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
              const Text('User email *'),
              SizedBox(
                width: 200,
                height: 40,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                    border: OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.green)),
                  ),
                ),
              ),
              Text(error ?? '', style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: _validate, child: const Text('Validate')),
      ),
    );
  }

  void _validate() {
    String text = 'user@gmail..com';

    ValidationResult result = FastValidator.validate(text,
        fieldName: 'Email',
        validators: [FastRequiredValidation(), FastEmailValidation(customMessage: 'Invalid email')]);

    debugPrint('Result: ${result.result}');
    debugPrint('Valid: ${result.valid}');
    debugPrint('Type: ${result.type}');
    debugPrint('ErrorMsg: ${result.errorMessage}');

    if (!result.valid) setState(() => error = result.errorMessage);
  }
}
