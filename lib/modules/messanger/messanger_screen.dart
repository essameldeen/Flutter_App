import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Chats",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.camera_alt,
                    size: 16.0,
                    color: Colors.white,
                  ))),
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.edit,
                    size: 16.0,
                    color: Colors.white,
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300]),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("Search...")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 100.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => buildStoryItem(),
                ),
              ),),

            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemBuilder: (context,index)=>buildChatItem(),
                separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                itemCount: 10)

          ],
        ),
      ),
    );
  }

  Widget buildChatItem() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: const [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                  child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Essam ElDeen Mohamed El Sayed Ibrhaim",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Hi Im try to connect with u , please try to connect with me ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                      ),
                      const Text("2:00 Am"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget buildStoryItem() => Row(
        children: [
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2F&psig=AOvVaw0pK3x5_AMy__ZFFNdnRmkp&ust=1676666010395000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOil-uDxmv0CFQAAAAAdAAAAABAE"),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  "Essam Mohamed",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      );
}
