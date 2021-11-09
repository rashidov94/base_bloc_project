import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:bloc_pattern/feature/presentation/bloc/add_todo_cubit.dart';
import 'package:bloc_pattern/feature/presentation/bloc/all_todo_cubit.dart';
import 'package:bloc_pattern/feature/presentation/screen/add_todo_create.dart';
import 'package:bloc_pattern/feature/presentation/state/all_todo_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AllTodoCubit>().getAllTodoFromRepo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocBuilder<AllTodoCubit, AllTodoState>(
        builder: (context, state) {
          switch (state.stateStatus) {
            case StateStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case StateStatus.failure:
              return const Center(
                child: Center(
                  child: Text('Some Error'),
                ),
              );
            case StateStatus.success:
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.todos![index].label),
                      subtitle: Text(state.todos![index].description),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: state.todos!.length);
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<AddTodoCubit>(
                create: (context) {
                  return container<AddTodoCubit>();
                },
                child: AddTodoScreen(),
              ),
            ),
          ).then((value) => context.read<AllTodoCubit>().getAllTodoFromRepo());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
