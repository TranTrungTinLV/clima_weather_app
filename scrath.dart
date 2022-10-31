import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String? taskResult2 = await task2();
  task3(taskResult2);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
  Duration Seconds = Duration(seconds: 3);

  String result;
  await Future.delayed(Seconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
}

void task3(String? task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete $task2Data');
}
