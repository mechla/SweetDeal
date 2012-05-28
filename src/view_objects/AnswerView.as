package view_objects
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import assets.ShowObject;
	import assets.Button;
	
	public class AnswerView extends ShowObject
	{
		private var _good_answer:good_answer = new good_answer();
		private var _wrong_answer:wrong_ans = new wrong_ans();
		private var _button_good:Button = new Button(_good_answer.ok);
		private var _button_bad:Button = new  Button(_wrong_answer.ok);
		private var _black_bg:Sprite = new Sprite();
		public function AnswerView(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_black_bg.graphics.beginFill(0x000000,.2);
			_black_bg.graphics.drawRect(0,0,_stage_width,_stage_height);
			_black_bg.graphics.endFill();
			addChild(_black_bg);
			_wrong_answer.x = _stage_width/2;
			_wrong_answer.y = _stage_height/2;
			_good_answer.x = _stage_width/2;
			_good_answer.y = _stage_height/2;
			addChild(_wrong_answer);
			addChild(_good_answer);
			_wrong_answer.addChild(_button_good);
			_good_answer.addChild(_button_good);s
			_button_bad.addEventListeners(hide);
			_button_good.addEventListeners(hide);
			
			
		}
		public function showWrong():void{
			_wrong_answer.visible = true;
			_good_answer.visible = false;
			super.show();
		}
		public function showGood():void{
			_wrong_answer.visible = false;
			_good_answer.visible = true;
			super.show();
		}
	}
}