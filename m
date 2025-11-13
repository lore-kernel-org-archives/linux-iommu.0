Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AFC352F8D
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039462; cv=none; b=srGs+OJBiycFzAEApVTvn0NheccDmimDe+FUpTiSaU+xoRvDxktlp7V33plGzNXeGXvWKpUWKNOicDglUZpX2RTR/OzWTmJHOjxdAYWXATJXgFOVWuu/TUOvqdjSyuHbYM+4C3c3lUDEDzeQTb45UDVdaZbMozHW7A+WRBTGmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039462; c=relaxed/simple;
	bh=bJLpgmhmTmJRQ1f2sjYlvMkh1MNjxIMj51sjDN0rwd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwITQnNVYGFgtz1y81apwZHx10iTbeXXTm4Ps6IybQ4+G2EVAmChU2TiTRlJtoGP6FnPzF/SsbgdZClIAoufXT2z6seMxy1mTZd+wxcmgc1h1ps39StWYOQHKoq2ZmBqnEatBUNqBAsOhXUrzM0KjUASzxb7GXlXMdXdaDTX0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOqMaBTs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ERV8wawy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOqMaBTs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERV8wawy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD6hZfo3801210
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DRTlfmcA5G3RNmazWc6q+mJMqfQXqWOCzTyBT64u9rM=; b=TOqMaBTsjWUqDCE5
	HDed8I/iW2bdO1rwLxiMq7m7eb87aqzdumHxxMdVgZ8/CEnauG+fKxWLkRNspXks
	bM24P6wv/5ylAbR/OnXEbcJZ7VUmCaFSW7XylRBDABE5A18wVpNvXt3wrVDCVYBu
	bBiUrn4EVnTECSgSiRVGXRESIrU8cF1oWGyYOiusBeGhnMk5aI4KyfDGHegM4eW9
	qrfjzvuYHqpAvZv0/1Mfbpr4+NOqgHVqaSKtdgRLuWHj+9sT73RLQusyIZ4BZrSu
	vOWUFz6snmp1LvuBpdCipRhcr+7aKiHKnr4DTFsv5QxC+Fv+9CLXTFzHj8P0D5gd
	LN+fBA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaam94ns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:10:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6a906c52so2313331cf.2
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039459; x=1763644259; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRTlfmcA5G3RNmazWc6q+mJMqfQXqWOCzTyBT64u9rM=;
        b=ERV8wawy1OGarFJquUQ7fzqz2HelBqWwpAPVZ6eTe61xYiZuG/mjBTTBJFKGNak7fi
         keeZsvfqyzEp+QwfPJEkbKXuLj3b/jKtpvtYYxxezqeHh1eXvsdHus1twn8tu4NbIYIM
         xtpXwyxCIlicPepCgejxRdG01rVUc7GGmYfr0GKuuNFJk4YBYSpPzdRneSJEQdl8JWkN
         bFb4A9708pckGyj5thkHAQgG/obcJAT7mc5WOL9B/6J9jezurv4DFVMcJGL+zrdFgC/c
         M+9gskyCuqEYQ34KO5UdMxIE8ONGSXaRZgzqKDXZYJMtzE0zW2yDIJecxr4afruHxFu7
         QqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039459; x=1763644259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRTlfmcA5G3RNmazWc6q+mJMqfQXqWOCzTyBT64u9rM=;
        b=XGyyaA7pRcyyKrUltE+ATG5rCJOVREafu1rEa4Tw0Lfae7Qdrr09KILf1ElC6HQaoE
         a0WOLpJ1CZBb+XsmNSxMo39qHZMpKeipNtKijK8IFD/yOgA92Iggevu222iMbKp/ho9J
         AGBuV8HWXcsZQOWjGo4NbXIWfbTXE6lEhDlaRnUCvREvNAzNZ/ey6P754BKVz+Ba2evK
         91bWyTI3SZ5R8Q8+bEMyw7OGK57HBNnNT+dIhdHM7ib9DJsQJvmC9zdOXJHAUjCJ/mwm
         S8y/FDZ37q759tOFlXZenY2mgT3v3sA1Bo6ddUczLmTe5gUzzIAXbHVQ/HaYikTeJTCr
         DnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgPwzJD5OXuQNLf6ZuAqw8VLy7sPR/XOo2JhCLTPIrm4M/dMH/bviOto4eUKhi1CvGQMh6nw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+r2fRMkfiVKMYGmS6Xx+kisYw5isL7oLDqgjc4TRFg2mI+UBb
	AujG9NOhhjxwbTRW/DseTpaLMR/PjIEzgiSw1FuqfKh7JtYUNTuJx/TP3YgGUdJcAqUeywNue69
	eqNm7V8cFVKTQXhVwXsPSoczhgMtBZld0UAvnVFynLESsrevIEGnc7Wf0Qg==
X-Gm-Gg: ASbGnct80y9Q9XQWvz1OLdxC0+tKjLZ2DgHdtqEjE7J8cGC1u/2krs5CgYtFPiAYE0z
	x8+Vp04sGIPKzGbnuZt2bwTKNEVzAQv2IIJjjNjw+EJYyI5hpYSOs2yaiC5+sJjXdnieE4yD9Dw
	QL60FcCA2DB1CNJN7ZDm/BNKMewuY9oHPhOhBis4Rs5wJ8ISKcjcawaxkAtUKwCh5x4TFf37JVw
	mejnF4I9MH0D/0hIQJ+maDPV1cj49DQjIcZOLT1mOeUerq0hHbBPRkGRB7lYKMfcXevz0bThOv4
	hwjfIqHYmlumWXJa+FpqxtQyqQCn4bc/MK9O7inX6LvRtCbsIgXpXPDr717aFnazxi+Oicq+d/d
	eTU8lhzETiZRK1N2+8io2SGHpRdSfAJihRgXifFb254A8v36Q5IU5OQa0
X-Received: by 2002:a05:622a:316:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4eddbc3b368mr66675721cf.3.1763039458867;
        Thu, 13 Nov 2025 05:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFubAqHtUuJnDF+wjB0W9VlEiOIp1rA9oYXxjeZ4nxOglG6BzzsPMTiYzTMIQ8sTZ3z4gCpOw==
X-Received: by 2002:a05:622a:316:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4eddbc3b368mr66675131cf.3.1763039458247;
        Thu, 13 Nov 2025 05:10:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a498102sm1451965a12.24.2025.11.13.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:10:57 -0800 (PST)
Message-ID: <2a42b980-c037-4b08-85a0-07f5ca8dcc1e@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 14:10:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
 <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
 <d87bea02-1a89-4854-b760-617c3655b287@oss.qualcomm.com>
 <kwf62e5l5n4pwfmetvhicupj7r6ow46dnlkkluyhl7s5wuazpw@q7vbdi7d6ul3>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <kwf62e5l5n4pwfmetvhicupj7r6ow46dnlkkluyhl7s5wuazpw@q7vbdi7d6ul3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfXzvfdufQ9wA81
 slgi7Oer+uG0wyJzV45BSdUFzI8shoXq5qIknodFFAT2q9fVtqBX1meo1tfyPoIv59bz4HCBZ4I
 lit0ZnzO4D37EaeM4ORuqHk2oqRlQIqkEdWhH8/DnHYr8jxa5jQ3mzIMthal3Pz046kugzAaGSV
 F3KEsevGk4fl54+hgRothgEGc/krhFZWVSurA4WdAgWWpCIy6rxTzsDzJaGGkrzqx1LejifSO5W
 hAd63x1Vno8pF0S5gYkHpu4R1Nej2Q9/+azPLJAKf3W1+kI+igqET2WmYBbR+4mGBIMoywMOl5D
 /bUeuRhVJuwZQzuugqRm8ZG/6Kuk87iEZo1VZw38YG+xQwobswR5Jzlmz+Iw26OjZ2JO929X+lu
 ADfwkhKat22dsXVtcJnTzy4te4TcvA==
X-Authority-Analysis: v=2.4 cv=d4f4CBjE c=1 sm=1 tr=0 ts=6915d8e3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WG-851GjljAyzOMNImgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 5ftifbwfDTh-UmYzLkTebIioQYgkr5YH
X-Proofpoint-GUID: 5ftifbwfDTh-UmYzLkTebIioQYgkr5YH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130099

On 11/13/25 1:22 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 13, 2025 at 10:27:09AM +0100, Konrad Dybcio wrote:
>> On 11/13/25 4:38 AM, Dmitry Baryshkov wrote:
>>> On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
>>>> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
>>>>> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>>>>>> In A6x family (which is a pretty big one), there are separate
>>>>>> adreno_func definitions for each sub-generations. To streamline the
>>>>>> identification of the correct struct for a gpu, move it to the
>>>>>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>>>>>
>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> index 44df6410bce1..9007a0e82a59 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
>>>>>
>>>>> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
>>>>
>>>> Could you point me to the holi's devicetree? Currently I see only a610
>>>> (sm6115) and a702 (qcm2290) uses gmu_wrapper.
>>>
>>> I don't think upstream was ported to SM4350. SM6375 should need the same
>>> hook, but I don't know why Konrad didn't enable GPU on that platform.
>>
>> I'll try to fire up -next and confirm it hasn't bitrotten.
> 
> Maybe then a patch to enable it too?

I was hoping this would be implicitly obvious

Konrad
