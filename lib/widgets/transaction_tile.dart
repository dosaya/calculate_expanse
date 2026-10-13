
import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../utils/app_constants.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;


  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome = transaction.isIncome;

    final Color transactionColor = isIncome
        ? AppConstants.incomeColor
        : AppConstants.expenseColor;

    final IconData transactionIcon = isIncome
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded;

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: transactionColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            transactionIcon,
            color: transactionColor,
          ),
        ),
        title: Text(
          transaction.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${transaction.category} • ${_formatDate(transaction.date)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${isIncome ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: transactionColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 4),
              IconButton(
                tooltip: 'Delete transaction',
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 21,
                ),
              ),
            ],
            if (onEdit != null)
              IconButton(
                tooltip: 'Edit transaction',
                onPressed: onEdit,
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.blue,
                  size: 21,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }
}
