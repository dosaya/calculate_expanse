// import 'package:flutter/material.dart';
// import '../models/transaction_model.dart';
//
// class TransactionProvider extends ChangeNotifier{
//   final List<TransactionModel> _transaction =[];
//
//   List<TransactionModel> get transaction => List.unmodifiable(_transaction);
//
//   double get totalIncome => _transaction
//       .where((transaction) => transaction.isIncome)
//       .fold(0.0, (sum, transaction) => sum + transaction.amount);
//
//   double get totalExpense => _transaction
//       .where((transaction) => !transaction.isIncome)
//       .fold(0.0, (sum,transaction) => sum + transaction.amount);
//
//   double get balance => totalIncome - totalExpense;
//
//   void addTransaction (TransactionModel transaction) {
//     _transaction.insert(0, transaction);
//     notifyListeners();
//   }
//
//   void deleteTransaction (TransactionModel transaction) {
//     _transaction.remove(transaction);
//     notifyListeners();
//   }
//
// }
//

//
// import 'package:flutter/material.dart';
// import '../models/transaction_model.dart';
//
// class TransactionProvider extends ChangeNotifier {
//   final List<TransactionModel> _transactions = [];
//
//   // Getter to access the transaction list
//   List<TransactionModel> get transactions =>
//       List.unmodifiable(_transactions);
//
//   // Calculate total income
//   double get totalIncome {
//     return _transactions
//         .where((transaction) => transaction.isIncome)
//         .fold(0.0, (sum, transaction) => sum + transaction.amount);
//   }
//
//   // Calculate total expenses
//   double get totalExpenses {
//     return _transactions
//         .where((transaction) => !transaction.isIncome)
//         .fold(0.0, (sum, transaction) => sum + transaction.amount);
//   }
//
//   // Calculate balance
//   double get balance => totalIncome - totalExpenses;
//
//   // Add transaction
//   void addTransaction(TransactionModel transaction) {
//     _transactions.insert(0, transaction);
//     notifyListeners();
//   }
//
//   // Delete transaction
//   void deleteTransaction(TransactionModel transaction) {
//     _transactions.remove(transaction);
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';

import '../models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [
    TransactionModel(
      title: 'Monthly Salary',
      amount: 50000.00,
      type: 'Income',
      category: 'Salary',
      date: DateTime.now(),
      note: 'Monthly salary',
    ),
    TransactionModel(
      title: 'Grocery Shopping',
      amount: 2500.00,
      type: 'Expense',
      category: 'Shopping',
      date: DateTime.now(),
      note: 'Groceries for home',
    ),
    TransactionModel(
      title: 'Freelance Project',
      amount: 8000.00,
      type: 'Income',
      category: 'Business',
      date: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      note: 'Freelance payment',
    ),
    TransactionModel(
      title: 'Dinner',
      amount: 750.00,
      type: 'Expense',
      category: 'Food',
      date: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      note: 'Dinner with friends',
    ),
    TransactionModel(
      title: 'Transport',
      amount: 300.00,
      type: 'Expense',
      category: 'Transport',
      date: DateTime.now().subtract(
        const Duration(days: 2),
      ),
      note: 'Travel expenses',
    ),
    TransactionModel(
      title: 'Electricity Bill',
      amount: 1200.00,
      type: 'Expense',
      category: 'Bills',
      date: DateTime.now().subtract(
        const Duration(days: 3),
      ),
      note: 'Monthly electricity bill',
    ),
  ];

  List<TransactionModel> get transactions =>
      List.unmodifiable(_transactions);

  double get totalIncome => _transactions
      .where((transaction) => transaction.isIncome)
      .fold(
    0.0,
        (sum, transaction) => sum + transaction.amount,
  );

  double get totalExpenses => _transactions
      .where((transaction) => !transaction.isIncome)
      .fold(
    0.0,
        (sum, transaction) => sum + transaction.amount,
  );

  double get balance => totalIncome - totalExpenses;

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  void deleteTransaction(TransactionModel transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }

  void updateTransaction(
      TransactionModel oldTransaction,
      TransactionModel updatedTransaction,
      ) {
    final index = _transactions.indexOf(oldTransaction);

    if (index != -1) {
      _transactions[index] = updatedTransaction;
      notifyListeners();
    }
  }
}

