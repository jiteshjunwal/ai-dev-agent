#!/bin/bash

echo "SCRIPT STARTED"

mkdir -p output

echo "Reading prompt..."
PROMPT=$(cat prompt.txt)

echo "Calling Groq..."

curl https://api.groq.com/openai/v1/chat/completions \
  -H "Authorization: Bearer $GROQ_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"llama-3.1-8b-instant\",
    \"messages\": [
      {\"role\": \"user\", \"content\": \"$PROMPT\"}
    ]
  }" > output/result.json

echo "Saving output..."

jq -r '.choices[0].message.content' output/result.json > index.html

echo "Done!"
