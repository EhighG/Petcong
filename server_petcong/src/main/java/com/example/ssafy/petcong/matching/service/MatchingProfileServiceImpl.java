package com.example.ssafy.petcong.matching.service;

import com.example.ssafy.petcong.AWS.service.AWSService;
import com.example.ssafy.petcong.matching.model.CallStatus;
import com.example.ssafy.petcong.matching.model.entity.Matching;
import com.example.ssafy.petcong.matching.model.entity.ProfileRecord;
import com.example.ssafy.petcong.matching.repository.MatchingRepository;
import com.example.ssafy.petcong.matching.service.util.OnlineMembersService;
import com.example.ssafy.petcong.matching.service.util.SeenTodayService;
import com.example.ssafy.petcong.member.model.entity.Member;
import com.example.ssafy.petcong.member.model.entity.MemberImg;
import com.example.ssafy.petcong.member.model.entity.Pet;
import com.example.ssafy.petcong.member.repository.MemberImgRepository;
import com.example.ssafy.petcong.member.repository.MemberRepository;
import com.example.ssafy.petcong.member.model.enums.Gender;
import com.example.ssafy.petcong.member.model.enums.Preference;

import com.example.ssafy.petcong.member.repository.PetRepository;
import jakarta.transaction.Transactional;

import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class MatchingProfileServiceImpl implements MatchingProfileService {
    private final OnlineMembersService onlineMembers;
    private final SeenTodayService seenToday;
    private final MemberRepository memberRepository;
    private final MatchingRepository matchingRepository;
    private final MemberImgRepository memberImgRepository;
    private final AWSService awsService;
    private final PetRepository petRepository;

    private final int NO_MEMBER = -1;

    public List<String> pictures(int memberId) {
        List<MemberImg> imgList =  memberImgRepository.findMemberImgByMember_MemberId(memberId);
        return imgList.stream()
                .map(MemberImg::getBucketKey)
                .map(awsService::createPresignedUrl)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public Optional<ProfileRecord> profile(String uid) {
        Member requestingMember = memberRepository.findMemberByUid(uid).orElseThrow(() -> new NoSuchElementException(uid));
        int filteredMemberId = NO_MEMBER;
        for (int i = 0; i < onlineMembers.sizeOfQueue(); i++) {
            int potentialMemberId = nextOnlineMember();
            if (potentialMemberId == NO_MEMBER) {
                break;
            } else if (isPotentialMember(requestingMember, potentialMemberId)) {
                filteredMemberId = potentialMemberId;
                break;
            }
        }
        if (filteredMemberId == NO_MEMBER) return Optional.empty();
        List<String> urls = pictures(filteredMemberId);
        int finalFilteredMemberId = filteredMemberId;
        Member filteredMember = memberRepository.findMemberByMemberId(filteredMemberId).orElseThrow(() -> new NoSuchElementException(String.valueOf(finalFilteredMemberId)));
        Pet filteredPet = filteredMember.getPet();

        return Optional.of(new ProfileRecord(filteredMember, filteredPet, urls));
    }

    private int nextOnlineMember() {
        // if linkedblockingqueue is empty, return "empty"
        if (onlineMembers.sizeOfQueue() == 0) {
            return NO_MEMBER;
        }
        int memberid = onlineMembers.removeMemberIdFromQueue();
        onlineMembers.addMemberIdToQueue(memberid);

        return memberid;
    }

    private boolean isPreferred(Member requestingMember, Member potentialMember) {
        Preference requestingMemberPreference = requestingMember.getPreference();
        Gender potentialMemberGender = potentialMember.getGender();

        return requestingMemberPreference == Preference.BOTH
                || (requestingMemberPreference == Preference.MALE && potentialMemberGender == Gender.MALE)
                || (requestingMemberPreference == Preference.FEMALE && potentialMemberGender == Gender.FEMALE);
    }

    @Transactional
    public boolean isPotentialMember(Member requestingMember, int potentialMemberId) {
        Optional<Member> optionalPotentialMember = memberRepository.findById(potentialMemberId);
        int requestingMemberId = requestingMember.getMemberId();
        Member potentialMember = optionalPotentialMember.orElseThrow();

        // 1. 본인인지 확인
        if (requestingMemberId == potentialMemberId) return false;
        // 2. 온라인 유저인지 확인
        if (!potentialMember.isCallable()) return false;
        // 2.5. 선호 상대 확인
        if (!isPreferred(requestingMember, potentialMember)) return false;
        // 3. matching table에서 서로 매치한적 있는지 또는 거절 받은 유저인지 확인
        Matching matchingSentByRequesting = matchingRepository.findByFromMemberAndToMember(requestingMember, potentialMember);
        if (matchingSentByRequesting != null) return false;
        Matching matchingSentByPotential = matchingRepository.findByFromMemberAndToMember(potentialMember, requestingMember);
        if (matchingSentByPotential != null && matchingSentByPotential.getCallStatus() != CallStatus.PENDING) return false;

        // 4. 오늘 본적 있는지
//        if (seenToday.hasSeen(requestingMemberId, potentialMemberId)) return false;
//        seenToday.addSeen(requestingMemberId, potentialMemberId);

        return true;
    }

    @Override
    public List<ProfileRecord> findMatchingList(int myId) {
        List<Matching> matchingList = matchingRepository.findByFromMember_MemberIdOrToMember_MemberIdAndCallStatus(myId, myId, CallStatus.MATCHED);
        return matchingList.stream()
                .map(matching -> {
                    Member member = matching.getFromMember().getMemberId() == myId? matching.getToMember() : matching.getFromMember();
                    List<String> urls = pictures(member.getMemberId());
                    Pet pet = petRepository.findPetByMember_MemberId(member.getMemberId()).orElseThrow(() -> new NoSuchElementException(String.valueOf(member.getMemberId()))); return new ProfileRecord(member, pet, urls); }) .collect(Collectors.toList()); } }