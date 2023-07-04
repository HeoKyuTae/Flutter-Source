import 'package:get/get.dart';
import 'package:make_source/todo_apiclient.dart';
import 'package:make_source/todo_repository.dart';

class TodoController extends GetxController {
  final TodoRepository _todoRepository = TodoRepository(todoApiClient: TodoApiClient());

  final RxInt _counter = 0.obs;
  int get counter => _counter.value;

  @override
  void onInit() {
    print('Controller onInit');
    super.onInit();
  }

  void defaultCounter() {
    getList(_counter.value);
  }

  void outcrease() {
    _counter - 1;
  }

  void increase() {
    _counter + 1;
  }

  void getList(int itemIdx) async {
    final result = await _todoRepository.fetchItemList(itemIdx);
  }
}
