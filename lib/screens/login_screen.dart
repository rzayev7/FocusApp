import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      // If valid, proceed to next screen or do login logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful (placeholder)")),
      );
    } else {
      // If invalid, show an alert or a message
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Invalid Form'),
          content: const Text('Please fix the errors before logging in.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: const Color.fromARGB(255, 37, 35, 83),
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'Hi! Welcome',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color(0xFFF5F6FA), // Light purple/gray fill
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color(0xFFF5F6FA),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _onLoginPressed,
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height:16),

                TextButton(
                  onPressed: () {
                    // TODO: forgotten password action here
                  },
                  child: Text(
                    'Forgotten your password ?',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 37, 35, 83),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider with "Or sign in with"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[400])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or sign in with',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[400])),
                  ],
                ),
                const SizedBox(height: 16),

                // Social Login Images Row with extra margin
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 56.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Image.asset(
                          'assets/images/apple-black-logo.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                        },
                        child: Image.asset(
                          'assets/images/search.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // "Don't have an account? Create an Account"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
