# ollmpeg - Local FFmpeg Command Generator 

Natural language processing for generating FFmpeg commands. Uses Ollama for local LLM inference and Simon Willison's `llm` tool for orchestration and command extraction.

## ✨ Features

- 🔒 **Completely Local** - No API calls, all processing happens on your machine
- 🚀 **Easy to Use** - Simple command-line interface 
- 🎨 **Interactive** - Ask before running commands, with refinement option
- 🔧 **Configurable** - Support for different Ollama models
- 📋 **Auto-setup** - Handles dependency checking and model installation
- 🔄 **Refinement Loop** - Iteratively improve commands with context preservation
- 🔍 **File Analysis** - Automatically analyzes input files with FFmpeg to provide context to the model

## Prerequisites

You'll need these tools installed:

1. **Ollama** - For running local models
   ```bash
   # Install from https://ollama.ai/
   # Or on macOS: brew install ollama
   ```

2. **llm** - Simon Willison's LLM command-line tool
   ```bash
   # Install instructions: https://llm.datasette.io/en/stable/setup.html
   pip install llm
   llm install llm-ollama
   ```

3. **FFmpeg** - For actually running the generated commands
   ```bash
   # macOS
   brew install ffmpeg
   
   # Ubuntu/Debian
   sudo apt install ffmpeg
   ```

## Quick Start

1. Clone or download this repository
2. Run the setup command:
   ```bash
   ./ollmpeg --setup
   ```
3. Start generating FFmpeg commands:
   ```bash
   # File-aware mode (recommended)
   ./ollmpeg video.mp4 "convert to audio"
   
   # Traditional mode
   ./ollmpeg "convert video.mp4 to audio.mp3"
   ```

## Usage

### File-Aware Mode (New!)
```bash
./ollmpeg FILENAME "description of what you want to do"
```

The AI will automatically analyze your file and provide commands tailored to your specific video/audio properties.

### Traditional Mode
```bash
./ollmpeg "description of what you want to do"
```

### Interactive Refinement
After generating a command, you can:
- **[y]** - Run the command immediately
- **[n]** - Copy to clipboard and exit
- **[r]** - Refine the command with feedback

## Examples

### File-Aware Examples (Recommended)
```bash
# Analyze file and convert to audio
./ollmpeg movie.mkv "convert to MP3"

# Smart subtitle handling
./ollmpeg video.mkv "clip from 1:30 to 2:45 with english subtitles"

# Format-aware conversion
./ollmpeg input.avi "convert to MP4 maintaining quality"

# Stream-specific operations
./ollmpeg multilang.mkv "extract japanese audio track"

# Codec-aware processing
./ollmpeg hdr_video.mp4 "resize to 720p preserving HDR"
```

### Traditional Examples
```bash
# Convert video to audio
./ollmpeg "convert video.mp4 to audio.mp3"

# Resize video
./ollmpeg "resize input.mp4 to 720p and save as output.mp4"

# Extract clip
./ollmpeg "extract first 30 seconds from input.mp4"

# Combine audio and video
./ollmpeg "combine audio.mp3 with video.mp4"

# Convert format with quality settings
./ollmpeg "convert input.avi to mp4 with high quality"

# Add watermark
./ollmpeg "add watermark.png to bottom right of video.mp4"

# Speed up video
./ollmpeg "speed up video.mp4 by 2x"

# Extract audio from specific time range
./ollmpeg "extract audio from minute 2 to minute 5 of video.mp4"
```

### Refinement Examples
```bash
# Initial command
./ollmpeg video.mkv "clip from 1:00 to 2:00"
# Generated: ffmpeg -i video.mkv -ss 01:00 -to 02:00 -c copy output.mkv

# [r] Refine with: "save as MP4 instead"
# Refined: ffmpeg -i video.mkv -ss 01:00 -to 02:00 -c:v libx264 -c:a copy output.mp4

# [r] Refine with: "include subtitles"
# Refined: ffmpeg -i video.mkv -ss 01:00 -to 02:00 -c:v libx264 -c:a copy -c:s copy output.mp4
```

## File Analysis Benefits

When you provide a filename, ollmpeg will:

1. **Analyze File Properties**:
   - Video codec, resolution, framerate
   - Audio codec, channels, bitrate
   - All subtitle tracks with languages
   - Container format and duration

2. **Generate Smarter Commands**:
   - Use actual stream indices
   - Respect codec compatibility
   - Handle subtitle formats correctly
   - Optimize for your specific file

3. **Preserve Context in Refinement**:
   - Filename stays consistent
   - File analysis included in refinement
   - No reverting to generic placeholders

## Options
```bash
./ollmpeg --help           # Show usage information
./ollmpeg --setup          # Run setup (install models, configure llm)
./ollmpeg --model MODEL    # Use specific Ollama model
```

### Using Different Models
```bash
# Use gemma3 model
./ollmpeg --model gemma3:4b video.mp4 "convert to gif"

# Use deepseek model (default)
./ollmpeg --model deepseek-r1:1.5b video.mkv "extract frames"
```

## How It Works

1. **File Analysis** (if filename provided) - FFmpeg analyzes your file properties
2. **User Input** - You describe what you want to do
3. **AI Generation** - Ollama processes your request with file context using a local model
4. **Command Extraction** - Clean FFmpeg command extracted using `llm -x`
5. **User Interaction** - Choose to run, copy, or refine the command
6. **Context Preservation** - Refinements maintain file information and filename
7. **Execution** - If confirmed, the FFmpeg command runs directly

## Configuration

The script uses these defaults:
- **Model**: `deepseek-r1:1.5b` (fast and capable)
- **Temp Directory**: `/tmp/ollmpeg`
- **Logging**: All LLM commands logged to `/tmp/ollmpeg/llm_commands.log`

You can modify these at the top of the `ollmpeg` script if needed.

## Debugging and Logging

All interactions are logged for debugging:

```bash
# View LLM commands
cat /tmp/ollmpeg/llm_commands.log

# View file analysis
cat /tmp/ollmpeg/file_info.txt

# View raw responses
cat /tmp/ollmpeg/response.txt

# View errors
cat /tmp/ollmpeg/error.log
```

## Supported Models

The script works with any Ollama model, but these are recommended for FFmpeg tasks:

- `deepseek-r1:1.5b` (default) - Fast, good at code generation
- `gemma3:4b` - Excellent balance of speed and accuracy
- `llama3.2:3b` - More capable for complex requests
- `codellama:7b` - Specialized for code generation

## Troubleshooting

### Model Not Available
If you get a "model not available" error:
```bash
ollama list  # Check available models
ollama pull deepseek-r1:1.5b  # Pull the default model
```

### llm-ollama Plugin Issues
If the llm integration isn't working:
```bash
llm install llm-ollama  # Reinstall the plugin
llm models  # Check available models
```

### File Analysis Issues
If file analysis fails:
```bash
# Check if file exists
ls -la yourfile.mp4

# Test FFmpeg directly
ffmpeg -i yourfile.mp4

# Check logs
cat /tmp/ollmpeg/file_info.txt
```

### FFmpeg Command Fails
1. Check the generated command in the logs
2. Verify input files exist
3. Ensure you have write permissions for output files
4. Use refinement to fix issues: `[r] "fix the output filename"`

### Setup Issues
Run the setup command to check dependencies:
```bash
./ollmpeg --setup
```

## Advanced Usage

### Batch Processing with File Analysis
```bash
for file in *.mp4; do
    ./ollmpeg "$file" "convert to ${file%.mp4}.mp3"
done
```

### Complex File Operations
```bash
# Multi-stream operations
./ollmpeg movie.mkv "extract english audio and chinese subtitles to separate files"

# Format conversion with analysis
./ollmpeg hdr_content.mkv "convert to MP4 compatible with older devices"

# Stream mapping
./ollmpeg multi_audio.mkv "create version with only first audio track"
```

### Debugging Workflows
```bash
# Generate command without running
./ollmpeg video.mp4 "convert to audio" 
# Choose [n] to copy to clipboard

# Check what the AI sees
cat /tmp/ollmpeg/file_info.txt
cat /tmp/ollmpeg/llm_commands.log
```

## Contributing

Feel free to submit issues or pull requests! Some ideas for improvements:

- [ ] Support for batch operations UI
- [ ] History of generated commands
- [ ] Custom prompt templates
- [ ] Video preview integration
- [ ] Output format validation
- [ ] Stream mapping visualization

## License

MIT License - feel free to use and modify as needed.

## Credits

- [Ollama](https://ollama.ai/) - For local LLM inference
- [llm](https://github.com/simonw/llm) by Simon Willison - For command-line LLM interaction
- [FFmpeg](https://ffmpeg.org/) - For multimedia processing
