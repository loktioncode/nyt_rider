# NYT Rider

A 2D platformer game built with Godot Engine 4.4.

## Overview

NYT Rider is a pixel-art style platformer featuring a knight character navigating through tile-based levels. The game includes physics-based movement, jumping mechanics, and retro-style graphics and audio.

## Features

- **Character Movement**: Smooth left/right movement with physics-based controls
- **Jumping Mechanics**: Responsive jump controls with gravity
- **Pixel Art Graphics**: Retro-style sprites and tilesets
- **Sound Effects**: Immersive audio including coins, explosions, jumps, and power-ups
- **Background Music**: Adventure-themed soundtrack
- **Camera System**: Smooth following camera with zoom

## Game Assets

### Sprites
- Knight player character
- Various slime enemies (green and purple)
- Collectible coins and fruits
- Platform tilesets for level construction

### Audio
- **Music**: `time_for_adventure.mp3` - Main background track
- **Sound Effects**:
  - Coin collection sounds
  - Jump and movement audio
  - Explosion and hurt effects
  - Power-up notifications
  - UI interaction sounds

### Fonts
- PixelOperator8 font family for retro text styling

## Controls

- **Arrow Keys / WASD**: Move left and right
- **Space / Enter**: Jump (only when on ground)

## Technical Details

- **Engine**: Godot 4.4
- **Rendering**: Forward Plus with pixel-perfect textures
- **Physics**: Built-in CharacterBody2D with gravity and collision detection
- **Resolution**: Optimized for pixel art with 4x camera zoom

## Project Structure

```
nyt_rider/
├── assets/
│   ├── fonts/          # PixelOperator font files
│   ├── music/          # Background music
│   ├── sounds/         # Sound effects
│   └── sprites/        # Character and environment sprites
├── scenes/             # Game scenes (empty - scenes defined in .tscn files)
├── scripts/            # GDScript files
│   └── player.gd       # Player character controller
├── game.tscn          # Main game scene
├── player.tscn        # Player character scene
└── project.godot      # Godot project configuration
```

## Getting Started

1. **Prerequisites**: Install [Godot Engine 4.4](https://godotengine.org/download) or later
2. **Open Project**: Launch Godot and import the project using `project.godot`
3. **Run Game**: Press F5 or click the play button to start the game
4. **Edit Scenes**: Open `game.tscn` to modify levels or `player.tscn` to adjust player properties

## Player Configuration

The player character has the following properties:
- **Speed**: 130 units/second
- **Jump Velocity**: -250 units (upward)
- **Physics**: Uses Godot's built-in gravity and collision system

## Development

To modify or extend the game:

1. **Level Design**: Edit the TileMapLayer in `game.tscn` to create new platforms and obstacles
2. **Player Mechanics**: Modify `scripts/player.gd` to add new abilities or adjust movement
3. **Assets**: Replace files in the `assets/` directory to customize graphics and audio
4. **Scenes**: Create new scene files for additional levels or game states

## License

This project contains game assets and code. Please ensure you have appropriate licenses for any assets before distribution.

---

*Built with ❤️ using Godot Engine*
