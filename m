From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/4] PCI: get DMA configuration from parent device
Date: Wed, 7 Jan 2015 18:04:41 -0500
Message-ID: <54ADBB89.8070503@ti.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com> <4057859.4ynbgz66iN@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4057859.4ynbgz66iN@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/07/2015 04:18 PM, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 13:49:50 Murali Karicheri wrote:
>> PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
>> add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
>> and dma ops etc using the information from DT. The prior RFCs and discussions
>> are available at [1] and [2] below.
>>
>> [2] : https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg790244.html
>> [1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591
>
> Looks all good to me in this version, I'm just unsure about one thing:
>
>>                 - Limit the of_iommu_configure to non pci devices
>
> My last recommendation was to pass the b/d/f number into
> of_pci_dma_configure to handle this correctly. What was your
> reason for not doing it in the end?
Arnd,

I had responded to this already on the list and reproduced below your 
remark and my response below from that thread.

---------------cut-------------------------------------------------------
 > Actually regarding the bit I wrote above, it might be helpful to pass
 > the PCI_DEVID() into both of_iommu_configure and of_dma_configure.
 >
 > While this may or may not be sufficient, I think there is no question
 > about it being needed for the ARM SMMU with PCI, so we may as well add
 > it at the point when you touch the same lines already. In the platform
 > bus case, just pass zero here.
Arnd,

PCI_DEVID() is defined as

#define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))

So PCI_DEVID of 0 is a valid PCI DEVID.

How about checking if the device is PCI in of_iommu_configure() using 
dev_is_pci(dev) macro and return immediately for PCI? Need to include 
pci.h in this file though.

Some of the iommu drivers already include this.

a0868495@ares-ubuntu:~/projects/linux-keystone$ grep -r pci.h drivers/iommu/
drivers/iommu/amd_iommu_v2.c:#include <linux/pci.h>
drivers/iommu/dmar.c:#include <linux/pci.h>
drivers/iommu/amd_iommu_types.h:#include <linux/pci.h>
drivers/iommu/amd_iommu.c:#include <linux/pci.h>
drivers/iommu/fsl_pamu_domain.c:#include <sysdev/fsl_pci.h>
drivers/iommu/iommu.c:#include <linux/pci.h>
drivers/iommu/intel-iommu.c:#include <linux/pci.h>
drivers/iommu/intel_irq_remapping.c:#include <linux/pci.h>
drivers/iommu/arm-smmu.c:#include <linux/pci.h>
drivers/iommu/amd_iommu_init.c:#include <linux/pci.h>
drivers/iommu/irq_remapping.c:#include <linux/pci.h>

This will allow us to re-visit this later for IOMMU support for PCI 
without polluting the API.
-----------------------cut-end---------------------------------------

I assumed you want to use value of zero for b/d/f to indicate it is for
platform. Also use the non zero value to skip the DT attribute parsing 
for IOMMU DT attribute in of_iommu_configure() for PCI.
I did dev_is_pci() for skipping the processing for PCI. I thought it is 
better to add the b/d/f argument later when this is re-visited later.

BTW,

I still haven't received any comment from Bjorn w.r.t PCI part.

BJorn, could you review and comment on 3/4 and 4/4?

Regards,

Murali
>
> We will likely have to change this again if we take your current version,
> but that can be a follow-up patch. I believe AMD requires it to use
> PCI on their their Seattle platform.
>
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
