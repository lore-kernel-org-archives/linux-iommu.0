Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153598635C
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802492; cv=none; b=EZTQeiVwxmF9dpUjxAYHjGCRMn1rLpy7gR+EsOUNhqt/LOMaT+P/k+ip9TZ6l8z5bW+99bWrI/X9PjofTCtlup791YPRZXK9q/OZoJJ4Kg15bw2a1PLyaDsgsQvn/1+LSEkmhKsywFKqenLVk6tRd9OHyyBXjd5b+S2DDKsvQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802492; c=relaxed/simple;
	bh=uRflT48LDo87dXTO3uCvWWt1Fp9+tNIQrODhVV9dMWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKtKioyzYKLwFP196AciJZYPO6/FTpUBHUE5Zzwxx9lKL8f+/lXI1+uMzbsEFVOYX6TW/j3dm+P8X2F8z3s16mGm8YhZWveN//m5wrwnd3NZMjgO1+ZZC+yPwiW9KUC92jQ2HODG1zZ4d/WcgVL66lPhFcwC4AR6TvpYPz9fiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93D41515;
	Wed, 12 Mar 2025 11:01:39 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE553F5A1;
	Wed, 12 Mar 2025 11:01:27 -0700 (PDT)
Message-ID: <2d47815d-6bee-4d1f-8b60-854763794bf6@arm.com>
Date: Wed, 12 Mar 2025 18:01:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] iommu/arm-smmu: Save additional information on
 context fault
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-1-be14be37f4c3@gmail.com>
 <20250311180553.GB5216@willie-the-truck>
 <CACu1E7GzCiO2b7AFJSDC+pN2VD9VaD2aYz_GGymM3-xAUqd__A@mail.gmail.com>
 <20250312130525.GC6181@willie-the-truck>
 <CAF6AEGvqYithLFAKpfdkw35DEsUZ8rBt25-oWz3r=kaLt+RbQw@mail.gmail.com>
 <20250312164735.GA6561@willie-the-truck>
 <CAF6AEGskyoemQDrTXh=ewf61e-hVzWMjmqe=nX2J-65W5-M6Zw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAF6AEGskyoemQDrTXh=ewf61e-hVzWMjmqe=nX2J-65W5-M6Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2025 5:23 pm, Rob Clark wrote:
> On Wed, Mar 12, 2025 at 9:47 AM Will Deacon <will@kernel.org> wrote:
>>
>> On Wed, Mar 12, 2025 at 07:59:52AM -0700, Rob Clark wrote:
>>> On Wed, Mar 12, 2025 at 6:05 AM Will Deacon <will@kernel.org> wrote:
>>>> On Tue, Mar 11, 2025 at 06:36:38PM -0400, Connor Abbott wrote:
>>>>> On Tue, Mar 11, 2025 at 2:06 PM Will Deacon <will@kernel.org> wrote:
>>>>>> On Tue, Mar 04, 2025 at 11:56:47AM -0500, Connor Abbott wrote:
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>> index ade4684c14c9b2724a71e2457288dbfaf7562c83..a9213e0f1579d1e3be0bfba75eea1d5de23117de 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>>>>> @@ -409,9 +409,12 @@ void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
>>>>>>>                                      struct arm_smmu_context_fault_info *cfi)
>>>>>>>   {
>>>>>>>        cfi->iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
>>>>>>> +     cfi->ttbr0 = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_TTBR0);
>>>>>>>        cfi->fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>>>>>>> -     cfi->fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
>>>>>>> +     cfi->fsynr0 = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
>>>>>>> +     cfi->fsynr1 = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR1);
>>>>>>
>>>>>> We already have an implementation hook (->get_fault_info()) which the
>>>>>> qcom SMMU driver can override with qcom_adreno_smmu_get_fault_info().
>>>>>> That thing dumps these registers already so if we're moving that into
>>>>>> the core SMMU driver, let's get rid of the hook and move everybody over
>>>>>> rather than having it done in both places.
>>>>>
>>>>> As you probably saw, the next commit moves over
>>>>> qcom_adreno_smmu_get_fault_info() to use this. The current back door
>>>>> used by drm/msm to access these functions is specific to adreno_smmu
>>>>> and there isn't an equivalent interface to allow it to call a generic
>>>>> SMMU function so it isn't possible to move it entirely to the core. At
>>>>> least not without a bigger refactoring that isn't justified for this
>>>>> series that is just trying to fix things.
>>>>
>>>> Ok :(
>>>>
>>>>>>>        cfi->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
>>>>>>> +     cfi->contextidr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_CONTEXTIDR);
>>>>>>
>>>>>> I think the CONTEXTIDR register is stage-1 only, so we shouldn't dump
>>>>>> it for stage-2 domains.
>>>>>>
>>>>> Does it matter if we read the register though, as long as users are
>>>>> aware of this and don't use its value for anything?
>>>>
>>>> I think the contents are "UNKNOWN", so it could be hugely confusing even
>>>> if they just got logged someplace. Why is it difficult to avoid touching
>>>> it for stage-2?
>>>>
>>> Fwiw, we are only ever using stage-1
>>
>> Sure, but this is in arm-smmu.c which is used by other people and supports
>> both stages.
> 
> Sure, but no one else is using this field in the fault-info.  So maybe
> the addition of a comment in the struct would be enough if it isn't
> going to cause an SError/etc to read it for S2 cb?

Any worthwhile comment isn't going to be significantly shorter or 
clearer than 1 extra line of "if (smmu_domain->stage == 
ARM_SMMU_DOMAIN_S1)"...

TBH it's the Qualcomm register-middle-man firmware I'd be more worried 
about than real hardware, given how touchy it can be even with register 
accesses which *should* be well defined. But then I guess it also has 
the habit of killing the system if anything other than the GPU dares 
cause a fault in the first place, so maybe it OK?

If anyone still uses Arm Fast Models SMMUv1/2 components it'll probably 
squawk an annoying warning there too - ISTR I had at least one patch 
motivated by that in the past.

Thanks,
Robin.
