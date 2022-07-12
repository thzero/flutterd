import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thzero_library/blocs/tabs/events/updated.dart';
import 'package:thzero_library/blocs/tabs/tab_bloc.dart';
import 'package:thzero_library/blocs/tabs/tab_state.dart';
import 'package:thzero_library/ui/mixins/material/platform.dart';
import 'package:thzero_library/ui/navigation_bar_tabs.dart';
import 'package:thzero_library/ui/screens/home.dart';
import 'package:thzero_library/ui/widgets/material/navigation_tab_selector.dart';

class MaterialHomeScreen extends HomeScreen with MaterialPlatformMixin {
  const MaterialHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        return constructScaffold(context, NavigationBarTabs.determineTabBody(state.tab), title(context),
            bottomNavigationBar: MaterialNavigationTabSelectorWidget(
              state.tab,
              (tab) => BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
            ),
            actions: <Widget>[
              // IconButton(
              //   icon: const Icon(Icons.search),
              //   onPressed: () {
              //     Navigator.pushNamed(context, AppRoutes.findDevice);
              //   },
              // ),
              constructNavigationBarMenu(context),
            ]);
      },
    );
  }
}
