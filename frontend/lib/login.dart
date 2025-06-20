import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'checkbox_page.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      // 1. Trigger the Google authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        setState(() => _isLoading = false);
        return;
      }

      // 2. Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with the credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = userCredential.user!;

      // 5. Check if this is a new user or existing user in Firestore
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        // --- This is a NEW user ---
        // Create their document in Firestore with data from their Google account
        await userDocRef.set({
          'name': user.displayName ?? 'New User',
          'email': user.email,
          'photoURL': user.photoURL, // This is where you get the picture!
          'createdAt': Timestamp.now(),
          'questionnaireCompleted': false, // They haven't done the questionnaire yet
        });
        
        // Navigate them to the questionnaire
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CheckboxPage()),
          );
        }

      } else {
        // --- This is an EXISTING user ---
        // Check if they have completed the questionnaire
        final userData = userDoc.data();
        final hasCompleted = userData != null && userData['questionnaireCompleted'] == true;
        
        if (hasCompleted) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CheckboxPage()),
          );
        }
      }

    } catch (e) {
      setState(() {
        _error = "Failed to sign in with Google. Please try again.";
      });
      print("Google Sign-In Error: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleLogin() async {
    //if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Step 1: Authenticate with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // After successful login
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userData = userDoc.data();
      final hasCompleted = userData != null && userData['questionnaireCompleted'] == true;

      if (hasCompleted) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CheckboxPage()),
        );
      }
      // // Step 2: ALWAYS navigate to the home screen after successful login
      // if (context.mounted) {
      //   Navigator.of(context).pushReplacementNamed('/home');
      // }
    } on FirebaseAuthException catch (e) {
      // Provide more user-friendly error messages
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        _error = 'Invalid email or password. Please try again.';
      } else {
        _error = 'An unexpected error occurred during login.';
      }
      setState(() {});
    } catch (e) {
      setState(() {
        _error = 'Login failed. Please check your connection.';
      });
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
      // The Scaffold's background can be white now, as the Stack will handle colors
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Layer 1: The green background
            // This container acts as the top colored section
            Container(
              height: screenHeight * 0.4, // Occupies the top 40% of the screen
              width: double.infinity,
              color: darkGreen,
            ),

            // Layer 2: All the content (logo, form, etc.)
            Column(
              children: [
                // This SafeArea ensures the logo isn't hidden by the status bar
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

                // This is the white card with the form fields
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
                          'Log in your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
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
                            onPressed: _isLoading ? null : _handleLogin,
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
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("OR", style: TextStyle(color: Colors.grey)),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                        ),

                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : _handleGoogleSignIn,
                          icon: SvgPicture.asset(
                            'assets/icons/google.svg', // Make sure you have this asset
                            height: 24,
                          ),
                          label: const Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
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
                            const Text("Don't have an account? "),
                            TextButton(
                              onPressed:
                                  () => Navigator.pushNamed(context, '/signup'),
                              child: const Text(
                                'SIGN UP',
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
