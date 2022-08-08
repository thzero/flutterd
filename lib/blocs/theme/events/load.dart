import 'package:flutterd/blocs/theme/events/theme.dart';
import 'package:flutterd/blocs/theme/theme_state.dart';

class LoadThemeEvent extends ThemeEvent {
  final ThemeState state;

  LoadThemeEvent({required this.state});

  @override
  List<Object> get props => [];
}
