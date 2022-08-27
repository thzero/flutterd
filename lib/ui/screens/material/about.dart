import 'package:flutter/material.dart';

import 'package:flutterd/ui/mixins/material/platform.dart';
import 'package:flutterd/ui/screens/about.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MaterialAboutScreen extends AboutScreen {
  const MaterialAboutScreen({Key? key}) : super(key: key);

  @override
  MaterialAboutScreenState createState() => MaterialAboutScreenState();
}

class MaterialAboutScreenState extends AboutScreenState<MaterialAboutScreen> with MaterialPlatformMixin {
  MaterialAboutScreenState();

  @override
  Widget build(BuildContext context) {
    return constructScaffold(
        context,
        AboutDialog(
          applicationIcon: const FlutterLogo(),
          applicationName: title(context),
          applicationVersion: (version ?? '') + (buildNumber ?? ''),
          applicationLegalese: '\u{a9} ${copyright?.yearsComplete} ${copyright?.authors}',
        ),
        title(context));
  }
}
