package
{
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	[SWF(width='825',height='640',frameRate='25')]
	public class SweetDeal extends Sprite
	{
		public function SweetDeal()
		{
			super();
			if(this.stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(...args):void{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			this.addEventListener(ErrorEvent.ERROR,errorHandler);
			getFlashvars();
		}
		private function getFlashvars():void{
			root.loaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		private function loaderComplete(myEvent:Event):void {
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			//			var text_params:String = {"game_id":"6","position":"19","throws":"165","friends":"[{\"id\":\"4\",\"facebook_id\":\"1231540742\",\"name\":\"Marcin Krykwiński\"},{\"id\":\"6\",\"facebook_id\":\"1474418122\",\"name\":\"Sylwia Dyrek\"}]"}
			//			var paramObj:Object = {"game_id":"6","position":"19","throws":"165","friends":"[{\"id\":\"4\",\"facebook_id\":\"1231540742\",\"name\":\"Marcin Krykwiński\"},{\"id\":\"6\",\"facebook_id\":\"1474418122\",\"name\":\"Sylwia Dyrek\"}]"}
			Game.instance().params = JSON.encode(paramObj);
			if (paramObj['position'] != undefined) {
				Game.instance().data.position = paramObj['position']
				Game.instance().data.throws = paramObj['throws']
				Game.instance().data.gameId = paramObj['game_id']
			} else {
				Game.instance().data.position = 1;
				Game.instance().data.throws = 3;
				Game.instance().data.gameId = "6";
			}
			if(paramObj['points'] != undefined){
				Game.instance().data.points = paramObj['points']
			}else{	
				Game.instance().data.points = 0;
			}
			//			if ((paramObj['friends'] != undefined)) {
			//				Game.instance().data.friends = paramObj['friends'];
			//			}
			//			else{
			//				Game.instance().data.friends = [{"id":"6","facebook_id":"1474418122","name":"Sylwia Dyrek"}];
			Game.instance().data.friends = [];
			if (ExternalInterface.available) 
				ExternalInterface.call("updatePoints",Game.instance().data.points)
			else
				Game.instance().console.showText("EXTERNAl INTERFACE NOT EVALIABLE");
			
			//			}
			
			addChild(Game.instance());
			Game.instance().init();
		}
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			throw new Error("wywołuje UncaughtErrorEvent");
		}
		private function errorHandler(evt:Error):void
		{
			throw new Error(" wywołuje Error ");
			
		}
	}
}