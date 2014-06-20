package com.gamerisker.command
{
	import com.gamerisker.core.Define;
	import com.gamerisker.editor.Editor;
	import com.gamerisker.manager.ComponentManager;
	
	import flash.events.EventDispatcher;

	public class Command implements ICommand
	{
		public static const MoveName : String = "移动命令";
		public static const AddName : String = "添加命令";
		public static const DelName : String = "删除命令";
		public static const SwapName : String = "换层命令";
		public static const ChangeName : String = "属性改变命令";
		public static const NewName : String = "新建舞台";
		public static const ClearName : String = "清空舞台";
		
		private var m_list : Array
		private var m_name : String;
		private var m_xml : String = "";
		
		public function Command(type : String)
		{
			m_name = type;
			m_list = new Array;
			
			var numChildren : int = Define.editorContainer.numChildren;
			var index : int = 1;
			var editor : Editor;
			
			while(index < numChildren)
			{
				editor = Define.editorContainer.getChildAt(index++) as Editor;
				if(editor)
				{
					m_list.push(editor.toXMLString());
					m_xml += editor.toXMLString();
				}
			}
		}
		
		public function execute() : void
		{
			while(Define.editorContainer.numChildren > 1)
			{
				Define.editorContainer.removeChildAt(1);
			}
			
			var editor : Editor
			for(var i:int=0;i<m_list.length;i++)
			{
				editor = ComponentManager.setComponentByXML(new XML(m_list[i]));
				Define.Scene_Edit.addChild(editor);
			}
		}
		
		public function isCheck():String
		{
			return m_xml;
		}
		
		public function get name():String
		{
			return m_name;
		}
		
		public function destroy() : void
		{
			m_list = null;
		}
	}
}