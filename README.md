# godot-roaring

Roaring Bitmaps implementation for GDExtensions (Godot 4).

# How to Build

Requires CMake and git.

```
git clone https://github.com/fissure-games/godot-roaring
cd godot-roaring
git submodule update --init --recursive
mkdir build
cmake -DCMAKE_BUILD_TYPE=Debug .. # or Release
# Make with either `make` or `MSBuild` depending on platform.
# Binaries will be in build/GodotRoaring
```
