# AI Quote Application (iOS, SwiftUI)

## Overview

AI Quote Application is a mobile iOS app developed using SwiftUI. The project demonstrates the design and implementation of a modular application that combines structured data management with a lightweight AI-inspired text generation system.

The application allows users to explore, search, and manage quotes, as well as generate new ones based on selected themes and user input.

---

## Objectives

The main goals of this project are:

- To design a clean and scalable iOS application architecture
- To implement a responsive and user-friendly interface using SwiftUI
- To demonstrate the use of the MVVM (Model–View–ViewModel) pattern
- To simulate AI-based content generation within a mobile application
- To manage application state and persistence effectively

---

## Key Features

- Category-based quote browsing (e.g., Love, Motivation, Life)
- Favorites system with local persistence
- Full-text search by quote content or author
- AI-inspired quote generator with user-defined prompts
- Copy and share functionality using native iOS features
- Adaptive UI supporting Light and Dark modes
- Animated text rendering (typewriter effect)

---

## System Architecture

The application follows the **MVVM architecture**, ensuring separation of concerns and maintainability.

### Structure:

- **Model**
  - Represents the data layer (e.g., `Quote`)
- **View**
  - SwiftUI-based user interface
- **ViewModel**
  - Handles application logic and state management
- **Service Layer**
  - Responsible for AI-like quote generation logic

### Data Flow:
---

## AI Component

The application includes a modular AI-inspired component that generates quotes dynamically based on:

- Selected category
- Optional user input (prompt)

This component is intentionally designed as a **replaceable service layer**, allowing integration with external AI APIs (e.g., OpenAI) in future iterations.

---

## Technologies Used

- Swift
- SwiftUI
- MVVM Architecture
- UserDefaults (local persistence)
- UIKit (for system sharing features)

---

## Installation

1. Clone the repository: https://github.com/vergoo9/QuoteApp.git
2. Open the project in Xcode:QuoteApp.xcodeproj
3. Build and run on iOS Simulator (iOS 15 or later)

---

## Project Scope and Limitations

- The AI module uses a rule-based approach rather than a real machine learning model
- Data is stored locally and not synchronized across devices
- The application is designed as a standalone demo project

---

## Future Work

- Integration with real AI APIs (e.g., OpenAI GPT models)
- Cloud-based data storage (Firebase / iCloud)
- Multi-language support
- User accounts and synchronization
- Advanced personalization of generated content

---

## 📸 Screenshots

<img src="Screenshots Quote/Simulator Screenshot - iPhone 17 Pro Max - 2026-04-22 at 17.11.31.png" width="250"/>
<img src="Screenshots Quote/Simulator Screenshot - iPhone 17 Pro Max - 2026-04-22 at 17.12.14.png" width="250"/>
<img src="Screenshots Quote/Simulator Screenshot - iPhone 17 Pro Max - 2026-04-22 at 17.12.18.png" width="250"/>
<img src="Screenshots Quote/Simulator Screenshot - iPhone 17 Pro Max - 2026-04-22 at 17.12.26.png" width="250"/>

## Author

Roman Zhuravlev  

---

## Notes

This project was developed as part of a personal portfolio
