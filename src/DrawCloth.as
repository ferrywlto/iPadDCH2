package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.LoaderContext;
	
	public class DrawCloth extends Sprite
	{
		public function DrawCloth()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(event:Event):void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0,0,100,100);
			this.graphics.endFill();

			var bmp:Bitmap = new Bitmap();
			addChild(bmp);
			bmp.x = bmp.y = 0;
			bmp.bitmapData = new BitmapData(640,360);
			var loader:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.allowCodeImport = true;
			//loader.loadBytes(new iPadDCH_Assets.srcClsSWF,loaderContext);
			bmp.bitmapData.draw(loader);
		}
	}
}