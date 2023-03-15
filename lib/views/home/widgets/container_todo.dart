import 'package:flutter/material.dart';

import '../../../models/todo_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/state_util.dart';
import '../../detils/todo_detail_view.dart';

class ContainerTodo extends StatelessWidget {
  final TodoModel data;
  const ContainerTodo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        clipBehavior: Clip.antiAlias,
        color: data.deadline!.isEmpty ? orangeColor : boldOrangeColor,
        child: InkWell(
          onTap: () {
            Get.to(
              page: TodoDetailView(
                data: data,
              ),
            );
          },
          child: Container(
            height: 120.0,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (data.deadline!.isNotEmpty)
                      const Icon(
                        Icons.access_time_sharp,
                        size: 16.0,
                        color: Colors.white,
                      )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Text(
                    data.description ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Created at ${data.createdAt}",
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
