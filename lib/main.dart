import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notion_sample/api/notion_oauth_api.dart';
import 'package:notion_sample/env/env.dart';
import 'package:notion_sample/provider/notion_auth_provider.dart';
import 'package:notion_sample/provider/webview_provider.dart';
import 'package:notion_sample/widget/notion_database_list_widget.dart';
import 'package:notion_sample/widget/notion_login_webview_widget.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyApp();
}

class _MyApp extends ConsumerState<MyApp> {
  StreamSubscription? _sub;
  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    _sub = linkStream.listen((link) async {
      if (link != null &&
          link.startsWith('notionsample://oauth/callback?code')) {
        await ref.read(notionOauthApiProvider).authenticate(link);
        ref.invalidate(notionAuthProvider);
      }
    }, onError: (e) {
      ref.read(webViewProvider.notifier).error(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final notionAuthAsync = ref.watch(notionAuthProvider);
    final notionAuthNotifier = ref.read(notionAuthProvider.notifier);
    final webview = ref.watch(webViewProvider);
    final webviewNotifier = ref.read(webViewProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (notionAuthAsync is AsyncLoading) {
        ref.read(notionAuthProvider.notifier).getNotionWorkspace();
      }
    });
    if (webview.isOpen) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                  title: Row(children: [
                IconButton(
                  icon: const Icon(Icons.close_outlined, color: Colors.black),
                  onPressed: () => webviewNotifier.hide(),
                ),
                const Center(child: Text("Notionと連携")),
              ])),
              body: Column(children: [
                Expanded(
                    child: Stack(children: <Widget>[
                  const NotionLoginWebviewWidget(),
                  webview.isError
                      ? Center(child: Text(webview.errorText))
                      : webview.isLoading
                          ? Container(
                              color: Colors.white,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Container()
                ]))
              ])));
    } else {
      return MaterialApp(
          home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Notion Sample'),
        ),
        body: notionAuthAsync.when(
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (notionAuth) {
            if (notionAuth.isAuth) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${notionAuth.workspaceName}'),
                    const SizedBox(height: 10),
                    notionAuth.workspaceIcon != null
                        ? Image.network(notionAuth.workspaceIcon!)
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await notionAuthNotifier.deleteNotionWorkspace();
                      },
                      child: const Text('連携を解除'),
                    ),
                    const SizedBox(height: 10),
                    const NotionDatabaseListWidget()
                  ],
                ),
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // webview使うときはこっち
                    // webviewNotifier.show();
                    //  url_launcher使うときはこっち
                    if (await canLaunchUrl(Uri.parse(Env.notionOauthUrl))) {
                      await launchUrl(Uri.parse(Env.notionOauthUrl));
                    }
                  },
                  child: const Text('Notionと連携する'),
                ),
              );
            }
          },
        ),
      ));
    }
  }
}
