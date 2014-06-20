package com.gamerisker.utils
{
	
	
	/**
	 * 界面管理
	 * @author liuyong
	 */	
	public class GUI 
	{		
//		private static var m_list : Array = new Array;
		private static var m_Number : uint;
		
		public function GUI(){}
		
		/**
		 *	获取唯一标示 
		 * @param bool		是否新创建 true:创建新标示，false不创建
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getInstanteId(value : String) : String
		{
			var num : Number = parseInt(value.slice(8));
			
			if(isNaN(num))
				num = 0;
			
			m_Number = Math.max(num , m_Number);
			
			if(value != "null")
			{
				return value;
			}
			m_Number++;
			
			return "Instante" + m_Number;
		}
		
		public static function getInstanteIdNew() : String
		{
			m_Number++;
			return "Instante" + m_Number
		}
		
//		public static function setIndex(value : String) : void
//		{
//			var s : String = value.slice(8);
//			var i : int = parseInt(s);
//			var id : int = Math.max(i,m_idNum);
//			
//			m_idNum = id;
			
//			return m_idNum;
//		}
	}
}