import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personify/model/history_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPagStateState createState() => _HistoryPagStateState();
}

class _HistoryPagStateState extends State<HistoryPage> {
  //final List<Employee> _employees = [];
  final Box<History> _historyBox = Hive.box<History>('history');
  int? _selectedIndex;

  void deleteAllHistory() {
    _historyBox.clear();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _historyBox.listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: _historyBox.length,
            itemBuilder: (context, index) {
              final entry = _historyBox.getAt(index);
              bool isSelected = _selectedIndex == index;
              return ListTile(
                title: Text(entry!.playerName),
                subtitle: Text(entry.results),
                tileColor: isSelected ? Colors.blue.withOpacity(0.5) : null,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedIndex = null;
                      isSelected = false;
                    } else {
                      _selectedIndex = index;
                      isSelected = true;
                    }
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteAllHistory();
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
