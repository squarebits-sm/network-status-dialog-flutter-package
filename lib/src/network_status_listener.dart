import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network_status_dialog.dart';
import 'network_dialog_widget.dart';

/// A widget that listens for network connectivity changes
/// and automatically shows or hides a [NetworkDialogWidget].
///
/// Place [NetworkStatusListener] above your app's root widget
/// to ensure connectivity changes are detected globally.
///
/// Example:
/// ```dart
/// runApp(
///   NetworkStatusListener(
///     navigatorKey: navigatorKey,
///     config: NetworkDialogConfig(primaryColor: Colors.blue),
///     child: MyApp(),
///   ),
/// );
/// ```
class NetworkStatusListener extends StatefulWidget {
  /// The child widget that will be displayed beneath the listener.
  ///
  /// This is usually your app's root widget.
  final Widget child;

  /// The configuration used to customize the appearance of the dialog.
  final NetworkDialogConfig config;

  /// A [GlobalKey] for the app's [Navigator], used to display dialogs
  /// above all screens.
  final GlobalKey<NavigatorState> navigatorKey;

  /// Creates a [NetworkStatusListener].
  ///
  /// - [child] is required and represents the widget tree to wrap.
  /// - [config] provides dialog customization options.
  /// - [navigatorKey] is required for showing the dialog.
  const NetworkStatusListener({
    super.key,
    required this.child,
    required this.config,
    required this.navigatorKey,
  });

  @override
  State<NetworkStatusListener> createState() => _NetworkStatusListenerState();
}

/// Internal state for [NetworkStatusListener].
///
/// Handles subscriptions to [Connectivity] changes,
/// and manages showing and closing the [NetworkDialogWidget].
class _NetworkStatusListenerState extends State<NetworkStatusListener> {
  late final StreamSubscription _subscription;
  bool _isDialogOpen = false;
  BuildContext? _dialogContext;

  @override
  void initState() {
    super.initState();

    // Subscribe to connectivity changes.
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final bool isOffline = results.contains(ConnectivityResult.none);

      if (isOffline && !_isDialogOpen) {
        _showCustomDialog();
      } else if (!isOffline && _isDialogOpen) {
        _closeDialog();
      }
    });
  }

  /// Displays the custom network dialog when the device is offline.
  void _showCustomDialog() {
    final overlayContext = widget.navigatorKey.currentState?.overlay?.context;
    if (overlayContext == null || !mounted) return;

    _isDialogOpen = true;

    showDialog(
      context: overlayContext,
      barrierDismissible: false,
      builder: (ctx) {
        _dialogContext = ctx;
        return NetworkDialogWidget(config: widget.config);
      },
    ).then((_) {
      _isDialogOpen = false;
      _dialogContext = null;
    });
  }

  /// Closes the network dialog when the device comes back online.
  void _closeDialog() {
    if (_dialogContext != null && _isDialogOpen) {
      Navigator.of(_dialogContext!, rootNavigator: true).pop();
      _isDialogOpen = false;
      _dialogContext = null;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
