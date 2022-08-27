import 'package:flutter/material.dart';

import 'package:flutterd/ui/mixins/material/platform.dart';
import 'package:flutterd/ui/screens/about.dart';

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
          applicationVersion: initVersionFormat(),
          applicationLegalese: initLeagleseFormat(),
        ),
        title(context));
  }
}
