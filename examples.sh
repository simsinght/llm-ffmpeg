#!/bin/bash

# llm-ffmpeg Examples - Demonstrating the new LLM-powered approach

echo "=== llm-ffmpeg Examples ==="
echo ""
echo "These examples show how to use the new simplified llm-ffmpeg"
echo "that works with any LLM via the 'llm' tool."
echo ""

# Check if llm-ffmpeg is executable
if [[ ! -x "./llm-ffmpeg" ]]; then
    echo "Making llm-ffmpeg executable..."
    chmod +x llm-ffmpeg
fi

echo "1. Check setup and dependencies:"
echo "   ./llm-ffmpeg --setup"
echo ""

echo "2. List available models:"
echo "   ./llm-ffmpeg --list-models"
echo ""

echo "3. File-aware examples (recommended):"
echo "   ./llm-ffmpeg video.mp4 \"convert to MP3\""
echo "   ./llm-ffmpeg movie.mkv \"clip from 1:30 to 2:45\""
echo "   ./llm-ffmpeg input.avi \"resize to 720p\""
echo ""

echo "4. Traditional examples:"
echo "   ./llm-ffmpeg \"convert video.mp4 to audio.mp3\""
echo "   ./llm-ffmpeg \"extract first 30 seconds from input.mp4\""
echo "   ./llm-ffmpeg \"combine audio.mp3 with video.mp4\""
echo ""

echo "5. Check command history:"
echo "   ./llm-ffmpeg --history"
echo ""

echo "6. Interactive workflow:"
echo "   - Run a command with [y]"
echo "   - Copy to clipboard with [n]"
echo "   - Refine with feedback using [r]"
echo "   - View history with [s]"
echo ""

echo "7. Error recovery:"
echo "   - If a command fails, llm-ffmpeg will:"
echo "     * Show the error"
echo "     * Suggest common fixes"
echo "     * Let you fix automatically [f] or manually [r]"
echo ""

echo "=== Configuration ==="
echo ""
echo "Set your default model: llm models default MODEL_NAME"
echo "List available models:  llm models"
echo "Test your setup:        llm logs -n 1"
echo ""

echo "=== Requirements ==="
echo ""
echo "1. Install llm:         brew install llm"
echo "2. Install ffmpeg:      brew install ffmpeg"
echo "3. Configure a model:"
echo "   - Ollama:            llm install llm-ollama"
echo "   - Anthropic:         llm install llm-anthropic && llm keys set claude"
echo ""

echo "Test your setup:        llm models"
echo "Test llm-ffmpeg:        ./llm-ffmpeg --setup"
echo ""

# If we have test files, show practical examples
if [[ -f "clip.mp4" ]]; then
    echo "=== Try these with your test files ==="
    echo ""
    echo "Using clip.mp4:"
    echo "   ./llm-ffmpeg clip.mp4 \"convert to audio\""
    echo "   ./llm-ffmpeg clip.mp4 \"create a 10-second preview\""
    echo ""
fi

if [[ -f "rick.and.morty.s08e02.1080p.web.h264-successfulcrab.mkv" ]]; then
    echo "Using Rick and Morty episode:"
    echo "   ./llm-ffmpeg rick.and.morty.s08e02.1080p.web.h264-successfulcrab.mkv \"extract a 30-second clip with subtitles\""
    echo "   ./llm-ffmpeg rick.and.morty.s08e02.1080p.web.h264-successfulcrab.mkv \"convert to MP4 for compatibility\""
    echo ""
fi

echo "Happy video processing! 🎬"
