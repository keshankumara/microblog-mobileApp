import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'posts';

  // Create a new post
  Future<void> createPost({
    required String userId,
    required String userName,
    required String content,
    required bool isPublic,
  }) async {
    try {
      DocumentReference docRef = _firestore.collection(_collection).doc();

      Post post = Post(
        id: docRef.id,
        userId: userId,
        userName: userName,
        content: content,
        isPublic: isPublic,
        createdAt: DateTime.now(),
      );

      await docRef.set(post.toJson());
    } catch (e) {
      throw 'Failed to create post: $e';
    }
  }

  // Update an existing post
  Future<void> updatePost({
    required String postId,
    required String content,
    required bool isPublic,
  }) async {
    try {
      await _firestore.collection(_collection).doc(postId).update({
        'content': content,
        'isPublic': isPublic,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw 'Failed to update post: $e';
    }
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection(_collection).doc(postId).delete();
    } catch (e) {
      throw 'Failed to delete post: $e';
    }
  }

  // Get all public posts (stream)
  Stream<List<Post>> getPublicPosts() {
    return _firestore
        .collection(_collection)
        .where('isPublic', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
        });
  }

  // Get user's private posts (stream)
  Stream<List<Post>> getPrivatePosts(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .where('isPublic', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
        });
  }

  // Get all user's posts (both public and private)
  Stream<List<Post>> getUserPosts(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
        });
  }

  // Get a single post by ID
  Future<Post?> getPostById(String postId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection(_collection)
          .doc(postId)
          .get();
      if (doc.exists) {
        return Post.fromDocument(doc);
      }
      return null;
    } catch (e) {
      throw 'Failed to fetch post: $e';
    }
  }
}
