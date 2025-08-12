import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkDialogConfig {
  final Color primaryColor;
  final String title;
  final String description;

  const NetworkDialogConfig({
    this.primaryColor = Colors.red,
    this.title = "No Internet",
    this.description = "Please check your connection.",
  });
}

class NetworkStatusListener extends StatefulWidget {
  final Widget child;
  final NetworkDialogConfig? config;
  final GlobalKey<NavigatorState>? navigatorKey;

  const NetworkStatusListener({
    Key? key,
    required this.child,
    this.config,
    this.navigatorKey,
  }) : super(key: key);

  @override
  State<NetworkStatusListener> createState() => _NetworkStatusListenerState();
}

class _NetworkStatusListenerState extends State<NetworkStatusListener> {
  StreamSubscription<ConnectivityResult>? _subscription;
  bool _isDialogVisible = false;

  late final GlobalKey<NavigatorState> _navKey;

  @override
  void initState() {
    super.initState();
    _navKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();

    _subscription = Connectivity().onConnectivityChanged.listen((status) {
      final hasInternet = status != ConnectivityResult.none;
      if (!hasInternet && !_isDialogVisible) {
        _showOfflineDialog();
      } else if (hasInternet && _isDialogVisible) {
        _dismissDialog();
      }
    }) as StreamSubscription<ConnectivityResult>?;
  }

  void _showOfflineDialog() {
    _isDialogVisible = true;
    final cfg = widget.config ?? const NetworkDialogConfig();
    showDialog(
      context: _navKey.currentContext!,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(cfg.title),
        content: Text(cfg.description),
        backgroundColor: cfg.primaryColor.withOpacity(0.1),
      ),
    );
  }

  void _dismissDialog() {
    if (_isDialogVisible) {
      Navigator.of(_navKey.currentContext!, rootNavigator: true).pop();
      _isDialogVisible = false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navKey,
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (_) => widget.child),
    );
  }
}