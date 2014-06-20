package com.gamerisker.view
{
	import com.gamerisker.core.Define;
	import com.gamerisker.manager.ControlManager;
	import com.gamerisker.manager.KeyboardManager;
	import com.gamerisker.manager.LoadManager;
	import com.gamerisker.manager.MouseManager;
	import com.gamerisker.manager.MultipleManager;
	import com.gamerisker.manager.PngManager;
	import com.gamerisker.manager.RemoteConfig;
	import com.gamerisker.manager.SceneSourceManager;
	import com.gamerisker.manager.SharedManager;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.manager.TexturesManager;
	
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			if(stage)
				Init();
			else
				addEventListener(Event.ADDED_TO_STAGE , Init);
		}
		
		private function Init(event : Event = null) : void
		{
			KeyboardManager.Init(this.stage);
			MouseManager.Init(Define.stg , this.stage);
			ControlManager.Init();
			MultipleManager.Init();
			
			RookieEditor.getInstante().LoadBar.OnTextureComplete();
			
			RookieEditor.getInstante().ResetPosition();
			
			Define.Scene_Edit.Init(this.stage);
			
//			LoadManager.Init();
//			LoadManager.Add(SharedManager.getInstance().getSceneUrl(),1,OnSceneSourceComplete);
//			LoadManager.Start(OnSceneSourceComplete);
		}
		
//		private function OnSceneSourceComplete(value : String) : void
//		{
//			SceneSourceManager.Init(value);
//			
//			var sceneUrl : Object = SceneSourceManager.GetAllSourceInsUrl();
//			
//			for each(var items : Array in sceneUrl)
//			{
//				for each(var temp : Object in items)
//				{
//					LoadManager.Add(RemoteConfig.GetAtfRemoteURL(temp["url"]),temp["type"]);
//				}
//			}
//			
//			LoadManager.Start(OnTextureComplete);
//		}
		
//		private function OnTextureComplete(value : Object = null) : void
//		{
//			var data : Object = SceneSourceManager.GetAllData();
//			
//			for(var name : String in data)
//			{
//				HandleSceneSource(name);
//			}
//			
//			InitPngManager();
//		}
		
//		private function InitPngManager() : void
//		{
//			PngManager.Init(InitCompleteManager);
//		}
		
//		private function InitCompleteManager() : void
//		{
//			KeyboardManager.Init(this.stage);
//			MouseManager.Init(Define.stg , this.stage);
//			
//			InitSkinManager();
//			
//			ControlManager.Init();
//			MultipleManager.Init();
//		}
		
//		private function InitSkinManager() : void
//		{
//			LoadManager.Add(SharedManager.getInstance().getSkinUrl(),1,OnCompleteSkinManager);
//			LoadManager.Start();
//		}
		
//		private function OnCompleteSkinManager(value : String) : void
//		{
//			RookieEditor.getInstante().ResetPosition();
//			
//			SkinManager.Init(value);
//			
//			Define.Scene_Edit.Init(this.stage);
//		}
		
//		private function HandleSceneSource(sceneName : String) : void
//		{
//			var allId : Array = SceneSourceManager.GetSceneSourceId(sceneName);
//			var data : Array;
//			var xml : XML;
//			var byte : ByteArray;
//			var name : String;
//			
//			for(var i:int=0;i<allId.length;i++)
//			{
//				name = allId[i];
//				data = SceneSourceManager.GetSourceItem(sceneName,name);
//				
//				if(data[0]["type"] == 1)	//XML文件
//				{
//					xml = new XML(LoadManager.GetSource(RemoteConfig.GetAtfRemoteURL(data[0]["url"])));
//				}
//				else if(data[0]["type"] == 2)	//二进制文件
//				{
//					byte = LoadManager.GetSource(RemoteConfig.GetAtfRemoteURL(data[0]["url"])) as ByteArray;
//				}
//				
//				if(data[1]["type"] == 1)
//				{
//					xml = new XML(LoadManager.GetSource(RemoteConfig.GetAtfRemoteURL(data[1]["url"])));
//				}
//				else if(data[1]["type"] == 2)
//				{
//					byte = LoadManager.GetSource(RemoteConfig.GetAtfRemoteURL(data[1]["url"])) as ByteArray;
//				}
//				
//				TexturesManager.Add(name,xml,byte);
//			}
//			
//		}
	}
}