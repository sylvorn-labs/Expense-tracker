import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/custome_text_field.dart';
import '../widgets/field_label.dart';

class RecordTransactionScreen extends StatefulWidget {
  const RecordTransactionScreen({super.key});

  @override
  State<RecordTransactionScreen> createState() => _RecordTransactionScreenState();
}

class _RecordTransactionScreenState extends State<RecordTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController amountController =
  TextEditingController();
  final TextEditingController dateController =
  TextEditingController();
  final TextEditingController descriptionController =
  TextEditingController();

  // 'Income' or 'Expense'
  String transactionType = 'Income';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 4, 18),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BrandColor.brand1,
              onPrimary: Colors.white,
              onSurface: BrandColor.brand1,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        // Format  'Date Month year'
        dateController.text = "${picked.day}th April ${picked.year}";
      });
    }
  }

  void proceedToNext() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaction recorded as $transactionType!'),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //SPACED
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      //BACK BUTTON
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.chevron_left,
                              color: BrandColor.brand1,
                              size: 22,
                            ),
                            SizedBox(width: 2),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: BrandColor.brand1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 2),

                      //TITLE
                      const Text(
                        'Record Transaction',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: BrandColor.brand1,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 6),

                      //SUBTITLE
                      const Text(
                        'Add a new transaction to your records.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Gray_palette.gray7,
                        ),
                      ),

                      const Spacer(flex: 3),

                      //INCOME / EXPENSE TOGGLE BUTTONS
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  transactionType = 'Income';
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: transactionType == 'Income'
                                      ? BrandColor.brand6
                                      : Gray_palette.gray2,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_down_outlined,
                                      color: transactionType == 'Income'
                                          ? Colors.white
                                          : Gray_palette.gray7,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: transactionType == 'Income'
                                            ? Colors.white
                                            : Gray_palette.gray7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  transactionType = 'Expense';
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: transactionType == 'Expense'
                                      ? BrandColor.brand11
                                      : Gray_palette.gray2,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_up_outlined,
                                      color: transactionType == 'Expense'
                                          ? Colors.white
                                          : Gray_palette.gray7,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: transactionType == 'Expense'
                                            ? Colors.white
                                            : Gray_palette.gray7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      //AMOUNT FIELD
                      const FieldLabel(text: 'Amount', isRequired: true),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: amountController,
                        hintText: '18,000 INR',
                        prefixIcon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      //DATE PICKER FIELD
                      const FieldLabel(text: 'Occured On', isRequired: true),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: dateController,
                            hintText: 'Select Date',
                            prefixIcon: Icons.calendar_today_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      //DESCRIPTION FIELD
                      const FieldLabel(text: 'Description', isRequired: false),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: 'Phase-1 Payment',
                        prefixIcon: Icons.article_outlined,
                      ),

                      const Spacer(flex: 4),

                      //NEXT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: proceedToNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BrandColor.brand1,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),

            //MOUNTAIN BANNER
            Image.asset(
              'assets/images/mountain_banner.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}