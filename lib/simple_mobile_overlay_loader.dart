/// A lightweight utility for displaying a modal loader overlay with
/// customizable status text.
///
/// This library exposes a single convenience function: [showLoaderOverlay].
///
/// The overlay blocks user interaction until you remove the returned
/// [OverlayEntry]. Typical usage:
///
/// ```dart
/// final entry = showLoaderOverlay(context, message: 'Saving data');
/// try {
///   await performSave();
/// } finally {
///   if (entry.mounted) entry.remove();
/// }
/// ```
///
/// The overlay fades and scales in for a subtle appearance.
library;

import 'package:flutter/material.dart';

/// Inserts and returns an [OverlayEntry] that shows a blocking loader dialog
/// with a circular progress indicator and optional [message].
///
/// The overlay is inserted into the root [Overlay] so it will appear above
/// all other widgets. You are responsible for removing the overlay by calling
/// `remove()` on the returned [OverlayEntry] when loading completes.
///
/// Parameter [message] defaults to `Loading…` and is rendered beneath the
/// spinner. Keep it short (1–2 words) for best layout.
///
/// Returns the created, already inserted [OverlayEntry].
OverlayEntry showLoaderOverlay(
  BuildContext context, {
  String message = 'Loading…',
}) {
  final entry = OverlayEntry(
    builder: (overlayContext) {
      return _AnimatedLoader(message: message);
    },
  );
  Overlay.of(context, rootOverlay: true).insert(entry);
  return entry;
}

class _AnimatedLoader extends StatefulWidget {
  final String message;
  const _AnimatedLoader({required this.message});

  @override
  State<_AnimatedLoader> createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<_AnimatedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ModalBarrier(dismissible: false, color: Colors.black38),
        Center(
          child: FadeTransition(
            opacity: _opacity,
            child: ScaleTransition(
              scale: _scale,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 42,
                        width: 42,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
