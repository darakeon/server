#!/bin/bash
set -e

apt install make

echo "#!/bin/bash" > /usr/bin/please
echo "" >> /usr/bin/please
echo "cd ~/server" >> /usr/bin/please
echo "make \$1" >> /usr/bin/please

chmod +x /usr/bin/please
