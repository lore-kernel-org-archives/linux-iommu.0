Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074F28EF
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 11:42:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7D92B;
	Fri, 27 Jan 2023 03:43:26 -0800 (PST)
Received: from [10.57.88.221] (unknown [10.57.88.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3755B3F64C;
	Fri, 27 Jan 2023 03:42:43 -0800 (PST)
Message-ID: <389082e3-f4c3-4e84-a2d0-629612eed305@arm.com>
Date: Fri, 27 Jan 2023 11:42:27 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/8] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-GB
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com,
 baolu.lu@linux.intel.com
References: <cover.1674753627.git.robin.murphy@arm.com>
 <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
 <20230126152237.2f8b681f@jacob-builder>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230126152237.2f8b681f@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-01-26 23:22, Jacob Pan wrote:
> Hi Robin,
> 
> On Thu, 26 Jan 2023 18:26:20 +0000, Robin Murphy <robin.murphy@arm.com>
> wrote:
> 
>>   
>> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
>> +{
>> +	struct device **alloc_dev = data;
>> +
>> +	if (!dev_iommu_ops_valid(dev))
>> +		return 0;
>> +
>> +	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) !=
>> dev_iommu_ops(*alloc_dev),
>> +		"Multiple IOMMU drivers present, which the public IOMMU
>> API can't fully support yet. You may still need to disable one or more to
>> get the expected result here, sorry!\n"); +
>> +	*alloc_dev = dev;
>> +	return 0;
>> +}
>> +
>>   struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>>   {
>> -	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
>> +	struct device *dev = NULL;
>> +
>> +	/* We always check the whole bus, so the return value isn't
>> useful */
>> +	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
>> +	if (!dev)
>> +		return NULL;
> Since __iommu_domain_alloc_dev() will always return 0, bus_for_each_dev()
> will never breakout until the whole dev list is iterated over. If so, would
> dev only record the last one? i.e. prior results get overwritten.  Maybe a
> misunderstood the logic.

Yes, as the comment points out, the intent is to walk the whole bus to 
check it for consistency. Beyond that, we just need *a* device with 
IOMMU ops; it doesn't matter at all which one it is. It happens to be 
the last one off the list because that's what fell out of writing the 
fewest lines of code.

(You could argue that there's no need to repeat the full walk if the 
WARN_ONCE has already fired, but I'd rather keep the behaviour simple 
and consistent - this is only meant to be a short-term solution, and 
it's not a performance-critical path)

Thanks,
Robin.

> 
>> +	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
> 
> Thanks,
> 
> Jacob
