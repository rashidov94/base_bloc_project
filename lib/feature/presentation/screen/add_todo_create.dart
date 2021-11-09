import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:bloc_pattern/feature/presentation/bloc/add_todo_cubit.dart';
import 'package:bloc_pattern/feature/presentation/state/add_todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create ToDo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<AddTodoCubit>().insertTodo(TodoEntity(
                  label: _controller.text,
                  description: _controller.text,
                  createdDate: DateTime.now().microsecondsSinceEpoch));
            },
            child: SizedBox(
              width: 80,
              height: 56,
              child: BlocConsumer<AddTodoCubit, AddTodoState>(
                  listener: (context, state) {
                if (state.stateStatus == StateStatus.success) {
                  Navigator.pop(context);
                }
              }, builder: (context, state) {
                if (state.stateStatus == StateStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return const Center(child: Text('Create Todo'));
              }),
            ),
          )
        ],
      ),
    );
  }
}
