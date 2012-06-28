package view_objects
{
	import assets.ShowObject;
	
	import com.adobe.serialization.json.JSON;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import comunication.SendPost;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	public class FriendView extends ShowObject
	{
		private var _loader:LoaderMax =  new LoaderMax({name:"loader",onComplete:completeHandler});
		
		public function FriendView(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			this.filters = [ new DropShadowFilter(.5,45,0x000000,.9,2,2)];
		}
		public function init(f:Object,last:Boolean = false):void{
			var post:SendPost =  new SendPost();
			post.sendPost("http://graph.facebook.com/"+f.facebook_id+"/?fields=picture&type=large",null,getAdress,false);
			
			var friend:friend_view = new friend_view()
			//			if(!last)
			friend.freind_name.text = f.name;
			//			else
			//				friend.freind_name.text = f.name;
			
			friend.x = 15;
			addChild(friend);
		}
		private function getAdress(e:Object):void{
			var o:Object = JSON.decode(e.target.data);
			var url:String = o.picture
			var pict_loader:ImageLoader =  new ImageLoader(url,{name:"picture"});
			_loader.append(pict_loader);
			_loader.load();
		}
		private function completeHandler(e:LoaderEvent):void{
			var avatar:Sprite =  new Sprite();
			var image:Sprite = resize(_loader.getContent("picture"),new Point(25,25));
			image.y = 13;
			image.x = 28;
			var mask:Sprite  = new Sprite()
			mask.graphics.beginFill(0x00000);
			mask.graphics.drawRect(28,13,25,25);
			mask.graphics.endFill();
			avatar.addChild(image);
			avatar.addChild(mask);
			avatar.mask = mask;
			avatar.x = -42;
			avatar.y = -32;
			addChild(avatar);
		}
		private function resize(mc:Sprite,size:Point):Sprite{
			if(mc.height>mc.width){
				var h:Number=size.x/mc.width;
				mc.width = size.x;
				mc.height=mc.height*h;
				
			}
			else{
				var w:Number=size.x/mc.height;
				mc.height = size.x;
				mc.width=mc.width*w;
				
			}
			return mc;
		}
	}
}