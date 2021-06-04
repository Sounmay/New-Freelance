import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_booking_app/Providers/cartServices.dart';
import 'package:freelance_booking_app/Providers/parlourServices.dart';
import 'package:provider/provider.dart';

class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final args =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;
    final id = args['id'];
    var mostAvailed = Provider.of<ParlourServices>(context)
        .findById(id)
        .mostAvailservices
        .toList();
    final cart = Provider.of<CartService>(context);
    final service = Provider.of<CartService>(context).services;
    final gst1 = service[id] != null ? service[id].subtotal * 0.08 ?? 0 : 0;
    final gst2 = service[id] != null ? service[id].subtotal * 0.08 ?? 0 : 0;
    final time = service[id] != null ? service[id].time : 0;
    final int minute = time % 60;
    final int hours = (time / 60).floor();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF0F2735),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Book your appointment',
                    style: TextStyle(fontSize: 18.0, letterSpacing: 1.0)),
              ),
            ],
          )),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/croppedParlour.png',
                      height: 60,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10.0, 25.0, 0.0, 0.0),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.scissors,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Perfect Salon',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Container(
                    height: height * 0.05,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Most available services",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                cart.removeAllServices(id);
                              },
                              child: Text(
                                "Clear",
                                style: TextStyle(color: Colors.grey),
                              ))
                        ]),
                  )),
              mostAvailed.length != 0
                  ? Container(
                      height: height * 0.26,
                      child: ListView.builder(
                          itemCount: mostAvailed.length,
                          itemBuilder: (ctx, i) => Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Container(
                                        height: 30,
                                        width: 2.3,
                                        color: Color(0xff5D5FEF),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mostAvailed[i]["serviceName"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "₹ " +
                                                "${mostAvailed[i]["price"]}" +
                                                " | " +
                                                "${mostAvailed[i]["time"]}" +
                                                "min",
                                            style: TextStyle(
                                                color: Color(0xFF606572)),
                                          )
                                        ],
                                      ),
                                    ]),
                                    service[id] != null &&
                                            service[id].serviceName.contains(
                                                mostAvailed[i]["serviceName"])
                                        ? SizedBox(
                                            height: 30,
                                            width: 60,
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff02CF96),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "Added",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        : SizedBox(
                                            height: 30,
                                            width: 50,
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff5D5FEF),
                                                ),
                                                onPressed: () {
                                                  cart.addServices(
                                                      id,
                                                      mostAvailed[i]
                                                          ["serviceName"],
                                                      mostAvailed[i]["price"],
                                                      mostAvailed[i]["time"]);
                                                },
                                                child: Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                  ],
                                ),
                              )))
                  : Container(
                      height: height * 0.2,
                      child: Center(child: CircularProgressIndicator())),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Services',
                      style: TextStyle(
                          color: Colors.indigo[400],
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    TextButton(
                      child: Text(
                        'Check Catalogue',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF0F2735),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              service[id] != null
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: height * 0.12,
                      color: Color(0xFFF7F7F7),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: service[id].serviceName.length,
                        itemBuilder: (ctx, i) => Container(
                            height: 20,
                            decoration: BoxDecoration(
                                color: Color(0xff5D5FEF),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.all(5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(service[id].serviceName[i],
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: 30,
                                      width: 1.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                              "₹ ${service[id].price[i]}",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: IconButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              cart.removeServices(
                                                id,
                                                service[id].serviceName[i],
                                              );
                                            },
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.white)),
                                              child: Icon(
                                                Icons.close_outlined,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ])),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 6),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      color: Color(0xFFF7F7F7),
                      height: height * 0.12,
                      child: null,
                    ),
              SizedBox(height: 10.0),
              Container(
                height: height * 0.28,
                color: Color(0xFFF7F7F7),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal Amount",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              )),
                          Text(
                              service[id] != null
                                  ? "${service[id].subtotal}"
                                  : "0",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GST 1 ( 8% )",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              )),
                          Text(service[id] != null ? "$gst1" : "0",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GST 2 ( 8% )",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              )),
                          Text(
                              service[id] != null &&
                                      service[id].subtotal != null
                                  ? "$gst2"
                                  : "0",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Net Amount",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              service[id] != null &&
                                      service[id].subtotal != null
                                  ? "₹ ${service[id].subtotal + gst1 + gst2}/-"
                                  : "0",
                              style: TextStyle(
                                  color: Color(0xff5D5FEF),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("For 3 services",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                          Row(children: [
                            Text("Duration : ",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                            Text(
                                service[id] != null && service[id].time != null
                                    ? "$hours hr $minute min"
                                    : "0",
                                style: TextStyle(
                                    color: Color(0xff5D5FEF),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                          ])
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Slot booking',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF0F2735),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/slotBooking');
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                            child: Text(
                              'Emergency booking',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff5D5FEF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {},
                          )
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}