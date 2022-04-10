import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:getxpattern4/models/post_model.dart';

Card post(Post post){
  return Card(
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: ListTile(
      dense: true,
      isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child:
        CachedNetworkImage(
          imageUrl: post.imageURL,
          placeholder: (context, url) => Image.asset('assets/default.png', color: Colors.red),
          errorWidget: (context, url, error) => Image.asset('assets/default.png', color: Colors.red),
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.content + '\n', maxLines: 1, overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(post.date, maxLines: 1, overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    )
  );
}