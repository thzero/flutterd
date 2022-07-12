class ThemeEvent {
  ThemeEvent();
}

class ThemeChangeEvent extends ThemeEvent {
  final int theme;

  ThemeChangeEvent(this.theme);
}
