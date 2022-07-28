import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DecimalValidatorWrapper<Value> extends ValidatorWrapper<Value> {
  late int precision;
  late double max;
  late double min;
}

class LengthValidatorWrapper<Value> extends ValidatorWrapper<Value> {
  late int max;
  late int min;
}

class NumericValidatorWrapper<Value> extends ValidatorWrapper<Value> {
  late int max;
  late int min;
}

class ExpandedFieldBlocValidators {
  ExpandedFieldBlocValidators._();

  static LengthValidatorWrapper<dynamic> length({int min = -999, int max = 999}) {
    LengthValidatorWrapper<String> validator = LengthValidatorWrapper<String>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      LengthValidatorWrapper wrapper2 = wrapper as LengthValidatorWrapper;

      if (value == null) {
        return null;
      }
      if (value.isEmpty) {
        return null;
      }

      if (value is String) {
        return null;
      }
      String string = value as String;
      if (string.runes.length < wrapper2.min) {
        ValidatorWrapperResults results = ValidatorWrapperResults('error_invalid_length_min');
        results.params['min'] = wrapper2.min.toString();
        return results;
        // return 'error_invalid_length_min';
      }
      if (string.runes.length > wrapper2.max) {
        ValidatorWrapperResults results = ValidatorWrapperResults('error_invalid_length_max');
        results.params['max'] = wrapper2.max.toString();
        return results;
        // return 'error_invalid_length_max';
      }

      return null;
    };
    validator.max = max;
    validator.min = min;
    return validator;
  }

  static DecimalValidatorWrapper<String> isDecimal({int precision = 2, double min = -999, double max = 999}) {
    DecimalValidatorWrapper<String> validator = DecimalValidatorWrapper<String>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      DecimalValidatorWrapper wrapper2 = wrapper as DecimalValidatorWrapper;
      return isNumericI(value, true, wrapper2.precision, wrapper2.min, wrapper2.max);
    };
    validator.precision = precision;
    validator.max = max;
    validator.min = min;
    return validator;
  }

  // static String? isDecimal(dynamic value) {
  //   return isNumericI(value, true);
  // }

  static NumericValidatorWrapper<String> isNumeric({int min = -999, int max = 999}) {
    NumericValidatorWrapper<String> validator = NumericValidatorWrapper<String>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      NumericValidatorWrapper wrapper2 = wrapper as NumericValidatorWrapper;
      return isNumericI(value, false, null, wrapper2.min.toDouble(), wrapper2.max.toDouble());
    };
    validator.max = max;
    validator.min = min;
    return validator;
  }

  // static String? isNumeric(dynamic value) {
  //   return isNumericI(value, false);
  // }

  static Object? isNumericI(dynamic value, bool allowDecimal, int? precision, double min, double max) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return null;
    }

    if (allowDecimal) {
      var temp = double.tryParse(value);
      if (temp == null) {
        return 'error_invalid_decimal';
      }

      if (temp < min) {
        ValidatorWrapperResults results = ValidatorWrapperResults('error_invalid_number_min');
        results.params['min'] = min.toString();
        return results;
        // return 'error_invalid_number_min';
      }
      if (temp > max) {
        ValidatorWrapperResults results = ValidatorWrapperResults('error_invalid_number_max');
        results.params['max'] = max.toString();
        return results;
        // return 'error_invalid_number_max';
      }

      return null;
    }

    var temp = int.tryParse(value);
    if (temp == null) {
      return 'error_invalid_number';
    }

    if (temp < min) {
      ValidatorWrapperResults results = ValidatorWrapperResults('error_invalid_number_min');
      results.params['min'] = min.toString();
      return results;
      // return 'error_invalid_number_min';
    }
    if (temp > max) {
      ValidatorWrapperResults results = ValidatorWrapperResults('error_invalid_number_max');
      results.params['max'] = max.toString();
      return results;
      // return 'error_invalid_number_max';
    }

    return null;
  }
}
