package com.gamerisker.editor
{
	import com.gamerisker.controls.Slider;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class SliderEditor extends Editor
	{
		private var m_slider : Slider;
		private var m_skin : String;
		private var m_minimum : Number;
		private var m_maximum : Number;
		private var m_value : Number;
		
		public function SliderEditor()
		{
			m_type = "Slider";
			
			m_slider = new Slider;
			m_slider.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_slider);
		}

		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			skin = "SliderDefault";
			minimum = 0;
			maximum = 100;
			value = 0;
			width = 400;
			height = 10
			alpha = 1;
		}
		
		override public function get width():Number{return m_slider.width}
		override public function set width(value:Number):void{m_slider.width = value;}
		
		override public function get height():Number{return m_slider.height}
		override public function set height(value:Number):void{m_slider.height = value}
		
		public function get skin():String{return m_skin;}
		public function set skin(value:String):void
		{
			m_skin = value;
			m_slider.skinInfo = SkinManager.GetSlider(value);
		}

		public function get minimum():Number{return m_minimum;}
		public function set minimum(value:Number):void
		{
			m_minimum = value;
			m_slider.minimum = value;
		}

		public function get maximum():Number{return m_maximum;}
		public function set maximum(value:Number):void
		{
			m_maximum = value;
			m_slider.maximum = value;
		}

		public function get value():Number{return m_value;}
		public function set value(value:Number):void
		{
			m_value = value;
			m_slider.value = value;
		}

		override public function set alpha(value:Number):void{m_slider.alpha = value}
		override public function get alpha():Number{return m_slider.alpha}

		override public function toCopy():Editor
		{
			var _slider : SliderEditor = new SliderEditor();
			_slider.xmlToComponent(new XML(toXMLString()));
			_slider.id = GUI.getInstanteIdNew();
			return _slider;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<Slider id="'
				+id+
				'" skin="'
				+skin+
				'" x="'
				+x+
				'" y="'
				+y+
				'" minimum="'
				+minimum+
				'" maximum="'
				+maximum+
				'" value="'
				+value+
				'" width="'
				+width+
				'" height="'
				+height+
				'" alpha="'
				+alpha+
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
			
			return xml += '</Slider>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "skin" , "Value" : skin};
			list[2] = {"Name" : "minimum" , "Value" : minimum};
			list[3] = {"Name" : "maximum" , "Value" : maximum};
			list[4] = {"Name" : "value" , "Value" : value};
			list[5] = {"Name" : "width" , "Value" : width};
			list[6] = {"Name" : "height" , "Value" : height};
			list[7] = {"Name" : "alpha" , "Value" : alpha};
			list[8] = {"Name" : "x" , "Value" : x};
			list[9] = {"Name" : "y" , "Value" : y};
			
			return new ArrayList(list);
		}
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			skin = value.@skin.toString();
			minimum = Number(value.@minimum);
			maximum = Number(value.@maximum);
			this.value = Number(value.@value);
			width = int(value.@width);
			height = int(value.@height);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			
			return this;
		}
	}
}