package view_objects
{
	import assets.ShowObject;
	
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
		public function moveCounter(start:int,new_position:int,back:Boolean = false):void{
			if(new_position >31)
				new_position = new_position -32
			var count:int;
			//			if(!back){
			if (new_position>start)
				count = new_position - start;
			else if(new_position<start)
				count = (32-start)+new_position;
			else 
				count = 0;
			tweenCounter(start,count);
			trace("START",start, new_position);
			//			}
			//			else{
			//				if (new_position<start)
			//					count = start - new_position;
			//				else if (new_position>start)
			//					count = (31-new_position)+start;
			//				else
			//					count = 0;
			//				trace("START",start, new_position);
			//				tweenCounterBack(start,count);
			//				
			//			}
		}
		//		private function tweenCounterBack(index:int,count:int):void{
		//			trace(index, count);
		//			
		//			if(index == 0) 
		//				index = 31;
		//			else index--;
		//			if(count>0){
		//				count--;
		//				TweenLite.to(_counter,.5,{x:_fields[index][0],y:_fields[index][1], onComplete:tweenCounterBack, onCompleteParams:[index,count]});
		//			}
		//			else
		//				counterFinishMove();
		//		}
		private function tweenCounter(index:int,count:int):void{
			trace(index, count);
			
			if(index == 31) {
				index = 0;
				Game.instance().help_popup.updateMessage("Minąłeś start!", "Za przejście przez start otrzymujesz 200 pkt.");
				Game.instance().help_popup.show();
				
				//				Game.instance().menu.updateThrows(Game.instance().data.throws+2);
				//				ExternalInterface.call("updatePoints",Game.instance().data.points)
			}
			else index++;
			if(count>0){
				count--;
				try{
					TweenLite.to(_counter,.5,{x:_fields[index][0],y:_fields[index][1], onComplete:tweenCounter, onCompleteParams:[index,count]});
				}catch(e:Error){}
			}
			else
				counterFinishMove();
		}
		private function counterFinishMove():void{
			//decide what to do?
			if(Game.instance().data.ACTION == Game.instance().data.QUESTION)
				Game.instance().question.show();
			else if(Game.instance().data.ACTION == "none"){
				Game.instance().menu.addClickEvent();
				Game.instance().data.roundFinish();
			}
			else
				Game.instance().action_popup.show();
			//			Game.instance().data.update_position();
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
			_fields.push([54,562]);
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