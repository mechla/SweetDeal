package view_objects
{
	import assets.Button;
	import assets.ShowObject;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class ActionView extends ShowObject
	{
		private var _comunicat:comunicat = new comunicat()
		private var _button_ok:Button = new Button(_comunicat.ok);
		private var _black_bg:Sprite = new Sprite();
		private var _callback:Function;
		private var _param:int;
		public function ActionView(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_black_bg.graphics.beginFill(0x000000,.2);
			_black_bg.graphics.drawRect(0,0,_stage_width,_stage_height);
			_black_bg.graphics.endFill();
			addChild(_black_bg);
			_comunicat.x = _stage_width/2;
			_comunicat.y = _stage_height/2;
			_comunicat.invite.visible = false;
			addChild(_comunicat);
			_comunicat.addChild(_button_ok);
			_button_ok.addEventListeners(hide);
		}
		public function showInviteFriends():void{
			_comunicat.invite.visible = true;
		}
		public function update(title:String,message:String,callback:Function,param:int):void{
			_comunicat.title.text = title;
			_comunicat.message.text = message; 
			_callback = callback;
			_param = param;
		}
		public function updateMessage(title:String,message:String):void{
			_comunicat.title.text = title;
			_comunicat.message.text = message; 
		}
		override public function hide(...params):void{
			super.hide();
			if(_callback !=null)
				_callback(_param);
		}
	}
}