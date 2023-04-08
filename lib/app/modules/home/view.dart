import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasks_app/app/core/utils/extentions.dart';
import 'package:tasks_app/app/core/values/colors.dart';
import 'package:tasks_app/app/data/models/task.dart';
import 'package:tasks_app/app/modules/home/controller.dart';
import 'package:tasks_app/app/modules/home/widgets/add_card.dart';
import 'package:tasks_app/app/modules/home/widgets/add_dialog.dart';
import 'package:tasks_app/app/modules/report/view.dart';

import 'widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.tabIdx.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      "My Lists",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks.map(
                          (element) => LongPressDraggable(
                            data: element,
                            onDragStarted: () =>
                                controller.changeDeleteing(true),
                            onDraggableCanceled: (_, __) =>
                                controller.changeDeleteing(false),
                            onDragEnd: (_) => controller.changeDeleteing(false),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: element),
                            ),
                            child: TaskCard(task: element),
                          ),
                        ),
                        AddCard()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportPage(),
          ],
        ),
        floatingActionButton: DragTarget<Task>(
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(
                      () => AddDialog(),
                      transition: Transition.downToUp,
                    );
                  } else {
                    EasyLoading.showInfo("Please create your task type");
                  }
                },
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                child: Icon(
                  controller.deleting.value ? Icons.delete : Icons.add,
                ),
              ),
            );
          },
          onAccept: (data) {
            controller.deleteTask(data);
            EasyLoading.showSuccess("Delete success");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () => Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (value) => controller.changeTabIdx(value),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.tabIdx.value,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(Icons.apps),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(
                      Icons.apps,
                      color: blue,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(Icons.data_usage),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(
                      Icons.data_usage,
                      color: blue,
                    ),
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
