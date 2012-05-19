package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Question extends ShowObject
	{
		private var _question:String;
		private var _id:String;
		private var _answears:Array;
		
		private var _black_bg:Sprite = new Sprite();
		private var _bg:question_popup = new question_popup();
		private var _ok_button:Button =  new Button(_bg.ok_button);
		
		private var _answer1:answer_bg =  new answer_bg();
		private var _answer2:answer_bg =  new answer_bg();
		private var _answer3:answer_bg =  new answer_bg();
		
		private var _user_answer:int;
		public function Question(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_black_bg.graphics.beginFill(0x000000,.2);
			_black_bg.graphics.drawRect(0,0,_stage_width,_stage_height);
			_black_bg.graphics.endFill();
			addChild(_black_bg);
			_bg.x = _stage_width/2;
			_bg.y = _stage_height/2;
			addChild(_bg)
			_bg.addChild(_ok_button);
			
			_answer1.x = -34;
			_answer2.x = -34;
			_answer3.x = -34;
			_answer1.y = -54;
			_answer2.y = -7;
			_answer3.y = 38;
			_bg.addChild(_answer1);
			_bg.addChild(_answer2);
			_bg.addChild(_answer3);
			_answer1.name = "1"
			_answer2.name = "2"
			_answer3.name = "3"
			_answer1.mouseChildren = false;
			_answer2.mouseChildren = false;
			_answer3.mouseChildren = false;
		}
		private function okClicked(e:MouseEvent):void{
			if(_user_answer!=0){
				_ok_button.removeEventListeners(okClicked);
				_answer1.removeEventListener(MouseEvent.CLICK, answerClicked);
				_answer2.removeEventListener(MouseEvent.CLICK, answerClicked);
				_answer3.removeEventListener(MouseEvent.CLICK, answerClicked);
				this.hide();
				Game.instance().data.sendAnswer(_id,_answears[_user_answer-1][1]);
			}
		}
		public function addAnswear(answear:String,id:String):void{
			_answears.push(new Answear(answear, id));
		}
		public function update(o:Object):void{
			_user_answer=0;
			_question = o.question;
			_id = o.question_id;
			_answears = new Array();
			_answears.push([o.answer1.answer, o.answer1.id]);
			_answears.push([o.answer2.answer, o.answer2.id]);
			_answears.push([o.answer3.answer, o.answer3.id]);
			renderView();
		}
		private function renderView():void{
			
			_bg.question.text = _question;
			_answer1.answer.text = _answears[0][0];
			_answer2.answer.text = _answears[1][0];
			_answer3.answer.text = _answears[2][0];
			
			
		}
		private function answerClicked(e:MouseEvent):void{
			_answer1.check.visible = false;
			_answer2.check.visible = false;
			_answer3.check.visible = false;
			_user_answer = e.target.name;
			e.target.check.visible = true;
		}
		private function addEventsListeners():void{
			_answer1.check.visible = false;
			_answer2.check.visible = false;
			_answer3.check.visible = false;
			_ok_button.addEventListeners(okClicked);
			_answer1.addEventListener(MouseEvent.CLICK, answerClicked);
			_answer2.addEventListener(MouseEvent.CLICK, answerClicked);
			_answer3.addEventListener(MouseEvent.CLICK, answerClicked);
		}
		override public function show(...args):void{
			addEventsListeners();
			super.show();
		}
		public function get question():String
		{
			return _question;
		}
		public function set question(value:String):void
		{
			_question = value;
		}
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get answears():Array
		{
			return _answears;
		}
		
		public function set answears(value:Array):void
		{
			_answears = value;
		}
		
		
	}
}

//	"dice1":3,
//	"dice2":4,
//	"position":10,
//	"question_obj":{
//		"question":"Ile masz lat?", "question_id": 123,
//		"answer1":{
//			"id":12,
//			"answer":"15"
//		},
//		"answer2":{
//			"id":125,
//			"answer":"18"
//		},
//		"answer3":{
//			"id":44,
//			"answer":">60"