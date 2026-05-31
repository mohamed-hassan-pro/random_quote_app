# 💡 Inspirational Quotes - Random Quote Generator

A beautiful, minimalistic, and responsive Random Quote Generator built with Flutter. This project showcases advanced software engineering principles, serving as Task 2 for the **CodeAlpha Internship**.

## ✨ Features
- **Fail-Safe Random Quotes:** Dynamic quote fetching from remote APIs with multiple robust fallovers (ZenQuotes, Quote Garden) and local offline fallbacks.
- **Save Favorites:** Instantly bookmark your favorite quotes locally using an SQLite database.
- **Glassmorphism Design:** Sleek UI elements utilizing high-quality backdrop filters.
- **Animated Custom Themes:** Tap to cycle through stunning responsive gradient backgrounds smoothly.
- **Share Quotes:** Share your favorite inspirations directly to social media or messaging platforms.

## 🏗️ Architecture & Engineering Standards
This project is engineered using **Clean Architecture** and follows strict **SOLID Principles**:
- **Presentation Layer:** State management using `Bloc`/`Cubit`. Separated reusable widgets, with all files strictly under 100 lines of code.
- **Domain Layer:** Pure business logic including `Quote` entities and the `QuoteRepository` contract interface.
- **Data Layer:** Handles remote API communication, local database storing (`sqflite`), and repository implementations.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.44.0 or latest)
- Dart SDK

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/mohamed-hassan-pro/random_quote_app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd random_quote_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---
*Built with passion by [mohamed-hassan-pro] during the CodeAlpha Internship.*
