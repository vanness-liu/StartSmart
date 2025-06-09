import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  int _step = 0;

  // Page 1: Single selection
  final List<String> industries = [
    "Agriculture",
    "Banking",
    "Biotech",
    "Cybersecurity",
    "Education",
    "Finance",
    "Food and Beverages",
  ];
  int? selectedIndustry;

  // Page 2: Multiple selection
  final List<String> topics = [
    "Funding",
    "Potential Risks",
    "Market Analysis",
    "Building Key Partnerships",
    "Marketing Strategy",
    "Common Mistakes and Prevention",
  ];
  List<bool> selectedTopics = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: _step == 0 ? _buildIndustryStep() : _buildTopicStep(),
        ),
      ),
    );
  }

  Widget _buildIndustryStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose your industry:",
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
                  ? () => setState(() => _step = 1)
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

  Widget _buildTopicStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Which Topic Are You Interested In?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...List.generate(topics.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => setState(() => selectedTopics[i] = !selectedTopics[i]),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedTopics[i] ? Color(0xFF4EA46A) : Color(0xFF4EA46A),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedTopics[i],
                        onChanged: (val) => setState(() => selectedTopics[i] = val!),
                        activeColor: Color(0xFF005C57),
                      ),
                      Expanded(
                        child: Text(
                          topics[i],
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => setState(() => selectedTopics = List.filled(topics.length, false)),
                  child: const Text(
                    "Clear Selection",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF005C57),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: selectedTopics.contains(true) ? () {} : null,
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EA46A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => setState(() => _step = 0),
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}