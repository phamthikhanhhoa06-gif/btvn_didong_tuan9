import 'package:flutter/material.dart';
import '../controllers/expense_controller.dart';
import '../models/expense.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseController _controller = ExpenseController();
  List<Expense> _expenses = [];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final list = await _controller.fetchExpenses();
    setState(() {
      _expenses = list;
    });
  }

  void _addExpense() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    final newExpense = Expense(
      title: _titleController.text,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      note: _noteController.text,
    );

    _controller.insertExpense(newExpense).then((_) {
      _titleController.clear();
      _amountController.clear();
      _noteController.clear();
      _loadExpenses();
    });
  }

  void _deleteExpense(int id) {
    _controller.deleteExpense(id).then((_) => _loadExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 1: Quản Lý Chi Tiêu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Nội dung chi tiêu', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Số tiền', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Ghi chú', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addExpense,
              child: const Text('Thêm Chi Tiêu'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final item = _expenses[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Ghi chú: ${item.note}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${item.amount.toStringAsFixed(0)} VNĐ', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteExpense(item.id!),
                          ),
                        ],
                      ),
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