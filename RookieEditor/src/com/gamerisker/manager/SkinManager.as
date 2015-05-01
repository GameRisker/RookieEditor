package com.gamerisker.manager
{
	import com.gamerisker.utils.Tool;
	
	import flash.geom.Rectangle;
	
	import spark.components.Alert;
	
	import starling.textures.TextureAtlas;
	
	/**
	 *	皮肤管理器 
	 * @author GameRisker
	 * 
	 */	
	public class SkinManager
	{		
		private static const s_buttonList : Object = new Object;
		private static const s_popupWindowList : Object = new Object;
		private static const s_imagebuttonList : Object = new Object;
		private static const s_checkBoxList : Object = new Object;
		private static const s_radiobuttonList : Object = new Object;
		private static const s_sliderList : Object = new Object;
		private static const s_uiframeList : Object = new Object;
		private static const s_uiimageList : Object = new Object;
		private static const s_imagenumber : Object = new Object;
		
		private static const s_curbuttonList : Object = new Object;
		private static const s_curpopupWindowList : Object = new Object;
		private static const s_curimagebuttonList : Object = new Object;
		private static const s_curcheckBoxList : Object = new Object;
		private static const s_curradiobuttonList : Object = new Object;
		private static const s_cursliderList : Object = new Object;
		private static const s_curuiframeList : Object = new Object;
		private static const s_curuiimageList : Object = new Object;
		private static const s_curimagenumber : Object = new Object;
		
		public function SkinManager()
		{
			
		}
		
		/**
		 *	获取所有资源 
		 * @param name
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getSkinInfo(name : String , type : String) : Object
		{
			var skinInfo : Object;
			
			switch(type)
			{
				case "Button" : 
					skinInfo = s_buttonList;
					break
				case "ImageButton" :
					skinInfo = s_imagebuttonList;
					break
				case "CheckBox" :
					skinInfo = s_checkBoxList;
					break
				case "RadioButton" : 
					skinInfo = s_radiobuttonList;
					break
				case "SkinFrame" : 
					skinInfo = s_uiframeList;
					break
				case "SkinImage" : 
					skinInfo = s_uiimageList;
					break
				case "TitleWindow" : 
					skinInfo = s_popupWindowList;
					break
				case "ImageNumber" : 
					skinInfo = s_imagenumber;
					break
			}
			
			
			for each(var item : Object in skinInfo)
			{
				if(item["name"] == name)
					return item;
			}
			
			return null;
		}
		
		public static function get uiimagenumber() : Object
		{
			return s_imagenumber;
		}
		
		public static function get uiimageList():Object
		{
			return s_uiimageList;
		}
		
		public static function get uiframeList():Object
		{
			return s_uiframeList;
		}

		public static function get sliderList():Object
		{
			return s_sliderList;
		}

		public static function get radiobuttonList():Object
		{
			return s_radiobuttonList;
		}

		public static function get checkBoxList():Object
		{
			return s_checkBoxList;
		}

		public static function get imagebuttonList():Object
		{
			return s_imagebuttonList;
		}

		public static function get popupWindowList():Object
		{
			return s_popupWindowList;
		}

		public static function get buttonList():Object
		{
			return s_buttonList;
		}

		public static function Init(data : String) : void
		{
			OnLoadConfigComplete(data);
		}
		
		/**
		 *	清除皮肤池里面的皮肤 
		 * 
		 */		
		public static function RemoveAll() : void
		{
//			Tool.CleanObjectProperty(s_curbuttonList);
//			Tool.CleanObjectProperty(s_curpopupWindowList);
//			Tool.CleanObjectProperty(s_curimagebuttonList);
//			Tool.CleanObjectProperty(s_curcheckBoxList);
//			Tool.CleanObjectProperty(s_curradiobuttonList);
//			Tool.CleanObjectProperty(s_cursliderList);
//			Tool.CleanObjectProperty(s_curuiframeList);
//			Tool.CleanObjectProperty(s_curuiimageList);
		}
		
		private static function OnLoadConfigComplete(data : String) : void
		{
			var configXML : XML = new XML(data);
			var skinInfo : Object;
			var skinName : String;
			var skinXml : XML
			for each(skinXml in configXML.elements("Button"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["upSkin"] = skinXml.@upSkin.toString();
				skinInfo["downSkin"] = skinXml.@downSkin.toString();
				skinInfo["disabledSkin"] = skinXml.@disabledSkin.toString();
				skinInfo["scale9Grid"] = new Rectangle(int(skinXml.@scale9GridX), 
					int(skinXml.@scale9GridY), int(skinXml.@scale9GridWidth), 
					int(skinXml.@scale9GridHeight));
				
				if(s_buttonList.hasOwnProperty(skinName))
					Alert.show("Button Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_buttonList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("ImageNumber"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["skin"] = skinXml.@skin.toString();
				
				if(s_imagenumber.hasOwnProperty(skinName))
					Alert.show("ImageNumber Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_imagenumber[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("TitleWindow"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["skin"] = skinXml.@skin.toString();
				skinInfo["closeUpSkin"] = skinXml.@closeUpSkin.toString();
				skinInfo["closeDownSkin"] = skinXml.@closeDownSkin.toString();
				skinInfo["closeX"] = int(skinXml.@closeX);
				skinInfo["closeY"] = int(skinXml.@closeY);
				skinInfo["scale9Grid"] = new Rectangle(int(skinXml.@scale9GridX), 
					int(skinXml.@scale9GridY), int(skinXml.@scale9GridWidth), 
					int(skinXml.@scale9GridHeight));
				skinInfo["textBounds"] = new Rectangle(int(skinXml.@textboundsX), 
					int(skinXml.@textboundsY), int(skinXml.@textboundsW), 
					int(skinXml.@textboundsH));
				
				if(s_popupWindowList.hasOwnProperty(skinName))
					Alert.show("TitleWindow Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_popupWindowList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("ImageButton"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["upSkin"] = skinXml.@upSkin.toString();
				skinInfo["downSkin"] = skinXml.@downSkin.toString();
				skinInfo["disabledSkin"] = skinXml.@disabledSkin.toString();
				
				if(s_imagebuttonList.hasOwnProperty(skinName))
					Alert.show("ImageButton Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_imagebuttonList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("CheckBox"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["upSkin"] = skinXml.@upSkin.toString();
				skinInfo["downSkin"] = skinXml.@downSkin.toString();
				
				if(s_checkBoxList.hasOwnProperty(skinName))
					Alert.show("CheckBox Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_checkBoxList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("RadioButton"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["upSkin"] = skinXml.@upSkin.toString();
				skinInfo["downSkin"] = skinXml.@downSkin.toString();
				
				if(s_radiobuttonList.hasOwnProperty(skinName))
					Alert.show("RadioButton Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_radiobuttonList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("Slider"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();			
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["upSkin"] = skinXml.@upSkin.toString();
				skinInfo["downSkin"] = skinXml.@downSkin.toString();
				skinInfo["backtexture"] = skinXml.@background.toString();
				skinInfo["scale9Grid"] = new Rectangle(int(skinXml.@scale9GridX), 
					int(skinXml.@scale9GridY), int(skinXml.@scale9GridWidth), 
					int(skinXml.@scale9GridHeight));
				
				if(s_sliderList.hasOwnProperty(skinName))
					Alert.show("Slider Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_sliderList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("SkinFrame"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();			
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["skin"] = skinXml.@skin.toString();
				skinInfo["scale9Grid"] = new Rectangle(int(skinXml.@scale9GridX), 
					int(skinXml.@scale9GridY), int(skinXml.@scale9GridWidth), 
					int(skinXml.@scale9GridHeight));
				
				if(s_uiframeList.hasOwnProperty(skinName))
					Alert.show("SkinFrame Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_uiframeList[skinName] = skinInfo;
			}
			
			skinXml = null;
			for each(skinXml in configXML.elements("SkinImage"))
			{
				skinInfo = new Object;
				skinName = skinXml.@skin.toString();			
				skinInfo["name"] = skinName;
				skinInfo["skinParent"] = skinXml.@skinParent.toString();
				skinInfo["skin"] = skinXml.@skin.toString();
				
				if(s_uiimageList.hasOwnProperty(skinName))
					Alert.show("SkinFrame Repeated skin : " + skinName ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				s_uiimageList[skinName] = skinInfo;
			}
		}
		
		public static function GetSkin(name : String , skinName : String) : Object
		{
			if(skinName){
				
				switch(name)
				{
					case "Button" : 
						return GetButtonSkin(skinName);
					case "TitleWindow" : 
						return GetPopupWindowSkin(skinName);
					case "ImageButton" : 
						return GetImageButtonSkin(skinName);
					case "CheckBox" : 
						return GetCheckBox(skinName);
					case "RadioButton" : 
						return GetRadioButton(skinName);
					case "Slider" : 
						return GetSlider(skinName);
					case "SkinFrame" : 
						return GetSkinFrame(skinName);
					case "SkinImage" : 
						return GetSkinImage(skinName);
					case "ImageNumber" :
						return GetImageNumber(skinName);
				}
			}
			
			return null;
//			throw(new Error("SkinManager.GetSkin exit Skin"));
		}
		
		public static function GetButtonSkin(name : String) : Object
		{
			if(s_curbuttonList.hasOwnProperty(name))
			{
				return s_curbuttonList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_buttonList[name]);
			
			if(skinInfo==null)
			{
				Alert.show("Button not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["upSkin"] = atlas.getTexture(skinInfo["upSkin"]);
			skinInfo["downSkin"] = atlas.getTexture(skinInfo["downSkin"]);
			skinInfo["disabledSkin"] = atlas.getTexture(skinInfo["disabledSkin"]);
			
			s_curbuttonList[name] = skinInfo;
			
			return skinInfo;
		}
		
		public static function GetPopupWindowSkin(name : String) : Object
		{
			if(s_curpopupWindowList.hasOwnProperty(name))
			{
				return s_curpopupWindowList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_popupWindowList[name]);
			
			if(skinInfo==null)
			{
				Alert.show("TitleWindow not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["skin"] = atlas.getTexture(skinInfo["skin"]);
			skinInfo["closeUpSkin"] = atlas.getTexture(skinInfo["closeUpSkin"]);
			skinInfo["closeDownSkin"] = atlas.getTexture(skinInfo["closeDownSkin"]);

			
			s_curpopupWindowList[name] = skinInfo;
			
			return skinInfo;
		}
		
		public static function GetImageButtonSkin(name : String) : Object
		{
			if(s_curimagebuttonList.hasOwnProperty(name))
			{
				return s_curimagebuttonList[name];
			}

			var skinInfo : Object = Tool.UpdateObjectProperty(s_imagebuttonList[name]);
			
			if(skinInfo==null)
			{
				Alert.show("ImageButton not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["upSkin"] = atlas.getTexture(skinInfo["upSkin"]);
			skinInfo["downSkin"] = atlas.getTexture(skinInfo["downSkin"]);
			skinInfo["disabledSkin"] = atlas.getTexture(skinInfo["disabledSkin"]);
			
			s_curimagebuttonList[name] = skinInfo;
			
			return skinInfo;
		}
		
		public static function GetCheckBox(name : String) : Object
		{
			if(s_curcheckBoxList.hasOwnProperty(name))
			{
				return s_curcheckBoxList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_checkBoxList[name]);
			
			if(skinInfo==null)
			{
				Alert.show("CheckBox not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["upSkin"] = atlas.getTexture(skinInfo["upSkin"]);
			skinInfo["downSkin"] = atlas.getTexture(skinInfo["downSkin"]);
			
			s_curcheckBoxList[name] = skinInfo;
			
			return skinInfo;
		}
		
		public static function GetRadioButton(name : String) : Object
		{
			if(s_curradiobuttonList.hasOwnProperty(name))
			{
				return s_curradiobuttonList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_radiobuttonList[name]);
			
			if(skinInfo==null)
			{
				Alert.show("RadioButton not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["upSkin"] = atlas.getTexture(skinInfo["upSkin"]);
			skinInfo["downSkin"] = atlas.getTexture(skinInfo["downSkin"]);
			
			s_curradiobuttonList[name] = skinInfo;
			
			return skinInfo
		}
		
		public static function GetSlider(name : String) : Object
		{
			if(s_cursliderList.hasOwnProperty(name))
			{
				return s_cursliderList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_sliderList[name]);
			if(skinInfo==null)
			{
				Alert.show("Slider not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["upSkin"] = atlas.getTexture(skinInfo["upSkin"]);
			skinInfo["downSkin"] = atlas.getTexture(skinInfo["downSkin"]);
			skinInfo["backtexture"] = atlas.getTexture(skinInfo["backtexture"]);
			
			s_cursliderList[name] = skinInfo;
			
			return skinInfo;
			
		}
		
		public static function GetSkinFrame(name : String) : Object
		{
			if(s_curuiframeList.hasOwnProperty(name))
			{
				return s_curuiframeList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_uiframeList[name]);
			if(skinInfo==null)
			{
				Alert.show("SkinFrame not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}	
			
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["skin"] = atlas.getTexture(skinInfo["skin"]);

			if(!skinInfo["skin"]){
				
				Alert.show("SkinFrame not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			s_curuiframeList[name] = skinInfo;
			
			return skinInfo;
			
		}
		
		public static function GetSkinImage(name : String) : Object
		{
			if(s_curuiimageList.hasOwnProperty(name))
			{
				return s_curuiimageList[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_uiimageList[name]);
			
			if(skinInfo==null)
			{
				Alert.show("SkinImage not found :" + name,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["skin"] = atlas.getTexture(skinInfo["skin"]);
			
			if(!skinInfo["skin"]){
				Alert.show("SkinImage not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			s_curuiimageList[name] = skinInfo;
			
			return skinInfo;
		}
		
		public static function GetImageNumber(name : String) : Object
		{
			if(s_curimagenumber.hasOwnProperty(name))
			{
				return s_curimagenumber[name];
			}
			
			var skinInfo : Object = Tool.UpdateObjectProperty(s_imagenumber[name]);
			if(skinInfo==null)
			{
				Alert.show("ImageNumber not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			var atlas : TextureAtlas = TexturesManager.GetAtlas(skinInfo["skinParent"]);
			
			skinInfo["skin"] = atlas.getTextures(skinInfo["skin"]);
			
			if(!skinInfo["skin"]){
				
				Alert.show("ImageNumber not found :" + name ,"SkinManager",Alert.OK,RookieEditor.getInstante().Editor);
				return null;
			}
			
			s_curimagenumber[name] = skinInfo;
			
			return skinInfo;
		}
	}
}
