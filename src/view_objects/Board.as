package view_objects
{
	import flash.display.DisplayObjectContainer;
	import assets.ShowObject;
	
	public class Board extends ShowObject
	{
		private var _board:board = new board()
		private var _cards:cards =  new cards();
		public function Board(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_board.x = -56;
			_board.y = -85;
			addChild(_board);
			
			_cards.x = 339;
			_cards.y = 301;
			addChild(_cards);
		}
	}
}