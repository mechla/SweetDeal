package
{
	import flash.display.DisplayObjectContainer;
	
	public class Board extends ShowObject
	{
		private var _board:board = new board()
		public function Board(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			_board.x = -56;
			_board.y = -85;
			addChild(_board);
		}
	}
}