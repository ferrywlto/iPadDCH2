package
{
	public class SharedDataManager
	{
		public static var data:Array = new Array();
		
		public static function SetSharedData(key:String, value:Object):void
		{
			data[key] = value;
		}
		public static function GetSharedData(key:String):Object
		{
			if(data[key] != null)
			{
				return data[key];
			}
			else
			{
				throw new Error("Key does not exist.");
			}
		}
	}
}