import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:thzero_library/ui/mixins/platform.dart';
import 'package:thzero_library/ui/navigation_bar_menu.dart';

mixin MaterialPlatformMixin on PlatformMixin {
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
  StatelessWidget constructContainer(BuildContext context, Widget child) {
    return Card(child: child);
  }

  @override
  Widget constructDialogAlert(BuildContext context, Widget? content, List<Widget>? actions) {
    return AlertDialog(content: content, actions: actions);
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
  Widget constructDivider(BuildContext context) {
    return const Divider();
  }

  @override
  Widget constructInputCheckbox<T extends BooleanFieldBloc<dynamic>>(BuildContext context, T value, String title, {bool readOnly = true}) {
    return CheckboxFieldBlocBuilder(
      booleanFieldBloc: value,
      isEnabled: readOnly,
      body: Text(title),
    );
  }

  @override
  Widget constructInputDropdown<T extends ValueItemSelectFieldBloc<String, String, dynamic>>(BuildContext context, T value, String text, String hint, {bool readOnly = true}) {
    return ValueItemDropdownFieldBlocBuilder<String, String>(
      selectFieldBloc: value,
      decoration: InputDecoration(
        // filled: true,
        hintText: hint,
        labelText: text,
      ),
      itemBuilder: (context, value) => FieldItem(
        child: Text(value),
      ),
    );
  }

  @override
  Widget constructInputNumber<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint, {bool signed = false, bool readOnly = false}) {
    return TextFieldBlocBuilder(
      textFieldBloc: value,
      readOnly: readOnly,
      keyboardType: TextInputType.numberWithOptions(signed: signed, decimal: false),
      decoration: InputDecoration(labelText: title, hintText: hint),
    );
  }

  @override
  Widget constructInputNumberDecimal<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint, {bool signed = false, bool readOnly = false}) {
    return TextFieldBlocBuilder(
      textFieldBloc: value,
      readOnly: readOnly,
      keyboardType: TextInputType.numberWithOptions(signed: signed, decimal: true),
      decoration: InputDecoration(labelText: title, hintText: hint),
    );
  }

  @override
  Widget constructInputText<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint, {bool readOnly = false}) {
    return TextFieldBlocBuilder(
      textFieldBloc: value,
      readOnly: readOnly,
      decoration: InputDecoration(labelText: title, hintText: hint),
    );
  }

  @override
  Widget constructInputTextArea<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint,
      {int maxLines = 5, int minLines = 1, int maxLength = 500, MaxLengthEnforcement maxLengthEnforced = MaxLengthEnforcement.enforced, bool readOnly = false}) {
    return TextFieldBlocBuilder(
      textFieldBloc: value,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      maxLengthEnforced: maxLengthEnforced,
      readOnly: readOnly,
      decoration: InputDecoration(labelText: title, hintText: hint),
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
  StatefulWidget constructScaffold(BuildContext context, Widget body, String title, {Widget? bottomNavigationBar, List<Widget>? actions, Widget? actionButton}) {
    return Scaffold(resizeToAvoidBottomInset: false, appBar: AppBar(title: Text(title), actions: actions), body: body, bottomNavigationBar: bottomNavigationBar, floatingActionButton: actionButton);
  }

  @override
  Widget constructText(BuildContext context, String valueOrId, {bool isId = true}) {
    return Text(isId ? FlutterI18n.translate(context, valueOrId) : valueOrId);
  }

  @override
  Widget constructTextHeader(BuildContext context, String valueOrId, {bool isId = true}) {
    return Text(isId ? FlutterI18n.translate(context, valueOrId) : valueOrId, style: Theme.of(context).textTheme.headline6);
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
      case PlatformMixin.iconArrowUp:
        {
          icon = Icons.arrow_upward;
          break;
        }
      case PlatformMixin.iconArrowLeftDirectory:
        {
          icon = Icons.subdirectory_arrow_left;
          break;
        }
      case PlatformMixin.iconArrowRightDirectory:
        {
          icon = Icons.subdirectory_arrow_right;
          break;
        }
      case PlatformMixin.iconArrowDown:
        {
          icon = Icons.arrow_downward;
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
      case PlatformMixin.iconPlay:
        {
          icon = Icons.play_arrow;
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
  showDialogAlert(BuildContext context, WidgetBuilder builder, Function(dynamic) onSuccess) {
    showDialog(context: context, builder: builder).then(onSuccess);
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
  TextStyle? textStyleHeading(BuildContext context) {
    return Theme.of(context).textTheme.headline6;
  }

  @override
  TextStyle? textStyleText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2;
  }
}
