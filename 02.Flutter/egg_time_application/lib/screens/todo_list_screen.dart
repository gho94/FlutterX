import 'package:egg_time_application/common/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, dynamic>> _todoItems = [];
  final TextEditingController _controller = TextEditingController();

  final List<String> _categories = ['A', 'B', 'C'];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  Future<void> _loadTodoItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('todoItems');

    if (items != null) {
      final updatedItems = items.map((item) {
        final split = item.split('|');
        return {
          'task': split[0],
          'category': split.length > 1 ? split[1] : 'Others',
          'isChecked': split.length > 2 ? split[2] == 'true' : false,
        };
      }).toList();

      setState(() {
        _todoItems.addAll(updatedItems);
        _applyCategorySort();
      });
    }
  }

  Future<void> _saveTodoItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'todoItems',
      _todoItems
          .map((item) =>
              '${item['task']}|${item['category']}|${item['isChecked']}')
          .toList(),
    );
  }

  void _addTodoItem() {
    if (_controller.text.isNotEmpty && _selectedCategory != null) {
      setState(() {
        _todoItems.add({
          'task': _controller.text,
          'category': _selectedCategory!,
          'isChecked': false,
        });
        _applyCategorySort(); // 추가 후 정렬 적용
        _saveTodoItems();
      });
      _controller.clear();
      _selectedCategory = null;
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
      _saveTodoItems();
    });
  }

  void _toggleCheck(int index) {
    setState(() {
      _todoItems[index]['isChecked'] = !_todoItems[index]['isChecked'];
      _saveTodoItems();
    });
  }

  void _updateCategory(int index, String newCategory) {
    setState(() {
      _todoItems[index]['category'] = newCategory;
      _applyCategorySort(); // 카테고리 변경 시 정렬 적용
      _saveTodoItems();
    });
  }

  void _applyCategorySort() {
    _todoItems.sort((a, b) => _categories
        .indexOf(a['category'])
        .compareTo(_categories.indexOf(b['category'])));
  }

  final eggColors = EggColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: eggColors.yellowstyle3,
      appBar: AppBar(
        backgroundColor: eggColors.yellowstyle3,
        title: const Text(
          '병아리의 하루',
          style: TextStyle(fontFamily: 'Hyemin_Bold', fontSize: 40),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                cursorColor: eggColors.basestyle3,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Enter a task',
                  filled: true,
                  fillColor: eggColors.basestyle2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addTodoItem,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text('Select a category'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: eggColors.basestyle2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  final item = _todoItems[index];
                  return ListTile(
                    leading: Checkbox(
                      value: item['isChecked'],
                      onChanged: (value) {
                        _toggleCheck(index);
                      },
                      activeColor: eggColors.yellowstyle6,
                    ),
                    title: Text(
                      item['task'],
                      style: TextStyle(
                        fontFamily: 'Hyemin_Regular',
                        color: item['isChecked']
                            ? Colors.grey
                            : eggColors.basestyle3,
                        decoration: item['isChecked']
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: item['category'],
                          items: _categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (newCategory) {
                            if (newCategory != null) {
                              _updateCategory(index, newCategory);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeTodoItem(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
