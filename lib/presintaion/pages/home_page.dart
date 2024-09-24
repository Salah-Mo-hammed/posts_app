// HomePage

// ignore_for_file: prefer_const_constructors

import 'package:ca_post_app/domain/entities/post_entity.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_bloc.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_event.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(context),
      appBar: AppBar(
        title: Text("news App with clean archeticture"),
      ),
      body: _buildBody(),
    );
  }

  FloatingActionButton _buildFloatingButton(BuildContext context) {
    TextEditingController postController = TextEditingController();
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text("Add Post"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: postController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Post"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.black)),
                        onPressed: () {
                          final PostEntity postEntity = PostEntity(
                              userId: 0,
                              id: 0,
                              title: postController.text,
                              body: '');
                          context.read<PostBloc>()
                              .add(AddPostEvent(post: postEntity));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "add",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.black)),
                        onPressed: () {},
                        child: Text(
                          "cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ));
      },
    );
  }

  BlocBuilder<PostBloc, PostState> _buildBody() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostStateLoading) {
          return _buildCircularIndecator();
        } else if (state is PostStateDone) {
          final posts = state.postsList;
          return _listViewBuilder(posts);
        } else if (state is PostStateExceptions) {
          return Text((state.exception).toString());
        } else {
          return _buildCircularIndecator();
        }
      },
    );
  }

  Padding _buildCircularIndecator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

ListView _listViewBuilder(List<PostEntity> posts) {
  return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      colors: const [Colors.black12, Colors.white],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight)),
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    context
                        .read<PostBloc>()
                        .add(DeletePostEvent(postId: posts[index].id));
                  },
                  icon: Icon(Icons.delete),
                ),
                title: Text(posts[index].title),
              ),
            ),
          ));
}
/*
   showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Add Post'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'post',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle your add post logic here
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
     
 */