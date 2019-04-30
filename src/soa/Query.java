package soa;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;

import org.json.JSONArray;
import org.json.JSONObject;

public class Query {

	public static String[] GetCountryAndWeather(String city) {
		String cod = "";
		String pais = "";
		String weather = "";
		String infoPais = "";
		Client client = ClientBuilder.newClient();
		try {
			infoPais = client.target("http://api.openweathermap.org/data/2.5/weather").queryParam("q", city)
					.queryParam("APPID", "96af234bd42e33bfdd5c708d26c81523").request().get(String.class);
			JSONObject arr = new JSONObject(infoPais);
			pais = arr.getJSONObject("sys").getString("country");
			weather = arr.getJSONArray("weather").getJSONObject(0).getString("description");
		} catch (Exception e) {
			cod = "404";
		}
		client.close();
		String[] out = { pais, weather, cod };
		return out;
	}

	public static String[] GetNameAndCurrency(String country) {
		Client client = ClientBuilder.newClient();
		String infoPais = client.target("https://restcountries.eu/rest/v1/alpha").queryParam("codes", country).request()
				.get(String.class);
		JSONArray arr = new JSONArray(infoPais);
		String name = arr.getJSONObject(0).getString("name");
		String moneda = arr.getJSONObject(0).getJSONArray("currencies").getString(0);
		client.close();
		String[] out = { name, moneda };
		return out;
	}

	public static Float GetChange(String currency) {
		Client client = ClientBuilder.newClient();
		String infoPais = client.target("https://free.currencyconverterapi.com/api/v6/convert")
				.queryParam("q", currency + "_EUR").queryParam("compact", "ultra")
				.queryParam("apiKey", "933b368ba225782e47dd").request().get(String.class);
		JSONObject arr = new JSONObject(infoPais);
		Float moneda = arr.getFloat(currency + "_EUR");
		client.close();
		return moneda;
	}
}
