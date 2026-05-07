Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0544B666
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168686; cv=none; b=OSRCA04HKQCd9r9ZIek8CHSOQAyvRFr0U6an+DcqBww15vzfjUaEtVcl1XNOaV/GNpxGEowlmfHUV028LA9XGNN3jwoZtmX4EUAJ3A2gMezCn2dTGmZoblaKqqk7ojRGxNL6vwezjoQc+RECQiOPcxVrs9g3ZfbmYkobOPbyTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168686; c=relaxed/simple;
	bh=/65aTewutdOYYHkLbv4J7oGxKMUrM7GHgTR/87MEjOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCxojjiUsZsvCChwUt0ESl8dTnRcxWnFp7N3PF+5mx3btOLotAoHGGyDIBXyGNbDMGSRYs+/9bc9+igATXIkb/lUC61wBR0dOKLCi92LSCWr99f3jsVMP4AL/a0q0JnvUBSEdusJjHQC4m+UBVu1bnGUqvhgNmGykgv9beMD1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0Jn/xe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0Jn/xe"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso10471265e9.2
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168683; x=1778773483; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSOmSFJwCPNmD4rhxZFAOsBilrO5DsGS6d5uAovPx48=;
        b=MJ0Jn/xexa0APtmgBIuZnGAyDxQk2BUTpgVeAGD1Kc1QJcAnNhKNfpHRRoGDETvuvF
         u4TbLypMQcG0to6SynLuG5Y7qemGjqZAXcWP4ZyW03ZfAmKESQPjz3L3OU77+R0P9NVq
         kAI8+ouMFgAwS6lG4cmfU6CWwjLHXmImRTqPxq2A1gH30/sQR7zzq+I6fyGtFt4XiQdG
         O4BDHb4ltmlJz6L18F5eYRD2n9HvcgXDOSZwvaBdXuANnM+9fn0Ns1PbGLjippZKCBzO
         g7ihYR+qe12TE/lTMvMeYgrGcFQqStrI4E6HFaaXfE3TaWDVa38f7q3YgNVK9ywIasp0
         dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168683; x=1778773483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSOmSFJwCPNmD4rhxZFAOsBilrO5DsGS6d5uAovPx48=;
        b=pZjXho9ov437T7qSDyrpdZovofAB0cnhSpM5aAmM1P7vfZC2vj8Q3CG2xokLqQlYZ/
         iqc8SwEhtnKL3iQhUnO2f3092cB6gxa5gbBuoS3UVRyGNC6LWCeunnSkWun8AHgTm0ZV
         k6FdwWJo2n9NiMNQqqB10F70LsVwXUYaq6AqDBolVVSSe2xcDul1Qb4KHNZEZfTQlfla
         BL1iNWNVwm4rr8Zp70LWxli6ei/fv4jRroU8mJ/rhFrlKMKrMmpeUG7dB/HpIwEfFXA6
         LH/tAd4UoKegtsW9wqhthiIBTNSW85IwuK72NJwMF9pjIHApjfLOan9yr6Wccq+TLctR
         zxkQ==
X-Gm-Message-State: AOJu0YxM/szQG4A20rTm4cpEbuVz9Ab1feblwFRtRx2V4vxFE3DcdZgO
	HDVdAjRQyHlpODKV2/pvZQaHUlV5scXawpjZKfhDfkKuKJb4MlVY/Cc=
X-Gm-Gg: AeBDieteRNm9D4j67XqZcLmTcD8Xyx8o2Z0UXcaFar/X2rXlwH7239niDV6OHw0S8rn
	Jkp9159wd156+9M2AMNEJ3IsFj59p5u1JbFVZTm2Mrlv1ZSUWUheh/wt7DGc3mkHtOdJVQWo7Bk
	BcpqZunO56M9y0dvhj7gCU1OErUadcxPyC60vULPJmG/hjMh2mCf0Mm4+uCENmrYHU9vDevq0xJ
	vXaL8B0mvbg3NJyBc1j0jpkANgahh8JwHhaius1MO2Rm53PUxkE5wG+2pbca4s2HvH4wXBlZaiB
	XcaPSJlqCWz6MXxGejleXgAUw25LMOG2MXOz2+0o+7me+TWPOMaRB6VIzy3nwM1zsh2iO7kW71b
	bP/T85KbCqPqxTlmMCiCanMGqHDE5NKFgQmbv/JuHCLEklVItEjVKPLI7IMGcguFhKGsE5h3VzK
	dnqIq0bUp6ObO+9P0RuvklAgF2L/IACR8guPh5X5BZIU1esS+7xQ6vsR7b6gDYZOvLy5Bpx7Zdo
	HVlhcr5GYB220cjyns=
X-Received: by 2002:a05:600c:2d15:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48e51e16d0bmr83937765e9.8.1778168682869;
        Thu, 07 May 2026 08:44:42 -0700 (PDT)
Received: from [192.168.1.17] (host-79-50-55-97.retail.telecomitalia.it. [79.50.55.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530fe317sm65839805e9.4.2026.05.07.08.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 08:44:42 -0700 (PDT)
Message-ID: <c6e73ca7-fc97-483a-8abf-f2c31407807c@gmail.com>
Date: Thu, 7 May 2026 17:44:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: arm-smmu-qcom: Ensure smmu is powered up in
 set_ttbr0_cfg
To: Robin Murphy <robin.murphy@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260325-qcom_smmu_pmfix-v2-1-ba769a6ad0be@gmail.com>
 <d071cc86-0449-430f-a572-4f43c3440748@arm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <d071cc86-0449-430f-a572-4f43c3440748@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/26 4:47 PM, Robin Murphy wrote:
> On 25/03/2026 9:11 pm, Anna Maniscalco wrote:
>> Previously the device was being accessed while potentially in a
>> suspended state.
>
> The SMMU driver's own write_context_bank() calls all look to be safely 
> within arm_smmu_rpm_get() scopes that are holding an RPM count when 
> relevant (or the one at probe time before RPM is activated at all), so 
> indeed this seems like the appropriate solution for here where we're 
> free to assume that Adreno platforms must always have a power domain.
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> Just a minor nit: it's probably OK in this case (unless Will 
> disagrees), but for future patches, it's preferable for the commit 
> message to be self-contained, so as to give a sufficiently clear 
> description of the problem, and summary of the solution, without 
> having to be read in the context of the title and the whole diff to 
> make sense. For example, if I were writing this I'd put it something 
> like:
>
> "
>   iommu/arm-smmu-qcom: Ensure SMMU is powered up in set_ttbr0_cfg
>
>   arm_smmu_write_context_bank() assumes it is being called with RPM
>   active, but it turns out that is not guaranteed in the path from
>   qcom_adreno_smmu_set_ttbr0_cfg(), so it's possible for the the
>   register accesses to lead to an [external abort/hang/whatever] when
>   [doing whatever it is] while the GPU is idle. Add the RPM calls here
>   to make sure the SMMU is active before we touch it.
> "
>
> Thanks,
> Robin.
Thanks for the feedback, I've sent a v3 with an improved commit message.
>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>> Changes in v2:
>> - Simplify patch by acquiring device just around the call that needs it
>> - Link to v1: 
>> https://lore.kernel.org/r/20260210-qcom_smmu_pmfix-v1-1-78b7143ac053@gmail.com
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 573085349df3..cab7d110aaf5 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -231,6 +231,7 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const 
>> void *cookie,
>>       struct io_pgtable *pgtable = 
>> io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>       struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
>> +    int ret;
>>         /* The domain must have split pagetables already enabled */
>>       if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
>> @@ -260,8 +261,16 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const 
>> void *cookie,
>>           cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
>>       }
>>   +    ret = pm_runtime_resume_and_get(smmu_domain->smmu->dev);
>> +    if (ret < 0) {
>> +        dev_err(smmu_domain->smmu->dev, "failed to get runtime PM: 
>> %d\n", ret);
>> +        return -ENODEV;
>> +    }
>> +
>>       arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
>>   +    pm_runtime_put_autosuspend(smmu_domain->smmu->dev);
>> +
>>       return 0;
>>   }
>>
>> ---
>> base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
>> change-id: 20260210-qcom_smmu_pmfix-2aead2ba4e20
>>
>> Best regards,
>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

