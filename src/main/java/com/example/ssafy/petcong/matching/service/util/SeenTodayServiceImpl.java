package com.example.ssafy.petcong.matching.service.util;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

public class SeenTodayServiceImpl implements  SeenTodayService {
    private final ConcurrentHashMap<Integer, Set<Integer>> userProfileMap = new ConcurrentHashMap<>();

    // Method to track a profile seen by a user
    @Override
    public void addSeen(int userId, int profileId) {
        // Using computeIfAbsent to ensure that the set is created if it doesn't exist
        userProfileMap.computeIfAbsent(userId, k -> new ConcurrentSkipListSet<>()).add(profileId);
    }

    // Method to get profiles seen by a user
    @Override
    public Set<Integer> getProfilesSeenByUser(int userId) {
        return userProfileMap.getOrDefault(userId, new ConcurrentSkipListSet<>());
    }

    @Override
    public boolean hasSeen(int userId, int profileId) {
        return userProfileMap.getOrDefault(userId, new ConcurrentSkipListSet<>()).contains(profileId);
    }

}
