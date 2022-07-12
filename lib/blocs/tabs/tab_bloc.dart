import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:thzero_library/blocs/tabs/events/tab.dart';
import 'package:thzero_library/blocs/tabs/events/updated.dart';
import 'package:thzero_library/blocs/tabs/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(const TabState(0)) {
    on<TabUpdated>(_handleUpdate);
  }

  FutureOr<void> _handleUpdate(TabUpdated event, Emitter<TabState> emit) {
    emit(TabState(event.tab));
  }
}
