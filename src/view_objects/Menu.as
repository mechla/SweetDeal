package view_objects
{
	import assets.Button;
	import assets.ShowObject;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.controls.Menu;
	
	public class Menu extends ShowObject
	{
		private var _friends_bg:friends =  new friends();
		private var _friends_container:Sprite  = new Sprite();
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
			//			addFriends();
			addChild(_friends_container);
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
		public function updateThrows(throws:int):void{
			_left_throws.left.text = throws.toString();
		}
		public function addFriends():void{
			_friends_bg.x = 513;
			_friends_bg.y = -55;
			_friends_container.addChild(_friends_bg)
			var friends:Array = Game.instance().data.friends
			if(friends.length > 0){
				var posiition:int = 0;
				var index:int = 5;
				var friends_view:FriendsView =  new FriendsView(_friends_container,true);
				var lenght:int = friends.length
				for each(var f:Object in friends){
					lenght--;
					index--;
					trace(f.name)
					friends_view.createFriend(f,lenght==0);
				}
				friends_view.x = 653;
				friends_view.y = 118;
			}
			else{
				_no_friends.x = 643
				_no_friends.y = 174;
				_friends_container.addChild(_no_friends);
			}
			
			_invite_friends.x = 522
			_invite_friends.y = 0;
			_friends_container.addChild(_invite_friends);
			_invite_friends.addEventListeners(inviteFriends);
			
		}
		private function inviteFriends(e:MouseEvent):void{
			ExternalInterface.call("inviteFriends");
		}
		private function addThrowCube():void{
			_throw_cube_button.x = 663;
			_throw_cube_button.y = 418;
			addChild(_throw_cube_button);
			addClickEvent();
		}
		public function addClickEvent():void{
			_throw_cube_button.addEventListeners(throwClick);	
			ExternalInterface.call("updatePoints",Game.instance().data.points)
			try{
				Game.instance().menu.updateThrows(Game.instance().data.throws);
			}
			catch(e:Error){
				trace(e.message);
			}
		}
		private function throwClick(e:MouseEvent):void{
			if(Game.instance().data.throws>0){
				_throw_cube_button.removeEventListeners(throwClick);
				Game.instance().dice.throwDices();
				Game.instance().data.sendThrowCubePost();
				Game.instance().dice.throwDices();
				Game.instance().data.throws --
					Game.instance().menu.updateThrows(Game.instance().data.throws)
			}
			else{
				Game.instance().action_popup.updateMessage("Nie masz rzutów!", "Skończyły się rzuty, zagraj jutro lub zaproś znajomych.");
				Game.instance().action_popup.show();
				trace("NIE MASZ JUZ RZUTÓW");
				
			}
		}
	}
}