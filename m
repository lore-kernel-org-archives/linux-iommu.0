Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52051E898
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891051; cv=none; b=iFeL8zgp+Ro1oXuEzMe8grM6uluWJ2Zj/u4lQfR5Xm+9aXukiCp3+Er1r8UoXv1hy8OShYMwBclxAgTBV8T2FxO9Z/8Vv8z3Yf7SLKPU9xnpFVsyoKPHnWc85F/EMtir5jI6Tp4KtoevVWHaVKAk1nx9qyYO3yMGo7BxChHtldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891051; c=relaxed/simple;
	bh=SlCd5UMjr7VeKE6v5k9mAv72Tjl/QZqumgOiY6PYPk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AabaI66iD3rEWQxtmECvfYOQleYycOYAMlD3vbjuMqowEPTtlZavezO9Ukm+MGWcRdBH9K3kGNBMlsCuPvME+EcCuxkVD+Yj8hXeFbrYmNkN5x11gM3DycNHBxnjcLxBDEEjwnx/DphhL6nus2N20PeaOxHqPZjzm1qxpAPOUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC76C339;
	Tue, 23 Apr 2024 09:51:16 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 150CA3F7BD;
	Tue, 23 Apr 2024 09:50:46 -0700 (PDT)
Message-ID: <1d72cdc2-7480-4cc9-8299-7f3d4ed7bc63@arm.com>
Date: Tue, 23 Apr 2024 17:50:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
 mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
 joao.m.martins@oracle.com, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
 linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
 <fa1968eb-9ad0-41a4-8259-6c500fc88521@arm.com>
 <20240423163954.GA941030@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240423163954.GA941030@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 17:39, Jason Gunthorpe wrote:
> On Tue, Apr 23, 2024 at 05:27:09PM +0100, Ryan Roberts wrote:
> 
>>>  	switch (smmu_domain->stage) {
>>>  	case ARM_SMMU_DOMAIN_S1:
>>>  		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
>>> -		ias = min_t(unsigned long, ias, VA_BITS);
>>> -		oas = smmu->ias;
>>> +		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
>>
>> I know this isn't changed by this patch, but do we really mean VA_BITS here?
>> Don't we want vabits_actual? I'm guessing we are intending to limit ias to the
>> size the kernel is using.
> 
> I think the intention here is to allow CONFIG_ARM64_VA_BITS to choose
> the number of page table levels in the iommu. 

Hmm ok, got it. But it seems odd...

> Perhaps a SMMU specific
> config option would be clearer.

Yes, it would certainly be clearer. Anyway, I don't think there is any required
action here. Thanks for explaining.

> 
> There is no relationship to the configuration of the S1 paging domain
> and what the MM is doing, there should be no crossing between those
> two worlds.
> 
> vabits_actual is used in the SVA code to match the SMMU SVA S1 to the
> mm_struct.
> 
>>> @@ -3206,6 +3212,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>>>  	if (user_data)
>>>  		return ERR_PTR(-EINVAL);
>>>  
>>> +	if (enforce_dirty &&
>>> +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
>>> +		return ERR_PTR(-EOPNOTSUPP);
>>
>> I'm guessing the intention is that only a stage 1 will ever be marked with
>> IOMMU_CAP_DIRTY_TRACKING (there are a few places that assume/check we are
>> dealing with S1)? But is there a reason why stage 2 can't be supported as well?
> 
> Stage 2 really should ultimately be supported..
> 
> I'd say this is a first step as iommufd will naturally prefer the S1
> configuration when not using nesting. After the nesting support is
> merged the vSMMU will require the S2 to do the dirty tracking.

Yep, ok, so we should plan to support S2 as a later step. Sounds good.

> 
> Jason

