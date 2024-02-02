
# Fast Validator

A flutter package to validate text fields, date fields or any data fastly. The package contains a list of built in commonly used validators. You can also add custom validators for your needs.

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://pub.dev/packages/fast_validator)
[![pub](https://img.shields.io/pub/v/fast_cached_network_image)](https://pub.dev/packages/fast_validator)
[![dart](https://img.shields.io/badge/dart-pure%20dart-success)](https://pub.dev/packages/fast_validator)

## Screenshots

**Validating an email id**
![Error Example in UI](https://raw.githubusercontent.com/CHRISTOPANANJICKAL/fast_validator/main/images/error.png)


**Validating the email id "user@gmail.com" (valid)**
![Valid Example](https://raw.githubusercontent.com/CHRISTOPANANJICKAL/fast_validator/main/images/example.png)

**Validating the email id "user@gmail..com" (invalid because contains '..')**
![Invalid Example](https://raw.githubusercontent.com/CHRISTOPANANJICKAL/fast_validator/main/images/example_invalid.png)

## Usage
Import it
```dart
import 'package:fast_validator/fast_validator.dart';
```
Use the default validator function to validate anything.

```dart
ValidationResult result = FastValidator.validate(text,fieldName: 'Username',validators: [FastRequiredValidation()]);
```
The **ValidationResult/ValidationAllResult** class will contain the below details.


| Variable | Type                           | Description                                                                                                                                                                                                                                                |
|----------|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| valid    | bool                           | indicates whether the given data have passed all the given validations                                                                                                                                                                                     |
| errorMessage    | String                         | The error message after validation. This will be null if the data is valid                                                                                                                                                                                 |
| allErrorMessage    | List<String>                   | list of errors after validating all validators given to the validate function (only available with FastValidator.validateAll())                                                                                                                    |
| type    | ResultType                     | An enum indicating the validation result status, like valid, invalid, validWithNoValue. ValidWithNoValue indicates the filed was valid but did not contain any data. This can be useful if you are trying to validate any filed which is not a required one |
| result    | Same as the type of input data | the same data given as input to the validation function                                                                                                                                                                                                    |



The **FastValidator.validate** function has three arguments.
First parameter is the data to be validated. This can be of any type such as String, int, List etc.

The **fieldName** is the name of the filed which you are validating. This is just to make a meaningful validation message.
For example if you give the filedName as 'Username', then the default validation error message will be 'Username is required'.
If you provide fieldName as 'XYZ', then the default validation error message will be 'XYZ is required'.

The **validators** parameter is the list of validations to be done on the given data.
These validations are done in the order in which they are kept in the list. For example, if  you give the list as validators: [FastRequiredValidation(), FastEmailValidation()], then the FastRequiredValidation() validation will be executed first. If that validation is passed then the FastEmailValidation() will be executed.

Use
```dart
  ValidationResult result = FastValidator.validate(
  text,
  fieldName: 'Sample field name',
  validators: [FastRequiredValidation(), FastMaxLengthValidation(maxLength: 12)],
);
```
if you want to get the first error at which the validation failed. **FastValidator.validate()** will be returning the error result
**immediately** if any of the validations in the list fails. The rest of the validations in the list will not be executed. Hence the error message will be a 'String'.

Use
```dart
    ValidationAllResult result = FastValidator.validateAll(
  text,
  fieldName: 'Sample field name',
  validators: [FastRequiredValidation(), FastMinLengthValidation(minLength: 12)],
);
```
if you want to get the all the errors from the list of validations given. **FastValidator.validateAll()** function will be returning a list of errors after executing all the given validations in the list.

## Build in validators
The below given are the ready-made validators you can use. Most of the validators will have optional arguments to customize the validation.  

| Validator                  | Description              |
|----------------------------|--------------------------|
| FastRequiredValidation()   | used to do required validation on a filed. Null and empty fields are also considered as invalid |
| FastMinLengthValidation()  | used to validate minimum length of a string |
| FastMaxLengthValidation()  | used to validate maximum length of a string|
| FastExactLengthValidation() | used to validate exact length of a string|
| FastMinValueValidation()   | used to validate minimum value of a number|
| FastMaxValueValidation()   | used to validate maximum value of a number |
| FastExactValueValidation()  | used to validate exact value of given data|
| FastTypeValidation()  | used to validate the datatype of given data |
| FastEmailValidation()    | used to validate an email|
| FastUrlValidation()    | used to validate an URL  |
| FastDigitsOnlyValidation()    |used to validate whether a string contains numbers alone |
| FastAlphabetsOnlyValidation()    | used to validate whether a string contains alphabets alone |
| FastAlphaNumericOnlyValidation()    | used to validate whether a string contains alphabets and numbers alone |
| FastAllowedCharactersValidation()    | used to validate whether a string contains the allowed characters alone |
| FastRegexValidation()    | used to validate a String against a RegExp |
| FastPasswordValidation()    | used to validate a password field |
| FastDateValidation()    | used to validate a date field |
| FastCreditCardValidation()    | used to validate a credit card number using Luhn's algorithm |
| FastGSTNumberValidation()    | used to validate a GST number |

## Custom validator

You can create your own validators and can even use them along with the build in validations.
To create a custom validator, create a class and extend it with FastValidation class as shown in the below example.

```dart
class MyCustomValidator extends FastValidation {
final String? errorMessage; // Optional error message
MyCustomValidator({this.errorMessage});

@override
validate<T>(T toValidate, String? fieldName) {
String? error;
bool valid = true;
ResultType outputType = ResultType.valid; // setting the default value to valid

// the main validation  condition. In this example we are just checking whether the input data is a String or not.
    if (toValidate.runtimeType != String) {  
      error = errorMessage ?? 'This filed must be a string';
      valid = false;
      outputType = ResultType.invalid;
    }

    return ValidationResult<T>(
      errorMessage: error,
      type: outputType,
      valid: valid,
      result: toValidate,
    );
}
}
```
And now you can use this in the FastValidator.validate() function as shown below.

```dart
    ValidationResult result = FastValidator.validate(
      50,
      fieldName: null,
      validators: [MyCustomValidator()],
    );

    debugPrint('Result: ${result.result}');
    debugPrint('Valid: ${result.valid}');
    debugPrint('Type: ${result.type}');
    debugPrint('ErrorMsg: ${result.errorMessage}');
```
## Usage in TextFormField
You can use the **FastValidator.validate()** function directly with the TextFormFiled widget as shown below.
```dart
    TextFormField(
    controller: textController,
    decoration: const InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
    border: OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.green)),
    ),
    validator: (String? text) {
    ValidationResult result = FastValidator.validate(text?.trim(),
    fieldName: 'Personal email', validators: [FastRequiredValidation(), FastEmailValidation()]);

    return result.errorMessage;
    },
    )
```

Feel free to contribute and support.

## Contributors 🤝

Big thanks go to these wonderful people:

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/CHRISTOPANANJICKAL"><img src="https://avatars.githubusercontent.com/u/58786637?v=4" width="100px;" alt=""/><br /><sub><b>Author: Christo Pananjickal</b></sub></a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->




## Package on pub.dev

[fast_validator](https://pub.dev/packages/fast_validator)