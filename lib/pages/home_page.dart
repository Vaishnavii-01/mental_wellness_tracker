import 'dart:async';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://picsum.photos/id/112/600/300",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("meditation practices or mood-lifting activities"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        inputDecoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          filled: true,
          fillColor: Color.fromARGB(255, 222, 241, 245),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Type your message...",
        ),
        sendButtonBuilder: (Function() onSend) {
          return InkWell(
            onTap: onSend,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 46, 81, 88),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;

      StringBuffer responseBuffer = StringBuffer();
      StreamSubscription? subscription;

      subscription = gemini.streamGenerateContent(question).listen(
        (event) {
          String cleanResponse = _cleanResponse(event.content?.parts);
          responseBuffer.write("$cleanResponse ");
        },
        onError: (error) {
          setState(() {
            messages = [
              ChatMessage(
                user: geminiUser,
                createdAt: DateTime.now(),
                text: "An error occurred: $error",
              ),
              ...messages,
            ];
          });
          subscription?.cancel();
        },
        onDone: () {
          String finalResponse = responseBuffer.toString().trim();

          ChatMessage responseMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: finalResponse,
          );

          setState(() {
            messages = [responseMessage, ...messages];
          });
        },
      );
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  String _cleanResponse(List<dynamic>? parts) {
    if (parts == null) return "";

    return parts
        .map((part) {
          return part.text.replaceAll(RegExp(r'\*|~|\[.*?\]'), '').trim();
        })
        .join(" ")
        .trim();
  }
}