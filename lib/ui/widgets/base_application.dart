import 'package:flutter/widgets.dart';

import 'package:fluttered/ui/mixins/platform.dart';

enum AppTypes { cupertino, material }

enum DeviceType { phone, tablet }

typedef ApplicationFactoryInit = void Function(BuildContext context);

abstract class BaseApplicationWidget extends StatelessWidget with PlatformMixin {
  final ApplicationFactoryInit? init;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final GlobalKey<NavigatorState>? navigatorKey;
  final RouteFactory? onGenerateRoute;
  final GenerateAppTitle? onGenerateTitle;
  final Map<String, WidgetBuilder> routes;

  const BaseApplicationWidget(this.localizationsDelegates, this.navigatorKey, this.onGenerateRoute, this.onGenerateTitle, this.routes, {Key? key, this.init}) : super(key: key);
}
