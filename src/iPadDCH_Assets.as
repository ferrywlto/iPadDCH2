package
{
	import flash.display.MovieClip;
	import flash.utils.ByteArray;
	
	import mx.core.BitmapAsset;
	import mx.core.ByteArrayAsset;
	import mx.flash.UIMovieClip;
	
	public class iPadDCH_Assets
	{
		//[Embed(source="assets/mymovie.swf")]
		//public static var srcClsSWF:Class;
		
		[Embed(source="assets/logo.png")]
		private static var srcClsLogo:Class;
		
		[Embed(source="assets/background.jpg")]
		private static var srcClsBackground:Class;
		
		[Embed(source="assets/btn_acura.jpg")]
		private static var srcClsCarBrand1:Class;
		
		[Embed(source="assets/btn_audi_round.jpg")]
		private static var srcClsCarBrand2:Class;
		
		[Embed(source="assets/btn_audi.jpg")]
		private static var srcClsCarBrand3:Class;
		
		[Embed(source="assets/btn_honda.jpg")]
		private static var srcClsCarBrand4:Class;
		
		[Embed(source="assets/btn_hyundai.jpg")]
		private static var srcClsCarBrand5:Class;
		
		[Embed(source="assets/btn_isuzu.jpg")]
		private static var srcClsCarBrand6:Class;
		
		[Embed(source="assets/btn_jaguar.jpg")]
		private static var srcClsCarBrand7:Class;
		
		[Embed(source="assets/btn_mazda.jpg")]
		private static var srcClsCarBrand8:Class;
		
		[Embed(source="assets/btn_bmw.jpg")]
		private static var srcClsCarBrand9:Class;
		
		[Embed(source="assets/background_02a.jpg")]
		private static var srcClsCarBrand10:Class;
		
		[Embed(source="assets/background_01a.jpg")]
		private static var srcClsBrandBG:Class;
		
		//public static var byteArrSWF:ByteArray = new srcClsSWF() as ByteArray;
		//public static var swfGW:MovieClip = new srcClsSWF() as MovieClip;
		public static var bmpLogo:BitmapAsset = new srcClsLogo() as BitmapAsset;
		public static var bmpBackground:BitmapAsset = new srcClsBackground() as BitmapAsset;
		public static var bmpBrandAcura:BitmapAsset = new srcClsCarBrand1() as BitmapAsset;
		public static var bmpBrandAudiRound:BitmapAsset = new srcClsCarBrand2() as BitmapAsset;
		public static var bmpBrandAudi:BitmapAsset = new srcClsCarBrand3() as BitmapAsset;
		public static var bmpBrandHonda:BitmapAsset = new srcClsCarBrand4() as BitmapAsset;
		public static var bmpBrandHyundai:BitmapAsset = new srcClsCarBrand5() as BitmapAsset;
		public static var bmpBrandIsuzu:BitmapAsset = new srcClsCarBrand6() as BitmapAsset;
		public static var bmpBrandJaguar:BitmapAsset = new srcClsCarBrand7() as BitmapAsset;
		public static var bmpBrandMazda:BitmapAsset = new srcClsCarBrand8() as BitmapAsset;
		public static var bmpBrandBMW:BitmapAsset = new srcClsCarBrand9() as BitmapAsset;
		public static var bmpDetailBG:BitmapAsset = new srcClsCarBrand10() as BitmapAsset;
		
		public static var bmpBrandBG:BitmapAsset = new srcClsBrandBG() as BitmapAsset;
	}
}