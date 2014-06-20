package com.gamerisker.editor
{
	import com.gamerisker.controls.List;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.utils.GUI;
	
	import flash.display.Shape;
	
	import mx.collections.ArrayList;
	
	import starling.display.Image;
	import starling.text.TextField;

	public class ListEditor extends Editor
	{
		private var m_back : Image;
		private var m_txt : TextField
		
		private var m_list : List;
		private var m_width : Number;
		private var m_height : Number;
		private var m_rowHeight : int;
		
		public function ListEditor()
		{
			m_type = "List";
		
			var box : flash.display.Shape = new flash.display.Shape;
			box.graphics.beginFill(0x0033ff);
			box.graphics.drawRect(0,0,100,100);
			box.graphics.endFill();
			var bitmap : flash.display.Bitmap = new flash.display.Bitmap;
			var bitmapdata : flash.display.BitmapData = new flash.display.BitmapData(100,100);
			bitmapdata.draw(box);
			bitmap.bitmapData = bitmapdata;
			m_back = starling.display.Image.fromBitmap(bitmap);
			m_back.alpha = 0.3
			m_txt = new TextField(50,20,"List");
			m_txt.name = "title";
			m_txt.touchable = false;
			m_txt.x = (m_back.width - m_txt.width) >> 1;
			m_txt.y = (m_back.height - m_txt.height) >> 1;
			addChild(m_back);
			addChild(m_txt);
			
			m_list = new List;
			m_list.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_list);
		}
		
		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			width = 100;
			height = 100;
			rowHeight = 20;
			alpha = 1;
		}
		
		override public function get width():Number
		{
			return m_width;
		}

		override public function set width(value:Number):void
		{
			m_back.width = value;
			m_width = value;
			m_list.width = value;
			
			m_txt.x = (m_back.width - m_txt.width) >> 1;
			m_txt.y = (m_back.height - m_txt.height) >> 1;
		}

		override public function get height():Number
		{
			return m_height;
		}

		override public function set height(value:Number):void
		{
			m_back.height = value;
			m_height = value;
			m_list.height = value;
			
			m_txt.x = (m_back.width - m_txt.width) >> 1;
			m_txt.y = (m_back.height - m_txt.height) >> 1;
		}

		public function get rowHeight():int
		{
			return m_rowHeight;
		}

		public function set rowHeight(value:int):void
		{
			m_rowHeight = value;
			m_list.rowHeight = value;
		}
		
		override public function toCopy():Editor
		{
			var _list : ListEditor = new ListEditor();
			_list.xmlToComponent(new XML(toXMLString()));
			_list.id = GUI.getInstanteIdNew();
			return _list;
		}
		
		override public function toXMLString():String
		{
			var xml : String = '<List id="'
				+id+
				'" x="'
				+x+
				'" y="'
				+y+
				'" width="'
				+width+
				'" height="'
				+height+
				'" rowHeight="'
				+rowHeight + 
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
			
			return xml += '</List>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "width" , "Value" : width};
			list[2] = {"Name" : "height" , "Value" : height};
			list[3] = {"Name" : "alpha" , "Value" : alpha};
			list[4] = {"Name" : "x" , "Value" : x};
			list[5] = {"Name" : "y" , "Value" : y};
			list[6] = {"Name" : "rowHeight" , "Value" : rowHeight};
			
			return new ArrayList(list);
		}
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			width = int(value.@width);
			height = int(value.@height);
			rowHeight = int(value.@rowHeight);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			
			return this;
		}
	}
}