package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(frameRate="30")]
	public class iPadDCH extends Sprite
	{
		//private var mcLoginWin:LoginWinMC;
		private var mcBrand:BrandMC;
		private var mcCar:SelectCarMC;
		private var mcDetail:DetailMC;
		private var stateMachine:StateMachine;
		public function iPadDCH()
		{
			super();
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			//mcLoginWin = new LoginWinMC();
			mcBrand = new BrandMC();
			//mcCar = new SelectCarMC();
			mcDetail = new DetailMC();
			
			
			//StateManager.AddState("Login");
			StateManager.AddState("Brand");
			StateManager.AddState("Detail");
			
			stateMachine = new StateMachine(this);
			//stateMachine.AddTransition("Login", transitToLogin);
			stateMachine.AddTransition("Brand", transitToBrand);
			stateMachine.AddTransition("Detail", transitToDetail);
			StateManager.AddObserver(stateMachine);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function transitToLogin():void
		{
			if(mcDetail.parent != null) { removeChild(mcDetail); }
			if(mcBrand.parent != null) { removeChild(mcBrand); }
			//addChild(mcLoginWin);
		}
		private function transitToBrand():void
		{
			//if(mcLoginWin.parent != null) { removeChild(mcLoginWin); }
			if(mcDetail.parent != null) { removeChild(mcDetail); }

			addChild(mcBrand);
		}
		private function transitToDetail():void
		{
			//if(mcLoginWin.parent != null) { removeChild(mcLoginWin); }
			if(mcBrand.parent != null) { removeChild(mcBrand); }
			
			addChild(mcDetail);
		}
		public function init(event:Event):void
		{
			StateManager.TransitState("Brand");
		}
	}
}