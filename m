Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C50446847
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940431; cv=none; b=sObhzatoeqzLKu2v7hQiHbFP9huJmMdP6I3NVXClvuJg+0HIe3fv0bzYlydUWLDWIdKAMrXcZu47AoowFYfUv94I4/JIvSsubY/PTLoWIX9ZOYRXS5+K5HYtOcVFnUCu19mugL+vfWfg8rNeu+Z+zlfuOdVdE0ZA8evRiC0m59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940431; c=relaxed/simple;
	bh=MjEa1mE5Ps6Q3lUg66pSiS+PNEddq3EUs4UY8dMBW3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7FepbWNq8dav9S18Dy+U3hziNzp24gGLWlTPH7e6gHkGB3DIQ35BxZ+FxJpagELZPsU+d18ja0codrxseVc0O2jZ/WtkoITmMluaSX++a2ZofjXtwPaWi4uVpHYhu9inkQx2DDhPFYX5fMXOTWz/L26nfClg16rfLs2X7wB6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awEjX0iD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XrAKrUWM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awEjX0iD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XrAKrUWM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896X4Z0130567
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 07:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fTXYHOV3KBPJQ32Zh91Zlf5yN7Iu2qtX163LKYkR9as=; b=awEjX0iD51BjJkE8
	LwNHHPSHht3oE1KO7F9cPjyuUZ/ZZ3WfSUWKrd3Zueupcsj3uUeQydE5y2DJ+y55
	KJUggAzPHNiQU8Qjenkh1pO8F09rxk/riqCs8XLOXT46iowckp7LijOmp6m2gqu+
	BB/aoXDDfd2OPM5zhwv6juBu2zBS5OC4kVGE7LMzPz0o6Hit791NO2SkI5WnnhsX
	NZj3c+gT+PqNxh75knGC0+0yKyq5vba/qmsWUdSy3Bi3hlmVZzluIpR7qzIdf8Ci
	Z0L7C7CkubJVGNqD4V3kNVSjvQLGCq/cdH8B9ZundNT6skwxpTgizWrVsByKW1k3
	fIBT4Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjntpkdub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:53:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so7033722a91.1
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788940427; x=1789545227; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTXYHOV3KBPJQ32Zh91Zlf5yN7Iu2qtX163LKYkR9as=;
        b=XrAKrUWMNm2HAOhnBPEmkQu8lO7LWRmqauXJLkoY/yAWKWaTPWTiA8OYhKSFHkHhA3
         NCiWt3kCdhx/V2QqBQoQrr6zbSW/ipAKnDGRMNez8+DoyPOlGEwopVah5iZLdI3I1MLW
         bdyncqCC0aPAyZtzAsNrVDQNmi8RZJ6lT1ddHDkxm7VrAGc4PcnIsmcrwSV53ZhXsgkC
         dCZ9UwJX+kWE0xGJ0tN6bkNg82NhXUyM7qCL37XPhjYLBm25CkudDxr3b0oYkFXY3ebU
         BBhOCvhcC0dRhzjrSl09AU/yavXoe7yxmdUBrYMPczssO22l7BRsOL4NIgGoiMfcprUu
         o1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940427; x=1789545227;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTXYHOV3KBPJQ32Zh91Zlf5yN7Iu2qtX163LKYkR9as=;
        b=hJpeYjsJ13f4YveAGEjieuTb2GaBIyds17Kev3Eqla9ksJ0hC0QHb7mhdQFX1L+l6L
         8r821j0k0s5JK6lWZyoiuxNC0uuWY/PKXM6cXvBsPt22B+xvHwCGCbfjM4wIv6q6rXrG
         aBctWvHcfBnXtrc4Bzt3SWlEL9xiBvKbepcnl5ZxymE+vZ4ECLYK000uadZzwWFWkydn
         lQibc1FkU2EUi//JioUur5b4D0S8FQ44uPWApnflT6h2VJMN9zv57f+J5yTRoC0Uqj6Y
         xh43ZC3YwwHYcGfstI93Vo1JxgOdn+23ztzblzF+9EVnVVjSLAu6geDx7aFdDB7AwitH
         IbCw==
X-Forwarded-Encrypted: i=1; AKwUvBzGUZvQ2gReNayruJElGvusxVibMV7FVGEJ62ceR9jUsfZ3mlMzZTojiYuEY12aipbQ8nmibA==@lists.linux.dev
X-Gm-Message-State: AFuF++lvt7w9O8oTwWNPqmxmbTTzI8MpAvXw/1Bu+Cue+Uopc803VqI6
	/r+fyIdq5S6Ab/ttGKPG0+dUrardILALCvjDanY2dZVtFCJa7q5WIJt1skfqM6APBYJKdCtSkWJ
	PVa0U2jccpTpQwQF4UsHXvaNssrP9G5jWcy/LqDW9N1ozUG/mnA2bTTI9mw==
X-Gm-Gg: AYBFou004dqLAuhGMa+a3MMHsej78HLqPkc6r/kfbOZT0Hcd6GbQ9ZX4wIErDnWWxqB
	42B/BZYNOW74eDMXVz/QNZn3zBaA3g+Fw4+zLfRY8AfDGpKPovnyphnOVWAGZO1YA7yJ7HXinLK
	OJLRTr8DcW1NMprOfvrWEXNKPbXBekzUvzSflXhdc+C5NkVKLCrsk+w4g3D5jhlgoVyNcagQQkh
	sJzHYYqAVRKs92qPE0cRinm/l+sc+vdhVgYZHZ+D23ckv8J1FWOM8paN8phIBnSrAjDVMs5qxNk
	W+RkqI6fHdpnWidERxjiHv/7YMoIqutN7WG4bc1ae7JAQhsM5XdQKRBMld5rPr5Bkp03sEUdUbw
	UIdMUcndpkJIc664TsbcSZkpXGPkPVQ==
X-Received: by 2002:a17:90b:5807:b0:398:9be9:ab8c with SMTP id 98e67ed59e1d1-39b26229bd7mr52084954a91.17.1788940426987;
        Wed, 09 Sep 2026 00:53:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5807:b0:398:9be9:ab8c with SMTP id 98e67ed59e1d1-39b26229bd7mr52084889a91.17.1788940426365;
        Wed, 09 Sep 2026 00:53:46 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm65319126c88.4.2026.09.09.00.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 00:53:45 -0700 (PDT)
Message-ID: <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:23:34 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Bjorn Andersson <andersson@kernel.org>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <aqCKgM1yCbWjFdgO@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA4NiBTYWx0ZWRfX96zcGrQoQRSW
 tZWHOe5fXrd8JKEXcEVKXNT+BfFXDPxKTzpOlvNawTScUQ+xSkOEnC3GGsrYGQtpk3oiy5Fpdlq
 a1BbMjwYpO8fTGbZ1+36n6rEalM6/NbAwvY4T9TCR7Ak6YRKF8XyjVBY7BsBTVtJbHQiA7V9UKw
 MHV3woYOysLNh7pc+LXXNdc9226JugOHq6TdTkcXwJf2EhwSowANFE1NXpXHYVELAJ7Ta+HOJaX
 MM59GacIBnxtnMnC1RKj/qs/F5n4weTsP4iZGbf23c/kq0toPWaprYnyEpHArlLjBBWTnIcxR5b
 a3qUr7pcV6qvhkgkIrZ0LA4RRgX4uv1Wxm+P6jabPxoGWXovTu7FeiEuPtDOb0RHBM12n0faEmi
 H/VKh8IuF8FWevrLIjrueM+1OzcvZI1T74DY+UdNy2RIszpenEmPSydWuOGcIEaLRn3HRz/KNEd
 asrid2wCFLaClfMV8Fw==
X-Authority-Analysis: v=2.4 cv=N+AZ0W9B c=1 sm=1 tr=0 ts=6aa1108c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=ZGy5um1dRlDb5ydww_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: NHJm05Ck4RXg_M3GM_HLCAxGu8fKaoHl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA4NiBTYWx0ZWRfX91U6Gp/JGJNe
 4536gm4E4AROM8Y2qFu3/EwYrAlSRCYBevaU6EymJFSijtuUF3EbGbm/2eiuDNjHGD+qDvT5CL8
 ICVt9JEH5n/BFLWgc3y2UFm7j+tbPrw=
X-Proofpoint-GUID: NHJm05Ck4RXg_M3GM_HLCAxGu8fKaoHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090086

On 09-09-2026 04:14, Bjorn Andersson wrote:
> On Wed, Aug 26, 2026 at 06:37:00PM +0530, Ekansh Gupta wrote:
>> On 20-08-2026 20:17, Rob Clark wrote:
>>> On Wed, Aug 19, 2026 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 19/08/2026 17:48, Rob Clark wrote:
>>>>> On Wed, Aug 19, 2026 at 8:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>> The rule of usptream development is that we do not accept duplicated
>>>>>> code, just because a vendor wants to write something new. This is
>>>>>> basically the concept applied all over the drivers tree, where we pushed
>>>>>> back against all sorts of duplications all over the vendors.
>>>>>>
>>>>>> What I miss in this thread is why would there be any exception here. We
>>>>>> do not grant exceptions from standard practices on "I want" reasons.
>>>>>
>>>>> I agree that we should not have duplicated drivers just for vendor
>>>>> lolz.  But when it comes to adopting common frameworks and integrating
>>>>> better into the ecosystem, this doesn't seem like something we should
>>>>> actively discourage.  I don't think this is a case of vendor lolz, but
>>>>
>>>> No one discourages it. Following standard Linux kernel practices and
>>>> requirements is not discouraging, do not twist the narrative here.
>>>> Again, it is standard upstream review telling that we do not duplicate
>>>> drivers. Ever, unless there is serious exception needed.
>>>
>>> I wasn't trying to twist the narrative, just trying to come up with a
>>> path forward that isn't "no" or "improve existing driver", since
>>> neither of those gets us towards a future using common frameworks.
>>>
>>>> I asked why there should be an exception granted? Is the reason for
>>>> exception following:
>>>> "We want to adopt common framework"
>>>> ?
>>>
>>> Possibly?  But I don't think we want two drivers to be any sort of
>>> long term solution.  (Ie. as long as venus/iris have co-exist.)
>>>
>>>>
>>>>> rather reacting to drm/accel emerging as the standard framework for
>>>>> this sort of driver.
>>>>>
>>>>> So how do we get from here to there?
>>>>
>>>> What is wrong with my proposal?
>>>
>>> Maybe I missed something, my understanding was your proposal was
>>> "Grow/replace/improve existing driver instead of coming with a
>>> duplicate"..  grow or improve doesn't move us toward common
>>> frameworks.  Maybe "replace" is a valid option.  If there is something
>>> I missed, then I apologize.
>>>
>>> Options I can think of are:
>>>
>>> 1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
>>>    driver
>>> 2. Backwards compat chardev registered by new driver, providing existing
>>>    UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
>>>    AFAIU the fastrpc folks where planning a backwards compat layer in
>>>    userspace, so maybe it is possible.
>>> 3. exception?
>>>
>>> I'd like to know what the feasibility of #2 is, since at a high level
>>> that sounds like the best option.  Possibly limit exposure of legacy
>>> UABI to existing hw so we don't get into a place of needing to extend
>>> the legacy UABI for new hw?
>>>
>>> But #1 sounds like a non-controversial place to start regardless.
>>> Possibly with #2 coming as followup and necessary step before eventual
>>> migration to new driver for existing hw?
>>>
>>> Even if we start with #2, how do we handle first-merge-window
>>> bugs/regressions without reverting addition of new driver and removal
>>> of old?  It seems like we'd need a window of a couple release cycles
>>> where both drivers exist?
>>>
>>> Maybe others have other/better options in mind?
>> To all, I'm seeking on the approach I should follow to go ahead here. I
>> can work on implementing #1(as per Rob's list) with hw specific
>> compatible for v4 if it's acceptable.
>>
> 
> I don't see any reason for you to define a "hw specific compatible",
> because as you have shown in this series (and as Rob point out), there's
> no difference in the "hardware".
> 
> The only reason for your "hw specific compatible" is to make a software
> selection in Linux - and that's not what DeviceTree is for.
> 
> 
> As such, I don't see that you have a DeviceTree problem at all, because
> this is a Linux-internal problem.

Agreed.

> 
>> #2(compat driver) is something that we are still exploring as we
>> couldn't find any standard way to achieve it. We might start a separate
>> discussion for that once we have few possible designs with us.
>>
> 
> This is the actual problem!
> 
> We have existing user space that depends on the ioctl interface exposed
> by the current misc driver. You must not break these.
> 
> Hardware cutoff is not a viable solution, because that's just a
> declaration that we'll let the old platforms rotten - or alternatively
> you commit to maintain two drivers to the very same feature and quality
> level.
> 
> So the only reasonable solution is #2; from there it's a valid question
> if you reach that point my stepwise migrating the current misc driver
> that solution, or if you present a new driver with the fully backwards
> compatible interface, alongside the new ABI.
> 
> 
> But this does bring to a question which the cover letter should explain
> - but doesn't: what problem does this patch series actually solve?
> 
> Regards,
> Bjorn

Agreed. I'll target #2: QDA implementing the existing fastrpc UABI
alongside the new one, rather than a driver split by platform.

On how to get there: the blocker we hit in v1 was that legacy fastrpc
buffer semantics appeared to need a drm_file, and there's no exported
way to construct one outside the DRM core. I want to re-examine that
constraint rather than treat it as final, since the legacy interface's
own buffer model (a dma_buf fd as the buffer identity, no GEM
involved) is not inherently tied to drm_file, that's how the existing
misc driver implements it today. I don't have a concrete design yet
and would rather work through it here than commit to one prematurely.
If anyone has thoughts on how the legacy UABI could be served without
requiring a drm_file per session or if I can somehow bind drm_file with
chardev by exposing some APIs from DRM core, I'd welcome them.

On the cover letter: fair point, and I'll fix it. The problem this
series solves is that a miscdevice interface requires us to hand-roll
what the accel/DRM subsystem already provides as common
infrastructure: GEM for buffer lifecycle and reference counting,
PRIME for cross-driver import/export, per-file (per-open) context and
handle-namespace isolation, and the existing debug and lifecycle
tooling the DRM core already ships. Every accelerator driver added to
drivers/accel (habanalabs, ivpu, qaic, rocket) has taken this path for
the same reason, rather than each maintaining its own equivalent
inside drivers/misc. Building QDA directly on this shared
infrastructure, instead of extending fastrpc's own ad hoc buffer and
session tracking to cover the same ground, avoids that duplication
going forward.

I'll put this plainly in the cover letter rather than leaving it
implicit.

/Ekansh

> 
>> Happy to take any other suggestion also.>
>>> BR,
>>> -R
>>
>>

