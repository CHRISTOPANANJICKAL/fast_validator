///[ResultType] is enum which indicated the validation result. The [isValid] [bool] indicated whether the given data
///is valid or not
library;

enum ResultType {
  valid(isValid: true),
  validWithNoValue(isValid: true),
  invalid,
  ;

  final bool isValid;
  const ResultType({this.isValid = false});
}
