import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterd/blocs/tabs/events/updated.dart';
import 'package:flutterd/blocs/tabs/tab_bloc.dart';
import 'package:flutterd/blocs/tabs/tab_state.dart';
import 'package:flutterd/ui/mixins/material/platform.dart';
import 'package:flutterd/ui/navigation_bar_tabs.dart';
import 'package:flutterd/ui/screens/home.dart';
import 'package:flutterd/ui/widgets/material/navigation_tab_selector.dart';

class MaterialHomeScreen extends HomeScreen with MaterialPlatformMixin {
  const MaterialHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        return (NavigationBarTabs.hasSingle()
            ? constructScaffold(context, NavigationBarTabs.determineTabBody(0), title(context))
            : constructScaffold(context, NavigationBarTabs.determineTabBody(state.tab), title(context),
                bottomNavigationBar: MaterialNavigationTabSelectorWidget(
                  state.tab,
                  (tab) => BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
                ),
                actions: <Widget>[
                    constructNavigationBarMenu(context),
                  ]));
      },
    );
  }
}
