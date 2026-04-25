#!/bin/bash

set -e

echo "🚀 SCRIPT STARTED"

mkdir -p output

# Read prompt safely (JSON-escaped)
echo "📖 Reading prompt..."
PROMPT=$(jq -Rs . < prompt.txt)

echo "🤖 Calling Groq API..."

RESPONSE=$(curl -s https://api.groq.com/openai/v1/chat/completions \
  -H "Authorization: Bearer $GROQ_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"llama-3.1-8b-instant\",
    \"messages\": [
      {
        \"role\": \"system\",
        \"content\": \"You are an expert frontend engineer. Output ONLY valid HTML code. No markdown, no explanation, no backticks.\"
      },
      {
        \"role\": \"user\",
        \"content\": $PROMPT
      }
    ],
    \"temperature\": 0.2
  }")

# Save raw response for debugging
echo "$RESPONSE" > output/result.json

echo "🧠 Extracting model output..."

CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // empty')

if [ -z "$CONTENT" ]; then
  echo "❌ Error: Empty response from model"
  exit 1
fi

# Write final HTML output
echo "$CONTENT" > output/index.html

echo "✅ Build complete: index.html generated"