import 'package:api_call_with_riverpod/services/http_get_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, PostState>(
  (ref) => PostsNotifier(),
);

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  PostLoadedState({required this.posts});
  final List<Post> posts;
}

class ErrorPostState extends PostState {
  ErrorPostState({
    required this.message,
  });
  final String message;
}

class PostsNotifier extends StateNotifier<PostState> {
  PostsNotifier() : super(InitialPostState());
  HttpGetPost _httpGetPost = HttpGetPost();
  fetchPosts() async {
    try {
      state = PostLoadingState();
      List<Post> posts = await _httpGetPost.getPosts();
      state = PostLoadedState(posts: posts);
    } catch (e) {
      state = ErrorPostState(message: e.toString());
    }
  }
}
