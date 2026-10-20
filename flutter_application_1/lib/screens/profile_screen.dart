import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TO DO: 1.Deklasrasi variabel yang dibutuhkan
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  int favoriteCandiCount = 0;
  // TODO: 5. Implementasi fungsi signIn
void signIn() {
  setState(() {
    isSignedIn = !isSignedIn;
  });
}
// TODO: 6. Implementasi fungsi signOut
void signOut() {
  setState(() {
    isSignedIn = !isSignedIn;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Column(
            children: [
              // TO DO: 2. Membuat widget untuk menampilkan foto profil
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200 - 50),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'images/placeholder_image.png',
                          ),
                        ),
                      ),
                      if (isSignedIn)
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.deepPurple[50],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // TO DO: 3. Membuat bagian profileinfo yang berisi informasi profil
              ProfileInfoItem(
                icon: Icons.lock,
                label: 'Pengguna',
                value: userName,
                iconColor: Colors.amber,
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.deepPurple[10]),
              // SizedBox, Divider, SizedBox
              ProfileInfoItem(
                icon: Icons.person,
                label: 'Nama',
                value: fullName,
                showEditIcon: isSignedIn,
                onEditPressed: () => debugPrint('Icon edit ditekan'),
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.deepPurple[10]),
              // SizedBox, Divider, SizedBox
              ProfileInfoItem(
                icon: Icons.favorite,
                label: 'Favorit',
                value: favoriteCandiCount > 0 ? '$favoriteCandiCount' : '',
                iconColor: Colors.red,
              ),

              // TO DO: 4. Membuat bagian profileaction yang berisi tombol sign out/in
              const SizedBox(height: 4),
              Divider(color: Colors.deepPurple[10]),
              const SizedBox(height: 20),
              isSignedIn
              ? TextButton(onPressed: signOut, child: const Text('Sign Out'))
              : TextButton(onPressed: signIn,   child: const Text('Sign In')),
            ],
          ),
        ],
      ),
    );
  }
}
