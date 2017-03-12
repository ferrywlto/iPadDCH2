package 
{
	import flash.display.Sprite;

	public class StateMachine implements StateChangedListener
	{
		private var transitions:Array;
		private var target:Sprite;

		public function StateMachine(disObj:Sprite)
		{
			transitions = new Array();
			target = disObj;
		}
		
		private function Transit(stateID:String):void
		{
			if(transitions[stateID] != null){ transitions[stateID](); }
		}
	
		public function AddTransition(stateID:String, func:Function):Boolean
		{
			return SetTransition((transitions[stateID]!=null), stateID, func);
		}
		
		public function ChangeTransition(stateID:String, func:Function):Boolean
		{
			return SetTransition((transitions[stateID]==null), stateID, func);
		}
		
		private function SetTransition(falseCondition:Boolean,stateID:String, func:Function):Boolean
		{
			if(falseCondition) { return false; }
			else
			{
				transitions[stateID] = func;
				return true;
			}
		}
				
		public function NotifyStateChanged(stateID:String):void
		{
			Transit(stateID);
		}
	}
}