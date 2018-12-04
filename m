From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
	support
Date: Tue, 4 Dec 2018 14:13:31 +0800
Message-ID: <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
	<20181128035449.10226-5-baolu.lu@linux.intel.com>
	<20181203134856.lui4us4ejm4d5avz@8bytes.org>
	<A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D838AB-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 12/4/18 1:23 AM, Liu, Yi L wrote:
> Hi Joerg,
> 
>> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
>> Sent: Monday, December 3, 2018 5:49 AM
>> To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
>> support
>>
>> On Wed, Nov 28, 2018 at 11:54:41AM +0800, Lu Baolu wrote:
>>> -
>>> -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
>> 0);
>>> +	/*
>>> +	 * Need two pages to accommodate 256 descriptors of 256 bits each
>>> +	 * if the remapping hardware supports scalable mode translation.
>>> +	 */
>>> +	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
>>> +				     !!ecap_smts(iommu->ecap));
>>
>>
>> Same here, does the allocation really need GFP_ATOMIC?
> 
> still leave to Baolu.

The existing code uses GFP_ATOMIC, this patch only changes the size of
the allocated desc_page.

I don't think we really need GFP_ATOMIC here (and also for some other
places). I will clean up them in a separated patch.

> 
>>
>>>   struct q_inval {
>>>   	raw_spinlock_t  q_lock;
>>> -	struct qi_desc  *desc;          /* invalidation queue */
>>> +	void		*desc;          /* invalidation queue */
>>>   	int             *desc_status;   /* desc status */
>>>   	int             free_head;      /* first free entry */
>>>   	int             free_tail;      /* last free entry */
>>
>> Why do you switch the pointer to void* ?
> 
> In this patch, there is some code like the code below. It calculates
> destination address of memcpy with qi->desc. If it's still struct qi_desc
> pointer, the calculation result would be wrong.
> 
> +			memcpy(desc, qi->desc + (wait_index << shift),
> +			       1 << shift);
> 
> The change of the calculation method is to support 128 bits invalidation
> descriptors and 256 invalidation descriptors in this unified code logic.
> 
> Also, the conversation between Baolu and me may help.
> 
> https://lore.kernel.org/patchwork/patch/1006756/

Yes. We need to support different descriptor size.

Best regards,
Lu Baolu
