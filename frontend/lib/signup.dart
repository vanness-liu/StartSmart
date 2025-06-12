import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Future<void> _handleSignUp() async {
    if (_isLoading) return;

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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': name,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please log in.'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on FirebaseAuthException catch (e) {
      _error = 'Signup failed: ${e.message}';
    } catch (e) {
      _error = 'An unexpected error occurred.';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF005C57);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: double.infinity,
              color: darkGreen,
            ),
            Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                    child: SvgPicture.asset(
                      'assets/icons/startsmart.svg',
                      height: 80,
                      colorFilter: const ColorFilter.mode(
                        Colors.white70,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Create your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _nameController,
                          cursorColor: Color(0xFF005C57),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            floatingLabelStyle: TextStyle(
                              color: Color(
                                0xFF005C57,
                              ), 
                              fontWeight: FontWeight.bold,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey, 
                            ),
                            hintText: 'ex: Jon Smith',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFF005C57), 
                                width: 2.0,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          cursorColor: Color(0xFF005C57),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            floatingLabelStyle: TextStyle(
                              color: Color(
                                0xFF005C57,
                              ), 
                              fontWeight: FontWeight.bold,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey, 
                            ),
                            hintText: 'ex: jon.smith@email.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFF005C57), 
                                width: 2.0,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          cursorColor: Color(0xFF005C57),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '********',
                            floatingLabelStyle: TextStyle(
                              color: Color(
                                0xFF005C57,
                              ), 
                              fontWeight: FontWeight.bold,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey, 
                            ),
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
                          cursorColor: Color(0xFF005C57),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: '********',
                            floatingLabelStyle: TextStyle(
                              color: Color(
                                0xFF005C57,
                              ), 
                              fontWeight: FontWeight.bold,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey, 
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFF005C57), 
                                width: 2.0,
                              ),
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
                              backgroundColor: darkGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _isLoading ? null : _handleSignUp,
                            child:
                                _isLoading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                          ),
                        ),
                        if (_error != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              _error!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'LOG IN',
                                style: TextStyle(
                                  color: Color(0xFF4EA46A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
