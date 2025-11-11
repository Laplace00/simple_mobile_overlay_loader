# Simple Mobile Overlay Loader for Flutter

[![Pub Version](https://img.shields.io/pub/v/simple_mobile_overlay_loader.svg)](https://pub.dev/packages/simple_mobile_overlay_loader)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A lightweight, customizable overlay loader for Flutter. Displays a modal progress indicator with optional message text while preventing user interaction.

---

## Features

- Simple one-line API: `showLoaderOverlay(context, message: '...')`
- Returns the inserted `OverlayEntry` for manual removal
- Animated fade + scale entrance
- Custom message string (defaults to `Loading…`)
- Blocks interaction using `ModalBarrier`
- No external dependencies

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  simple_mobile_overlay_loader: ^0.0.1
```

Then run:

```bash
flutter pub get
```

Import it where needed:

```dart
import 'package:simple_mobile_overlay_loader/simple_mobile_overlay_loader.dart';
```

---

## Quick Usage

```dart
final loader = showLoaderOverlay(
  context,
  message: 'Logging in…', // optional
);

// Do async work
await Future.delayed(const Duration(seconds: 3));

// Safely remove when finished
if (loader.mounted) loader.remove();
```

---

## Full Example

```dart
import 'package:flutter/material.dart';
import 'package:simple_mobile_overlay_loader/simple_mobile_overlay_loader.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final loader = showLoaderOverlay(
            context,
            message: 'Logging in…',
          );
          // Simulate work
          await Future.delayed(const Duration(seconds: 3));
          if (loader.mounted) loader.remove();
        },
        child: const Text('Start Loader'),
      ),
    );
  }
}
```

---

## API

### `OverlayEntry showLoaderOverlay(BuildContext context, { String message = 'Loading…' })`

Inserts an animated loader overlay into the root overlay.

Returns: The created `OverlayEntry`.

Remove: Call `overlayEntry.remove()` (check `mounted` first if asynchronous work may complete after removal elsewhere).

---

## Customization

Need different colors, layout, or animation?

1. Copy the implementation of `_AnimatedLoader` from the source file.
2. Adjust styling (e.g., replace `CircularProgressIndicator`, change `Card` shape, durations, barrier color).
3. Optionally create your own helper similar to `showLoaderOverlay`.

For simple message changes just pass the `message` argument.

---

## Troubleshooting

| Issue                                    | Cause                                                        | Fix                                                                                     |
|------------------------------------------|--------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| Overlay not visible                      | No `Overlay` above context                                  | Use a context from a widget below `MaterialApp` / `Navigator`                         |
| Cannot dismiss                           | Forgot to store the returned `OverlayEntry`                 | Assign to variable and call `remove()`                                                |
| Multiple loaders stack                   | Calling show repeatedly                                      | Track if a loader is already active before showing                                    |
| Exception: Overlay.of() returned null   | Using a context during initState                            | Call from event handlers / post-frame callback                                        |

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

---

## License

MIT © 2025. See [LICENSE](LICENSE).

---

## Contributing

Pull requests welcome. Open an issue for bugs or feature requests.

---

## Acknowledgements

Inspired by common overlay patterns in Flutter apps; packaged for quick reuse.
