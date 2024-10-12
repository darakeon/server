tasks_by_memory:
	@top -o %MEM -b -n 1

tasks_by_cpu:
	@top -o %CPU -b -n 1

memory:
	@free -t | awk 'NR == 4 {print $3/$2*100 "%"}'

all_memory:
	@free -t

cpu:
	@vmstat | awk 'NR == 3 {print 100-$15 "%"}'

all_cpu:
	@vmstat

disk:
	@df -h | grep /dev/root | awk '{print $5}'

all_disk:
	@df -h

restart_docker:
	@sudo systemctl restart docker
	@sudo systemctl restart containerd
