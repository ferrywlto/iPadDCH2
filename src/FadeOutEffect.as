package
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class FadeOutEffect
	{
		private var target:DisplayObject;
		private var fadeTimer:Timer;
		public function FadeOutEffect(disObj:DisplayObject)
		{
			target = disObj;
			fadeTimer = new Timer(50,20);
			fadeTimer.addEventListener(TimerEvent.TIMER, fadeInLis);
			fadeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, complete);
			fadeTimer.start();
			
		}
		private function complete(event:TimerEvent):void
		{
			fadeTimer.stop();
			fadeTimer.removeEventListener(TimerEvent.TIMER, fadeInLis);
			fadeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, complete);
			fadeTimer = null;
		}
		private function fadeInLis(event:TimerEvent):void
		{
			//trace("fadeOutLis:"+target);
			if(target.alpha > 0){
				target.alpha -= 0.05;
			}else
			{
				target.alpha = 0;
				complete(event);
			}
				
		}
	}
}