import 'package:flutter/material.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final Map<String, List<Map<String, String>>> faqCategories = {
  'Getting Started': [
    {
      'question': 'What are beginner-friendly, low-risk startup ideas?',
      'answer': 'Start with reselling, dropshipping, or services like tutoring and freelancing. Low investment, minimal risk.',
    },
    {
      'question': 'How do I start a business with no experience?',
      'answer': 'Begin by learning from free online platforms, take small steps, find a mentor, and validate your idea before investing much.',
    },
    {
      'question': 'Do I need a business plan to start?',
      'answer': 'While not mandatory, a business plan helps clarify your vision, target market, and financial forecast.',
    },
    {
      'question': 'How can students start a side hustle?',
      'answer': 'Start with freelancing, content creation, tutoring, or selling digital products online. Keep it flexible to suit your schedule.',
    },
  ],
  'Legal & Financial Structures': [
    {
      'question': 'What legal structures are available and when is each suitable (e.g., sole prop, partnership, LLP, Sdn Bhd)?',
      'answer': 'Sole proprietorship: Best for solo, low-risk ventures.\nPartnership/LLP: Good for small co-founded service businesses.\nSendirian Berhad (Sdn Bhd): Ideal for startups seeking investors, liability protection, or future scaling.',
    },
    {
      'question': 'What are suitable funding options for startups with limited capital?',
      'answer': 'Bootstrapping: Best for early validation stages.\nGovernment grants: MDEC, SME Corp — ideal for tech or innovation-focused ideas.\nMicroloans: TEKUN, MARA for small B40 businesses.\nAngel investment: Suitable after MVP or early traction.',
    },
    {
      'question': 'What financial tools/practices do you recommend for new startups?',
      'answer': 'Use tools like Google Sheets, QuickBooks, or Wave for budgeting. Track burn rate, set a 3–6 month runway buffer, and monitor cash flow weekly. Include projected vs actual financials.',
    },
    {
      'question': 'What licenses do I need to operate legally?',
      'answer': 'It depends on your industry—food businesses need health permits, e-commerce needs SSM registration in Malaysia.',
    },
  ],
  'Business Operations': [
    {
      'question': 'How do I find my target market?',
      'answer': 'Start by researching who benefits most from your product, analyze competitors, and test with small audiences.',
    },
    {
      'question': 'What tools can help manage my business daily?',
      'answer': 'Use Trello/Notion for planning, Google Workspace for communication, and accounting tools like Wave or QuickBooks.',
    },
    {
      'question': 'Should I hire freelancers or employees?',
      'answer': 'Freelancers are flexible and cost-effective for startups. Hire full-time when workload becomes consistent.',
    },
    {
      'question': 'How can I price my product or service?',
      'answer': 'Calculate cost, research competitors, and find a price that reflects your value while staying competitive.',
    },
  ],
  'Marketing & Growth Strategies': [
    {
      'question': 'How can I scale my business?',
      'answer': 'Automate tasks, expand to new markets, invest in marketing, and build strong partnerships.',
    },
    {
      'question': 'What are effective marketing strategies?',
      'answer': 'Start with social media, email newsletters, SEO, and influencer collaborations to boost visibility.',
    },
    {
      'question': 'How do I get investors or funding?',
      'answer': 'Prepare a strong pitch deck, show traction (users, revenue), and apply to grants or pitch events.',
    },
    {
      'question': 'How to retain customers after first purchase?',
      'answer': 'Provide excellent service, follow up with personalized messages, and offer loyalty rewards or discounts.',
    },
  ],
  'Common Challenges': [
    {
      'question': 'What if I fail in my first business?',
      'answer': 'It’s okay! Most entrepreneurs fail before succeeding. Treat it as a learning experience and try again smarter.',
    },
    {
      'question': 'How to deal with burnout as a founder?',
      'answer': 'Take breaks, delegate tasks, set boundaries, and remember why you started. Your health matters.',
    },
    {
      'question': 'What if my family doesn’t support my startup idea?',
      'answer': 'Focus on proving your concept. Support will come once they see results. Keep communication open.',
    },
    {
      'question': 'How to balance studies and running a startup?',
      'answer': 'Prioritize tasks, use time-blocking, avoid perfectionism, and ask for help when needed.',
    },
  ],
};


  final Map<String, bool> expandedQuestions = {};
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    for (var category in faqCategories.values) {
      for (var item in category) {
        expandedQuestions[item['question']!] = false;
      }
    }
  }

  List<Map<String, String>> getFilteredFaqs() {
    if (searchQuery.isEmpty) return [];
    return faqCategories.values
        .expand((category) => category)
        .where((faq) => faq['question']!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F4),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4EA46A), Color(0xFF005C57)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Center(
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        color: Color(0xFFCFF5D4),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search questions...'
                    .trim(),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
          ),
          Expanded(
            child: searchQuery.isNotEmpty
                ? _buildFaqList('Search Results', getFilteredFaqs())
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: faqCategories.entries
                        .map((entry) => _buildFaqList(
                            entry.key, entry.value))
                        .toList(),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildFaqList(String category, List<Map<String, String>> faqs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF005C57),
            ),
          ),
        ),
        ...faqs.map((faq) {
          final question = faq['question']!;
          final answer = faq['answer']!;
          final isExpanded = expandedQuestions[question]!;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  leading: const Icon(Icons.question_answer,
                      color: Color(0xFF005C57)),
                  title: Text(
                    question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    isExpanded
                        ? Icons.remove_circle_outline
                        : Icons.add_circle_outline,
                    color: const Color(0xFF005C57),
                  ),
                  onTap: () {
                    setState(() {
                      expandedQuestions[question] = !isExpanded;
                    });
                  },
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          );
        })
      ],
    );
  }
}
