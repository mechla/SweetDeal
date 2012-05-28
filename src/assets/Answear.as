package assets
{
	public class Answear
	{
		private var _answear:String;
		private var _id:String;
		public function Answear(answear:String,id:String)
		{
			_answear = answear;
			_id = id;
		}

		public function get answear():String
		{
			return _answear;
		}

		public function set answear(value:String):void
		{
			_answear = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}


	}
}