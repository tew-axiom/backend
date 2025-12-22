#!/bin/bash
# 测试应用启动脚本

set -e

echo "🧪 测试应用启动..."
echo ""

# 设置环境
export PYTHONPATH=/app:$PYTHONPATH

echo "1️⃣ 测试导入应用..."
python -c "
import sys
sys.path.insert(0, '/app')
try:
    from app.main import app
    print('✅ 应用导入成功')
except Exception as e:
    print(f'❌ 应用导入失败: {e}')
    import traceback
    traceback.print_exc()
    exit(1)
"

echo ""
echo "2️⃣ 测试 Uvicorn 命令..."
echo "命令: uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000} --log-level info"
echo ""

# 尝试启动 uvicorn（前台运行，显示所有输出）
exec uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000} --log-level info
