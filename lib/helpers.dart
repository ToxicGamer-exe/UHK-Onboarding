import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uhk_onboarding/sign_in.dart';

void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  int durationMillis = 3000,
}) {
  final overlay = Overlay.of(context);

  if (!overlay.mounted) {
    print("No overlay found");
    return;
  }

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 8.0,
      left: 8.0,
      right: 8.0,
      child: CupertinoPopupSurface(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 14.0,
              color: CupertinoColors.secondaryLabel,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(
    Duration(milliseconds: durationMillis),
    () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    },
  );
}

extension IterableX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

void signOut(BuildContext context, [String? message]) {
  Hive.box('user').delete('accessToken');
  Hive.box('user').delete('rememberMe');
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => SignInPage(
                customMessage: message,
              )),
      (Route<dynamic> route) => false);
}
