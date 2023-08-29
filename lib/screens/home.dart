import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/model/message.dart';
import 'package:flutter_socket_io/providers/home.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

import '../model/countries_model.dart';
import '../providers/graphQl_service.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();

  final GraphQlService graphQlService = GraphQlService();

  _sendMessage() {
    _socket.emit('room:join', {'email': widget.username, 'room': "widget.username"});
    _messageInputController.clear();
  }

  _sendMessage2() {
    _socket.emit('room:join', {'email': widget.username, 'room': "widget.username"});
    _messageInputController.clear();
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on('user:joined', (data) {
      dev.log(data, name: "user:joined");
    });
    _socket.on('room:join', (data) {
      dev.log(data, name: "room:join");
    });
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    // _socket = IO.io(
    //   'http://192.168.1.18:8081/', IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders({'userId': '12345678'}).build()
    // );
    // _socket = IO.io(
    //     'http://192.168.1.18:8000',
    //     IO.OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect()
    //         .setTimeout(10000)
    //         .setExtraHeaders({'Connection': 'Upgrade', 'Upgrade': 'websocket'}) // optional
    //         .build());

    // _socket.connect();
    // _connectSocket();
    apiCall();
  }

  apiCall() async {
    final response = await graphQlService.getContinent();
    // log(response.);
    // List<Continent> da = List<Continent>.from(response!.map((x) => Continent.fromMap(x)));
    // dev.log(da.length.toString());
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Socket.IO'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (_, provider, __) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  //   final message = provider.messages[index];
                  //   return Wrap(
                  //     alignment: message.senderUsername == widget.username ? WrapAlignment.end : WrapAlignment.start,
                  //     children: [
                  //       Card(
                  //         color: message.senderUsername == widget.username ? Theme.of(context).primaryColorLight : Colors.white,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             crossAxisAlignment: message.senderUsername == widget.username ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  //             children: [
                  //               Text(message.message),
                  //               Text(
                  //                 DateFormat('hh:mm a').format(message.sentAt),
                  //                 style: Theme.of(context).textTheme.caption,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: provider.messages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {
                        _sendMessage();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {
                        _sendMessage2();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
