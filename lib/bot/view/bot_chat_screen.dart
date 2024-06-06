import 'package:flutter/material.dart';
import 'package:my_gender/bot/view/widget/chat_widget.dart';
import 'package:my_gender/utils/constants/strings.dart';

import '../constant/bot_api_constant.dart';

const String _apiKey = BotApiKonstant.apiKey;

class BotChatView extends StatefulWidget {
  const BotChatView({super.key});

  @override
  State<BotChatView> createState() => _BotChatViewState();
}

class _BotChatViewState extends State<BotChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.chatWithMyGender),
      ),
      body: const ChatWidget(apiKey: _apiKey),
    );
  }
}
