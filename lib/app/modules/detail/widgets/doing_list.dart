import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/app/core/utils/extentions.dart';
import 'package:tasks_app/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  DoingList({super.key});
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtr.doingTodos.isEmpty && homeCtr.doneTodos.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.0.wp,
                ),
                Image.asset(
                  "assets/task.png",
                  width: 65.0.wp,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 3.0.wp,
                ),
                Text(
                  "Add task",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtr.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0.wp, vertical: 3.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: element['done'],
                                onChanged: (value) {
                                  homeCtr.doneTodo(element['title']);
                                  homeCtr.doneTodos.refresh();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                              child: Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeCtr.doneTodos.isNotEmpty &&
                    homeCtr.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.wp, right: 6.0.wp),
                    child: const Divider(thickness: 1),
                  ),
              ],
            ),
    );
  }
}
