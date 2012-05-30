package view_objects
{
	import assets.ShowObject;
	
	import flash.display.DisplayObjectContainer;
	
	public class Dice extends ShowObject
	{
		
		private var _dice1:dice =  new dice();
		private var _dice2:dice  = new dice();
		public function Dice(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_dice1.gotoAndStop(Math.ceil(Math.random()*7));
			_dice2.gotoAndStop(Math.ceil(Math.random()*7));
			_dice1.x = 661;
			_dice1.y = 353;
			_dice2.x = 738;
			_dice2.y = 353;
			addChild(_dice1);
			addChild(_dice2);
		}
		public function throwDices():void{
			_dice1.play();
			_dice2.play();
		}
		public function stopDices(dice1:int, dice2:int,position:int):void{
			_dice1.gotoAndStop(dice1)
			_dice2.gotoAndStop(dice2);
			trace(Game.instance().data.position,position);
			if(Game.instance().data.ACTION != "none"){
				Game.instance().counter.moveCounter(Game.instance().data.position,position);
				Game.instance().data.position = position;
			}
			
			
		}
	}
}