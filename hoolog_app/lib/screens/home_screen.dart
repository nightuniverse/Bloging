import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';
import '../services/firebase_service.dart';
import '../widgets/post_card.dart';
import '../widgets/add_post_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String? _selectedDate;
  bool _showAllPosts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF8), // Figma 배경색
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hoolog',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF171D1B),
            fontFamily: 'Roboto',
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFF171D1B)),
            onPressed: () {
              _showDeleteModeDialog();
            },
            tooltip: '삭제 모드',
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFF171D1B)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 날짜 선택기
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: _selectedDate ?? '날짜 선택',
                        ),
                        decoration: InputDecoration(
                          labelText: '날짜',
                          labelStyle: const TextStyle(
                            color: Color(0xFF949494),
                            fontFamily: 'Roboto',
                          ),
                          suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF949494)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFF171D1B)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xFF171D1B),
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            locale: const Locale('ko', 'KR'),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedDate = DateFormat('yyyy-MM-dd').format(date);
                              _showAllPosts = false;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF171D1B),
                        side: const BorderSide(color: Color(0xFFDDDDDD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        textStyle: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                          _showAllPosts = true;
                        });
                      },
                      child: const Text('전체 보기'),
                    ),
                  ],
                ),
              ),
              // 포스트 입력 폼
              const AddPostForm(),
              const Divider(height: 32, thickness: 1, color: Color(0xFFF4FBF8)),
              // 포스트 목록
              Expanded(
                child: _buildPostsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    if (_selectedDate != null && !_showAllPosts) {
      // 특정 날짜의 포스트만 표시
      return StreamBuilder<List<Post>>(
        stream: _firebaseService.getPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('오류가 발생했습니다: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final allPosts = snapshot.data ?? [];
          final filteredPosts = allPosts
              .where((post) => post.date == _selectedDate)
              .toList();

          if (filteredPosts.isEmpty) {
            return const Center(
              child: Text('선택한 날짜에 포스트가 없습니다.'),
            );
          }

          return _buildGroupedPosts(filteredPosts);
        },
      );
    } else {
      // 모든 포스트 표시
      return StreamBuilder<List<Post>>(
        stream: _firebaseService.getPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('오류가 발생했습니다: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data ?? [];
          
          if (posts.isEmpty) {
            return const Center(
              child: Text('포스트가 없습니다. 첫 번째 포스트를 작성해보세요!'),
            );
          }

          return _buildGroupedPosts(posts);
        },
      );
    }
  }

  Widget _buildGroupedPosts(List<Post> posts) {
    // 날짜별로 그룹화
    final groupedPosts = <String, List<Post>>{};
    for (final post in posts) {
      if (!groupedPosts.containsKey(post.date)) {
        groupedPosts[post.date] = [];
      }
      groupedPosts[post.date]!.add(post);
    }

    // 각 날짜 그룹 내에서 createdAt으로 정렬 (최신순)
    for (final date in groupedPosts.keys) {
      groupedPosts[date]!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    // 날짜별로 정렬 (최신순)
    final sortedDates = groupedPosts.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final datePosts = groupedPosts[date]!;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF444444),
                  ),
                ),
                const SizedBox(height: 12),
                ...datePosts.map((post) => PostCard(
                  post: post,
                  onDelete: () => _deletePost(post.id),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deletePost(String postId) async {
    try {
      await _firebaseService.deletePost(postId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('포스트가 삭제되었습니다.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('삭제 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  void _showDeleteModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 모드'),
        content: const Text('포스트를 길게 눌러서 삭제할 수 있습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
} 