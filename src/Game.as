package
{
	
	import comunication.Data;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import view_objects.ActionView;
	import view_objects.AnswerView;
	import view_objects.Board;
	import view_objects.ConsoleLog;
	import view_objects.Counter;
	import view_objects.Dice;
	import view_objects.Menu;
	import view_objects.Question;
	
	public class Game extends MovieClip
	{
		
		private static var _instance:Game =  new Game();
		private var _board:Board;
		private var _counter:Counter;
		private var _dice:Dice;
		private var _question:Question;
		private var _answer_corr:AnswerView;
		private var _action_popup:ActionView;
		private var _help_popup:ActionView;
		private var _menu:Menu;
		private var _current_position:int = 0;
		private var _data:Data = new Data();
		private var _test_mode:Boolean = false;
		private var _console:ConsoleLog;
		private var _params:String;
		public function Game()
		{
			_help_popup = new ActionView(this);
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
			_answer_corr = new AnswerView(this);
			_action_popup =  new ActionView(this);
//			this.setChildIndex(_help_popup,this.numChildren-1);
			_console  = new ConsoleLog(this,true);
			Game.instance().data.sendFriends();
			
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

		public function get answer_corr():AnswerView
		{
			return _answer_corr;
		}

		public function get action_popup():ActionView
		{
			return _action_popup;
		}

		public function get help_popup():ActionView
		{
			return _help_popup;
		}

		public function set help_popup(value:ActionView):void
		{
			_help_popup = value;
		}

		public function get params():String
		{
			return _params;
		}

		public function set params(value:String):void
		{
			_params = value;
		}

		public function get console():ConsoleLog
		{
			return _console;
		}

		public function set console(value:ConsoleLog):void
		{
			_console = value;
		}


	}
}