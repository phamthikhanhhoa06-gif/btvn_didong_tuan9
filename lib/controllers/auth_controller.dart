import '../models/user.dart';
import '../utils/database_helper.dart';

class AuthController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> registerUser(String email, String password) async {
    final db = await _dbHelper.database;
    try {
      await db.insert('users', User(email: email, password: password).toMap());
      return true;
    } catch (e) {
      return false; // Trùng email
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty;
  }
}