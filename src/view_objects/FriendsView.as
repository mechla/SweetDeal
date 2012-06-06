package view_objects
{
	import assets.ShowObject;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.DisplayObjectContainer;
	
	public class FriendsView extends ShowObject
	{
		private var _count:int = 0;
		private var _position:int = 0;
		public function FriendsView(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
		}
		public function createFriend(f:Object,last:Boolean = false):void{
			if(_count < 5){
				var friend:FriendView =  new FriendView(this,true);
				if(_count==4)
					last = true;
				friend.init(f,last)
				friend.y = _position;
				_position+=30;
				_count++;
			}
		}
	}
}
