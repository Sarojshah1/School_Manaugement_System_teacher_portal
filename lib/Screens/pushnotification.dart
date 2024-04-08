import 'package:web_socket_channel/web_socket_channel.dart';

// final channel = WebSocketChannel.connect(
//   Uri.parse('ws:http://192.168.56.1:7000/send-notification'),
// );

void sendNotification(String message) {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://192.168.56.1:7000/send-notification'),
  );


  channel.sink.add(message);
  print(message);
  channel.sink.close();
}
