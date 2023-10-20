package org.galapagos.service;

import org.galapagos.domain.kakao.local.LocalResult;

import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.GET;
import retrofit2.http.Headers;
import retrofit2.http.Query;

public interface KakaoMapService {
	String BASE_URL = "https://dapi.kakao.com/";
	@GET("v2/local/search/keyword")
	@Headers({ "Authorization: KakaoAK bdfeccb4ad76154f2c422c96f1f37f2c" })
	Call<LocalResult> searchLocal(@Query("query") String query, @Query("size") int size, @Query("page") int page);
	
	public static KakaoMapService getService() {
		Retrofit retrofit = new Retrofit.Builder().baseUrl("https://dapi.kakao.com/")
				.addConverterFactory(GsonConverterFactory.create()).build();

		return retrofit.create(KakaoMapService.class);
	}
}
