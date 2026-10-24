Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853880;
	b=a9KwuFgUJ9jqiYbZo2QSjzLD/b0Mi/Qt01rn7IbvuhiVOxZ0ZZHmPDUQ3RAdI6HXqvqp
	 2yEYTKcSAcObAGlF3APvcko2pIc1s9ddyzY6gSe7LYfLdw+4SPZU1rTtF4WCbWoKy/hEO
	 L2aCKjtSC7EvIidwTyyNFR6TGxB5ImGoF/LqpFrVIvRpNRPt/jrhgTIz+iMRtMXt87bl1
	 jMdUYVNL5qMT0i+AkWVisoRPTQP/rxRhiIrefsINvUL86cPXTxrIvBSabxMmBNO8ck6M+
	 KQjE2dKIk+VHDmmCoalNWoK341TppXQ1FAiuukJClt22pOOBQL2ozvPSM1HTyM0bLqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0glh7Tm3hCTaLHkk+iB1ZlmshEZqwQSCyeFUL075eSY=;
	b=bCVmEA1N9I7+lsxHvhNsxNYBnfdf/ccoIX/bP4w3Q+ZgCUrXt2LPfAOg+OswbWqzPCUf
	 H8a2SaB5N87vju0f615hMcg/cjZq9tMEVA7T9L3joAvOYxh9T8jIgAiqgIMQVe+O+D3Ag
	 nVVTrVZc3ejXs0dbeuQNWSZVL+pXA6f93+k6/r3/ZqL0uMQWDeh0ycrd/MQGAxLOvnp8x
	 vRa7n7tf007V3xTP0OyU1QxDZBETl/2QukNvk0bmMdGnx58/8E8Zbp5V5Rh64suFhDOkR
	 SKtT0KIEmiN92JyGDXxmeh0SLo2AC07yWxVfJZRn2qG1rimLR/5cYvQks/kF3q/xmuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hut+SIjo;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8005606A31A
	for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 14:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8005606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hut+SIjo
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c45111bebso875477f8f.0
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792853878; x=1793458678; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0glh7Tm3hCTaLHkk+iB1ZlmshEZqwQSCyeFUL075eSY=;
        b=Hut+SIjoAZm6q8rL78eLWEfWRNxbE9mAVErzbCYpdr34ryDev4/BqNX9IfU1VncdY3
         3NLs8NeDYbJXhWzk4HIXrRnXapEeb7EsMBwdIdcKsepcdF1dHB4AMiTNetsp7ieMoGj/
         RagGKM1jo61PLrrivERlGANxgq8vsISQCoBgioudf5NpVPR4a/jDX2eB8nWyGxHOkYZM
         9mvcGTZhKyciRsm4rnD/mf5QVBhWFZIu9D7TqS3kxnZT4lk24j7L6alRTXit/IzqKFEg
         ACYXyZIKsV1z4/QRcG5eRJvUanOBAxdE0g9ms5NgyGQOjqnIWX+xTKF7TbZAzbyodbKQ
         5vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792853878; x=1793458678;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0glh7Tm3hCTaLHkk+iB1ZlmshEZqwQSCyeFUL075eSY=;
        b=vahdUeyhHoEwLEi7HJmyYcimShvYTXZ3zBbTwKoojmOexD8vqx5byuIqgAt3VeTpbE
         Dmkvp94/G3be8pnLJPVE4roHiFhvEFq+29eiH+2xGhU/n7I7KBorRtUgYp8b/1RkC9J0
         2z3iUzpV0F8su8bUgijlds/rym06AESeyrA941RrqwyWLSHLzVo/0Mu1qaVcE1W5DSfF
         9HWuSoNaNCy4MK0RRQ0/M1Pkqb+hYKp/IO/Bcs7EDwL9UcJ0i2aVqHQ03lpfQjsWnijI
         HOkyU25PAt6jW0miEJu9cq4lMiJzFbpo33koc2dfivEcRuHVgowntR1Kv+KDLOYdxNZP
         5aqg==
X-Forwarded-Encrypted: i=1; AKwUvBxZRClqUQdMTK9NGg/4FYfb7KGB6IULFjVgoehW+gW1ZvrxqW7aYacz5PGkR6VBAcDD205hpg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ/kEJca/GYPcFTb/hv90kVfMo/WPfuWgRO6GZEjTXVZen3gqSo
	aLaVUu3MQATADj/32u/p2X6AeVZ6CuGLhVOB7z/1WvXZJxMQTXtmXo0=
X-Gm-Gg: AYBFou0UI/hLmRPKreyrv6m1Gq6+rx4jPzWRo6GpTcSzRZ0ZWiHpPzF7kr/BHB1Wjhb
	RVl8Sgmn3yvxIysW6U8CwI3li2CthItgwsGawbvVP5arjvniTa0BpBef+wqzxWPlvQ8uq+W2JSn
	jmG74L6zKkENLGTTjuV2pF1RxxuKISh05ocgsXoLZILnUXECD2HNcWVCQKK0Rn8fls8Y/5EThpm
	uRWnbTiYeBlnz1oTvChqUBjAaqDWe8o3vV/2D+n87jw24qnRhBguRg4OgVkpTSJwu5eQ1Zd4kgk
	ioEWYwoeZYsxmO/FJ1bYwdtTwHe9xuVucLQyPm8/ST1EyNZXDfus1K2bRPrq3dRF5tRGox3OpSS
	jzsipFClA72ggkcE1kz/2O2JxFvkwmXo/Qe3t3diRadBBHjQwu1uKKsz4e1dC8mV/oQgI0PXZWd
	crzYsVe5aybQRhRq5oK3e3F2k6OUBrdXJFtcNTrqGTsnvcYDpdUOqaaRrntCoQ656lHDsBNpIrj
	gUO/l4/ZDMNKz2K5WgxkP/mLXkSBcPmon9+6oRAo+0gpgNTWA4ORuAaQ2IJkpJbsdCmE9GOlGYN
	wHwJWM6g11OsNxPNmSDwOQ5M1yVz9nzwgnxt7ciwKty5sdNMdHBMFfNrjA==
X-Received: by 2002:a05:600c:198e:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4a35acafde7mr31200265e9.30.1792853878070;
        Sat, 24 Oct 2026 07:57:58 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbc718sm50327315e9.2.2026.10.24.07.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 07:57:57 -0700 (PDT)
Message-ID: <7d35f41a-c72b-4743-b8a4-0ba715be6756@gmail.com>
Date: Sat, 24 Oct 2026 16:57:55 +0200
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
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
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
 <o2zmplbtmoueumw3iqejfsdmucp5f66woa5hmw3vodbe66reab@syn2ashugzyg>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <o2zmplbtmoueumw3iqejfsdmucp5f66woa5hmw3vodbe66reab@syn2ashugzyg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/24/26 1:36 AM, Dmitry Baryshkov wrote:
> On Fri, Oct 23, 2026 at 03:16:27AM +0530, Akhil P Oommen wrote:
>>
>> On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
>>> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>>>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>>>>> unnecessary.
>>>>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>>>>> context banks.
>>>>>>>>
>>>>>>>>   From what I recall, so long as we use the same dt node, the iommu drivert
>>>>>>>> provides no way of doing this.
>>>>>>>>
>>>>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>>>>> and secure.
>>>>>>>>
>>>>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>>>> describe the same usecase - a set of SIDs which are used by the device
>>>>>>> but which should not be a part of the defaut set. With it in place you
>>>>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>>>>> etc.
>>>>>>>
>>>>>>> I'd recommend following the same approach.
>>>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>>>> similar case:
>>>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>>>> Let me check internally.
>>>> After a brief discussion: it can be either, depending on what suites
>>>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>>>> bus or not).
>>>>
>>> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
> The rule is the opposite: new kernels must continue to work with the old
> DTs. If the new DT breaks with the older kernel, just specify it in the
> cover letter so that Bjorn doesn't merge DT changes before the driver
> changes find the way into his tree.
Ah ok thanks for clarifying that.
>
>> + Bjorn/Konrad
>>
>> Not sure how strict is the requirement for compatibility with older kernel version. An
>> option in your case could be just do an override in the board dts file of the
>> Steam Frame.
> Anyway, would it be a problem? Does GPU normally use SID 1? Or is it
> only used by the LPAC?
It is a problem because, even if nothing touches the LPAC ring, it's 
firmware
will still initialize and that will cause page faults if sid1 isn't setup.
>
>> -Akhil.
>>
>>> Not sure how to address this.
>>>
>>> Best regards,


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

