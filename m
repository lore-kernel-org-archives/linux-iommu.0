From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3] vfio/type1: Adopt fast IOTLB flush interface when
 unmap IOVAs
Date: Wed, 24 Jan 2018 11:38:04 +0700
Message-ID: <1fb32e87-80f9-27e0-affe-afed3add7306@amd.com>
References: <1516595377-4681-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20180123150452.03a42c53@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123150452.03a42c53@w520.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Alex/Joerg,

On 1/24/18 5:04 AM, Alex Williamson wrote:
>> +static size_t try_unmap_unpin_fast(struct vfio_domain *domain, dma_addr_t iova,
>> +				   size_t len, phys_addr_t phys,
>> +				   struct list_head *unmapped_regions)
>> +{
>> +	struct vfio_regions *entry;
>> +	size_t unmapped;
>> +
>> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENOMEM;
> size_t is unsigned, so pushing -ENOMEM out though this unsigned
> function and the callee interpreting it as unsigned, means we're going
> to see this as a very large unmap, not an error condition.  Looks like
> the IOMMU API has problems in this space too, ex. iommu_unmap(), Joerg?
> 


I can clean up the APIs to use ssize_t, where it can return errors.

Suravee
