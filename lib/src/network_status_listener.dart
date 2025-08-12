import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network_status_dialog.dart';
import 'network_dialog_widget.dart';

class NetworkStatusListener extends StatefulWidget {
  final Widget child;
  final NetworkDialogConfig config;
  final GlobalKey<NavigatorState> navigatorKey;

  const NetworkStatusListener({
    super.key,
    required this.child,
    required this.config,
    required this.navigatorKey,
  });

  @override
  State<NetworkStatusListener> createState() => _NetworkStatusListenerState();
}

class _NetworkStatusListenerState extends State<NetworkStatusListener> {
  late final StreamSubscription _subscription;
  bool _isDialogOpen = false;
  BuildContext? _dialogContext;

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      bool isOffline = results.contains(ConnectivityResult.none);

      if (isOffline && !_isDialogOpen) {
        _showCustomDialog();
      } else if (!isOffline && _isDialogOpen) {
        _closeDialog();
      }
    });
  }

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
