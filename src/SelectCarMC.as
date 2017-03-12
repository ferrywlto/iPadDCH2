package  {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SelectCarMC extends Sprite
	{
		private var stateMachine:StateMachine;
		
		private var cmc0:Sprite, cmc1:Sprite, cmc2:Sprite,
		cmc3:Sprite, cmc4:Sprite, cmc5:Sprite;
		public function SelectCarMC() 
		{
			stateMachine = new StateMachine(this);
			stateMachine.AddTransition("Login", transitToLogin);
			stateMachine.AddTransition("Brand", transitToBrand);
			stateMachine.AddTransition("Car", transitToCar);
			stateMachine.AddTransition("Detail", transitToDetail);
			
			StateManager.AddObserver(stateMachine);
			for(var i:uint=0; i<6; i++)
			{
				this["cmc"+i] = new Sprite();
				this["cmc"+i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				this["cmc"+i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				this["cmc"+i].addEventListener(MouseEvent.CLICK, onMouseClick);
				this["cmc"+i].cacheAsBitmap = true;
				this["cmc"+i].cacheAsBitmapMatrix = new Matrix();	
				this["cmc"+i].alpha = 0;
				this["cmc"+i].x = i*100;
				addChild(this["cmc"+i]);
			}
			cmc0.addChild(new Bitmap(iPadDCH_Assets.bmpBrandAcura.bitmapData));
//			cmc1.addChild(new Bitmap(iPadDCH_Assets.bmpCarBrand1.bitmapData));
//			cmc2.addChild(new Bitmap(iPadDCH_Assets.bmpCarBrand1.bitmapData));
//			cmc3.addChild(new Bitmap(iPadDCH_Assets.bmpCarBrand1.bitmapData));
//			cmc4.addChild(new Bitmap(iPadDCH_Assets.bmpCarBrand1.bitmapData));
//			cmc5.addChild(new Bitmap(iPadDCH_Assets.bmpCarBrand1.bitmapData));
			
			with(cmc0){x=0; y=0;}
			with(cmc0){x=0; y=0;}
			with(cmc0){x=0; y=0;}
			with(cmc0){x=0; y=0;}
			with(cmc0){x=0; y=0;}
			with(cmc0){x=0; y=0;}
			
			var title:TextField = new TextField();
			title.text = "Choose a car.";
			var tfor:TextFormat = new TextFormat("Arial",20,0xFFFFFF);
			title.setTextFormat(tfor);
			addChild(title);
			title.x = 10;
			title.y = 20;
		}
		public function onMouseClick(event:MouseEvent):void
		{
			StateManager.TransitState("Detail");
		}
//		public function onMouseOver(event:MouseEvent):void
//		{
//			event.target.filters = [new DropShadowFilter(), new GlowFilter(0x00FFFF,1,10,10,5,3)];
//		}
//		public function onMouseOut(event:MouseEvent):void
//		{
//			event.target.filters = [new DropShadowFilter()];
//		}
		
		public function onMouseOut(event:MouseEvent):void
		{
			trace("CarMC:onMouseOut");
			//event.target.scaleX = 1;
			//event.target.scaleY = 1;
			new FadeOutEffect(event.target as DisplayObject);
		}
		public function onMouseOver(event:MouseEvent):void
		{
			trace("CarMC:onMouseOver");
			//event.target.scaleX = 1.3;
			//event.target.scaleY = 1.3;
			new FadeInEffect(event.target as DisplayObject);
		}
		
		
		public function transitToCar():void
		{
			this.x = 0;
			this.y = 0;
			trace("SelectCarMC:transitToCar");
			this.visible = true;
		}
		public function transitToDetail():void
		{
			trace("SelectCarMC:transitToDetail");
			this.visible = false;
		}
		public function transitToLogin():void
		{
			trace("SelectCarMC:transitToLogin");
			this.visible = false;
		}
		public function transitToBrand():void
		{
			trace("SelectCarMC:transitToBrand");
			this.visible = false;
		}
	}
	
}
