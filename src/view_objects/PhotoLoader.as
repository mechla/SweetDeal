package VIEW
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.Sprite;
	
	public class PhotoLoader extends Sprite
	{
		private var _loader:LoaderMax =  new LoaderMax({name:"loader",onComplete:completeHandler});
		public function PhotoLoader()
		{
			super();
		}
		
		public function setGlory(url:String):void{
			var pict_loader:ImageLoader =  new ImageLoader("https://oxapps.pl/apps/agora/images/loga/"+url,{name:"picture"});
			_loader.append(pict_loader);
			try{
				
				_loader.load();
			}catch(e:Error){}
		}
		private function completeHandler(e:LoaderEvent):void{
			var flag:Sprite = _loader.getContent("picture");
			addChild(flag);
		}
	}
}