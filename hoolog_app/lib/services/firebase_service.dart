import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'posts';

  // 포스트 추가
  Future<String> addPost(Post post) async {
    try {
      final docRef = await _firestore.collection(_collectionName).add(post.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('포스트 추가 중 오류가 발생했습니다: $e');
    }
  }

  // 포스트 삭제
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection(_collectionName).doc(postId).delete();
    } catch (e) {
      throw Exception('포스트 삭제 중 오류가 발생했습니다: $e');
    }
  }

  // 모든 포스트 가져오기
  Future<List<Post>> getPosts() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('date', descending: true)
          .get();
      
      final posts = querySnapshot.docs
          .map((doc) => Post.fromMap(doc.data(), doc.id))
          .toList();
      
      // 클라이언트 사이드에서 정렬
      posts.sort((a, b) {
        // 먼저 날짜로 정렬
        final dateComparison = b.date.compareTo(a.date);
        if (dateComparison != 0) return dateComparison;
        
        // 같은 날짜면 createdAt으로 정렬 (최신순)
        return b.createdAt.compareTo(a.createdAt);
      });
      
      return posts;
    } catch (e) {
      throw Exception('포스트 로딩 중 오류가 발생했습니다: $e');
    }
  }

  // 특정 날짜의 포스트 가져오기
  Future<List<Post>> getPostsByDate(String date) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('date', isEqualTo: date)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Post.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('포스트 로딩 중 오류가 발생했습니다: $e');
    }
  }

  // 실시간 포스트 스트림
  Stream<List<Post>> getPostsStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          final posts = snapshot.docs
              .map((doc) => Post.fromMap(doc.data(), doc.id))
              .toList();
          
          // 클라이언트 사이드에서 정렬
          posts.sort((a, b) {
            // 먼저 날짜로 정렬
            final dateComparison = b.date.compareTo(a.date);
            if (dateComparison != 0) return dateComparison;
            
            // 같은 날짜면 createdAt으로 정렬 (최신순)
            return b.createdAt.compareTo(a.createdAt);
          });
          
          return posts;
        });
  }
} 