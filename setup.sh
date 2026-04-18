#!/bin/bash
set -e

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🚀 Starting Hermes Agent + Ollama + Gemma 4 setup...${NC}"

# 1. Установка Ollama
echo -e "${GREEN}📦 Installing Ollama...${NC}"
curl -fsSL https://ollama.com/install.sh | sh

# 2. Запуск сервера Ollama в фоновом режиме
echo -e "${GREEN}🔄 Starting Ollama server...${NC}"
ollama serve &
sleep 5

# 3. Скачивание модели Gemma 4 (E4B, ~9.6GB)
echo -e "${YELLOW}⚠️  Downloading Gemma 4 model (~9.6GB). This will take a while...${NC}"
ollama pull gemma4:e4b

# 4. Установка Hermes Agent
echo -e "${GREEN}🤖 Installing Hermes Agent...${NC}"
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
source ~/.bashrc

# 5. Автоматическая настройка Hermes для работы с Ollama
echo -e "${GREEN}⚙️  Configuring Hermes Agent...${NC}"
mkdir -p ~/.hermes
cat > ~/.hermes/config.yaml << 'EOF'
provider: custom
model: gemma4:e4b
custom_endpoint: http://localhost:11434/v1
api_key: "ollama"
EOF

echo -e "${GREEN}✅ Setup complete!${NC}"
echo -e "${GREEN}💡 You can now use 'hermes' command in the terminal.${NC}"
