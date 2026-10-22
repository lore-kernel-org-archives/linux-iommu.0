Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692343;
	b=tRHHkkvMRx4zyBtf22vdj9jBQYw4C5XoRQglpF0+bjQfN7dNKJH6FNv33GolUf5ml7gO
	 xTHLE+57oK1e0M4jni93z1mWJOc5soVnmSQnFK08KEMcrnmYd5FfKgRo7VI5tyen/G0MO
	 4DPEKRCEZ8l/bTabjeMTulaXwjke2ouveiv5Ur7+1kP1vjjkp0vy9YDki3Uh7+xSE4o84
	 TGNPhTOKafGfOAu1OBRtwaEZUWNoAA6+UU8BrU3Zjy0iLJv+UQhHnX5WxNOWvpAGSUGee
	 WPPn5LZ74bAsZ++Evw9iMkPy71YIsTNQIZjvBukKIi6hkX1fbX1LCHP1ojOoDC3f9Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JY/kgswJkw3rC1uB03Rt3fXoWelWaBya4FySXulL7N8=;
	b=h3O5oxqqndLBgauTlOFh6UdKzNH9gSYG3tkpQTrkjuOJshz+5YfSHuI9kde6KUZhA6/1
	 W7f1TJ5GHZh1HgUHH6h9ExsgyVP/WU2dHNjLlhmtjUxoCQWBqq1MNb3KwlwGE5jeqG5XK
	 KmTFquSERvzKeyN2hdnib/MoS3A75dS40X/djIZzJAurjfxDVljwC39L2IjEopijLrint
	 3xubtT5wNiKcWkD8UvBAjtRrlzZGHTfqb3cPS0tbB9fwga9qx47eDVWr3kdnQAnHMC48o
	 6IVxUBagsdOogYvjR8k01kH/RFyAVKMDYCZBV53h0To5qQiwtsmlMTJ8ODJ1dKwOUqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ZViHxgz/";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA56606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 18:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA56606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZViHxgz/
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20803a757so619425e9.0
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692341; x=1793297141; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JY/kgswJkw3rC1uB03Rt3fXoWelWaBya4FySXulL7N8=;
        b=ZViHxgz/HaGa3NoXIukydsdL+g9tINJcJ4jaFZCYSQpKINGZOtIwrzuV92/mDCMCvD
         ghpl82w8RdQ/h4An02a73E8X3XHUBWoXIXicnjg7Ah0wtBGivw5pWwTk/5G87iXuLZpT
         T0fge7bMJdVhIWz2wcSLc1zOVpgkg+rTc0TdOkPfMcD5H95NH24Rw6TWJwwN/SZSwu7d
         9XGJPpd8phy7puBUYCFcAahdBBXuHAAUryQ5K6/tezU4DVTDghtAGy9pA+JQXXvzW78t
         lOa/XMxOMqQjOqHwrU1IK/N2fiKFPs/APgBEh7rQVc+X5Rl9bktvoEQaPn0yHmYCNfw8
         8QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692341; x=1793297141;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JY/kgswJkw3rC1uB03Rt3fXoWelWaBya4FySXulL7N8=;
        b=2q90b+3licxeb6wmZ52uTsGqImZ9+2lgnohZ5swCBgQjdrT/BAbg4piTd7m+erKxXL
         SdH/Lr/O9/OQnOxXzZVEblK1j83ZcXXInwK0/RL9VPBhHEAWkUbmLIxJedBRG6gN+hU2
         sN+OoL62GPbe9FLaD19rACp8VCV3K9IZaQHnqlaSPiru7aRAIrM/Bq0U2hGxmOxK9nIb
         sgaeJiR9DW/0pEynRFmVzh/llY7TI0uw+D32hpS7vDwkza/qKqzt92PODcI5KI8IOVyX
         MktZ4o4vg4bluW3JVA+sq4StWNPlkos6VQsqIkJE6iunsmXE01nq1lL6idQy4hlznGIP
         8QjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPm+1FbV/7rXmKPifHyx3qiz74jJxARRF9I1sDpSZFFdyMJ6/S6HRZwFYoEfJ3u0Gkg9FeHw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLqpQgdLnicpENoX6k4AUywqojaUrNIXhX8bHF9MaqAoILJjOnc
	Zr5lgl6Ehi5ZS4zy2BVJuQH6XYgJv1IdKjNeppBq8S31GiNXCVDWU9U=
X-Gm-Gg: AYBFou0gFL2xJxV0P4klpgM9iKFNzC8drZs3ma+h0c3mi5pbPQvDv0VbBm524W5/nf8
	JauZ9SJkpFMz8MwtkYZ4iChoHCiNs9NGGJ2tmmOZ1cFEKe0TwnGd6fRZtBc1P6WrGWp9qtbyiwm
	OwcHksoFLs7YwiqrLeJgYBLrSBgZwL1lrd0skVN1jva4O4XSJZtfycj2OvwyGkCw2/RQILI5Rau
	WRGEq3TvhRa8Do/G+5TuOswhG5qwp80xfclvxepBr+BV41NOmOo8rO8+6jmbN7WldCdMix4+EAZ
	9r07a+PYGi4yDEw8uOWhswbLJKYUAnBNmiJm47OUenQIjiJrpEGZfqdLXSzxF7IhQFjDBXk87gZ
	3oApkXVs7lLZqT62TKOvMATC3yq7qTFpPhjb3DDmI6jF4S9C8WWXYRKmRq+kNNDwv8m9quCA7t5
	QlzrguX9+1WsR7oE188JQYfLhNgjXWqCctIhq5qmX7BjvqBblb0561RTGQiYj3GcZW+2NfQnNX4
	xIkcD64hF9MwX7Oj7zVqjk8WzhAAHY4Wpm3V7Xk01O/MRnAAfHIf1EOmAyQDCxcxpSSzxc/kp9n
	5HkmCSA/9Lc4FDZXvKMLJHeIT/FqBOtWpPBq
X-Received: by 2002:a05:600c:46d3:b0:4a1:acaa:c355 with SMTP id 5b1f17b1804b1-4a1fdd0b191mr127111405e9.10.1792692340943;
        Thu, 22 Oct 2026 11:05:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2104627e0sm14106125e9.9.2026.10.22.11.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 11:05:40 -0700 (PDT)
Message-ID: <31970f28-5415-4e78-aa0f-51f15d779e1b@gmail.com>
Date: Thu, 22 Oct 2026 20:05:38 +0200
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
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
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
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Language: en-US
In-Reply-To: <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 2:54 PM, Anna Maniscalco wrote:
> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>> trying to separate a part of the GPU into a separate device, but 
>>>>>>> it's
>>>>>>> unnecessary.
>>>>>> What I was trying to say is that we need to map sid0 and sid1 to 
>>>>>> different
>>>>>> context banks.
>>>>>>
>>>>>>  From what I recall, so long as we use the same dt node, the 
>>>>>> iommu drivert
>>>>>> provides no way of doing this.
>>>>>>
>>>>>> What kgsl does is having a node for the iommu and then subnodes 
>>>>>> for gfx lpac
>>>>>> and secure.
>>>>>>
>>>>>> The address on the lpac device doesn't really matter. I have very 
>>>>>> limted
>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>> I think, you were poined to the Glymur Iris patches. Another 
>>>>> option is
>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>> describe the same usecase - a set of SIDs which are used by the 
>>>>> device
>>>>> but which should not be a part of the defaut set. With it in place 
>>>>> you
>>>>> don't need to have separate qcom,lpac devices, no additional 
>>>>> properties,
>>>>> etc.
>>>>>
>>>>> I'd recommend following the same approach.
>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>> similar case:
>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>> Let me check internally.
>> After a brief discussion: it can be either, depending on what suites
>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>> bus or not).
>>
> One thing sashiko is pointing out is that new dt should work with hold 
> kernel so, in general moving sid1 from there would break it since old 
> kernels don't know how to handle them separately.
>
> Not sure how to address this.
>
> Best regards,

Also, looking into iommu-map, it seems like I would ultimately still 
need to add a child device.

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

