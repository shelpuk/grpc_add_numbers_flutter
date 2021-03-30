import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_add_numbers_flutter/grpc/add.pbgrpc.dart';

void main() => runApp(MaterialApp(
    home: Home()
)
);


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int result = 0;
  int a, b;

  SumClient client = SumClient(
      ClientChannel('192.168.0.246', port:50051,
          options:ChannelOptions(credentials: ChannelCredentials.insecure())));

  void _callGrpcService() async {
    var response = await client.add(SumRequest(a: a, b: b));
    setState(() {
      result = response.sum;
    });
  }

  final textInputDecoration = InputDecoration(
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white,
              width: 2
          )

      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.pink,
              width: 2
          )
      )
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add numbers with gRPC server'),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              // color: Colors.cyan,
              child: TextField(
                onChanged: (String value) {
                  if (value.length != 0) {
                    a = int.parse(value);
                  }
                  else {
                    a = 0;
                  }
                },
                decoration: textInputDecoration.copyWith(hintText: 'Enter a'),
                style: TextStyle(
                  fontSize: 30,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (String value) {
                  if (value.length != 0) {
                    b = int.parse(value);
                  }
                  else {
                    b = 0;
                  }
                },
                decoration: textInputDecoration.copyWith(hintText: 'Enter b'),
                style: TextStyle(
                  fontSize: 30,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(30),
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue[600], borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                        onPressed: _callGrpcService,
                        // style: ButtonStyle(
                        //   backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[800])
                        // ),
                        child: Text('Add them up',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey[50]
                            ))
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              // color: Colors.yellow[100],
              child: Text('$result',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.grey[600]
                ),
              ),
            )
          ]
      ),
    );
  }
}




