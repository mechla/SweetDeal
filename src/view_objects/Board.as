package view_objects
{
	import assets.ShowObject;
	
	import flash.display.DisplayObjectContainer;
	
	public class Board extends ShowObject
	{
		private var _board:plansza = new plansza()
		private var _cards:cards =  new cards();
		public function Board(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_board.x = 1;
			_board.y = -11;
			addChild(_board);
			
			_cards.x = 339;
			_cards.y = 301;
			addChild(_cards);
		}
	}
}