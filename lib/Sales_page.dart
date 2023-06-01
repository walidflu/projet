import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<Cale> sales = [];

  Widget _buildCard({
    required String title,
    required Color color,
    required IconData icon,
    required int index,
  }) {
    return MouseRegion(
      child: Card(
        elevation: 4.0,
        color: color,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(width: 16.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child : Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/rm222-mind-22.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildCard(
                          title: 'All Sales',
                          color: Colors.deepPurpleAccent.shade100,
                          icon: Icons.shopping_cart,
                          index: 0,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: _buildCard(
                          title: 'Daily Number of Sales',
                          color: Colors.deepPurpleAccent.shade100,
                          icon: Icons.calendar_today,
                          index: 1,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: _buildCard(
                          title: 'Total Incomes from Sales',
                          color: Colors.deepPurpleAccent.shade100,
                          icon: Icons.attach_money,
                          index: 2,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Row(
                children: [
                  Container(
                    height: 400,
                    width: 800,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sales Graph',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 400,
                    width: 400,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'The Best Clients',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildClientWidget(
                              icon: Icons.star,
                              color: Colors.yellow,
                              label: 'Golden Client',
                            ),
                            _buildClientWidget(
                              icon: Icons.star,
                              color: Colors.grey,
                              label: 'Silver Client',
                            ),
                            _buildClientWidget(
                              icon: Icons.star,
                              color: Color(0xFFCD7F32),
                              label: 'Bronze Client',
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildClientGraphicWidget(
                              percentage: 0.3,
                              backgroundColor: Colors.yellow,
                            ),
                            _buildClientGraphicWidget(
                              percentage: 0.65,
                              backgroundColor: Colors.grey,
                            ),
                            _buildClientGraphicWidget(
                              percentage: 0.8,
                              backgroundColor: Color(0xFFCD7F32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sales Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle delete sale action
                    },
                    child: Text('Delete Sale'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _showAddItemDialog(); // Call the method to show the add sale dialog
                    },
                    child: Text('Add Sale'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle edit sale action
                    },
                    child: Text('Edit Sale'),
                  ),
                ],
              ),
              SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            width: double.infinity,
             // Enable horizontal scrolling
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.deepPurpleAccent.shade100,
                ),
                    columns: [
                      DataColumn(
                        label: Text('Sale Number',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Date',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Product Name',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Quantity',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Unity Price',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Client Name',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Case',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Total Price',
                            style: TextStyle(color: Colors.white60)),
                      ),
                      DataColumn(
                        label: Text('Reduction Amount',
                            style: TextStyle(color: Colors.white60)),
                      ),
                    ],
                    rows: sales.asMap().entries.map((entry) {
                      final index = entry.key;
                      final sale = entry.value;
                      return DataRow(cells: [
                        DataCell(Text(index.toString())),
                        DataCell(Text(
                            DateFormat('dd/MM/yy').format(sale.creationDate))),
                        DataCell(Text(sale.product_name)),
                        DataCell(Text(sale.quantity.toString())),
                        DataCell(Text(sale.unityprice.toString())),
                        DataCell(Text(sale.client_name)),
                        DataCell(Text(sale.cas)),
                        DataCell(Text(sale.price.toString())),
                        DataCell(Text(sale.reductionAmount.toString())),
                      ]);
                    }).toList(),
                  ),
                ),
              ),

            ],

          ),
        ),

    );
  }

  Widget _buildClientWidget(
      {required IconData icon, required Color color, required String label}) {
    return Column(
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildClientGraphicWidget(
      {required double percentage, required Color backgroundColor}) {
    return Container(
      width: 60.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: percentage,
          child: Container(
            color:backgroundColor,
          ),
        ),
      ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String unitPrice = '';
        String quantity = '';
        String reduction = '';
        String product_name = '';
        String client = '';
        String? cas = 'Pending'; // Default value

        return AlertDialog(
          title: Text('Add Sale'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Product Name'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  product_name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  unitPrice = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Client Name'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  client = value;
                },
              ),
              DropdownButton<String>(
                value: cas,
                items: [
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text(
                      'Pending',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Delivered',
                    child: Text(
                      'Delivered',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    cas = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Reduction'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  reduction = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String date = DateTime.now().toString();
                String saleNumber = _generateSaleNumber();
                double unitPriceValue = double.tryParse(unitPrice) ?? 0.0;
                int quantityValue = int.tryParse(quantity) ?? 0;
                double reductionValue = double.tryParse(reduction) ?? 0.0;
                double totalPrice = (unitPriceValue * quantityValue) -
                    (unitPriceValue * quantityValue * reductionValue);

                addSales(product_name, client, date, saleNumber, unitPriceValue,
                    quantityValue, reductionValue, totalPrice, cas!);

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void addSales(
      String product,
      String client,
      String date,
      String saleNumber,
      double unitPrice,
      int quantity,
      double reduction,
      double totalPrice,
      String cas) {
    setState(() {
      if (product.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid product name.'),
          ),
        );
        return;
      }
      if (client.isEmpty) {
        // Check if client name is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid client name.'),
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
      if (unitPrice <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid price.'),
          ),
        );
        return;
      }
      if (totalPrice <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid unity price.'),
          ),
        );
        return;
      }
      if (containsNumbers(product)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The product name should only contain characters.'),
          ),
        );
        return;
      }
      if (containsNumbers(client)) {
        // Check if client name contains numbers
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The client name should only contain characters.'),
          ),
        );
        return;
      }

      Cale sale = Cale(
        product_name: product,
        cas: cas,
        creationDate: DateTime.now(),
        quantity: quantity.toInt(),
        price: totalPrice,
        unityprice: unitPrice,
        client_name: client, // Assign client name
      );
      sales.add(sale);

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

  String _generateSaleNumber() {
    int saleNumber = sales.length + 1;
    return saleNumber.toString();
  }
}

class Cale {
  final String product_name;
  final String cas;
  final String client_name; // New attribute
  final DateTime creationDate;
  int quantity;
  double price;
  double unityprice;
  double reductionAmount;
  Cale({
    required this.product_name,
    required this.cas,
    required this.client_name, // New attribute
    required this.creationDate,
    this.quantity = 0,
    this.price = 0,
    this.unityprice = 0,
    this.reductionAmount = 0.0,
  });
}
