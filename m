Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F13559F7
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488610; cv=none; b=jJ0lBI3PQEyfvRYd8+u1Ul2p6Wv3lXCMFvFv/YaLFod/mmT7ySkMhfQ7VrQWc920v6DbklqBdznmoZhqmurWDmXwgFLkzdPxzUarLNQX5pD8zCvmXXE8vFAtGsK3bBIYP1FTgm3EIcxkkzbHBRi76drL3EsaBsDTG5Zv0oa0GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488610; c=relaxed/simple;
	bh=uf+40LotPEMgbLut4129kTZe9+ZPzyHrW2kpACe7kjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOVEznkOdg2n+jf2dSRpZeOW3F+IdgbMLUmkSMtvIk5ZA/OF/7SweDx46N+AtlCcSSphPFIAtRExX+5Jpadhq1t5x1LxulNhvGdfmjbJd2Y2ojQnUbgaI7BepEszKn663SjTukD+pMrG4j63udGiDT7qif1FJrtNzQzPco1rAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwmT8sKI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XZ7L0Cbm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwmT8sKI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZ7L0Cbm"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIGrQRh3165036
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 17:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MGfq3+o76gasNqjhRUD5fDSxtMn7/maZ/Vlsn3dafG4=; b=VwmT8sKIt895LNEz
	nwSV2POpOiQMw4EJCsVpK5GouVyWWNQZJ1P6cik/hjPgO4GxpurwtjD7LuUnMYb/
	bPWDsi/sXEfi4S4XbTcgu0LrBRo0GYJXljXPaMAy1HqQy46w+FmJZM3bHqzPC1hc
	GkpMr/ezsxZFq8ynz9hbFSU5g5Nh45FC4OBrq+/RBzt2KRz14Obd/pVyhaBNphZB
	R2BBcweU7do7EBFhZTez5gotoEl5BwAluHE2aRi/TUC6HiKkB0RO314WJ2lZZB/K
	cSGPE71k5SWTGHiMbjNPHDdNRjI9/XXy8OccCbSEnVG8YXLYT6lTMfst37Ml9csq
	d1XdFg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agvqgr6y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 17:56:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956cdcdc17so69787215ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763488607; x=1764093407; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGfq3+o76gasNqjhRUD5fDSxtMn7/maZ/Vlsn3dafG4=;
        b=XZ7L0CbmTStiHYc/oaVx1SpJY9k1xATqiPcGCj99kt25xpmDmldnBdDA9GiJ0zPdfS
         jbqeptOSeb7QW70jXfVXG9dJcaE+X6B87ZZT9rZm3IUC92fEch1Aypnlkbjx3P5OLEkM
         WTfEGZFp80FXaG66th73KJrcZ4MKNzVdyiIpTD+B2l7JlZOBpxpSUJnbtIaNafoGAnXL
         UjdmRcsqp4OD7UB8aZqD1wnBJmXKYRahC99yJf733lan8HVDrY5UZiLGSeUwfg4fwUgn
         YBxfHmrvaAEGGM0GQ42VAruQ2pNVyqE2egqHeYKXxkBxRWoBXyP6G77D/rDX/98LrEau
         57Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488607; x=1764093407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGfq3+o76gasNqjhRUD5fDSxtMn7/maZ/Vlsn3dafG4=;
        b=nK/IEm8TsVQLVZY7NAwmymZPhyCh3MN7QFADZg9CVJZGFZqN4ISEkiDkVScQ69NkP3
         kYa1uGskyZUP0TL5LLX+WlVe1CHtEG3xompQKCI+YNrQSfys5RzsOCFWadxV625Qkk9d
         PLhRiEUzFhmK1Zvb1MeepGdqBx63uOnjE7SqX5tOQHEwR54cFMaslTVesgsoTYovVEev
         xwyXUF4jG9zUDZ1mXDZgjDljBlKPTOLES/xYVsWUAIKDZHwxOKSCpb7PEigU4vbxwhWZ
         ZTxhW7Go7hoSwcjn3gpl3i5+c9T/Q+7y5WBRAKOt1UTh8ZhaNWHNHdNMFWhIWEnzn2gG
         UEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWi8bAiKIDtILi0WVOfX34+mwuwvI8EEU0RU6bA2OIHTDSpcxhoXEOH62Ppbxsj66sUwe5p7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YynMK0vz1X0WPTVtZEcpvBIZqSAlZcd7OGbIGBC+y46Cxc8niem
	7la3Sjvn27ZLWmuedqvhSpGKL4HxNNeDLLdqX0F7vA/G0/OSUm9e965wpAFvj32z+TPFH/FMoDv
	lfgQst4ULz7maigp9nV4L3vGFdyxgmhRh2zkiZetl/iFKZB1RaxKCDFyiXQ==
X-Gm-Gg: ASbGncsaam5/bzXPrew/0+8l2V7H+HcR/00AU1Jv9gzYs1MLe7irysCbB+t1LyEsbB0
	l1cM/cEZxZqfxn8bjylEJmy0QIIDJD3RG4mTdZhyIhw9Gh8BnNHYYc1XfIwsUmxXLQA3v+OKzZU
	21ywsm6Z86XkeGmukuTjyVW5eB6iIzuX10eRjq7ykdX8dkGrmsrkTkszmLn/QQm3J33Y04aXyf6
	8Hy5fgtOh6ocU37GR3QYjrumFvYMfNIcd0SIfCLnbST03/CoISzWc1OIqTj1yvU6DI64LwNPN8k
	nKFbj+yrNfaAIZRyr2l+ZXF2zTRMwRgjRCwTFrZorjdfLERdB0Ue+KahHrGUhoRvvfDZwhM4XlY
	kxB2vISF6YMiFeIeY9qLeSsA=
X-Received: by 2002:a17:903:388d:b0:298:8a9:766a with SMTP id d9443c01a7336-2986a76744amr178497635ad.53.1763488606641;
        Tue, 18 Nov 2025 09:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQlMErgROQXlsJJoTVKsYRv9QN0O/2YGJMmSrS6nuYJu/7XEVDBts4CiDzoWr4bcLhtAddlA==
X-Received: by 2002:a17:903:388d:b0:298:8a9:766a with SMTP id d9443c01a7336-2986a76744amr178497255ad.53.1763488606089;
        Tue, 18 Nov 2025 09:56:46 -0800 (PST)
Received: from [192.168.1.13] ([106.222.233.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346b8sm181565255ad.16.2025.11.18.09.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 09:56:45 -0800 (PST)
Message-ID: <dcaaba7e-1073-4900-a4c8-88dac40be434@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 23:26:37 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/22] drm/msm/adreno: Support AQE engine
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
 <20251118-kaana-gpu-support-v4-15-86eeb8e93fb6@oss.qualcomm.com>
 <CACu1E7HzsnSjz0SiUJT0SMNJ7cFhiNdtUE9jKHpvD3UzG6EegQ@mail.gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <CACu1E7HzsnSjz0SiUJT0SMNJ7cFhiNdtUE9jKHpvD3UzG6EegQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XcQYm0QTWoQ8F82PHIgf-Oi1TVLTq-9Z
X-Proofpoint-GUID: XcQYm0QTWoQ8F82PHIgf-Oi1TVLTq-9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0NSBTYWx0ZWRfX89wIlGdKTVbs
 HFdnH93hmPXbWle8aeMRbxow2H86eyuPEfXL/Xi8mOfWyJmrfQWT+SDb8kvjEZemRDoSdelj/wb
 HB3+NcUVqhcct/44lN65gVYoM2ZJmBXZd2xKZscKTrR+kduFlGxv9PsbmFdJcr0EOj78MU9SKwn
 wUaArpRHa94AsuNrn6dL9vBKyLW0/svkOykRIn8S/dCVzrBZ6VIhrokPsPgrEUuOj5FRBsYb8Lo
 hpWYkF2jBpYScoP+Cb9GpO1PO9kXivPRGgPDStXWQfAKAnGaWtodOSjSqBfuhTNXvoZ3/5XMQtD
 oO1h923/obIo7LderZZuurQKj8uJ0hIS214prmOxCUknv40JQfa34kXXfgHx/00qfId2SDhChZd
 pU/H5nxCIWTqlxr0K9dfTQ6MElctlg==
X-Authority-Analysis: v=2.4 cv=LMJrgZW9 c=1 sm=1 tr=0 ts=691cb35f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=/VsID1VB8JbHTH3F2fYZMQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=neJfBgYAGg7YAZYFY1IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180145

On 11/18/2025 9:26 PM, Connor Abbott wrote:
> On Tue, Nov 18, 2025 at 3:53 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
>> in Raytracing related workloads. Add support for loading the AQE firmware
>> and initialize the necessary registers.
>>
>> Since AQE engine has dependency on preemption context records, expose
>> Raytracing support to userspace only when preemption is enabled.
> 
> I guess the plan is to expose MSM_PARAM_AQE later once preemption
> records are in place and for now just load the firmware to ensure that
> people have it?
> 
> The interrupt error handling is still missing, but I guess that can be
> handled later if that's the plan.

Correct. The stale 2nd para in the commit text will be removed when Rob
apply the patches.

-Akhil

> 
> Connor
> 
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 22 ++++++++++++++++++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>>  4 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 810b64b909f5..9a643bcccdcf 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1118,6 +1118,23 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>>                 }
>>         }
>>
>> +       if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
>> +               a6xx_gpu->aqe_bo = adreno_fw_create_bo(gpu,
>> +                       adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iova);
>> +
>> +               if (IS_ERR(a6xx_gpu->aqe_bo)) {
>> +                       int ret = PTR_ERR(a6xx_gpu->aqe_bo);
>> +
>> +                       a6xx_gpu->aqe_bo = NULL;
>> +                       DRM_DEV_ERROR(&gpu->pdev->dev,
>> +                               "Could not allocate AQE ucode: %d\n", ret);
>> +
>> +                       return ret;
>> +               }
>> +
>> +               msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
>> +       }
>> +
>>         /*
>>          * Expanded APRIV and targets that support WHERE_AM_I both need a
>>          * privileged buffer to store the RPTR shadow
>> @@ -2400,6 +2417,11 @@ static void a6xx_destroy(struct msm_gpu *gpu)
>>                 drm_gem_object_put(a6xx_gpu->sqe_bo);
>>         }
>>
>> +       if (a6xx_gpu->aqe_bo) {
>> +               msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
>> +               drm_gem_object_put(a6xx_gpu->aqe_bo);
>> +       }
>> +
>>         if (a6xx_gpu->shadow_bo) {
>>                 msm_gem_unpin_iova(a6xx_gpu->shadow_bo, gpu->vm);
>>                 drm_gem_object_put(a6xx_gpu->shadow_bo);
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index e6218b0b9732..3a054fcdeb4a 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -59,6 +59,8 @@ struct a6xx_gpu {
>>
>>         struct drm_gem_object *sqe_bo;
>>         uint64_t sqe_iova;
>> +       struct drm_gem_object *aqe_bo;
>> +       uint64_t aqe_iova;
>>
>>         struct msm_ringbuffer *cur_ring;
>>         struct msm_ringbuffer *next_ring;
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index c9cd7546024a..e011e80ceb50 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -627,6 +627,9 @@ static int hw_init(struct msm_gpu *gpu)
>>                 goto out;
>>
>>         gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
>> +       if (a6xx_gpu->aqe_iova)
>> +               gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
>> +
>>         /* Set the ringbuffer address */
>>         gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
>>         gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index c496b63ffd41..0aca222c46bc 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -27,6 +27,7 @@ enum {
>>         ADRENO_FW_PFP = 1,
>>         ADRENO_FW_GMU = 1, /* a6xx */
>>         ADRENO_FW_GPMU = 2,
>> +       ADRENO_FW_AQE = 3,
>>         ADRENO_FW_MAX,
>>  };
>>
>>
>> --
>> 2.51.0
>>

