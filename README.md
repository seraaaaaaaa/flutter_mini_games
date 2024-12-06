# Flutter Mini Games 🎲

This app features a collection of lucky draw mini-games, each designed to provide a delightful and fun experience. Each game includes engaging animations, smooth gameplay, and a unique set of rules.

## 🎯 Features

- Spin & Win
- Flip, Scratch & Win
- Roll & Win
- Tap & Win
- Stop & Win

## 🔗 Live Preview

https://flutter-mini-games.web.app

## 📸 Preview

![](/preview/preview.png)

The preview screenshot was generated using [AppMockUp Studio](https://studio.app-mockup.com/).

## 📁 File Structure

The project is modularized to maintain clarity and reusability. This structure allows for easy updates and adding new games in the future.

```
📂lib
│───main.dart                # Main entry point of the application
│
│───📂enum
│   │───games.dart           # Enum for different games
│   └───prizes.dart          # Enum for different prizes
│
│───📂services
│   └──coin_services.dart    # Service for handling coin-related operations
│
└───📂screens
    │───📂games              # Game-specific screens and components
    │   │───📂game_name      # Folder for each game
    │   │   │──📂game_widget
    │   │   │   │──game_item.dart        # Defines game items (e.g., cards, buttons)
    │   │   │   └──game_indicator.dart   # Defines game-related indicators
    │   │   └──game_screen   # Main screen for the game
    │   └───📂components
    │       └──reusable_widget.dart      # Common reusable widgets
    └───📂home
        │───📂widgets
        │   └──game_card.dart           # Widget for displaying game cards on the home screen
        └───home.dart                   # Home screen to navigate to different games
```

## 🌟 Attribution

- Icons: Icons used in this project are sourced from [Freepik](https://www.freepik.com/).
- Background Image: Background images are sourced from [Haikei](https://app.haikei.app/).
