package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.events.FlexEvent;
	
	
	
	public class LoginWinMC extends Sprite
	{
		private var stateMachine:StateMachine;
		private var uiBtnLogin:Sprite;
		private var uiTxtUser:TextField, uiLblUser:TextField;
		private var uiTxtPass:TextField, uiLblPass:TextField;
		private var sprBackground:Sprite;
		
		public function LoginWinMC()
		{
			stateMachine = new StateMachine(this);
			stateMachine.AddTransition("Login", transitToLogin);
			stateMachine.AddTransition("Brand", transitToBrand);
			stateMachine.AddTransition("Detail", transitToDetail);
			StateManager.AddObserver(stateMachine);
			
			this.filters = [new DropShadowFilter()];
			this.cacheAsBitmap = true;
			this.cacheAsBitmapMatrix = new Matrix();
			
			initUI();
		}
		public function initUI():void
		{
			var tFormat:TextFormat = new TextFormat("Arial", 16, 0x000000);
			with(sprBackground = new Sprite())
			{
				cacheAsBitmap = true;
				with(graphics)
				{
					lineStyle(1,0xCCCCCC,1,false,"normal","Round","Round");
					beginFill(0xFFFFFF);
					drawRect(0,0,216,134);
					moveTo(0,36);
					lineTo(216,36);
					endFill();
				}
				with(uiLblUser = new TextField()) { text = "Username:"; x=20; y=42; setTextFormat(tFormat); autoSize = "left";}
				with(uiLblPass = new TextField()) { text = "Password:"; x=20; y=72; setTextFormat(tFormat); autoSize = "left";}
				addChild(uiLblPass);
				addChild(uiLblUser);
			}
			addChild(sprBackground);
			with(uiTxtUser = new TextField())
			{
				border = true;	x=100; y=42; width=100; height=22;
				text = "Administrator";
				setTextFormat(tFormat);
			}
			with(uiTxtPass = new TextField())
			{
				border = true; x=100; y=72; width=100; height=22;
				text = "Password";
				displayAsPassword= true;
				setTextFormat(tFormat);
			}
			with(uiBtnLogin = new Sprite())
			{
				x=100; y=100; addEventListener(MouseEvent.CLICK, onBtnLoginClick);
				with(graphics)
				{
					lineStyle(1,0xCCCCCC,1,false,"normal","Round","Round");
					beginFill(0xFFFFFF);
					drawRect(0,0,100,22);
					endFill();
				}
			}
			var ttLogin:TextField = new TextField();
			ttLogin.x = 130;
			ttLogin.y = 100;
			ttLogin.width = 80;
			ttLogin.height = 20;
			ttLogin.text = "Login";
			ttLogin.setTextFormat(tFormat);
			addChild(uiTxtUser);
			addChild(uiTxtPass);
			addChild(uiBtnLogin);
			addChild(ttLogin);
		}
		public function onBtnLoginClick(event:MouseEvent):void
		{
			trace("onBtnLoginClick");
			StateManager.TransitState("Brand");
		}
		
		public function transitToDetail():void
		{
			trace("LoginWinMC:transitToDetail");
			this.visible = false;
		}
		public function transitToLogin():void
		{
			this.x = 512-this.width/2;
			this.y = 384-this.height/2;
			//this.x = 100;
			//this.y = 50;
			trace("LoginWinMC:transitToLogin");
			this.visible = true;
			//trace(this.width+":"+this.height+":"+this.x+":"+this.y);
		}
		public function transitToBrand():void
		{
			uiBtnLogin.removeEventListener(MouseEvent.CLICK, onBtnLoginClick);
			trace("LoginWinMC:transitToBrand");
			this.visible = false;
		}
	}
}