abstract class SharedPreferencesModel {
  int? theme;

  SharedPreferencesModel fromJson(Map<String, dynamic> json) {
    // var preferences = getInstance();
    // preferences.theme = json['theme'];
    // return preferences;
    theme = json['theme'];
    return this;
  }

  SharedPreferencesModel getInstance();

  Map<String, dynamic> toJson() {
    return {'theme': theme};
  }
}
