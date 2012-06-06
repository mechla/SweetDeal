package view_objects
{
	import assets.Button;
	import assets.ShowObject;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ConsoleLog extends ShowObject
	{
		private var _console:console_log =  new console_log();
		private var _triger:Button  = new Button(_console.trigger);
		private var _text:String =  "";
		public function ConsoleLog(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			addConsole();
		}
		private function addConsole():void{
			_console.y = _stage_height;
			_console.addChild(_triger);
			_triger.addEventListeners(showLog);
			addChild(_console);
			showText(Game.instance().params);
		}
		private function showLog(...args):void{
			_triger.removeEventListeners(showLog);
			_console.y = 50;
			_triger.addEventListeners(hideLog);
		}
		private function hideLog(e:MouseEvent):void{
			_triger.removeEventListeners(hideLog);
			_console.y = _stage_height;
			_triger.addEventListeners(showLog);
		}
		public function showText(text:String):void{
			_text = _text+"       \n "+ text;
			_console.logi.text = _text;
		}
	}
}