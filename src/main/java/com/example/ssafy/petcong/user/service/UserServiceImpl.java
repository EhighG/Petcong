package com.example.ssafy.petcong.user.service;

import com.example.ssafy.petcong.user.model.entity.User;
import com.example.ssafy.petcong.user.model.entity.UserImg;
import com.example.ssafy.petcong.user.model.record.UserImgRecord;
import com.example.ssafy.petcong.user.model.record.UserRecord;
import com.example.ssafy.petcong.user.repository.UserImgRepository;
import com.example.ssafy.petcong.user.repository.UserRepository;

import jakarta.transaction.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest;
import software.amazon.awssdk.services.s3.presigner.model.PresignedGetObjectRequest;

import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final Bucket bucket;
    private final S3Client s3Client;
    private final S3Presigner s3Presigner;
    private final UserRepository userRepository;
    private final UserImgRepository userImgRepository;

    @Override
    public UserRecord findUserByUid(String uid) {
        User result = userRepository.findUserByUid(uid);
        UserRecord record = new UserRecord(result);
        return record;
    }

    @Override
    public UserRecord save(UserRecord userRecord) {
        User userEntity = new User(userRecord);
        User result = userRepository.save(userEntity);
        UserRecord record = new UserRecord(result);
        return record;
    }

    @Override
    public UserRecord updateCallable(UserRecord userRecord, boolean state) {
        User userEntity = new User(userRecord).updateCallable(state);
        User result = userRepository.save(userEntity);
        UserRecord record = new UserRecord(result);
        return record;
    }

    @Override
    public String createPresignedUrlForGetImage(String key) {
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(bucket.name())
                .key(key)
                .build();

        GetObjectPresignRequest presignRequest = GetObjectPresignRequest.builder()
                .getObjectRequest(getObjectRequest)
                .signatureDuration(Duration.ofMinutes(10))
                .build();

        PresignedGetObjectRequest presignedRequest = s3Presigner.presignGetObject(presignRequest);

        String url = presignedRequest.url().toString();
        return url;
    }

    @Override
    @Transactional
    public UserImgRecord uploadImage(UserRecord user, MultipartFile file) throws IOException {
        try (InputStream fileInputStream = file.getInputStream()) {
            String uid = user.uid();
            String key = new StringBuilder(uid)
                    .append("-")
                    .append(file.getOriginalFilename())
                    .toString();
            String contentType = file.getContentType();
            long size = file.getSize();
            log.info("key: " + key);

            UserImg userImg = UserImg.builder()
                    .user(user.userId())
                    .url(key)
                    .contentType(contentType)
                    .length(size)
                    .build();

            UserImg result = userImgRepository.save(userImg);

            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucket.name())
                    .key(result.getUrl())
                    .contentType(result.getContentType())
                    .contentLength(result.getLength())
                    .build();

            RequestBody requestBody = RequestBody.fromInputStream(fileInputStream, result.getLength());

            s3Client.putObject(putObjectRequest, requestBody);

            return new UserImgRecord(result);
        }
    }
}
