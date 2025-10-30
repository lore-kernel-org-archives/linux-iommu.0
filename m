Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76D1E5B9E
	for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833075; cv=none; b=FWAOIXipCVr579dZW3qFUmLy86/z72QVOJfOHs40J42jhXRV9HsH8WnZKY4b94sUszife4mluYlYxwiC8nhf7uVrJ07i8dKbkrG1Jf9FUfBUhl1N3Br8sPTDwtRiB1eLKhewVK2SmVPLBGxKEhWhjLyYCvV5nupDFSM5fQLRUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833075; c=relaxed/simple;
	bh=LTWQBjn0CZ8QqR6dlwlS/KcTfG6d9CFl7mBgOcL6lD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlNPs+WdF+3Q28++HYKBIdD9vVILtQ8rDUlQ8o6XiMZEi71WzOGaOkjKL8S+y6xWfsECLPdMaqu9JY3jhIsbPpec66EVBfLtM8Mie2beWAqzyXcWfZccl7uRt1qPmGAWz6q6JXGge1cCNsix90uONZmHw1Eqmy6S/4Fu/y8uUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWuor9Yx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQMSuWF6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWuor9Yx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQMSuWF6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7VG441655983
	for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 14:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aQyeMtemgCoOzTzlwykczyRlEpZ0QjYCHYEqGRqhGag=; b=AWuor9Yxkz6K2wy3
	IiPbM7oYI158WOrYLTN7eMPnu70Uu3AuuCOcn+C2w4weR3T6rH0AVFAd8haAFv/H
	pNOTpocnKQbzDT9i+zu+/tXr0ZhoFM9AL3KPw8cFanSHVtw7MGl/3zpSrFwgl/q2
	0znrD3KNsyRnHMYKTFNSXUOSvUj7qrbSCBsPrJd28y8iFdv9h5hgmwvolEKYfvyW
	KmBmsjWOrA6rN7696+mrUhXbV7d89iJz9P3oZmHddxBMxy08Kh/Pcxii9D+xnwb2
	+Mlze/ikiy/UbwTVNSOmrQ0jJVssydVZuXIblCFlRmYMGdkiJ7zrRwy7oAp1LC8y
	R045iw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptthes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 14:04:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7810289cd5eso2862432b3a.1
        for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761833072; x=1762437872; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQyeMtemgCoOzTzlwykczyRlEpZ0QjYCHYEqGRqhGag=;
        b=CQMSuWF6+f0VTsQS2+x1fzZ+4moevCuWIPhahSMrmQS+cXysBIJrrpGuzuzv+TBeMf
         z7Bbm7XVZo6sMR9xKapMEjykbcY9lb6Zn39mF3pMqsjMk7MCWP0rTYpdY/qICJKOdKyl
         E8xBroK/O0Wa+URiilJkjVaO9nb5VeJ6rVGL2uvoB4UdcCERjZzWOxzL9mCEaI2OHQhZ
         bxoebs3izquCe6dGCSJCfizaX7w+wnR8R4ZI24eN65nb6HzO/qN0DSZFg+RNwMx0KJIw
         De2LASs8hdzryA0p0OlVvxxrjFnp1vT5X+hH81r4Bd1T4CNFOmt9qavM51hj1RIMNGVR
         jhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833072; x=1762437872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQyeMtemgCoOzTzlwykczyRlEpZ0QjYCHYEqGRqhGag=;
        b=RKaa9GXrHVp4OQbOkgLNcF4aGH/bVMG6Z1UWKVzivuWxzEnQg3oQNlK4Gf5GYoUYit
         o2B0A1EGCOzqHlCrj2CYwyKzxJZvHL9azg1AKn1OeVeMXjuhupAwulYsivzHTgf6/wLs
         voI3V+qFKSmU2dD3IETDZkgukm06tJtoTEN4L9Z+mFGKI0J0rZfiUzGWwuP71V5SqSoP
         gUDgdWZuv3nHglahcNSm9IBHSnw3l4+Mn7hUar9Uw84A+wLaC6PN+SiJNB1zmg1n6efe
         4oBLtHIl6/3G0I6wLcIw9QoIgrbdN7/+VprWsuD8et/+SiBCMkZjWdnTmT0xbR2bHNZw
         0o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUayouOhxXHMPSGtH3bTRQsqQEw68NWl5CYvqaV1J6HBf4bRZxRN5vxHjsKL8i7mnEQfezWKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/SB76RiCvtZ5syaeOCHmcd81lu+Ie8ewr6f4XrluQnUjZGGz/
	A8ReCJA+I2f/cZtQZZXMvGQbmfcimw6f6pdq9l3ZDn8nZ1O3zXFCm91OLpAWQ9CwuEI6u5hbFvI
	2WRI+Ud4FL1NdTViHAIhQcIDrYWjcbRyQbtRx7xkeWxAzQBhd3Gw1Yk+/Aw==
X-Gm-Gg: ASbGncs2O5Ua6Z4/5RtJ/WcVmCm4AaOssnlNfPG349sing5imySjbxtoXDjd84eMG07
	8fRJy7GTzRUG1l3qAn5bUiHNhB22EQvVShxV8nSlcnTVRMbXwQkI4bM6n9NmHsit3c1Iexq6Wen
	CAm/pOsXQnvigDTk7o//0G/3Cha/mk2xnmvd94J2MYXm3cfAphd8WiK64QJSxCoC0DwgFMeqCa7
	2cjR38WiKsapgyoMTqDaB4+NL3p2nQMFwAUwXJvy/kH7GMJ40mtzOV+uUX2Xm7Cpc9X9Po18mJm
	TtH7fAd/uK1aR4/SCGgxmpnmr5qDRwrZphUByA7u83mbg+jv+m7QKo2JiX4Jgn/idbaId4GSbbj
	gwNjFdwqCHZ9wKwWajqYdrg==
X-Received: by 2002:a05:6a00:1786:b0:7a2:8649:5ab7 with SMTP id d2e1a72fcca58-7a4e2fe7764mr9513752b3a.14.1761833071967;
        Thu, 30 Oct 2025 07:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOsm+Sq4JNvFojnAbXxBbvyUiQ9n1HBmXRQ7fcHIwRyOXUnsy9UNUn/WOnPgjzpqXGKHxy5w==
X-Received: by 2002:a05:6a00:1786:b0:7a2:8649:5ab7 with SMTP id d2e1a72fcca58-7a4e2fe7764mr9512694b3a.14.1761833062850;
        Thu, 30 Oct 2025 07:04:22 -0700 (PDT)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409c703sm18826520b3a.70.2025.10.30.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 07:04:22 -0700 (PDT)
Message-ID: <4b41cb16-858b-4fc2-8ee1-3a7171712808@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 19:34:13 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
To: rob.clark@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
 <CACSVV03HaKAvfDa5A5LqRZM4_o8g-haVU3A6GgWqfTO0QNcK2w@mail.gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <CACSVV03HaKAvfDa5A5LqRZM4_o8g-haVU3A6GgWqfTO0QNcK2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDExNCBTYWx0ZWRfXw9wh0MtBo+kA
 yNHTDitDyC0MQn1dkkqFJYIl+lABaBOHtDTJ7gTVxNjL1fy65M+Qc6j04zGbrwbP7FLyn8cNi8N
 x7LBgK/YnugLjKc/MYQcuCQ/5EgP2WjVJQaEhSExy9d+oZvOYjcTfK9lrFF9uJUlQYrcMMDs1bB
 q5zMOJWySotHuQvS2X52rc1jQtW1Rl875BaRauVILVTgo1bKY744U27EEYeEyeADvu3q/kz/8JW
 TQrwoAd5E1qDjHsXSqUDLBLuA04VJTsfZjoUldtxFrbJwDYo0zEg62pnykEVh7K4wch9LkFBJQ6
 JHlaGY+sjsdKsoGsd9VKgLdKpZdNZTc2hOZ55buZ6r02ORX+UFyQ4xATKgF0WjV9n4UAvSEGgp+
 9vuNJ5T+pZikE/0tXRbWTQJS9dkbjA==
X-Proofpoint-GUID: bD304EfPzor6CAEt0Eaz9folKD8kShnH
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=69037071 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ktRuAwBfdPNgXckAlmEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: bD304EfPzor6CAEt0Eaz9folKD8kShnH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300114

<< snip >>

>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 0b17d36c36a9567e6afa4269ae7783ed3578e40e..18300b12bf2a8bcd5601797df0fcc7afa8943863 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -46,6 +46,7 @@ struct a6xx_info {
>>         const struct adreno_protect *protect;
>>         const struct adreno_reglist_list *pwrup_reglist;
>>         const struct adreno_reglist_list *ifpc_reglist;
>> +       const struct adreno_reglist_pipe *nonctxt_reglist;
>>         u32 gmu_chipid;
>>         u32 gmu_cgc_mode;
>>         u32 prim_fifo_threshold;
>> @@ -101,6 +102,11 @@ struct a6xx_gpu {
>>         void *htw_llc_slice;
>>         bool have_mmu500;
>>         bool hung;
>> +
>> +       u32 cached_aperture;
>> +       spinlock_t aperture_lock;
> 
> I don't see aperture_lock used.. but seems like maybe a good idea if
> a8xx_aperture_slice_set() acquired the lock and we had an
> corresponding _release() which dropped the lock, so that we couldn't
> have race conditions between the users of the aperture.
> 

Yeah, I guess we should add a lock because the pagefault-coredump path
and gpu irq are not serialized. And both of them are users of aperture.
The other users are serialized already with gpu lock.

-Akhil

> BR,
> -R
> 
