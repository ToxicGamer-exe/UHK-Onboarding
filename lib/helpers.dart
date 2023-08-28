import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      final snackBarTopMargin =
          mediaQuery.viewInsets.bottom + mediaQuery.padding.top + 8.0;

      return Positioned(
        top: snackBarTopMargin,
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
      );
    },
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

Future<dynamic> showCupertinoPasswordConfirm(
    BuildContext context, TextEditingController passwordController) {
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: const Text('Confirm password'),
            content: const Text('Please re-enter password to continue.'),
            actions: [
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //     child:
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: CupertinoTextField(
                      placeholder: 'Password',
                      controller: passwordController,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoButton(
                        child: const Text('Create'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ],
                  )
                ],
                // )
              ),
            ],
          ));
  return Future.value(false);
}

OverlayEntry _loadingOverlayEntry = OverlayEntry(builder: (context) {
  return Stack(
    children: [
      const Opacity(
        opacity: 0.8,
        child: ModalBarrier(dismissible: false, color: Colors.black),
      ),
      Center(
        child: SpinKitSpinningLines(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    ],
  );
});

get loadingOverlayEntry => _loadingOverlayEntry;

void showLoadingOverlay(BuildContext context) {
  final overlay = Overlay.of(context);

  if (!overlay.mounted) {
    print("No overlay found");
    return;
  }

  overlay.insert(_loadingOverlayEntry);
}

void hideLoadingOverlay(BuildContext context) {
  final overlay = Overlay.of(context);

  if (!overlay.mounted) {
    print("No overlay found");
    return;
  }

  _loadingOverlayEntry.remove();
}

extension IterableX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension StringX on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
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

String handleResponseErrorCode(int? code) {
  switch (code) {
    case 400:
      return 'Please fill in all the fields correctly';
    case 401:
      return 'Check your inputs and try again';
    case 403:
      return 'You are not authorized to access this resource';
    case 404:
      return 'Resource not found';
    case 500:
      return 'Something went wrong on the server';
    default:
      return 'Something went wrong';
  }
}
