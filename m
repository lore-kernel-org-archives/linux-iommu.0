Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E13F54DF
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160486; cv=none; b=lDDK+noggQ5ijitFAqsClp7rRag/U5FbmnhWU+WWE34jUc7YWUzgh6XvSTpzhUtv1or71VWaNY9HPeDDGLcBprdnLCH5RAZE0Sif3WjHuYB+ikJmPuPlx84JvBdCdVxYKZCEn2Bsxec/ebvvWAvo/1zRCgndVvSmto2cVqu3vNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160486; c=relaxed/simple;
	bh=GUGxPoO5R7lonFmB6Rui3l22EEGIexu+OW62yr5eVbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTs8Kz/DP/EMEVUZ3ewRdoYp8CFvvn2SliFwBeG6CxYmKSENLAh0Ytl0hBGGseNWQqfJDb++P+t7hVHqD9gSIRVIYy8IsK5AEk7DdD4KOiVmRAEbIUmeR+OT7AgOX0mH0sdi1sSmumELzHMk0lOlolpy1exBbbHLYnr5b/2tRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF/SwuyX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF/SwuyX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-449de065cb3so907999f8f.2
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778160481; x=1778765281; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/1d4MNXx8F6WoIg+pWhQR6lyz8UlfDfaD1LAFn90c8=;
        b=bF/SwuyXiY3CTtxoM1cu1hvqB5DPcKGkvmIwxs7Su10BlDLt2ofgs9DPrJkFT6Bxhl
         BI4L0d2CJGpiPD0S9PbisIQsEmZ3oJErNMmFPqcpTsdW9eIHUQcyF5QaNxbHDgjANQr5
         akFN/CUoC9cWhc5CW3x2vSWedDpjNq2f96Bjb0HboN3EyOljILnY8ya4lfDp565BKcqp
         WHOhb8NHGPVA18d5fbzGZzCgZ2lrxsB0mp4lWt/DSX9XoTlrtakO0YL9uVZAjP3ioMJC
         1T3ZV10PJ94Nea7x0VDr68JVvRpPmRp7AykA8AqMG79hsNG5qPNQBWgHXPg3Z3/2ZweY
         +gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160481; x=1778765281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/1d4MNXx8F6WoIg+pWhQR6lyz8UlfDfaD1LAFn90c8=;
        b=K6P+Xw36JH42jxip/iNeL7vhtr77x7nJNv3iaBLFdwXeMuHxqv0H25FgEVwwA2gt5G
         3UjuNNNGLwkT4C5eOm80RLHRLpHR4OdmqLIZsHUkEMVPBMa3q1pjmEFBOWmFr0rgXe3J
         SXytNnaT0bAWR1UeY7S8MTfnm4SKcrOUrmgfHKqbdzkLcNe3X2o1t+SHZfLxWtdVYd26
         7rSKPmsKEhHtTVHqwSAc5JPgfuhmSZW5NqxxeBnYa/SrSWd8WGz8Z4JlFCwbQ9U20t22
         HhpJV6y5k0olp4+iiDuq0mFx+TUObdMXJGQWJKkwVIS+jo0ZcbHO2BlylolUBiC97AyM
         JBJw==
X-Gm-Message-State: AOJu0Yx15FX6lIITp4Qmdho6vJQIFY/PHG4y5O6moKnQJNWSHjZSjQ0O
	k4Hp2wsqmqRLfVYKaaspoW+cABl/FRqf4UVGvREvXv2X7PhALZkbbnk=
X-Gm-Gg: AeBDiesyBBjOMoYvimtv6DWcVvn1W8akdkFCGg3/tC8Gwo72m1vINn6M0G5UJU9w4fI
	eCQN5MJX8oCTnxtG3SlmaVULqbGU0E3Q6HILCSuJM7zoMD/XG/bcLerO3wLIiOhxgTPHAp64gkc
	KDq4PQKNNaQMv7McQhNTmey7yA95d5rV0DTVreZpvWDUapjvM1nTVtJuNQWySnWDj0qFSPqONWv
	s+jV4WcmuIrsDkEuH50d2pDo8lxN8gM935XkwcMpkrZOvp0AmKTTPNGpxGRRIOBmykF6y1kYMsU
	F0u8DYuvDBVzkq+2AhJTlTzhrTOt1Xfv8KeWLnUMo8H8spyrD9rIpCb0EPRUXivRw60dQvGjoaE
	0eI3TPAF8HsTkt4S9sLuMKYOpwLICt/YfNaKuYIDQEymHqNPsSTUUqDrCxQazZ7Jw4vej9cyWez
	0SiyojnnO1UmNKGTdloS6VLJT1ot6/rDYHu2UuzUy2l5EBGe1XbcxJpi75Z0FgjWq5S4w0gpuEB
	DAhv16yHaR5xgQ7jQZY2QpmrMm8FA==
X-Received: by 2002:a5d:588b:0:b0:44b:7ec9:2d76 with SMTP id ffacd0b85a97d-4515b056d5fmr14170290f8f.7.1778160480564;
        Thu, 07 May 2026 06:28:00 -0700 (PDT)
Received: from [192.168.1.17] (host-79-50-55-97.retail.telecomitalia.it. [79.50.55.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055e2d3d0sm20037129f8f.34.2026.05.07.06.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 06:28:00 -0700 (PDT)
Message-ID: <6cc62409-9ca5-4db1-9526-65dd8b88981c@gmail.com>
Date: Thu, 7 May 2026 15:27:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: arm-smmu-qcom: Ensure smmu is powered up in
 set_ttbr0_cfg
To: Xilin Wu <sophon@radxa.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260325-qcom_smmu_pmfix-v2-1-ba769a6ad0be@gmail.com>
 <330D3C56EBC6D08F+3d956321-39de-4308-a977-ad8f7101ed92@radxa.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <330D3C56EBC6D08F+3d956321-39de-4308-a977-ad8f7101ed92@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/26 10:21 AM, Xilin Wu wrote:
> On 3/26/2026 5:11 AM, Anna Maniscalco wrote:
>> Previously the device was being accessed while potentially in a
>> suspended state.
>>
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
> May I ask what is the status of this patch? Without this patch, I can 
> trigger a crash easily on sc8280xp by running fastfetch multiple times.
It's ready on my side so if someone could review I think it could be 
merged.
>
> Tested-by: Xilin Wu <sophon@radxa.com> # sc8280xp-radxa-dragon-q8b
>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

