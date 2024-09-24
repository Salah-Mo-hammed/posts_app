import 'package:ca_post_app/dependency_container.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_bloc.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_event.dart';
import 'package:ca_post_app/presintaion/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilaizedDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) => sl()..add(GetAllPostsEvent()),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
