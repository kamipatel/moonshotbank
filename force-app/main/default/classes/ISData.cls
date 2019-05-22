
public class ISData{
	
	public IsAction[] actions;

	public class IsAction {

		public String name;	
		public IsAsset asset;	
	}
	
    public class IsAsset {
		public String content;	
	}

    public class IsContent {
        public String name;	
		public String proposition;	
		public String description;	
        public String imageurl;	
	}

public class Content {
        public String name {get;set;}
        public String proposition {get;set;}
        public String description {get;set;}
        public Integer rank {get;set;}
        public String imageurl{get;set;}
        
    }

	public static ISData parse(String json){
		return (ISData) System.JSON.deserialize(json, ISData.class);
	}

}