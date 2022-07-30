import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:thzero_library/ui/navigation_bar_menu.dart';

mixin PlatformMixin {
  static const String iconAdd = 'add';
  static const String iconArrowUp = 'arrow_upward';
  static const String iconArrowLeftDirectory = 'subdirectory_arrow_left';
  static const String iconArrowRightDirectory = 'subdirectory_arrow_right';
  static const String iconArrowDown = 'arrow_downward';
  static const String iconCheck = 'check';
  static const String iconClose = 'close';
  static const String iconDelete = 'delete';
  static const String iconEdit = 'edit';
  static const String iconMoreVert = 'moreVert';
  static const String iconPause = 'pause';
  static const String iconPlay = 'play';
  static const String iconReadMore = 'readMore';
  static const String iconReorder = 'reorder';
  static const String iconStart = 'start';
  static const String iconStop = 'stop';

  Color colorHyperlink(BuildContext context);
  Widget constructButton(BuildContext context, VoidCallback? onPressed, String text, {bool disabled = false});
  Widget constructButtonIcon(BuildContext context, VoidCallback? onPressed, String iconType, {bool disabled = false});
  Widget constructButtonTap(BuildContext context, TapDebouncerFunc? onTapFunc, String title, {int cooldown = 500, bool disabled = false});
  Widget constructButtonTapIcon(BuildContext context, TapDebouncerFunc? onTapFunc, String iconType, {int cooldown = 500, bool disabled = false});
  StatelessWidget constructContainer(BuildContext context, Widget child);
  Widget constructDialogAlert(BuildContext context, Widget? content, List<Widget>? actions);
  constructDialogConfirm(
    BuildContext context, {
    Widget? title,
    Widget? content,
  });
  Widget constructDivider(BuildContext context);
  Widget constructInputCheckbox<T extends BooleanFieldBloc<dynamic>>(BuildContext context, T value, String title, {bool readOnly = true});
  Widget constructInputDropdown<T extends ValueItemSelectFieldBloc<String, String, dynamic>>(BuildContext context, T value, String text, String hint, {bool readOnly = true});
  Widget constructInputNumber<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint, {bool signed = false, bool readOnly = false});
  Widget constructInputNumberDecimal<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint, {bool signed = false, bool readOnly = false});
  Widget constructInputText<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint, {bool readOnly = false});
  Widget constructInputTextArea<T extends TextFieldBloc<dynamic>>(BuildContext context, T value, String title, String? hint,
      {int maxLines = 5, int minLines = 1, int maxLength = 500, MaxLengthEnforcement maxLengthEnforced = MaxLengthEnforcement.enforced, bool readOnly = false});
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
  StatefulWidget constructScaffold(BuildContext context, Widget body, String title, {Widget? bottomNavigationBar, List<Widget>? actions, Widget? actionButton});
  Widget constructText(BuildContext context, String valueOrId, {bool isId = true});
  Widget constructTextHeader(BuildContext context, String valueOrId, {bool isId = true});

  IconData determineIcon(String iconType);

  showDialogAlert(BuildContext context, WidgetBuilder builder, Function(dynamic) onSuccess);
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

  Future<String?> showDialogSelection(BuildContext context, String? title, Map<String, String> selections);

  TextStyle? textStyleHeading(BuildContext context);
  TextStyle textStyleHyperlink(BuildContext context) {
    return TextStyle(color: colorHyperlink(context), decoration: TextDecoration.underline, fontWeight: FontWeight.bold);
  }

  TextStyle? textStyleText(BuildContext context);
}

typedef PopupMenuItem2Selected = void Function(PopupMenuItem2 value);

class PopupMenuItem2 {
  final String title;
  final IconData? icon;
  final PopupMenuItem2Selected? onSelected;

  const PopupMenuItem2(this.title, this.icon, this.onSelected);
}
