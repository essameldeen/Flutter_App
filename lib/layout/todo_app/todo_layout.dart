import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/cubit/cubit.dart';
import 'package:app_test/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AppCubit()
        ..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titlesList[cubit.currentIndex]),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  cubit.fabIcon,
                ),
                onPressed: () {
                  if (cubit.isBottomSheetShow) {
                    if (formKey.currentState?.validate() == true) {
                      cubit.insertIntoDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text);

                      cubit.changeBottomSheetState(
                          newValue: false, newIcon: Icons.edit);
                    }
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet(
                        elevation: 20.0, (context) => bottomSheet(context))
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          newValue: false, newIcon: Icons.edit);
                    });
                    cubit.changeBottomSheetState(
                        newValue: true, newIcon: Icons.add);
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (indexOfTap) {
                    cubit.changeIndex(indexOfTap);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: "Tasks"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive), label: "Archived"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle), label: "Done"),
                  ]),
              body: ConditionalBuilder(
                  condition: state is! AppShowProgressBarState,
                  fallback: (context) =>
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  builder: (context) => cubit.screen[cubit.currentIndex]));
        },
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultFormField(
                controller: titleController,
                hint: "enter title",
                label: "Title",
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "title must not be empty";
                  }
                  return null;
                },
                prefixIcon: Icons.title,
                textInputType: TextInputType.text),
            const SizedBox(height: 10.0),
            defaultFormField(
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    var timeText = value?.format(context);
                    timeController.text = timeText!;
                  });
                },
                controller: timeController,
                hint: "Enter Task Time",
                label: "Task Time",
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "time must not be empty";
                  }
                  return null;
                },
                prefixIcon: Icons.watch_later_outlined,
                textInputType: TextInputType.datetime),
            const SizedBox(height: 10.0),
            defaultFormField(
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse("2023-03-21"))
                      .then((value) {
                    var dateText = DateFormat.yMMMd().format(value!);
                    dateController.text = dateText.toString();
                  });
                },
                controller: dateController,
                hint: "Enter date",
                label: "Task Date",
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Date must not be empty";
                  }
                  return null;
                },
                prefixIcon: Icons.calendar_today,
                textInputType: TextInputType.datetime),
          ],
        ),
      ),
    );
  }
}
