package com.gamerisker.editor
{
	import com.gamerisker.core.Component;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.utils.GUI;
	
	import mx.collections.ArrayList;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Editor extends Sprite implements IEditor
	{
		private var m_id : String;
		
		private var m_controlList : Array;		//保存控制块
		
		private var m_childList : Vector.<Editor>;

		private var m_x : int;
		
		private var m_y : int;
		
		private var m_alpha : Number;
		
		protected var m_type : String;
		
		public function get type():String{return m_type;}
		
		override public function get alpha():Number{return m_alpha;}
		override public function set alpha(value:Number):void
		{
			m_alpha = value;
			super.alpha = value;
		}
		
		//保存操作添加的子类
		
		public function get id():String{return m_id;}
		public function set id(value:String):void{m_id = value;}

		public function Editor()
		{
			m_childList = new Vector.<Editor>;
			m_controlList = new Array;
		}
				
		public function get childList():Vector.<Editor>{return m_childList;}
		
		override public function get x():Number{return m_x;}
		override public function set x(value:Number):void
		{
			m_x = value;		
			super.x = m_x;
		}
		
		override public function get y():Number{return m_y;}
		override public function set y(value:Number):void
		{
			m_y = value;
			super.y = m_y;
		}
		
		public function create() : void{}
		
		public function toArrayList() : ArrayList
		{
			return null;
		}
		
		public function toXMLString():String
		{
			return null;
		}
		
		public function xmlToComponent(value : XML) : Editor
		{
			return null;
		}
		
		public function destroy():void
		{
		}
		
		public function setStyleName(name:String, value:*):void
		{
		}
				
		public function toCopy():Editor
		{
			return null;
		}
		
		public function getComponent() : Component
		{
			return null;
		}
		
		/**
		 *	添加控制块 
		 * @param args
		 * 
		 */		
		public function addControl(... args) : void
		{
			for(var i:int=0;i<args.length;i++)
			{
				m_controlList.push(addChild(args[i]));
			}
		}
		
		public function removeControl() : void
		{
			for(var i:int=0;i<m_controlList.length;i++)
			{
				removeChild(m_controlList[i]);
			}
		}
		
		/**
		 *	添加子组件进入 组件 
		 * @param editor
		 * @return 
		 * 
		 */		
		public function addEditor(editor : Editor) : Editor
		{
			addChild(editor);
			
			m_childList.push(editor);
			
			return editor;
		}
		
		public function removeEditor(editor : Editor) : Editor
		{
			removeChild(editor);
			
			m_childList.splice(m_childList.indexOf(editor),1);
			
			return editor;
		}
		
		protected function onCreateComponent(event : Event) : void
		{
			dispatchEventWith(ComponentEvent.CREATION_COMPLETE);
		}

	}
}