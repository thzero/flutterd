import 'package:flutter/widgets.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

abstract class TranslateFormBloc<SuccessResponse, FailureResponse> extends FormBloc<SuccessResponse, FailureResponse> {
  TranslateFormBloc({
    bool autoValidate = true,
    bool isEditing = false,
    bool isLoading = false,
    required BuildContext context,
  }) : super(
            context: context,
            autoValidate: autoValidate,
            isEditing: isEditing,
            isLoading: isLoading,
            translate: (context, error) {
              if (context == null || context is! BuildContext) {
                return 'error!';
              }

              if (error is String) {
                return FlutterI18n.translate(context, error);
              }

              if (error is ValidatorWrapperResults) {
                ValidatorWrapperResults results = error;
                return FlutterI18n.translate(context, results.error, translationParams: results.params);
              }

              return FlutterI18n.translate(context, 'error_unknown');
            });
}
