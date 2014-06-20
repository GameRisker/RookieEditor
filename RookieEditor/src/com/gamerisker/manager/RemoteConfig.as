package com.gamerisker.manager
{
	import flash.system.Capabilities;

	public class RemoteConfig
	{
		public function RemoteConfig()
		{
		}
		
		public static function GetAtfRemoteURL(url : String) : String
		{
			var os : String = Capabilities.os;
			var str : String;
			if(os.indexOf("Mac") > -1)
			{
				str = SharedManager.getInstance().getTextureUrl() + "/" +url.replace(/\\/g,"\/");
			}
			else
			{
				str = SharedManager.getInstance().getTextureUrl() + "\\" +url.replace(/\//g,"\\");
			}
			return str;
		}
	}
}