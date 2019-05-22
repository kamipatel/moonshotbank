public class ISReponse{
	public Integer statusCode;	
	public String tid;	
	public String session;	
	public cls_trackers[] trackers;
	public cls_captures[] captures;
	public cls_optimizations[] optimizations;
	class cls_trackers {
	}
	class cls_captures {
	}
	class cls_optimizations {
		public String data;	
		public String path;	
		public String dataMimeType;	
		public String directives;	
	}
	public static ISReponse parse(String json){
		return (ISReponse) System.JSON.deserialize(json, ISReponse.class);
	}

}