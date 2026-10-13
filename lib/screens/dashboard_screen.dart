
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedFilter = 'All';

  // Ask for confirmation before deleting a transaction.
  Future<void> _confirmDelete(
      BuildContext context,
      TransactionModel transaction,
      ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Transaction?'),
          content: Text(
            'Are you sure you want to delete "${transaction.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && context.mounted) {
      context
          .read<TransactionProvider>()
          .deleteTransaction(transaction);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;

    // Apply the selected filter.
    final filteredTransactions = transactions.where((transaction) {
      if (_selectedFilter == 'Income') {
        return transaction.isIncome;
      }

      if (_selectedFilter == 'Expense') {
        return !transaction.isIncome;
      }

      return true;
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Here is your financial overview.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              // Balance summary.
              BalanceCard(
                balance: provider.balance,
                income: provider.totalIncome,
                expenses: provider.totalExpenses,
              ),

              const SizedBox(height: 28),

              // Recent transactions heading and filter.
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        isDense: true,
                        borderRadius: BorderRadius.circular(12),
                        items: const [
                          DropdownMenuItem(
                            value: 'All',
                            child: Text('All'),
                          ),
                          DropdownMenuItem(
                            value: 'Income',
                            child: Text('Income'),
                          ),
                          DropdownMenuItem(
                            value: 'Expense',
                            child: Text('Expense'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedFilter = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Filtered transaction list with delete support.
              if (filteredTransactions.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                  ),
                  child: Center(
                    child: Text(
                      'No ${_selectedFilter.toLowerCase()} '
                          'transactions found.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                ListView.builder(
                  itemCount: filteredTransactions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final transaction = filteredTransactions[index];

                    return TransactionTile(
                      transaction: transaction,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddTransactionScreen(
                              transactionToEdit: transaction,
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        _confirmDelete(context, transaction);
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
