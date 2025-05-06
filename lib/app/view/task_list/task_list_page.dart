import 'package:flutter/material.dart';
import 'package:laboratorio04/app/view/components/h1.dart';
import 'package:laboratorio04/app/model/task.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final taskList = <Task>[
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Mis Tareas',
          style: TextStyle(
            color: Color(0xFF444444),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF444444)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF444444)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF444444)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tu Progreso',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${taskList.where((task) => task.done).length}/${taskList.length} Completadas',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value:
                                    taskList.isEmpty
                                        ? 0
                                        : taskList
                                                .where((task) => task.done)
                                                .length /
                                            taskList.length,
                                strokeWidth: 8,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '${((taskList.isEmpty ? 0 : taskList.where((task) => task.done).length / taskList.length) * 100).toInt()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tareas Pendientes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Ver Todo',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: taskList.length,
                itemBuilder:
                    (_, index) => _TaskItem(
                      taskList[index],
                      onTap: () {
                        setState(() {
                          taskList[index].done = !taskList[index].done;
                        });
                      },
                      onDelete: () {
                        setState(() {
                          taskList.removeAt(index);
                        });
                      },
                    ),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              _showNewTaskModal(context);
            },
            backgroundColor: Colors.blue.shade600,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.add, size: 32, color: Colors.white),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => _NewTaskModal(
            onTaskAdded: (title) {
              setState(() {
                taskList.add(Task(title));
              });
            },
          ),
    );
  }
}

class _NewTaskModal extends StatefulWidget {
  const _NewTaskModal({Key? key, required this.onTaskAdded}) : super(key: key);

  final Function(String) onTaskAdded;

  @override
  State<_NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<_NewTaskModal> {
  final _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      final text = _controller.text.trim();
      widget.onTaskAdded(text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1('Nueva tarea'),
          const SizedBox(height: 26),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Descripción de la tarea',
              prefixIcon: const Icon(Icons.task),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _controller.clear(),
              ),
            ),
            style: const TextStyle(color: Colors.black), // Add this style
            maxLines: 2,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _addTask(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final text = _controller.text.trim();
                widget.onTaskAdded(text);
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'Guardar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(
    this.task, {
    Key? key,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  final Task task;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.title),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: task.done ? Colors.blue.shade500 : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: task.done ? Colors.blue.shade500 : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child:
                task.done
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
          ),
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF333333),
              decoration: task.done ? TextDecoration.lineThrough : null,
              decorationColor: Colors.grey,
              decorationThickness: 2,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color:
                      task.done ? Colors.green.shade50 : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.done ? 'Completado' : 'Pendiente',
                  style: TextStyle(
                    color:
                        task.done
                            ? Colors.green.shade700
                            : Colors.orange.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
