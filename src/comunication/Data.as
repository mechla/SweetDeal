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
		private var _gameId:String;  //przychodzi we flashvars
		private var _friends:Array = new Array();
		private var _position:int;
		private var _points:int =0;
		private var _new_position:int;
		private var _change_position:int;
		private var _dice1:int;
		private var _dice2:int;
		private var _throws:int =0;
		private var _new_throws:int;
		
		private var _ACTION:String;
		private var _QUESTION:String = "question";
		private static var _THROWS:String  = "throws";
		private static var _MOVE:String =  "move";
		private var _NONE:String = "none";
		
		public function Data()
		{
		}
		//rzut kostką
		public function sendFriends():void{
			var sendFriends:SendPost  = new SendPost();
			var data:URLVariables = new URLVariables();
			data.gameId = _gameId;
			sendFriends.sendPost(sendFriends.FRIENDS,data, reciveFriends,true);
		}
		private function reciveFriends(e:Object):void{
			var obj:Array = JSON.decode(e.target.data);
			for each (var o:Object in obj){
				trace(o.name);
				_friends.push(o);
			}
			Game.instance().menu.addFriends();
		}
		public function sendThrowCubePost():void{
			var sendThrow:SendPost = new SendPost();
			var data:URLVariables = new URLVariables();
			trace(data);
			data.gameId = _gameId;
			var date:Date = new Date();
			data.t = Math.round(date.getTime()/1000);
			if(Game.instance().test_mode){
				//				reciveQuestion({"dice1":1,"dice2":6,"points":"10280","position":"13","throws":"99","points":"240","question":null,"message":"Dzi\u0119ki skorzystaniu z oferty na SweetDeal odwiedzisz Hiszpani\u0119 40% taniej."});
				//				reciveQuestion({"dice1":3,"dice2":4,"position":7,"throws_left":0,"throws_obj":{"message":"Dostajesz dodatkowy rzut","new_throws_left":1}});
				//				reciveQuestion({"dice1":3,"dice2":4,"position":7,"throws_left":0,"move_obj":{"message":"Cofasz sie o 3 pola","new_position":4}});
				//				reciveQuestion({"dice1":3,"dice2":4,"position":7,"throws_left":0,"question_obj":{"question":"Do jakiej grupy zwierząt należy delfin?", "question_id": 123,"answer1":{"id":12,"answer":"Ryby"},"answer2":{"id":125,"answer":"Ssaki"},"answer3":{"id":44,"answer":"Płazy"}}});
				//				reciveQuestion({"dice1":1,"dice2":1,"position":"22","throws":"0","points":"720","question":{"id":"162","question":"W Toruniu znajduje si\u0119 najwi\u0119kszy w Europie","answer":["ko\u015bci\u00f3\u0142","rynek","stadion \u017cu\u017clowy"]},"message":null});
				reciveQuestion({"dice1":3,"dice2":3,"position":"0","throws":"180","points":"3460","question":null,"message":"Min\u0105\u0142e\u015b pole Sta"});
			}
			else
				sendThrow.sendPost(sendThrow.THROW_CUBE,data,reciveQuestion,true)
		}
		private function reciveQuestion(e:Object):void{
			var obj:Object =  {}; 
			try{
				if(Game.instance().test_mode)
					obj = e;
				else
					obj = JSON.decode(e.target.data)
				_dice1 = obj.dice1;
				_dice2 = obj.dice2;	
				_points = obj.points;
				_new_position =  _position+_dice1+_dice2;
				_change_position = obj.position;
				_new_throws = obj.throws;
			}
			catch(e:Error){}
			
			if(obj.question != null){
				_ACTION = _QUESTION;
				Game.instance().question.update(obj.question);
				TweenLite.delayedCall(.5,stopDices,[obj.position]);
			}
				//			else if(_change_position != _new_position){
			else{
				_ACTION = _MOVE;
				Game.instance().action_popup.update("",obj.message,updatePosition,_change_position);
				TweenLite.delayedCall(.5,stopDices,[_new_position]);
				
			}
			//			else if(_throws-1 != _new_throws){
			//				_ACTION = _THROWS;
			//				Game.instance().action_popup.update("",obj.message,updateThrows,_new_throws);
			//				TweenLite.delayedCall(.5,stopDices,[_change_position]);
			//			}
			//				
			//			else{
			//				_ACTION = _NONE;
			//				TweenLite.delayedCall(.5,stopDices,[_position]);
			//			}
		}
		public function roundFinish():void{
			_position = _change_position;
			_new_position = _change_position;
			_throws = _new_throws;
			Game.instance().menu.addClickEvent();
		}
		public function get new_throws():int
		{
			return _new_throws;
		}
		
		public function set new_throws(value:int):void
		{
			_new_throws = value;
		}
		private function updateThrows(throws:int):void{
			_ACTION = _NONE
			_throws = throws;
			Game.instance().menu.updateThrows(throws);
			roundFinish();
			
		}
		private function updatePosition(position:int):void{
			_ACTION = _NONE;
			Game.instance().counter.moveCounter(_new_position,position,position<_new_position);
			
		}
		private function stopDices(new_position:int):void{
			Game.instance().dice.stopDices(_dice1, _dice2,new_position);	
		}
		public function sendAnswer(question_id:String,answer_id:String):void{
			var sendAnswear:SendPost = new SendPost();
			var data:URLVariables = new URLVariables();
			data.question_id = question_id;
			data.gameId = _gameId;
			data.answer = answer_id
			var date:Date = new Date();
			data.t = Math.round(date.getTime()/1000);
			if(Game.instance().test_mode)
				reciveAnswercorrectness({"message":"Niestety to jest b\u0142\u0119dna odpowied\u017a!","correct":false});
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
			if(obj.correct == true){
				_points = obj.points
				_throws = obj.throws;
				Game.instance().answer_corr.showGood(obj.message);
			}
			else if (obj.correct == false)
				Game.instance().answer_corr.showWrong(obj.message)
			else
				Game.instance().answer_corr.showGood("COS NIE TAK POSZŁO");
			
			
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
		
		public function get gameId():String
		{
			return _gameId;
		}
		
		public function set gameId(value:String):void
		{
			_gameId = value;
		}
		
		public function get points():int
		{
			return _points;
		}
		
		public function set points(value:int):void
		{
			_points = value;
		}
		
		
	}
}

