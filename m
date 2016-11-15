From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Tue, 15 Nov 2016 10:24:22 -0800
Message-ID: <582B52D6.6060907@caviumnetworks.com>
References: <1479193220-6693-1-git-send-email-gakula@caviumnetworks.com>
	<0414d797-7134-8192-d373-b14b26edd023@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0414d797-7134-8192-d373-b14b26edd023-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, suzuki.poulose-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, james.morse-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/15/2016 01:26 AM, Marc Zyngier wrote:
> On 15/11/16 07:00, Geetha sowjanya wrote:
>> From: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>>    This patch implements Cavium ThunderX erratum 28168.
>>
>>    PCI requires stores complete in order. Due to erratum #28168
>>    PCI-inbound MSI-X store to the interrupt controller are delivered
>>    to the interrupt controller before older PCI-inbound memory stores
>>    are committed.
>>    Doing a sync on SMMU will make sure all prior data transfers are
>>    completed before invoking ISR.
>>
>> Signed-off-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
[...]
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -28,6 +28,8 @@
>>   #include <linux/of_irq.h>
>>   #include <linux/percpu.h>
>>   #include <linux/slab.h>
>> +#include <linux/msi.h>
>> +#include <linux/pci.h>
>>
>>   #include <linux/irqchip.h>
>>   #include <linux/irqchip/arm-gic-common.h>
>> @@ -736,6 +738,20 @@ static inline void gic_cpu_pm_init(void) { }
>>
>>   #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
>>
>> +/*
>> + * Due to #28168 erratum in ThunderX,
>> + * we need to make sure DMA data transfer is done before MSIX.
>> + */
>> +static void cavium_irq_perflow_handler(struct irq_data *data)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
>
> What happens if this is not a PCI device?
>
>> +	if ((pdev->vendor != 0x177d) &&
>> +			((pdev->device & 0xA000) != 0xA000))
>> +		cavium_arm_smmu_tlb_sync(&pdev->dev);
>
> I've asked that before. What makes Cavium devices so special that they
> are not sensitive to this bug?


This is a heuristic for devices connected to external PCIe buses as 
opposed to on-SoC devices (which don't suffer from the erratum).

In any event what would happen if we got rid of this check and ...


>
>> +}
>> +
>>   static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>   			      irq_hw_number_t hw)
>>   {
>> @@ -773,6 +789,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>   			return -EPERM;
>>   		irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>   				    handle_fasteoi_irq, NULL, NULL);
>> +		if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_28168))
>> +			__irq_set_preflow_handler(irq,
>> +						  cavium_irq_perflow_handler);
>

... move the registration of the preflow_handler into a 
msi_domain_ops.msi_finish() handler in irq-git-v3-its-pic-msi.c?

There we will know that it is a pci device, and can walk up the bus 
hierarchy to see if there is a Cavium PCIe root port present.  If such a 
port is found, we know we are on an external Cavium PCIe bus, and can 
register the preflow_handler without having to check the device identifiers.



> What happens if SMMUv2 is not compiled in? Also, since this only affects
> LPI signaling, why is this in the core GICv3 code and not in the ITS.
> And more specifically, in the PCI part of the ITS, since you seem to
> exclusively consider PCI?
>
>>   	}
>>
>>   	return 0;
>>
>
> Thanks,
>
> 	M.
>
