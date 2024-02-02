import 'package:flutter/material.dart';
import 'package:fast_validator/fast_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController textController;
  String? error;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('User email *', style: TextStyle(fontSize: 32)),
              SizedBox(
                width: 350,
                height: 100,
                child: TextField(
                  controller: textController,
                  style: const TextStyle(fontSize: 32),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.green)),
                  ),
                ),
              ),
              Text(error ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 24)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _validate, child: const Text('Validate')),
      ),
    );
  }

  void _validate() {
    setState(() => error = null); // reset the error message

    String text =
        textController.text.trim(); // extract the text to be validated.

    ValidationResult result = FastValidator.validate(text,
        fieldName: 'Email',
        validators: [
          FastRequiredValidation(),
          FastEmailValidation(customMessage: 'Invalid email')
        ]); // validate

    debugPrint('Result: ${result.result}');
    debugPrint('Valid: ${result.valid}');
    debugPrint('Type: ${result.type}');
    debugPrint('ErrorMsg: ${result.errorMessage}');

    if (!result.valid)
      setState(() => error = result.errorMessage); // update the error message
  }
}
