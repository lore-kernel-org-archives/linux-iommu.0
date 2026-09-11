Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654194349B9
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122751; cv=none; b=bHq9Mp6DZQj9WKzjcK+x3d9CgFA8XYUo9Jd5uZdlRBi+KpEgum9KjSlye5T7QIPe9cp/kvcDOVMSZ+PyhLbBqGAGtJFG/FlK1QRtAaV9w1u9C2tDl55x1h8dMvscReUpn38hjNWdhwxaGCT2Pwg71nnVu6hh7zS9kXvTJXy1y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122751; c=relaxed/simple;
	bh=s1kwKfNWdOwKIVHRxyXH+/0Wwl++ZJB8huriAF1FUm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duM7M1wIabvlrtNOiDojJXZg9dzhTDS0flO9RkB7kYvokE4+OZj9FugB4hIy7/mEV/1wjruB3Dnrpfea6oEBzX2SxUCNGn07UzGtjUvEyf4Z6aWG0uLeyCh6ziPqiw+SeC3cR/X4O75+ESqNThRQgXN5SsdFnyveqF295KbCK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CGiKxwS3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I74PC5Tb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CGiKxwS3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I74PC5Tb"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kg77423573
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZMSPcX6SEWInooLZbCmLaOZJRUfm8sfjnK+8IHF2YyE=; b=CGiKxwS3c2iakXdR
	YVX0BoRscMKYnmvuEL3lx6W8pNzabSEVh0CvAmtM34SBpd48CvgvxAWDc+9tdMsH
	hR2Gn7WCItDbUOFShJfa1HLFDqJpk8xGvETNOorCuPd6F45KmEDOBahjoNkYWf7P
	LdlOzvDP9VKhI0fxPYOddMg1ryEOTgSE/lrfsXeJatd9wMt6q6tfuzSOYqskSHze
	dAMyPPmZa0WiV43mmi4l63UThuRGqbGGhRVrPG+zPI1yt7tpmj5eCPAxTpiSB4D2
	7nyOJRNHxCnATh1zmR4JqBjJt4xKmQAJSnP5+ozyEs34A7ntBgoJt0OOJPM2tHN/
	y/Wghg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8h7j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:32:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39533bb224cso967892a91.3
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122743; x=1789727543; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMSPcX6SEWInooLZbCmLaOZJRUfm8sfjnK+8IHF2YyE=;
        b=I74PC5Tblwz2Nt8bKr/04T06cuXawBiMIAF4/wZiFd7E/Mn15E5+oJQm1A92c6v6cN
         1Wo+hWIygHNyLkf874Vu5wjXDYrnu1Ctc1dikXiEJIYJBoXpAEQoUJ7rRst9ongjRrox
         gbYXf/adqOjdzE4YJ+s9hbJoSiLgAW2oswzrmCCEZIqg7UZtv0afkl4vwtnpZoUcwP2T
         fMW0Y4Dxm0ijKmH3eJ3l0nEorBGYNxMKDtrE99AyPWx/YZYvBsXmvX+v3z4PrALC0awj
         gOhP6WwIixNxepjsqJAJ0grLdZsc8/RTQaU4Rw2ZSmf5euzZm6y+nyKQNaaWLeB3VtLH
         KPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122743; x=1789727543;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMSPcX6SEWInooLZbCmLaOZJRUfm8sfjnK+8IHF2YyE=;
        b=oDJn51gmgf3W7sDG0zdoR+9Gnm6yYTSxtNtMjtovkww/rwZq9mcHsde3Nft7sUkT3K
         PmKr0FgpTzo6pZuTYUv/ECTmqM5uI+PF+aKlWe2DfYbtO2fIbZwaLQRFoU8WErFG5tnX
         GzNZa8ZxrxWlIyoXLUZ0iV//27gbfwUm7M5FeRL6Ixmom3aDtcbJcnYIT8PYBZyRsY0Z
         wAVcHVM/0j3Te2sZPA6/VXstVj2NhJlftXyVzSS3EQ8Xt6a8QY1pFhZEr9NNbFlVJ18i
         lCqoP6FpGGUygUn0upffIGOHTo+46m7FGwTlIZD1IZz6E7hWD3BJ18RDjy4h5MD0PWsS
         q6LQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRBccCPFyH3Zz79JMeMjZJOf0CR/meBQYNpA/9xxJDlNyob4lhScp+q/M4uOa6nMAqv6/fJg==@lists.linux.dev
X-Gm-Message-State: AFuF++nt9pNrMaSI3TjfQVRrYlvoQ0GqvHvguoZsQ6eAZ2QBkZupW4Al
	8ad8k2gBqqwqiuCjcpDOoVK67tAqxvFtvtUNBTXIsrKu4F4tNFLBpMEjgaN/R97g/yLWQAPlj8Z
	DDcFaAXW4anznxTydyyqX8NwuIXSYA3pmR2MwdUEqVrrL6BMfEBC9ZolfAA==
X-Gm-Gg: AYBFou1CtUxtM8gmvj1DtoNhQHndOHibYDuGskm1WcObmhWMrtFy6QOj1tv54PcyArI
	CkMNyLMv01jzbElb3FRRpJfgrdXiBHppetL+73tdmWQcMs4jmKzddn+dU7zRt6RU94EIeLEDGm/
	jdsni5M5APXjbABPBvjgWLgC9whaQ02ujimpC4cVU7t1dbc5/64G8toEWMWYftzpMuKHcWBwTXM
	5OY4V5vfWbNR/N/LUkgZXr86mggF47KbAAVOLSJnLh+OmjJ6xeVdwBkowMeJ2hCH7vbcpbWTEAh
	umqayicNnf3D98fr9uevCc+twfdF4W++mD/YIjoXIiNHU194A7CENpLybIqN0xcxaUV/b7VGs8x
	I38pVYweJoEXVkr9cNQL6V9c45211
X-Received: by 2002:a17:90b:6cc:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39d9bd8fb3bmr5841468a91.9.1789122742677;
        Fri, 11 Sep 2026 03:32:22 -0700 (PDT)
X-Received: by 2002:a17:90b:6cc:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39d9bd8fb3bmr5841416a91.9.1789122742125;
        Fri, 11 Sep 2026 03:32:22 -0700 (PDT)
Received: from [10.218.24.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95713602sm4520593a91.11.2026.09.11.03.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 03:32:21 -0700 (PDT)
Message-ID: <68a5c18c-1b88-4ac5-bff6-22396dde5e2b@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 16:02:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
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
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
 <rh5ufacfap4x63rjmgd76wlwgn3n2wuelpe4sqwy4yda27nsiq@lg4ltoqwz7ba>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <rh5ufacfap4x63rjmgd76wlwgn3n2wuelpe4sqwy4yda27nsiq@lg4ltoqwz7ba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CpTg_cW7jA8alHE-S8oWgbV7frxtOXwT
X-Proofpoint-ORIG-GUID: CpTg_cW7jA8alHE-S8oWgbV7frxtOXwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NyBTYWx0ZWRfX9rfixaZjRkCt
 Dk5pryGdDGIgPMynBrD15+cDF9YFRefejwB+A5ECOYejqCed2AQnlpiHjuYUA8Z5rA0dDWdRK5x
 N71JXUUrXLPvp82lwuHhLUwkPWvZ23jbq1ZOlujQCFcobGPF8JaX6YojlVNHrF4QIXIZpKGNlbZ
 oJCKYOgIZy2lbhiz+uYIUJWBbpulAJOHC7VY3cFEDMU68eYqhOWH7NvfNu45TSuZyitQpPnR91H
 Y1SvY9ZyPEcStTTXvuVW0lEm1DU1+qfOqLe8v4ZXgjfX/FUlbFqm56ypGGVvvGrUdi+J0YEzCyG
 Unoj5EQ3UhsLnpSnr0CjRSudj4L03h01l6RICo1ouvwH5WbZAshuA9UER1AZ0Zlh5gLQUnvE0S9
 XUYowBZ3PIpZx7xsdhMFSJV18DH76ZRndl1lh9fAE9VhfjSN/JWIGfQqAojKTHf3Vg6fb4DxUS5
 +swBQu5DU9RxAzSMxlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NyBTYWx0ZWRfX12EAlr+eT8lS
 L9qn3Ug5uCISILyjRDzhtibmqKU6honkWBBTrgO/ObelUcXjtnJUAj/0zNEab3HQjYqJHUVu1DV
 mrPM0w7Dzijy4+fkp1KhkMmNgQMlwyw=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa3d8b7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=ALIpgHWzX8X-H7dRLqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110147

On 09-09-2026 17:18, Dmitry Baryshkov wrote:
> On Tue, Sep 08, 2026 at 05:44:10PM -0500, Bjorn Andersson wrote:
>> On Wed, Aug 26, 2026 at 06:37:00PM +0530, Ekansh Gupta wrote:
>>> On 20-08-2026 20:17, Rob Clark wrote:
>>>> On Wed, Aug 19, 2026 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>
>>>>> On 19/08/2026 17:48, Rob Clark wrote:
>>>>>> On Wed, Aug 19, 2026 at 8:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>> The rule of usptream development is that we do not accept duplicated
>>>>>>> code, just because a vendor wants to write something new. This is
>>>>>>> basically the concept applied all over the drivers tree, where we pushed
>>>>>>> back against all sorts of duplications all over the vendors.
>>>>>>>
>>>>>>> What I miss in this thread is why would there be any exception here. We
>>>>>>> do not grant exceptions from standard practices on "I want" reasons.
>>>>>>
>>>>>> I agree that we should not have duplicated drivers just for vendor
>>>>>> lolz.  But when it comes to adopting common frameworks and integrating
>>>>>> better into the ecosystem, this doesn't seem like something we should
>>>>>> actively discourage.  I don't think this is a case of vendor lolz, but
>>>>>
>>>>> No one discourages it. Following standard Linux kernel practices and
>>>>> requirements is not discouraging, do not twist the narrative here.
>>>>> Again, it is standard upstream review telling that we do not duplicate
>>>>> drivers. Ever, unless there is serious exception needed.
>>>>
>>>> I wasn't trying to twist the narrative, just trying to come up with a
>>>> path forward that isn't "no" or "improve existing driver", since
>>>> neither of those gets us towards a future using common frameworks.
>>>>
>>>>> I asked why there should be an exception granted? Is the reason for
>>>>> exception following:
>>>>> "We want to adopt common framework"
>>>>> ?
>>>>
>>>> Possibly?  But I don't think we want two drivers to be any sort of
>>>> long term solution.  (Ie. as long as venus/iris have co-exist.)
>>>>
>>>>>
>>>>>> rather reacting to drm/accel emerging as the standard framework for
>>>>>> this sort of driver.
>>>>>>
>>>>>> So how do we get from here to there?
>>>>>
>>>>> What is wrong with my proposal?
>>>>
>>>> Maybe I missed something, my understanding was your proposal was
>>>> "Grow/replace/improve existing driver instead of coming with a
>>>> duplicate"..  grow or improve doesn't move us toward common
>>>> frameworks.  Maybe "replace" is a valid option.  If there is something
>>>> I missed, then I apologize.
>>>>
>>>> Options I can think of are:
>>>>
>>>> 1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
>>>>    driver
>>>> 2. Backwards compat chardev registered by new driver, providing existing
>>>>    UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
>>>>    AFAIU the fastrpc folks where planning a backwards compat layer in
>>>>    userspace, so maybe it is possible.
>>>> 3. exception?
>>>>
>>>> I'd like to know what the feasibility of #2 is, since at a high level
>>>> that sounds like the best option.  Possibly limit exposure of legacy
>>>> UABI to existing hw so we don't get into a place of needing to extend
>>>> the legacy UABI for new hw?
>>>>
>>>> But #1 sounds like a non-controversial place to start regardless.
>>>> Possibly with #2 coming as followup and necessary step before eventual
>>>> migration to new driver for existing hw?
>>>>
>>>> Even if we start with #2, how do we handle first-merge-window
>>>> bugs/regressions without reverting addition of new driver and removal
>>>> of old?  It seems like we'd need a window of a couple release cycles
>>>> where both drivers exist?
>>>>
>>>> Maybe others have other/better options in mind?
>>> To all, I'm seeking on the approach I should follow to go ahead here. I
>>> can work on implementing #1(as per Rob's list) with hw specific
>>> compatible for v4 if it's acceptable.
>>>
>>
>> I don't see any reason for you to define a "hw specific compatible",
>> because as you have shown in this series (and as Rob point out), there's
>> no difference in the "hardware".
>>
>> The only reason for your "hw specific compatible" is to make a software
>> selection in Linux - and that's not what DeviceTree is for.
> 
> That's not exactly true. There are protocol differences. For example,
> polling mode is supported only since a certain timeline in the history.
> Likewise other interface features are not supported on all the FastRPC
> devices. For the polling mode support we were already beaten by the lack
> of SoC-specific compats.
> 
>> As such, I don't see that you have a DeviceTree problem at all, because
>> this is a Linux-internal problem.
>>
>>> #2(compat driver) is something that we are still exploring as we
>>> couldn't find any standard way to achieve it. We might start a separate
>>> discussion for that once we have few possible designs with us.
>>>
>>
>> This is the actual problem!
>>
>> We have existing user space that depends on the ioctl interface exposed
>> by the current misc driver. You must not break these.
> 
> This is clear.
> 
>> Hardware cutoff is not a viable solution, because that's just a
>> declaration that we'll let the old platforms rotten - or alternatively
>> you commit to maintain two drivers to the very same feature and quality
>> level.
>>
>> So the only reasonable solution is #2; from there it's a valid question
>> if you reach that point my stepwise migrating the current misc driver
>> that solution, or if you present a new driver with the fully backwards
>> compatible interface, alongside the new ABI.
> 
> I think the general direction was #3 (or #2.1): implement a shim layer
> on top of the QDA driver as a separate module. Put all the historical
> over-complicated solutions into that shim module and let it die at some
> point. Current fastrpc driver lets userspace specify buffers in several
> different ways, forcing the kernel driver to perform a lot of work
> with buffer addresses. I don't think that this legacy code should be a
> part of the QDA. It can go to qda-fastrpc-shim, keeping it out of the
> kernel memory if it's not necessary.
> 
>> But this does bring to a question which the cover letter should explain
>> - but doesn't: what problem does this patch series actually solve?
> 
> I agree that it should be a part of the cover letter.
> 
> As a person who triggered this work, I can propose my reasons:
> 
> - Current driver has over-complicated memory manager (both on the
>   userspace and on the kernel side). Correspondng uAPI is not really
>   suitable for virtualization. Using GEM simplifies both the kernel
>   driver and uAPI. Also using handle-offset-length to specify the
>   buffers makes it easy to support virtual QDA devices.
> 
> - Current driver predates the accel subsystem. Using common subsystem
>   simplifies reviews. The QDA driver has gotten several comments about
>   the usage of the DMA-BUFs. It'not unlikely that the same issues are
>   present in the current FastRPC driver, just being unnoticed.
> 
> - The ideas present in the current FastRPC driver also predate the
>   current design practices. The uAPI was created in the ad-hoc way, just
>   following the momentary needs. Driver code also shows the result of
>   that, having enough of the spaghetti code.
> 
> Given all of that, yes, it is possible to provide an evolution of the
> FastRPC driver into the accel+shim, improve the code quality meanwhile
> and end up with the good enough split. However I think that the path
> taken would be longer and the net result might be worse.
> 
> With all of that in mind, my suggestion is to continue working on the
> QDA driver, get the core of it to integrate nicely with the accel and
> DMA-BUF usage requirements and implement the (minimal?) fastrpc shim on
> top of it.
> 
Agreed on all the above points. We discussed this internally and are
exploring a shim module(something like qda_fastrpc_shim.ko) along these
lines, sitting on top of the QDA driver rather than growing fastrpc.c in
place. Still working through some of the details (e.g. who owns the
rpmsg binding, and what "minimal" means precisely given feature parity
is expected for the compat layer's behaviour). Will follow up with a
design doc here once that's settled.

To all, one separate question on daemon-attach security for feature
parity: would running the daemon with CAP_SYS_ADMIN, and having the
driver reject attach requests from any process without that capability,
be an acceptable approach? The concern is preventing a
malicious/unprivileged application from attaching to a privileged DSP PD
and disrupting it.

Thanks for the detailed feedback.

//Ekansh

