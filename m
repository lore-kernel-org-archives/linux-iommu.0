Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4B3ACA65
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731614; cv=none; b=HhIPI7WDPuwtLcKnDHWNnCBi4jr+9v7l5OBaUl4LELHg+YbwvyOJqzxgBn/4VNlnleHQ1y86RfQyW9i2BS0ZNtfZNOIml+6X68wR/1AQ/MdESiSE7hI/Wz8NvpXZqHlO1aCXI1A5y/PA58JBdxRrY5Ohg5A2rX82ZWorlSaMvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731614; c=relaxed/simple;
	bh=i51oMRM39b4zkPD5v1JZCUBphGiNCQBhDYu8AT0JFFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqRvPdHbqt/ViyvT+z737u+TpxyYiHl3LMBOZB8WfJVp1CckuVBQxGQHcx3A8mi3f+5oi2Me9OJx/jezXor+dVJhj93x5k6susFt3miHBh/b+N862pM77pnzG9TXERMWDy2m9Yg+PUXi3+rtJWI2qxVmeeh/p3+vi/j0dmwozD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKbC6gIm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TqunvBTC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKbC6gIm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TqunvBTC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AVdZ42400586
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 17:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tk4/hiWtP/NVhogneiRF45j/bTrlav0gUX1qihLjIkU=; b=MKbC6gImGeSGJy8a
	LGzOMcp5qxkuydwP19LM4Zpfip9t9Vbz6bn1UOtpH5mDsWbwPNyXxFK+KCparumq
	gk+w6ktG5uCZzF+y5MMAD5MQJ0EUHpT08mcutJ1YhihJjy2w5niS1kHlyOJaLCwc
	gas9+uODdBgQb2piFSiYqIzGG14B5zXKH8FHB3pkFCrnygrgkawe+JrXX9/HW+n/
	qIk8YzkTe8GNmB20kYlGeDcqDkkc9nQYHLfX+xZ2So3Tt2KEu5+drAfsi51mFJIh
	NgaPb1FVBI6VankCKKeFJmNQUd3YkGRKIJgeRnQcfrsRamuaYy5d0E6wFtKoZ/IA
	hgdXsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dh9gy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 17:26:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae42659a39so330827435ad.1
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772731611; x=1773336411; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tk4/hiWtP/NVhogneiRF45j/bTrlav0gUX1qihLjIkU=;
        b=TqunvBTC3KI15c2ls1BBJpBmvGY321sNX2EXrbtG5A063VjmNGQhbitrTNPGC6oyGU
         wy7ZHOfj98dEXAnhrTxXDCjn9O3g6XA8L9IfdTfVpvRthtewDI5P8JNSDvoW7xyxrQdA
         liHdNO332+hDdiOE6mhCr45tme5ATeeqw8JrMCH7/rorSxjdV+iQcgBYqb/SBWVRCwfL
         WQs3I7JT3R5Ojk+3pMWeG9wQVcyIN/bBlSb8Koa9gQGY4m+HR/VlFePuMZYafooSPPxO
         PNDBy+JmdZrJIaHPS5QM6bQPK/VQ6PLOK9KeK/nHEyKmTRsjw5tiSw1JbP70Hf5YV4uo
         RZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772731611; x=1773336411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tk4/hiWtP/NVhogneiRF45j/bTrlav0gUX1qihLjIkU=;
        b=ny1nozqFRrwFXgC2AhfcfVBBGdyumuHOzjvvyhtY4Q4gtJLdZ6N3E37mPjkzgr7Wqg
         mfdD3513/WRFZQ9J79i+MkiW6Ypa7qMTbVvxr8MgcCJrYL4qb+ARJ5asO7jvcKKE7vFR
         ZO4zu9wyVE+L3HBZqLExWZsW5nSq2FtOBjKtV/vVpwZNXAqJGv7N7vvUoYkIGyBjisZc
         ExY4XWqJlkHxBTPqScwDtnVm8HWqV6rhxzWXLRiDE2UCDp95ucYjlgCrLfXD/2aMEC8m
         PiZeCQ2hhxN5h+yVk0TV2ev17xUFLXEIQrc6tKpwgI3sxXhZv9Z8sV/cGT7GdKVDc3qr
         v0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX/F00CVq06jJl8riT5LnuutX6v7YqmplHAD2Rf++DKWTbmy0HwBhzdMStB3/RbWzPQqQ/idw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6IBXCTuLPr15wI37/TGMdm6mogcKx1pz8nPAzieB56YcVRxsq
	xDCL8CVDrhYCPb/kTjo2BSi50pK+CXPLJLcV5Lh+4geDhWL3StRX6/NZuHW+rm3h1DDxIr0FWhD
	YzD7CQ+EF2mWAm927tyNr8jc3o6tJUZnu5e3TUrKzYS6vMNQnGYunV4JzIg==
X-Gm-Gg: ATEYQzztFvc2uDtQIw0jU2UyEvqmHxzNAK6+UhEdXbiHVO6I1Cp9N67HTqM35RtuvWc
	H3dSk94J5SXwEjmKJohjHur8bDIAJpH/D68MCqFnEgVZ6kLplvsSDH0FGIeaXNVqdnyDHWtJU6m
	0h5kysN3zXC3pKTwh3QApKCiAgXG+5Uj4qPDy7vlJ9rpVRi28OQqMXph3O5nBkAQTgPo5AdgIDR
	TmQK6lTXTnNmTKOf0VpFpnPfleFAXqeUXZLOf5HEaRigoQF4Q6JUuoXnLcbk79lhPyMR+jvk4XY
	QaeLX8oWTPEbx3WEzvyD9yowHLjywTcWljWjUx+9shyYqEkQHN/2yknISl0LiiMprrESNRAKBZ5
	93ySUKkih542SanaTxW8wKRfTGLbQTg4F+ou+L71pMQZJUJC3H6IuDr4=
X-Received: by 2002:a17:902:f60e:b0:2ae:4732:2859 with SMTP id d9443c01a7336-2ae6a9ed194mr65585885ad.3.1772731610582;
        Thu, 05 Mar 2026 09:26:50 -0800 (PST)
X-Received: by 2002:a17:902:f60e:b0:2ae:4732:2859 with SMTP id d9443c01a7336-2ae6a9ed194mr65585505ad.3.1772731609912;
        Thu, 05 Mar 2026 09:26:49 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae46500068sm148080625ad.52.2026.03.05.09.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:26:49 -0800 (PST)
Message-ID: <1d2b55d9-42e3-4459-971b-e276a87fb843@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 22:56:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] media: iris: add context bank devices using
 iommu-map
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
 <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
 <e12da06d-cad5-4967-af07-64c7c6e540f4@oss.qualcomm.com>
 <vi5v5bczg2wx2adfpr6ppqcad76oecitoyc7zd2i4lahla4buw@mqnppboxcyrs>
 <6553cfcb-9399-4d17-a529-b07b421ed7e8@oss.qualcomm.com>
 <mqyg7cebyahkrngvnxcrenkdd3dybpnkecago4lqonfwqzize7@yawbtcsli3vi>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <mqyg7cebyahkrngvnxcrenkdd3dybpnkecago4lqonfwqzize7@yawbtcsli3vi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ttAWmlxjso2LVqzc9dILHIXh7HENzD2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0MiBTYWx0ZWRfX7IxDE+SMQZb/
 sE6jw55CLzoVVnL79viGGn301tkvGSClfCJnHQr/dj45qEeS+XvAxpJf/NgT9rKhdik/CCDVuq9
 I68NGKrPLkAe9WfAgQwGtTMp3zbXzooUiaRgMX1VPqgi62umanq/SCNZdoV0G30nNj276ifqzHl
 ksja67+8dHt6/kz/6shBxBkZ52my18Ca/s5AHGxM9h0NuMda2H7sarSve32jhJ+SUtSI9DrQv1Q
 WUqHUxNumg7VNrDY63vrd+RixoO6gQgWQIwxfn10YJ9+sBV0G0CNCkDgPJ37FVKBPeIqZNCZ7Je
 F9P6XYuswfOmHtC00nfn2/GYzejO1rJe34o59dZik93gkK82CADIZ60Sv1M7dsXqoSlwiqvWOjM
 be4kMmPM81S5O6nUVobloxfrNpT3XFysFMkilYeSOKIgYlSo2Q7uaQXn6kTV817MUoTMEUFSkaP
 /X3WHcToYqE3bTdZtpg==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69a9bcdb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aqFQw3FEyG5UwdlagGoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ttAWmlxjso2LVqzc9dILHIXh7HENzD2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603050142


On 3/5/2026 7:51 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 05, 2026 at 06:19:52PM +0530, Vikash Garodia wrote:
>>
>> On 3/4/2026 3:55 AM, Dmitry Baryshkov wrote:
>>> On Wed, Mar 04, 2026 at 12:16:50AM +0530, Vikash Garodia wrote:
>>>>
>>>> On 2/28/2026 1:50 AM, Dmitry Baryshkov wrote:
>>>>> On Fri, Feb 27, 2026 at 07:41:20PM +0530, Vikash Garodia wrote:
>>>>>> Introduce different context banks(CB) and the associated buffer region.
>>>>>> Different stream IDs from VPU would be associated to one of these CB.
>>>>>> Multiple CBs are needed to increase the IOVA for the video usecases like
>>>>>> higher concurrent sessions.
>>>>>>
>>>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>> ---
>>>>>>     .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
>>>>>>     drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
>>>>>>     drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
>>>>>>     drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
>>>>>>     4 files changed, 111 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>>>> index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
>>>>>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>>>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>>>> @@ -204,6 +204,22 @@ struct icc_vote_data {
>>>>>>     	u32 fps;
>>>>>>     };
>>>>>> +enum iris_buffer_region {
>>>>>> +	IRIS_BITSTREAM_REGION		= BIT(0),
>>>>>> +	IRIS_NON_PIXEL_REGION		= BIT(1),
>>>>>> +	IRIS_PIXEL_REGION		= BIT(2),
>>>>>> +	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
>>>>>> +	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
>>>>>> +	IRIS_SECURE_PIXEL_REGION	= BIT(5),
>>>>>
>>>>> Can a context bank belong to multiple regions at the same time?
>>>>
>>>> yes, they would.
>>>
>>> How? Each set of CBs is defined by a separate function in the DT. How
>>> can CB belong to multiple regions? Could you please provide an example?
>>
>> SM8550 would have same stream id for VPU hardwares (tensilica and vcodec)
>> accessing bitstream and non pixel regions. Thereby non_pixel and bitstream
>> regions would map to one CB.
> 
> In my opinion it means only one thing: you will have two CBs (one for
> non_pixel and one for bitstream) having the same SIDs. An alternative
> would be to define fallback rules (if CB foo doesn't exist, use CB bar).
> 
>> While kaanapali would have different stream id for tensilica accessing non
>> pixel region and vcodec accessing bitstream region, thereby having different
>> CB.
>>
>>>
>>>>
>>>>>
>>>>>> +};
>>>>>> +
>>>>>> +struct iris_context_bank {
>>>>>> +	struct device *dev;
>>>>>
>>>>> Separate data and the actual device. Define a wrapper around struct
>>>>> device for the actual runtime usage.
>>>>
>>>> we still have to store the list of dynamically created device. Name can be
>>>> used to fetch the device from the list, i think the existing approach is
>>>> simpler ?
>>>
>>> You don't need a list. You have an array of the size, which is known and
>>> fixed. You have at most 9 functions, which means less than 9 devices.
>>>
>>
>> as mentioned above, its not the same for all platforms to have one to one
>> mapping between CBs and buffer region. Thereby indexing based on array would
>> be an issue here
>> It would end up something like this, considering [dev region] array,
>>
>> SM8550
>> non_pixel_device  non_pixel_region
>> non_pixel_device  bitstream_region
>> pixel_device      pixel_region
>>
>> kaanapali
>> non_pixel_device  non_pixel_region
>> bitstream_device  bitstream_region
>> pixel_device      pixel_region
> 
> I'm sorry, I'm not sure I follow here. Could you please explain? Maybe
> by explititly mapping DT function values to iris_buffer_region values?
> 

Kaanapali
IRIS_BITSTREAM IRIS_BITSTREAM_REGION
IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION	
IRIS_PIXEL     IRIS_PIXEL_REGION

SM8550
IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION | IRIS_BITSTREAM_REGION
IRIS_PIXEL     IRIS_PIXEL_REGION

>>
>>
>>>>
>>>>>
>>>>>> +	const char *name;
>>>>>> +	const u32 f_id;
>>>>>> +	const enum iris_buffer_region region;
>>>>>> +};
>>>>>> +
>>>>>>     enum platform_pm_domain_type {
>>>>>>     	IRIS_CTRL_POWER_DOMAIN,
>>>>>>     	IRIS_HW_POWER_DOMAIN,
>>>>>> @@ -246,6 +262,8 @@ struct iris_platform_data {
>>>>>>     	u32 inst_fw_caps_enc_size;
>>>>>>     	const struct tz_cp_config *tz_cp_config_data;
>>>>>>     	u32 tz_cp_config_data_size;
>>>>>> +	struct iris_context_bank *cb_data;
>>>>>> +	u32 cb_data_size;
>>>>>
>>>>> Do they differ from platform to platform?
>>>> Yes
>>>>
>>>>> Mark them as const, it should be data only.
>>>>
>>>> cb_data_size can be marked as const
>>>
>>> Why is cb_data non-const?
>>
>> dev is being updated once created dynamically.
> 
> That's a bad idea. Please make the platform description constant.
> 

I can give it a try to move CBs in core struct out of platform data and 
have a buffer region based lookup array to fetch the device.

Regards,
Vikash
