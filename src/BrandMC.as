package  {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.sampler.Sample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	
	public class BrandMC extends Sprite
	{
		private var stateMachine:StateMachine;
		private var bmc0:Sprite,bmc1:Sprite,bmc2:Sprite,bmc3:Sprite,bmc4:Sprite,bmc5:Sprite,
			bmc6:Sprite,bmc7:Sprite,bmc8:Sprite,bmc9:Sprite;
		private var bgmc:Sprite;
	
			
		public function BrandMC()
		{
			stateMachine = new StateMachine(this);
			//stateMachine.AddTransition("Login", transitToLogin);
			stateMachine.AddTransition("Brand", transitToBrand);
			stateMachine.AddTransition("Detail", transitToDetail);
			StateManager.AddObserver(stateMachine);

			bgmc = new Sprite();
			bgmc.addChild(new Bitmap(iPadDCH_Assets.bmpBrandBG.bitmapData));
			bgmc.cacheAsBitmap = true;
			addChild(bgmc);
			for(var i:uint=0; i<9; i++)
			{
				this["bmc"+i] = new Sprite();
				this["bmc"+i].cacheAsBitmap = true;
				this["bmc"+i].cacheAsBitmapMatrix = new Matrix();	
				addChild(this["bmc"+i]);
			}

			bmc0.addChild(new Bitmap(iPadDCH_Assets.bmpBrandAcura.bitmapData));
			bmc1.addChild(new Bitmap(iPadDCH_Assets.bmpBrandAudi.bitmapData));
			bmc2.addChild(new Bitmap(iPadDCH_Assets.bmpBrandAudiRound.bitmapData));
			bmc3.addChild(new Bitmap(iPadDCH_Assets.bmpBrandHonda.bitmapData));
			bmc4.addChild(new Bitmap(iPadDCH_Assets.bmpBrandHyundai.bitmapData));
			bmc5.addChild(new Bitmap(iPadDCH_Assets.bmpBrandIsuzu.bitmapData));
			bmc6.addChild(new Bitmap(iPadDCH_Assets.bmpBrandJaguar.bitmapData));
			bmc7.addChild(new Bitmap(iPadDCH_Assets.bmpBrandMazda.bitmapData));
			bmc8.addChild(new Bitmap(iPadDCH_Assets.bmpBrandBMW.bitmapData));
			//bmc9.addChild(new Bitmap(iPadDCH_Assets.bmpCarBrand9.bitmapData));
			
			
			with(bmc0){x=77; y=75;}
			with(bmc1){x=466; y=288;}
			with(bmc2){x=211; y=531;}
			with(bmc3){x=405; y=56;}
			with(bmc4){x=273; y=364;}
			with(bmc5){x=59; y=386;}
			with(bmc6){x=675; y=116;}
			with(bmc7){x=693; y=370;}
			with(bmc8){x=479; y=495;}
//			with(bmc1){x=0; y=0;}
//			with(bmc1){x=0; y=0;}
//			with(bmc1){x=0; y=0;}
//			with(bmc1){x=0; y=0;}
			
			var title:TextField = new TextField();
			title.text = "Choose a brand.";
			title.autoSize = "left";
			var tfor:TextFormat = new TextFormat("Arial",20,0xFFFFFF);
			title.setTextFormat(tfor);
			addChild(title);
			title.x = 10;
			title.y = 20;
		}
		public function onClick(event:MouseEvent):void
		{
			var videoID:String;
			var mode:String = "STREAM_NORMAL";
			switch(event.target)
			{
				case bmc0: videoID = "c100k24p16m"; mode="STREAM_NORMAL"; break; 	// bmpBrandAcura
				case bmc3: videoID = "v200k24p16m"; mode="STREAM_NORMAL"; break;	// bmpBrandHonda
				case bmc1: videoID = "c100k24p16m"; mode="STREAM_SHRINK"; break; 	// bmpBrandAudi
				case bmc2: videoID = "c100k24p16m"; mode="STREAM_ZOOM"; break; // bmpBrandAudiRound
				case bmc3: videoID = "v200k24p16m"; mode="STREAM_NORMAL"; break;	// bmpBrandHonda
				case bmc4: videoID = "v200k24p16m"; mode="STREAM_SHRINK"; break;	// bmpBrandHyundai
				case bmc5: videoID = "v200k24p16m"; mode="STREAM_ZOOM"; break;	// bmpBrandIsuzu
				case bmc6: videoID = "v300k30p16m"; mode="STREAM_NORMAL"; break;	// bmpBrandJaguar
				case bmc7: videoID = "v300k30p16m"; mode="STREAM_SHRINK"; break;	// bmpBrandMazda
				case bmc8: videoID = "v300k30p16m"; mode="SWF"; break;	// bmpBrandBMW
				default: break;
			}
			SharedDataManager.SetSharedData("videoID",videoID);
			SharedDataManager.SetSharedData("mode", mode);
			StateManager.TransitState("Detail");									  
		}
		public function onMouseOut(event:MouseEvent):void
		{
			//trace("BrandMC:onMouseOut");
			//event.target.scaleX = 1;
			//event.target.scaleY = 1;
			new FadeOutEffect(event.target as DisplayObject);
		}
		public function onMouseOver(event:MouseEvent):void
		{
			//trace("BrandMC:onMouseOver");
			//event.target.scaleX = 1.3;
			//event.target.scaleY = 1.3;
			new FadeInEffect(event.target  as DisplayObject);
		}
		public function transitToDetail():void
		{
			for(var i:uint=0; i<9; i++)
			{
				this["bmc"+i].removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				this["bmc"+i].removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				this["bmc"+i].removeEventListener(MouseEvent.CLICK, onClick);
				this["bmc"+i].alpha = 0;
			}
			trace("BrandMC:transitToDetail");
			this.visible = false;
		}
		public function transitToLogin():void
		{
			trace("BrandMC:transitToLogin");
			this.visible = false;
		}
		public function transitToBrand():void
		{
			for(var i:uint=0; i<9; i++)
			{
				this["bmc"+i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				this["bmc"+i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				this["bmc"+i].addEventListener(MouseEvent.CLICK, onClick);
				this["bmc"+i].alpha = 0;
			}
			trace("BrandMC:transitToBrand");
			this.x = 0;
			this.y = 0;
			this.visible = true;
		}
	}
	
}




























var tmp:my