From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Tue, 15 Nov 2016 12:36:12 +0000
Message-ID: <bef0dde3-9bef-0dbc-8c61-8ad0dc74c2a7@arm.com>
References: <1479193220-6693-1-git-send-email-gakula@caviumnetworks.com>
	<0414d797-7134-8192-d373-b14b26edd023@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, suzuki.poulose-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, james.morse-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/11/16 09:26, Marc Zyngier wrote:
> On 15/11/16 07:00, Geetha sowjanya wrote:
>> From: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>>   This patch implements Cavium ThunderX erratum 28168.
>>
>>   PCI requires stores complete in order. Due to erratum #28168
>>   PCI-inbound MSI-X store to the interrupt controller are delivered
>>   to the interrupt controller before older PCI-inbound memory stores
>>   are committed.
>>   Doing a sync on SMMU will make sure all prior data transfers are
>>   completed before invoking ISR.
>>
>> Signed-off-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>  arch/arm64/Kconfig                  |   11 +++++++++++
>>  arch/arm64/Kconfig.platforms        |    1 +
>>  arch/arm64/include/asm/cpufeature.h |    3 ++-
>>  arch/arm64/kernel/cpu_errata.c      |   16 ++++++++++++++++
>>  drivers/iommu/arm-smmu.c            |   24 ++++++++++++++++++++++++
>>  drivers/irqchip/irq-gic-common.h    |    1 +
>>  drivers/irqchip/irq-gic-v3.c        |   19 +++++++++++++++++++
>>  7 files changed, 74 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 30398db..751972c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -474,6 +474,17 @@ config CAVIUM_ERRATUM_27456
>>  
>>  	  If unsure, say Y.
>>  
>> +config CAVIUM_ERRATUM_28168
>> +       bool "Cavium erratum 28168: Make sure DMA data transfer is done before MSIX"
>> +       depends on ARCH_THUNDER && ARM64
>> +       default y
>> +       help
>> +        Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
>> +        controller are delivered to the interrupt controller before older
>> +        PCI-inbound memory stores are committed. Doing a sync on SMMU
>> +        will make sure all prior data transfers are done before invoking ISR.
>> +
>> +        If unsure, say Y.
> 
> Where is the entry in Documentation/arm64/silicon-errata.txt?
> 
>>  endmenu
>>  
>>  
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index cfbdf02..2ac4ac6 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -185,6 +185,7 @@ config ARCH_SPRD
>>  
>>  config ARCH_THUNDER
>>  	bool "Cavium Inc. Thunder SoC Family"
>> +	select IRQ_PREFLOW_FASTEOI
>>  	help
>>  	  This enables support for Cavium's Thunder Family of SoCs.
>>  
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 758d74f..821fc3c 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -40,8 +40,9 @@
>>  #define ARM64_HAS_32BIT_EL0			13
>>  #define ARM64_HYP_OFFSET_LOW			14
>>  #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
>> +#define ARM64_WORKAROUND_CAVIUM_28168		16
>>  
>> -#define ARM64_NCAPS				16
>> +#define ARM64_NCAPS				17
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 0150394..0841a12 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -122,6 +122,22 @@ static void cpu_enable_trap_ctr_access(void *__unused)
>>  		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
>>  	},
>>  #endif
>> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
>> +	{
>> +	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
>> +		.desc = "Cavium erratum 28168",
>> +		.capability = ARM64_WORKAROUND_CAVIUM_28168,
>> +		MIDR_RANGE(MIDR_THUNDERX, 0x00,
>> +			   (1 << MIDR_VARIANT_SHIFT) | 1),
>> +	},
>> +	{
>> +	/* Cavium ThunderX, T81 pass 1.0 */
>> +		.desc = "Cavium erratum 28168",
>> +		.capability = ARM64_WORKAROUND_CAVIUM_28168,
>> +		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
>> +	},
>> +#endif
> 
> How is that a CPU bug? Shouldn't that be keyed on the SMMU version or
> the ITs version?

Seconded. I assume the actual component at fault is the PCI RC, SMMU, or
interconnect in between - are there no ID registers in those parts that
will indicate a fixed version (or ECO) in future?

>> +
>>  	{
>>  		.desc = "Mismatched cache line size",
>>  		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c841eb7..1b4555c 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -570,6 +570,30 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>>  	}
>>  }
>>  
>> +/*
>> + * Cavium ThunderX erratum 28168
>> + *
>> + * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
>> + * controller are delivered to the interrupt controller before older
>> + * PCI-inbound memory stores are committed. Doing a sync on SMMU
>> + * will make sure all prior data transfers are completed before
>> + * invoking ISR.
>> + *
>> + */
>> +void cavium_arm_smmu_tlb_sync(struct device *dev)
>> +{
>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +	struct arm_smmu_device *smmu;
>> +
>> +	smmu = fwspec_smmu(fwspec);
>> +	if (!smmu)
>> +		return;
>> +	__arm_smmu_tlb_sync(smmu);

Further to my questions on the last posting, is TLBGSYNC alone
guaranteed to always do something, even if there are no outstanding
invalidation requests? Will this workaround still apply if
__arm_smmu_tlb_sync() were to use CBn_TLBSYNC instead?

>> +
>> +}
>> +EXPORT_SYMBOL(cavium_arm_smmu_tlb_sync);
> 
> Why does this need to be exported? The only user can only be built-in.
> 
>> +
>> +
>>  static void arm_smmu_tlb_sync(void *cookie)
>>  {
>>  	struct arm_smmu_domain *smmu_domain = cookie;
>> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
>> index 205e5fd..4e88f55 100644
>> --- a/drivers/irqchip/irq-gic-common.h
>> +++ b/drivers/irqchip/irq-gic-common.h
>> @@ -38,4 +38,5 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>>  
>>  void gic_set_kvm_info(const struct gic_kvm_info *info);
>>  
>> +void cavium_arm_smmu_tlb_sync(struct device *dev);
> 
> Why should this be visible to GICv2 as well? I have the ugly feeling
> this should stay private to the SMMU code and that a more standard
> mechanism should be used... Robin, is there anything else we could
> piggy-back on?

I'm not sure it's actually any less horrible, but technically, one
*could* externally force a sync like so:

struct iommu_domain *dom = iommu_get_domain_for_dev(dev);
iommu_map(dom, <some reserved IOVA>, <some safe PA>, PAGE_SIZE, IOMMU_READ;
iommu_unmap(dom, <IOVA>, PAGE_SIZE);

(needs also to be error-safe and race-safe, obviously)

although there's rather a lot of extra overhead involved, and it also
relies on the driver not doing any Intel-style lazy unmapping.

The other 'generic' way which comes to mind would be some magic domain
attribute which has a sync side-effect on read (or write), but that's
utterly vile. And I'm not even going to entertain the thought of having
the SMMU driver implement a fake irqchip stacked on top of the ITS for
the sake of keeping all the code in one place...

>>  #endif /* _IRQ_GIC_COMMON_H */
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 19d642e..723cebe 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -28,6 +28,8 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/percpu.h>
>>  #include <linux/slab.h>
>> +#include <linux/msi.h>
>> +#include <linux/pci.h>
>>  
>>  #include <linux/irqchip.h>
>>  #include <linux/irqchip/arm-gic-common.h>
>> @@ -736,6 +738,20 @@ static inline void gic_cpu_pm_init(void) { }
>>  
>>  #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
>>  
>> +/*
>> + * Due to #28168 erratum in ThunderX,
>> + * we need to make sure DMA data transfer is done before MSIX.
>> + */
>> +static void cavium_irq_perflow_handler(struct irq_data *data)

perflow?

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
> 
>> +}
>> +
>>  static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>  			      irq_hw_number_t hw)
>>  {
>> @@ -773,6 +789,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>  			return -EPERM;
>>  		irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>  				    handle_fasteoi_irq, NULL, NULL);
>> +		if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_28168))
>> +			__irq_set_preflow_handler(irq,
>> +						  cavium_irq_perflow_handler);
> 
> What happens if SMMUv2 is not compiled in?

drivers/built-in.o: In function `cavium_irq_perflow_handler':
/work/src/linux/drivers/irqchip/irq-gic-v3.c:752: undefined reference to
`cavium_arm_smmu_tlb_sync'
make: *** [vmlinux] Error 1

Robin

> Also, since this only affects
> LPI signaling, why is this in the core GICv3 code and not in the ITS.
> And more specifically, in the PCI part of the ITS, since you seem to
> exclusively consider PCI?
> 
>>  	}
>>  
>>  	return 0;
>>
> 
> Thanks,
> 
> 	M.
> 
