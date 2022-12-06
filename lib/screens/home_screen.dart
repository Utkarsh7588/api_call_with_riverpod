import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';
import '../state/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            PostState state = ref.watch(postsProvider);
            if (state is InitialPostState) {
              return Text('Press the button at bottom right to fetch data');
            }
            if (state is PostLoadingState) {
              return CircularProgressIndicator();
            }
            if (state is ErrorPostState) {
              return Text(state.message);
            }
            if (state is PostLoadedState) {
              return _buildListView(state);
            } else {
              return const Text('some error occored');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postsProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _buildListView(PostLoadedState state) {
  return ListView.builder(
    itemBuilder: (context, index) {
      Post post = state.posts[index];
      return ListTile(
        leading: CircleAvatar(
          child: Text(post.id.toString()),
        ),
        title: Text(post.title),
      );
    },
    itemCount: state.posts.length,
  );
}
