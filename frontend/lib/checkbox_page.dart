import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;


  // Page 1: industry-Single selection
  final List<String> industries = [
    "Technology (Software, AI, Hardware)",
    "E-commerce & Retail",
    "Healthcare & Biotech",
    "Cybersecurity",
    "Finance & Fintech",
    "Creative Arts & Media",
    "Food and Beverages",
    "Manufacturing",
    "Professional Services (Consulting, Marketing)",
    "Sustainability & Green Tech",
    "Other"
  ];
  int? selectedIndustry;

  //Page 2: experience-single selection
  final List<String> experiences = [
    "New to startups/First-time founder",
    "Some experience (e.g., worked at a startup, managed a small team)",
    "Experienced entrepreneur/serial founder",
    "Experienced professional transitioning to entrepreneurship"
  ];
  int? selectedExperience;

  //Page 3: stage-single selection
  final List<String> stages = [
    "Just an idea/Concept phase",
    "Early-stage development (e.g., building MVP, market research)",
    "Launched/Operational (e.g., have customers, generating revenue)",
    "Scaling/Growing (e.g., expanding operations, seeking significant investment)",
    "Established business looking to innovate"
  ];
  int? selectedStage;

  //Page 4: planning-single selection
  final List<String> planning = [
    "Within the next 3 months",
    "Within the next 6-12 months",
    "In 1-2 years",
    "More than 2 years from now",
    "Already launched/operational"
  ];
  int? selectedPlanning;

  //Page 5: funding-single selection
  final List<String> funding = [
    "Less than RM 50,000",
    "RM 50,000 - RM 250,000",
    "RM 250,001 - RM 1,000,000",
    "RM 1,000,001 - RM 5,000,000",
    "More than RM 5,000,000",
    "Not actively seeking funding at this moment"
  ];
  int? selectedFunding;

  // Total number of steps for the progress indicator
  final int _totalSteps = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //upload data to firestore
  Future<void> _saveCheckboxDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;

    final data = {
      'industry': industries[selectedIndustry ?? 0],
      'experience': experiences[selectedExperience ?? 0],
      'stage': stages[selectedStage ?? 0],
      'planning': planning[selectedPlanning ?? 0],
      'funding': funding[selectedFunding ?? 0],
      'completedAt': Timestamp.now(),
      'questionnaireCompleted': true,
    };

    await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(data, SetOptions(merge: true)); 
  }

  void _nextPage() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Helper to check if the current step is completed
  bool _isStepCompleted() {
    switch (_currentStep) {
      case 0: return selectedIndustry != null;
      case 1: return selectedExperience != null;
      case 2: return selectedStage != null;
      case 3: return selectedPlanning != null;
      case 4: return selectedFunding != null;
      default: return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  LinearPercentIndicator(
                    percent: (_currentStep + 1) / _totalSteps,
                    lineHeight: 8.0,
                    backgroundColor: Colors.grey.shade200,
                    progressColor: const Color(0xFF005C57),
                    barRadius: const Radius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Step ${_currentStep + 1} of $_totalSteps",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swiping
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  _buildQuestionPage(
                    question: "Which industry best describes your startup or business idea?",
                    options: industries,
                    selectedValue: selectedIndustry,
                    onChanged: (value) => setState(() => selectedIndustry = value),
                  ),
                  _buildQuestionPage(
                    question: "What is your level of experience in the startup or business world?",
                    options: experiences,
                    selectedValue: selectedExperience,
                    onChanged: (value) => setState(() => selectedExperience = value),
                  ),
                  _buildQuestionPage(
                    question: "What best describes the current stage of your startup or business idea?",
                    options: stages,
                    selectedValue: selectedStage,
                    onChanged: (value) => setState(() => selectedStage = value),
                  ),
                  _buildQuestionPage(
                    question: "When are you planning to launch or significantly scale your business?",
                    options: planning,
                    selectedValue: selectedPlanning,
                    onChanged: (value) => setState(() => selectedPlanning = value),
                  ),
                  _buildQuestionPage(
                    question: "What is your estimated funding requirement or target?",
                    options: funding,
                    selectedValue: selectedFunding,
                    onChanged: (value) => setState(() => selectedFunding = value),
                  ),
                ],
              ),
            ),

            _buildFooter(),
          ],
        ),
      ),
    );
  }
  

  Widget _buildQuestionPage({
    required String question,
    required List<String> options,
    required int? selectedValue,
    required ValueChanged<int?> onChanged,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, height: 1.2),
          ),
          const SizedBox(height: 24),
          ...List.generate(options.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: selectedValue == i ? const Color(0xFFCFF5D4) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: selectedValue == i ? const Color(0xFF005C57) : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () => onChanged(i),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectedValue == i,
                          onChanged: (value) => onChanged(i),
                          activeColor: const Color(0xFF005C57),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        Expanded(
                          child: Text(
                            options[i],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    bool isLastStep = _currentStep == _totalSteps - 1;
    bool isCompleted = _isStepCompleted();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          if (_currentStep > 0)
            TextButton(
              onPressed: _previousPage,
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          else
            const SizedBox(), // Empty space to keep "Next" button on the right

          // Next/Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isCompleted ? const Color(0xFF005C57) : Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            onPressed: isCompleted
                ? () async {
                    if (isLastStep) {
                      await _saveCheckboxDataToFirestore();
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      _nextPage();
                    }
                  }
                : null,
            child: Text(
              isLastStep ? "Submit" : "Next",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}