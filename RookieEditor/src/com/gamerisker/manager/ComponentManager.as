package com.gamerisker.manager
{
	import com.gamerisker.core.Component;
	import com.gamerisker.core.Define;
	import com.gamerisker.editor.ButtonEditor;
	import com.gamerisker.editor.CheckBoxEditor;
	import com.gamerisker.editor.Editor;
	import com.gamerisker.editor.IEditor;
	import com.gamerisker.editor.ImageButtonEditor;
	import com.gamerisker.editor.ImageNumberEditor;
	import com.gamerisker.editor.LabelEditor;
	import com.gamerisker.editor.ListEditor;
	import com.gamerisker.editor.RadioButtonEditor;
	import com.gamerisker.editor.SkinFrameEditor;
	import com.gamerisker.editor.SkinImageEditor;
	import com.gamerisker.editor.SliderEditor;
	import com.gamerisker.editor.TileEditor;
	import com.gamerisker.editor.TileGroupEditor;
	import com.gamerisker.editor.TitleWindowEditor;
	
	import spark.components.Alert;
	
	import starling.events.TouchPhase;

	public class ComponentManager
	{

		/**
		 *	根据XML生成组件 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function setComponentByXML(xml : XML) : Editor
		{
			var name : String = xml.localName();
			var editor : Editor = getComponentByClass(name);
			editor.xmlToComponent(xml);
			
			var child : Editor;
			for each(var item : XML in xml.elements())
			{
				child = setComponentByXML(item);
				
				if(child)
				{
					editor.addEditor(child);
				}
			}
			
			MouseManager.AddTouch(TouchPhase.BEGAN , editor , Define.Scene_Edit.OnTouchDownClick);
			MouseManager.AddTouch(TouchPhase.HOVER , editor , Define.Scene_Edit.OnTouchMoveComponent);
			return editor
		}

		/**
		 *	根据组件名获取组件 
		 * @param className
		 * @return 
		 * 
		 */
		public static function getComponentByClass(className : String) : Editor
		{
			if(className == null)
				return null;
			
			switch(className)
			{
				case "Button" : 
					return new ButtonEditor;
				case "TitleWindow" : 
					return new TitleWindowEditor;
				case "ImageButton" :
					return new ImageButtonEditor;
				case "CheckBox" :
					return new CheckBoxEditor;
				case "RadioButton" : 
					return new RadioButtonEditor;
				case "Label" : 
					return new LabelEditor;
				case "Slider" : 
					return new SliderEditor;
				case "SkinFrame" : 
					return new SkinFrameEditor;
				case "SkinImage" : 
					return new SkinImageEditor;
				case "List" : 
					return new ListEditor;
				case "Tile" :
					return new TileEditor;
				case "TileGroup" :
					return new TileGroupEditor;
				case "ImageNumber" :
					return new ImageNumberEditor;
			}
			Alert.show("ComponentManager : 没有找到组件","错误",4,RookieEditor.getInstante().Editor);
			return null;
		}
	}
}