import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import '../network_status_dialog.dart';

class NetworkDialogWidget extends StatelessWidget {
  final NetworkDialogConfig? config;

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
              Image.asset(
                'packages/network_status_dialog/assets/no_wifi.png',
                height: MediaQuery.sizeOf(context).height * 0.12,
                width: MediaQuery.sizeOf(context).height * 0.12,
                color: primaryColor,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
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
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).height * 0.022,
                  color: descriptionColor,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
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