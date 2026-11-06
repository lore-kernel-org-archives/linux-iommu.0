Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978625;
	b=g22ZWX+2D9alJ9Xu+0daC3WTjILSdThxUMPoprtpqqtPFuv+oWpP22Nkq2AJXeLAfANQ
	 s494jUn0+eIwmCFtZwbvgU1LNKISOY6TXhZ5m47KFxw90nKsEHLKRFRFbbgLuS/pq1ZAS
	 Q7zEWMwVRFF4D21qq4h/w+FWQjGff0NyvKU4GANYucnmtu5i7SPK/ZLFV3F4PNDdu0egL
	 IwEreFKuGn5gMTAfvbQi/53vbbxQq/7dZqnHi7L/U7IAS32XiAhy1xtxY/mdLAlTa+xB8
	 NsW9a2dIU+78Jt52qxRrAfWPObZr2+ajdMqMotpN0lWmkxietJ7/vUi0Hs9LBTBdL8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=j7OxcM6JK9uGVP+NsNZjPsClP/ZMAV7N7NhrhI2qiXc=;
	b=x3ZVBTgjzwhtP1PbiuvBu7pEuLERBekLjXJJQxnVlckXxdf5H066upmSli/CxqbfwPSA
	 v4pi8EavgUiJa9bmfhk+X+QRw6+a87o7v2m+Uz85cvY4SC6FR8OKUg/eCXr7gxlU1Bl3N
	 wB+tnm0Gxl20s2bPuqt8nYqdpB3x9MPAjhK+wOmBzMmFoi7enIWwJ4szrexvEr1lDdiEZ
	 p/FtFLaNGXtmhs2lzHNCIZPhs5ESwv5iZCXxadD0hU994iAn4I9uImJo7ZC1eHnAOOC6A
	 gvAJGhLxR9314DIxLKL8MhqgUjc41EiH8jvGr9nA3zO2DFxZ+GTdgE0yiDSjzoZr4yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCv5AQov;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E960A2628
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 15:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24E960A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCv5AQov
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d473cfff6so70846466b.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 07:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978623; x=1794583423; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j7OxcM6JK9uGVP+NsNZjPsClP/ZMAV7N7NhrhI2qiXc=;
        b=vCv5AQovMD0HDYwuCL4TDkPV0QchF5Q3LjEc6Ks19Ppw9+NRoZARpSlHSIxJMFBNaA
         qKeVk1P7xKbSVuoe2H7f1R5EXixDjgLRDHoO15KJ7xU8RCN1h4XW/8wI5orV3v9VsmNJ
         9eZqNNSOfmD/5y4w9/53JmDE5Z2a0E/NeP5lVDa0TuQbm5qpKErsWm5wXbFSA0UkS+YA
         rKBfC0J7ElCB3WMI3/tBC3wnHmGHOG2y8caPCIWew4fG9FnMByvINxTBfA/fhr09ryUO
         c6cdp5A6emJqZn7XjRjhJobkdVNFMKD7j6VX9sPSCLVRBV4dgqx2GtxH97MWEdaIIe3m
         qdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978623; x=1794583423;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j7OxcM6JK9uGVP+NsNZjPsClP/ZMAV7N7NhrhI2qiXc=;
        b=dtUMK2X4hjOfA4zGGxG2ZgpEC8/pPWPhGNXMHzhIBaU+PsBaAwlOd3nRePT3IR6qHh
         N6uCvOtHhoMjbplxKotXjZpznxey4/93T0ogxc8mJcsLtrYKMBghJOSAcX5VgHuWoYgB
         90UV8tUQZiPsJwRroYRzQ1HL6LyLB+86zS9DUR6GCdhKghUdeTI7XDBwRei9u2N+YKGq
         PjbO0Y+TL/CXWaXnH+0n5uCu6r6stExlIOUKOmoVszqr02x3nDbbgcNQFHKX3iCe9Brp
         n0CfSix3il8Ved44jHZpN3cLY6ogGCvUaPpg1GUpqPzyTM0fWqlPLuucHQhV2uG6ZahJ
         07Mg==
X-Forwarded-Encrypted: i=1; AKwUvBzzW1XIO3PxA9Fajo8YXT37ByZiliCmtYiEq89mvZrJaYefs/5mQwgjWExKMgExzL6GXmWCIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8z6xqrlISF/44awnVkyLWaJW5ukCzwUcuQHbgknHXZjfkXrNl/
	NKGfnrCVGKbVFrxppPBu15AkQ7ejCmrGlzuwLiVlpOTUXTUCBdSZC3ex97YE56DUXHUDPjSt
X-Gm-Gg: AYBFou2xJfHOW8lAVXIgdnUqjRMCfe4pkkK1xM6hCsH15tf3/8mur8dd9XH6cGer6Mw
	WGcA5w2Mbp7+sryir5nRWOr2SyBZzY1/KgBbuQdYkAnsEs21SN1No6l6HfSwLfmdGflWkg5Cw8K
	dwUotcTM+vh5AOyY6fiHfU+W9UpCnEKE59IJVqWlhcVRa+Zy7u4rPrWCjM4hRACdNChgpoOnuGs
	WT4CXcPZRUWet+SsV3KvUG/gyQmSRSyCfYoPRtTrF2Au1e9pn1M+oq9b2ggl/xV0ScXFwBOYIDz
	t/VQcyP+iu1KzYH3IGpbmc/Duuv9zMQjI/2q+qVSaIciFw+kA+6E5EEXyfMIT++OG6N8t7RMgLj
	OJbfGDyYDYg7G1Zy+/zwdeUDBri5qdKCOfGsZZ7GjfT3ei5n9YgdA5maZLOdhlB6ku+BTQDEiun
	YgL6kOUSecC2oljxMFv8nclppqe7b6smNHPUbEL/E9SLaY4bgFOdFBK+yfT1Jfmha2kwsbMjeYi
	TkHTsaRNEBodRytkvyoaj0hpD+k+UtojgHgZHAKQzJbGJH7C8IGsghHtPgAu+WBoIbArMOf8h7K
	95ZjSWYfYIQX7hBKMqviWu/sCGx8kwkHBQF/IHGkmBzSVD6NXD7AraFI96p410FMjZ1Vh6OVslO
	bHO6X51xX+1Wt41ILwFkRuDgQy68Gor566w8uAF0Tit+U2iB0+K1iI47heQoB/bf/AzCzUkg0lx
	umTxLhzfO8YFUJimyACmTDxmadd++48oiwls3UZtPE4j3BfQS7q2H9NBEi0dc/hZ2sTRskzp5Nc
	l3pvkVfXPuq
X-Received: by 2002:a17:907:7fa5:b0:c4c:f846:1f1d with SMTP id a640c23a62f3a-c4d351f29d0mr243614666b.3.1793978623026;
        Fri, 06 Nov 2026 07:23:43 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c1d55sm87914166b.62.2026.11.06.07.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 07:23:42 -0800 (PST)
Message-ID: <092a1b61-0343-43be-9cba-c880949aebe9@gmail.com>
Date: Fri, 6 Nov 2026 16:23:41 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] memory leak in iommu_fwspec_init
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: syzbot <syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com>,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com, will@kernel.org
References: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
 <08037337-f8ac-4bca-b849-4c856d0bb68c@gmail.com>
Content-Language: en-US
In-Reply-To: <08037337-f8ac-4bca-b849-4c856d0bb68c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 16:08, Krystian Kaniewski wrote:
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
> Please move the fix out of iommu_fwspec_init() and into
> iommu_mock_device_add(), and leave iommu_fwspec_init() unchanged. The
> same core-level approach for this leak was already rejected by Robin
> Murphy on 2026-11-02 [1]. iommu_fwspec_init() is designed to run
> together with iommu_probe_device() or with a caller that cleans up after
> a failure, as of_iommu_configure() does. The defect is the early return
> in iommu_mock_device_add().
> 
> The leak happens because iommu_mock_device_add() returns the error of
> iommu_fwspec_init() without freeing dev->iommu. iommu_fwspec_init() can
> allocate dev->iommu with dev_iommu_get() and then fail to allocate the
> fwspec. The mock device has not been added at that point, so no bus
> notifier will ever call iommu_release_device() for it, and the
> put_device() in mock_dev_create() frees only the mock device. When
> iommu_fwspec_init() fails, iommu_mock_device_add() should call
> dev_iommu_free() if dev->iommu is set. The check is needed because
> iommu_fwspec_init() can also fail before it allocates anything, for
> example when dev_iommu_get() itself fails. The existing dev_iommu_free()
> on the device_add() failure path is correct and must stay. One error
> label shared by both failure paths is a clean way to write it.
> 
> Please change the tag to:
> 
>   Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")
> 
> That commit added the early return that leaks. The current tag names
> 72acd9df18f1, a v5.7 change, so stable tooling would try to carry a core
> change to trees that do not even have the mock helper, which only exists
> since v6.18.
> 
> The commit message has to describe the new placement: name the early
> return in iommu_mock_device_add() as the cause and explain why nothing
> else frees dev->iommu for a mock device that was never added.
> 
> While rewriting the message, please also keep it short. From the
> kmemleak report, the allocation chain (dev_iommu_get, iommu_fwspec_init
> and iommu_mock_device_add with their source lines) is enough. The hex
> dump, the object address, the comm line and the syscall entry frames can
> go. Two or three short paragraphs are enough for this change.
> 
> [1] https://lore.kernel.org/all/7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com/
> 
Please disregard the previous mail in this thread. It was meant as
review feedback on syzbot's AI-generated patch for this report, which is
still in moderation and was not posted to this list. It does not refer
to Qing Zhang's patch, which already makes this fix in
iommu_mock_device_add(). Sorry for the noise.
-- 
Krystian Kaniewski
