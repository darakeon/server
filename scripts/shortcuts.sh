#!/bin/bash
set -e

apt install make

echo "#!/bin/bash" > /usr/bin/status
echo "" >> /usr/bin/status
echo "cd ~/server" >> /usr/bin/status
echo "make status" >> /usr/bin/status

chmod +x /usr/bin/status
