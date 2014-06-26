From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Patch Part3 V3 00/21] Enable support of Intel DMAR device hotplug
Date: Thu, 26 Jun 2014 21:59:58 +0800
Message-ID: <53AC275E.4090602@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
	<CAErSpo5z9OH_u3f9L5qKoJsJ+mgRU5rba9mnQG0Y5XXn0zcEvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo5z9OH_u3f9L5qKoJsJ+mgRU5rba9mnQG0Y5XXn0zcEvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux hotplug mailing <linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2014/6/26 2:00, Bjorn Helgaas wrote:
>>   iommu/vt-d: match segment number when searching for dev_iotlb capable
>>     devices
>>   iommu/vt-d: use correct domain id to flush virtual machine domains
>>   iommu/vt-d: introduce helper functions to improve code readability
>>   iommu/vt-d: introduce helper functions to make code symmetric for
>>     readability
>>   iommu/vt-d: only dynamically allocate domain id for virtual domains
>>   iommu/vt-d: fix possible invalid memory access caused by
>>     free_dmar_iommu()
>>   iommu/vt-d: avoid freeing virtual machine domain in free_dmar_iommu()
>>   iommu/VT-d: simplify include/linux/dmar.h
>>   iommu/vt-d: change iommu_enable/disable_translation to return void
>>   iommu/vt-d: simplify intel_unmap_sg() and kill duplicated code
>>   iommu/vt-d: introduce helper domain_pfn_within_range() to simplify
>>     code
>>   iommu/vt-d: introduce helper function iova_size() to improve code
>>     readability
>>   iommu/vt-d: fix bug in computing domain's iommu_snooping flag
>>   IOMMU/vt-d: introduce helper function dmar_walk_resources()
>>   iommu/vt-d: dynamically allocate and free seq_id for DMAR units
>>   iommu/vt-d: implement DMAR unit hotplug framework
>>   iommu/vt-d: search _DSM method for DMAR hotplug
>>   iommu/vt-d: enhance intel_irq_remapping driver to support DMAR unit
>>     hotplug
>>   iommu/vt-d: enhance error recovery in function
>>     intel_enable_irq_remapping()
>>   iommu/vt-d: enhance intel-iommu driver to support DMAR unit hotplug
>>   pci, ACPI, iommu: enhance pci_root to support DMAR device hotplug
> 
> This looks a little sloppy; you have three different ways of
> capitalizing the area:
> 
>   iommu/vt-d:
>   iommu/VT-d:
>   IOMMU/vt-d:
> 
> Also, "git log --oneline drivers/iommu" says that the convention for
> drivers/iommu is to capitalize the first word of the rest of the
> subject line.
Hi Bjorn,
	Really sorry about my careless. I just rebased the patch set
onto v3.16-rc1, I should do more careful check about the commit
messages. I will wait for more comments and resend a new version
to address the commit message issues.
	Thanks for your reminder again.
Regards!
Gerry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
