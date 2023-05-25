import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Item.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _Items();
}

class _Items extends State<Items> {
  List<Item> items = [];
  List<int> usedIDs = [];
  String selectedOrderType ="Date"; // Default order type

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    return formattedTime;
  }

  void searchItemByTitle(String title) {
    Item? foundItem;
    for (var item in items) {
      if (item.title == title) {
        foundItem = item;
        break;
      }
    }

    if (foundItem != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Item Details'),
            content: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Creation Date')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Price')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(foundItem!.id.toString())),
                  DataCell(Text(foundItem.title)),
                  DataCell(Text(foundItem.creationDate.toString())),
                  DataCell(Text(foundItem.quantity.toString())),
                  DataCell(Text(foundItem.price.toString())),
                ]),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('There is no item with title "$title".'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void clearItems() {
    setState(() {
      items.clear();
      usedIDs.clear();
    });
  }

  void removeItem(int id) {
    setState(() {
      Item? removedItem;

      for (int i = 0; i < items.length; i++) {
        if (items[i].id == id) {
          removedItem = items.removeAt(i);
          break;
        }
      }
      int? removeid;
      for (int i = 0; i < usedIDs.length; i++) {
        if (usedIDs[i] == id) {
          removeid = usedIDs.removeAt(i);
          break;
        }
      }

      if (removedItem != null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Item Removed'),
              content: Text('Item with ID $id has been successfully removed.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No item found with ID $id.'),
          ),
        );
      }
    });
  }

  void showRemoveItemDialog() {
    int? id;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                onChanged: (value) {
                  id = int.tryParse(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (id != null) {
                  removeItem(id!);
                }
                Navigator.pop(context);
              },
              child: Text('Remove',style: TextStyle(color:Colors.deepPurple),),
            ),
          ],
        );
      },
    );
  }

  int nextId = 0;

  void addItem(String title, int quantity, double price) {
    setState(() {
      if (title.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid title.'),
          ),
        );
        return;
      }
      if (quantity <= 0 || quantity != quantity.toInt()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid integer quantity.'),
          ),
        );
        return;
      }
      if (price <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid price.'),
          ),
        );
        return;
      }
      if (containsNumbers(title)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The title should only contain characters.'),
          ),
        );
        return;
      }

      Item item = Item(
        id: nextId,
        title: title,
        creationDate: DateTime.now(),
        quantity: quantity.toInt(),
        price: price,
      );
      items.add(item);
      nextId++;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item added successfully.'),
        ),
      );
    });
  }

  bool containsNumbers(String text) {
    RegExp numericRegex = RegExp(r'[0-9]');
    return numericRegex.hasMatch(text);
  }

  void showAddItemDialog() {
    String title = "";
    int quantity = 0;
    double price = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? quantity;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                onChanged: (value) {
                  price = double.tryParse(value) ?? price;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addItem(title, quantity, price);
                Navigator.pop(context);
              },
              child: Text('Add',style: TextStyle(color: Colors.deepPurple),),
            ),
          ],
        );
      },
    );
  }
  List<Item> orderByAscendingId(List<Item> items) {
    items.sort((a, b) => a.id.compareTo(b.id));
    return items;
  }

  List<Item> orderByAscendingPrice(List<Item> items) {
    items.sort((a, b) => a.price.compareTo(b.price));
    return items;
  }

  List<Item> orderByAscendingQuantity(List<Item> items) {
    items.sort((a, b) => a.quantity.compareTo(b.quantity));
    return items;
  }

  void orderByDate(List<Item> items) {
    items.sort((a, b) => a.creationDate.compareTo(b.creationDate));
  }

  void sortItems(String orderType) {
    setState(() {
      selectedOrderType = orderType;

      switch (selectedOrderType) {
        case "ID":
          items = orderByAscendingId(items);
          break;
        case "Price":
          items = orderByAscendingPrice(items);
          break;
        case "Quantity":
          items = orderByAscendingQuantity(items);
          break;
        case "Date":
        default:
          orderByDate(items);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = items.length;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/rm222-mind-22.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      "Items",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.purpleAccent.shade700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(500, 0, 500, 0),
                    width: 100.0,
                    child: TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.purple.shade700,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Number of Items',
                        labelStyle: TextStyle(
                          color: Colors.purple.shade700,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple.shade700,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple.shade700,
                          ),
                        ),
                      ),
                      controller:
                          TextEditingController(text: itemCount.toString()),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 250.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type Item Title",
                            hintStyle: TextStyle(color: Colors.purple.shade700), // Set the hint text color to purple
                            prefixIcon: Icon(Icons.search, color: Colors.purple.shade700), // Set the prefix icon color to purple
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple.shade700,),),
                              focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple.shade700, // Set the border color to purple
                            ),
                          ),
                              ),


                            onSubmitted: (title) {
                            searchItemByTitle(title);
                          },
                        ),
                      ),

                      SizedBox(
                        width: 770.0,
                      ),
                      // DropdownButton(
                      //     dropdownColor:Colors.blueGrey,
                      //     hint: Text("Filter by"),
                      //     items: [
                      //       DropdownMenuItem(
                      //         value: "Date",
                      //         child: Text("Date"),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: "ID",
                      //         child: Text("ID"),
                      //       ),
                      //       DropdownMenuItem(
                      //
                      //         value: "Price",
                      //         child: Text("Price"),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: "Quantity",
                      //         child: Text("Quantity"),
                      //       ),
                      //     ],
                      //     onChanged: (value) {}),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("Order by",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent.shade700,                      ),),
                      SizedBox(
                        width: 20.0,
                      ),
                      DropdownButton(
                        dropdownColor: Colors.white,
                        value: selectedOrderType,
                        items: [
                          DropdownMenuItem(
                            value: "Date",
                            child: Text("Date"),
                          ),
                          DropdownMenuItem(
                            value: "ID",
                            child: Text("ID"),
                          ),
                          DropdownMenuItem(
                            value: "Price",
                            child: Text("Price"),
                          ),
                          DropdownMenuItem(
                            value: "Quantity",
                            child: Text("Quantity"),
                          ),
                        ],
                        onChanged: (value) {
                          sortItems(value.toString());
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.deepPurpleAccent.shade100,
                    ),
                    columns: [
                      DataColumn(label: Text("ID",style: TextStyle(color: Colors.white60),)),
                      DataColumn(label: Text("Items Title",style: TextStyle(color: Colors.white60),)),
                      DataColumn(label: Text("Creation Date",style: TextStyle(color: Colors.white60),)),
                      DataColumn(label: Text("Quantity",style: TextStyle(color: Colors.white60),)),
                      DataColumn(label: Text("Price",style: TextStyle(color: Colors.white60),)),
                    ],
                    rows: items.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item.id.toString())),
                        DataCell(Text(item.title)),
                        DataCell(Text(DateFormat('dd/MM/yyyy')
                            .format(item.creationDate))),
                        DataCell(Text(item.quantity.toString())),
                        DataCell(Text(item.price.toString())),
                      ]);
                    }).toList(),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade500,
                        ),
                        child: IconButton(
                          onPressed: clearItems,
                          icon: Icon(
                            Icons.cleaning_services,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade500,
                        ),
                        child: IconButton(
                          onPressed: showRemoveItemDialog,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade500,
                        ),
                        child: IconButton(
                          onPressed: showAddItemDialog,
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
