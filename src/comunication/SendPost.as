package comunication
{
	
	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	
	public class SendPost extends EventDispatcher
	{
		private var _THROW_CUBE:String = "https://oxapps.pl/apps/sweetdeal/game/random";
		private var _ANSWEAR:String = "https://oxapps.pl/apps/sweetdeal/game/answer";
		private var _FRIENDS:String = "https://oxapps.pl/apps/sweetdeal/game/friends";
		
		private var _loader:URLLoader =  new URLLoader();
		private var _request:URLRequest;
		
		private var _timer:Timer =   new Timer(3000,1);
		private var _unsuccefull_count:Number = 0;
		private var _popup:Boolean =  false;
		private var _wrongpopup:Sprite;
		
		public function SendPost(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public function sendPost(target:String,data:URLVariables = null, callback:Function = null, popup:Boolean = true):void{
			_popup = popup;
			_request = new URLRequest(target);
			_request.data =  data;
			_request.method = URLRequestMethod.POST;
			
			//ERROR EVENTS HANDLER
			_loader.addEventListener(Event.OPEN, onOpen);
			_loader.addEventListener(ProgressEvent.PROGRESS, onProgress,true, 0, true);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatusEvent);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(ErrorEvent.ERROR,onError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			
			if(callback != null)
				_loader.addEventListener(Event.COMPLETE, callback, false, 0, true);
			_loader.load(_request);
			startTimer();
			Game.instance().console.showText("POST: "+target+" "+ data);
			trace("POST: "+target+" "+ data);
		}
		private function renewPost(...args):void{
			_unsuccefull_count++;
			if (_unsuccefull_count >5){
				if(_popup){
					Game.instance().console.showText("Nastapiło rozsynchronizowanie z serwerem. Odśwież gre.");
					Game.instance().action_popup.update("Uwaga","Nastapiło rozsynchronizowanie z serwerem. Odśwież gre.",refresh,1);
					Game.instance().action_popup.show();
				}
				
				trace("serwery nieczynne");
			}
			else
				_loader.load(_request);
		}
		private function refresh(...args):void{
			trace("REFRESH GAME");
			
		}
		
		private function startTimer():void{
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, renewPost);
			_timer.start();
		}
		private function timerStop():void{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, renewPost);
			_timer.stop();
		}
		protected function onComplete(evt:Event):void {
			timerStop();
			_loader.removeEventListener(Event.OPEN, onOpen);
			_loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatusEvent);
			_loader.removeEventListener(Event.COMPLETE, onComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			trace(evt.target.data);
//			Game.instance().action_popup.updateMessage("ODPOWIEDZ SERWERA:",evt.target.data);
//			Game.instance().action_popup.show();
			trace("recive data end");
			Game.instance().console.showText(evt.target.data);
		}
		
		protected function onOpen(evt:Event):void {
			trace("Loading has begun."); 
		}
		protected function onProgress(evt:ProgressEvent):void {
			trace("Answear " + Math.round((evt.bytesLoaded/evt.bytesTotal)*100) + " % loaded: " );
		}
		protected function onError(evt:HTTPStatusEvent):void{
			trace("HTTPStatusEvent: "+evt.type);
			TweenLite.delayedCall(2,renewPost);
		}
		protected function onHTTPStatusEvent(evt:HTTPStatusEvent):void {
			trace("HTTPStatusEvent: " + evt.status); 
		}
		
		protected function onSecurityError(evt:SecurityErrorEvent):void {
			trace("SecurityErrorEvent: ", evt.text); 
			TweenLite.delayedCall(1,renewPost);
		}
		
		protected function onIOError(evt:IOErrorEvent):void {
			trace("IOErrorEvent: ", evt.text) 
			TweenLite.delayedCall(1,renewPost);
		}
		
		public function get THROW_CUBE():String
		{
			return _THROW_CUBE;
		}
		
		public function get ANSWEAR():String
		{
			return _ANSWEAR;
		}

		public function get FRIENDS():String
		{
			return _FRIENDS;
		}
		
		
		
	}
}