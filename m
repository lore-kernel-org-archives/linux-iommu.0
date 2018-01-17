From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC PATCH v2 1/2] vfio/type1: Adopt fast IOTLB flush interface
 when unmap IOVAs
Date: Wed, 17 Jan 2018 23:54:40 +0700
Message-ID: <966d7407-d91f-f652-454d-bbda263567ba@amd.com>
References: <1514366435-12723-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1514366435-12723-2-git-send-email-suravee.suthikulpanit@amd.com>
 <20180108135329.3c1e2c88@t450s.home> <20180108140718.5ce48492@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180108140718.5ce48492@t450s.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On 1/9/18 4:07 AM, Alex Williamson wrote:
>>> @@ -661,6 +705,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>>   	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
>>>   		return 0;
>>>   
>>> +	INIT_LIST_HEAD(&unmapped_regions);
>>> +
>>>   	/*
>>>   	 * We use the IOMMU to track the physical addresses, otherwise we'd
>>>   	 * need a much more complicated tracking system.  Unfortunately that
>>> @@ -698,24 +744,36 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>>   				break;
>>>   		}
>>>   
>>> -		unmapped = iommu_unmap(domain->domain, iova, len);
>>> -		if (WARN_ON(!unmapped))
>>> +		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>>> +		if (!entry)
>>>   			break;
> 
> Turns out this nagged at me a bit too, this function only gets called
> once to dump the vfio_dma, so bailing out here leaves pages pinned and
> IOMMU mappings in place, for a performance optimization that we could
> just skip.  We could sync&unpin anything collected up to this point and
> continue this step with a synchronous unmap/unpin.  Thanks,

Ah, that's an over look in my part also. Thanks for catching this. I'll implement
the fallback mechanism per your suggestion in v3.

Thanks,
Suravee
