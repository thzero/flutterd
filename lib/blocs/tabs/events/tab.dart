import 'package:equatable/equatable.dart';

abstract class TabEvent extends Equatable {
  final int tab;

  const TabEvent(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
