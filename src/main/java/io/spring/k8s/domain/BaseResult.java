package io.spring.k8s.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;


@Getter
@ToString
@AllArgsConstructor
public class BaseResult<T> {
    private T data;

    private String errorMessage;


    public static <T> BaseResult<T> ok(T data) {
        return new BaseResult<>(data, null);
    }
}