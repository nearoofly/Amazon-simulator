import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MaterialApp(
    home: SignUpPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  // Méthode pour sauvegarder les informations dans login.txt
  Future<void> saveDataToFile(String name, String email, String password) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/login.txt');
      final content = 'Name: $name\nEmail: $email\nPassword: $password\n\n';

      await file.writeAsString(content, mode: FileMode.append);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information saved to login.txt')),
      );
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg',
          height: 50,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  saveDataToFile(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  nameController.clear();
                  emailController.clear();
                  passwordController.clear();
                },
                child: const Text(
                  'Create your Amazon account',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
