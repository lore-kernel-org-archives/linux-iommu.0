Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6548DC433FE
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 17:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0805C418C1;
	Thu, 17 Mar 2022 17:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyb4FfgZKp_1; Thu, 17 Mar 2022 17:15:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AFC56418BF;
	Thu, 17 Mar 2022 17:15:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB71C0012;
	Thu, 17 Mar 2022 17:15:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28FF6C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 17:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 202CF8436A
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 17:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id djti3G0wxh4N for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 17:15:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56E4F8419A
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 17:15:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BBB71682;
 Thu, 17 Mar 2022 10:15:29 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1CE3F7B4;
 Thu, 17 Mar 2022 10:15:26 -0700 (PDT)
Message-ID: <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
Date: Thu, 17 Mar 2022 17:15:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus device
 to PCI device
Content-Language: en-GB
To: Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
 bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
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

On 2022-03-17 16:25, Michael Kelley via iommu wrote:
> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
> device and as a PCI device.  The coherence of the VMbus device is
> set based on the VMbus node in ACPI, but the PCI device has no
> ACPI node and defaults to not hardware coherent.  This results
> in extra software coherence management overhead on ARM64 when
> devices are hardware coherent.
> 
> Fix this by propagating the coherence of the VMbus device to the
> PCI device.  There's no effect on x86/x64 where devices are
> always hardware coherent.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ae0bc2f..14276f5 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -49,6 +49,7 @@
>   #include <linux/refcount.h>
>   #include <linux/irqdomain.h>
>   #include <linux/acpi.h>
> +#include <linux/dma-map-ops.h>
>   #include <asm/mshyperv.h>
>   
>   /*
> @@ -2142,9 +2143,9 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
>   }
>   
>   /*
> - * Set NUMA node for the devices on the bus
> + * Set NUMA node and DMA coherence for the devices on the bus
>    */
> -static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> +static void hv_pci_assign_properties(struct hv_pcibus_device *hbus)
>   {
>   	struct pci_dev *dev;
>   	struct pci_bus *bus = hbus->bridge->bus;
> @@ -2167,6 +2168,14 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
>   				     numa_map_to_online_node(
>   					     hv_dev->desc.virtual_numa_node));
>   
> +		/*
> +		 * On ARM64, propagate the DMA coherence from the VMbus device
> +		 * to the corresponding PCI device. On x86/x64, these calls
> +		 * have no effect because DMA is always hardware coherent.
> +		 */
> +		dev_set_dma_coherent(&dev->dev,
> +			dev_is_dma_coherent(&hbus->hdev->device));

Eww... if you really have to do this, I'd prefer to see a proper 
hv_dma_configure() helper implemented and wired up to 
pci_dma_configure(). Although since it's a generic property I guess at 
worst pci_dma_configure could perhaps propagate coherency from the host 
bridge to its children by itself in the absence of any other firmware 
info. And it's built-in so could use arch_setup_dma_ops() like everyone 
else.

Robin.

> +
>   		put_pcichild(hv_dev);
>   	}
>   }
> @@ -2191,7 +2200,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
>   		return error;
>   
>   	pci_lock_rescan_remove();
> -	hv_pci_assign_numa_node(hbus);
> +	hv_pci_assign_properties(hbus);
>   	pci_bus_assign_resources(bridge->bus);
>   	hv_pci_assign_slots(hbus);
>   	pci_bus_add_devices(bridge->bus);
> @@ -2458,7 +2467,7 @@ static void pci_devices_present_work(struct work_struct *work)
>   		 */
>   		pci_lock_rescan_remove();
>   		pci_scan_child_bus(hbus->bridge->bus);
> -		hv_pci_assign_numa_node(hbus);
> +		hv_pci_assign_properties(hbus);
>   		hv_pci_assign_slots(hbus);
>   		pci_unlock_rescan_remove();
>   		break;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
