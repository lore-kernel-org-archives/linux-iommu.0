Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1918C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 10:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 63E27401E1;
	Fri, 18 Mar 2022 10:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CtW5dddKi429; Fri, 18 Mar 2022 10:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B276D40545;
	Fri, 18 Mar 2022 10:58:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9106BC001A;
	Fri, 18 Mar 2022 10:58:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C7CCC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 10:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E03540192
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 10:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LkeDhdUl5fYh for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 10:58:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5856A40179
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 10:58:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7182A16F3;
 Fri, 18 Mar 2022 03:58:08 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519D23F7F5;
 Fri, 18 Mar 2022 03:58:04 -0700 (PDT)
Message-ID: <44dd4f16-3f0b-5289-c9a2-fe42341b0231@arm.com>
Date: Fri, 18 Mar 2022 10:57:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus device
 to PCI device
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
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
 <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
 <PH0PR21MB302533BCD6707DAACC13E64DD7139@PH0PR21MB3025.namprd21.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PH0PR21MB302533BCD6707DAACC13E64DD7139@PH0PR21MB3025.namprd21.prod.outlook.com>
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

On 2022-03-18 05:12, Michael Kelley (LINUX) wrote:
> From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 17, 2022 10:15 AM
>>
>> On 2022-03-17 16:25, Michael Kelley via iommu wrote:
>>> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
>>> device and as a PCI device.  The coherence of the VMbus device is
>>> set based on the VMbus node in ACPI, but the PCI device has no
>>> ACPI node and defaults to not hardware coherent.  This results
>>> in extra software coherence management overhead on ARM64 when
>>> devices are hardware coherent.
>>>
>>> Fix this by propagating the coherence of the VMbus device to the
>>> PCI device.  There's no effect on x86/x64 where devices are
>>> always hardware coherent.
>>>
>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>> ---
>>>    drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
>>>    1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>>> index ae0bc2f..14276f5 100644
>>> --- a/drivers/pci/controller/pci-hyperv.c
>>> +++ b/drivers/pci/controller/pci-hyperv.c
>>> @@ -49,6 +49,7 @@
>>>    #include <linux/refcount.h>
>>>    #include <linux/irqdomain.h>
>>>    #include <linux/acpi.h>
>>> +#include <linux/dma-map-ops.h>
>>>    #include <asm/mshyperv.h>
>>>
>>>    /*
>>> @@ -2142,9 +2143,9 @@ static void hv_pci_remove_slots(struct hv_pcibus_device
>> *hbus)
>>>    }
>>>
>>>    /*
>>> - * Set NUMA node for the devices on the bus
>>> + * Set NUMA node and DMA coherence for the devices on the bus
>>>     */
>>> -static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
>>> +static void hv_pci_assign_properties(struct hv_pcibus_device *hbus)
>>>    {
>>>    	struct pci_dev *dev;
>>>    	struct pci_bus *bus = hbus->bridge->bus;
>>> @@ -2167,6 +2168,14 @@ static void hv_pci_assign_numa_node(struct
>> hv_pcibus_device *hbus)
>>>    				     numa_map_to_online_node(
>>>    					     hv_dev->desc.virtual_numa_node));
>>>
>>> +		/*
>>> +		 * On ARM64, propagate the DMA coherence from the VMbus device
>>> +		 * to the corresponding PCI device. On x86/x64, these calls
>>> +		 * have no effect because DMA is always hardware coherent.
>>> +		 */
>>> +		dev_set_dma_coherent(&dev->dev,
>>> +			dev_is_dma_coherent(&hbus->hdev->device));
>>
>> Eww... if you really have to do this, I'd prefer to see a proper
>> hv_dma_configure() helper implemented and wired up to
>> pci_dma_configure(). Although since it's a generic property I guess at
>> worst pci_dma_configure could perhaps propagate coherency from the host
>> bridge to its children by itself in the absence of any other firmware
>> info. And it's built-in so could use arch_setup_dma_ops() like everyone
>> else.
>>
> 
> I'm not seeing an existing mechanism to provide a "helper" or override
> of pci_dma_configure().   Could you elaborate?  Or is this something
> that needs to be created?

I mean something like the diff below (other #includes omitted for 
clarity). Essentially if VMBus has its own way of describing parts of 
the system, then for those parts it's nice if it could fit into the same 
abstractions we use for firmware-based system description.

Cheers,
Robin.

----->8-----
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588cfda48..7d92ccad1569 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -20,6 +20,7 @@
  #include <linux/of_device.h>
  #include <linux/acpi.h>
  #include <linux/dma-map-ops.h>
+#include <linux/hyperv.h>
  #include "pci.h"
  #include "pcie/portdrv.h"

@@ -1602,6 +1603,8 @@ static int pci_dma_configure(struct device *dev)
  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);

  		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
+	} else if (is_vmbus_dev(bridge)) {
+		ret = hv_dma_configure(dev, device_get_dma_attr(bridge));
  	}

  	pci_put_host_bridge_device(bridge);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f565a8938836..d1d4dd3d5a3a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1764,4 +1764,19 @@ static inline unsigned long virt_to_hvpfn(void *addr)
  #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
  #define page_to_hvpfn(page)	(page_to_pfn(page) * NR_HV_HYP_PAGES_IN_PAGE)

+static inline bool is_vmbus_dev(struct device *dev)
+{
+	/*
+	 * dev->bus == &hv_bus would break when the caller is built-in
+	 * and CONFIG_HYPERV=m, so look for it by name instead.
+	 */
+	return !strcmp(dev->bus->name, "vmbus");
+}
+
+static inline int hv_dma_configure(struct device *dev, enum 
dev_dma_attr attr)
+{
+	arch_setup_dma_ops(dev, 0, 0, NULL, attr == DEV_DMA_COHERENT);
+	return 0;
+}
+
  #endif /* _HYPERV_H */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
