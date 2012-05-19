package
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	
	public class Counter extends ShowObject
	{
		private var _counter:counter = new counter();
		private var _fields:Array =  new Array();
		public function Counter(pClip:DisplayObjectContainer, canShow:Boolean=false)
		{
			super(pClip, canShow);
			createFields();
			addChild(_counter);
		}
		public function putOnField(index:int = 0):void{
			trace(_fields[index][0],_fields[index][1]);
			_counter.x = _fields[index][0];
			_counter.y = _fields[index][1];
		}
		public function moveCounter(position:int):void{
			TweenLite.to(_counter,3,{x:_fields[position][0],y:_fields[position][1], onComplete:counterFinishMove});
			
		}
		private function counterFinishMove():void{
			Game.instance().question.show();
		}
		private function createFields():void{
			_fields.push([581,530]);//0
			_fields.push([516,540]);
			_fields.push([450,540]);
			_fields.push([384,540]);
			_fields.push([317,550]);
			_fields.push([251,550]);//5
			_fields.push([185,550]);
			_fields.push([121,560]);
			_fields.push([55,650]);
			_fields.push([55,497]);
			_fields.push([50,432]);//10
			_fields.push([48,368]);
			_fields.push([44,300]);
			_fields.push([39,234]);
			_fields.push([36,170]);
			_fields.push([33,106]);//15
			_fields.push([29,42]);
			_fields.push([92,32]);
			_fields.push([158,32]);
			_fields.push([226,22]);
			_fields.push([291,22]);//20
			_fields.push([358,22]);
			_fields.push([424,11]);
			_fields.push([480,11]);
			_fields.push([555,11]);
			_fields.push([555,75]);//25
			_fields.push([559,145]);
			_fields.push([564,210]);
			_fields.push([568,274]);
			_fields.push([568,341]);
			_fields.push([572,404]);//30
			_fields.push([580,473]);
		}
	}
}