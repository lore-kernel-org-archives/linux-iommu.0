Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8568C09;
	Thu, 30 Mar 2023 18:24:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C3C2F4;
	Thu, 30 Mar 2023 11:24:47 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D3F33F663;
	Thu, 30 Mar 2023 11:24:01 -0700 (PDT)
Message-ID: <5966bdf2-2a1a-2970-9f18-784b88f2f687@arm.com>
Date: Thu, 30 Mar 2023 19:23:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to
 one function
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
 <ZCWsdjM/21IPvjKi@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZCWsdjM/21IPvjKi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-30 16:36, Jason Gunthorpe wrote:
> On Thu, Mar 30, 2023 at 08:37:16PM +0800, Baolu Lu wrote:
>> On 2023/3/30 7:40, Jason Gunthorpe wrote:
>>> +/**
>>> + * iommu_setup_default_domain - Set the default_domain for the group
>>> + * @group: Group to change
>>> + * @target_type: Domain type to set as the default_domain
>>> + *
>>> + * Allocate a default domain and set it as the current domain on the group. If
>>> + * the group already has a default domain it will be changed to the target_type.
>>> + * When target_type is 0 the default domain is selected based on driver and
>>> + * system preferences.
>>> + */
>>> +static int iommu_setup_default_domain(struct iommu_group *group,
>>> +				      int target_type)
>>> +{
>>> +	struct group_device *gdev;
>>> +	struct iommu_domain *dom;
>>> +	struct bus_type *bus =
>>> +		list_first_entry(&group->devices, struct group_device, list)
>>> +			->dev->bus;
>>> +	int ret;
>>> +
>>> +	lockdep_assert_held(&group->mutex);
>>> +
>>> +	target_type = iommu_get_default_domain_type(group, target_type);
>>> +	if (target_type < 0)
>>> +		return -EINVAL;
>>> +
>>> +	if (group->default_domain && group->default_domain->type == target_type)
>>> +		return 0;
>>> +
>>> +	dom = __iommu_domain_alloc(bus, target_type);
>>> +	if (!dom && target_type != IOMMU_DOMAIN_DMA) {
>>> +		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
>>> +		if (dom)
>>> +			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>>> +				target_type, group->name);
>>> +	}
>>
>> The background of the code above is that some ARM IOMMU drivers only
>> support DMA mapping domain and do not support identity domain.
>> Therefore, during boot, if the allocation of identity domain fails, a
>> DMA mapping domain is used instead.
> 
> Er, this is doing two things then because it also allows DMA_FQ to
> degrade to just DMA..

Same thing really; generally the point is that any of the more "special" 
default domain types set with the broad brush of Kconfig or command-line 
can cleanly fall back to the basic type wherever it turns out that 
there's a less-capable driver (or, eventually, IOMMU instance) present.

> I changed it like this:
> 
> 	dom = __iommu_domain_alloc(bus, req_type);
> 	if (!dom && !target_type &&
> 	    (req_type == IOMMU_DOMAIN_IDENTITY ||
> 	     req_type == IOMMU_DOMAIN_DMA_FQ)) {
> 		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
> 
> So the auto selection only happens if the target_type is not automatic.

You mean "is automatic"? I'm missing how target_type and req_type are 
related here, but the general principle should be that if we have 
derived the type from iommu_def_domain_type, because we had nothing more 
specific from either a sysfs request or iommu_get_def_domain_type(), 
then a !IOMMU_DOMAIN_DMA failure can retry with IOMMU_DOMAIN_DMA. 
Otherwise any failure should be final.

Strictly that's not quite what the current code does, since 
iommu_alloc_default_domain() is losing the iommu_get_def_domain_type() 
vs. iommu_def_domain_type distinction, but in the former case a driver's 
.def_domain_type should definitely not be returning a type which that 
driver doesn't support, thus allocation failure would only really 
represent unexpected OOM conditions, where the retry would likely fail 
as well, and the whole system is probably dying anyway. If we're 
refactoring the whole lot, though, we may as well make it logically 
consistent.

Thanks,
Robin.

>> However, this does not apply to use cases that change the default domain
>> through sysfs. In such cases, it seems that we should directly return
>> failure (-ENODEV) and tell the user that the iommu driver does not
>> support identity domain.
> 
> And with the fix below it will return ENODEV rather than autoselect DMA.
> 
>>> +	/*
>>> +	 * There are still some drivers which don't support default domains, so
>>> +	 * we ignore the failure and leave group->default_domain NULL.
>>> +	 *
>>> +	 * We assume that the iommu driver starts up the device in
>>> +	 * 'set_platform_dma_ops' mode if it does not support default domains.
>>> +	 */
>>> +	if (!dom) {
>>> +		ret = 0;
>>> +		goto out_set;
>>> +	}
>>
>> Should we call set_platform_dma_ops here?
> 
> It could be done and should be harmless, but the driver is supposed to
> start up in that mode so don't need to explicitly enter it when
> plugging the device.. I kept things as-is
> 
>> The existing default domain
>> (if exists) will be freed below. But the iommu driver doesn't know about
>> this. It probably will create a UAF case?
> 
> This is a bug:
> 
> 	if (!dom) {
> 		/* Once in default_domain mode we never leave */
> 		if (group->default_domain)
> 			return -ENODEV;
> 
> So default_domain is either NULL forever or set to something forever.
> 
> Jason
