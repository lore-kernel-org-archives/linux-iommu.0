Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605715ADA0
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963566; cv=none; b=P2NjoBTSBl3c3aVQcWkAhTzSnHgeEg8wfYwgbvoS8VbiCa7LDzrUKxNVavA8mhICqqrGJULZVwYP84xOnSNNDxkgIistFtR9fwOcGzkdprwTqGrfswKccUdcKUOndizY24vUP2Dx5m+ZbLgNSc0rpYBE0VdlXRG5i7xc6fEHhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963566; c=relaxed/simple;
	bh=i4/lVHQi1npTdUhA/Y2vuex7hmmO0rGzst0Lj6c70uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYhenW4GMC7R4+nF5Uh9yopLbOp7f/fch0Ya0xUBvFkMnF0qHrb+rz3EyGJN1PFdtLwCuKKWy0nfHvCMdMHQcLaQD647adBrL60PzwJmChycERRuBvM9M6Z7GglTrIhduE+wgMMcjcuRRkuDvPI0KjwePxSbNAJKnftRBYV6hK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 364531516;
	Wed, 24 Apr 2024 05:59:52 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B843F64C;
	Wed, 24 Apr 2024 05:59:22 -0700 (PDT)
Message-ID: <cd4dd0a3-3da4-4a22-8b59-56b812530619@arm.com>
Date: Wed, 24 Apr 2024 13:59:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
 mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
 joao.m.martins@oracle.com, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
 linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
 <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
 <20240424122349.GH941030@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240424122349.GH941030@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 13:23, Jason Gunthorpe wrote:
> On Wed, Apr 24, 2024 at 11:04:43AM +0100, Ryan Roberts wrote:
>> On 23/04/2024 15:52, Jason Gunthorpe wrote:
>>> On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
>>>> Hi,
>>>>
>>>> I'm aiming to (slowly) get more involved with SMMU activities, although I'm sure
>>>> it will take a while to get up to speed and provide useful input. It was
>>>> suggested that this series would be a useful starting point to dip my toe in.
>>>> Please bear with me while I ask stupid questions...
>>>
>>> Nice!
>>>
>>> I would like to see this merged as it was part of the original three
>>> implementations for iommufd dirty tracking. The other two have been
>>> merged for a long time now..
>>
>> My understanding is that this series should pretty much apply on top of
>> mainline, is that correct? (in practice there are some conflicts, but I think
>> they are trivial).
> 
> It was originally based on my part 2, but I suspect it could apply
> easially on top of part 2a. I don't think it is worth rebasing to
> v6.9-rc since I expect Will to take 2a.
> 
>> I don't think it depends on anything new in your smmuv3_newapi branch?
> 
> I feel part 2a is done, hopefully Will will take it soon:
> 
>   https://lore.kernel.org/linux-iommu/0-v8-4c4298c63951+13484-smmuv3_newapi_p2_jgg@nvidia.com/
> 
> There are quite a few distros waiting on this:
> 
>   https://lore.kernel.org/linux-iommu/cover.1712977210.git.nicolinc@nvidia.com/

Great thanks for the links. I'll aim to start working through from this one
onwards as an when I can.

> 
> The cmdq area is not something I've studied deeply
> 
> I will be reposting the latter half of this as a part 2b:
> 
>   https://lore.kernel.org/linux-iommu/0-v6-228e7adf25eb+4155-smmuv3_newapi_p2_jgg@nvidia.com/
> 
> Which is the prerequisite for the part 3 series to enable nested
> translation an vSMMUv3 for iommufd.
> 
> Nested translation and a few more bits is prerequisite to finally enable BTM:
> 
>   https://lore.kernel.org/linux-iommu/20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com/
> 
> Thanks,
> Jason

