From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 5/6] PCI: update dma configuration from DT
Date: Mon, 26 Jan 2015 18:28:54 -0500
Message-ID: <54C6CDB6.2080207@ti.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
	<1422052359-12384-6-git-send-email-m-karicheri2@ti.com>
	<20150123232725.GV29776@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150123232725.GV29776-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/23/2015 06:27 PM, Bjorn Helgaas wrote:
> On Fri, Jan 23, 2015 at 05:32:38PM -0500, Murali Karicheri wrote:
>> If there is a DT node available for the root bridge's parent device,
>> use the dma configuration from that device node. For example, keystone
>> PCI devices would require dma_pfn_offset to be set correctly in the
>> device structure of the pci device in order to have the correct dma mask.
>> The DT node will have dma-ranges defined for this. Also support using
>> the DT property dma-coherent to allow coherent DMA operation by the
>> PCI device.
>>
>> This patch use the new helper function of_pci_dma_configure() to update
>> the device dma configuration.
>>
>> Cc: Joerg Roedel<joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Cc: Grant Likely<grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Rob Herring<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Cc: Will Deacon<will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Cc: Russell King<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>> Cc: Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>
>> Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
>
> I assume this series will be merged via some non-PCI tree, so:

Not sure who will pick this. Since this is for PCI, will it be possible 
to apply this to arm-pci/next?

>
> Acked-by: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

I will add your ack for v5.

Murali
>
>> ---
>>   drivers/pci/probe.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 23212f8..d7dcd6c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -6,6 +6,7 @@
>>   #include<linux/delay.h>
>>   #include<linux/init.h>
>>   #include<linux/pci.h>
>> +#include<linux/of_pci.h>
>>   #include<linux/pci_hotplug.h>
>>   #include<linux/slab.h>
>>   #include<linux/module.h>
>> @@ -1520,6 +1521,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>   	dev->dev.dma_mask =&dev->dma_mask;
>>   	dev->dev.dma_parms =&dev->dma_parms;
>>   	dev->dev.coherent_dma_mask = 0xffffffffull;
>> +	of_pci_dma_configure(dev);
>>
>>   	pci_set_dma_max_seg_size(dev, 65536);
>>   	pci_set_dma_seg_boundary(dev, 0xffffffff);
>> --
>> 1.7.9.5
>>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
