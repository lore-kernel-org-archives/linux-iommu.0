From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Tue, 20 Dec 2016 11:52:58 +0000
Message-ID: <bd950765-8c1f-14d5-2be8-efa76f2d6b6b@arm.com>
References: <1482231993-27571-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1482231993-27571-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, suzuki.poulose-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, james.morse-5wv7dgnIgG8@public.gmane.org, Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Geetha,

On 20/12/16 11:06, Geetha sowjanya wrote:
> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> 
>   This patch implements Cavium ThunderX erratum 28168.
> 
>   PCI requires stores complete in order. Due to erratum #28168
>   PCI-inbound MSI-X store to the interrupt controller are delivered
>   to the interrupt controller before older PCI-inbound memory stores
>   are committed.
>   Doing a sync on SMMU will make sure all prior data transfers are
>   completed before invoking ISR.
> 
>  changes from v2:
>         - added entry in Documentation/arm64/silicon-errata.txt
>         - moved registration of the preflow_handler into
>            msi_domain_ops.msi_finish() handler.
>         - create linux/arm.smmu.h to expose smmu API.
> 
> Signed-off-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Where is your SoB? This is a requirement if you're picking a patch from
someone else.

> ---
>  Documentation/arm64/silicon-errata.txt   |  1 +
>  arch/arm64/Kconfig                       | 12 ++++++++
>  arch/arm64/include/asm/cpucaps.h         |  3 +-
>  arch/arm64/kernel/cpu_errata.c           | 16 +++++++++++
>  drivers/iommu/arm-smmu.c                 | 22 +++++++++++++++
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c | 48 +++++++++++++++++++++++++++++++-
>  include/linux/arm-smmu.h                 |  8 ++++++
>  7 files changed, 108 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/arm-smmu.h
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 405da11..1311f90 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -61,5 +61,6 @@ stable kernels.
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
> +| Cavium         | ThunderX PCI    | #28168          | CAVIUM_ERRATUM_28168    |
>  |                |                 |                 |                         |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 969ef88..cb647f4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -474,6 +474,18 @@ config CAVIUM_ERRATUM_27456
>  
>  	  If unsure, say Y.
>  
> +config CAVIUM_ERRATUM_28168
> +       bool "Cavium erratum 28168: Make sure DMA data transfer is done before MSIX"
> +       depends on ARM64 && ARM_SMMU
> +       default y
> +       select IRQ_PREFLOW_FASTEOI
> +       help
> +        Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
> +        controller are delivered to the interrupt controller before older
> +        PCI-inbound memory stores are committed. Doing a sync on SMMU
> +        will make sure all prior data transfers are done before invoking ISR.
> +
> +        If unsure, say Y.
>  endmenu
>  
>  
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 87b4465..6975a01 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -34,7 +34,8 @@
>  #define ARM64_HAS_32BIT_EL0			13
>  #define ARM64_HYP_OFFSET_LOW			14
>  #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
> +#define ARM64_WORKAROUND_CAVIUM_28168		16
>  
> -#define ARM64_NCAPS				16
> +#define ARM64_NCAPS				17
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index b75e917..fac6d74 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -123,6 +123,22 @@ static int cpu_enable_trap_ctr_access(void *__unused)
>  		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
>  	},
>  #endif
> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> +	{
> +	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
> +		.desc = "Cavium erratum 28168",
> +		.capability = ARM64_WORKAROUND_CAVIUM_28168,
> +		MIDR_RANGE(MIDR_THUNDERX, 0x00,
> +			   (1 << MIDR_VARIANT_SHIFT) | 1),
> +	},
> +	{
> +	/* Cavium ThunderX, T81 pass 1.0 */
> +		.desc = "Cavium erratum 28168",
> +		.capability = ARM64_WORKAROUND_CAVIUM_28168,
> +		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
> +	},
> +#endif
> +
>  	{
>  		.desc = "Mismatched cache line size",
>  		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 06167da..451b393 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -49,6 +49,8 @@
>  #include <linux/spinlock.h>
>  
>  #include <linux/amba/bus.h>
> +#include <linux/arm-smmu.h>
> +
>  
>  #include "io-pgtable.h"
>  
> @@ -577,6 +579,26 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>  	}
>  }
>  
> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> +/*
> + * Cavium ThunderX erratum 28168
> + *
> + * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
> + * controller are delivered to the interrupt controller before older
> + * PCI-inbound memory stores are committed. Doing a sync on SMMU
> + * will make sure all prior data transfers are completed before
> + * invoking ISR.
> + *
> + */
> +void dev_smmu_tlb_sync(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
> +
> +	if (smmu)
> +		__arm_smmu_tlb_sync(smmu);
> +}
> +#endif

I'll let Robin and Will comment on this, but it strikes be as rather odd
that nothing will happen if the SMMU is in bypass or simply compiled
out. So this workaround is at best incomplete.

>  static void arm_smmu_tlb_sync(void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index aee1c60..36ce696 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
> +#include <linux/arm-smmu.h>
>  
>  static void its_mask_msi_irq(struct irq_data *d)
>  {
> @@ -86,11 +87,53 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  
>  	/* ITS specific DeviceID, as the core ITS ignores dev. */
>  	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
> -
> +	info->scratchpad[1].ptr = &pdev->dev;
>  	return msi_info->ops->msi_prepare(domain->parent,
>  					  dev, dev_alias.count, info);
>  }
>  
> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> +#define	THUNDER_PME_DEVICE_ID		0xA100
> +
> +static void cavium_irq_preflow_handler(struct irq_data *data)
> +{
> +	struct pci_dev *pdev;
> +
> +	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
> +	dev_smmu_tlb_sync(&pdev->dev);
> +}

Missing space between the two functions.

> +static void cavium_its_pci_msi_finish(msi_alloc_info_t *info, int ret)
> +{
> +	struct device *dev = info->scratchpad[1].ptr;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct device *parent_dev;
> +	struct msi_desc *desc;
> +
> +	if (ret)
> +		return;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
> +		for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> +			pdev = to_pci_dev(parent_dev);
> +			if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
> +				continue;
> +
> +			if (pdev->device == THUNDER_PME_DEVICE_ID)
> +				for_each_pci_msi_entry(desc, to_pci_dev(dev))
> +					__irq_set_preflow_handler(desc->irq, cavium_irq_preflow_handler);

So only the PME device is affected? Why can't you simply use INTx for it
(there is already some provision for that in the PME driver
("pcie_pme=nomsi").

If your PME device doesn't implement legacy interrupt, can't you do
something in the PME interrupt handler instead? Like reading from the
end-point or something similar?

> +			break;
> +		}
> +	}
> +}
> +#else
> +static void cavium_irq_preflow_handler(struct irq_data *data)
> +{
> +}

Why is this defined? It is just going to generate a warning if
CONFIG_CAVIUM_ERRATUM_28168 is not defined...

> +static void cavium_its_pci_msi_finish(msi_alloc_info_t *info, int ret)
> +{
> +}

You might as well have
#define cavium_its_pci_msi_finish	NULL

> +#endif
> +
>  static struct msi_domain_ops its_pci_msi_ops = {
>  	.msi_prepare	= its_pci_msi_prepare,
>  };
> @@ -118,6 +161,9 @@ static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
>  		return -ENXIO;
>  	}
>  
> +	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_28168))
> +		its_pci_msi_ops.msi_finish = cavium_its_pci_msi_finish;
> +
>  	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
>  				       parent)) {
>  		pr_err("%s: Unable to create PCI domain\n", name);
> diff --git a/include/linux/arm-smmu.h b/include/linux/arm-smmu.h
> new file mode 100644
> index 0000000..d3f5dff
> --- /dev/null
> +++ b/include/linux/arm-smmu.h
> @@ -0,0 +1,8 @@
> +#ifndef _ARM_SMMU_H
> +#define _ARM_SMMU_H
> +
> +#include<linux/pci.h>
> +
> +extern void dev_smmu_tlb_sync(struct device *dev);
> +
> +#endif /* _ARM_SMMU_H */
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
