import '../models/expense.dart';
import '../utils/database_helper.dart';

class ExpenseController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertExpense(Expense expense) async {
    final db = await _dbHelper.database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> fetchExpenses() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('expenses', orderBy: 'id DESC');
    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  Future<int> deleteExpense(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}