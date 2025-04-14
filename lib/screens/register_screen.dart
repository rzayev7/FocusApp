import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/features');
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Invalid Form'),
          content: const Text('Please check your inputs.'),
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

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (pickedDate != null) {
      setState(() {
        _birthdayController.text = DateFormat.format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
                  'Fill your information below\nor register with your social account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color(0xFFF5F6FA),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _birthdayController,
                  readOnly: true,
                  onTap: _pickBirthday,
                  decoration: InputDecoration(
                    hintText: 'MM/DD/YYYY',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today_outlined),
                      onPressed: _pickBirthday,
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color(0xFFF5F6FA),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select your birthday';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    labelText: 'Mail',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color(0xFFF5F6FA),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                const SizedBox(height: 20),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color(0xFFF5F6FA),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _signUp,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

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

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // TODO: Apple sign-up logic
                        },
                        child: Image.asset(
                          'assets/images/apple-black-logo.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                        },
                        child: Image.asset(
                          'assets/images/search.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                          // TODO: Facebook sign-up logic
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateFormat {
  DateFormat(String s);

  static String format(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }
  static String formatDate(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }
}
