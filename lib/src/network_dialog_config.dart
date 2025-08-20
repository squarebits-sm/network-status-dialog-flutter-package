import 'dart:ui';

/// Configuration options for customizing the appearance of the
/// network status dialog.
///
/// Use this class to set text, colors, and background styles
/// when the app goes offline and the dialog is displayed.
class NetworkDialogConfig {
  /// Title text shown at the top of the dialog.
  final String? title;

  /// Description text displayed below the [title].
  final String? description;

  /// Color applied to the [title] text.
  final Color? titleColor;

  /// Color applied to the [description] text.
  final Color? descriptionColor;

  /// Background color of the dialog container.
  final Color? dialogBackgroundColor;

  /// Primary/accent color used for buttons or highlights inside the dialog.
  final Color primaryColor;

  /// Color applied to the action button text.
  final Color? buttonTxtColor;

  /// Creates a new [NetworkDialogConfig] with the given properties.
  ///
  /// - [title]: Dialog title text.
  /// - [description]: Dialog description text.
  /// - [titleColor]: Color of the title text.
  /// - [descriptionColor]: Color of the description text.
  /// - [dialogBackgroundColor]: Background color of the dialog.
  /// - [buttonTxtColor]: Color of the action button text.
  /// - [primaryColor]: Primary/accent color for buttons or highlights (required).
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
