import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:flutterd/ui/navigation_bar_menu.dart';

mixin PlatformMixin {
  static const String iconAdd = 'add';
  static const String iconArrowUp = 'arrow_upward';
  static const String iconArrowLeftDirectory = 'subdirectory_arrow_left';
  static const String iconArrowRightDirectory = 'subdirectory_arrow_right';
  static const String iconArrowDown = 'arrow_downward';
  static const String iconCamera = 'camera';
  static const String iconCameraAlt = 'camera_alt';
  static const String iconCameraAltOutlined = 'camera_alt_outlined';
  static const String iconCheck = 'check';
  static const String iconClear = 'clear';
  static const String iconClose = 'close';
  static const String iconColor = 'color';
  static const String iconDelete = 'delete';
  static const String iconEdit = 'edit';
  static const String iconImage = 'iconImage';
  static const String iconMoreVert = 'moreVert';
  static const String iconPause = 'pause';
  static const String iconPhoto = 'photo';
  static const String iconPhotoLibrary = 'photo_library';
  static const String iconPhotoLibraryOutlined = 'photo_library_outlined';
  static const String iconPhotoAlbum = 'photoAlbum';
  static const String iconPlay = 'play';
  static const String iconRadioCheck = 'radioCheck';
  static const String iconRadioUncheck = 'radioUncheck';
  static const String iconReadMore = 'readMore';
  static const String iconReorder = 'reorder';
  static const String iconSearch = 'search';
  static const String iconSettings = 'settings';
  static const String iconStart = 'start';
  static const String iconStop = 'stop';

  Color colorHyperlink(BuildContext context);
  Widget constructButton(BuildContext context, VoidCallback? onPressed, String text, {bool disabled = false});
  Widget constructButtonIcon(BuildContext context, VoidCallback? onPressed, String iconType, {bool disabled = false});
  Widget constructButtonTap(BuildContext context, TapDebouncerFunc? onTapFunc, String title, {int cooldown = 500, bool disabled = false});
  Widget constructButtonTapIcon(BuildContext context, TapDebouncerFunc? onTapFunc, String iconType, {int cooldown = 500, bool disabled = false});
  StatelessWidget constructCard(BuildContext context, Widget child, {double? height, double? width});
  Widget constructDialogAlert(BuildContext context, Widget? content, List<Widget>? actions);
  constructDialogConfirm(
    BuildContext context, {
    Widget? title,
    Widget? content,
  });
  Widget constructDivider(BuildContext context);
  Widget constructNavigationBarMenu(BuildContext context);
  constructNavigationBarMenuSelected(BuildContext context, NavigationBarMenuItem value) {
    Navigator.pushNamed(context, value.route);
  }

  PageRoute<T> constructPageRoute<T>(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  });
  Widget constructPopupMenu(BuildContext context, List<PopupMenuItem2> list);
  StatefulWidget constructScaffold(BuildContext context, Widget body, String title, {Widget? bottomNavigationBar, List<Widget>? actions, Widget? actionButton, String? actionButtonLocation, bool? resizeToAvoidBottomInset});
  Widget constructText(BuildContext context, String valueOrId, {bool isId = true});
  Widget constructTextHeader(BuildContext context, String valueOrId, {bool isId = true});

  IconData determineIcon(String iconType);

  showDialogAlert(BuildContext context, WidgetBuilder builder, Function(dynamic) onSuccess);
  Future<Color?> showDialogColor(BuildContext context, {Color? previous, List<Color>? colorsOverride});
  Future<bool> showDialogConfirm(
    BuildContext context, {
    Widget? title,
    Widget? content,
  });
  Future<bool> showDialogConfirmDirty(BuildContext context, bool? isDirty) async {
    if (isDirty == null || isDirty == false) {
      return false;
    }
    bool results = await showDialogConfirm(
      context,
      content: Text(FlutterI18n.translate(context, 'message_form_confirm_is_dirty')),
    );
    return !results;
  }

  Future<bool> showDialogConfirmDirtyWillPop(BuildContext context, bool? isDirty) async {
    return !(await showDialogConfirmDirty(context, isDirty));
  }

  Future<Uint8List?> showDialogImage(BuildContext context, {Uint8List? previous});
  Future<String?> showDialogSelection(BuildContext context, String? title, Map<String, String> selections);

  TextStyle? textStyleHeading(BuildContext context);
  TextStyle textStyleHyperlink(BuildContext context) {
    return TextStyle(color: colorHyperlink(context), decoration: TextDecoration.underline, fontWeight: FontWeight.bold);
  }

  TextStyle? getTextStyleSubTitle(BuildContext context);

  TextStyle? textStyleText(BuildContext context);
}

typedef PopupMenuItem2Selected = void Function(PopupMenuItem2 value);

class PopupMenuItem2 {
  final String title;
  final IconData? icon;
  final PopupMenuItem2Selected? onSelected;

  const PopupMenuItem2(this.title, this.icon, this.onSelected);
}
