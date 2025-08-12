## 0.0.6

### Fixed
- Enhanced core logic to ensure stable functionality regardless of widget placement (Material wrapping issue resolved).

### Added
- Customization options for dialog appearance:
  - Title text color
  - Description text color
  - Background color
  - Button color

## 0.0.3

### Fixed
- Fixed issue where dialog was not shown if `NetworkStatusListener` was placed inside `MaterialApp`, `GetMaterialApp`, or any provider-based root
  Dialog context now correctly initializes when `NetworkStatusListener` is placed **above** the app root


## 0.0.2

### Fixed
- Resolved issue where asset image path was not recognized
- Improved README.md with clear usage instructions and integration steps
- Downgraded Dart SDK constraint from `>=3.8.0` to `>=3.7.0` for broader compatibility

---

## 0.0.1

### Initial Release
- Introduced `NetworkStatusListener` widget for auto-detecting network connectivity changes
- Show customizable offline dialog using `NetworkDialogConfig`
- Clean, minimal UI with options for:
    - Custom title, description text
    - Primary color for icon/buttons
- Handles airplane mode, no internet, and auto-dismiss on reconnection
- Lightweight and easy to integrate with any Flutter app
