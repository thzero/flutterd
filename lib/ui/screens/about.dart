import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:flutterd/ui/mixins/platform.dart';
import 'package:flutterd/utils/utilities.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
}

abstract class AboutScreenState<T extends AboutScreen> extends State<T> with PlatformMixin {
  String? appName;
  String? buildNumber;
  Copyright? copyright;
  String? packageName;
  String? version;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appName = packageInfo.appName;
        buildNumber = packageInfo.buildNumber;
        copyright = Utilities.copyright ?? Copyright('', '');
        packageName = packageInfo.packageName;
        version = packageInfo.version;
      });
    });
  }

  String title(BuildContext context) {
    // title: Text(AppLocalizations.of(context)!.appTitle),
    return FlutterI18n.translate(context, 'appTitle');
  }
}
