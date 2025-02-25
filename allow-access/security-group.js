import { publicIpv4 } from 'public-ip'
import { fromIni } from '@aws-sdk/credential-providers';
import { EC2 } from '@aws-sdk/client-ec2';
import fs from 'fs'

// config file is ignored by git
// region: AWS region
// securityGroup: name of the security group to be changed
// apiVersion: AWS api version
// ports: list of ports which you want point to your IP
// profile: profile to be used from ~/.aws/credentials
const { region, securityGroup, apiVersion, ports, profile } = JSON.parse(
	fs.readFileSync('./config.json')
)

// ~/.aws/credentials:
// [default]
// aws_access_key_id = {}
// aws_secret_access_key = {}

async function updateSecurityGroup() {
	const credentials = fromIni({profile})

	const ec2 = new EC2({
		region,
		credentials
	})
	const params = { GroupNames: [securityGroup] }

	const ip = await publicIpv4() + '/32'

	ec2.describeSecurityGroups(params, async function(err, data) {
		if (err) {
			console.error(err)
		} else {
			const newSecurityGroup = data.SecurityGroups[0]
			const permissions = newSecurityGroup.IpPermissions
			const secretIps = await buildSecurityGroup(permissions, ports, ip)

			if (ports.length > 0) {
				console.error("Some ports was not found: " + ports)
				return
			}

			if (newSecurityGroup.IpPermissions.length == 0) {
				console.log("The " + secretIps + " rules are already right")
				return
			}

			await clearNotUsedFields(newSecurityGroup)
			await revokeOld(ec2, newSecurityGroup, permissions, ip)
		}
	})
}

async function buildSecurityGroup(permissions, ports, ip) {
	let secretIps = 0

	for (let p = 0; p < permissions.length; p++) {
		const permission = permissions[p]
		const port = permission.FromPort

		const currentIp = permission.IpRanges.length
			? permission.IpRanges[0].CidrIp
			: null

		const portIndex = ports.indexOf(port)
		const isSecret = portIndex >= 0 && currentIp.endsWith('/32')
		const isWrong = currentIp != ip

		if (isSecret) {
			ports.splice(portIndex, 1)
			secretIps++
		}

		if (isSecret && isWrong) {
			delete permission.Ipv6Ranges
			delete permission.PrefixListIds
			delete permission.UserIdGroupPairs
		} else {
			permissions.splice(p, 1)
			p--
		}
	}

	return secretIps
}

async function clearNotUsedFields(securityGroup) {
	delete securityGroup.GroupName
	delete securityGroup.Description
	delete securityGroup.OwnerId
	delete securityGroup.IpPermissionsEgress
	delete securityGroup.Tags
	delete securityGroup.VpcId
}

async function revokeOld(ec2, securityGroup, permissions, ip) {
	await ec2.revokeSecurityGroupIngress(securityGroup, async function(err, data) {
		if (err) {
			console.error(err)
		} else {
			console.log("Revoked old ip")

			for (let p = 0; p < permissions.length; p++) {
				permissions[p].IpRanges[0].CidrIp = ip
			}

			await authorizeNew(ec2, securityGroup)
		}
	})
}

async function authorizeNew(ec2, securityGroup) {
	await ec2.authorizeSecurityGroupIngress(securityGroup, function(err, data) {
		if (err) {
			console.error(err)
		} else {
			console.log("Authorized new ip")
		}
	})
}

updateSecurityGroup()
