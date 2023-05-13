import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutterd/utils/utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:flutterd/ui/mixins/platform.dart';
import 'package:flutterd/ui/navigation_bar_menu.dart';
import 'package:flutterd_logging_wrapper/logging.dart';

const List<Color> colors = [
  Colors.red,
  Colors.pink,
  Colors.deepOrange,
  Colors.amber,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.teal,
  Colors.cyan,
  Colors.lightBlue,
  Colors.blue,
  Color(0xFF00008B),
  Colors.indigo,
  Colors.purple,
  Colors.deepPurple,
  Colors.brown,
  Colors.grey,
  Color(0xFFC0C0C0),
  Colors.black,
  Colors.white,
];

mixin MaterialPlatformMixin on PlatformMixin {
  @override
  Color colorBorder(BuildContext context) {
    return Colors.black12.withOpacity(0.6);
  }

  @override
  Color colorHyperlink(BuildContext context) {
    return Colors.blue;
  }

  @override
  Widget constructButton(BuildContext context, VoidCallback? onPressed, String title, {bool disabled = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }

  @override
  Widget constructButtonIcon(BuildContext context, VoidCallback? onPressed, String iconType, {bool disabled = false}) {
    IconData icon = determineIcon(iconType);
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

  @override
  Widget constructButtonTap(BuildContext context, TapDebouncerFunc? onTapFunc, String title, {int cooldown = 500, bool disabled = false}) {
    if (disabled) {
      return ElevatedButton(
        onPressed: null,
        child: Text(title),
      );
    }

    return TapDebouncer(
        cooldown: Duration(milliseconds: cooldown),
        onTap: onTapFunc,
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return ElevatedButton(
            onPressed: onTap,
            child: Text(title),
          );
        });
  }

  @override
  Widget constructButtonTapIcon(BuildContext context, TapDebouncerFunc? onTapFunc, String iconType, {int cooldown = 500, bool disabled = false}) {
    IconData icon = determineIcon(iconType);

    if (disabled) {
      return IconButton(
        icon: Icon(icon),
        onPressed: null,
      );
    }

    return TapDebouncer(
        cooldown: Duration(milliseconds: cooldown),
        onTap: onTapFunc,
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return IconButton(
            icon: Icon(icon),
            onPressed: onTap,
          );
        });
  }

  @override
  Widget constructCheckboxOutline(BuildContext context, String label, bool? value) {
    return constructOutlineContainer(
        context,
        label,
        Checkbox(
          value: value,
          onChanged: null,
        ));
  }

  @override
  StatelessWidget constructCard(BuildContext context, Widget child, {double? height, double? width}) {
    return Card(child: child);
  }

  @override
  Widget constructDialogAlert(BuildContext context, Widget? content, List<Widget>? actions) {
    return AlertDialog(
      content: content,
      actions: actions,
    );
  }

  @override
  Widget constructDialogConfirm(
    BuildContext context, {
    Widget? title,
    Widget? content,
  }) {
    return AlertDialog(
      title: title,
      content: content ?? const Text('Are you sure continue?'),
      actions: <Widget>[
        TextButton(
          child: Text(FlutterI18n.translate(context, 'button_cancel')),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(FlutterI18n.translate(context, 'button_ok')),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  @override
  Widget constructDialogPopup(BuildContext context, String label, String? value) {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: constructTextFieldOutlineContainer(context, label, value),
          )
        ],
      ),
      actions: [constructButtonTap(context, () async => Navigator.pop(context), FlutterI18n.translate(context, 'button_dismiss'))],
    );
  }

  @override
  Widget constructDivider(BuildContext context, {double? height, double? thickness, double? indent, double? endIndent, Color? color}) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }

  @override
  Widget constructExpansion(BuildContext context, String title, List<Widget> content, {String? subTitle, bool initiallyExpanded = true, bool maintainState = true, ValueChanged<bool>? onExpansionChanged}) {
    return ExpansionTile(
      title: Text(title),
      subtitle: Utilities.isNotEmpty(subTitle) ? Text(subTitle!) : null,
      initiallyExpanded: initiallyExpanded,
      maintainState: maintainState,
      onExpansionChanged: onExpansionChanged,
      children: content,
    );
  }

  @override
  Widget constructNavigationBarMenu(BuildContext context) {
    return PopupMenuButton<NavigationBarMenuItem>(
      onSelected: (result) {
        constructNavigationBarMenuSelected(context, result);
      },
      itemBuilder: (BuildContext context) {
        return NavigationBarMenu.menuList.menuList.map((NavigationBarMenuItem item) {
          return PopupMenuItem<NavigationBarMenuItem>(
            value: item,
            child: ListTile(
              dense: true,
              trailing: item.icon != null ? Icon(item.icon) : null,
              title: Text(NavigationBarMenu.title(context, item.title)),
            ),
          );
        }).toList();
      },
    );
  }

  @override
  PageRoute<T> constructPageRoute<T>(
    WidgetBuilder builder, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    return MaterialPageRoute<T>(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);
  }

  @override
  Widget constructPopupMenu(BuildContext context, List<PopupMenuItem2> list) {
    return PopupMenuButton<PopupMenuItem2>(
      onSelected: (result) {
        if (result.onSelected != null) {
          result.onSelected!(result);
        }
      },
      itemBuilder: (BuildContext context) {
        return list.map((PopupMenuItem2 item) {
          return PopupMenuItem<PopupMenuItem2>(
            value: item,
            child: ListTile(
              trailing: item.icon != null ? Icon(item.icon) : null,
              title: Text(item.title),
            ),
          );
        }).toList();
      },
    );
  }

  @override
  StatefulWidget constructScaffold(BuildContext context, Widget body, String title, {Widget? bottomNavigationBar, List<Widget>? actions, Widget? actionButton, String? actionButtonLocation, bool? resizeToAvoidBottomInset}) {
    return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
        appBar: AppBar(title: Text(title), actions: actions),
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: actionButton,
        floatingActionButtonLocation: _convertActionButtonLocation(actionButtonLocation));
  }

  @override
  Widget constructText(BuildContext context, String valueOrId, {bool isId = true, TextStyle? style}) {
    return Text(
      isId ? FlutterI18n.translate(context, valueOrId) : valueOrId,
      style: style,
    );
  }

  @override
  Widget constructTextTap(BuildContext context, TapDebouncerFunc? onTapFunc, String title, {int cooldown = 500, bool disabled = false, TapDebouncerFunc? onDoubleTapFunc, TextStyle? style}) {
    if (disabled) {
      return Text(
        title,
        style: style,
      );
    }

    return TapDebouncer(
        cooldown: Duration(milliseconds: cooldown),
        onTap: onTapFunc,
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return InkWell(
            onTap: onTap,
            onDoubleTap: onDoubleTapFunc,
            child: Text(
              title,
              style: style,
            ),
          );
        });
  }

  @override
  Widget constructTextFieldOutline(BuildContext context, TextEditingController controller, String label, {GestureTapCallback? onTap}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      readOnly: true,
      onTap: onTap,
    );
  }

  @override
  Widget constructTextHeader(BuildContext context, String valueOrId, {bool isId = true}) {
    return Text(isId ? FlutterI18n.translate(context, valueOrId) : valueOrId, style: Theme.of(context).textTheme.titleLarge);
  }

  @override
  Widget constructWell(BuildContext context, Widget widget, TapDebouncerFunc? onTapFunc, {int cooldown = 500, TapDebouncerFunc? onDoubleTapFunc, TextStyle? style}) {
    return TapDebouncer(
        cooldown: Duration(milliseconds: cooldown),
        onTap: onTapFunc,
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return InkWell(
            onTap: onTap,
            onDoubleTap: onDoubleTapFunc,
            child: widget,
          );
        });
  }

  @override
  IconData determineIcon(String iconType) {
    IconData? icon;
    switch (iconType) {
      case PlatformMixin.iconAdd:
        {
          icon = Icons.add;
          break;
        }
      case PlatformMixin.iconArrowDown:
        {
          icon = Icons.arrow_downward;
          break;
        }
      case PlatformMixin.iconArrowLeft:
        {
          icon = Icons.arrow_left;
          break;
        }
      case PlatformMixin.iconArrowLeftDirectory:
        {
          icon = Icons.subdirectory_arrow_left;
          break;
        }
      case PlatformMixin.iconArrowRight:
        {
          icon = Icons.arrow_right;
          break;
        }
      case PlatformMixin.iconArrowRightDirectory:
        {
          icon = Icons.subdirectory_arrow_right;
          break;
        }
      case PlatformMixin.iconArrowUp:
        {
          icon = Icons.arrow_upward;
          break;
        }
      case PlatformMixin.iconCamera:
        {
          icon = Icons.camera;
          break;
        }
      case PlatformMixin.iconCameraAlt:
        {
          icon = Icons.camera_alt;
          break;
        }
      case PlatformMixin.iconCameraAltOutlined:
        {
          icon = Icons.camera_alt_outlined;
          break;
        }
      case PlatformMixin.iconColor:
        {
          icon = Icons.colorize;
          break;
        }
      case PlatformMixin.iconCheck:
        {
          icon = Icons.check;
          break;
        }
      case PlatformMixin.iconCircle:
        {
          icon = Icons.circle;
          break;
        }
      case PlatformMixin.iconClear:
        {
          icon = Icons.clear;
          break;
        }
      case PlatformMixin.iconClose:
        {
          icon = Icons.close;
          break;
        }
      case PlatformMixin.iconDelete:
        {
          icon = Icons.delete;
          break;
        }
      case PlatformMixin.iconEdit:
        {
          icon = Icons.edit;
          break;
        }
      case PlatformMixin.iconExport:
        {
          icon = Icons.download;
          break;
        }
      case PlatformMixin.iconImage:
        {
          icon = Icons.image;
          break;
        }
      case PlatformMixin.iconImport:
        {
          icon = Icons.upload;
          break;
        }
      case PlatformMixin.iconMoreVert:
        {
          icon = Icons.more_vert;
          break;
        }
      case PlatformMixin.iconPause:
        {
          icon = Icons.pause;
          break;
        }
      case PlatformMixin.iconPhoto:
        {
          icon = Icons.photo;
          break;
        }
      case PlatformMixin.iconPhotoAlbum:
        {
          icon = Icons.photo_album;
          break;
        }
      case PlatformMixin.iconPhotoLibrary:
        {
          icon = Icons.circle;
          break;
        }
      case PlatformMixin.iconPhotoLibraryOutlined:
        {
          icon = Icons.photo_library_outlined;
          break;
        }
      case PlatformMixin.iconPlay:
        {
          icon = Icons.play_arrow;
          break;
        }
      case PlatformMixin.iconRadioCheck:
        {
          icon = Icons.radio_button_checked;
          break;
        }
      case PlatformMixin.iconRadioUncheck:
        {
          icon = Icons.radio_button_unchecked;
          break;
        }
      case PlatformMixin.iconReadMore:
        {
          icon = Icons.read_more;
          break;
        }
      case PlatformMixin.iconReorder:
        {
          icon = Icons.reorder;
          break;
        }
      case PlatformMixin.iconSearch:
        {
          icon = Icons.search;
          break;
        }
      case PlatformMixin.iconSettings:
        {
          icon = Icons.settings;
          break;
        }
      case PlatformMixin.iconStart:
        {
          icon = Icons.start;
          break;
        }
      case PlatformMixin.iconStop:
        {
          icon = Icons.stop;
          break;
        }
    }
    if (icon == null) {
      throw Exception('Invalid \'$iconType\' iconType');
    }

    return icon;
  }

  @override
  Color? getOutlineColorBackground(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  @override
  BorderRadiusGeometry? getOutlineTitledContainerBorderRadius(BuildContext context) {
    return (Theme.of(context).inputDecorationTheme.focusedBorder! as OutlineInputBorder).borderRadius;
  }

  @override
  Color? getOutlineTitledContainerColor(BuildContext context) {
    return Theme.of(context).inputDecorationTheme.fillColor;
  }

  @override
  Color getOutlineTitledContainerColorBorder(BuildContext context) {
    return Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color;
  }

  @override
  Color? getOutlineTitledContainerColorTitle(BuildContext context) {
    return Theme.of(context).inputDecorationTheme.floatingLabelStyle!.color;
  }

  @override
  Color? getOutlineTitledContainerColorTitleAlt(BuildContext context) {
    return Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color;
  }

  @override
  double? getOutlineTitledContainerFontSize(BuildContext context) {
    return Theme.of(context).inputDecorationTheme.floatingLabelStyle!.fontSize;
  }

  @override
  showDialogAlert(BuildContext context, WidgetBuilder builder, Function(dynamic) onSuccess) {
    showDialog(context: context, builder: builder).then(onSuccess);
  }

  @override
  Future<Color?> showDialogColor(BuildContext context, {Color? previous, List<Color>? colorsOverride}) async {
    Color? colorOutput;
    await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(FlutterI18n.translate(context, 'message_color_select')),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: Colors.transparent,
              onColorChanged: (Color color) {
                colorOutput = color;
              },
              availableColors: colorsOverride ?? colors,
              // layoutBuilder: pickerLayoutBuilder,
              // itemBuilder: pickerItemBuilder,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(FlutterI18n.translate(context, 'button_cancel')),
              onPressed: () => Navigator.pop(context, null),
            ),
            TextButton(
              child: Text(FlutterI18n.translate(context, 'button_ok')),
              onPressed: () => Navigator.pop(context, colorOutput),
            ),
          ],
        );
      },
    );
    return colorOutput;
  }

  @override
  Future<bool> showDialogConfirm(
    BuildContext context, {
    Widget? title,
    Widget? content,
  }) async {
    final bool? isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) => WillPopScope(
        child: constructDialogConfirm(context, title: title, content: content),
        onWillPop: () async {
          Navigator.pop(context, false);
          return true;
        },
      ),
    );
    return isConfirm ?? false;
  }

  @override
  Future<Uint8List?> showDialogImage(BuildContext context, {Uint8List? previous}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      return await photo.readAsBytes();
    }
    return null;
  }

  @override
  Future<String?> showDialogSelection(BuildContext context, String? title, Map<String, String> selections) async {
    String? identifier;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: title != null ? Text(title) : null,
            children: <Widget>[
              for (var entry in selections.entries)
                SimpleDialogOption(
                  child: Text(entry.value),
                  onPressed: () {
                    identifier = entry.key;
                    Navigator.pop(context, true);
                  },
                )
            ],
          );
        });
    return identifier;
  }

  @override
  showSnackbar(BuildContext? context, String message, {Duration? duration}) {
    if (context == null) {
      Logger().wM(runtimeType.toString(), 'showSnackbar', 'Invalid context...');
    }

    ScaffoldMessenger.of(context!).showSnackBar(
      duration != null
          ? SnackBar(
              content: Text(message),
              duration: duration,
            )
          : SnackBar(
              content: Text(message),
            ),
    );
  }

  @override
  TextStyle? textStyleHeading(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge;
  }

  @override
  TextStyle? getTextStyleSubTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium;
  }

  @override
  TextStyle? textStyleText(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium;
  }

  _convertActionButtonLocation(String? actionButtonLocation) {
    if (actionButtonLocation == FloatingActionButtonLocation.centerDocked.toString()) return FloatingActionButtonLocation.centerDocked;
    if (actionButtonLocation == FloatingActionButtonLocation.centerFloat.toString()) return FloatingActionButtonLocation.centerFloat;
    if (actionButtonLocation == FloatingActionButtonLocation.centerTop.toString()) return FloatingActionButtonLocation.centerTop;
    if (actionButtonLocation == FloatingActionButtonLocation.endDocked.toString()) return FloatingActionButtonLocation.endDocked;
    if (actionButtonLocation == FloatingActionButtonLocation.endFloat.toString()) return FloatingActionButtonLocation.endFloat;
    if (actionButtonLocation == FloatingActionButtonLocation.endTop.toString()) return FloatingActionButtonLocation.endTop;
    if (actionButtonLocation == FloatingActionButtonLocation.miniCenterDocked.toString()) return FloatingActionButtonLocation.miniCenterDocked;
    if (actionButtonLocation == FloatingActionButtonLocation.miniCenterFloat.toString()) return FloatingActionButtonLocation.miniCenterFloat;
    if (actionButtonLocation == FloatingActionButtonLocation.miniCenterTop.toString()) return FloatingActionButtonLocation.miniCenterTop;
    if (actionButtonLocation == FloatingActionButtonLocation.miniEndDocked.toString()) return FloatingActionButtonLocation.miniEndDocked;
    if (actionButtonLocation == FloatingActionButtonLocation.miniEndFloat.toString()) return FloatingActionButtonLocation.miniEndFloat;
    if (actionButtonLocation == FloatingActionButtonLocation.miniEndTop.toString()) return FloatingActionButtonLocation.miniEndTop;
  }
}
