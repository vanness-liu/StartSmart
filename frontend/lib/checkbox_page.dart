import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  int _step = 0;


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
  final List<String> experience = [
    "New to startups/First-time founder",
    "Some experience (e.g., worked at a startup, managed a small team)",
    "Experienced entrepreneur/serial founder",
    "Experienced professional transitioning to entrepreneurship"
  ];
  int? selectedExperience;

  //Page 3: stage-single selection
  final List<String> stage = [
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

  //upload data to firestore
  Future<void> _saveCheckboxDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;

    final data = {
      'industry': industries[selectedIndustry ?? 0],
      'experience': experience[selectedExperience ?? 0],
      'stage': stage[selectedStage ?? 0],
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: _getStepWidget(),
        ),
      ),
    );
  }

  Widget _getStepWidget() {
  switch (_step) {
    case 0:
      return _buildIndustryStep();
    case 1:
      return _buildExperienceStep();
    case 2:
      return _buildStageStep();
    case 3:
      return _buildPlanningStep();
    case 4:
      return _buildFundingStep();
    default:
      return _buildIndustryStep(); // fallback
  }
}

  Widget _buildIndustryStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Which industry best describes your startup or business idea?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...List.generate(industries.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => setState(() => selectedIndustry = i),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndustry == i ? Color(0xFF4EA46A) : Color(0xFF4EA46A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedIndustry == i,
                        onChanged: (_) => setState(() => selectedIndustry = i),
                        activeColor: Color(0xFF005C57),
                      ),
                      Expanded(
                        child: Text(
                          industries[i],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Center(
          child:SizedBox(
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndustry != null ? Color(0xFF005C57) : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal:30, vertical: 14),
              ),
              onPressed: selectedIndustry != null
                  ? () => setState(() => _step += 1)
                  : null,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What is your level of experience in the startup or business world?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...List.generate(experience.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => setState(() => selectedExperience = i),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedExperience == i ? Color(0xFF4EA46A) : Color(0xFF4EA46A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedExperience == i,
                        onChanged: (_) => setState(() => selectedExperience = i),
                        activeColor: Color(0xFF005C57),
                      ),
                      Expanded(
                        child: Text(
                          experience[i],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Center(
          child:SizedBox(
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedExperience != null ? Color(0xFF005C57) : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal:30, vertical: 14),
              ),
              onPressed: selectedExperience != null
                  ? () => setState(() => _step += 1)
                  : null,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What best describes the current stage of your startup or business idea?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...List.generate(stage.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => setState(() => selectedStage = i),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedStage == i ? Color(0xFF4EA46A) : Color(0xFF4EA46A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedStage == i,
                        onChanged: (_) => setState(() => selectedStage = i),
                        activeColor: Color(0xFF005C57),
                      ),
                      Expanded(
                        child: Text(
                          stage[i],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Center(
          child:SizedBox(
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedStage!= null ? Color(0xFF005C57) : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal:30, vertical: 14),
              ),
              onPressed: selectedStage != null
                  ? () => setState(() => _step += 1)
                  : null,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanningStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "When are you planning to launch or significantly scale your business?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...List.generate(planning.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => setState(() => selectedPlanning = i),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedPlanning == i ? Color(0xFF4EA46A) : Color(0xFF4EA46A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedPlanning == i,
                        onChanged: (_) => setState(() => selectedPlanning = i),
                        activeColor: Color(0xFF005C57),
                      ),
                      Expanded(
                        child: Text(
                          planning[i],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Center(
          child:SizedBox(
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedPlanning != null ? Color(0xFF005C57) : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal:30, vertical: 14),
              ),
              onPressed: selectedPlanning != null
                  ? () => setState(() => _step += 1)
                  : null,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundingStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What is your estimated funding requirement or target?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...List.generate(funding.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => setState(() => selectedFunding = i),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedFunding == i ? Color(0xFF4EA46A) : Color(0xFF4EA46A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedFunding == i,
                        onChanged: (_) => setState(() => selectedFunding = i),
                        activeColor: Color(0xFF005C57),
                      ),
                      Expanded(
                        child: Text(
                          funding[i],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Center(
          child:SizedBox(
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedFunding != null ? Color(0xFF005C57) : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal:30, vertical: 14),
              ),
              onPressed: selectedFunding!= null
                  ? () async {
                    await _saveCheckboxDataToFirestore(); // Save answers + questionnaireCompleted
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                : null,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}