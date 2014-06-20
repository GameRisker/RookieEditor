package com.gamerisker.manager
{
	import com.gamerisker.utils.Tool;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.geom.Rectangle;
	
	import spark.components.Alert;

	public class PngManager
	{
		private static var m_list : Object = new Object;
		private static var m_fun : Function;
		
		public function PngManager(){}
		
		public static function Init(fun : Function) : void
		{
			m_fun = fun;
			
			var allUrl : Object = SceneSourceManager.GetSourceIdAll();
			
			for each(var item : String in allUrl)
			{
				LoadManager.Add(RemoteConfig.GetAtfRemoteURL(item),0);
			}
			
			LoadManager.Start(OnComplete);
		}
		
		private static function OnComplete(value : Object = null) : void
		{
			var allUrl : Object = SceneSourceManager.GetSourceIdAll();
			var loader : Loader;
			for each(var item : String in allUrl)
			{
				loader = new Loader();
				loader.loadBytes(LoadManager.GetSource(RemoteConfig.GetAtfRemoteURL(item)));
				m_list[item] = loader;
			}
			
			m_fun();
		}
		
		/**
		 *	根据url获取显示资源 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getUrl(value : Object,type : String) : Bitmap 
		{
			var skin : Object;
			var _rang : Rectangle;
			
			switch(type)
			{
				case "Button" : 
				case "ImageButton" :
				case "CheckBox" :
				case "RadioButton" : 
					skin = SkinManager.getSkinInfo(value["name"],type);
					_rang = getXml(skin["upSkin"],value["skinParent"]);
					
					if(!skin)Alert.show(value["name"]+":在SkinManager中没有找到.","",Alert.OK,RookieEditor.getInstante().Select);
					if(!_rang)Alert.show(skin["upSkin"]+":在XML中没找到.","",Alert.OK,RookieEditor.getInstante().Select);
					
					return getImage(_rang,skin["skinParent"]);
				case "SkinFrame" : 
				case "SkinImage" : 
					skin = SkinManager.getSkinInfo(value["name"],type);
					_rang = getXml(skin["skin"],value["skinParent"]);
					
					if(!skin)Alert.show(value["name"]+":在SkinManager中没有找到.","",Alert.OK,RookieEditor.getInstante().Select);
					if(!_rang)Alert.show(skin["upSkin"]+":在XML中没找到.","",Alert.OK,RookieEditor.getInstante().Select);
					
					return getImage(_rang,skin["skinParent"]);
				case "TitleWindow" : 
					skin = SkinManager.getSkinInfo(value["name"],type);
					_rang = getXml(skin["skin"],value["skinParent"]);
					
					if(!skin)Alert.show(value["name"]+":在SkinManager中没有找到.","",Alert.OK,RookieEditor.getInstante().Select);
					if(!_rang)Alert.show(skin["upSkin"]+":在XML中没找到.","",Alert.OK,RookieEditor.getInstante().Select);
					
					return getImage(_rang,skin["skinParent"]);
				case "ImageNumber" :
					skin = SkinManager.getSkinInfo(value["name"],type);
					_rang = getXml(skin["skin"]+"0",value["skinParent"]);
					
					if(!skin)Alert.show(value["name"]+":在SkinManager中没有找到.","",Alert.OK,RookieEditor.getInstante().Select);
					if(!_rang)Alert.show(skin["upSkin"]+":在XML中没找到.","",Alert.OK,RookieEditor.getInstante().Select);
					return getImage(_rang,skin["skinParent"]);
			}
			
			Alert.show("没有找到资源类型,请查看代码.","",Alert.OK,RookieEditor.getInstante().Select);
			
			return null;
		}
		
		public static function getXml(name : String , skinParent : String) : Rectangle
		{
			var url : String = SceneSourceManager.GetSourceIdXml(skinParent);
			var xml : XML = new XML(LoadManager.GetSource(RemoteConfig.GetAtfRemoteURL(url)));
			
			var _x : Number;
			var _y : Number;
			var _widht : Number;
			var _height : Number;
			
			for each(var item : XML in xml.elements("SubTexture"))
			{
				if(item.@name == name)
				{
					_x = parseFloat(item.@x);
					_y = parseFloat(item.@y);
					_widht = parseFloat(item.@width) != 0 ? parseFloat(item.@width) : parseFloat(item.@frameWidth);
					_height = parseFloat(item.@height) != 0 ? parseFloat(item.@height) : parseFloat(item.@frameHeight);
					
					return new Rectangle(_x,_y,_widht,_height);
				}
			}
			
			return null;
		}
		
		public static function getImage(scale9Grid : Rectangle,skinParent : String) : Bitmap
		{
			var url : String = SceneSourceManager.GetSourceId(skinParent);
			var loader : Loader = m_list[url] as Loader;
			return Tool.DrawBitmapRectangle(loader,scale9Grid);
		}
	}
}