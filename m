Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61A187554
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550228; cv=none; b=BEbQg/MNsi0NKVdX71sEn6btuQLL/ID44eUkG3ekP8lgBzdsZroJUZe2k/WMb5Zud4AJ6kiVtOuaFfBvc7xHWyikMmvf7CT0ieLIHrpqUoxBVpm9rOQYwy7i+C69BD6HhKB96rVU4iXThLL61Mr292TBNOVjY1EWsH0QJ03U6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550228; c=relaxed/simple;
	bh=0h9DecTC/wgE/rnQTdT1OO7GVXnGWIxwfqx97IXDET8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4u65Uju1cniIRJnXVskGTwN/QHDjmxidh6AGXZpgOs3ZYsEzGG3RY/HNMR5QbgeOLMtzYHI0YHJnCpgPRvmeig6KhoBpD6fRSrBi2+I1P0YFI6p8JUtuPMV4WvkU7atHpky0gkd9rK39cy567wdbglbuWkcyz/IdJmPkHBmmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DE4112FC;
	Tue, 13 Aug 2024 04:57:31 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15D7F3F73B;
	Tue, 13 Aug 2024 04:57:03 -0700 (PDT)
Message-ID: <e5a8e78e-2459-453a-b3b7-e1ed2ca4addc@arm.com>
Date: Tue, 13 Aug 2024 12:57:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
To: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-3-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240812205255.97781-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2024 9:52 pm, Mostafa Saleh wrote:
> Previously, S2 stall was disabled and in case there was an event it
> wouldn't be reported on the assumption that it's always pinned  by VFIO.
> 
> However, now since we can enable stall, devices that use S2 outside
> VFIO should be able to report the stalls similar to S1.
> 
> Also, to keep the old behaviour were S2 events from nested domains were
> not reported as they are pinned (from VFIO) add a new flag to track this.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8d573d9ca93c..ffa865529d73 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>   	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
>   	struct iopf_fault fault_evt = { };
>   	struct iommu_fault *flt = &fault_evt.fault;
> +	struct arm_smmu_domain *smmu_domain;
>   
>   	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
>   	case EVT_ID_TRANSLATION_FAULT:
> @@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* Stage-2 is always pinned at the moment */
> -	if (evt[1] & EVTQ_1_S2)
> -		return -EFAULT;
> -
>   	if (!(evt[1] & EVTQ_1_STALL))
>   		return -EOPNOTSUPP;
>   
> @@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>   		goto out_unlock;
>   	}
>   
> +	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
> +	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));
> +
> +	/* nesting domain is always pinned at the moment */
> +	if (smmu_domain->enable_nesting) {

Ugh, has the whole enable_nesting method still not gone away already?

However, at least for now, isn't this functionally equivalent to just 
testing !(smmu->features & ARM_SMMU_FEAT_TRANS_S1) anyway? We still 
won't be able to differentiate a nominally-pinned non-nested VFIO domain 
from a nominally-stallable non-VFIO domain on S2-only hardware.

Thanks,
Robin.

> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>   	iommu_report_device_fault(master->dev, &fault_evt);
>   out_unlock:
>   	mutex_unlock(&smmu->streams_mutex);
> @@ -3373,8 +3379,10 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
>   	mutex_lock(&smmu_domain->init_mutex);
>   	if (smmu_domain->smmu)
>   		ret = -EPERM;
> -	else
> +	else {
>   		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> +		smmu_domain->enable_nesting = true;
> +	}
>   	mutex_unlock(&smmu_domain->init_mutex);
>   
>   	return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 0dc7ad43c64c..f66efeec2cf8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -745,6 +745,8 @@ struct arm_smmu_domain {
>   	spinlock_t			devices_lock;
>   
>   	struct mmu_notifier		mmu_notifier;
> +
> +	bool				enable_nesting;
>   };
>   
>   /* The following are exposed for testing purposes. */
