From: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
Date: Fri, 4 Jan 2019 09:34:33 +0800
Message-ID: <98fdfb0c-0207-9a0a-4875-b834cfd1b2c3@oracle.com>
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
	<41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
	<34883ba5-b444-3d37-4d40-9b0a651dd2eb@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <34883ba5-b444-3d37-4d40-9b0a651dd2eb-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, Joe Jin <joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Konrad,

Would you please take a look on those two patches?

In addition, there is another patch correcting an error in comment.

https://lkml.org/lkml/2018/12/5/1721

Thank you very much!

Dongli Zhang

On 12/11/2018 05:05 AM, Joe Jin wrote:
> On 12/10/18 12:00 PM, Tim Chen wrote:
>>> @@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>>>  	return SWIOTLB_MAP_ERROR;
>>>  found:
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	io_tlb_used += nslots;
>>> +#endif
>> One nit I have about this patch is there are too many CONFIG_DEBUG_FS.
>>
>> For example here, instead of io_tlb_used, we can have a macro defined,
>> perhaps something like inc_iotlb_used(nslots).  It can be placed in the
>> same section that swiotlb_create_debugfs is defined so there's a single
>> place where all the CONFIG_DEBUG_FS stuff is located.
>>
>> Then define inc_iotlb_used to be null when we don't have
>> CONFIG_DEBUG_FS.
>>
> 
> Dongli had removed above ifdef/endif on his next patch, "[PATCH v2 2/2]
> swiotlb: checking whether swiotlb buffer is full with io_tlb_used"
> 
> Thanks,
> Joe
> 
