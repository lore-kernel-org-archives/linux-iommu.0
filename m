Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16318B645
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597499; cv=none; b=YazCcozMdek9QJ+cLw7/CrvYN8cmroHGa3Q9oZnRt/gkr4IiRQL2bJUUoieCb5RJC0/xde2ydWiB0fMOcGkRdaqRiEP69Ne2bvNCZGhay/MzcBPKhzcuUgMterBqFyvbE6LcPM+A9yVNOn/aUpGsgViND8pw8L34F2a9z+3Sb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597499; c=relaxed/simple;
	bh=duMliVfODqvhjdQ1uxUHADGh50JDWIymCOnDnXEXdeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCWi2DCP+QdJpHWXHdFKBHygRNmF4+f7xTyk0wpWuwDfsc4viWtQqeVhr3d6rlfI0OQnCupULXHc3pWP0rKvJpHen/zbOKSEePMRTkZKgHhOQk5mh+D4wzVpKgauJjpYgsF9Qnd4ljuWykZtKskudQMQxNcljtMq+t1PJaGiZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07083106F;
	Fri, 28 Jun 2024 10:58:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE473F6A8;
	Fri, 28 Jun 2024 10:58:15 -0700 (PDT)
Message-ID: <a232872a-be56-4806-a3f6-09c889fa777a@arm.com>
Date: Fri, 28 Jun 2024 18:58:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
 <903594d3-00c3-42f8-8003-eef30f110510@arm.com>
 <73e03875-cb36-4846-a3e5-c715a4c23869@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <73e03875-cb36-4846-a3e5-c715a4c23869@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 6:08 pm, Vasant Hegde wrote:
> Hi Robin,
> 
> On 6/28/2024 6:36 PM, Robin Murphy wrote:
>> On 28/06/2024 1:23 pm, Baolu Lu wrote:
>>> On 2024/6/28 14:43, Vasant Hegde wrote:
>>>> We are working on adding domain_alloc_paging() support in AMD driver and came
>>>> across below issue.
>>>>
> 
> .../...
> 
>>> Add an allocation flag seems to work. It doesn't indicate any type of
>>> domain. Instead, it indicates the required iommu feature.
>>>
>>> Something like
>>>
>>> #define DOMAIN_ALLOC_FLAG_PASID        0x1
>>>
>>> means the allocated domain requires PASID to support on both device and
>>> IOMMU. If the hardware lacks this support, it should return failure.
>>
>> Yeah, we could do with something sufficiently general, as we'll also have a need
>> for passing pagetable-format options through to drivers to be able to replace
>> iommu_set_pgtable_quirks().
> 
> Sorry. I doubt I understood it completely. You mean to say:
> Enhance iommu_domain_alloc() such that caller can pass any special quirks they
> need and then pass those quirk flag along with the other flags we need (like
> PASID support or not) to indivisual driver? So that at the end we are remove
> ops->set_pgtable_quirks().
> 
> Is that what you are thinking or something else?

Basically, what set_pgtable_quirks does currently will need to be known 
at domain_alloc_paging time in order to convert arm-smmu to the latter 
properly. You don't need to worry about the public interface for it just 
yet, but if we're going to start extending the driver-level interface 
already then it would be good to plan ahead for what other domain 
properties we may want to accommodate callers requesting. The things we 
have as io-pgtable quirks today are definite ones (and those would 
happen to be OK as simple flags), but it's always seemed like a good 
idea for callers to be able to indicate their preference for other 
things like VA size (or even full domain geometry), even perhaps 
specific io-pgtable formats, such that the IOMMU driver can make the 
most effective choice about what it actually allocates.

Thanks,
Robin.
