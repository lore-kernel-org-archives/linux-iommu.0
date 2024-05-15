Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E21553A8
	for <iommu@lists.linux.dev>; Wed, 15 May 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785163; cv=none; b=sSaScuRMgkxria8PLcfbBnNrET56o93WEoR7Ar2ff7d3E9SqXfi2CH/RvxW1IO4ICwpp2A44mpOKBDtD10z4V6cgr463glrkVdMVPAGnDKVDr9ZTvsPppdXgX0AAqfM2/Od8fYocY5XkuQo/AqDziVprt7VA5ipcpGVtn4LnU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785163; c=relaxed/simple;
	bh=dne70KVe5rvpkC5ZaTrqZsZ4NhyJhBOKmob9vFvZ0F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iP2ivuVjGygEEAshqAHXdU/t6GQbXljFtI83R/6gzF7V60xVxDTRkZa+iV3/hosNI2iGIqrXBcmfwafArb6HrYqhCuvxqR+xqKjqNSmPNIUoluCUpD0SHQDYruhNk95tBkvnrlC2wx6CC+vJ4kd4p7ewBEFQt4+bTupPdlu8JCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8A81042;
	Wed, 15 May 2024 07:59:44 -0700 (PDT)
Received: from [10.57.5.6] (unknown [10.57.5.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA1753F7A6;
	Wed, 15 May 2024 07:59:13 -0700 (PDT)
Message-ID: <48c39306-c226-4e7f-a013-d679ca80157e@arm.com>
Date: Wed, 15 May 2024 15:59:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
To: Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
 <243d441d-dda8-442a-a495-83bf9725a14c@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <243d441d-dda8-442a-a495-83bf9725a14c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jon,

On 2024-05-14 2:27 pm, Jon Hunter wrote:
> Hi Robin,
> 
> On 19/04/2024 17:54, Robin Murphy wrote:
>> It's now easy to retrieve the device's DMA limits if we want to check
>> them against the domain aperture, so do that ourselves instead of
>> relying on them being passed through the callchain.
>>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index a3039005b696..f542eabaefa4 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -660,19 +660,16 @@ static void iommu_dma_init_options(struct 
>> iommu_dma_options *options,
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> - * @base: IOVA at which the mappable address space starts
>> - * @limit: Last address of the IOVA space
>>    * @dev: Device the domain is being initialised for
>>    *
>> - * @base and @limit + 1 should be exact multiples of IOMMU page 
>> granularity to
>> - * avoid rounding surprises. If necessary, we reserve the page at 
>> address 0
>> + * If the geometry and dma_range_map include address 0, we reserve 
>> that page
>>    * to ensure it is an invalid IOVA. It is safe to reinitialise a 
>> domain, but
>>    * any change which could make prior IOVAs invalid will fail.
>>    */
>> -static int iommu_dma_init_domain(struct iommu_domain *domain, 
>> dma_addr_t base,
>> -                 dma_addr_t limit, struct device *dev)
>> +static int iommu_dma_init_domain(struct iommu_domain *domain, struct 
>> device *dev)
>>   {
>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +    const struct bus_dma_region *map = dev->dma_range_map;
>>       unsigned long order, base_pfn;
>>       struct iova_domain *iovad;
>>       int ret;
>> @@ -684,18 +681,18 @@ static int iommu_dma_init_domain(struct 
>> iommu_domain *domain, dma_addr_t base,
>>       /* Use the smallest supported page size for IOVA granularity */
>>       order = __ffs(domain->pgsize_bitmap);
>> -    base_pfn = max_t(unsigned long, 1, base >> order);
>> +    base_pfn = 1;
>>       /* Check the domain allows at least some access to the device... */
>> -    if (domain->geometry.force_aperture) {
>> +    if (map) {
>> +        dma_addr_t base = dma_range_map_min(map);
>>           if (base > domain->geometry.aperture_end ||
>> -            limit < domain->geometry.aperture_start) {
>> +            dma_range_map_max(map) < domain->geometry.aperture_start) {
>>               pr_warn("specified DMA range outside IOMMU capability\n");
>>               return -EFAULT;
>>           }
>>           /* ...then finally give it a kicking to make sure it fits */
>> -        base_pfn = max_t(unsigned long, base_pfn,
>> -                domain->geometry.aperture_start >> order);
>> +        base_pfn = max(base, domain->geometry.aperture_start) >> order;
>>       }
>>       /* start_pfn is always nonzero for an already-initialised domain */
>> @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 
>> dma_base, u64 dma_limit)
>>        * underlying IOMMU driver needs to support via the dma-iommu 
>> layer.
>>        */
>>       if (iommu_is_dma_domain(domain)) {
>> -        if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>> +        if (iommu_dma_init_domain(domain, dev))
>>               goto out_err;
>>           dev->dma_ops = &iommu_dma_ops;
>>       }
> 
> 
> I have noticed some random test failures on Tegra186 and Tegra194 and 
> bisect is pointing to this commit. Reverting this along with the various 
> dependencies does fix the problem. On Tegra186 CPU hotplug is failing 
> and on Tegra194 suspend is failing. Unfortunately, on neither platform 
> do I see any particular crash but the boards hang somewhere.

That is... thoroughly bemusing :/ Not only is there supposed to be no 
real functional change here - we should merely be recalculating the same 
information from dev->dma_range_map that the callers were already doing 
to generate the base/limit arguments - but the act of initially setting 
up a default domain for a device behind an IOMMU should have no 
connection whatsoever to suspend and especially not to CPU hotplug.

> If you have any ideas on things we can try let me know.

Since the symptom seems inexplicable, I'd throw the usual memory 
debugging stuff like KASAN at it first. I'd also try 
"no_console_suspend" to check whether any late output is being missed in 
the suspend case (and if it's already broken, then any additional issues 
that may be caused by the console itself hopefully shouldn't matter).

For more base-covering, do you have the "arm64: Properly clean up 
iommu-dma remnants" fix in there already as well? That bug has bisected 
to patch #6 each time though, so I do still suspect that what you're 
seeing is likely something else. It does seem potentially significant 
that those Tegra platforms are making fairly wide use of dma-ranges, but 
there's no clear idea forming out of that observation just yet...

Thanks,
Robin.
