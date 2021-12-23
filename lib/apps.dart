import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco/bloc/network/network_bloc.dart';
import 'package:myco/quiz/components/snackbar_component.dart';
import 'package:myco/todo/core/bloc/synchronize_todo_data.dart/synchronizetodo_bloc.dart';

class Myco extends StatefulWidget {
  const Myco({Key? key}) : super(key: key);

  @override
  State<Myco> createState() => _MycoState();
}

class _MycoState extends State<Myco> {
  List<Concept> concepts = [
    Concept('Quiz App', (context) {
      Navigator.pushNamed(context, 'quizApp');
    }),
    Concept('Todo App', (context) {
      Navigator.pushNamed(context, 'todoApp');
    })
  ];

  @override
  initState() {
    context.read<NetworkBloc>().add(ConnnectionListen());
    super.initState();
  }

  syncData() {
    context.read<SynchronizetodoBloc>().add(StartTodoSynchronization());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: const Text('MYCO - BLOC ')),
      body: Column(
        children: [
          BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
            debugPrint('$state');
            if (state is NetworkSucess &&
                state.connectionType == ConnectionType.Wifi) {
                   syncData();
              return Text('Wifi', style: Theme.of(context).textTheme.headline2);
            } else if (state is NetworkSucess &&
                state.connectionType == ConnectionType.Mobile) {
              syncData();
              return Text('Mobile',
                  style: Theme.of(context).textTheme.headline2);
            } else if (state is NetworkDisconnected) {
              return const Text('Disconnected');
            }
            return const CircularProgressIndicator();
          }),
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              debugPrint('$state');
              String connectionStatus = 'No internet connection';
              if (state is NetworkSucess) {
                connectionStatus =
                    state.connectionType.toString().split('.').last;
              } else {
                connectionStatus = 'Disconnected from internet';
              }
              mycoSnackBar(context, connectionStatus);
            },
            child: Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: concepts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => concepts[index].onTap(context),
                      child: Card(
                        color: Colors.amber,
                        child: Center(child: Text(concepts[index].conceptName)),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class Concept {
  final String conceptName;
  final Function onTap;

  Concept(this.conceptName, this.onTap);
}
