abstract class SharedPreferencesModel {
  int? theme;

  SharedPreferencesModel fromJson(Map<String, dynamic> json) {
    theme = json['theme'];
    return this;
  }

  SharedPreferencesModel getInstance();

  Map<String, dynamic> toJson() {
    return {'theme': theme};
  }
}
