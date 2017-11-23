From: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH kernel] vfio/spapr: Add trace points for map/unmap
Date: Thu, 23 Nov 2017 15:13:37 +1100
Message-ID: <d367b17a-6efa-26a8-821b-42080c90e16e@ozlabs.ru>
References: <20171027030008.17200-1-aik@ozlabs.ru>
	<8c58fcaa-dedc-e6be-44bf-2cb349ef9e38@ozlabs.ru>
	<20171116171301.6552869b@t450s.home>
	<52a19cfb-431f-522b-11de-c1c47f09a4c8@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52a19cfb-431f-522b-11de-c1c47f09a4c8-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Content-Language: en-AU
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shuah Khan <shuahkh-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 17/11/17 17:58, Alexey Kardashevskiy wrote:
> On 17/11/17 11:13, Alex Williamson wrote:
>> On Tue, 14 Nov 2017 10:47:12 +1100
>> Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org> wrote:
>>
>>> On 27/10/17 14:00, Alexey Kardashevskiy wrote:
>>>> This adds trace_map/trace_unmap tracepoints to spapr driver. Type1 already
>>>> uses these via the IOMMU API (iommu_map/__iommu_unmap).
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>  
>>
>> Is this really legitimate to include tracepoints from a different
>> subsystem?>  The vfio type1 backend gets these trace points by virtue of
>> it actually using the IOMMU API, it doesn't call them itself.  I'm kind
>> of surprised these are actually available to be called from a module.
> 
> They are explicitly exported:
> 
> EXPORT_TRACEPOINT_SYMBOL_GPL(map);
> EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);
> 
> I would think this is for things like drivers/vfio/vfio_iommu_spapr_tce.c ,
> why else?...
> 
> 
>> I suspect the way to do this is probably to define our own tracepoints
>> in the vfio/spapr backend or insert tracepoints into the IOMMU layers
>> that that code calls into rather than masquerading as tracepoints from
>> a different subsystem.  Right?
> 
> This makes sense too. But it is going to be just cut-n-paste and some
> confusion -
> /sys/kernel/debug/tracing/events/iommu/map will still be present but
> won't work and
> /sys/kernel/debug/tracing/events/vfio/vfio_iommu_spapr_tce/map will.
> 
> Judges? :)


Still nak? I discussed this locally, the conclusion was it is a matter of
taste and this proposal is not that disgusting. Thanks.


> 
> 
> 
>>  Thanks,
>>
>> Alex
>>
>>>> ---
>>>>
>>>> Example:
>>>>  qemu-system-ppc-8655  [096]   724.662740: unmap:                IOMMU: iova=0x000000003ffff000 size=4096 unmapped_size=4096
>>>>  qemu-system-ppc-8656  [104]   724.970912: map:                  IOMMU: iova=0x0800000000000000 paddr=0x00007ffef7ff0000 size=65536
>>>> ---
>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 12 ++++++++++--
>>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> index 63112c36ab2d..4531486c77c6 100644
>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> @@ -22,6 +22,7 @@
>>>>  #include <linux/vmalloc.h>
>>>>  #include <linux/sched/mm.h>
>>>>  #include <linux/sched/signal.h>
>>>> +#include <trace/events/iommu.h>
>>>>  
>>>>  #include <asm/iommu.h>
>>>>  #include <asm/tce.h>
>>>> @@ -502,17 +503,19 @@ static int tce_iommu_clear(struct tce_container *container,
>>>>  		struct iommu_table *tbl,
>>>>  		unsigned long entry, unsigned long pages)
>>>>  {
>>>> -	unsigned long oldhpa;
>>>> +	unsigned long oldhpa, unmapped, firstentry = entry, totalpages = pages;
>>>>  	long ret;
>>>>  	enum dma_data_direction direction;
>>>>  
>>>> -	for ( ; pages; --pages, ++entry) {
>>>> +	for (unmapped = 0; pages; --pages, ++entry) {
>>>>  		direction = DMA_NONE;
>>>>  		oldhpa = 0;
>>>>  		ret = iommu_tce_xchg(tbl, entry, &oldhpa, &direction);
>>>>  		if (ret)
>>>>  			continue;
>>>>  
>>>> +		++unmapped;
>>>> +
>>>>  		if (direction == DMA_NONE)
>>>>  			continue;
>>>>  
>>>> @@ -523,6 +526,9 @@ static int tce_iommu_clear(struct tce_container *container,
>>>>  
>>>>  		tce_iommu_unuse_page(container, oldhpa);
>>>>  	}
>>>> +	trace_unmap(firstentry << tbl->it_page_shift,
>>>> +			totalpages << tbl->it_page_shift,
>>>> +			unmapped << tbl->it_page_shift);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -965,6 +971,8 @@ static long tce_iommu_ioctl(void *iommu_data,
>>>>  					direction);
>>>>  
>>>>  		iommu_flush_tce(tbl);
>>>> +		if (!ret)
>>>> +			trace_map(param.iova, param.vaddr, param.size);
>>>>  
>>>>  		return ret;
>>>>  	}
>>>>   
>>>
>>>
>>
> 
> 


-- 
Alexey
