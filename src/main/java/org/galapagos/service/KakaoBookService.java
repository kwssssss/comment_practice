package org.galapagos.service;

import org.galapagos.domain.kakao.book.BookResult;

import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.GET;
import retrofit2.http.Headers;
import retrofit2.http.Query;

public interface KakaoBookService {
	String BASE_URL = "https://dapi.kakao.com/";
	@GET("v3/search/book")
	@Headers({ "Authorization: KakaoAK bdfeccb4ad76154f2c422c96f1f37f2c" })
	Call<BookResult> searchBook(@Query("query") String query, @Query("size") int size, @Query("page") int page);
	
	
	public static KakaoBookService getService() {
		Retrofit retrofit = new Retrofit.Builder()
										.baseUrl("https://dapi.kakao.com/")
										.addConverterFactory(GsonConverterFactory.create())
										.build();
	
	return retrofit.create(KakaoBookService.class);
	}

}
