package
{
	import com.adobe.crypto.MD5;
	import com.adobe.protocols.dict.events.ErrorEvent;
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.net.sendToURL;
	
	
	public class Data extends EventDispatcher
	{
		protected var _gameId:String;  //przychodzi we flashvars
		
		private var _position:int;
		private var _dice1:int;
		private var _dice2:int;
		private var _throws:int;
		
		public function Data()
		{
		}
		
		public function sendThrowCubePost():void{
			var sendThrow:SendPost = new SendPost();
			var data:URLVariables = new URLVariables();
			data.gameId = _gameId;
			var date:Date = new Date();
			data.t = Math.round(date.getTime()/1000);
			if(Game.instance().test_mode)
				reciveQuestion({"dice1":3,"dice2":4,"position":7,"question_obj":{"question":"Do jakiej grupy zwierząt należy delfin?", "question_id": 123,"answer1":{"id":12,"answer":"Ryby"},"answer2":{"id":125,"answer":"Ssaki"},"answer3":{"id":44,"answer":"Płazy"}}});
			else
				sendThrow.sendPost(sendThrow.THROW_CUBE,data,reciveQuestion,true)
		}
		private function reciveQuestion(e:Object):void{
			var obj:Object; 
			if(Game.instance().test_mode)
				obj = e;
			else
				obj = JSON.decode(e.target.data)
			_dice1 = obj.dice1;
			_dice2 = obj.dice2;	
			_position =  obj.position;
			Game.instance().dice.throwDices();
			TweenLite.delayedCall(2,stopDices);
			Game.instance().question.update(obj.question_obj);
		}
		private function stopDices():void{
			Game.instance().dice.stopDices(_dice1, _dice2,_position);	
		}
		public function sendAnswer(question_id:String,answer_id:String):void{
			var sendAnswear:SendPost = new SendPost();
			var data:URLVariables = new URLVariables();
			data.gameId = _gameId;
			data.question_id = question_id;
			data.answer_id = answer_id
			var date:Date = new Date();
			data.t = Math.round(date.getTime()/1000);
			if(Game.instance().test_mode)
				reciveAnswercorrectness({"answear":"OK"});
			else
			sendAnswear.sendPost(sendAnswear.ANSWEAR,data,reciveAnswercorrectness,true)
			
		}

		private function reciveAnswercorrectness(e:Object):void{
			//Show pop up if the answear was correct
			trace("answer was correct or not");
			
		}
		public function set gameId(value:String):void
		{
			_gameId = value;
		}
		
		public function get position():int
		{
			return _position;
		}
		
		public function set position(value:int):void
		{
			_position = value;
		}		

		public function get throws():int
		{
			return _throws;
		}

		public function set throws(value:int):void
		{
			_throws = value;
		}

	}
}

