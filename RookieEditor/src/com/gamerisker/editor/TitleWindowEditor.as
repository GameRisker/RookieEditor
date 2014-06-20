package com.gamerisker.editor
{
	import com.gamerisker.containers.TitleWindow;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class TitleWindowEditor extends Editor
	{
		private var m_window : TitleWindow;
		private var m_title : String;
		private var m_skin : String;
		private var m_fontSize : int;
		private var m_textWidth : int;
		private var m_textHeight : int;
		private var m_textX : int;
		private var m_textY : int;
		private var m_enabled : Boolean;
		
		public function TitleWindowEditor()
		{
			m_type = "TitleWindow";
			
			m_window = new TitleWindow;
			m_window.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_window);
		}

		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			title = "TitleWindow";
			skin = "default_beijing";
			width = 600;
			height = 270;
			alpha = 1;
			fontSize = 12;
			textWidth = 100;
			textHeight = 20;
			textX = 10;
			textY = 10;
			enabled = true;
		}
		
		public function get title():String
		{
			return m_title;
		}

		public function set title(value:String):void
		{
			m_title = value;
			m_window.title = value;
		}

		public function get skin():String
		{
			return m_skin;
		}

		public function set skin(value:String):void
		{
			m_skin = value;
			m_window.skinInfo = SkinManager.GetPopupWindowSkin(value)
		}

		override public function set width(value:Number):void{m_window.width = value}
		override public function get width():Number{return m_window.width}
		
		override public function set height(value:Number):void{m_window.height = value}
		override public function get height():Number{return m_window.height}

		public function get fontSize():int
		{
			return m_fontSize;
		}

		public function set fontSize(value:int):void
		{
			m_fontSize = value;
			m_window.fontSize = value;
		}

		public function get textWidth():int
		{
			return m_textWidth;
		}

		public function set textWidth(value:int):void
		{
			m_textWidth = value;
			m_window.textWidth = value;
		}

		public function get textHeight():int
		{
			return m_textHeight;
		}

		public function set textHeight(value:int):void
		{
			m_textHeight = value;
			m_window.textHeight = value;
		}

		public function get textX():int
		{
			return m_textX;
		}

		public function set textX(value:int):void
		{
			m_textX = value;
			m_window.textX = value;
		}

		public function get textY():int
		{
			return m_textY;
		}

		public function set textY(value:int):void
		{
			m_textY = value;
			m_window.textY = value;
		}

		public function get enabled():Boolean
		{
			return m_enabled;
		}

		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_window.enabled = value;
		}

		override public function toCopy():Editor
		{
			var _window : TitleWindowEditor = new TitleWindowEditor();
			_window.xmlToComponent(new XML(toXMLString()));
			_window.id = GUI.getInstanteIdNew();
			return _window;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<TitleWindow id="'
				+id+
				'" x="'
				+x+
				'" y="'
				+y+
				'" skin="'
				+skin+
				'" width="'
				+width+
				'" height="'
				+height+
				'" fontSize="'
				+fontSize+
				'" textWidth="'
				+textWidth+
				'" textHeight="'
				+textHeight+
				'" alpha="'
				+alpha+
				'" textX="'
				+textX+
				'" textY="'
				+textY+
				'" title="'
				+title+
				'" enabled="'
				+enabled+
				'"';
			
			var leng : int = childList.length;
			
			if(leng > 0)
			{
				xml += ">";
			}
			else
			{
				return xml += "/>";
			}
			
			var editor : Editor;
			for(var i:int=0;i<leng;i++)
			{
				editor = childList[i];
				xml += editor.toXMLString();
			}
			
			return xml += '</TitleWindow>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "title" , "Value" : title};
			list[2] = {"Name" : "skin" , "Value" : skin};
			list[3] = {"Name" : "width" , "Value" : width};
			list[4] = {"Name" : "height" , "Value" : height};
			list[5] = {"Name" : "alpha" , "Value" : alpha};
			list[6] = {"Name" : "fontSize" , "Value" : fontSize};
			list[7] = {"Name" : "textWidth" , "Value" : textWidth};
			list[8] = {"Name" : "textHeight" , "Value" : textHeight};
			list[9] = {"Name" : "textX" , "Value" : textX};
			list[10] = {"Name" : "textY" , "Value" : textY};
			list[11] = {"Name" : "enabled" , "Value" : enabled};
			list[12] = {"Name" : "x" , "Value" : x};
			list[13] = {"Name" : "y" , "Value" : y};
			return new ArrayList(list);
		}
		
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			title = value.@title.toString();
			skin = value.@skin.toString();
			width = int(value.@width);
			height = int(value.@height);
			alpha = Number(value.@alpha);
			fontSize = int(value.@fontSize);
			textWidth = int(value.@textWidth);
			textHeight = int(value.@textHeight);
			textX = int(value.@textX);
			textY = int(value.@textY);
			enabled = (value.@enabled.toString() == "true" ? true : false);
			
			return this;
		}
	}
}