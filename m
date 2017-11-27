From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] vfio/type1: Adopt fast IOTLB flush interface when
	unmap IOVAs
Date: Mon, 27 Nov 2017 15:14:59 +0700
Message-ID: <b26ed4cb-4c87-7357-e3e6-460545df5f03@amd.com>
References: <1510953080-5619-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1510953080-5619-2-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20171117145152.41fae930@t450s.home>
	<20171117212040.7f0921a0@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171117212040.7f0921a0-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On 11/18/17 11:20 AM, Alex Williamson wrote:
> On Fri, 17 Nov 2017 14:51:52 -0700
> Alex Williamson<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrote:
> 
>> On Fri, 17 Nov 2017 15:11:19 -0600
>> Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>  wrote:
>>
>>> From: Suravee Suthikulpanit<suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>>
>>> VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
>>> IOTLB flushing for every unmapping. This results in large IOTLB flushing
>>> overhead when handling pass-through devices with a large number of mapped
>>> IOVAs (e.g. GPUs).
>> Of course the type of device is really irrelevant, QEMU maps the entire
>> VM address space for any assigned device.
>>
>>> This can be avoided by using the new IOTLB flushing interface.
>>>
>>> Cc: Alex Williamson<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> Cc: Joerg Roedel<jroedel-l3A5Bk7waGM@public.gmane.org>
>>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/vfio/vfio_iommu_type1.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>> index 92155cc..28a7ab6 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -698,10 +698,12 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>>   				break;
>>>   		}
>>>   
>>> -		unmapped = iommu_unmap(domain->domain, iova, len);
>>> +		unmapped = iommu_unmap_fast(domain->domain, iova, len);
>>>   		if (WARN_ON(!unmapped))
>>>   			break;
>>>   
>>> +		iommu_tlb_range_add(domain->domain, iova, len);
>>> +
>> We should only add @unmapped, not @len, right?
> Actually, the problems are deeper than that, if we can't guarantee that
> the above iommu_unmap_fast has removed the iommu mapping, then we can't
> do the unpin below as that would potentially allow the device access to
> unknown memory.  Thus, to support this, the unpinning would need to be
> pushed until after the sync and we therefore need some mechanism of
> remembering the phys addresses that we've unmapped.  Thanks,
> 
> Alex
>   

If so, I am planning to use a list to temporary store information for 
unmapped regions to be unpinned after sync.  Please lemme know if that 
would be alright.

Suravee
