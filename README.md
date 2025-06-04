# llm-ffmpeg - Natural Language FFmpeg Command Tool

Transform your natural language requests into ffmpeg commands using any LLM. Built on [Simon Willison's `llm` tool](https://llm.datasette.io/en/stable/) for maximum flexibility - use local models, OpenAI, Anthropic, or any other provider.

## ✨ Features

- 🌐 **Any LLM** - Works with local models (Ollama), OpenAI, Anthropic, and more
- 🔄 **Error Recovery** - Built in error detection and fixing
- 📋 **Command History** - Saves successful commands for reuse
- 🛠️ **Interactive Refinement** - Iteratively improve commands with feedback
- 📚 **Command Explanation** - Get clear explanations of what commands do
- 🚀 **Simple Setup** - Leverages your existing `llm` configuration

## Quick Start

1. **Install dependencies:**
   ```bash
   brew install llm
   brew install ffmpeg  # or your system's package manager
   ```

2. **Configure llm with a model** (choose one):
Your default model for llm will be used. So ensure you've selected the one you would like to use. I've personally been using gemma-3n
   ```bash
   llm models list
   llm models default set MODEL_NAME
   ```

3. **Test your setup:**
   ```bash
   llm models  # should show your available models
   ./llm-ffmpeg --setup  # verify llm-ffmpeg configuration
   ```

4. **Start generating commands:**
   ```bash
   # File-aware mode (recommended)
   ./llm-ffmpeg video.mp4 "convert to MP3"
   
   # Pure prompt mode
   ./llm-ffmpeg "convert video.mp4 to audio.mp3"
   ```

## Usage Examples

### File-Aware Mode (Recommended)
```bash
# Convert with file analysis
./llm-ffmpeg movie.mkv "convert to MP4"

# Smart clipping with subtitles
./llm-ffmpeg video.mkv "clip from 1:30 to 2:45 with subtitles"

# Format-aware operations
./llm-ffmpeg input.avi "resize to 720p maintaining quality"

# Stream-specific tasks
./llm-ffmpeg multilang.mkv "extract english audio track"
```

### Prompt Mode
```bash
# Basic conversions
./llm-ffmpeg "convert input.mp4 to output.mp3"
./llm-ffmpeg "resize video.mp4 to 720p"
./llm-ffmpeg "extract first 30 seconds from video.mp4"
./llm-ffmpeg "combine audio.mp3 with video.mp4"
```

### Interactive Refinement
After generating a command, you can:
- **[y]** - Run the command immediately
- **[n]** - Copy to clipboard and exit
- **[e]** - Explain what this command does
- **[r]** - Refine with feedback
- **[s]** - Show command history

If a command fails, llm-ffmpeg will:
- Analyze the error automatically
- Suggest common fixes
- Let you fix it automatically or manually refine

### Command Line Options
```bash
./llm-ffmpeg --help              # Show usage
./llm-ffmpeg --setup             # Check dependencies
./llm-ffmpeg --list-models       # Show available models
./llm-ffmpeg --history           # Show command history
./llm-ffmpeg -m MODEL "request"  # Use specific model
```

## How It Works

1. **File Analysis** (if filename provided) - FFmpeg analyzes your file properties
2. **Smart Prompting** - Context-aware prompts sent to your configured LLM
3. **Command Extraction** - Clean ffmpeg commands extracted from LLM response
4. **Interactive Options** - Choose to run, copy, or refine
5. **Error Recovery** - If command fails, automatic error analysis and fixing
6. **History Tracking** - Successful commands saved for future reference

## Supported Models

llm-ffmpeg works with any model supported by the `llm` tool:

### Local Models (via Ollama)
```bash
llm install llm-ollama
ollama pull llama3.2:3b      # Good balance of speed/quality
ollama pull deepseek-r1:1.5b # Fast and capable
ollama pull codellama:7b     # Specialized for code
```

### Cloud Models
```bash
# OpenAI (GPT-3.5, GPT-4, etc.)
llm keys set openai

# Anthropic (Claude)
llm install llm-anthropic
llm keys set anthropic

# Google (Gemini)
llm install llm-gemini
llm keys set gemini
```

## Error Recovery

llm-ffmpeg automatically detects and suggests fixes for common errors:

- **File not found** → Check paths and spelling
- **Codec not found** → Suggest alternative codecs  
- **Permission denied** → Check output directory permissions
- **Invalid stream** → Analyze available streams
- **File exists** → Suggest overwrite flag

Example error recovery flow:
```bash
./llm-ffmpeg video.mp4 "convert to audio"
# Generated: ffmpeg -i video.mp4 output.wav
# [y] Run command
# Error: Permission denied writing to output.wav
# [f] Try to fix automatically
# Fixed: ffmpeg -i video.mp4 ~/Downloads/output.wav
```

## Command History

View and reuse successful commands:
```bash
./llm-ffmpeg --history
# [2024-01-15 10:30:45] video.mp4: "convert to audio" -> ffmpeg -i video.mp4 -vn output.mp3
# [2024-01-15 10:32:12] movie.mkv: "clip with subtitles" -> ffmpeg -i movie.mkv -ss 00:01:30 ...
```

## Troubleshooting
For logs check the `/tmp/llm-ffmpeg/` directory.

### Setup Issues
```bash
./llm-ffmpeg --setup  # Comprehensive setup check
```

### Model Not Working
```bash
llm models  # Check available models
llm "test"  # Test your default model
```

### Command Extraction Issues
If the LLM returns invalid commands:
- Try a different model with `./llm-ffmpeg -m MODEL`
- Use refinement to provide more specific instructions
- Check the raw LLM output in `/tmp/llm-ffmpeg/response.txt`

### File Analysis Problems
```bash
# Test file analysis manually
ffmpeg -i yourfile.mp4  # Should work
ls -la yourfile.mp4     # Check file exists and permissions
```

## Configuration Files

- `~/.llm-ffmpeg_history` - Command history
- `/tmp/llm-ffmpeg/` - Temporary files and logs

## Contributing

Ideas for improvements:
- [ ] Template system for common operations

## Credits

- [llm](https://github.com/simonw/llm) by Simon Willison - LLM command-line interface
- [FFmpeg](https://ffmpeg.org/) - Multimedia processing
- [Ollama](https://ollama.ai/) - Local model support
- Vibe Coded using Cline with Sonnet 4

## License

MIT License - feel free to use and modify as needed.
