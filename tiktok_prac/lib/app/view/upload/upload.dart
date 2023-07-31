import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:modu_tiktok/app/data/model/video.dart';
import 'package:modu_tiktok/app/data/service/auth_service.dart';
import 'package:video_player/video_player.dart';

class UploadScreen extends StatefulWidget {
  @override
  createState() => _UploadScreenState();
}

class _UploadScreenState extends State {
  File? _videoFile;

  final TextEditingController _videoTitleController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();
  ImagePicker imgPick = ImagePicker();

  VideoPlayerController? _videoPlayerController;
  bool _isUploading = false;

  @override
  void dispose() {
    _videoTitleController.dispose();
    _songNameController.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _selectVideo() async {
    final file = await imgPick.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState((){
        _videoFile = File(file.path);
        _videoPlayerController = VideoPlayerController.file(_videoFile!);
          ..initialize().then((_){
            setState(( {}));
          });
      });
    }
  }

  Future _uploadVideo() async {
    if(_videoFile == null){
      return;
    }

    setState((){
      _isUploading = true;
    });
    final currentUserUuid = await getCurrentUserUuid();
    final currentUserName = await getCurrentUserName();
    final profileImageUrl = await getProfileImageUrl(currentUserUuid.toString());
    Logger().d(profileImageUrl);

    try{
      final videoUrl = await uploadVideoToFirestore(_videoFile!);
      final video = Video(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        user: currentUserName.toString(),
        userPic: profileImageUrl.toString(),
        videoTitle: _videoTitleController.text,
        songName: _songNameController.text,
        likes: '0',
        comments: '0',
        url: videoUrl,
        );

        await FirebaseFirestore.instance.collection('Videos').doc(video.id).set({
          'user': video.user,
          'userPic': video.userPic,
          'video_title': video.videoTitle,
          'song_name': video.songName,
          'likes': video.likes,
          'comments': video.comments,
          'url': video.url,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video iploaded successfully')),
        );

        setState((){
          _videoFile = null;
          _videoPlayerController?.dispose();
          _videoTitleController.clear();
          _songNameController.clear();
        });
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading video: $error')),
      );
    }finally{
      setState((){
        _isUploading = false;
      });
    }
  }

  Future uploadVideoToFirestore(File videoFile) async {
    try{
      final storageRef = FirebaseStorage.instance.ref().child('videos');
      final uploadTask = storageRef.child('${DateTime.now()}.mp4').putFile(videoFile);

      final snapshot = await uploadTask;
      final videoUrl = await snapshot.ref.getDownloadURL();

      final videoUrl;
    } catch (error){
      throw PlatformException(
        code: 'VIDEO_UPLOAD_ERROR',
        message: 'Failed to upload video: $error',
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video'),
      ),
      body: SingChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _selectVideo,
                child: Text('Select Video'),
              ),
              SizedBox(height: 16.0),
              _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    )
                  : Container(),
              SizedBox(height: 16.0),
              TextField(
                controller: _videoTitleController,
                decoration: InputDecoration(
                  labelText: 'Video Title',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _songNameController,
                decoration: InputDecoration(
                  labelText: 'Song Name',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadVideo,
                child: _isUploading
                    ? CircularProgressIndicator()
                    : Text('Upload Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
