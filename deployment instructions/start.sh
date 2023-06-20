#!/bin/bash

# 指定要查询的进程名列表
PROCESS_NAMES=("beam.smp")

# 指定日志文件名列表，与进程名对应
LOG_FILES=("beam.log")
#!/bin/bash

# 指定要查询的进程名列表
PROCESS_NAMES=("beam.smp")

# 指定日志文件名列表，与进程名对应
LOG_FILES=("beam.log")

# 查询并终止进程
for i in "${!PROCESS_NAMES[@]}"; do
  PROCESS_NAME="${PROCESS_NAMES[i]}"
  LOG_FILE="${LOG_FILES[i]}"

  PIDS=$(pgrep -f "$PROCESS_NAME")
  if [ -n "$PIDS" ]; then
    echo "找到进程 $PROCESS_NAME (PIDs: $PIDS)，正在终止..."
    kill $PIDS
    sleep 1
    echo "进程已终止."
  fi

  # 清空日志文件
  > "$LOG_FILE"
done

# 启动程序并将输出重定向到日志文件
nohup mix phx.server  >> "beam.log" 2>&1 &
