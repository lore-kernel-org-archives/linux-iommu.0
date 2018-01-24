From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3] vfio/type1: Adopt fast IOTLB flush interface when
	unmap IOVAs
Date: Wed, 24 Jan 2018 17:00:18 +0700
Message-ID: <abb9f471-9a77-85f7-4afb-a46b86f4e11a@amd.com>
References: <1516595377-4681-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20180123150452.03a42c53@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180123150452.03a42c53-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Alex / Joerg,

On 1/24/18 5:04 AM, Alex Williamson wrote:
>> @@ -648,12 +685,40 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>>   	return i > npage ? npage : (i > 0 ? i : -EINVAL);
>>   }
>>   
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
>> +
>> +	unmapped = iommu_unmap_fast(domain->domain, iova, len);
>> +	if (WARN_ON(!unmapped)) {
>> +		kfree(entry);
>> +		return -EINVAL;
>> +	}
> Not sure about the handling of this, the zero check is just a
> consistency validation.  If there's nothing mapped where we think there
> should be something mapped, we warn and throw out the whole vfio_dma.
> After this patch, such an error gets warned twice, which doesn't
> really seem to be an improvement.
> 

Since iommu_unmap() and iommu_unmap_fast() can return errors, instead of just zero check,
we should also check for errors, warn, and bail out the whole vfio_dma.

Thanks,
Suravee
