Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769163;
	b=bjWBh8oshZ/azJKMtuD5zS/PFUI7e5hBN456IR1pWZCy708D7qEL86nvWvRqBjEd0fck
	 1NhIxT7BbimuR0VsW3h+wQ26IoqM7st/AX46LVLsXbfKvUD2U4+xo2y+IqRh8/NVcfqu9
	 nT8Y4YHdzuskrVAnpfVLXzWuVEVyVGJN+Kr3q2jG0nI4BgfP6rA05FBlO4IM40FM/yQid
	 oqARKgNOCo5X+iY+/YHJ9GmYp4LT46KGEb70fdMlRY7gpoZp3FL7Yhs64yYqMG1PYQH+y
	 GQDVtVrwG3D5RIr7NnG7UoFMXLaO6LFjPuofoVRnf4Ihz7p3Rn9J9llCHVgHtLjp62w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4a2HGeqSU90/oPjDCBfIOMhTpn84AQ4hBfmcEVcMu7Y=;
	b=yWQjwWHaOUJTgeJ1tTpRSuvwEXlnWEIlV8GjtCzNn1qcdgrs21lwJrxaUa5Exb/1Rc7b
	 gBcNWGl3wMDYm/L74eUacHKDabLHYkOluISbMTh+lH7a1GQwu+ijON+Esj6cMJgfh+pyQ
	 Ldc4/uRnDYe25sDnm4xekQXDn2zRYjhIQw/P7rab8SZqpZ+5GVKxhfSJFu2QvYwC5oq/h
	 uvh/CoMlI3v2lyUrszuJd3BHbKmXiaLzcDVYL1f9oZo+DTG0tXMy0NbVkTn9TKAx1tIzK
	 cvwYNb0hL5jpBM+Bz+9fBy6iU9HCKtCN00rUgAr9Ey6GE3RkG8jrI84IaSGpu9Zsmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipR6WcEE;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970C606A31F
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7970C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipR6WcEE
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1df146015so7365045e9.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792769161; x=1793373961; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4a2HGeqSU90/oPjDCBfIOMhTpn84AQ4hBfmcEVcMu7Y=;
        b=ipR6WcEE6eydq7YSQIM6paEou2NU6AGTfCF5iRUCEHAWtLy03/sYeT4tUVg5jem4fA
         1jXNf65Bj2sPS5SbLgasydWpxS4c9jWvLP7+ur5WA9OXGDP0T0nQL9VhSWc6pno2HhIO
         1qSARpYP1YhAciyuZVrJnPi9q/t81FFX7vGYLfDAZ6HYoE4j6GhUcKm5NYdMGjeXUsOg
         qcT1KUirRmChYAoQqpcDSXqpZX2fzJ/aUYszOFxE+6AIDIz6EuB+UcLUpk4sTc6UqEIQ
         djyRZMtGK7KpF24qJBdrqx4iUs06sE/7KNAHWXA5/JJwCau7c2IM9Eu3BO2uo3h/6ivF
         NT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769161; x=1793373961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4a2HGeqSU90/oPjDCBfIOMhTpn84AQ4hBfmcEVcMu7Y=;
        b=0fcSBTu1GGgJdmFIfz7iVoMPhcZ1DY7V3XVKZffbDW7zD9apt+zUd155gNPuq1+KrK
         6ksxvMvoz2ai3ac/zb5VvLpoHdJ3uspG61nPR++41Vr5M+Vl+R/uhxlICQTvUgbrEQc9
         5TtkztgRO02dKchKfOuINL1GFYpmlfQnN96WjZ4eNUDo8qRzQVlePXRQ0Qcaf/PIXlTm
         aZNXORgvxN9jjYZrckbXvHtms3veqWGyadeNjk/IFvQHN9D4f+EBlwSHGs0lf+AroK3r
         StwtrSFPLbx+Mf8lKQf4uzM3tAPqoQRZBPUDJU+ULm0jriTA5fEyDSPUE3IoHYbOb4vr
         bOAQ==
X-Forwarded-Encrypted: i=1; AKwUvByOCzej1Rjfgw7izpGv4gsKVit95TwoblN3jgQ1yfdGIN58sPCzIntY+qx/+m4I6wQIiihXiw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJKC0Ja9s4CaVLbZW+6Je2zagTi/cPS+ycpiVfCxjsOVCzmYXYr
	Eyp35c1Tnu3ESpDc/CKkuNx5uTcyey+F4H23ysvXXGS6wVAVTctRQZY=
X-Gm-Gg: AYBFou1Ja30MEAQOzpl/G3+IjkzFpyRMrm+ivb0Ai52YgzDf8kf5BiaLwIe85XlyCR3
	LZwWm9oVH2i5y5PqjCIg+K4mVoVDfEAluLiMInDL+NpwcifRuyr9Bt+trYhBychktYYgfcE/sJ3
	zEq0xRWWSgWjnCDHsd03eW4xUmyu6tRiYD2M+P3qgAY7tlxDMq2mLUg4o0PO4sb8rJV064NHaAg
	u42f6l63mO0bMwUH8/WWTxGHMemvurmmTDpRcHkupWLJkbcfDIh0l5bZS7XR2UGCxh+xIFh4nF2
	aq9UvydJY+2GC9drQUGQmabr38ebqyxp1o4iAGCndN6J1IUW6Db/Nkdyp3FgFHkk5HdHv2c49lh
	k/KfIGh/yPIQ4mMtVPNtlLM1YhbRIGUFAptz+GMr9V8HhO5zfjrX4tIkDUXJp470BhI/KN5kKBC
	yYKEdQIYd44fY9PzHx1jukXlxp8k7So4o4EIQc9YHkxr0AibnmcacYqmjro12b4FdLbFlNrGoro
	ljvoT5+r12EBmlWc1XZYfmiC8YGBmYaqDV7d0lLpU0HTrPyTtuBMH6aOarL7nbyzLJO0MvXAvtZ
	FtocmOxcNQxdnkQXH6l8cNwuUAnKj9LjLgg0X0vazW0rRBIO8jQBEno1VA==
X-Received: by 2002:a05:600c:19ca:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a211c8fa81mr43106325e9.8.1792769161277;
        Fri, 23 Oct 2026 08:26:01 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a29cda9686sm11718245e9.6.2026.10.23.08.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:26:00 -0700 (PDT)
Message-ID: <af06c4b0-55a6-45e2-b2d0-81d64fcc845d@gmail.com>
Date: Fri, 23 Oct 2026 17:25:58 +0200
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
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
 <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 11:46 PM, Akhil P Oommen wrote:
>
> On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
>> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>>>> unnecessary.
>>>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>>>> context banks.
>>>>>>>
>>>>>>>   From what I recall, so long as we use the same dt node, the iommu drivert
>>>>>>> provides no way of doing this.
>>>>>>>
>>>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>>>> and secure.
>>>>>>>
>>>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>>> describe the same usecase - a set of SIDs which are used by the device
>>>>>> but which should not be a part of the defaut set. With it in place you
>>>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>>>> etc.
>>>>>>
>>>>>> I'd recommend following the same approach.
>>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>>> similar case:
>>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>>> Let me check internally.
>>> After a brief discussion: it can be either, depending on what suites
>>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>>> bus or not).
>>>
>> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
>>
> + Bjorn/Konrad
>
> Not sure how strict is the requirement for compatibility with older kernel version. An
> option in your case could be just do an override in the board dts file of the
> Steam Frame.'
In other words that would mean not upstreaming the DTS change? Although 
we plan
on keeping LPAC off by default upstream it feels like that would be 
quite a big
barrier to enabling it for people that want it.

Also yeah not sure where sashiko got that requirement, maybe it's not a 
real problem?
>
> -Akhil.
>
>> Not sure how to address this.
>>
>> Best regards,


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

