package comunication
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
//		protected var _gameId:String;  //przychodzi we flashvars
		private var _friends:Array;
		private var _position:int;
		private var _new_position:int;
		private var _dice1:int;
		private var _dice2:int;
		private var _throws:int;
		
		private var _ACTION:String;
		private var _QUESTION:String = "question";
		private static var _THROWS:String  = "throws";
		private static var _MOVE:String =  "move";
		private var _NONE:String = "none";
		
		public function Data()
		{
		}
		//rzut kostką
		public function sendThrowCubePost():void{
			var sendThrow:SendPost = new SendPost();
			var data:URLVariables = new URLVariables();
//			data.gameId = _gameId;
			var date:Date = new Date();
			data.t = Math.round(date.getTime()/1000);
			if(Game.instance().test_mode){
//				reciveQuestion({"dice1":3,"dice2":4,"position":7,"throws_left":0,"throws_obj":{"message":"Dostajesz dodatkowy rzut","new_throws_left":1}});
				reciveQuestion({"dice1":3,"dice2":4,"position":7,"throws_left":0,"move_obj":{"message":"Cofasz sie o 3 pola","new_position":4}});
//				reciveQuestion({"dice1":3,"dice2":4,"position":7,"throws_left":0,"question_obj":{"question":"Do jakiej grupy zwierząt należy delfin?", "question_id": 123,"answer1":{"id":12,"answer":"Ryby"},"answer2":{"id":125,"answer":"Ssaki"},"answer3":{"id":44,"answer":"Płazy"}}});
			}
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
			_new_position =  obj.position;
			_throws = obj.throws_left;
			
			if(obj.hasOwnProperty("question_obj")){
				_ACTION = _QUESTION;
				Game.instance().question.update(obj.question_obj);
			}
			else if(obj.hasOwnProperty("throws_obj")){
				_ACTION = _THROWS;
				Game.instance().action_popup.update("",obj.throws_obj.message,updateThrows,obj.throws_obj.new_throws_left);
			}
			else if(obj.hasOwnProperty("move_obj")){
				_ACTION = _MOVE;
				trace(obj.move_obj.message);
				trace(obj.move_obj.new_position);
				Game.instance().action_popup.update("",obj.move_obj.message,updatePosition,obj.move_obj.new_position);
				
			}
			TweenLite.delayedCall(1,stopDices,[obj.position]);
		}
		private function updateThrows(throws:int):void{
			_ACTION = _NONE
			Game.instance().menu.updateThrows();
			
		}
		private function updatePosition(position:int):void{
			_ACTION = _NONE;
			Game.instance().counter.moveCounter(_position,position,position<_position);
			
		}
		private function stopDices(new_position:int):void{
			Game.instance().dice.stopDices(_dice1, _dice2,new_position);	
		}
		public function sendAnswer(question_id:String,answer_id:String):void{
			var sendAnswear:SendPost = new SendPost();
			var data:URLVariables = new URLVariables();
//			data.gameId = _gameId;
			data.question_id = question_id;
			data.answer_id = answer_id
			var date:Date = new Date();
			data.t = Math.round(date.getTime()/1000);
			if(Game.instance().test_mode)
				reciveAnswercorrectness({"answear":"OK","message":"Zdobyłeś 100 punktów!"});
			else
				sendAnswear.sendPost(sendAnswear.ANSWEAR,data,reciveAnswercorrectness,true)
			
		}
		
		private function reciveAnswercorrectness(e:Object):void{
			//Show pop up if the answear was correct
			trace("answer was correct or not");
			var obj:Object; 
			if(Game.instance().test_mode)
				obj = e;
			else
				obj = JSON.decode(e.target.data)
			
			
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
		
		public function get ACTION():String
		{
			return _ACTION;
		}
		
		public function set ACTION(value:String):void
		{
			_ACTION = value;
		}
		
		public function get QUESTION():String
		{
			return _QUESTION;
		}
		
		public function get THROWS():String
		{
			return _THROWS;
		}
		
		public function get MOVE():String
		{
			return _MOVE;
		}

		public function get friends():Array
		{
			return _friends;
		}

		public function set friends(value:Array):void
		{
			_friends = value;
		}
		
		
	}
}

