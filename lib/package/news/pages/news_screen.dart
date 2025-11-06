import 'package:flutter/material.dart';
import '../../model/news_model.dart';
import '../../model/faq_model.dart';
import '../../model/tutorial_model.dart';
import '../services/load_tutorial.dart';
import '../services/load_news.dart';
import '../services/load_faq.dart'; 
import '../widgets/news_item_card.dart';
import '../widgets/faq_item_card.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsSectionCardState();
}

class _NewsSectionCardState extends State<NewsScreen> {
  int selectedIndex = 0;
  final List<String> tabs = ["Mega Story", "Hỏi đáp", "Hướng dẫn"];

  late Future<List<NewsModel>> futureNews;
  late Future<List<FAQModel>> futureFAQ; 
  late Future<List<TutorialModel>> futureTutorial;
  @override
  void initState() {
    super.initState();
    futureNews = loadNews(); // ✅ Gọi load dữ liệu news
    futureFAQ = loadFAQ();   // ✅ Gọi load dữ liệu faqs
    futureTutorial = loadTutorial();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale(double v) => v * width / 430;

    return SafeArea(
      
      child: Scaffold(
        
        backgroundColor: const Color(0xFFF8F8F8),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            const SizedBox(height: 12),

            // ---------------- SEGMENT CONTROL ----------------
            Center(
              child: Container(
                width: scale(406),
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(256),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(tabs.length, (index) {
                    final bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: scale(122),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(256),
                          color: isSelected
                              ? const Color(0xFF17D066)
                              : Colors.transparent,
                          boxShadow: isSelected
                              ? const [
                                  BoxShadow(
                                    color: Color(0x3317D066),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: isSelected
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF848484),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------- NỘI DUNG TAB ----------------
            Expanded(
              
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  // 🟩 Tab 0: Mega Story
                  FutureBuilder<List<NewsModel>>(
                    future: futureNews,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Lỗi tải tin: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final newsList = snapshot.data ?? [];
                      if (newsList.isEmpty) {
                        return const Center(
                            child: Text('Không có tin tức nào hiện tại'));
                      }

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: scale(16)),
                        itemCount: newsList.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 17),
                        itemBuilder: (context, index) {
                          return NewsCardCard(news: newsList[index]);
                        },
                      );
                    },
                  ),

                  // 🟦 Tab 1: Hỏi đáp (load từ JSON)
                  FutureBuilder<List<FAQModel>>(
                    
                    future: futureFAQ,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Lỗi tải FAQ: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final faqList = snapshot.data ?? [];
                      if (faqList.isEmpty) {
                        return const Center(
                            child: Text('Không có câu hỏi nào hiện tại'));
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: scale(16)),
                        itemCount: faqList.length,
                        itemBuilder: (context, index) {
                          final faq = faqList[index];
                          return FAQItem(
                            title: faq.title,
                            content: faq.content,
                          );
                        },
                      );
                    },
                  ),

                  // 🟨 Tab 2: Hướng dẫn
                  FutureBuilder<List<TutorialModel>>(
                    future: futureTutorial,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Lỗi tải tin: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final tutorialList = snapshot.data ?? [];
                      if (tutorialList.isEmpty) {
                        return const Center(
                            child: Text('Không có tin tức nào hiện tại'));
                      }

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: scale(16)),
                        itemCount: tutorialList.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 17),
                        itemBuilder: (context, index) {
                          return NewsCardCard(news: tutorialList[index]);
                        },
                      );
                    },
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
