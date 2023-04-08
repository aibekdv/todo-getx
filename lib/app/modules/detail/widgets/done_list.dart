import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/app/core/utils/extentions.dart';
import 'package:tasks_app/app/core/values/colors.dart';
import 'package:tasks_app/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  DoneList({super.key});
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtr.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6.0.wp, vertical: 3.0.wp),
                  child: Text(
                    "Completed (${homeCtr.doneTodos.length})",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ),
                ...homeCtr.doneTodos
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtr.deleteDoneTodo(element),
                        background: Container(
                          color: Colors.red.withOpacity(.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 6.0.wp),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.0.wp, vertical: 3.0.wp),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.done,
                                  color: blue,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 3.0.wp),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0.sp,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
