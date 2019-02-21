public class ParseEntity
{
	public static String preResponse;
	
	public ParseEntity(String input){
		this.preResponse = input;
	}


	public String getFullResponse(){
		return preResponse;
	}

	public String getLabelValue(String key){
		JSONObject d = new JSONObject(preResponse).getJSONObject("d");
		JSONObject joLabel = d.getJSONObject("label");
		JSONArray labelArray =joLabel.getJSONObject("labels").getJSONArray("results");
		for(int i=0; i < labelArray.length(); i++){
			if(labelArray.get(i).getString("key").equals(key)){
				return labelArray.get(i).getString("value");
			}
		}
	}

}