Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8499CC433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 14:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 382C141C69;
	Thu, 24 Mar 2022 14:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaHoK-thBgbL; Thu, 24 Mar 2022 14:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F0F0041C4C;
	Thu, 24 Mar 2022 14:41:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEC4DC001A;
	Thu, 24 Mar 2022 14:41:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB9EC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 14:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5743B843F8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 14:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d3Fs3Swj3hyP for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 14:41:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B94B843EA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 14:41:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708AA1515;
 Thu, 24 Mar 2022 07:41:48 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8173F73D;
 Thu, 24 Mar 2022 07:41:45 -0700 (PDT)
Message-ID: <e3cf16f2-e9d7-b169-cccf-038df5acdb79@arm.com>
Date: Thu, 24 Mar 2022 14:41:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Content-Language: en-GB
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-2-git-send-email-mikelley@microsoft.com>
 <f984116a-c748-ada0-c073-6e62f486b4f5@arm.com>
 <PH0PR21MB3025C5DFB189B9609F7A601FD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PH0PR21MB3025C5DFB189B9609F7A601FD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-03-24 13:18, Michael Kelley (LINUX) wrote:
> From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 24, 2022 4:59 AM
>>
>> On 2022-03-23 20:31, Michael Kelley wrote:
>>> VMbus synthetic devices are not represented in the ACPI DSDT -- only
>>> the top level VMbus device is represented. As a result, on ARM64
>>> coherence information in the _CCA method is not specified for
>>> synthetic devices, so they default to not hardware coherent.
>>> Drivers for some of these synthetic devices have been recently
>>> updated to use the standard DMA APIs, and they are incurring extra
>>> overhead of unneeded software coherence management.
>>>
>>> Fix this by propagating coherence information from the VMbus node
>>> in ACPI to the individual synthetic devices. There's no effect on
>>> x86/x64 where devices are always hardware coherent.
>>>
>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>> ---
>>>    drivers/hv/hv_common.c         | 11 +++++++++++
>>>    drivers/hv/vmbus_drv.c         | 23 +++++++++++++++++++++++
>>>    include/asm-generic/mshyperv.h |  1 +
>>>    3 files changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>> index 181d16b..820e814 100644
>>> --- a/drivers/hv/hv_common.c
>>> +++ b/drivers/hv/hv_common.c
>>> @@ -20,6 +20,7 @@
>>>    #include <linux/panic_notifier.h>
>>>    #include <linux/ptrace.h>
>>>    #include <linux/slab.h>
>>> +#include <linux/dma-map-ops.h>
>>>    #include <asm/hyperv-tlfs.h>
>>>    #include <asm/mshyperv.h>
>>>
>>> @@ -216,6 +217,16 @@ bool hv_query_ext_cap(u64 cap_query)
>>>    }
>>>    EXPORT_SYMBOL_GPL(hv_query_ext_cap);
>>>
>>> +void hv_setup_dma_ops(struct device *dev, bool coherent)
>>> +{
>>> +	/*
>>> +	 * Hyper-V does not offer a vIOMMU in the guest
>>> +	 * VM, so pass 0/NULL for the IOMMU settings
>>> +	 */
>>> +	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>>> +
>>>    bool hv_is_hibernation_supported(void)
>>>    {
>>>    	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>> index 12a2b37..2d2c54c 100644
>>> --- a/drivers/hv/vmbus_drv.c
>>> +++ b/drivers/hv/vmbus_drv.c
>>> @@ -905,6 +905,14 @@ static int vmbus_probe(struct device *child_device)
>>>    	struct hv_device *dev = device_to_hv_device(child_device);
>>>    	const struct hv_vmbus_device_id *dev_id;
>>>
>>> +	/*
>>> +	 * On ARM64, propagate the DMA coherence setting from the top level
>>> +	 * VMbus ACPI device to the child VMbus device being added here.
>>> +	 * On x86/x64 coherence is assumed and these calls have no effect.
>>> +	 */
>>> +	hv_setup_dma_ops(child_device,
>>> +		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
>>
>> Would you mind hooking up the hv_bus.dma_configure method to do this?
>> Feel free to fold hv_setup_dma_ops entirely into that if you're not
>> likely to need to call it from anywhere else.
> 
> I'm pretty sure using hv_bus.dma_configure() is doable.  A separate
> hv_setup_dma_ops() is still needed because arch_setup_dma_ops() isn't
> exported and this VMbus driver can be built as a module.

Ah, right you are, I keep forgetting that.

>>> +
>>>    	dev_id = hv_vmbus_get_id(drv, dev);
>>>    	if (drv->probe) {
>>>    		ret = drv->probe(dev, dev_id);
>>> @@ -2428,6 +2436,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
>>>
>>>    	hv_acpi_dev = device;
>>>
>>> +	/*
>>> +	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
>>> +	 * method on the top level VMbus device in the DSDT. But devices
>>> +	 * are hardware coherent in all current Hyper-V use cases, so fix
>>> +	 * up the ACPI device to behave as if _CCA is present and indicates
>>> +	 * hardware coherence.
>>> +	 */
>>> +	ACPI_COMPANION_SET(&device->dev, device);
>>> +	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
>>> +	    device_get_dma_attr(&device->dev) == DEV_DMA_NOT_SUPPORTED) {
>>> +		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
>>> +		device->flags.cca_seen = true;
>>> +		device->flags.coherent_dma = true;
>>> +	}
>>
>> I'm not the biggest fan of this, especially since I'm not convinced that
>> there are any out-of-support deployments of ARM64 Hyper-V that can't be
>> updated. However I suppose it's not "real" firmware, and one Hyper-V
>> component is at liberty to hack another Hyper-V component's data if it
>> really wants to...
> 
> Agreed, it's a hack.  But Hyper-V instances are out there as part of
> Windows 10/11 on ARM64 PCs, and they run ARM64 VMs for the
> Windows Subsystem for Linux.  Microsoft gets pilloried for breaking
> stuff, and this removes the potential for that happening if someone
> runs a new Linux kernel version in that VM.

And actually that one's on me as well - for some reason I was thinking 
that this had never worked, and therefore you could likely get a Hyper-V 
update pushed out long before users get this patch through distros, but 
of course it only becomes an issue now because previously there was no 
connection to any ACPI node at all. As I said, personally I'm happy to 
consider this a Hyper-V internal workaround, but if anyone else objects 
to poking at the ACPI flags, I suppose you've also got the fallback 
option of flipping it around and making the ACPI_COMPANION_SET() 
conditional, so that the behaviour for older versions remains entirely 
unchanged. If it happens, feel free to keep my ack for that approach too.

Cheers,
Robin.

> 
> Michael
> 
>>
>> If you can hook up .dma_configure, or clarify if it wouldn't work,
>>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>>
>> Cheers,
>> Robin.
>>
>>> +
>>>    	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>>>    					vmbus_walk_resources, NULL);
>>>
>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>> index c08758b..c05d2ce 100644
>>> --- a/include/asm-generic/mshyperv.h
>>> +++ b/include/asm-generic/mshyperv.h
>>> @@ -269,6 +269,7 @@ static inline int cpumask_to_vpset_noself(struct hv_vpset
>> *vpset,
>>>    u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
>>>    void hyperv_cleanup(void);
>>>    bool hv_query_ext_cap(u64 cap_query);
>>> +void hv_setup_dma_ops(struct device *dev, bool coherent);
>>>    void *hv_map_memory(void *addr, unsigned long size);
>>>    void hv_unmap_memory(void *addr);
>>>    #else /* CONFIG_HYPERV */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
