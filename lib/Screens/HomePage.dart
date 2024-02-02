import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobigic/Widgets/Custom_Button.dart';
import 'package:mobigic/Widgets/custom_toast_message.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController M_num = TextEditingController();
  TextEditingController N_num = TextEditingController();
  TextEditingController search = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  List<String> alphabets = [];
  List<String> highlightedCells = [];

  void generateAlphabets(int m, int n) {
    setState(() {
      alphabets.clear();
      highlightedCells.clear();
    });

    if (m > 0 && n > 0) {
      for (int i = 0; i < m * n; i++) {
        int charCode = Random.secure().nextInt(26) + 65;
        alphabets.add(String.fromCharCode(charCode));
      }
    } else {
      CustomToastMessage().showLongToast('Please Enter Positive number for rows and columns');
    }

    setState(() {});
  }

  void search_Highlight(String text) {
    setState(() {
      highlightedCells.clear();
    });

    if (text.isEmpty) {
      CustomToastMessage().showLongToast('Please Enter text to search');
      return;
    }

    for (int i = 0; i < alphabets.length; i++) {
      for (int j = 0; j < alphabets[i].length; j++) {
        if (alphabets[i][j].toLowerCase() == text.toLowerCase() && text.length == 1) {
          setState(() {
            highlightedCells.add('$i$j');
          });
        }
      }
    }

    if (text.length > 1) {
      for (int i = 0; i < alphabets.length; i++) {
        for (int j = 0; j < alphabets[i].length; j++) {
          for (int k = 0; k < text.length; k++) {
            if (alphabets[i][j].toLowerCase() == text[k].toLowerCase() && alphabets[i][j].toLowerCase() == text[k++].toLowerCase()) {
              setState(() {
                highlightedCells.add('$i$j');
              });
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    M_num.dispose();
    N_num.dispose();
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Grid Creation'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(16),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: M_num,
                          decoration: InputDecoration(
                              hintText: 'Enter m rows',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Quicksand',
                                  color: Colors.grey),
                              contentPadding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 19, top: 13),
                              prefix: Container(
                                margin: const EdgeInsets.only(right: 10, top: 0),
                                child: Icon(
                                  Icons.table_rows_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.purpleAccent),
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            }
                            else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              val = M_num.text;
                            });
                          },
                          obscureText: false,
                        ),
                        SizedBox(height: 15,),

                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: N_num,
                          decoration: InputDecoration(
                              hintText: 'Enter n column',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Quicksand',
                                  color: Colors.grey),
                              contentPadding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 19, top: 13),
                              prefix: Container(
                                margin: const EdgeInsets.only(right: 10, top: 0),
                                child: Icon(
                                  Icons.view_column_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.purpleAccent),
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              val = N_num.text;
                            });
                          },
                          obscureText: false,
                        ),
                        SizedBox(height: 15),

                        CustomButton(
                          buttoncolor: Colors.purple.shade100,
                          onpressed: () {
                            int m = int.tryParse(M_num.text) ?? 0;
                            int n = int.tryParse(N_num.text) ?? 0;
                            generateAlphabets(m, n);
                          },
                          label: 'Generate Grid',
                          txtcolor: Colors.purple.shade800,
                        ),

                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: search,
                          decoration: InputDecoration(
                              hintText: 'Enter search Text',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Quicksand',
                                  color: Colors.grey),
                              contentPadding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 19, top: 13),
                              prefix: Container(
                                margin: const EdgeInsets.only(right: 10, top: 0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.purpleAccent),
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              val = search.text;
                            });
                          },
                          obscureText: false,
                        ),
                        SizedBox(height: 15),

                        CustomButton(
                          buttoncolor: Colors.purple.shade100,
                          onpressed: () {
                            alphabets.isEmpty ?
                            CustomToastMessage().showLongToast('Please Generate Grid First')
                            : null;
                            alphabets.isEmpty ? null:
                            search_Highlight(search.text);
                          },
                          label: 'Search Grid',
                          txtcolor: Colors.purple.shade800,
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              alphabets.isEmpty || N_num.text.isEmpty && M_num.text.isEmpty ?
              Container(): Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: int.tryParse(N_num.text.isEmpty ? M_num.text : N_num.text) ?? 1,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: alphabets.length,
                  itemBuilder: (context, index) {
                    int row = (index / alphabets[0].length).floor();
                    int col = index % alphabets[0].length;
                    return Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: highlightedCells.contains('$row$col') ? Colors.yellow : Colors.purple.shade200,
                      ),
                      margin: EdgeInsets.only(bottom: 20, right: 10, left: 10),
                      child: Center(
                        child: Text(alphabets[index]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}

