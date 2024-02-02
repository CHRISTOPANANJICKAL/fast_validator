import 'result_type.dart';

/// [ValidationResult] is the response model of a validation function.
/// [errorMessage] is the error message after validation. [errorMessage] will be null if the data is valid.
/// [valid] is a [bool] indicating whether the filed is valid or not.
/// [result] is the same data given as input to the validation function.

class ValidationResult<T> {
  ValidationResult({
    required this.errorMessage,
    required this.type,
    required this.valid,
    required this.result,
  });

  String? errorMessage;
  ResultType type;
  bool valid;
  T result;
}

/// [ValidationAllResult] is the response model of validateAll function.
/// [valid] is a [bool] indicating whether the filed is valid or not.
/// [result] is the same data given as input to the validation function.
/// [allErrorMessage] is the list of errors after validating all conditions in given to a validator function.
class ValidationAllResult<T> {
  ValidationAllResult({
    required this.type,
    required this.valid,
    required this.result,
    required this.allErrorMessage,
  });

  ResultType type;
  bool valid;
  T result;
  List<ValidationResult> allErrorMessage;
}
