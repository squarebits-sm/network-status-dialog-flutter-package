import 'dart:ui';

class NetworkDialogConfig {
  final String? title;
  final String? description;
  final Color? titleColor;
  final Color? descriptionColor;
  final Color? dialogBackgroundColor;
  final Color primaryColor;
  final Color? buttonTxtColor;

  const NetworkDialogConfig({
    this.title,
    this.description,
    this.titleColor,
    this.descriptionColor,
    this.dialogBackgroundColor,
    this.buttonTxtColor,
    required this.primaryColor,
  });
}
