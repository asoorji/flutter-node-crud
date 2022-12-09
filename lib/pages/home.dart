import 'package:flutter/material.dart';
import 'package:http_methods/services/base_client.dart';
import 'package:http_methods/models/user.dart';

import '../widgets/app_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? posts;
  var isLoaded = false;

  var userController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    posts = await BaseClient().get();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: newMethod(),
    );
  }

  Widget newMethod() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: userController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: bodyController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  labelText: "Bio",
                  labelStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: AppButton(
              operation: 'POST',
              operationColor: Colors.lightBlue,
              description: 'Add user',
              onPressed: () async {
                var user = User(
                  name: userController.text,
                  body: bodyController.text,
                );

                var response = await BaseClient()
                    .post('/users', user)
                    .catchError((err) {});
                if (response == null) return;
                debugPrint('successful:');
                getData();
                userController.clear();
                bodyController.clear();
              },
            ),
          ),
          Visibility(
            visible: isLoaded,
            child: ListView.builder(
              shrinkWrap: true,
              // physics: const ClampingScrollPhysics(),
              // scrollDirection: Axis.vertical,
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              posts![index].name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              posts![index].body ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 180,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: const Icon(Icons.edit),
                                    onTap: () async {},
                                  ),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        BaseClient().delete(posts![index].id!);
                                        debugPrint(posts![index].id);
                                      });
                                      getData();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
