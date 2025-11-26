# Rupio

A clean architecture Flutter application with feature-based organization.

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run on specific platform
flutter run -d chrome    # Web
flutter run -d ios       # iOS Simulator
flutter run -d android   # Android Emulator
```

## Project Structure

```
lib/
├── main.dart                    # Entry point, initializes DI
└── src/
    ├── core/                    # App-wide utilities and config
    │   ├── ui/                  # App, routes, theme
    │   ├── di/                  # Dependency injection setup
    │   ├── utils/               # Helper functions
    │   ├── errors/              # Custom exceptions
    │   └── constants/           # App constants
    ├── features/                # Feature modules
    │   └── home/
    │       ├── presentation/    # UI layer (pages, widgets, cubit)
    │       ├── domain/          # Business logic (entities, usecases, repos)
    │       └── data/            # Data layer (models, repos impl, datasources)
    ├── shared/                  # Shared widgets across features
    ├── models/                  # Global models
    └── generated/               # Auto-generated code
```

## Adding a New Feature

1. Create folder: `lib/src/features/your_feature/`
2. Add subfolders: `presentation/`, `domain/`, `data/`
3. Create:
   - Entity in `domain/entities/`
   - Repository interface in `domain/repositories/`
   - UseCase in `domain/usecases/`
   - Model in `data/models/`
   - Repository impl in `data/repositories/`
   - DataSource in `data/datasources/`
   - Cubit + States in `presentation/cubit/`
   - Page in `presentation/pages/`
4. Register dependencies in `di_container.dart`
5. Add route in `routes.dart`

## Architecture Overview

### Data Flow
```
UI (Page) → Cubit → UseCase → Repository → DataSource → API
```

### Dependency Injection
Uses `get_it` for service locator pattern. All dependencies registered in `di_container.dart`.

### Routing
Centralized in `routes.dart` using `onGenerateRoute`. Add named routes as constants.
