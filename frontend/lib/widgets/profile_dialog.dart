import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDialog extends StatefulWidget {
  final VoidCallback onLogout;

  const ProfileDialog({
    super.key,
    required this.onLogout,
  });

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  // State to hold user data
  String? _username;
  String? _email;
  String? _photoURL;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    _email = user.email;
    _photoURL = user.photoURL;

    // Get username from Firestore
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        // Assume you have a 'username' field in your users document
        _username = userDoc.data()?['name'] ?? 'No name provided'; 
      }
    } catch (e) {
      _username = "Error loading name";
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            "Profile",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),

          // Display user info or a loading indicator
          if (_isLoading)
            const CircularProgressIndicator(color: Color(0xFF005C57))
          else ...[
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: _photoURL != null ? NetworkImage(_photoURL!) : null,
              child: _photoURL == null
                  ? const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    )
                  : null,
            ),
            _buildProfileInfo(Icons.person, "Username", _username ?? "Not set"),
            const SizedBox(height: 12.0),
            _buildProfileInfo(Icons.email, "Email", _email ?? "No email found"),
          ],

          const SizedBox(height: 24.0),
          
          // "Logout" Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: widget.onLogout,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFE57373),
                side: const BorderSide(color: Color(0xFFE57373), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}