package com.gamerisker.editor
{
	import com.gamerisker.controls.ImageNumber;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class ImageNumberEditor extends Editor
	{
		private var m_imageNumber : ImageNumber;
		
		private var m_skin : String;
		private var m_value : int;
		private var m_digit : int;
		private var m_distance : int;
		private var m_enabled : Boolean;
		private var m_isShow : Boolean;
		
		public function ImageNumberEditor()
		{
			m_type = "ImageNumber";
			m_imageNumber = new ImageNumber;
			m_imageNumber.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_imageNumber);
		}

		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			skin = "num_";
			value = 100;
			alpha = 1;
			digit = 3;
			distance = 5;
			enabled = false;
			isShow = false;
		}
		
		override public function set width(value:Number):void{}
		override public function get width():Number{return m_imageNumber.width};
		
		override public function set height(value:Number):void{}
		override public function get height():Number{return m_imageNumber.height};
		
		public function get skin():String
		{
			return m_skin;
		}

		public function set skin(value:String):void
		{
			m_skin = value;
			m_imageNumber.skinInfo = SkinManager.GetImageNumber(value);
		}

		public function get value():int
		{
			return m_value;
		}

		public function set value(value:int):void
		{
			m_value = value;
			m_imageNumber.value = value;
		}

		public function get digit():int
		{
			return m_digit;
		}

		public function set digit(value:int):void
		{
			m_digit = value;
			m_imageNumber.digit = value;
		}

		public function get distance():int
		{
			return m_distance;
		}

		public function set distance(value:int):void
		{
			m_distance = value;
			m_imageNumber.distance = value;
		}

		public function get enabled():Boolean
		{
			return m_enabled;
		}

		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_imageNumber.enabled = value;
		}

		public function get isShow():Boolean
		{
			return m_isShow;
		}

		public function set isShow(value:Boolean):void
		{
			m_isShow = value;
			m_imageNumber.isShow = value;
		}
		
		override public function toCopy():Editor
		{
			var _num : ImageNumberEditor = new ImageNumberEditor();
			_num.xmlToComponent(new XML(toXMLString()));
			_num.id = GUI.getInstanteIdNew();
			return _num;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<ImageNumber id="'
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
								'" enabled="'
								+enabled+
								'" value="'
								+value + 
								'" isShow="'
								+isShow + 
								'" digit="'
								+digit + 
								'" distance="'
								+distance + 
								'" alpha="'
								+alpha + 
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
			
			return xml += '</ImageNumber>';

		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "skin" , "Value" : skin};
			list[2] = {"Name" : "value" , "Value" : value};
			list[3] = {"Name" : "isShow" , "Value" : isShow};
			list[4] = {"Name" : "enabled" , "Value" : enabled};
			list[5] = {"Name" : "alpha" , "Value" : alpha};
			list[6] = {"Name" : "x" , "Value" : x};
			list[7] = {"Name" : "y" , "Value" : y};
			list[8] = {"Name" : "digit" , "Value" : digit};
			list[9] = {"Name" : "distance" , "Value" : distance};
			
			return new ArrayList(list);
		}
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			skin = value.@skin.toString();
			this.value = int(value.@value);
			isShow = (value.@enabled.toString() == "true" ? true : false);
			enabled = (value.@enabled.toString() == "true" ? true : false);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			digit = int(value.@digit);
			distance = int(value.@distance);
			
			width = int(value.@width);
			height = int(value.@height);

			return this;
		}
	}
}