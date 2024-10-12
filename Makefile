MAKEFLAGS += --no-print-directory


tasks_by_memory:
	@top -o %MEM -b -n 1

tasks_by_cpu:
	@top -o %CPU -b -n 1

status:
	@echo "CPU $$(make cpu_percent && echo ' / ' && make cpu_total)" | tr -d '\n'
	@echo ""
	@echo "MEM $$(make memory_percent && echo ' / ' && make memory_total)" | tr -d '\n'
	@echo ""
	@echo "DSK $$(make disk_percent && echo ' / ' && make disk_total)" | tr -d '\n'
	@echo ""
	@docker stats --no-stream

memory_percent:
	@free -t | awk 'NR == 4 {print $$3/$$2*100 "%"}'

memory_total:
	@free -t | awk 'NR == 4 {print $$2/1024 "M"}'

cpu_percent:
	@vmstat | awk 'NR == 3 {print 100-$$15 "%"}'

cpu_total:
	@lscpu | grep CPU\(s\): | awk 'NR == 1 {print $$2}'

disk_percent:
	@df -h | grep /dev/root | awk '{print $$5}'

disk_total:
	@df -h | grep /dev/root | awk '{print $$2}'

restart_docker:
	@sudo systemctl restart docker
	@sudo systemctl restart containerd
