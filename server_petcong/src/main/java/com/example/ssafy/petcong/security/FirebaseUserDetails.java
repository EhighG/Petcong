package com.example.ssafy.petcong.security;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

@RequiredArgsConstructor
public class FirebaseUserDetails implements UserDetails {
    public static final String UID = "uid";
    public static final String USER_ID = "userId";

    @Getter
    private final String uid;
    private final String userId;
    private final boolean status;
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return this.userId;
    }

    @Override
    public String getUsername() {
        return this.uid;
    }

    @Override
    public boolean isAccountNonExpired() {
        return isEnabled();
    }

    @Override
    public boolean isAccountNonLocked() {
        return isEnabled();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isEnabled();
    }

    @Override
    public boolean isEnabled() {
        return isLiveUser();
    }

    private boolean isLiveUser() {
        return this.status;
    }

    public int getUserId() {
        return Integer.parseInt(this.userId);
    }
}
