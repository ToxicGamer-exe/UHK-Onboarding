import 'package:flutter/cupertino.dart';

void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  int durationMillis = 3000,
}) {
  final overlayEntry = OverlayEntry(
    builder: (context) =>
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: CupertinoPopupSurface(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: CupertinoColors.secondaryLabel,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
  );
  Future.delayed(
    Duration(milliseconds: durationMillis),
    overlayEntry.remove,
  );
  Overlay.of(context).insert(overlayEntry);
}

extension IterableX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}