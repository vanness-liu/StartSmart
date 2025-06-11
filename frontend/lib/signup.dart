import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//for firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 24,
              color: const Color(0xFF005C57),
            ),
            const SizedBox(height: 32),
            SvgPicture.asset(
              'assets/icons/startsmart.svg',
              height: 80,
            ),
            const SizedBox(height: 32),
            const Text(
              'Create your account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'ex: jon smith',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                  ),
                ),

                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'ex: jon.smith@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      hintText: '********',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005C57),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async{
                        setState(() {
                          _isLoading = true;
                          _error = null;
                        });

                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final confirmPassword = _confirmPasswordController.text.trim();

                        if (password != confirmPassword) {
                          setState(() {
                            _error = "Passwords do not match";
                            _isLoading = false;
                          });
                          return;
                         }

                        try {
                        // Create user in Firebase Auth
                          UserCredential userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(email: email, password: password);

                          // Store name in Firestore under users/{uid}
                          await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({
                            'name': name,
                            'email': email,
                            'createdAt': FieldValue.serverTimestamp(),
                          });

                        // Navigate or show success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Account created successfully')),
                        );

                        // Navigate to login or home page here if needed
                        Navigator.pushReplacementNamed(context, '/login');
                      } catch (e) {
                      setState(() {
                        _error = "Signup failed: ${e.toString()}";
                      });
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  // Show loading indicator or error message
                  const SizedBox(height: 16),
                  if (_isLoading)
                  const CircularProgressIndicator(),
                  if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}