Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A06D24;
	Thu, 30 Mar 2023 14:29:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE502F4;
	Thu, 30 Mar 2023 07:29:51 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773613F663;
	Thu, 30 Mar 2023 07:29:05 -0700 (PDT)
Message-ID: <559f8b71-6636-b4b8-27c4-bd0764baa741@arm.com>
Date: Thu, 30 Mar 2023 15:29:00 +0100
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
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-03-30 13:37, Baolu Lu wrote:
> On 2023/3/30 7:40, Jason Gunthorpe wrote:
>> +/**
>> + * iommu_setup_default_domain - Set the default_domain for the group
>> + * @group: Group to change
>> + * @target_type: Domain type to set as the default_domain
>> + *
>> + * Allocate a default domain and set it as the current domain on the 
>> group. If
>> + * the group already has a default domain it will be changed to the 
>> target_type.
>> + * When target_type is 0 the default domain is selected based on 
>> driver and
>> + * system preferences.
>> + */
>> +static int iommu_setup_default_domain(struct iommu_group *group,
>> +                      int target_type)
>> +{
>> +    struct group_device *gdev;
>> +    struct iommu_domain *dom;
>> +    struct bus_type *bus =
>> +        list_first_entry(&group->devices, struct group_device, list)
>> +            ->dev->bus;
>> +    int ret;
>> +
>> +    lockdep_assert_held(&group->mutex);
>> +
>> +    target_type = iommu_get_default_domain_type(group, target_type);
>> +    if (target_type < 0)
>> +        return -EINVAL;
>> +
>> +    if (group->default_domain && group->default_domain->type == 
>> target_type)
>> +        return 0;
>> +
>> +    dom = __iommu_domain_alloc(bus, target_type);
>> +    if (!dom && target_type != IOMMU_DOMAIN_DMA) {
>> +        dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
>> +        if (dom)
>> +            pr_warn("Failed to allocate default IOMMU domain of type 
>> %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>> +                target_type, group->name);
>> +    }
> 
> The background of the code above is that some ARM IOMMU drivers only
> support DMA mapping domain and do not support identity domain.
> Therefore, during boot, if the allocation of identity domain fails, a
> DMA mapping domain is used instead.
> 
> However, this does not apply to use cases that change the default domain
> through sysfs. In such cases, it seems that we should directly return
> failure (-ENODEV) and tell the user that the iommu driver does not
> support identity domain.
> 
>> +
>> +    /*
>> +     * There are still some drivers which don't support default 
>> domains, so
>> +     * we ignore the failure and leave group->default_domain NULL.
>> +     *
>> +     * We assume that the iommu driver starts up the device in
>> +     * 'set_platform_dma_ops' mode if it does not support default 
>> domains.
>> +     */
>> +    if (!dom) {
>> +        ret = 0;
>> +        goto out_set;
>> +    }
> 
> Should we call set_platform_dma_ops here? The existing default domain
> (if exists) will be freed below. But the iommu driver doesn't know about
> this. It probably will create a UAF case?
> 
>> +
>> +    ret = __iommu_group_set_domain_internal(group, dom,
>> +                        IOMMU_SET_DOMAIN_WITH_DEFERRED);
>> +    if (ret) {
>> +        /*
>> +         * An attach_dev failure may result in some devices being left
>> +         * attached to dom. This is not cleaned up until release_device
>> +         * is called. Thus we can't always free dom on failure, we have
>> +         * no choice but to stick the broken domain into
>> +         * group->default_domain to defer the free and try to continue.
>> +         */
>> +        if (list_count_nodes(&group->devices) > 1)
>> +            goto out_set;
>> +
>> +        iommu_domain_free(dom);
>> +        dom = NULL;
>> +        goto out_set;
>> +    }
>> +
>> +    /* The domain must be attached before we can establish any 
>> mappings */
>> +    for_each_group_device(group, gdev)
>> +        iommu_create_device_direct_mappings(dom, gdev->dev);
> 
> It's better to move creating direct mappings before setting the domain
> to the group devices.
> 
> The VT-d platforms allow the firmware to access the memory regions
> defined in RMRR ACPI table. If we set an empty domain to the device
> while the firmware DMA accesses the RMRR memory, it might result in
> spurious DMA faults.

Yes, logically IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions 
*must* be mapped before their device is attached, in order to guarantee 
continuity. Yes, this means the RMR stuff for Arm SMMU still isn't truly 
working properly - it still needs domain_alloc fixing to get rid of the 
whole horrible "finalise on first attach" idiom, which sadly I haven't 
had time to get back to yet :(

Thanks,
Robin.

> 
>> +
>> +out_set:
>> +    if (group->default_domain)
>> +        iommu_domain_free(group->default_domain);
>> +    group->default_domain = dom;
>> +    return ret;
>> +}
> 
> Best regards,
> baolu
