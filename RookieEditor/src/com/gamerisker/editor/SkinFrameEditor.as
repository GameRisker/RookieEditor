package com.gamerisker.editor
{
	import com.gamerisker.containers.SkinFrame;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class SkinFrameEditor extends Editor
	{
		private var m_skinFrame : SkinFrame;
		private var m_skin : String;
		private var m_width : Number;
		private var m_height : Number;
		private var m_enabled : Boolean;
		
		public function SkinFrameEditor()
		{
			m_type = "SkinFrame";
			
			m_skinFrame = new SkinFrame;
			m_skinFrame.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_skinFrame);
		}
		
		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			skin = "chat_liaotiankuang";
			width = 100;
			height = 100;
			alpha = 1;
			enabled = true;
		}

		public function get skin():String
		{
			return m_skin;
		}

		public function set skin(value:String):void
		{
			m_skin = value;
			m_skinFrame.skinInfo = SkinManager.GetSkinFrame(value);
		}

		override public function get width():Number
		{
			return m_width;
		}

		override public function set width(value:Number):void
		{
			m_width = value;
			m_skinFrame.width = value;
		}

		override public function get height():Number
		{
			return m_height;
		}

		override public function set height(value:Number):void
		{
			m_height = value;
			m_skinFrame.height = value;
		}

		override public function set alpha(value:Number):void
		{
			m_skinFrame.alpha = value;
		}
		
		override public function get alpha():Number
		{
			return m_skinFrame.alpha;
		}

		public function get enabled():Boolean
		{
			return m_enabled;
		}

		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_skinFrame.enabled = value;
		}
		
		override public function toCopy():Editor
		{
			var _skin : SkinFrameEditor = new SkinFrameEditor();
			_skin.xmlToComponent(new XML(toXMLString()));
			_skin.id = GUI.getInstanteIdNew();
			return _skin;
		}

		override public function toXMLString():String
		{
			var xml : String = '<SkinFrame id="'
				+id+
				'" skin="'
				+skin+
				'" x="'
				+x+
				'" y="'
				+y+
				'" width="'
				+width+
				'" height="'
				+height+
				'" alpha="'
				+alpha+
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
			
			return xml += '</SkinFrame>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "skin" , "Value" : skin};
			list[2] = {"Name" : "enabled" , "Value" : enabled};
			list[3] = {"Name" : "alpha" , "Value" : alpha};
			list[4] = {"Name" : "x" , "Value" : x};
			list[5] = {"Name" : "y" , "Value" : y};
			list[6] = {"Name" : "width" , "Value" : width};
			list[7] = {"Name" : "height" , "Value" : height};
			return new ArrayList(list);
		}
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			
			skin = value.@skin.toString();
			width = value.@width.toString();
			height = value.@height.toString();
			enabled = (value.@enabled.toString() == "true" ? true : false);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			return this;
		}
	}
}