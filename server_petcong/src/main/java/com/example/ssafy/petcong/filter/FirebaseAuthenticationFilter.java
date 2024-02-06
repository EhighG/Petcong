package com.example.ssafy.petcong.filter;

import com.example.ssafy.petcong.security.FirebaseAuthenticationToken;
import com.example.ssafy.petcong.security.FirebaseUserDetails;
import com.example.ssafy.petcong.security.UserRole;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class FirebaseAuthenticationFilter extends OncePerRequestFilter {
    private static final String TOKEN = "Petcong-id-token";
    private final AuthenticationManager authenticationManager;
    private HttpServletRequest httpServletRequest;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Assert.isInstanceOf(UserRole.class, request.getAttribute("role"), "Require UserRole type instance in request's attributes.");

        this.httpServletRequest = request;

        UserRole role = (UserRole) request.getAttribute("role");

        Authentication authenticated = attemptAuthenticate(role);

        saveAuthentication(authenticated);

        filterChain.doFilter(request, response);
    }

    protected Authentication attemptAuthenticate(UserRole role) {
        Authentication authentication;

        if (role.equals(UserRole.ANONYMOUS)) { // anonymous request
            UserDetails anonymousUserDetails = new FirebaseUserDetails(role.getUid(), role.getUserId(), role.isStatus());
            AbstractAuthenticationToken authenticatedToken = FirebaseAuthenticationToken.authenticated(anonymousUserDetails, anonymousUserDetails.getPassword(), null);
            authenticatedToken.setDetails(anonymousUserDetails);
            return authenticatedToken;
        } else {
            String idToken = getTokenFromHeader(); // unauthenticated request
            idToken = (idToken != null) ? idToken.trim() : "";
            authentication = FirebaseAuthenticationToken.unauthenticated(idToken);
            return authenticate(authentication);
        }
    }

    private Authentication authenticate(Authentication authentication) {
        return authenticationManager.authenticate(authentication);
    }

    private void saveAuthentication(Authentication authentication) {
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    private String getTokenFromHeader() {
        Assert.notNull(this.httpServletRequest, "HttpServletRequest must not be null.");

        return this.httpServletRequest.getHeader(TOKEN);
    }
}