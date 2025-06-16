# services/knowledge_base.py

# This file contains the complete, categorized knowledge bases derived from the
# original 132 rules. The rules are separated into 'strategic' and 'procedural'
# to power the Query Router architecture. All critical concepts have been retained.

# --- STRATEGIC KNOWLEDGE BASE ---
# For open-ended, advisory questions (e.g., "Is my idea good?", "What should I do?").
STRATEGIC_KB = [
    # --- Theme: Idea Viability, Competitiveness & Market Positioning ---
    {
        'if': "a user is unsure about their competitiveness in the market",
        'then': "You should perform a SWOT analysis (Strengths, Weaknesses, Opportunities, Threats) and identify at least 3 direct competitors to benchmark their products, pricing, and value propositions. This will help you find your unique advantage."
    },
    {
        'if': "a user is unsure if their business idea is strong enough or has a good value proposition",
        'then': "A strong business idea offers something new or better than existing solutions and addresses a real, significant customer need. If it lacks uniqueness or doesn't solve a real problem, it is not considered viable."
    },
    {
        'if': "a user wants to know if their idea is ready for investment",
        'then': "Your idea is generally considered ready for investment if it has a strong value proposition, multiple clear revenue streams, and a high speed-to-market because the product is already tested and validated with real users."
    },
    {
        'if': "a user wants to know if their product is commercially viable",
        'then': "If your product is still just an idea or in the early concept stage, its commercialization potential is low. Your immediate focus must be on testing and validating the concept. If it has been tested and validated with users, it has a high commercialization potential."
    },
    {
        'if': "a user is asking about their business model's scalability",
        'then': "You should reconsider your model if it is not scalable. Look for options that allow growth with fewer added costs, as this is critical for long-term success."
    },
    {
        'if': "a user wants to start with the most profitable customer segment",
        'then': "If you know which customer segment is most profitable, you should focus all your initial efforts on serving that manageable segment first before expanding."
    },
    {
        'if': "a user wants to decide on a pricing strategy based on product cost",
        'then': "Your pricing must be sustainable. If your production cost is high, do not set the price too low. If your cost is low, you can set a price with a higher markup to increase your profit margin."
    },
    {
        'if': "a user wants to decide on a pricing strategy based on product value",
        'then': "If your product offers strong, unique advantages, you can confidently set a higher, value-based price. If your brand is already strong and credible, you can also enter the market with premium pricing."
    },
    {
        'if': "a user's product is similar to competitors' offerings",
        'then': "You should avoid setting the price too far above or below the existing market rate. Research competitor pricing carefully and position yourself competitively within that range."
    },
    {
        'if': "a user's product targets underserved communities or they have government support",
        'then': "If your product targets low-income communities, you should explore possibilities for government subsidies. If you are able to get a subsidy, you should lower your product price to increase accessibility and expand your customer base."
    },
    {
        'if': "a user wants their startup to have a social impact",
        'then': "If your business can solve both a market need and a social issue, such as empowering marginalized communities, it achieves both sustainability and impact, making it more valuable and attractive to funders."
    },
    
    # --- Theme: Business Model Types & Implications ---
    {
        'if': "a user's target customer is businesses",
        'then': "Your business model is B2B (Business-to-Business). You should expect longer sales cycles, formal contracts, and larger order volumes. Focus on building professional relationships and demonstrating clear ROI to business clients."
    },
    {
        'if': "a user's target customer is individual consumers",
        'then': "Your business model is B2C (Business-to-Consumer). You should focus on marketing appeal, customer experience, and handling many smaller transactions efficiently."
    },
    {
        'if': "a user's delivery method involves recurring payments or services",
        'then': "Your business model is Subscription-based. You must deliver consistent value over time and focus heavily on customer retention, as losing subscribers directly impacts your revenue stream."
    },
    {
        'if': "a user's platform connects buyers and sellers",
        'then': "Your business model is a Marketplace. You'll need to manage a reliable platform, build trust among users, and typically earn through transaction fees or listing fees."
    },

    # --- Theme: Founder Readiness, Mindset & Common Mistakes ---
    {
        'if': "a user is uncertain if they are ready to start a business or underestimating entrepreneurial challenges",
        'then': "You need to reflect on your personal goals, your willingness to take significant financial and personal risks, and your ability to handle high levels of pressure and stress. Be aware of the most common entrepreneurial challenges: potential financial instability, major sacrifices to your personal life and free time, and significant mental stress. Create a personal readiness checklist to ensure you are committed."
    },
    {
        'if': "a user has acknowledged the sacrifices involved in starting a business",
        'then': "To confirm your readiness, you should create a personal readiness checklist to assess your long-term commitment and ensure you are prepared for the journey ahead."
    },
    {
    'if': "a user is planning to run their business completely solo",
    'then': "Starting solo is perfectly fine if you have the necessary skills to handle all critical aspects of your business. However, be aware of the high risks of founder isolation and burnout. Only bring on a co-founder if they have essential skills you lack (e.g., a technical co-founder for a tech startup), because a bad partnership is worse than no partnership. At minimum, consider finding at least one reliable advisor or mentor to share the burden and provide guidance."
    },
    {
        'if': "a user is thinking of quitting their studies to work on their startup",
        'then': "It is highly recommended to validate your business as a side project first. Use your weekends and free time to test your idea and get your first customers. This approach significantly lowers your personal and financial risk and allows you to complete your education, which is a valuable asset."
    },
    {
        'if': "a user is eager to expand their business quickly after some initial success",
        'then': "You should first conduct a SWOT analysis (Strengths, Weaknesses, Opportunities, Threats) to ensure your growth is strategic and sustainable, not just based on excitement."
    },
    {
        'if': "a user is considering a significant investment to scale up their business",
        'then': "You must first validate the market demand at a larger scale with a pilot program or a limited launch before committing large sums of money."
    },
    {
        'if': "a user is making business decisions based on assumptions",
        'then': "You should always gather real-world data to validate your assumptions. The best way to do this is by talking to at least 10 potential customers or analyzing competitor performance."
    },
    {
        'if': "a user has not validated their product-market fit",
        'then': "You must seek expert help to validate your idea. Make sure it solves a real, proven problem using evidence like statistics, reports, or customer interviews before proceeding with major investments."
    },
    {
        'if': "a user is spending early on marketing or hiring before validation",
        'then': "Be careful. In the early stage, prioritize product development and validating your idea over heavy spending on marketing or hiring. Prove demand first."
    },

    # --- Theme: Team Building & Partnerships ---
    {
        'if': "a user is deciding whether to include someone in their team",
        'then': "You should not include a potential team member if they cannot contribute meaningfully to your business model, even if you trust them personally. Skills and contribution come first."
    },
    {
        'if': "a user is looking for a technical co-founder or partner",
        'then': "If you have a business background but lack technical knowledge, you should actively seek a partner who can provide those skills, such as coding, or has access to key resources like software or databases."
    },
    {
        'if': "a user is forming their founding team",
        'then': "When forming your startup team, you must ensure it includes a mix of not only technical experts but also people with strong management and marketing skills."
    },
    {
        'if': "a user is unsure about the benefits of having partners",
        'then': "You should understand that strong partners are key to sustainability. They help by sharing the workload, reducing operational costs through their resources, and opening doors you couldn't open alone."
    },
    {
        'if': "a user has technical knowledge but lacks funding",
        'then': "You should leverage your expertise by reaching out to potential industry partners who may be willing to offer funding or resources in exchange for your technical skills."
    },
    {
        'if': "a user is developing a high-cost or highly technical product",
        'then': "You should prioritize forming strategic partnerships with organizations that can provide licensing support, access to expensive technical tools, or connections to relevant government bodies."
    },
    {
        'if': "a user wants to get noticed by the government or big organizations",
        'then': "You should actively seek endorsements or partnerships with credible institutions like your university's entrepreneurship center, MaGIC, or MDEC to build trust and visibility effectively."
    },

    # --- Theme: Launch Timing & Market Conditions ---
    {
        'if': "a user is wondering if it's a good time to enter the market",
        'then': "If the economic situation is favorable and stable, it is generally a good time to enter the market. Also consider if there is rising consumer demand and government support for your industry."
    },
    {
        'if': "a user is worried about launching during a crisis or period of instability",
        'then': "You should avoid launching during periods of political or economic instability, as this increases startup risk. The only exception is if your product directly solves a problem caused by the crisis."
    },
    {
        'if': "a user's technology is not yet ready for the market",
        'then': "You should delay your launch until the technology is more mature or accessible, as launching with unready tech can damage your reputation."
    },
    {
        'if': "a user is wondering if it's a good time to launch based on non-economic factors",
        'then': "It's a good time to launch if there is government support for your industry. However, you should delay your launch if your core technology is not yet mature or accessible."
    },
    {
        'if': "a user wants to know the ideal conditions for launching a startup",
        'then': "The ideal time to launch is when the economy is stable, consumer purchasing power is high, and you have clear evidence of market demand for your product with minimal competition."
    },

    # --- Theme: Common Startup Misconceptions ---
    {
        'if': "a user believes that a large amount of capital is required to start a business",
        'then': "You should understand that startups can begin with minimal capital and grow gradually. Focus on low-cost models and bootstrapping first."
    },
    {
        'if': "a user thinks they must form a partnership before launching their business",
        'then': "You can start with a solo or a small, trusted team in the early stages. A formal partnership is not always necessary from day one."
    },
    {
        'if': "a user wants to create a product before identifying a real problem to solve",
        'then': "You should focus on identifying real community needs first to ensure your product provides genuine added value. A great product that solves no problem will fail."
    },
    {
        'if': "a user assumes that marketing must be outsourced to experts",
        'then': "You should know that self-managed marketing can be very effective and is a skill you can learn over time. It also helps you stay closer to your customers."
    },
    
    # --- Theme: Overwhelm and Progress Tracking ---
    {
        'if': "a user is feeling overwhelmed with information or tasks",
        'then': "To manage feeling overwhelmed, use a dashboard or a simple to-do list to track your progress. Focus on completing only one critical task at a time, such as validating your idea this week, before moving on to the next."
    }
]

# --- PROCEDURAL KNOWLEDGE BASE ---
# For direct, factual, "how-to" questions (e.g., "How do I register?", "What is an LLP?").
PROCEDURAL_KB = [
    # --- Theme: Business Planning & Validation Procedures ---
    {
        'if': "a user wants to know how to validate their business idea",
        'then': "To validate your idea, first conduct 10-15 'customer discovery' interviews with your target audience to understand their problems. Based on their feedback, create a Minimum Viable Product (MVP)—the simplest version of your product—and test it with a small group of users to see if they will actually use it."
    },
    {
        'if': "a user wants to know how to structure their business idea",
        'then': "To structure your business idea professionally, you should complete a Business Model Canvas (BMC). This will help you map out your key activities, customer segments, value proposition, and revenue streams all on a single page."
    },
    {
        'if': "a user needs to estimate their market size",
        'then': "To estimate your market size, use the 'Three-Scope Projection' model: estimate the Total Available Market (TAM), then your Serviceable Available Market (SAM), and finally your realistic Serviceable Obtainable Market (SOM). You must be prepared to justify your numbers with clear logic and supporting research."
    },
    {
        'if': "a user wants to know how to analyze their competition",
        'then': "To analyze your competition, you must identify at least 3 direct competitors and research their products, pricing, marketing strategies, and customer reviews to find weaknesses you can exploit or strengths you can learn from."
    },
    {
        'if': "a user wants a framework to define their product's value",
        'then': "To define your product's value and help it stand out, use the FAB (Features, Advantages, Benefits) framework. For every feature, define its advantage, and then explain the tangible benefit it provides to the customer."
    },
    {
        'if': "a user wants to know how to perform a SWOT analysis",
        'then': "To perform a SWOT analysis, create four categories: Strengths (your internal advantages), Weaknesses (your internal limitations), Opportunities (external factors you can exploit), and Threats (external risks you face). List at least 3-5 items in each category and use this analysis to make strategic decisions."
    },

    # --- Theme: Legal & Registration Procedures ---
    {
        'if': "a user is asking for a step-by-step checklist on how to start their first business",
        'then': "For your first business, follow this checklist: 1) Choose a business name and check availability, 2) Select your business structure (Sole Proprietorship, Partnership, LLP, or Sdn Bhd), 3) Register with SSM via EzBiz portal, 4) Apply for necessary licenses if your business is regulated, 5) Register for tax with LHDN, 6) Open a business bank account. It's wise to consult with a business registration expert for guidance."
    },
    {
        'if': "a user is confused about how to register their business in Malaysia",
        'then': "To register your business, you can follow the step-by-step instructions available on the Suruhanjaya Syarikat Malaysia (SSM) website via their EzBiz portal. For direct help, contact local business registration assistance agencies."
    },
    {
        'if': "a user is working with a team and needs to formalize it",
        'then': "If you are working with a team, you must always register the business legally (e.g., as a Partnership or LLP) to formally define each person's roles, responsibilities, and how profits will be shared. This prevents serious conflicts later on."
    },
    {
        'if': "a user wants to know what a Sole Proprietorship is",
        'then': "A Sole Proprietorship is the simplest business structure for a single owner. It is easy to set up, but it does not separate your personal assets from the business, meaning you are personally liable for all business debts."
    },
    {
        'if': "a user wants to know what a Partnership is",
        'then': "A Partnership is a business structure for two or more individuals who share ownership, responsibilities, and profits. It's flexible and supportive for young teams but usually involves shared personal liability for all partners."
    },
    {
        'if': "a user wants to know what an LLP is",
        'then': "An LLP (Limited Liability Partnership) is a business structure that combines the flexibility of a partnership with the benefit of limited liability, meaning your personal assets are protected from business debts. It has fewer formalities than a Sendirian Berhad."
    },
    {
        'if': "a user wants to know what a Sendirian Berhad (Sdn. Bhd.) is",
        'then': "A Sendirian Berhad (Sdn. Bhd.) is a private limited company that offers the strongest protection for personal assets by strictly limiting liability to the company. It is suitable for startups that plan to scale and seek major investment, but it comes with more legal and regulatory formalities."
    },
    {
        'if': "a user wants to know what different business legal structures mean",
        'then': "A Sole Proprietorship is for one owner with full personal liability. A Partnership is for two or more owners who share liability. A Limited Liability Partnership (LLP) and Sendirian Berhad (Sdn. Bhd.) protect your personal assets from business debt, but have more formal requirements."
    },
    {
        'if': "a user needs to protect their intellectual property like an idea, brand, or software",
        'then': "To protect your intellectual property in Malaysia, you must register it with MyIPO. You can file for a Trademark for your brand name/logo, a Copyright for creative or software work, or a Patent for a unique invention."
    },
    {
        'if': "a user's business involves regulated products like food, cosmetics, or agriculture",
        'then': "You must identify and secure the specific licenses required for your products. For example, consult Malaysia's National Pharmaceutical Regulatory Agency (NPRA) for cosmetics, the Food Safety and Quality Division (BKKM) for food products, and the relevant agricultural authorities for farming-related businesses."
    },
    {
        'if': "a user is using B2C platforms like Taobao for sourcing products",
        'then': "You must understand the differences between personal and commercial import rules. When sourcing for business, even small quantities may require commercial import procedures, customs declarations, and proper documentation. Personal import rules don't apply to business sourcing."
    },
    {
        'if': "a user is importing goods for their business",
        'then': "For business imports, you must follow commercial import rules, not personal ones, even when using platforms like Taobao. For bulk imports, you need to handle customs declarations and check for SIRIM/DVS/MITI requirements. It is highly recommended to hire a licensed customs agent."
    },
    {
        'if': "a user plans to import goods during a crisis or shortage",
        'then': "During a crisis, you must first verify if the product you are importing requires special emergency permits. Check with the relevant ministry for specific emergency importation guidelines before placing any orders."
    },
    {
        'if': "a user needs advice on choosing the right legal structure",
        'then': "You should consult a legal advisor to help you pick the right structure (e.g., Partnership, LLP, Sdn Bhd) to protect your interests and ensure you comply with all local laws."
    },

    # --- Theme: Funding & Financial Procedures ---
    {
        'if': "a user needs to estimate their startup costs",
        'then': "You must perform a detailed financial assessment before you start. Create a list of all expected one-time and recurring costs, including registration fees, licensing, inventory, software, and your first few months of operational expenses."
    },
    {
        'if': "a user wants to know how to fund their business using bootstrapping",
        'then': "To bootstrap, you should use your personal savings or small, informal loans from family and friends. It requires strong discipline in managing money and is a good first step if you are not yet ready for formal funding."
    },
    {
        'if': "a user wants to know how to apply for government grants",
        'then': "To get government grants, you should focus on developing a socially impactful or innovative idea. Participating and winning in startup competitions can greatly strengthen your grant applications and provide public pitching practice."
    },
    {
        'if': "a user wants to know about startup competitions and their benefits",
        'then': "Startup competitions are not just about winning money - they provide opportunities to gain visibility, receive valuable feedback from judges, network with other entrepreneurs, and pitch to potential investors. Even if you don't win, the experience and connections can be invaluable for your startup journey."
    },
    {
        'if': "a user wants to know how to get a business loan without collateral",
        'then': "If you have no collateral or a poor credit history, you should apply for funding through a government-guaranteed development bank. They often provide lower-risk loans with low interest rates and no collateral requirements."
    },
    {
        'if': "a user wants to know how to manage their business finances",
        'then': "You must start tracking your cash flow closely using simple tools like Excel or Google Sheets to plan your budget and forecast revenue. As you grow, you can move to accounting software like Wave, QuickBooks, or Xero."
    },
    {
        'if': "a user needs advice on their funding strategy",
        'then': "You should get advice on your funding options from a mentor or advisor. Depending on your business type, a mix of bootstrapping, grants, competitions, or micro-loans may be the most suitable strategy."
    },
    {
        'if': "a user's financial runway is less than 6 months",
        'then': "You must talk to a financial advisor or mentor immediately to find ways to extend your runway, either by cutting costs or securing new funding."
    },

    # --- Theme: Marketing & Sales Procedures ---
    {
        'if': "a user wants to know how to do marketing with a limited budget",
        'then': "To market with a limited budget, focus on organic SEO (Search Engine Optimization) to get your website found on Google, and create engaging content on 1-2 social media platforms where your target audience is most active. Make sure to engage directly with your first 100 users to build a strong community."
    },
    {
        'if': "a user is not a marketing expert and wants to learn",
        'then': "Focus on organic marketing strategies you can learn over time. Create useful content on one or two social media platforms your customers use, learn basic SEO for your website, and engage directly with your first 100 users to understand their needs and build relationships."
    },
    {
        'if': "a user wants to know how to use social media for marketing",
        'then': "To use social media effectively, limit your efforts to 2-3 platforms where your target audience is most active. Use relevant hashtags in your posts to increase your reach and engagement."
    },
    {
        'if': "a user wants to know how to increase sales from each customer",
        'then': "To increase sales per customer, you can apply three techniques: 'upselling' (recommending a higher-tier product), 'cross-selling' (suggesting complementary products), and 'next-selling' (offering future discounts)."
    },
    {
        'if': "a user is looking for ways to monetize their app or website",
        'then': "To make extra money with your app or website, you can integrate affiliate marketing links from platforms like Shopee, Lazada, or Involve Asia. When a user clicks a link from your site and makes a purchase, you earn a small commission."
    },

    # --- Theme: Team, Networking & Pitching Procedures ---
    {
        'if': "a user needs advice on building their founding team",
        'then': "You should seek advice on team building to ensure you choose co-founders who balance your weaknesses and share your vision. A complementary team is crucial for success."
    },
    {
        'if': "a user wants to know how to improve their pitching skills",
        'then': "You should seek out pitch training or join practice sessions. A strong pitch is clearly structured around the problem you're solving, your unique solution, the benefits for the customer, and any traction or validation you have achieved so far."
    },
    {
        'if': "a user needs to build industry contacts",
        'then': "To build your network, you should attend industry expos, join professional associations, and actively leverage your university's alumni and faculty networks."
    },
    {
        'if': "a user wants to know how to keep customers happy",
        'then': "To keep your customers happy, you should set up a simple, reliable customer service channel, such as a dedicated email or WhatsApp number, and make sure to respond to all inquiries within 24 hours to build a reputation for great support."
    },
    {
        'if': "a user lacks industry experience, needs guidance, or is looking for a mentor",
        'then': "To get expert help, you should first check with your university's entrepreneurship center for available mentorship programs. Additionally, you can use this app's 'Mentor Booking' feature to browse and connect with vetted industry experts."
    }
]

# knowledge_base = [
#     "IF the entrepreneur is starting a business for the first time, THEN recommend a checklist of legal procedures and suggest consultation with a business registration expert.",
#     "IF the business involves regulated products (e.g., agriculture, food, cosmetics, or imported goods), THEN identify the specific licenses or approvals required and guide them to the relevant authorities.",
#     "IF the entrepreneur expresses confusion about business registration, THEN provide step-by-step instructions and local agency contacts for registration assistance.",
#     "IF the entrepreneur plans to import goods during a crisis or shortage (e.g., PPE during COVID-19), THEN verify if the product requires special permits and direct them to emergency importation guidelines.",
#     "IF the entrepreneur uses B2C platforms (e.g., Taobao) for sourcing products, THEN alert them to the differences between personal and commercial import rules.",
#     "IF the entrepreneur is importing in bulk, THEN recommend customs declaration processes, SIRIM/DVS/MITI requirements (if in Malaysia), and suggest hiring a licensed customs agent.",
#     "IF a user is asking how to start a business with limited capital, a small budget, or as a student with no money, THEN first, choose a low-cost business model like providing a service, selling digital products, or dropshipping to keep initial expenses low. Your main strategy should be bootstrapping—using your personal savings carefully and avoiding non-essential costs. At the same time, you must actively apply for government grants designed for students from agencies like Cradle and MaGIC, as this is funding you don't have to pay back.",
#     "IF the entrepreneur has not estimated startup and compliance costs, THEN prompt a financial assessment including registration fees, licensing, inventory, and operational costs.",
#     "IF the entrepreneur seeks funding, THEN recommend funding options such as government grants, microloans, or angel investors.",
#     "IF a user is unsure if their business idea is viable, will solve a real problem, or if customers will actually pay for it, THEN to validate your idea, start by conducting at least 10 'customer discovery' interviews with your target audience to understand their problems before you mention your solution. Based on their feedback, create a Minimum Viable Product (MVP)—the simplest version of your product that solves their core problem. Finally, test this MVP with a small group of users to see if they will actually use it and would be willing to pay.",
#     "IF the entrepreneur is unsure about their competitiveness, THEN suggest performing a SWOT analysis (Strengths, Weaknesses, Opportunities, Threats) and competitive benchmarking.",
#     "IF the entrepreneur has not studied competitors, THEN prompt them to identify at least 3 direct competitors and analyze their offerings, pricing, and value propositions.",
#     "IF the entrepreneur is looking for funding opportunities, THEN suggest exploring innovation grants, government schemes, and startup competitions.",
#     "IF the entrepreneur considers entering competitions, THEN advise them that competitions are also opportunities to gain visibility, receive feedback, and pitch to investors.",
#     "IF the entrepreneur lacks pitching skills, THEN recommend training or practice sessions to build confidence and structure (problem-solution-benefits-traction model).",
#     "IF the entrepreneur lacks funding but has technical knowledge, THEN suggest reaching out to potential partners in industry who might value their expertise and offer support.",
#     "IF the entrepreneur is developing a high-cost or technical product, THEN recommend forming partnerships with entities that can provide licensing support, technical tools, or government access.",
#     "IF the entrepreneur has no current industry contacts, THEN suggest attending industry expos, joining professional associations, or leveraging university networks to find partners.",
#     "IF the entrepreneur is a startup with no historical data, THEN recommend using the “Three-Scope Projection” model (TAM, SAM, SOM) to estimate market size.",
#     "IF the entrepreneur is unaware of market estimation techniques, THEN explain that large companies use data-driven models, but startups should rely on assumptions backed by research.",
#     "IF the entrepreneur has identified their TAM, SAM, and SOM, THEN prompt them to justify each with logic, sources, or comparisons to similar startups or industries.",
#     "IF the user is uncertain about starting a business, THEN prompt them to reflect on their personal goals, willingness to take risks, and ability to handle pressure.",
#     "IF the user shows signs of underestimating entrepreneurial challenges, THEN alert them to common issues such as financial instability, lifestyle sacrifices, and mental stress.",
#     "IF the user acknowledges the emotional and lifestyle sacrifices involved, THEN assess their long-term commitment and suggest creating a personal readiness checklist.",
#     "IF the entrepreneur has no plan for sustaining the business in year one, THEN recommend calculating a 12-month cash flow projection, including fixed assets and operational costs.",
#     "IF the entrepreneur cannot fund early growth, THEN suggest securing a financial buffer or identifying potential funding sources before launching.",
#     "IF the entrepreneur has not considered delayed returns, THEN highlight that most startups don’t generate profits immediately and need financial patience.",
#     "IF the entrepreneur plans to run the business solo, THEN warn about the risks of isolation and recommend seeking at least one reliable co-founder or advisor.",
#     "IF the entrepreneur lacks industry contacts or strategic allies, THEN encourage them to build partnerships that can offer funding, domain expertise, and networking.",
#     "IF the entrepreneur is unsure about partnership benefits, THEN explain that strong partners can improve sustainability by sharing workload, reducing costs, and opening doors.",
#     "IF the business idea offers something new or better than existing solutions and addresses a real customer need, THEN it is considered to have a strong value proposition.",
#     "IF the business idea does not offer something unique or does not solve a real problem, THEN it is considered not viable due to a weak value proposition.",
#     "IF the business idea does not clearly define how it will generate income, THEN it is not viable.",
#     "IF the business idea includes multiple well-defined revenue streams (e.g., online sales, in-store sales, subscription fees), THEN it is considered to have a strong revenue model.",
#     "IF the product is still an idea OR at a very early concept stage, THEN its commercialization potential is low.",
#     "IF the product is tested AND validated AND or close to launch, THEN it has a high commercialization potential.",
#     "IF the idea has a strong value proposition AND multiple clear revenue streams AND high speed to market, THEN it is considered ready for investment.",
#     "IF the business is small, simple, and managed by one person, THEN the sole proprietorship is the most suitable structure.",
#     "IF the entrepreneur is confident in handling all operations alone and is comfortable with personal liability, THEN the sole proprietorship is appropriate.",
#     "IF the entrepreneur wants to avoid risk to personal assets, THEN the sole proprietorship is not recommended.",
#     "IF there are two or more founders, THEN a partnership is suitable.",
#     "IF the entrepreneurs want to share responsibilities, pool resources, or avoid facing challenges alone, THEN a partnership is recommended.",
#     "IF the business is started by young or first-time entrepreneurs, THEN a partnership is especially encouraged due to its flexibility and support structure.",
#     "IF the entrepreneurs want limited liability but fewer legal formalities than a company, THEN an LLP is suitable.",
#     "IF the business falls between a partnership and a Sendirian Berhad in terms of structure and needs, THEN an LLP is recommended.",
#     "IF the business needs personal asset protection, THEN a Sendirian Berhad is suitable.",
#     "IF the entrepreneur is prepared to comply with more legal and regulatory formalities, THEN a Sendirian Berhad is appropriate.",
#     "IF the entrepreneur wants to limit liability strictly to company assets, THEN a Sendirian Berhad is the preferred choice.",
#     "IF the entrepreneur is new and wants operational flexibility with shared responsibility, THEN starting with a partnership is recommended.",
#     "IF the entrepreneur has personal savings or access to small informal loans from family/friends, THEN bootstrapping is a feasible option.",
#     "IF the entrepreneur has strong motivation and personal discipline in managing money, THEN bootstrapping is recommended.",
#     "IF the business is short-term or small-scale, THEN bootstrapping is a good initial funding method.",
#     "IF the entrepreneur is not yet eligible or ready for formal funding sources, THEN bootstrapping should be used as a first step.",
#     "IF the startup involves a socially impactful, innovative, or unique idea, THEN applying for government grants is recommended.",
#     "IF the entrepreneur is willing to join competitions or pitch publicly, THEN government grants are a good option.",
#     "IF the startup needs non-repayable funding or early support for idea development, THEN grants are ideal.",
#     "IF the entrepreneur has no collateral or poor credit history, THEN applying through a government-guaranteed development bank is recommended.",
#     "IF the startup requires moderate capital but the founder wants to avoid risking personal assets, THEN development bank loans are suitable.",
#     "IF the entrepreneur prefers lower-risk loans with low interest rates or no collateral requirements, THEN government-backed bank loans are the best fit.",
#     "IF the startup is looking for safer borrowing alternatives than commercial banks, THEN development bank funding is recommended.",
#     "IF the business is growing and needs additional capital without risking personal assets, THEN consider microloans from banks or government agencies that don’t require collateral.",
#     "IF the startup cannot afford advertising, THEN focus on organic SEO to increase visibility without spending on ads.",
#     "IF the startup has limited budget, THEN avoid paid ads like Google Ads or Meta Ads.",
#     "IF the target audience is active on social media, THEN use free platforms such as Instagram, TikTok, or Facebook.",
#     "IF resources are limited, THEN limit marketing efforts to 2–3 platforms to maintain content consistency and credibility.",
#     "IF using social media platforms, THEN utilize relevant hashtags to increase reach and engagement.",
#     "IF the goal is to increase revenue per customer, THEN apply upselling by recommending higher-tier products.",
#     "IF the goal is to increase basket size, THEN use cross-selling by suggesting complementary products.",
#     "IF the goal is to encourage customer retention, THEN use next-sell techniques such as exclusive offers or future discounts.",
#     "IF the customer segment is local, THEN tailor marketing efforts toward local needs and platforms.",
#     "IF the target customers are young, THEN prioritize youth-friendly platforms like TikTok or Instagram.",
#     "IF targeting older consumers, THEN focus on Facebook or platforms they frequently use.",
#     "IF the business is oriented toward export markets, THEN align branding and marketing to international expectations and needs.",
#     "IF target_customer is 'business', THEN business_model is 'B2B' AND explanation is 'Expect longer sales cycles, contracts, and larger order volumes.'",
#     "IF target_customer is 'individual', THEN business_model is 'B2C' AND explanation is 'Focus on marketing, customer experience, and handling many small purchases.'",
#     "IF delivery_method is 'recurring', THEN business_model is 'Subscription' AND explanation is 'You must deliver consistent value and focus on customer retention.'",
#     "IF platform_type is 'connects buyers and sellers', THEN business_model is 'Marketplace' AND explanation is 'You\'ll need to manage a reliable platform and build trust among users.'",
#     "IF most_profitable_segment is known, THEN advice is 'Start with the most profitable and manageable segment first.'",
#     "IF business_model is not scalable, THEN advice is 'Reconsider the model. Look for options that scale better with fewer added costs.'",
#     "IF unsure_about_model, THEN advice is 'Start with one model (e.g., B2C), test it with real users, and expand based on feedback and profitability.'",
#     "IF political_or_economic_stability is False, THEN advice is 'Avoid launching now. Unstable conditions increase startup risk.'",
#     "IF government_support is True, THEN advice is 'It may be a good time to launch. Take advantage of available grants or programs.'",
#     "IF consumer_demand is increasing, THEN advice is 'There is rising demand. Consider launching to meet market needs.'",
#     "IF technology_readiness is low, THEN advice is 'Delay launch until the technology is more mature or accessible.'",
#     "IF current_period is a major crisis AND solution does NOT address crisis, THEN advice is 'Avoid launching during crisis unless your startup solves a direct crisis need.'",
#     "IF current_period is stable AND purchasing_power is high AND demand_exists is True, THEN advice is 'This is an ideal time to launch. Conditions support startup growth.'",
#     "IF cash_flow_tracking is False, THEN advice is 'Start tracking your cash flow closely. Make sure you always have enough liquidity for monthly operations.'",
#     "IF funding_method is 'bootstrapping', THEN advice is 'Use bootstrapping wisely. Keep costs low and avoid unnecessary spending.'",
#     "IF eligible_for_grants is True, THEN advice is 'Apply for government grants or student entrepreneur programs to get early funding.'",
#     "IF participating_in_competitions is True, THEN advice is 'Join startup competitions. They’re a good source of seed funding and exposure.'",
#     "IF have_access_to_investors is True, THEN advice is 'Reach out to angel investors or early-stage partners if needed, but stay lean.'",
#     "IF using_tool is 'none', THEN advice is 'Use simple tools like Excel or Google Sheets to plan your budget and forecast revenue.'",
#     "IF using_tool is 'accounting_software', THEN advice is 'Good! Tools like Wave, QuickBooks, or Xero can help you track finances more efficiently.'",
#     "IF early_spending_on_marketing_or_hiring is True, THEN warning = 'Be careful. In the early stage, prioritize product development and validating your idea over heavy spending.'",
#     "IF product_market_fit is not validated, THEN advice = 'Seek expert help to validate your idea. Make sure it solves a real, proven problem using evidence like statistics, reports, or customer interviews.'",
#     "IF funding_strategy is unclear, THEN advice = 'Get advice on funding options. Depending on your business type, bootstrapping, grants, competitions, or micro-loans may be suitable.'",
#     "IF cash_runway < 6_months, THEN advice = 'Talk to a financial advisor or mentor to extend your runway and plan sustainable cash flow.'",
#     "IF founding_team is incomplete OR lacks complementary skills, THEN advice = 'Seek advice on team building. Choose co-founders who balance your weaknesses and share your vision.'",
#     "IF legal_structure is not decided, THEN advice = 'Consult a legal advisor to pick the right structure (e.g., partnership, LLP, Sdn Bhd) to protect your interests and comply with local laws.'",
#     "IF the cost of producing the product is high, THEN do not set the selling price too low, or the business will not be sustainable.",
#     "IF your cost is low, THEN set a price with a higher markup to gain more profit margin.",
#     "IF your product offers strong value-added features or unique advantages, THEN you can set a higher price confidently.",
#     "IF your product is similar to competitors' offerings, THEN avoid setting the price too far above or below the existing market rate.",
#     "IF your product targets underserved or low-income communities, THEN explore possibilities of government subsidies to offer lower prices and reach more people.",
#     "IF you are able to get a government subsidy, THEN lower the product price to increase accessibility and expand your customer base.",
#     "IF a potential team member cannot contribute meaningfully to your business model, THEN do not include them, even if you trust them personally.",
#     "IF a team member has skills or resources (e.g., software, databases, coding) that fill a gap in your business, THEN include them as they provide key resources or activities.",
#     "IF you are forming a startup team, THEN ensure it includes not only technical experts but also people with management and marketing skills.",
#     "IF you are working with a team on a business project, THEN always register the business to legally define roles and profit-sharing, and prevent future conflicts.",
#     "IF the economic situation is favorable (i.e., stable or growing), THEN it is a good time to enter the market.",
#     "IF your product has strong competitive advantages or clear added value, THEN proceed confidently into the market, even at a higher price point.",
#     "IF your product can address social problems or benefit a marginalized group, THEN look for opportunities to align your business with government or NGO support (e.g., grants, subsidies).",
#     "IF your brand is already strong or credible, THEN you may enter the market at a premium price.",
#     "IF your business solves both a market need and a social issue (e.g., empowering single mothers), THEN you achieve both sustainability and impact, making the business more valuable and fundable.",
#     "IF you are eager to expand your business quickly after some initial success, THEN first conduct a SWOT analysis (Strengths, Weaknesses, Opportunities, Threats) to ensure your growth is strategic and sustainable, not just based on excitement.",
#     "IF a user has created a unique invention, a software application, a creative work, or a proprietary formula, THEN you must protect your intellectual property immediately to prevent it from being copied. Visit the MyIPO (Intellectual Property Corporation of Malaysia) website to learn how to file for copyright to protect your code and creative works, or a patent to protect your unique invention or process.",
#     "IF you are considering a significant investment to scale up, THEN first validate the market demand at a larger scale with a pilot program or a limited launch before committing large sums of money.",
#     "IF a user has a business idea but is unsure how to structure it, assess its viability, or plan the next steps, THEN the best first step is to complete a Business Model Canvas (BMC). This one-page framework will force you to think through the nine essential building blocks of your business, such as your customer segments, value proposition, and revenue streams. It will give you a clear, professional overview of your idea and instantly highlight any critical gaps you need to address.",
#     "IF a user lacks industry experience, needs guidance, or is looking for a mentor to help with their startup, THEN the best way to overcome inexperience is to seek guidance. First, check with your university's entrepreneurship center or faculty for any available mentorship programs. Additionally, use this app's 'Mentor Booking' feature to browse and connect with vetted industry experts who can provide specific advice for your business.",
#     "IF you are worried about the legal process of starting up, THEN start by registering a Sole Proprietorship with SSM (Suruhanjaya Syarikat Malaysia) as it is the simplest and most straightforward legal structure for a solo student founder.",
#     "IF you are feeling overwhelmed with information, THEN use a suitable dashboard to track your progress and focus on one critical task at a time, such as validating your idea or building your financial plan.",
#     "IF the idea is for a regulated industry like food/cosmetics, THEN before launching, you must consult Malaysia's National Pharmaceutical Regulatory Agency (NPRA) for product notification and SIRIM for quality standards to ensure your product is legal and safe for consumers.",
#     "IF a user believes that large capital is required to start a business, THEN explain that startups can begin with minimal capital and grow gradually.",
#     "IF a user thinks they must form a partnership before launching, THEN advise that solo or small trusted teams are sufficient in early stages.",
#     "IF a user wants to create a product before identifying real problems, THEN recommend focusing on community needs first to ensure real added value.",
#     "IF a user assumes marketing must be outsourced, THEN inform them that self-managed marketing can be effective and is learnable over time.",
#     "IF you feel like you need a co-founder to start, THEN starting solo is perfectly fine, only bring on a co-founder if they have essential skills you lack (e.g., a technical co-founder for a tech idea) because a bad partnership is worse than no partnership.",
#     "IF you're thinking of quitting your studies to work on your startup, THEN validate your business as a side project first, use your weekends and free time to test the idea and get your first customers.",
#     "IF you're not a marketing expert, THEN focus on organic marketing. Create useful content on one or two social media platforms your customers use, learn basic SEO for your website, and engage directly with your first 100 users.",
#     "IF you want to know how a startup application can help you stand out from competitors, THEN use the FAB (Features, Advantages, Benefits) framework to define your unique value.",
#     "IF you're trying to get your startup noticed by the government or big organizations, THEN actively seek endorsements or partnerships with credible institutions like your university's entrepreneurship center, MaGIC, or MDEC, building trusts effectively.",
#     "IF you want to know how to keep your customers happy once you have them, THEN set up a simple, reliable customer service channel such as a dedicated email or WhatsApp number and respond to all inquiries within 24 hours to build a reputation for great support.",
#     "IF you're looking to make some extra money with your app or website, THEN integrate affiliate marketing links from platforms like Shopee, Lazada, or Involve Asia. When a user clicks a link and makes a purchase, you earn a small commission."
# ]