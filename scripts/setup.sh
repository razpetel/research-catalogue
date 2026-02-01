#!/bin/bash
set -e

echo "🔧 Setting up Research Agent..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18+."
    exit 1
fi

echo "✓ Node.js $(node -v)"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker for GitHub MCP."
    exit 1
fi

echo "✓ Docker found"

# Install agent-browser
echo "📦 Installing agent-browser..."
npm install -g agent-browser
agent-browser install

echo "✓ agent-browser installed"

# Check for .env
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Copying from .env.example..."
    cp .env.example .env
    echo "   Please edit .env and add your GITHUB_TOKEN"
fi

# Create directories
mkdir -p .claude/research-cache
mkdir -p .claude/skills
mkdir -p .claude/prompts
mkdir -p research/catalogue

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env and add your GITHUB_TOKEN"
echo "2. Run: source .env"
echo "3. Use: /research <topic>"
