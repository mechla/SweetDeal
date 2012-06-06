package view_objects
{
	import assets.ShowObject;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class FriendView extends ShowObject
	{
		//		private var _loader:LoaderMax =  new LoaderMax({name:"loader",onComplete:completeHandler});
		public function FriendView(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			this.filters = [ new DropShadowFilter(.5,45,0x000000,.9,2,2)];
		}
		public function init(f:Object,last:Boolean = false):void{
			//			var url:String = "https://graph.facebook.com/"+f.facebook_id+"/picture";
			//			var pict_loader:ImageLoader =  new ImageLoader(url,{name:"picture"});
			//			_loader.append(pict_loader);
			//			_loader.load();
			
			var friend:friend_view = new friend_view()
			if(!last)
				friend.freind_name.text = f.name+",";
			else
				friend.freind_name.text = f.name;
			
			friend.x = 15;
			addChild(friend);
		}
		private function completeHandler(e:LoaderEvent):void{
			//			var image:Sprite = _loader.getContent("picture");
			//			image.scaleX = image.scaleY = .5;
			//			image.y = -20;
			//			image.x = -15;
			//			addChild(image);
		}
	}
}