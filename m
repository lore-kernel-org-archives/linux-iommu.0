Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428052FDC5E
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769579803; cv=none; b=TOlw8OwwhcxB4S5uHgj84d4zhCCiV5MaummJxn9ruDU0QIdtxnCd597HtnSWaN0IC12wr+u1AZRXBZcScIpQ++uNxDAs1qICOtOHaq4SezevElIJ5okhvF9D1NbkwJ5F48b+fXpRIS9F+92jGw5Iv/IPEPhw39xN18sO9n/MTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769579803; c=relaxed/simple;
	bh=MaI+0yBlwt4eAVcrUGbCmqxstJPGVJMSBHTq9aLCdgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEcmmmLvmdIZ8Xbo/HWFc2/9BJwAxyCMR+qoG0uFkEWndDnPe2N7LDdFJQ3C34AEH+t5lqzotWePME5akFKOF6BAKHBOQOwqzC1LdBQkCCuQRnnMK7DafiRc3eV+vzBX/Ev7YQsWun46UKmtrDceoRQLQXmtloq3CRI2hDPxZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9dyKXwr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NziJy/AR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9dyKXwr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NziJy/AR"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S3X4462728766
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 05:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uYR9kTxk5UBFhydzzD4L7yS3eDix4nvw8qLgcmQmCsQ=; b=C9dyKXwrWjyNujv2
	g0L4IuCICrpcjYDgG9zjgAc6OJfsBk0R/OTSrUplHk84RnYo0C2c3WwYR/WaMB4p
	Y/wT3Tv9n1l0kP88kHQlU85n0F/12H4QF4BssHzFHSJjxOX0ru0WvoEk3XcAcJZL
	ypPW6DDe2XiQM8jm5d65HbG/Ymb/MnfU3+cz8hgBwq7lsz/aU1jIQWbxEg3/DOM5
	sjY1uYo82Gvn5DoLWjeLK6Kt+EaGaPM4YDQC5WzQobytF7/MRZ36CXos5MqDWvlN
	3xMgtqEkaFAr4fyCbZ47Ibja8D+QxmbL4cLz06NFD43GiwnRAxgpL9bvOiI1Nm8Z
	tBV4qw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byanagbwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 05:56:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c38781efcso6085006a91.2
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 21:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769579799; x=1770184599; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYR9kTxk5UBFhydzzD4L7yS3eDix4nvw8qLgcmQmCsQ=;
        b=NziJy/ARatrjKijVUbFdZS3BxfX8JXfmT5JgOUmIpgyrGowg/2IA7VU/IIh1CQUfFR
         Ze7Po81H2P5kLkqmrIKJqbKqUHBd9WVoNVK107jsIPZ5OeZ1oKK8C0AuRwTE29ht2zoS
         7hZYCyUbKXNBbaN2zAQMgFDxP1OmqryYUG4dbKnt6CpBpEupNenYkIkVwZWRebhpkp6r
         hAVeucY5UM+EFWWr1GBkvDbMffXPumKIvttHue0eoXOXU9WTC92zrJrCNb6flprXTf+L
         0H1oLhSTQKrgsqXqvnmk6goHZhf1szepHNMgky04VMV4NABrJVwZVG/53t6SDyDPTeXY
         yYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769579799; x=1770184599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYR9kTxk5UBFhydzzD4L7yS3eDix4nvw8qLgcmQmCsQ=;
        b=VbguFXzAZGvLlWwOEl2cXB9kruNJCxXBsQFwtcp7FExn2YwYqpmCc9Gcz5XtjX0WPa
         9H7cBssKOo5vtFFuE/2Luj1rrkD3kKtXrWJLWhi05Bc11v+cnydNy7FU+ls1hCBSsU0y
         jTt8Hj4DPeyOv+4c4+Mzmjtl36XK7l3tCrEun6oH6HDjL25tAbx2++XNRkQudUr8qlgQ
         ca/6NC9KMoeGz/YSMTBRQR8SB8ID8nN6N4CIuVHccJ3qNF6I8SQjPFeqjfn7I4kOWJu9
         gu90+qrdpze4JXhmz2uYVrVBGUIBUkWMmmnP478n7Qs2U4sHyN/mCMGC0fnGp1AnijOP
         9prQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm/7+NeTcFg/pg9kcJNU72w2Zg/FAODfVPCxxNqDpJS05tp3PZ6X7wrrMMcfDgDw4diLgVxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAckwqpqkbTkXextacxXeQpJ73uKXoded1E2xC0n/4ZyVCYSgQ
	n2XFT6HnyoGyW3Z7O6eqEq4dYWgSGYLkBJ6XjVB8FRa9tIsdzoYDweaFBiVIRprEH7OVEF3LNct
	8L9bne7geYF8IK7Sqx98j+AO2YwVBppg34JHgIRo6fjhl3YepM58HAN1APg==
X-Gm-Gg: AZuq6aJtlOz0LNS+pzAg9JAn3SDgqpk6JTcAMaE5SEMmQ5uzoHW/kZTebzT4Cg9GEch
	153LahhR5tAP6zNhtAtdgM37iHdAE3h6uaPQq/tsdVK1J+U+WAas4cfXTKEfYYv2oufC7/bAqhJ
	9netsrdBlN/bv4OiNDRq/7mobGKFJ2heoINvuQnNVEOeK5q4MUS68LlYUxZs4GvLOnKHqpJbFog
	R9mKhoMp+jUWvQeS3gfsJQHVLSFq5/covTojR4QaIVZ5xKk5YL1xgsbAAuSiIdB40Foid4AjYFL
	mujsaYt9qZVFDljC5JcrJI6TundOOevVOK//vmYtJMrAamoUTmFxSfzome4Zo8DTkjnHErnm8Zw
	Yc+DiP4cGpHQBnXpmLcpDKT8MoPMsMB3lG/D5SV3H
X-Received: by 2002:a17:90b:3a4f:b0:352:e27e:79c5 with SMTP id 98e67ed59e1d1-353feda98damr3425992a91.31.1769579798662;
        Tue, 27 Jan 2026 21:56:38 -0800 (PST)
X-Received: by 2002:a17:90b:3a4f:b0:352:e27e:79c5 with SMTP id 98e67ed59e1d1-353feda98damr3425979a91.31.1769579798059;
        Tue, 27 Jan 2026 21:56:38 -0800 (PST)
Received: from [10.219.57.215] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f405ceasm1122081a91.17.2026.01.27.21.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 21:56:37 -0800 (PST)
Message-ID: <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 11:26:33 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
Content-Language: en-US
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
In-Reply-To: <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: if_UJi5GIZS8RsfRJOCIvtHrI_TWCoH0
X-Proofpoint-ORIG-GUID: if_UJi5GIZS8RsfRJOCIvtHrI_TWCoH0
X-Authority-Analysis: v=2.4 cv=N58k1m9B c=1 sm=1 tr=0 ts=6979a517 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Jg306G9I-f7xxtujTVEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NSBTYWx0ZWRfX9toSAhRknZEp
 XGHD11vZjwmw5AECpvrwn9whVUVqHizffXT6s68to5PlV9/XpI7QY9Hi0dDEtAoIVbYgtCQtnbo
 jiauReglFOQI9vTh2kxruR/Yg9qdJh//v087irkzrnatsFNiiA/ip0VXzOTknYtavBQuuUsVYlF
 tmONIXoU9qCnGKlZpz7zukG6VAekKisNDQn8Qknt1/vTg+xBPRAmeE9ex7q9BQYlNngyWzGaDVr
 AmlFWRvv10Dbf8Ja2x9azxHN6oBpWjBpN1s/NxhJ+TCXoqtxbLuVsIl2/9KR7JR153usfG/bj0K
 sViUDfZ/l+GE5mgSh8U89eAU7duHa/8mghVKGV/k25ZiCaaGqgnTpGoh2dqTPeJDKw2JCHqELlp
 HUldG+pL+Hzvjf6gIITkU5S6nQ3nkD/srs7zYLdHm7pkWicU42cpsPbfkkyxu5pewACxVkkf7aN
 PmaSHdo1WoyKosxW0UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280045


On 1/27/2026 9:35 PM, Robin Murphy wrote:
> On 2026-01-27 12:11 pm, Prakash Gupta wrote:
>> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the
>> driver")
>> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
>> sits in a power domain, all register accesses must be done while the
>> device is runtime-resumed to avoid unclocked register reads and
>> potential NoC errors.
>>
>> So far, this has not been an issue for most SMMU clients because
>> stall-on-fault is enabled by default. While a translation fault is
>> being handled, the SMMU stalls further translations for that context
>> bank, so the fault handler would not race with a powered-down
>> SMMU.
>>
>> Adreno SMMU now disables stall-on-fault in the presence of fault
>> storms to avoid saturating SMMU resources and hanging the GMU. With
>> stall-on-fault disabled, the SMMU can generate faults while its power
>> domain may no longer be enabled, which makes unclocked accesses to
>> fault-status registers in the SMMU fault handlers possible.
>
> At face value, that sounds wrong - how does an SMMU generate a fault,
> or indeed do anything, when it's powered off? In principle it's
> possible that the SMMU might signal an interrupt, and is _then_
> suspended (with the interrupt line somehow remaining asserted, so
> probably more clock-gated than completely powered down) before the
> interrupt hander runs, but we rather assume that we're not going to
> have an unhandled hardware IRQ hanging around for longer than the
> autosuspend delay.
>
> So, judging by the diff below, I guess what you really mean is that in
> the case of a threaded context IRQ handler, it can take long enough
> between handling the hardware IRQ and the thread actually running that
> the SMMU may have suspended in between? 

You are correct that the SMMU cannot generate a fault while powered
down. A more accurate description of the race condition is as follows:
When stall-on-fault is disabled, the faulting transaction does is
terminated. This allows the master (the GPU) to complete its work, drop
its power vote for the SMMU, and allow the SMMU to suspend. However, the
SMMU fault handler may still be waiting to execute on the CPU.
If the SMMU suspends before the handler reads the fault registers, an
unclocked access occurs. This scenario is significantly more likely when
using threaded IRQs due to the scheduling latency involved. I will
update the next iteration to reflect this.

>
>> Guard the context and global fault handlers with arm_smmu_rpm_get() /
>> arm_smmu_rpm_put() so that all SMMU fault register accesses are done
>> with the SMMU powered.
>>
>> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault
>> after a page fault")
>> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
>> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
>> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  5 ++-
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      | 53
>> ++++++++++++++++++++++--------
>>   2 files changed, 43 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 573085349df3..2d03df72612d 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -317,6 +317,7 @@ static int qcom_adreno_smmu_init_context(struct
>> arm_smmu_domain *smmu_domain,
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>       const struct of_device_id *client_match;
>> +    const struct arm_smmu_impl *impl = qsmmu->data->impl;
>>       int cbndx = smmu_domain->cfg.cbndx;
>>       struct adreno_smmu_priv *priv;
>>   @@ -350,10 +351,12 @@ static int
>> qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>       priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
>>       priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
>>       priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
>> -    priv->set_stall = qcom_adreno_smmu_set_stall;
>>       priv->set_prr_bit = NULL;
>>       priv->set_prr_addr = NULL;
>>   +    if (impl->context_fault_needs_threaded_irq)
>> +        priv->set_stall = qcom_adreno_smmu_set_stall;
>> +
>>       if (of_device_is_compatible(np, "qcom,smmu-500") &&
>>           !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
>>           of_device_is_compatible(np, "qcom,adreno-smmu")) {
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 5e690cf85ec9..183f12e45b02 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -462,10 +462,23 @@ static irqreturn_t arm_smmu_context_fault(int
>> irq, void *dev)
>>       int idx = smmu_domain->cfg.cbndx;
>>       int ret;
>>   +    if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq) {
>
> Why is this conditional on being threaded, if the global fault handler
> that can never be threaded at all apparently needs it unconditionally? 
Synchronous runtime PM calls can sleep, which would cause issue if
called within a hard IRQ context. This is why I added the conditional
check for threaded IRQs.
Furthermore, this change only allow the driver to override the
stall-on-fault setting when context_fault_needs_threaded_irq is true.
Since the unclocked access issue is tied to disabling stall-on-fault,
the fix is only logically required for the threaded IRQ path.
For the Global Fault handler, which runs in a hard IRQ context, you are
right—we cannot safely vote for power there. I will remove the runtime
PM call from that section.
>
> Thanks,
> Robin.
>
>> +        ret = arm_smmu_rpm_get(smmu);
>> +        if (ret < 0)
>> +            return IRQ_NONE;
>> +    }
>> +
>> +    if (smmu->impl && smmu->impl->context_fault) {
>> +        ret = smmu->impl->context_fault(irq, dev);
>> +        goto out_power_off;
>> +    }
>> +
>>       arm_smmu_read_context_fault_info(smmu, idx, &cfi);
>>   -    if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
>> -        return IRQ_NONE;
>> +    if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT)) {
>> +        ret = IRQ_NONE;
>> +        goto out_power_off;
>> +    }
>>         ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
>>           cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE :
>> IOMMU_FAULT_READ);
>> @@ -480,7 +493,14 @@ static irqreturn_t arm_smmu_context_fault(int
>> irq, void *dev)
>>                     ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
>>       }
>>   -    return IRQ_HANDLED;
>> +    ret = IRQ_HANDLED;
>> +
>> +out_power_off:
>> +
>> +    if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
>> +        arm_smmu_rpm_put(smmu);
>> +
>> +    return ret;
>>   }
>>     static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>> @@ -489,14 +509,21 @@ static irqreturn_t arm_smmu_global_fault(int
>> irq, void *dev)
>>       struct arm_smmu_device *smmu = dev;
>>       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>>                         DEFAULT_RATELIMIT_BURST);
>> +    int ret;
>> +
>> +    ret = arm_smmu_rpm_get(smmu);
>> +    if (ret < 0)
>> +        return IRQ_NONE;
>>         gfsr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSR);
>>       gfsynr0 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR0);
>>       gfsynr1 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR1);
>>       gfsynr2 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR2);
>>   -    if (!gfsr)
>> -        return IRQ_NONE;
>> +    if (!gfsr) {
>> +        ret = IRQ_NONE;
>> +        goto out_power_off;
>> +    }
>>         if (__ratelimit(&rs)) {
>>           if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
>> @@ -513,7 +540,11 @@ static irqreturn_t arm_smmu_global_fault(int
>> irq, void *dev)
>>       }
>>         arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
>> -    return IRQ_HANDLED;
>> +    ret = IRQ_HANDLED;
>> +
>> +out_power_off:
>> +    arm_smmu_rpm_put(smmu);
>> +    return ret;
>>   }
>>     static void arm_smmu_init_context_bank(struct arm_smmu_domain
>> *smmu_domain,
>> @@ -683,7 +714,6 @@ static int arm_smmu_init_domain_context(struct
>> arm_smmu_domain *smmu_domain,
>>       enum io_pgtable_fmt fmt;
>>       struct iommu_domain *domain = &smmu_domain->domain;
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -    irqreturn_t (*context_fault)(int irq, void *dev);
>>         mutex_lock(&smmu_domain->init_mutex);
>>       if (smmu_domain->smmu)
>> @@ -850,19 +880,14 @@ static int arm_smmu_init_domain_context(struct
>> arm_smmu_domain *smmu_domain,
>>        */
>>       irq = smmu->irqs[cfg->irptndx];
>>   -    if (smmu->impl && smmu->impl->context_fault)
>> -        context_fault = smmu->impl->context_fault;
>> -    else
>> -        context_fault = arm_smmu_context_fault;
>> -
>>       if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
>>           ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
>> -                        context_fault,
>> +                        arm_smmu_context_fault,
>>                           IRQF_ONESHOT | IRQF_SHARED,
>>                           "arm-smmu-context-fault",
>>                           smmu_domain);
>>       else
>> -        ret = devm_request_irq(smmu->dev, irq, context_fault,
>> IRQF_SHARED,
>> +        ret = devm_request_irq(smmu->dev, irq,
>> arm_smmu_context_fault, IRQF_SHARED,
>>                          "arm-smmu-context-fault", smmu_domain);
>>         if (ret < 0) {
>>
>> ---
>> base-commit: fcb70a56f4d81450114034b2c61f48ce7444a0e2
>> change-id: 20251208-smmu-rpm-8bd67db93dca
>>
>> Best regards,
>> -- 
>> Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>>
>
