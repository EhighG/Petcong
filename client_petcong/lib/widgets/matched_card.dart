import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petcong/models/card_profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchedCard extends StatefulWidget {
  final CardProfileModel matchedUser;
  const MatchedCard({Key? key, required this.matchedUser}) : super(key: key);

  @override
  State<MatchedCard> createState() => _MatchedCardState();
}

class _MatchedCardState extends State<MatchedCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("matchedUser nickname onTap:}");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ProfileDetailPage(matchedUser: widget.matchedUser)),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.matchedUser.profileImageUrls![0],
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.matchedUser.profileImageUrls![0],
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.matchedUser.nickname,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailPage extends StatefulWidget {
  final CardProfileModel matchedUser;

  const ProfileDetailPage({Key? key, required this.matchedUser})
      : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchedUser.nickname),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.matchedUser.profileImageUrls![0],
              child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                      imageUrl: widget.matchedUser.profileImageUrls![0],
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 20),
            Text(
              widget.matchedUser.description!,
              style: const TextStyle(
                // 여기에 폰트 사이즈와 무게 추가
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Instagram 주소: ',
                  style: TextStyle(
                    // 여기에 폰트 사이즈와 무게 추가
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                        'http://www.instagram.com/${widget.matchedUser.instagramId}');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch https://instagram.com/${widget.matchedUser.instagramId}}';
                    }
                  },
                  child: Image.asset(
                    'assets/src/instagram.png',
                    width: 30, // 여기를 변경
                    height: 30, // 여기를 변경
                  ), // 이 부분을 변경
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/src/kakaotalk.png',
                  width: 30, // 원하는 크기로 조절
                  height: 30, // 원하는 크기로 조절
                ),
                const SizedBox(width: 8),
                Text(
                  ':${widget.matchedUser.kakaoId}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
