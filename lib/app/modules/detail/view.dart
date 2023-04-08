import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasks_app/app/core/utils/extentions.dart';
import 'package:tasks_app/app/core/values/colors.dart';
import 'package:tasks_app/app/modules/detail/widgets/done_list.dart';
import 'package:tasks_app/app/modules/home/controller.dart';

import 'widgets/doing_list.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homeCtr.task.value;
    var color = HexColor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtr.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        homeCtr.updateTodos();
                        homeCtr.changeTask(null);
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        task.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: color,
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                var totalTasks =
                    homeCtr.doingTodos.length + homeCtr.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 14.0.wp, right: 14.0.wp, top: 3.0.wp),
                  child: Row(
                    children: [
                      Text(
                        "$totalTasks Task",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0.sp),
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTasks == 0 ? 1 : totalTasks,
                          currentStep: homeCtr.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color.withOpacity(.5),
                              color,
                            ],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 2.0.wp),
                child: TextFormField(
                  controller: homeCtr.editCtrl,
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Please enter your todo item.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.check_box_outline_blank),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeCtr.formKey.currentState!.validate()) {
                          var success = homeCtr.addTodo(homeCtr.editCtrl.text);
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                          } else {
                            EasyLoading.showError('Todo item is already exist');
                          }
                          homeCtr.editCtrl.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.done,
                        color: blue,
                      ),
                    ),
                  ),
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
