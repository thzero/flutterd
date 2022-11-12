import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:flutterd/ui/navigation_bar_menu.dart';

mixin PlatformMixin {
  static const String iconAdd = 'add';
  static const String iconArrowDown = 'arrow_downward';
  static const String iconArrowLeft = 'addLeft';
  static const String iconArrowLeftDirectory = 'subdirectory_arrow_left';
  static const String iconArrowRight = 'addRight';
  static const String iconArrowRightDirectory = 'subdirectory_arrow_right';
  static const String iconArrowUp = 'arrow_upward';
  static const String iconCamera = 'camera';
  static const String iconCameraAlt = 'camera_alt';
  static const String iconCameraAltOutlined = 'camera_alt_outlined';
  static const String iconCheck = 'check';
  static const String iconClear = 'clear';
  static const String iconClose = 'close';
  static const String iconColor = 'color';
  static const String iconDelete = 'delete';
  static const String iconExport = 'export';
  static const String iconEdit = 'edit';
  static const String iconImage = 'iconImage';
  static const String iconImport = 'import';
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

  Color colorBorder(BuildContext context);
  Color colorHyperlink(BuildContext context);
  Widget constructButton(BuildContext context, VoidCallback? onPressed, String text, {bool disabled = false});
  Widget constructButtonIcon(BuildContext context, VoidCallback? onPressed, String iconType, {bool disabled = false});
  Widget constructButtonTap(BuildContext context, TapDebouncerFunc? onTapFunc, String title, {int cooldown = 500, bool disabled = false});
  Widget constructButtonTapIcon(BuildContext context, TapDebouncerFunc? onTapFunc, String iconType, {int cooldown = 500, bool disabled = false});
  StatelessWidget constructCard(BuildContext context, Widget child, {double? height, double? width});
  Widget constructCheckboxOutline(BuildContext context, String label, bool? value);
  Widget constructDialogAlert(BuildContext context, Widget? content, List<Widget>? actions);
  constructDialogConfirm(
    BuildContext context, {
    Widget? title,
    Widget? content,
  });
  Widget constructDivider(BuildContext context);
  Widget constructExpansion(BuildContext context, String title, List<Widget> content, {String? subTitle, bool initiallyExpanded = true, bool maintainState = true, ValueChanged<bool>? onExpansionChanged});
  Widget constructNavigationBarMenu(BuildContext context);
  constructNavigationBarMenuSelected(BuildContext context, NavigationBarMenuItem value) {
    Navigator.pushNamed(context, value.route);
  }

  Widget constructOutlineContainer(BuildContext context, String label, Widget widget) {
    double fontSize = getOutlineTitledContainerFontSize(context) ?? 12.0;
    return Padding(
        padding: EdgeInsets.fromLTRB(0, fontSize + 4, 0, 0),
        child: TitledContainer(
            titleColor: getOutlineTitledContainerColorTitle(context) ?? getOutlineTitledContainerColorTitleAlt(context),
            title: label,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            textAlign: TextAlignTitledContainer.left,
            backgroundColor: getOutlineColorBackground(context),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: getOutlineTitledContainerColor(context),
                    border: Border.all(
                      color: getOutlineTitledContainerColorBorder(context),
                      width: 1.2,
                    ),
                    borderRadius: getOutlineTitledContainerBorderRadius(context)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
                  child: widget,
                ))));
  }

  Widget constructTextOutlineContainer(BuildContext context, String label, String? text) {
    double fontSize = getOutlineTitledContainerFontSize(context) ?? 12.0;
    return Padding(
        padding: EdgeInsets.fromLTRB(0, fontSize + 4, 0, 0),
        child: TitledContainer(
            titleColor: getOutlineTitledContainerColorTitle(context) ?? getOutlineTitledContainerColorTitleAlt(context),
            title: label,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            textAlign: TextAlignTitledContainer.left,
            backgroundColor: getOutlineColorBackground(context),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: getOutlineTitledContainerColor(context),
                    border: Border.all(
                      color: getOutlineTitledContainerColorBorder(context),
                      width: 1.2,
                    ),
                    borderRadius: getOutlineTitledContainerBorderRadius(context)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
                  child: Text(text ?? '',
                      style: getTextStyleSubTitle(context)!.merge(
                        const TextStyle(fontWeight: FontWeight.normal),
                      )),
                ))));
    // return Column(children: [
    //   Padding(
    //       padding: EdgeInsets.fromLTRB(0, fontSize + 4, 0, 0),
    //       child: TitledContainer(
    //           titleColor: Theme.of(context).inputDecorationTheme.floatingLabelStyle!.color ?? Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color,
    //           title: label,
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           textAlign: TextAlignTitledContainer.left,
    //           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //           child: Expanded(
    //               child: Container(
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).inputDecorationTheme.fillColor,
    //                 border: Border.all(
    //                   color: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color,
    //                   width: 1.2,
    //                 ),
    //                 borderRadius: (Theme.of(context).inputDecorationTheme.focusedBorder! as OutlineInputBorder).borderRadius),
    //             child: Padding(
    //               padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
    //               child: Text(text ?? '',
    //                   style: getTextStyleSubTitle(context)!.merge(
    //                         const TextStyle(fontWeight: FontWeight.normal),
    //                       )),
    //             ),
    //           ))))
    // ]);
  }

  PageRoute<T> constructPageRoute<T>(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  });
  Widget constructPopupMenu(BuildContext context, List<PopupMenuItem2> list);
  StatefulWidget constructScaffold(BuildContext context, Widget body, String title, {Widget? bottomNavigationBar, List<Widget>? actions, Widget? actionButton, String? actionButtonLocation, bool? resizeToAvoidBottomInset});
  Widget constructText(BuildContext context, String valueOrId, {bool isId = true, TextStyle? style});

  Widget constructTextFieldOutline(BuildContext context, TextEditingController controller, String label, {GestureTapCallback? onTap});
  Widget constructTextFieldOutlineContainer(BuildContext context, String label, String? text, {GestureTapCallback? onTap}) {
    double fontSize = getOutlineTitledContainerFontSize(context) ?? 12.0;
    TextEditingController controller = TextEditingController();
    Widget widget = Padding(padding: EdgeInsets.fromLTRB(0, fontSize + 4, 0, 0), child: constructTextFieldOutline(context, controller, label, onTap: onTap));
    if (text != null) {
      controller.text = text;
      // controller.value.copyWith(text: text);
    }
    return widget;
  }

  Widget constructTextHeader(BuildContext context, String valueOrId, {bool isId = true});
  Widget constructTextTap(BuildContext context, TapDebouncerFunc? onTapFunc, String title, {int cooldown = 500, bool disabled = false, TapDebouncerFunc? onDoubleTapFunc, TextStyle? style});

  IconData determineIcon(String iconType);

  Color? getOutlineColorBackground(BuildContext context);
  BorderRadiusGeometry? getOutlineTitledContainerBorderRadius(BuildContext context);
  Color? getOutlineTitledContainerColor(BuildContext context);
  Color getOutlineTitledContainerColorBorder(BuildContext context);
  Color? getOutlineTitledContainerColorTitle(BuildContext context);
  Color? getOutlineTitledContainerColorTitleAlt(BuildContext context);
  double? getOutlineTitledContainerFontSize(BuildContext context);

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

  void showSnackbar(BuildContext? context, String message);

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
