From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Patch Part3 V5 5/8] iommu/vt-d: Enhance intel_irq_remapping
	driver to support DMAR unit hotplug
Date: Tue, 16 Sep 2014 16:13:47 +0800
Message-ID: <5417F13B.7030500@linux.intel.com>
References: <1410487848-6027-1-git-send-email-jiang.liu@linux.intel.com>
	<1410487848-6027-6-git-send-email-jiang.liu@linux.intel.com>
	<54164D01.4060003@huawei.com> <5417E00D.5000108@linux.intel.com>
	<5417EC7B.4060400@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5417EC7B.4060400-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2014/9/16 15:53, Yijing Wang wrote:
> On 2014/9/16 15:00, Jiang Liu wrote:
>> On 2014/9/15 10:20, Yijing Wang wrote:
>>>> +static void ir_remove_ioapic_hpet_scope(struct intel_iommu *iommu)
>>>> +{
>>>> +	int i;
>>>>  
>>>> -			ir_parse_one_hpet_scope(scope, iommu);
>>>> -		}
>>>> -		start += scope->length;
>>>> -	}
>>>> +	for (i = 0; i < MAX_HPET_TBS; i++)
>>>> +		if (ir_hpet[i].iommu == iommu)
>>>> +			ir_hpet[i].iommu = NULL;
>>>
>>> Hi Gerry, why not reset whole ir_hpe and ir_ioapic data struct?
>> Hi Yijing,
>> 	Thanks for review. Zero is legal for id, bus and devfn in
>> struct ioapic_scope and struct hpet_scope. So we use domain field
>> as a flag to mark entry valid or invalid and only reset iommu field.
> 
> Hi Gerry, use iommu field as a flag to mark entry valid may be not safe enough,
> I found map_hpet_to_ir() and map_ioapic_to_ir() still only check the id field to return the valid iommu.
> 
> What about this case:
> E.g. ir_hpet[2].id = N, ir_hpet[2].iommu = NULL, ir_hpet[4].id = N, ir_hpet[4].iommu = iommu;
> 
> ir_hpet[2] maybe released yet, and the hpet now has been saved in ir_hpet[4], but map_hpet_to_irq()
> will return the wrong iommu(NULL).
Hi Yijing,
Good catch, I will enhance map_hpet_to_ir() and map_ioapic_to_ir().
Regards!
Gerry
> 
> 
> static struct intel_iommu *map_hpet_to_ir(u8 hpet_id)
> {
> 	int i;
> 
> 	for (i = 0; i < MAX_HPET_TBS; i++)
> 		if (ir_hpet[i].id == hpet_id)
> 			return ir_hpet[i].iommu;
> 	return NULL;
> }
> 
>>
>> Regards!
>> Gerry
>>>
>>>
>>>
>>>>  
>>>> -	return 0;
>>>> +	for (i = 0; i < MAX_IO_APICS; i++)
>>>> +		if (ir_ioapic[i].iommu == iommu)
>>>> +			ir_ioapic[i].iommu = NULL;
>>>>  }
>>>>  
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>> .
>>
> 
> 
