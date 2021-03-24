import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/app/models/song_model.dart';

class MusicTile extends StatefulWidget {
  MusicTile({
    Key key,
    @required this.song,
    @required this.audioPlayer,
  }) : super(key: key);

  final Song song;
  final AudioPlayer audioPlayer;

  bool playing = false;

  @override
  _MusicTileState createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {

  String getTime(){
    int hours=0,minutes=0;
    int seconds = widget.song.seconds;
    hours=seconds~/3600;
    seconds-=hours*3600;
    minutes=seconds~/60;
    seconds-=minutes*60;
    String time='';
    if(hours!=0){
      if(hours<10)
        time+='0'+hours.toString()+':';
      else
        time+=hours.toString()+':';
      if(minutes<10)
        time+='0'+minutes.toString()+':';
      else
        time+=minutes.toString()+':';
      if(seconds<10)
        time+='0'+seconds.toString()+':';
      else
        time+=seconds.toString()+':';
    }else{
      if(seconds<10)
        time+=minutes.toString()+':0'+seconds.toString();
      else
        time+=minutes.toString()+':'+seconds.toString();
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        if (widget.playing) {
          widget.audioPlayer.stop();
          widget.playing = false;
        } else {
          await widget.audioPlayer.play(widget.song.url);
          widget.playing = true;
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.network(widget.song.songImageUrl),
        title: Text(widget.song.title,style: TextStyle(color: Theme.of(context).focusColor),),
        subtitle: Text(widget.song.author,style: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.5))),
        trailing: Text(getTime(),style: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.5))),
      ),
    );
  }
}
