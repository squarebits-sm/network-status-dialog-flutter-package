import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import '../network_status_dialog.dart';

/// A dialog widget that is shown when the device goes offline.
///
/// The [NetworkDialogWidget] displays a customizable dialog
/// containing a title, description, icon, and buttons that let the
/// user quickly open Wi-Fi or mobile data settings.
///
/// By default, the dialog:
/// - Prevents closing via back navigation ([PopScope.canPop] = false).
/// - Displays a Wi-Fi icon, title, and description.
/// - Provides two actions:
///   - **Open Wi-Fi Settings** (Android: opens Wi-Fi settings, iOS: opens app settings).
///   - **Open Mobile Data Settings** (opens general app settings).
///
/// The appearance can be customized by passing a [NetworkDialogConfig].
class NetworkDialogWidget extends StatelessWidget {
  /// Configuration for customizing the dialog's look and feel.
  ///
  /// If not provided, default values are applied for text, colors,
  /// and background.
  final NetworkDialogConfig? config;

  /// Creates a [NetworkDialogWidget].
  ///
  /// The [config] parameter allows overriding dialog title, description,
  /// colors, and button text style.
  const NetworkDialogWidget({super.key, this.config});

  @override
  Widget build(BuildContext context) {
    final primaryColor = config?.primaryColor ?? Colors.blueAccent;
    final title = config?.title ?? 'Oops!';
    final description = config?.description ??
        'You\'re currently offline. Please connect to Wi-Fi or mobile data to continue using the app.';
    final titleColor = config?.titleColor ?? Colors.black;
    final descriptionColor = config?.descriptionColor ?? Colors.grey[700];
    final dialogBgColor = config?.dialogBackgroundColor ?? Colors.white;
    final buttonTxtColor = config?.buttonTxtColor ?? Colors.white;

    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: dialogBgColor,
        insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.04, // responsive margin
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.sizeOf(context).width * 0.08,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.07),
          child: ListView(
            shrinkWrap: true,
            children: [
              // Wi-Fi icon
              Image.asset(
                'packages/network_status_dialog/assets/no_wifi.png',
                height: MediaQuery.sizeOf(context).height * 0.12,
                width: MediaQuery.sizeOf(context).height * 0.12,
                color: primaryColor,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: titleColor,
                  fontSize: MediaQuery.sizeOf(context).height * 0.028,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.015),

              // Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).height * 0.022,
                  color: descriptionColor,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),

              // Wi-Fi settings button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      AppSettings.openAppSettings(type: AppSettingsType.wifi);
                    } else if (Platform.isIOS) {
                      AppSettings.openAppSettings();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.018,
                    ),
                  ),
                  child: Text(
                    'Open Wi-Fi Settings',
                    style: TextStyle(
                      color: buttonTxtColor,
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.015),

              // Mobile data settings button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    AppSettings.openAppSettings();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.018,
                    ),
                  ),
                  child: Text(
                    'Open Mobile Data Settings',
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
