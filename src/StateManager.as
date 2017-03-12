package
{
	public class StateManager
	{
		private static var states:Vector.<String> = new Vector.<String>;
		private static var observers:Vector.<StateChangedListener> = new Vector.<StateChangedListener>();
		private static var currentState:String;
		private static var previousState:String;
		public static function get CurrentState():String
		{
			return currentState;
		}
		
		public static function TransitState(stateID:String):void
		{
			trace("TransitState1");
			if(states.indexOf(stateID)!= -1)
			{
				trace("TransitState2");
				if(currentState != stateID)
				{
					trace("TransitState3");
					previousState = currentState;
					currentState = stateID;
					NotifyStateChanged(currentState);
				}
			}
		}
		
		public static function AddState(stateID:String):Boolean
		{
			if(states.indexOf(stateID) == -1)
			{
				states.push(stateID);
				return true;
			}
			return false;
		}
		
		public static function AddObserver(observer:StateChangedListener):Boolean
		{
			if(observers.indexOf(observer) == -1)
			{
				observers.push(observer);
				return true;
			}
			return false;
		}
		
		private static function NotifyStateChanged(stateID:String):void
		{
			trace("NotifyStateChanged");
			for(var i:uint = 0; i<observers.length; i++)
			{
				observers[i].NotifyStateChanged(stateID);		
			}
		}
	}
}