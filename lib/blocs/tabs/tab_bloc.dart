import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutterd/blocs/tabs/events/tab.dart';
import 'package:flutterd/blocs/tabs/events/updated.dart';
import 'package:flutterd/blocs/tabs/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(const TabState(0)) {
    on<TabUpdated>(_handleUpdate);
  }

  FutureOr<void> _handleUpdate(TabUpdated event, Emitter<TabState> emit) {
    emit(TabState(event.tab));
  }
}
