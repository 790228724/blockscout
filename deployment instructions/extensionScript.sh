#!/bin/bash
  
# 指定要查询的进程名列表
PROCESS_NAMES=("sig-provider-server" "smart-contract-verifier-server*" "visualizer-server")

# 指定日志文件名列表，与进程名对应
LOG_FILES=("sig-provider.log" "smart-contract-verifier.log" "visualizer.log")

# 查询并终止进程
for i in "${!PROCESS_NAMES[@]}"; do
  PROCESS_NAME="${PROCESS_NAMES[i]}"
  LOG_FILE="${LOG_FILES[i]}"

  PID=$(pgrep -f "$PROCESS_NAME")
  if [ -n "$PID" ]; then
    echo "找到进程 $PROCESS_NAME (PID: $PID)，正在终止..."
    kill "$PID"
    sleep 1
    echo "进程已终止."
  fi

  # 清空日志文件
  > "$LOG_FILE"
done

# 启动程序并将输出重定向到日志文件
nohup ./sig-provider/target/release/sig-provider-server >> "sig-provider.log" 2>&1 &
nohup ./smart-contract-verifier/target/release/smart-contract-verifier-server >> "smart-contract-verifier.log" 2>&1 &
nohup ./visualizer/target/release/visualizer-server >> "visualizer.log" 2>&1 &
