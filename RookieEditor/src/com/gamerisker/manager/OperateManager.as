package com.gamerisker.manager
{
	import com.gamerisker.command.ICommand;
	import com.gamerisker.core.Define;
	import com.gamerisker.editor.Editor;

	/**
	 *	操作管理器 
	 * @author GameRisker
	 * 
	 */	
	public class OperateManager
	{
		private static var operateList : Vector.<ICommand>;
		private static var Index : int = -1;
		private static const MaxLeng : int = 50;
		private static var isChange : Boolean = false;
		
		public function OperateManager() 
		{
			operateList = new Vector.<ICommand>;
		}
		
		/**
		 *	记录操作 
		 * 
		 */		
		/**
		 *	记录操作 
		 * @param command	操作命令
		 * @param isCheck	是否检查命令相同	true:不检查	 false:检查（默认）
		 * @return 
		 * 
		 */		
		public function addCommand(command : ICommand,isCheck : Boolean = false) : ICommand
		{
			if(checkSame(command) || isCheck)
			{
				if(isChange)
				{
					operateList.length = Index + 1;
					isChange = false;
				}
				
				if(MaxLeng < operateList.length)
				{
					operateList.shift();
				}
				
				operateList.push(command);
				
				Index = -1;
				
				RookieEditor.getInstante().Histroy.update();
				
//				trace("operateList Index : " , Index)
			}
			return command;
		}
		
		/**
		 *	添加命令 切执行 
		 * @param command
		 * 
		 */		
		public function pushCommand(command : ICommand) : void
		{
//			addCommand(command).execute();
		}
		
		/**
		 *	撤销 
		 * @return 
		 * 
		 */		
		public function onDownKeyZ() : void
		{
			if(operateList.length > 0)
			{
				if(Index == -1)
					Index = operateList.length - 2;
				else if(Index > 0)
					Index--;
				
				if(Index < operateList.length && Index > -1)
				{
					var command : ICommand = operateList[Index];
					if(command)
					{
						isChange = true;
						command.execute();
					}
//					trace("operateList Index : " , Index)
					RookieEditor.getInstante().Histroy.selectedIndex(Index);
				}
				
			}
		}
		
		/**
		 *	撤销反向 
		 * @return 
		 * 
		 */		
		public function onDownKeyY() : void
		{
			if(operateList.length > 0)
			{
				Index++;
				
				Index = Math.min(Index , operateList.length - 1);
				
				if(Index < operateList.length && Index > -1)
				{
					var command : ICommand = operateList[Index];
					
					if(command)
					{
						isChange = true;
						command.execute();
					}
					
					RookieEditor.getInstante().Histroy.selectedIndex(Index);
//					trace("operateList Index : " , Index)
				}
			}
		}
		
		/**
		 *	检查相同 
		 * @param list
		 * @return 
		 * 
		 */		
		private function checkSame(command : ICommand) : Boolean
		{
			for each(var item : ICommand in operateList)
			{
				if(item.isCheck() == command.isCheck())
				{
					return false;
				}
			}
			return true;
		}
		
		public function getList() : Array
		{
			var list : Array = new Array;
			for each(var item : ICommand in operateList)
			{
				list.push(item);
			}
			return list;
		}
	}
}
