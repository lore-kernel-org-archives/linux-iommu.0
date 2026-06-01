Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47333689F
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303329; cv=none; b=MEMR+2zjomlDEmjBFDO5aR13ShPUdSDlq7VJUfPv3X7HSPfuWLlD9jlsbf4JKWEHnprGQfRCs9cRmLlij+7IvBY420qFcovsMtJGaxxdm+Uu00or9d0jsJiQZYA15bXR/phtNgaUhIPs/nQvi4CkniNSyCnkt6xs+dBlpib6lOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303329; c=relaxed/simple;
	bh=87UhcpT4ALaMLm33WeuvGbVnab+p7ZlH+/OIyT4u91g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naHkMhMiZlTGt8QzYunE0VI0bcm2yWxFOhJTOvWDOGbNYqs3RpbBf8rdTHI/M7/FQZCCzvLBCPBARI5eFyybxiruHLrvonmxGC4tz7cksT9iZ83mXxwflloUqONPjZ0xDi3FUYZ/LjmwI4OQoYCb5vzfbshWOTGlIFNwNpyxfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NchrHrVA; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NchrHrVA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780303323; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=klc98YH+ItkJ3emUHfiBibK7AzKrV+4NC80O7N82uMI=;
	b=NchrHrVAOlNkQqxS9xpjEbJzuGfLZzbfuWcEsvXyuIq/uMsFeV0QMdJXliR2h0XjNdK48Z90MR4bR5qPwEsTcGmKbQSJa4ps60ktaI9OtWhwzdjfWm/AiNzhwuw32jBt754wvkXjyx7Yde8x8kdH4HxDiPqCUXl+j95WPh6BMdg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X3zThL._1780303309;
Received: from 30.221.133.117(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3zThL._1780303309 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Jun 2026 16:42:00 +0800
Message-ID: <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
Date: Mon, 1 Jun 2026 16:41:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com,
 alikernel-developer <alikernel-developer@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260531235148.GV2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/6/1 7:51, Jason Gunthorpe 写道:
> On Sun, May 31, 2026 at 05:36:29PM +0800, Guanghui Feng wrote:
>> Add iova_to_phys_length callback to struct iommu_domain_ops alongside
>> the existing iova_to_phys. The new callback returns both the physical
>> address and the PTE mapping page size in a single page table walk.
>>
>> Add iommu_iova_to_phys_length() core function that:
>> - Checks ops->iova_to_phys_length first (preferred path)
>> - Falls back to ops->iova_to_phys for unmigrated drivers
>>
>> This enables callers like VFIO to efficiently traverse IOVA space
>> by actual mapping granularity instead of fixed PAGE_SIZE steps.
>>
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
>> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
>> ---
>>   drivers/iommu/iommu.c | 34 ++++++++++++++++++++++++++++++++--
>>   include/linux/iommu.h |  9 +++++++++
>>   2 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d1a9e713d3a0..43323229a1df 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_detach_group);
>>   
>> -phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>> +/**
>> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
>> + * @domain: IOMMU domain to query
>> + * @iova: IO virtual address to translate
>> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
>> + *
>> + * Like iommu_iova_to_phys() but additionally returns the page size of the
>> + * PTE mapping at @iova through @mapped_length.
>> + *
>> + * Return: The physical address for the given IOVA, or 0 if no translation.
>> + */
> When introducing the new function I would like to fix this 0 error as
> well, it should return PHYS_MAX for error

Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)

all use a return value of 0 as an invalid state, so 0 is used as the 
representation

of an invalid state to maintain compatibility.

>
>> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
>> +				       dma_addr_t iova,
>> +				       size_t *mapped_length)
>>   {
>> +	if (mapped_length)
>> +		*mapped_length = 0;
>> +
>>   	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>>   		return iova;
>>   
>>   	if (domain->type == IOMMU_DOMAIN_BLOCKED)
>>   		return 0;
> Any domain that doesn't have an op should fail, blocked is one example

In accordance with the implementation of iommu_iova_to_phys, it returns 
a phy value of 0 in invalid states.

>
>>   
>> -	return domain->ops->iova_to_phys(domain, iova);
>> +	if (domain->ops->iova_to_phys_length)
>> +		return domain->ops->iova_to_phys_length(domain, iova,
>> +							mapped_length);
>> +
>> +	/* Fallback to legacy iova_to_phys without length info */
>> +	if (domain->ops->iova_to_phys)
>> +		return domain->ops->iova_to_phys(domain, iova);
> If it falls back it should return something sensible for the length.
>
> I suggest you approach the patch plan a little differently, the first
> patches should implement the new function and an iommput
> implementation
>
> Arrange things so the normal iova_to_phys calls the new function if it
> is available and discards the length.
>
> Then convert callers that can take advantage of it. Have the fallback
> path also compute the length by iterating internally.
>
> Finally one patch per driver implementing the new op, this could even
> be a second series.
>
> Don't remove iova_to_phys(), it is fine for things that don't need the
> length.

Does this mean retaining the iommu_iova_to_phys implementation but

implementing it through domain->ops->iova_to_phys_length (mapped_length 
is NULL)?

>
> Jason
