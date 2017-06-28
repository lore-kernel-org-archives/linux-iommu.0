From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/9] iommu: Introduce iommu do invalidate API function
Date: Wed, 28 Jun 2017 18:07:32 +0100
Message-ID: <00a5fe10-98bb-f018-06b6-29af22d014eb@arm.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1498592883-56224-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20170628100823.GG14532@8bytes.org>
	<20170628090952.0bebd2b3@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170628090952.0bebd2b3@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28/06/17 17:09, Jacob Pan wrote:
> On Wed, 28 Jun 2017 12:08:23 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Tue, Jun 27, 2017 at 12:47:57PM -0700, Jacob Pan wrote:
>>> From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>
>>> When a SVM capable device is assigned to a guest, the first level
>>> page tables are owned by the guest and the guest PASID table
>>> pointer is linked to the device context entry of the physical IOMMU.
>>>
>>> Host IOMMU driver has no knowledge of caching structure updates
>>> unless the guest invalidation activities are passed down to the
>>> host. The primary usage is derived from emulated IOMMU in the
>>> guest, where QEMU can trap invalidation activities before pass them
>>> down the host/physical IOMMU. There are IOMMU architectural
>>> specific actions need to be taken which requires the generic APIs
>>> introduced in this patch to have opaque data in the
>>> tlb_invalidate_info argument.  
>>
>> Which "IOMMU architectural specific actions" are you thinking of?
>>
> construction of queued invalidation descriptors, then submit them to
> the IOMMU QI interface.
>>> +int iommu_invalidate(struct iommu_domain *domain,
>>> +		struct device *dev, struct tlb_invalidate_info
>>> *inv_info) +{
>>> +	int ret = 0;
>>> +
>>> +	if (unlikely(!domain->ops->invalidate))
>>> +		return -ENODEV;
>>> +
>>> +	ret = domain->ops->invalidate(domain, dev, inv_info);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_invalidate);  
>>
>> [...]
>>
>>> +struct tlb_invalidate_info {
>>> +	__u32	model;
>>> +	__u32	length;
>>> +	__u8	opaque[];
>>> +};  
>>
>> This interface is aweful. It requires the user of a generic api to
>> know details about the implementation behind to do anything useful.
>>
>> Please explain in more detail why this is needed. My feeling is that
>> we can make this more generic with a small set of invalidation
>> functions in the iommu-api.
>>
> My thinking was that via configuration control, there will be unlikely
> any mixed IOMMU models between pIOMMU and vIOMMU. We could have just
> model specific data pass through layers of SW (QEMU, VFIO) for
> performance reasons. We do have an earlier hybrid version that has
> generic data and opaque raw data. Would the below work for all IOMMU
> models?

For reference, this was also discussed in the initial posting of the series:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03452.html

At least for ARM SMMUv2 and v3, I think the invalidation format you
propose should be sufficient, although "device_selective" should probably
be "domain_selective". And maybe a flag field could contain relatively
generic hints such as "only invalidate leaf table when page_selective".

Thanks,
Jean

> https://www.spinics.net/lists/kvm/msg148798.html
> 
> struct tlb_invalidate_info
> {
>         __u32   model;  /* Vendor number */
>         __u8 granularity
> #define DEVICE_SELECTVIE_INV    (1 << 0)
> #define PAGE_SELECTIVE_INV      (1 << 0)
> #define PASID_SELECTIVE_INV     (1 << 1)
>         __u32 pasid;
>         __u64 addr;
>         __u64 size;
> 
>         /* Since IOMMU format has already been validated for this table,
>            the IOMMU driver knows that the following structure is in a
>            format it knows */
>         __u8 opaque[];
> };
> 
>>
>>
>> 	Joerg
>>
> 
> [Jacob Pan]
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
