import 'package:equatable/equatable.dart';

class TabState extends Equatable {
  final int tab;

  const TabState(this.tab);

  @override
  List<Object?> get props => [tab];
}
