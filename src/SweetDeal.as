package
{
	//	import com.adobe.protocols.dict.events.ErrorEvent;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
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
			if ((paramObj['gameId'] != undefined)) {
				Game.instance().data.gameId = paramObj['gameId']
				Game.instance().data.position = paramObj['position']
				Game.instance().data.position = paramObj['throws']
			} else {
				Game.instance().data.position = 0
				Game.instance().data.gameId = '199';
				Game.instance().data.throws = '1';
			}
			
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