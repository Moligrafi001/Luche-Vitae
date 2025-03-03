# LucheVitae Library Tutorial

Welcome! This tutorial explains how to use the **Luche Vitae Library**. This powerful library is designed for authentication and implementing functionalities within your script, adding more server side to your client. Each section below breaks down how to load, configure, and utilize the library's key features.

---

## 1. Loading the Library

First, load the library directly from GitHub using `loadstring` combined with `game:HttpGet`, which retrieves and executes the remote code.

```lua
local LucheVitae = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luche-Vitae/refs/heads/main/Auth.lua"))() -- Load the Library
