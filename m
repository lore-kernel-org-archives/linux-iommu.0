Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F82A1CF
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982218; cv=none; b=JiTgAfJ3tO2D5ISQ23QW2+w0XyVT84QDvbe6/FVstIwj6SrM7ohYdNZnB53BqbKczPK6uCqwM4cDZAU9s7W9wisxBSMp/4iFJ9pDCb36Zk6hydg7Ivi4Dahy+wGJv/jEV9GNp8/+1bHSqn5Nlpt1KjYRvfpeN/i6l8iz/KEX5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982218; c=relaxed/simple;
	bh=uoYVhExYnbof9LSxnCeZcfCxSRtSH4o3C+hFXV3ob/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkLH9rEuk2xD8cfYQ+fB+8HqgkFK6foHGqYB7/eZZpM+A5cRsodtNeXFTD/0LxA0mw257dD3nEi+B3AyNTZrG2nlT7DTjiGfmQbWHzceJBadm8DcS3QUQxQvfCmKJthQZxKJ3ZrN1r5q/xh9PmPsi1l4om/hItb4J+g6zCaE0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Keh42dv6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZp/MK38; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Keh42dv6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZp/MK38"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEJ7ZT1382178
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 21:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4KLUxP1A+fJKIGmw2pZNAAkuORqzlask/BowKwIFvtA=; b=Keh42dv6DiOMyBbz
	5Tbb1I2a55SDATcKLk323qMBe+6ZMJPIQLAMr1FFEzCZuoxZQzPUigsaBfmTl6OC
	LlcCJOFwX5oZ9HGoUA1JbcLVzd939kWrEogRs16f7lciqkrjMxDELr1QebNgRrga
	ctmGxyu0pLDW5RIUhCHdTPbuceAJ+je8pQ68eam4KBjvxOrUrGM+BDBdv82cNtj8
	Juakh5ix88e9JCvbkO0gU3USEDzkWklSVR8UQAxNXLc7tO2H+OzxkI4V5t55llu/
	fIt0cUV8F18JwwIvRHdlkkkT6Kpv5Bb/xaLctPAYXZzhk/yfhdzUQ0AayOS6I/Ga
	oRQLOg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw49auc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 21:16:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2955f0b8895so15579005ad.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 13:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762982215; x=1763587015; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KLUxP1A+fJKIGmw2pZNAAkuORqzlask/BowKwIFvtA=;
        b=ZZp/MK38c5IFJl7+R+X/2VrKKS+Um8o84jZaHK8OxHRlBlzQ1HRpT9AlDDNnFHi5i2
         C43qvaa4ZmpwBgYjhC7KKgYxG3FrgUOm5yykKOgGBJgvPJVPagBfghtF1LscTkqJzERy
         /AeHaTkoUYlI0Uy2jhd2ho4Bo4RuJ9WLPVjwi5r5jYcDHg1akeIZ31s2ZytKA3HnXfy1
         Om4OyCA9oTQILtq9ulZYL1GLexsvJUBlLIiJgS+qEQh7GWyuqdtBvjVIJdxVTvs2o8T5
         hRZNAlR41IVt2JNlq6Yxb+pweltJ1O79EitZzurdX7lTWJXHqgV8UobUQBSRroq2DaLj
         jxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982215; x=1763587015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KLUxP1A+fJKIGmw2pZNAAkuORqzlask/BowKwIFvtA=;
        b=oDuM/PTAdPYDvf7x93XhmiHlYiUf+gBZS8vF//5KEM/TeJl70q5zcTIslHEIIYUb5e
         qajelqqR8Lhfhv3bH/3Vx+DDSTHaobId4SczCDBTUS9Ev7mwxBT87fzfHawmsgNzq+f/
         sgqDV5AREifeo5RyAewKfq2uyjf8aF4ST3CTtaTgJ++kTImimIByZtAvDGXEv4ijgu2y
         RsmCscVS0y4svJ70OnQTDohZT8QrH8RXOT6ppPntcjZpyjDPpbHmQe7BYD4vVBZZL1E9
         XKeC565O+zs6s9eAJbnu7ED7G6lhsx+Srb8BA6nAsefsdp+V78/DnUG7eP6t9fvE8YWo
         x1yg==
X-Forwarded-Encrypted: i=1; AJvYcCUcNRSJQWI7hO6xf8kGqf1NQZgC56XaargFk4pBqOLqU8SgnqaiesV2FomGZ++ttXexthhBig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7jI+lZNNe4j36gbLF6KdSqgpu8YisJQujRyl0uaV+rL0Ru85V
	ShEMM7KN8Y+4uMggpJO4cgk9uOPlFBMVEQCDUm+hWuWEdnOPL9eQuGIKP7wGFf7nYYstvfyRvTT
	NnaM2jY508aLCRALNFU9FCOaPRSO/2dQoRVwgqigZ5jr3y9JZLQFCj+xoQg==
X-Gm-Gg: ASbGncvqL7IT8XuF6ihElK8xpEv2fDYYFW0Q1KinkgEFSAic6EP3CUOt4abM8D4lJke
	G3EPyvkrY4DLy23PkHQM/gDciLzzO1BuIOvnv+tvNW9TlDLbHN9SUChnbQjkINRnotBrsZfOaJN
	kDSUuRZ8RwmZiE9E2+jo1rHMoXTm6pXjfutq1gqwjdL8F8J9TP7qMxiWl1jGlPV4l0mZ52n1dlP
	SmCvgNvj9CI31K3iDVFOsFK9ND1a7iWYIW6Fzg4N1H4PNFToE1GOSLlZgqpwRNZxT5zPGwNtsdS
	iPId7xwHYII2+flGi2JoUzT/c76KkQKKCsU/1lzQ5ktN2flkXURJx6e3u4ACtdpTkASrXv6NnUh
	lmtm0pJigRq1d1IpL6o9ePQ==
X-Received: by 2002:a17:902:e951:b0:298:88:c006 with SMTP id d9443c01a7336-2985a4b366emr11200955ad.4.1762982214698;
        Wed, 12 Nov 2025 13:16:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfYCKhd6MQEsF06e3F32Ghk4Zj+VCRoijQ1Gh0yc34lnyP12H7UORYvh0CdBd1dlZ6GUpfaA==
X-Received: by 2002:a17:902:e951:b0:298:88:c006 with SMTP id d9443c01a7336-2985a4b366emr11200475ad.4.1762982214157;
        Wed, 12 Nov 2025 13:16:54 -0800 (PST)
Received: from [192.168.1.5] ([106.222.234.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2c16a1sm916005ad.95.2025.11.12.13.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:16:53 -0800 (PST)
Message-ID: <cc4ff1c7-3158-402d-b746-5aa57b4a855f@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 02:46:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/21] drm/msm/adreno: Support AQE engine
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-14-bef18acd5e94@oss.qualcomm.com>
 <1202b66c-6d4f-4909-a010-7e5e3ec7f0c7@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <1202b66c-6d4f-4909-a010-7e5e3ec7f0c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XBsAM_8O46btGoxwbiEJWGBb_TvLSsHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MiBTYWx0ZWRfX8OHrnTSBxIkU
 HAITdw6huxsoiPGIg1dTfaOJ34YuH0MhSTml26y7qIf86mXUJ/WnjJKhTFdm+7YP/iET2+39KoT
 aLJukA2QzO7Nxbn81qw8MXyAhcX2PwMNSejXMwy4T27Qd5JGWaTI6Sggf1pcvaOTNWLP8SthTOf
 MAPjLnyx+cbvcz+rnd5J6oE385fBjuWfCyJfKBmaHJ+DSU57iHweVsqYSwNrIY3qFc+qFX8Xoc3
 cRMuP+3LVFnKCV83mh3YYHw0loRDGbcrZUzNX7RhCw8rGnVucx9zUTg+fpvdXOCg/U1StUrDCkB
 rXxmK478a+TjA0flcT/Lh+DL2gpwOsKJqRowp8NbNC/khOf/BEgQb5kSyO7u6yngr9u5zeyW/sT
 vUVVNgRgivqWLtv51aY/UfOnwXx3sg==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=6914f947 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=2IP1oaZ8+KUWsYovLW0HHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1HEVVvjKVHWHBA54g4IA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: XBsAM_8O46btGoxwbiEJWGBb_TvLSsHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120172

On 11/12/2025 4:37 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
>> in Raytracing related workloads. Add support for loading the AQE firmware
>> and initialize the necessary registers.
>>
>> Since AQE engine has dependency on preemption context records, expose
>> Raytracing support to userspace only when preemption is enabled.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Side question: is the AQE fully functional on any gen7 targets?
> A750?

Yes. Only A750 has it in the A7x family.

> 
> [...]
> 
>> -		adreno_gpu->has_ray_tracing =
>> -			!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
>> +		/*
>> +		 * AQE requires preemption records, so disable raytracing
>> +		 * if preemption is not supported
>> +		 */
>> +		if (gpu->nr_rings == 1)
> 
> "nr_rings > 1"?

Ack.

> 
>> +			adreno_gpu->has_ray_tracing =
>> +				!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
>>  	} else if (adreno_is_a740(adreno_gpu)) {
>>  		/* Raytracing is always enabled on a740 */
>>  		adreno_gpu->has_ray_tracing = true;
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index b507ff4e1756..7921b4a68937 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -58,6 +58,8 @@ struct a6xx_gpu {
>>  
>>  	struct drm_gem_object *sqe_bo;
>>  	uint64_t sqe_iova;
>> +	struct drm_gem_object *aqe_bo;
>> +	uint64_t aqe_iova;
>>  
>>  	struct msm_ringbuffer *cur_ring;
>>  	struct msm_ringbuffer *next_ring;
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index 78dcb9bc3377..2ef69161f1d0 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -616,6 +616,9 @@ static int hw_init(struct msm_gpu *gpu)
>>  		goto out;
>>  
>>  	gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
>> +	if (a6xx_gpu->aqe_iova)
>> +		gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
> 
> I believe you should also set CP_AQE_APRIV_CNTL per-pipe

We already configure CP_APRIV_CNTL_PIPE for this.

> 
> Should we also enable AQE1 while at it, to reduce potential backwards
> compatibility issues? Would that require solving the iommu woes?
Yeah, AQE1 is strictly for LPAC workloads. So lets wait for LPAC support
first.

-Akhil

> 
> Konrad

