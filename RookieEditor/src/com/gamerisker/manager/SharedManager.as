package com.gamerisker.manager
{
	import com.gamerisker.core.Define;
	
	import flash.net.SharedObject;

	public class SharedManager
	{
		private static var s_instance : SharedManager;
		private static var s_config : SharedObject;
		private static var s_uiSrcUrl : String = "";
		private static var s_SkinUrl : String = "";
		private static var s_ConfigUrl : String = "";
		private static var s_textureUrl : String = "";
		private static var s_sceneSource : String = "";
		
		public function SharedManager()
		{
		}
		
		private static function InitConfig() : void
		{
			if(s_config.data.s_uiSrcUrl != undefined || s_config.data.s_SkinUrl != undefined)
			{
				s_uiSrcUrl = s_config.data.s_uiSrcUrl;
				s_SkinUrl = s_config.data.s_SkinUrl;
				s_ConfigUrl = s_config.data.s_ConfigUrl;
				s_textureUrl = s_config.data.textureUrl;
				s_sceneSource = s_config.data.sceneSource;
			}
		}

		public function isNull() : Boolean
		{
			if(s_uiSrcUrl =="" || s_SkinUrl == "" || s_ConfigUrl == "" || s_textureUrl == "")
			{
				return true;
			}
			return false;
		}
		
		public static function getInstance() : SharedManager
		{
			if(s_instance == null)
			{
				s_instance = new SharedManager;
				s_config = SharedObject.getLocal("RookieEditor");
				InitConfig();
			}
			
			return s_instance;
		}
		
		public function setVersion(value : String) : void
		{
			s_config.data.version = value;
		}
		
		public function setSceneUrl(value : String) : void
		{
			s_sceneSource = value;
			s_config.data.sceneSource = value;
		}
		
		public function getSceneUrl() : String
		{
			return s_sceneSource;
		}
		
		public function setUiSrcUrl(value : String) : void
		{
			s_uiSrcUrl = value;
			s_config.data.s_uiSrcUrl = value;
		}
		
		public function setSkinUrl(value : String) : void
		{
			s_SkinUrl = value;
			s_config.data.s_SkinUrl = value;
		}
		
		/**
		 *	界面配置文件路径 .cfg
		 * @param value
		 * 
		 */		
		public function setConfigUrl(value : String) : void
		{
			s_ConfigUrl = value;
			s_config.data.s_ConfigUrl = value;
		}
		
		/**
		 *	纹理集路径  
		 * @param value
		 * 
		 */		
		public function setTextureUrl(value : String) : void
		{
			s_textureUrl = value;
			s_config.data.textureUrl = value;
		}
		
		/**
		 *	纹理集路径  
		 * @return 
		 * 
		 */		
		public function getTextureUrl() : String
		{
			return s_textureUrl;
		}
		
		/**
		 *	界面配置文件路径 .cfg
		 * @return 
		 * 
		 */		
		public function getConfigUrl() : String
		{
//			return "D:\\WorkSpace\\Example\\src";
			return s_ConfigUrl;//.replace(/\\/g, "/");	
		}
		
		/**
		 *	配置文件所在目录
		 */	
		public function getUiSrcUrl() : String
		{
			return s_uiSrcUrl;
		}
		
		/**
		 *	配置文件的路径 
		 */	
		public function getSkinUrl() : String
		{
			return s_SkinUrl;	
		}
	}
}