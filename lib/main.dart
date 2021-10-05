import 'package:day002/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: PaymentContainer(),
      ),
    );
  }
}

class PaymentContainer extends StatefulWidget {
  const PaymentContainer({Key? key}) : super(key: key);

  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  bool _obscureCvv = true;

  late final TextEditingController _expDateEditingController;

  @override
  void initState() {
    _expDateEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _expDateEditingController.dispose();
    super.dispose();
  }

  Future<DateTime?> showDatePickerDialog(
    BuildContext context,
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Payment',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.accentColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Material(
              borderRadius: BorderRadius.circular(18),
              elevation: 1,
              shadowColor: AppColors.primaryColor,
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      cursorColor: AppColors.primaryColor,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Card Number',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 16,
                      cursorColor: AppColors.primaryColor,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Exp. Date',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'CVV',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextField(
                            controller: _expDateEditingController,
                            onTap: () async {
                              final dateTime = await showDatePickerDialog(
                                context,
                                DateTime.now(),
                                DateTime.utc(2000),
                                DateTime.now(),
                              );
                              if (dateTime == null) return;
                              _expDateEditingController.text =
                                  dateTime.day.toString() +
                                      '/' +
                                      dateTime.month.toString() +
                                      '/' +
                                      dateTime.year.toString();
                            },
                            cursorColor: AppColors.primaryColor,
                            style: TextStyle(fontSize: 22),
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextField(
                            cursorColor: AppColors.primaryColor,
                            style: TextStyle(fontSize: 22),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            obscureText: _obscureCvv,
                            decoration: InputDecoration(
                              isDense: true,
                              suffix: _obscureCvv
                                  ? GestureDetector(
                                      child: Icon(Icons.hide_source_sharp),
                                      onTap: () {
                                        setState(() {
                                          _obscureCvv = false;
                                        });
                                      },
                                    )
                                  : GestureDetector(
                                      child:
                                          Icon(Icons.panorama_fish_eye_rounded),
                                      onTap: () {
                                        setState(() {
                                          _obscureCvv = true;
                                        });
                                      },
                                    ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 100),
                    Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Pay →',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
