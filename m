From: Joe Jin <joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] swiotlb: add debugfs to track swiotlb buffer usage
Date: Thu, 6 Dec 2018 22:33:32 -0800
Message-ID: <30439f1e-cf75-0560-8bd4-5ec5cd692aef@oracle.com>
References: <1544068785-20399-1-git-send-email-dongli.zhang@oracle.com>
	<da16ecce-4e25-d246-3e0d-389e8e9e413e@oracle.com>
	<28a9f44a-d1bf-fb34-5a57-cfdb7bb23163@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <28a9f44a-d1bf-fb34-5a57-cfdb7bb23163-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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
To: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/6/18 9:49 PM, Dongli Zhang wrote:
> 
> 
> On 12/07/2018 12:12 AM, Joe Jin wrote:
>> Hi Dongli,
>>
>> Maybe move d_swiotlb_usage declare into swiotlb_create_debugfs():
> 
> I assume the call of swiotlb_tbl_map_single() might be frequent in some
> situations, e.g., when 'swiotlb=force'.
> 
> That's why I declare the d_swiotlb_usage out of any functions and use "if
> (unlikely(!d_swiotlb_usage))".

This is reasonable.

Thanks,
Joe

> 
> I think "if (unlikely(!d_swiotlb_usage))" incur less performance overhead than
> calling swiotlb_create_debugfs() every time to confirm if debugfs is created. I
> would declare d_swiotlb_usage statically inside swiotlb_create_debugfs() if the
> performance overhead is acceptable (it is trivial indeed).
> 
> 
> That is the reason I tag the patch with RFC because I am not sure if the
> on-demand creation of debugfs is fine with maintainers/reviewers. If swiotlb
> pages are never allocated, we would not be able to see the debugfs entry.
> 
> I would prefer to limit the modification within swiotlb and to not taint any
> other files.
> 
> The drawback is there is no place to create or delete the debugfs entry because
> swiotlb buffer could be initialized and uninitialized at very early stage.
> 
>>
>> void swiotlb_create_debugfs(void)
>> {
>> #ifdef CONFIG_DEBUG_FS
>> 	static struct dentry *d_swiotlb_usage = NULL;
>>
>> 	if (d_swiotlb_usage)
>> 		return;
>>
>> 	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
>>
>> 	if (!d_swiotlb_usage)
>> 		return;
>>
>> 	debugfs_create_file("usage", 0600, d_swiotlb_usage,
>> 			    NULL, &swiotlb_usage_fops);
>> #endif
>> }
>>
>> And for io_tlb_used, possible add a check at the begin of swiotlb_tbl_map_single(),
>> if there were not any free slots or not enough slots, return fail directly?
> 
> This would optimize the slots allocation path. I will follow this in next
> version after I got more suggestions and confirmations from maintainers.
> 
> 
> Thank you very much!
> 
> Dongli Zhang
> 
>>
>> Thanks,
>> Joe
>> On 12/5/18 7:59 PM, Dongli Zhang wrote:
>>> The device driver will not be able to do dma operations once swiotlb buffer
>>> is full, either because the driver is using so many IO TLB blocks inflight,
>>> or because there is memory leak issue in device driver. To export the
>>> swiotlb buffer usage via debugfs would help the user estimate the size of
>>> swiotlb buffer to pre-allocate or analyze device driver memory leak issue.
>>>
>>> As the swiotlb can be initialized at very early stage when debugfs cannot
>>> register successfully, this patch creates the debugfs entry on demand.
>>>
>>> Signed-off-by: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  kernel/dma/swiotlb.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 57 insertions(+)
>>>
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index 045930e..d3c8aa4 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -35,6 +35,9 @@
>>>  #include <linux/scatterlist.h>
>>>  #include <linux/mem_encrypt.h>
>>>  #include <linux/set_memory.h>
>>> +#ifdef CONFIG_DEBUG_FS
>>> +#include <linux/debugfs.h>
>>> +#endif
>>>  
>>>  #include <asm/io.h>
>>>  #include <asm/dma.h>
>>> @@ -73,6 +76,13 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>>>   */
>>>  static unsigned long io_tlb_nslabs;
>>>  
>>> +#ifdef CONFIG_DEBUG_FS
>>> +/*
>>> + * The number of used IO TLB block
>>> + */
>>> +static unsigned long io_tlb_used;
>>> +#endif
>>> +
>>>  /*
>>>   * This is a free list describing the number of free entries available from
>>>   * each index
>>> @@ -100,6 +110,41 @@ static DEFINE_SPINLOCK(io_tlb_lock);
>>>  
>>>  static int late_alloc;
>>>  
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>> +static struct dentry *d_swiotlb_usage;
>>> +
>>> +static int swiotlb_usage_show(struct seq_file *m, void *v)
>>> +{
>>> +	seq_printf(m, "%lu\n%lu\n", io_tlb_used, io_tlb_nslabs);
>>> +	return 0;
>>> +}
>>> +
>>> +static int swiotlb_usage_open(struct inode *inode, struct file *filp)
>>> +{
>>> +	return single_open(filp, swiotlb_usage_show, NULL);
>>> +}
>>> +
>>> +static const struct file_operations swiotlb_usage_fops = {
>>> +	.open           = swiotlb_usage_open,
>>> +	.read           = seq_read,
>>> +	.llseek         = seq_lseek,
>>> +	.release        = single_release,
>>> +};
>>> +
>>> +void swiotlb_create_debugfs(void)
>>> +{
>>> +	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
>>> +
>>> +	if (!d_swiotlb_usage)
>>> +		return;
>>> +
>>> +	debugfs_create_file("usage", 0600, d_swiotlb_usage,
>>> +			    NULL, &swiotlb_usage_fops);
>>> +}
>>> +
>>> +#endif
>>> +
>>>  static int __init
>>>  setup_io_tlb_npages(char *str)
>>>  {
>>> @@ -449,6 +494,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>>  		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
>>>  			     sme_active() ? "SME" : "SEV");
>>>  
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	if (unlikely(!d_swiotlb_usage))
>>> +		swiotlb_create_debugfs();
>>> +#endif
>>> +
>>>  	mask = dma_get_seg_boundary(hwdev);
>>>  
>>>  	tbl_dma_addr &= mask;
>>> @@ -528,6 +578,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>>>  	return SWIOTLB_MAP_ERROR;
>>>  found:
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	io_tlb_used += nslots;
>>> +#endif
>>>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>>>  
>>>  	/*
>>> @@ -588,6 +641,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>>>  		 */
>>>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>>>  			io_tlb_list[i] = ++count;
>>> +
>>> +#ifdef CONFIG_DEBUG_FS
>>> +		io_tlb_used -= nslots;
>>> +#endif
>>>  	}
>>>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>>>  }
>>>
>>
>>
