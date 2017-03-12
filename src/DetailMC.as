package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.formats.VerticalAlign;
	


	
	import net.hires.debug.Stats;
	
	import org.osmf.containers.MediaContainer;
	import org.osmf.elements.VideoElement;
	import org.osmf.events.ContainerChangeEvent;
	import org.osmf.events.DisplayObjectEvent;
	import org.osmf.events.MediaErrorEvent;
	import org.osmf.events.MediaPlayerCapabilityChangeEvent;
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.layout.HorizontalAlign;
	import org.osmf.layout.LayoutMetadata;
	import org.osmf.layout.ScaleMode;
	import org.osmf.media.DefaultMediaFactory;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaFactory;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.MediaType;
	import org.osmf.media.URLResource;
	import org.osmf.net.StreamType;
	import org.osmf.net.StreamingURLResource;
	
	public class DetailMC extends Sprite
	{
		private static const 
			//serverURL:String = "http://202.134.125.204:8500/mbs_content/uploads/",
			//serverURL:String = "http://192.168.0.232:8500/mbs_content/uploads/",
			//serverURL:String = "http://202.134.125.204/vod/",
			serverURL:String = "rtmp://192.168.0.231/vod/";
			//serverURL:String = "rtmp://solutions.grandtech.com.hk/vod/";

		private static var
			contentToPlay:String = "gt2";
			//contentToPlay:String = "shared/00000269/00000275/output/Zoozoo alien [www_441hz.keepvid";
			//contentToPlay:String = "Honda_The Cog.flv";
			
		private var 
			stateMachine:StateMachine,
			layoutMetaData:LayoutMetadata,
			mediaSprite:MediaPlayerSprite,
			mf:MediaFactory,
			player:MediaPlayer,
			mCon:MediaContainer,
			element:MediaElement,
			res:StreamingURLResource,
			title1:TextField,
			title2:TextField,
			scaled:Boolean,
			detailBtn0:Sprite,
			detailBtn1:Sprite,
			detailBtn2:Sprite,
			detailBtn3:Sprite, 
			detailBtn4:Sprite, 
			detailBtn5:Sprite, 
			bgmc:Sprite,
			tfor:TextFormat = new TextFormat("Arial",20,0xFFFFFF);
			
		private function initTextField():TextField
		{
			var titleX:TextField = new TextField();
			titleX.text = "debug";
			titleX.setTextFormat(tfor);
			titleX.autoSize = "left";
			
			return titleX;
		}
		private function initVidLayoutMeta():void
		{
			layoutMetaData = new LayoutMetadata();
			layoutMetaData.verticalAlign = VerticalAlign.MIDDLE;
			layoutMetaData.horizontalAlign = HorizontalAlign.CENTER;
			layoutMetaData.percentWidth = 100;
			layoutMetaData.percentHeight = 100;
			layoutMetaData.scaleMode = ScaleMode.LETTERBOX;
		}
		private function onPlayStateChange(event:MediaPlayerStateChangeEvent):void{
			title1.text = "onPlayStateChange:"+event.state;
			title1.setTextFormat(tfor);
			trace(title1.text);
			if(event.state == "playing")
			{
				mediaSprite.y = this.height/2-mediaSprite.height/2;
				switch(mode)
				{
					case "STREAM_NORMAL":
						mediaSprite.width = 640;
						mediaSprite.height = 360;
						break;
					case "STREAM_SHRINK":
						mediaSprite.width = 320;
						mediaSprite.height = 180;
						break;
					case "STREAM_ZOOM":
						mediaSprite.width = 800;
						mediaSprite.height = 450;
						break;
				}
			}
			title2.text = "mw:"+mediaSprite.width+" mh:"+mediaSprite.height+" p:"+serverURL+contentToPlay;
			title2.setTextFormat(tfor);
			trace(title2.text);
		}
		private function onError(event:MediaErrorEvent):void{
			title2.text = "Error:"+event.error.detail;
			title2.setTextFormat(tfor);
			trace(title2.text);
		}
		private function onSizeChange(event:DisplayObjectEvent):void{
			title2.text = "SizeChange: oldWidth: "+event.oldWidth+" oldHeight: "+event.oldHeight+" newWidth: "+event.newWidth+" newHeight: "+event.newHeight;
			title2.setTextFormat(tfor);
			trace(title2.text);
			mediaSprite.width = event.newWidth;
			mediaSprite.height = event.newHeight;
		}
		private var _mc:mymovie;
		//private var z:mymovie;
		
		public function DetailMC() 
		{
			stateMachine = new StateMachine(this);
			stateMachine.AddTransition("Brand", transitToBrand);
			stateMachine.AddTransition("Detail", transitToDetail);
			
			StateManager.AddObserver(stateMachine);
			initVidLayoutMeta();
			
			bgmc = new Sprite();
			bgmc.cacheAsBitmap = true;
			bgmc.addChild(new Bitmap(iPadDCH_Assets.bmpDetailBG.bitmapData));
			//bgmc.alpha = 0.5;
			addChild(bgmc);
			
			mediaSprite = new MediaPlayerSprite();
	
			detailBtn0 = new Sprite();
			//detailBtn0.alpha = 0;
			detailBtn0.graphics.beginFill(0xffffff,0);
			detailBtn0.graphics.drawRect(0,0,150,105);
			detailBtn0.graphics.endFill();
			detailBtn0.addEventListener(MouseEvent.CLICK, onBrandClick);
			addChild(detailBtn0);
			detailBtn0.x=0; 
			detailBtn0.y=640; 
			
			detailBtn0.cacheAsBitmap = true;
			
			title1 = initTextField();
			title2 = initTextField();
			addChild(title1);
			addChild(title2);
			title1.x = 150; title1.y = 20;
			title2.x = 150; title2.y = 50;
			
			var stats:Stats = new Stats();
			addChild(stats);
			trace(stats.width);
			stats.x = 950;
			
			_mc = new mymovie();
			_mc.stop();
			//addChild(bmp);
		}
		private var loader:Loader = new Loader();
		private var loaderContext:LoaderContext = new LoaderContext();
		private var bmp:Bitmap = new Bitmap();
		private var oldW:Number, oldH:Number;
		private function onMouseOver(event:MouseEvent):void
		{
			new FadeInEffect(event.target as DisplayObject);
		}
		private function onMouseOut(event:MouseEvent):void
		{
			new FadeOutEffect(event.target as DisplayObject);
		}

		private function onBrandClick(event:MouseEvent):void
		{
			StateManager.TransitState("Brand");									  
		}
		private function clearResource():void
		{
			trace("clean");
			if(mode == "SWF"){
				_mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				_mc.gotoAndStop(1);
				removeChild(_mc);
			}
			else {
				if(mediaSprite.mediaPlayer.playing){
					mediaSprite.mediaPlayer.stop();
				}
				if(mediaSprite.media != null){
					mediaSprite.media = null;
					mediaSprite.resource = null;
				}
				mediaSprite.mediaPlayer.removeEventListener(MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE, onPlayStateChange);
				mediaSprite.mediaPlayer.removeEventListener(MediaErrorEvent.MEDIA_ERROR, onError);
				mediaSprite.mediaPlayer.removeEventListener(DisplayObjectEvent.MEDIA_SIZE_CHANGE, onSizeChange);
			}
			//res = null;	
		}

		private var path:String = "";
		private function playVideo():void
		{
			
			scaled = false;
			trace("play:"+serverURL+contentToPlay);
			if(path != serverURL+contentToPlay){
				path = serverURL+contentToPlay;
				res = new StreamingURLResource(serverURL+contentToPlay, StreamType.LIVE_OR_RECORDED);
				res.mediaType = MediaType.VIDEO;
			}
			mediaSprite.resource = res;
			//mediaSprite.media.addMetadata(LayoutMetadata.LAYOUT_NAMESPACE, layoutMetaData);
			mediaSprite.scaleMode = ScaleMode.LETTERBOX;
		}
		
		private var rowCount:uint;
		private var mode:String;
		public function transitToDetail():void
		{
			contentToPlay = SharedDataManager.GetSharedData("videoID") as String;
			mediaSprite.mediaPlayer.addEventListener(MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE, onPlayStateChange);
			mediaSprite.mediaPlayer.addEventListener(MediaErrorEvent.MEDIA_ERROR, onError);
			mediaSprite.mediaPlayer.addEventListener(DisplayObjectEvent.MEDIA_SIZE_CHANGE, onSizeChange);
			
			mode = SharedDataManager.GetSharedData("mode") as String;
			switch(mode)
			{
				case "STREAM_NORMAL":
				case "STREAM_SHRINK":
				case "STREAM_ZOOM":
					addChild(mediaSprite);
					mediaSprite.x = 150;
					playVideo();
					break;
				case "SWF":
					//_mc = iPadDCH_Assets.swfGW;
					addChild(_mc);
					_mc.x = 150;
					_mc.y = 150;
					(_mc as MovieClip).scaleX = 2;

					_mc.gotoAndPlay(1);
					_mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
					break;
			}
			
			this.x = 0;
			this.y = 0;
			trace("DetailMC:transitToDetail");
			this.visible = true;
			/*
			bmp.x = bmp.y = 0;
			bmp.bitmapData = new BitmapData(640,360);
			loaderContext.allowCodeImport = true;

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawBMP);
			addEventListener(Event.ENTER_FRAME, drawLine);
			*/
		}
		public function onEnterFrame(event:Event):void{
			title2.text = "SWF frame: "+_mc.currentFrame + ((new Date().milliseconds%2 == 0)?"":"!");
			title2.setTextFormat(tfor);
		}
		public function drawBMP(event:Event):void
		{
			rowCount = 0;
			//trace(iPadDCH_Assets.byteArrSWF.length);
			//trace(loader.content);
			bmp.bitmapData.draw(loader);
		}
/*
		public function drawLine(event:Event):void
		{
			if(rowCount*640 < iPadDCH_Assets.byteArrSWF.length){
				var ba:ByteArray = new ByteArray();
				ba.writeBytes(iPadDCH_Assets.byteArrSWF, rowCount*640 , 640);
				rowCount++;
				loader.loadBytes(ba,loaderContext);
				
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, drawLine);
			}
		}
*/
		public function transitToBrand():void
		{
			clearResource();
			trace("DetailMC:transitToBrand");
			this.visible = false;
		}
	}
	
}
