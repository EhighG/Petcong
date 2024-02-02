package com.example.ssafy.petcong.AWS.service;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectResponse;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest;
import software.amazon.awssdk.services.s3.presigner.model.PresignedGetObjectRequest;

import java.io.IOException;
import java.time.Duration;

@Service
@RequiredArgsConstructor
public class AWSServiceImpl implements AWSService{
    private final Bucket bucket;
    private final S3Client s3Client;
    private final S3Presigner s3Presigner;

    @Override
    public String upload(String key, MultipartFile file) throws IOException {
        PutObjectRequest putObjectRequest = createPutObjectRequest(key, file);
        uploadFileToS3(file, putObjectRequest);
        return key;
    }

    private PutObjectRequest createPutObjectRequest(String key, MultipartFile file) {
        return PutObjectRequest.builder()
                .bucket(bucket.name())
                .key(key)
                .contentType(file.getContentType())
                .contentLength(file.getSize())
                .build();
    }

    private PutObjectResponse uploadFileToS3(MultipartFile file, PutObjectRequest putObjectRequest) throws IOException {
        RequestBody requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
        return s3Client.putObject(putObjectRequest, requestBody);
    }

    @Override
    public String createPresignedUrl(String key) {
        return createPresignedUrl(key, Duration.ofMinutes(30));
    }

    @Override
    public String createPresignedUrl(String key, Duration duration) {
        GetObjectRequest getObjectRequest = getObjectRequest(key);

        GetObjectPresignRequest presignRequest = getObjectPresignRequest(getObjectRequest, duration);

        String presignedUrl = s3Presigner.presignGetObject(presignRequest).url().toString();

        return presignedUrl;
    }

    private GetObjectRequest getObjectRequest(String key) {
        return GetObjectRequest.builder()
                .bucket(bucket.name())
                .key(key)
                .build();
    }

    private GetObjectPresignRequest getObjectPresignRequest(GetObjectRequest getObjectRequest, Duration duration) {
        return GetObjectPresignRequest.builder()
                .getObjectRequest(getObjectRequest)
                .signatureDuration(duration)
                .build();
    }
}
