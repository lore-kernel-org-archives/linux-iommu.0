Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673700;
	b=DZUvlFQNyvikln2fzaaQGahGMXJ2/pSMNamjTs8USHkQfICI5SIAhaYHkXMm1BvZfhHo
	 ajteeeYPzaE9OM7HkdkWrsEe4FlW8pVSNgkVUZ9WlGLQ3XZOnL9ZiDQwEC/+AHCWudjoT
	 oz6PvNB+KWsfrjxbAdMZzRQJLqxtYYxu3yeHJWWePxfVZ2VAZ8jVoZuBqRG94TDfoq6++
	 GWJy24mws5cW57VrlAmjYaYorOOccw4IS83y7Ttezf3EA6JazC+8T3JzcLOUlMeWOpDbB
	 OvjgoEkC9FG3MpcGXE5bdLeHMfbFJs9zxmsUlQVp5d6x5S22gkcTNudLxuC0N7KFMiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jYF7S1s7Ov9hCjAhKpbMqkQvqhCJSe4k6JebACUrQ0U=;
	b=ugYrh3xZeTb+eZZHxooKHIX9zNGgWYs1U/+b68w5LsIw1KOF3lA4eHpiAg7iugtUFeq+
	 c4df2AZMrcZjMod8HCivN23V4+N6n2beGKopZh3YEp6eWSzAWq+mJCuGbBQSkrXrTbfwb
	 OhkxtDPX9t3SyU5/Wh1x+LC1U4eaLqvXNz17g4iHrEXNqxyWcoetwFsLUVbzjp+wS8bIQ
	 1mmeNqg2zhpXu+1JLBqZDCIIbwGE03hZHQvrr+y7dqkdHdahfLUsTGRB2dUdzS4FS+nNE
	 UJRk5PAX5ef3bUFruSk3LuljjepqWJAqcnY0CFcJWK02LdP4T3dN/VmuAxcGjr23LKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FAKCYBFe;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF8606A321
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 12:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECF8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FAKCYBFe
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so3824315e9.3
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792673698; x=1793278498; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYF7S1s7Ov9hCjAhKpbMqkQvqhCJSe4k6JebACUrQ0U=;
        b=FAKCYBFe8FArmA3gQ8tHSnZbtzIuyi13QN4wKLrYiXyPDOVPGEFRPuC1iaseZ2gshq
         2+pTKosEB4upTzFy2uXL1A5nrIzD5uQXVlR23sei+Tyja7hQyvsRzLt6+WJgJL7MENCm
         7YP22abSvvLeJKe/7LkSk4YvY6ch69oxLJFAjzEHh2AFNjDxNSNDVW+xQLt4by+aspju
         M6bjM3CKw50/xpW4wZwwCne4+KsS+YuH4g0KDHO9pDTs9H8BYsETNwRXR4tjbwJc4PF8
         xmycERsL/87ohLf/OiWCCheiOTTp6rNl6Bm6udjsQ3J2CkjUHXV1WbPGX6kVX2IRML9/
         91cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673698; x=1793278498;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYF7S1s7Ov9hCjAhKpbMqkQvqhCJSe4k6JebACUrQ0U=;
        b=O8MTFbTwEzUaxrj6rRG6bBrNn9KQZ6SebMWi4lF42vjrVpy/U8j6CzIgyW+9/kkDsu
         ORf/VVsq5dBGcSVk9CoKtezNu5v2VnRR1eFKYbAWXX5Ai7y/CwhMdGRp0ZZkrSARTOHV
         yY5o4AwU9LT1u5AlKF0Wy0LIuvq5RP2PIQUrXofBJmsA0OFzJc7xYPhon3nqlaw1ihOv
         r2ZOKuuGZyn0bmDmmgrou0ZCNbkQE4SnDb31Yl/NjeJPLIM2LKXMq3cQa5qIQ2UXHm2M
         TEzLfqdEJObCJbopQdSb+bvs4+Xbue3GLDywvuN8fmsEBTjSJXgNoYqap3CXEYrEUPhW
         DDKA==
X-Forwarded-Encrypted: i=1; AKwUvBx7lcD+NjuR9i+SwDgBeSgKJV/G4vHt41L3SLpvHqvr+rC0EQmNVu+vfAUtJ/RAS5dtqL4J7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLvdX69kCzM7LGQH+mXYbAFLFxNcY20JTE1rmaXabk+8jQNqqXs
	7mPzwjzV62aJUjk+hJjRjpCZzHRdSFm6rRFfARNuNytXwbc+89voAG4=
X-Gm-Gg: AYBFou2NRlroj85QB98Upyxb1lKICz8dzKAZvDgJ9xy7WziEox/gQQztid7e3ETd5Z4
	GNagA78EOlrl6zJZgpufRKA6IWIOmlg7xjMegy1rr3XZ6e0QcCuTZDWPxK/THCHGoTWQPihdc3p
	um7RxsgYNwQDPWHr8SVtHcjeNCkUxMxYJESKdmRcDFFARcTZZ/GOf20kfbK9Q+moZ/i9l9YOx34
	XPdnJ3XGtTIdW4uJdyi/2ZXHLxbqgMA25SwB/SQ7cUbWeCxwc/YR2KS63kThsL8vEeNX4bLs2Me
	FMptEKUNjbG6V36TFl1BsyL1fO59zQKMbmE+he07uvdl1M6hV+hHGsdzqQGbRZjaAFCy3gAHmFf
	LjlJtZFquDv5JTsOTlNXgC4Jm9ujYEBznDqBL7SQjlBXcpuZPfA6nrX9cE5jT0/Egq4PI81lDPd
	4JiAxyDSrgqPLiA1dmXWNbOodMZ1aLFnmjJaawyJued74jtub6hsNQbtwdug1DMxmXlPbem47oA
	n5utzEmIsMu0Yvnyz5DZMEh96oEmFVRcovRSYZGVK5HdFwCQEh4f7Czy/qhsjpTJlXBkrncU7QS
	IQA2r/Sqhet4TpRph4YJUBLn56OONuS9EoKJ
X-Received: by 2002:a05:600c:1c2a:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4a1fdd4fe80mr121774905e9.26.1792673697832;
        Thu, 22 Oct 2026 05:54:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a447c8sm68550055e9.12.2026.10.22.05.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:54:57 -0700 (PDT)
Message-ID: <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Date: Thu, 22 Oct 2026 14:54:53 +0200
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
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>> context bank we need a separate node on the DTS.
>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>> unnecessary.
>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>> context banks.
>>>>>
>>>>>  From what I recall, so long as we use the same dt node, the iommu drivert
>>>>> provides no way of doing this.
>>>>>
>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>> and secure.
>>>>>
>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>> describe the same usecase - a set of SIDs which are used by the device
>>>> but which should not be a part of the defaut set. With it in place you
>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>> etc.
>>>>
>>>> I'd recommend following the same approach.
>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>> similar case:
>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>> Let me check internally.
> After a brief discussion: it can be either, depending on what suites
> better (and if you can persuade DMA / IOMMU maintainers to let one extra
> bus or not).
>
One thing sashiko is pointing out is that new dt should work with hold 
kernel so, in general moving sid1 from there would break it since old 
kernels don't know how to handle them separately.

Not sure how to address this.

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

