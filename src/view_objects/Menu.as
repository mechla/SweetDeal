package view_objects
{
	import assets.Button;
	import assets.ShowObject;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Menu extends ShowObject
	{
		private var _friends_bg:friends =  new friends();
		private var _invite_friends:Button = new Button(new invite());
		private var _no_friends:no_friends = new no_friends();
		private var _throw_cube_button:Button = new Button(new throw_cube());
		private var _left_throws:throw_left = new throw_left();
		public function Menu(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			init();
		}
		public function init():void{
			addFriends();
			addThrowCube();
			addLeftThrows();
		}
		private function addLeftThrows():void{
			_left_throws.x = 660;
			_left_throws.y = 472;
			addChild(_left_throws);
			_left_throws.left.text = Game.instance().data.throws.toString();
			var s_sign:s =  new s()
			s_sign.x = 698;
			s_sign.y = 518;
			addChild(s_sign);
		}
		public function updateThrows():void{
			_left_throws.left.text = Game.instance().data.throws.toString();
		}
		private function addFriends():void{
			_friends_bg.x = 513;
			_friends_bg.y = -55;
			addChild(_friends_bg)
			var friends:Array = Game.instance().data.friends
			if(friends.length > 0){
				var friends_view:Sprite = new Sprite();
				var posiition:int = 0;
				for each(var f:Object in friends){
					trace(f.name)
					var friend:friend_view = new friend_view()
					friend.freind_name.text = f.name;
					friend.y = posiition;
					friends_view.addChild(friend);
					posiition+=20;
					
				}
				friends_view.x = 653;
				friends_view.y = 118;
				addChild(friends_view);
			}
			else{
				_no_friends.x = 643
				_no_friends.y = 174;
				addChild(_no_friends);
			}
			
			_invite_friends.x = 522
			_invite_friends.y = -26
			addChild(_invite_friends);
			
		}
		private function addThrowCube():void{
			_throw_cube_button.x = 663;
			_throw_cube_button.y = 418;
			addChild(_throw_cube_button);
			addClickEvent();
		}
		public function addClickEvent():void{
			if(Game.instance().data.throws>0)
				_throw_cube_button.addEventListeners(throwClick);	
			else{
//				Game.instance().action_popup.updateMessage("Skończyły ci się rzuty.","Zaproś znajomych, albo zagraj w gre jutro");
//				Game.instance().action_popup.showInviteFriends();
//				Game.instance().action_popup.show();
				trace("NIE MASZ JUZ RZUTÓW");
			}
		}
		private function throwClick(e:MouseEvent):void{
			_throw_cube_button.removeEventListeners(throwClick);
			Game.instance().dice.throwDices();
			Game.instance().data.sendThrowCubePost();
			Game.instance().dice.throwDices();
			Game.instance().menu.updateThrows()
			
		}
	}
}