package com.gamerisker.editor
{
	import com.gamerisker.controls.ImageButton;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.SkinManager;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;

	public class ImageButtonEditor extends Editor
	{
		private var m_imageButton : ImageButton;
		private var m_toggle : Boolean;
		private var m_enabled : Boolean;
		private var m_skin : String;
		
		public function ImageButtonEditor()
		{
			m_type = "ImageButton";
			
			m_imageButton = new ImageButton;
			m_imageButton.addEventListener(ComponentEvent.CREATION_COMPLETE , onCreateComponent);
			addChild(m_imageButton);
		}
		
		override public function create():void
		{
			id = GUI.getInstanteIdNew();
			enabled = true;
			skin = "close";
			alpha = 1;
			toggle = false;
		}
		
		override public function setStyleName(name:String, value:*):void{m_imageButton[name] = value;	}
		
		override public function get width():Number{return m_imageButton.width;}
		override public function set width(value:Number):void{}
		
		override public function get height():Number{return m_imageButton.height;}
		override public function set height(value:Number):void{}
		
		public function get enabled():Boolean{return m_enabled;}
		public function set enabled(value:Boolean):void
		{
			m_enabled = value;
			m_imageButton.enabled = value;
		}

		public function get skin():String{return m_skin;}
		public function set skin(value:String):void
		{
			m_skin = value;
			m_imageButton.skinInfo = SkinManager.GetImageButtonSkin(value);
		}

		public function get toggle():Boolean{	return m_toggle;}
		public function set toggle(value:Boolean):void
		{
			m_toggle = value;
			m_imageButton.toggle = value;
		}
		
		override public function toCopy():Editor
		{
			var _button : ImageButtonEditor = new ImageButtonEditor();
			_button.xmlToComponent(new XML(toXMLString()));
			_button.id = GUI.getInstanteIdNew();
			return _button;
		}

		
		override public function toXMLString() : String
		{
			var xml : String = '<ImageButton id="'+id+'" skin="'+skin+'" x="'+x+'" y="'+y+'" enabled="'+enabled+'" alpha="'+alpha+'" toggle="' +toggle+'"';
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
			
			return xml += '</ImageButton>';
		}
		
		override public function toArrayList():ArrayList
		{
			var list : Array = new Array;
			list[0] = {"Name" : "id" , "Value" : id};
			list[1] = {"Name" : "skin" , "Value" : skin};
			list[2] = {"Name" : "enabled" , "Value" : enabled};
			list[3] = {"Name" : "toggle" , "Value" : toggle};
			list[4] = {"Name" : "alpha" , "Value" : alpha};
			list[5] = {"Name" : "x" , "Value" : x};
			list[6] = {"Name" : "y" , "Value" : y};
			
			return new ArrayList(list);
		}
		
		override public function xmlToComponent(value:XML):Editor
		{
			id = GUI.getInstanteId(value.@id.toString());
			skin = value.@skin.toString();
			enabled = (value.@enabled.toString() == "true" ? true : false);
			toggle = (value.@toggle.toString() == "true" ? true : false);
			alpha = Number(value.@alpha);
			x = int(value.@x);
			y = int(value.@y);
			
			return this;
		}
	}
}