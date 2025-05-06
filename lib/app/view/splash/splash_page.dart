import 'package:flutter/material.dart';
import 'package:laboratorio04/app/view/task_list/task_list_page.dart';
import 'package:laboratorio04/app/view/components/shape.dart';
import 'package:laboratorio04/app/view/components/h1.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Shape(),
              ],
            ),
            const SizedBox(height: 79),
            Image.asset(
              'assets/images/onboarding-image.png',
              width: 180,
              height: 168,
            ),
            const SizedBox(height: 99),
            const H1('Lista de tareas'),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const TaskListPage();
                  }));
                },
                child: const Text(
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}