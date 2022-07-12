import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import 'package:thzero_library/blocs/settings/settings_bloc.dart';
import 'package:thzero_library/blocs/settings/settings_state.dart';
import 'package:thzero_library/ui/screens/material/settings/theme.dart';
import 'package:thzero_library/ui/screens/settings.dart';

class MaterialSettingsScreen extends SettingsScreen {
  const MaterialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title(context)),
      ),
      body: Container(),
      // BlocBuilder<SettingsBloc, SettingsState>(
      //   builder: (context, state) {
      //     return Container(
      //       padding: const EdgeInsets.only(top: 5),
      //       child: SettingsList(sections: [
      //         SettingsSection(title: commons(context), tiles: [
      //           SettingsTile(
      //             title: theme(context),
      //             leading: const Icon(Icons.colorize),
      //             trailing: Text(context.select((SettingsBloc bloc) => bloc.state.themeAsString(context))),
      //             onPressed: (context) {
      //               Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (_) => const MaterialThemeSettingsScreen(),
      //               ));
      //             },
      //           ),
      //         ])
      //       ]),
      //     );
      //   }),
    );
  }
}
