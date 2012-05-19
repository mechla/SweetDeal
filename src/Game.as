package
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class Game extends MovieClip
	{
		
		private static var _instance:Game =  new Game();
		private var _board:Board;
		private var _counter:Counter;
		private var _dice:Dice;
		private var _question:Question;
		private var _menu:Menu;
		private var _current_position:int = 0;
		private var _data:Data = new Data();
		private var _test_mode:Boolean = true;
		public function Game()
		{
			
		}
		public static function instance():Game
		{
			return _instance;
		}
		public function init():void{
			_board = new Board(this,true);
			_menu =  new Menu(this,true);
			_counter = new Counter(this,true);
			_counter.putOnField(_data.position);
			_dice = new Dice(this,true);
			_question = new Question(this);
			
		}

		public function get data():Data
		{
			return _data;
		}

		public function get dice():Dice
		{
			return _dice;
		}

		public function get question():Question
		{
			return _question;
		}

		public function get test_mode():Boolean
		{
			return _test_mode;
		}

		public function get counter():Counter
		{
			return _counter;
		}

		public function get menu():Menu
		{
			return _menu;
		}

		public function set menu(value:Menu):void
		{
			_menu = value;
		}


	}
}