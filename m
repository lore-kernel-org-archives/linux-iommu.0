Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2078632B
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448285; cv=none; b=DMuIiZF7lnITvAxqZWDeniF7dA9R8Acua3e3JHEeRGnDhYRWwpAzbG2/0F4VfSb/abMNRvgq5POeIsKn45akyqXcGl9i7tb+W2SXtymDSxsyLQVdX99E75+ed6GMU4GhWtWtU2yP/ovLpqgG6MI+uYjyCeI5sGcc9HKufy025Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448285; c=relaxed/simple;
	bh=ojSY4Apxchs89YzInh7dmxCYnkcaTxc1iwkhojnaB98=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pL9oJvKqJxnfvMP96N0g7e1THOzYE2Uy9zFPIkqNm6Hk/tEqru6QM1o4jCxM1WVf++Uyf7Z2DNG69U0nu+gQts7edLUgQQ8fZepdNEj7VrW3YF7MOXLpPvcR4iOJTgVGLqhcx+OluKLlM7O6lx9lDgmuzuJF+CBSlOnEIvBxHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DFCE16A3;
	Fri, 20 Jun 2025 12:37:41 -0700 (PDT)
Received: from [10.57.27.59] (unknown [10.57.27.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72C8A3F673;
	Fri, 20 Jun 2025 12:37:58 -0700 (PDT)
Message-ID: <43276c9a-5434-467c-abb2-dd2806ab81d0@arm.com>
Date: Fri, 20 Jun 2025 20:37:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
 will@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, nicolas.dufresne@collabora.com, jgg@ziepe.ca
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
Content-Language: en-GB
In-Reply-To: <20250619131232.69208-4-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/06/2025 2:12 pm, Benjamin Gaignard wrote:
> The Verisilicon IOMMU hardware block can be found in combination
> with Verisilicon hardware video codecs (encoders or decoders) on
> different SoCs.
> Enable it will allow us to use non contiguous memory allocators
> for Verisilicon video codecs.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> changes in version 3:
> - Change compatible to "rockchip,rk3588-iommu-1.2"
> - Create an identity domain for the driver
> - Fix double flush issue
> - Rework attach/detach logic
> - Simplify xlate function
> - Discover iommu device like done in ARM driver
> - Remove ARM_DMA_USE_IOMMU from Kconfig
> 
>   drivers/iommu/Kconfig     |  11 +
>   drivers/iommu/Makefile    |   1 +
>   drivers/iommu/vsi-iommu.c | 874 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 886 insertions(+)
>   create mode 100644 drivers/iommu/vsi-iommu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 0a33d995d15d..3e95d1db737b 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -383,4 +383,15 @@ config SPRD_IOMMU
>   
>   	  Say Y here if you want to use the multimedia devices listed above.
>   
> +config VSI_IOMMU
> +	tristate "Verisilicon IOMMU Support"
> +	depends on ARM64

"(ARCH_ROCKCHIP && ARM64) || COMPILE_TEST", probably. Otherwise you 
might risk annoying Geert :)

> +	select IOMMU_API
> +	help
> +	  Support for IOMMUs used by Verisilicon sub-systems like video
> +	  decoders or encoder hardware blocks.
> +
> +	  Say Y here if you want to use this IOMMU in front of these
> +	  hardware blocks.
> +
>   endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 355294fa9033..68aeff31af8b 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>   obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
>   obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
>   obj-$(CONFIG_APPLE_DART) += apple-dart.o
> +obj-$(CONFIG_VSI_IOMMU) += vsi-iommu.o
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> new file mode 100644
> index 000000000000..89e63a6a60c1
> --- /dev/null
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -0,0 +1,874 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Collabora Ltd.
> + *
> + * IOMMU API for Verisilicon
> + *
> + * Module Authors:	Yandong Lin <yandong.lin@rock-chips.com>
> + *			Simon Xue <xxm@rock-chips.com>
> + *			Benjamin Gaignard <benjamin.gaignard@collabora.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>

This shouldn't be here, it's a device driver not a DMA API implementation.

> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include "iommu-pages.h"
> +
> +struct vsi_iommu {
> +	struct device *dev;
> +	void __iomem **bases;
> +	int num_mmu;

What are these for, given the binding specifies a single "reg"?

If you do anticipate supporting multiple MMUs per client device, I would 
still strongly consider following the exynos-iommu approach of linking 
distinct instances together internally - the "single instance with 
multiple interfaces" model is a bit of a bodge, and has the big weakness 
that you tend to end up forever having to evolve the "clocks", 
"interrupts" etc. bindings in weird and arbitrary ways for different 
integrations. Especially if this is a 3rd-party IP that's liable to be 
used by multiple different SoC vendors.

> +	int num_irq;
> +	struct clk_bulk_data *clocks;
> +	int num_clocks;
> +	struct iommu_device iommu;
> +	struct list_head node; /* entry in vsi_iommu_domain.iommus */
> +	struct iommu_domain *domain; /* domain to which iommu is attached */
> +};
> +
> +struct vsi_iommu_domain {
> +	struct device *dma_dev;
> +	struct list_head iommus;
> +	u32 *dt; /* page directory table */
> +	dma_addr_t dt_dma;
> +	spinlock_t iommus_lock; /* lock for iommus list */
> +	spinlock_t dt_lock; /* lock for modifying page directory table */
> +	struct iommu_domain domain;
> +	/* for vsi iommu */

Wait, so who is the rest of this driver-private structure for, if not 
also for this driver? :/

> +	u64 *pta; /* page directory table */
> +	dma_addr_t pta_dma;
> +};
> +
> +static struct iommu_domain vsi_identity_domain;
> +
> +#define NUM_DT_ENTRIES	1024
> +#define NUM_PT_ENTRIES	1024
> +#define PT_SIZE		(NUM_PT_ENTRIES * sizeof(u32))
> +
> +#define SPAGE_SIZE	BIT(12)
> +
> +/* vsi iommu regs address */
> +#define VSI_MMU_CONFIG1_BASE			0x1ac
> +#define VSI_MMU_AHB_EXCEPTION_BASE		0x380
> +#define VSI_MMU_AHB_CONTROL_BASE		0x388
> +#define VSI_MMU_AHB_TBL_ARRAY_BASE_L_BASE	0x38C
> +
> +/* MMU register offsets */
> +#define VSI_MMU_FLUSH_BASE		0x184
> +#define VSI_MMU_BIT_FLUSH		BIT(4)
> +
> +#define VSI_MMU_PAGE_FAULT_ADDR		0x380
> +#define VSI_MMU_STATUS_BASE		0x384	/* IRQ status */
> +
> +#define VSI_MMU_BIT_ENABLE		BIT(0)
> +
> +#define VSI_MMU_OUT_OF_BOUND		BIT(28)
> +/* Irq mask */
> +#define VSI_MMU_IRQ_MASK		0x7
> +
> +#define VSI_DTE_PT_ADDRESS_MASK		0xffffffc0

I'm curious what those lowest 6 bits are for - does it really only 
require 64-byte alignment for pagetables, or can it actually accommodate 
a folded >32-bit address similar to the PTE level?

> +#define VSI_DTE_PT_VALID		BIT(0)
> +
> +#define VSI_PAGE_DESC_LO_MASK		0xfffff000
> +#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
> +#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)
> +
> +static inline phys_addr_t vsi_dte_pt_address(u32 dte)
> +{
> +	return (phys_addr_t)dte & VSI_DTE_PT_ADDRESS_MASK;
> +}
> +
> +static inline u32 vsi_mk_dte(u32 dte)
> +{
> +	return (phys_addr_t)dte | VSI_DTE_PT_VALID;
> +}
> +
> +#define VSI_PTE_PAGE_ADDRESS_MASK	0xfffffff0
> +#define VSI_PTE_PAGE_WRITABLE		BIT(2)

Any idea if there are other useful permission bits?

> +#define VSI_PTE_PAGE_VALID		BIT(0)
> +
> +static inline phys_addr_t vsi_pte_page_address(u32 pte)
> +{
> +	u64 pte_vsi = pte;
> +
> +	pte_vsi = ((pte_vsi & VSI_PAGE_DESC_HI_MASK) << VSI_PAGE_DESC_HI_SHIFT) |

"(pte_vsi & VSI_PAGE_DESC_HI_MASK)" will by definition be 0.

> +		  (pte_vsi & VSI_PAGE_DESC_LO_MASK);
> +
> +	return (phys_addr_t)pte_vsi;
> +}
> +
> +static u32 vsi_mk_pte(phys_addr_t page, int prot)
> +{
> +	u32 flags = 0;
> +
> +	flags |= (prot & IOMMU_WRITE) ? VSI_PTE_PAGE_WRITABLE : 0;
> +	page = (page & VSI_PAGE_DESC_LO_MASK) |
> +	       ((page & VSI_PAGE_DESC_HI_MASK) >> VSI_PAGE_DESC_HI_SHIFT);
> +	page &= VSI_PTE_PAGE_ADDRESS_MASK;

If VSI_PAGE_DESC_LO_MASK and VSI_PAGE_DESC_HI_MASK are correct to start 
with then VSI_PTE_PAGE_ADDRESS_MASK serves no purpose.

> +	return page | flags | VSI_PTE_PAGE_VALID;
> +}
> +
> +#define VSI_DTE_PT_VALID	BIT(0)
> +
> +static inline bool vsi_dte_is_pt_valid(u32 dte)
> +{
> +	return dte & VSI_DTE_PT_VALID;
> +}
> +
> +static inline bool vsi_pte_is_page_valid(u32 pte)
> +{
> +	return pte & VSI_PTE_PAGE_VALID;
> +}
> +
> +static u32 vsi_mk_pte_invalid(u32 pte)
> +{
> +	return pte & ~VSI_PTE_PAGE_VALID;
> +}
> +
> +#define VSI_MASTER_TLB_MASK	GENMASK_ULL(31, 10)

I note that this ends up being associated with the 
VSI_MMU_AHB_TBL_ARRAY_BASE_L_BASE register - is the "TLB"/"TBL" 
difference a typo one way or the other, or definitely intentional?

(For all I know maybe it really could be a table of translation 
lookaside bufers?)

> +/* mode 0 : 4k */
> +#define VSI_PTA_4K_MODE	0
> +
> +static u64 vsi_mk_pta(dma_addr_t dt_dma)
> +{
> +	u64 val = (dt_dma & VSI_MASTER_TLB_MASK) | VSI_PTA_4K_MODE;
> +
> +	return val;
> +}
> +
> +static struct vsi_iommu_domain *to_vsi_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct vsi_iommu_domain, domain);
> +}
> +
> +static void vsi_iommu_disable(struct vsi_iommu *iommu)
> +{
> +	int i;
> +
> +	/* Ignore error while disabling, just keep going */

FWIW I thought that comment was wrong at first, because we're clearly 
not disabling the clocks...

> +	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> +	for (i = 0; i < iommu->num_mmu; i++)
> +		writel(0, iommu->bases[i] + VSI_MMU_AHB_CONTROL_BASE);

However, even if the IOMMU itself is going away, is it really safe to 
ignore an error if it means we could risk hanging on an unclocked 
register access here?

> +	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +}
> +
> +static int vsi_iommu_enable(struct vsi_iommu *iommu)
> +{
> +	struct iommu_domain *domain = iommu->domain;
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	int ret, i;
> +
> +	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < iommu->num_mmu; i++) {
> +		u32 val = readl(iommu->bases[i] + VSI_MMU_AHB_CONTROL_BASE);
> +
> +		if (!(val & VSI_MMU_BIT_ENABLE)) {

If the hardware happens to be enabled already, can you be sure it's 
enabled *with the expected configuration*?

> +			writel(vsi_domain->pta_dma,
> +			       iommu->bases[i] + VSI_MMU_AHB_TBL_ARRAY_BASE_L_BASE);
> +			writel(VSI_MMU_OUT_OF_BOUND, iommu->bases[i] + VSI_MMU_CONFIG1_BASE);
> +			writel(VSI_MMU_BIT_ENABLE, iommu->bases[i] + VSI_MMU_AHB_EXCEPTION_BASE);
> +			writel(VSI_MMU_BIT_ENABLE, iommu->bases[i] + VSI_MMU_AHB_CONTROL_BASE);
> +		}
> +	}
> +	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +
> +	return ret;
> +}
> +
> +static inline void vsi_table_flush(struct vsi_iommu_domain *vsi_domain, dma_addr_t dma,
> +				   unsigned int count)
> +{
> +	size_t size = count * sizeof(u32); /* count of u32 entry */
> +
> +	dma_sync_single_for_device(vsi_domain->dma_dev, dma, size, DMA_TO_DEVICE);
> +}
> +
> +#define VSI_IOVA_DTE_MASK	0xffc00000
> +#define VSI_IOVA_DTE_SHIFT	22
> +#define VSI_IOVA_PTE_MASK	0x003ff000
> +#define VSI_IOVA_PTE_SHIFT	12
> +#define VSI_IOVA_PAGE_MASK	0x00000fff
> +#define VSI_IOVA_PAGE_SHIFT	0
> +
> +static u32 vsi_iova_dte_index(dma_addr_t iova)
> +{
> +	return (u32)(iova & VSI_IOVA_DTE_MASK) >> VSI_IOVA_DTE_SHIFT;

Are these u32 casts really necessary? At worst, why not just make the 
"iova" argument u32 to begin with?

> +}
> +
> +static u32 vsi_iova_pte_index(dma_addr_t iova)
> +{
> +	return (u32)(iova & VSI_IOVA_PTE_MASK) >> VSI_IOVA_PTE_SHIFT;
> +}
> +
> +static u32 vsi_iova_page_offset(dma_addr_t iova)
> +{
> +	return (u32)(iova & VSI_IOVA_PAGE_MASK) >> VSI_IOVA_PAGE_SHIFT;
> +}
> +
> +static u32 vsi_iommu_read(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static void vsi_iommu_write(void __iomem *base, u32 offset, u32 value)
> +{
> +	writel(value, base + offset);
> +}

Ditch these read/write wrappers, they're used all of once, and they're 
still longer than just writing out the straightforward readl/writel 
directly. Abstracting a structure member dereference is one thing, but 
abstracting a single addition is entirely unnecessary.

> +static void vsi_iommu_flush_tlb_all(struct iommu_domain *domain)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	struct list_head *pos;
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
> +	list_for_each(pos, &vsi_domain->iommus) {
> +		struct vsi_iommu *iommu;
> +		int ret;
> +
> +		iommu = list_entry(pos, struct vsi_iommu, node);
> +		ret = pm_runtime_get_if_in_use(iommu->dev);
> +		if (WARN_ON_ONCE(ret < 0))
> +			continue;
> +		if (ret) {
> +			WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));

Again, would it really be OK to go ahead and access a potentially 
unclocked register?

TBH I'd drop all this busywork with the clocks altogether, and just 
enable/disable them in the runtime PM callbacks. I can't imagine the 
IOMMU would actually work very well with its core clock stopped anyway - 
presumably you're only getting away with it in this case because the 
clocks are shared with the codec so that's keeping them enabled while 
there is traffic for the IOMMU to translate. If someone really really 
really wants to gate the interface clock between register accesses on 
some other platform where it would have an effect, they can always come 
back and add that later.

> +			for (i = 0; i < iommu->num_mmu; i++) {
> +				writel(VSI_MMU_BIT_FLUSH,
> +				       iommu->bases[i] + VSI_MMU_FLUSH_BASE);
> +				writel(0, iommu->bases[i] + VSI_MMU_FLUSH_BASE);

That's curious - you set the bit, then explicitly clear it again 
imemdiately, but don't have to wait for any kind of completion status?

> +			}
> +			clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +			pm_runtime_put(iommu->dev);
> +		}
> +	}
> +	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
> +}
> +
> +static irqreturn_t vsi_iommu_irq(int irq, void *dev_id)
> +{
> +	struct vsi_iommu *iommu = dev_id;
> +	u32 int_status;
> +	dma_addr_t iova;
> +	irqreturn_t ret = IRQ_NONE;
> +	int i, err;
> +
> +	err = pm_runtime_get_if_in_use(iommu->dev);
> +	if (!err || WARN_ON_ONCE(err < 0))
> +		return ret;
> +
> +	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
> +		goto out;
> +
> +	for (i = 0; i < iommu->num_mmu; i++) {
> +		int_status = vsi_iommu_read(iommu->bases[i], VSI_MMU_STATUS_BASE);
> +		if (int_status & VSI_MMU_IRQ_MASK) {
> +			dev_err(iommu->dev, "unexpected int_status=%08x\n", int_status);
> +			iova = vsi_iommu_read(iommu->bases[i], VSI_MMU_PAGE_FAULT_ADDR);
> +
> +			if (iommu->domain)

The current domain should never be NULL. You should default to either a 
blocking or bypass domain (depending on the hardware behaiour), and 
initialise that before you ever even request the IRQ.

> +				report_iommu_fault(iommu->domain, iommu->dev, iova, int_status);
> +			else
> +				dev_err(iommu->dev,
> +					"Page fault while iommu not attached to domain?\n");
> +		}
> +		vsi_iommu_write(iommu->bases[i], VSI_MMU_STATUS_BASE, 0);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +
> +out:
> +	pm_runtime_put(iommu->dev);
> +	return ret;
> +}
> +
> +static struct vsi_iommu *vsi_iommu_get_from_dev(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device *iommu_dev = bus_find_device_by_fwnode(&platform_bus_type,
> +							     fwspec->iommu_fwnode);
> +
> +	put_device(iommu_dev);
> +
> +	return iommu_dev ? dev_get_drvdata(iommu_dev) : NULL;
> +}
> +
> +static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = vsi_iommu_get_from_dev(dev);

Use dev_iommu_priv_get() - we get here via a dev_iommu_ops() lookup, so 
dev is already guaranteed to be one of your clients.

> +	struct vsi_iommu_domain *vsi_domain;
> +
> +	vsi_domain = kzalloc(sizeof(*vsi_domain), GFP_KERNEL);
> +	if (!vsi_domain)
> +		return NULL;
> +
> +	vsi_domain->dma_dev = iommu->dev;
> +	iommu->domain = &vsi_identity_domain;

Nope, that should only happen when the domain is actually attached.

> +	/*
> +	 * iommu use a 2 level pagetable.
> +	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
> +	 * Allocate one 4 KiB page for each table.
> +	 */
> +	vsi_domain->dt = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
> +					      SPAGE_SIZE);
> +	if (!vsi_domain->dt)
> +		goto err_free_domain;
> +
> +	vsi_domain->dt_dma = dma_map_single(vsi_domain->dma_dev, vsi_domain->dt,
> +					    SPAGE_SIZE, DMA_TO_DEVICE);
> +	if (dma_mapping_error(vsi_domain->dma_dev, vsi_domain->dt_dma)) {
> +		dev_err(vsi_domain->dma_dev, "DMA map error for DT\n");
> +		goto err_free_dt;
> +	}
> +
> +	vsi_domain->pta = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
> +					       SPAGE_SIZE);
> +	if (!vsi_domain->pta)
> +		goto err_unmap_dt;
> +
> +	vsi_domain->pta[0] = vsi_mk_pta(vsi_domain->dt_dma);
> +	vsi_domain->pta_dma = dma_map_single(vsi_domain->dma_dev, vsi_domain->pta,
> +					     SPAGE_SIZE, DMA_TO_DEVICE);
> +	if (dma_mapping_error(vsi_domain->dma_dev, vsi_domain->pta_dma)) {
> +		dev_err(vsi_domain->dma_dev, "DMA map error for PTA\n");
> +		goto err_free_pta;
> +	}

I'm especially curious what this "pta" really is - is the comment above 
just wrong, and you've actually got a 3-level pagetable supporting 
somewhere between 33 and 42 bits of VA? If not, then the additional 
level of indirection would very much seem to imply some kind of 
mechanism for accommodating multiple pagetables at once, and in that 
case, is it like a PASID table where the client device gets to choose 
which entry to use, or a StreamID table to disambiguate multiple client 
devices? (Where in the latter case it should most likely belong to the 
IOMMU rather than the domain, and you probably want nonzero #iommu-cells 
in the DT binding for the client IDs).

> +	spin_lock_init(&vsi_domain->iommus_lock);
> +	spin_lock_init(&vsi_domain->dt_lock);
> +	INIT_LIST_HEAD(&vsi_domain->iommus);
> +
> +	vsi_domain->domain.geometry.aperture_start = 0;
> +	vsi_domain->domain.geometry.aperture_end   = DMA_BIT_MASK(32);
> +	vsi_domain->domain.geometry.force_aperture = true;
> +	vsi_domain->domain.pgsize_bitmap = SZ_4K;
> +
> +	return &vsi_domain->domain;
> +
> +err_free_pta:
> +	iommu_free_pages(vsi_domain->pta);
> +err_unmap_dt:
> +	dma_unmap_single(vsi_domain->dma_dev, vsi_domain->dt_dma,
> +			 SPAGE_SIZE, DMA_TO_DEVICE);
> +err_free_dt:
> +	iommu_free_pages(vsi_domain->dt);
> +err_free_domain:
> +	kfree(vsi_domain);
> +
> +	return NULL;
> +}
> +
> +static phys_addr_t vsi_iommu_iova_to_phys(struct iommu_domain *domain,
> +					  dma_addr_t iova)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	phys_addr_t pt_phys, phys = 0;
> +	u32 dte, pte;
> +	u32 *page_table;
> +
> +	spin_lock_irqsave(&vsi_domain->dt_lock, flags);
> +
> +	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
> +	if (!vsi_dte_is_pt_valid(dte))
> +		goto out;
> +
> +	pt_phys = vsi_dte_pt_address(dte);
> +	page_table = (u32 *)phys_to_virt(pt_phys);
> +	pte = page_table[vsi_iova_pte_index(iova)];
> +	if (!vsi_pte_is_page_valid(pte))
> +		goto out;
> +
> +	phys = vsi_pte_page_address(pte) + vsi_iova_page_offset(iova);
> +out:
> +	spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
> +
> +	return phys;
> +}
> +
> +static u32 *vsi_dte_get_page_table(struct vsi_iommu_domain *vsi_domain, dma_addr_t iova)
> +{
> +	u32 *page_table, *dte_addr;
> +	u32 dte_index, dte;
> +	phys_addr_t pt_phys;
> +	dma_addr_t pt_dma;
> +
> +	assert_spin_locked(&vsi_domain->dt_lock);
> +
> +	dte_index = vsi_iova_dte_index(iova);
> +	dte_addr = &vsi_domain->dt[dte_index];
> +	dte = *dte_addr;
> +	if (vsi_dte_is_pt_valid(dte))
> +		goto done;
> +
> +	page_table = (u32 *)iommu_alloc_pages_sz(GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);
> +	if (!page_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dte = vsi_mk_dte(virt_to_phys(page_table));

No no no no no. You're already generating pt_dma the correct way just 
below, use it! By all means *check* what dma_map_single() returns to 
make sure you're not getting any unexpected translation/bounce-buffering 
if you want to be able to rely on using phys_to_virt() as a shortcut 
later, but never blindly assume that virt_to_phys() is appropriate for 
DMA (for instance, what if CONFIG_ZONE_DMA32 isn't enabled so page_table 
ended up at a >32-bit address?)

> +	*dte_addr = dte;
> +
> +	pt_dma = dma_map_single(vsi_domain->dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
> +	if (dma_mapping_error(vsi_domain->dma_dev, pt_dma)) {
> +		dev_err(vsi_domain->dma_dev, "DMA mapping error while allocating page table\n");
> +		iommu_free_pages(page_table);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	vsi_table_flush(vsi_domain,
> +			vsi_domain->dt_dma + dte_index * sizeof(u32), 1);

The oreder seems a bit jumbled up here as well - it would be safest to 
get everything done with page_table itself first, *then* worry about 
updating the DTE to point to it.

> +done:
> +	pt_phys = vsi_dte_pt_address(dte);
> +	return (u32 *)phys_to_virt(pt_phys);
> +}
> +
> +static size_t vsi_iommu_unmap_iova(struct vsi_iommu_domain *vsi_domain,
> +				   u32 *pte_addr, dma_addr_t pte_dma,
> +				   size_t size)
> +{
> +	unsigned int pte_count;
> +	unsigned int pte_total = size / SPAGE_SIZE;
> +
> +	assert_spin_locked(&vsi_domain->dt_lock);
> +
> +	for (pte_count = 0; pte_count < pte_total; pte_count++) {
> +		u32 pte = pte_addr[pte_count];

What prevents this running off the end of the pagetable page? AFAICS 
you're not capping "size" to DTE boundaries in the main callback either.

> +
> +		if (!vsi_pte_is_page_valid(pte))
> +			break;
> +
> +		pte_addr[pte_count] = vsi_mk_pte_invalid(pte);
> +	}
> +
> +	vsi_table_flush(vsi_domain, pte_dma, pte_count);
> +
> +	return pte_count * SPAGE_SIZE;
> +}
> +
> +static int vsi_iommu_map_iova(struct vsi_iommu_domain *vsi_domain, u32 *pte_addr,
> +			      dma_addr_t pte_dma, dma_addr_t iova,
> +			      phys_addr_t paddr, size_t size, int prot)
> +{
> +	unsigned int pte_count;
> +	unsigned int pte_total = size / SPAGE_SIZE;
> +
> +	assert_spin_locked(&vsi_domain->dt_lock);
> +
> +	for (pte_count = 0; pte_count < pte_total; pte_count++) {
> +		u32 pte = pte_addr[pte_count];
> +
> +		if (vsi_pte_is_page_valid(pte))
> +			goto unwind;
> +
> +		pte_addr[pte_count] = vsi_mk_pte(paddr, prot);
> +
> +		paddr += SPAGE_SIZE;
> +	}
> +
> +	vsi_table_flush(vsi_domain, pte_dma, pte_total);
> +
> +	return 0;
> +unwind:
> +	/* Unmap the range of iovas that we just mapped */
> +	vsi_iommu_unmap_iova(vsi_domain, pte_addr, pte_dma,
> +			     pte_count * SPAGE_SIZE);

If you failed to map anything, return an error; otherwise, just return 
however much you did map successfully. The IOMMU core will take care of 
the rest.

> +
> +	return -EADDRINUSE;
> +}
> +
> +static size_t vsi_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
> +			      size_t size, size_t count, struct iommu_iotlb_gather *gather)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
> +	phys_addr_t pt_phys;
> +	u32 dte;
> +	u32 *pte_addr;
> +	size_t unmap_size;
> +
> +	spin_lock_irqsave(&vsi_domain->dt_lock, flags);
> +
> +	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
> +	/* Just return 0 if iova is unmapped */
> +	if (!vsi_dte_is_pt_valid(dte)) {
> +		spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
> +		return 0;
> +	}
> +
> +	pt_phys = vsi_dte_pt_address(dte);
> +	pte_addr = (u32 *)phys_to_virt(pt_phys) + vsi_iova_pte_index(iova);
> +	pte_dma = pt_phys + vsi_iova_pte_index(iova) * sizeof(u32);
> +	unmap_size = vsi_iommu_unmap_iova(vsi_domain, pte_addr, pte_dma, size);
> +
> +	spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
> +
> +	return unmap_size;
> +}
> +
> +static int vsi_iommu_map(struct iommu_domain *domain, unsigned long _iova,
> +			 phys_addr_t paddr, size_t size, size_t count,
> +			 int prot, gfp_t gfp, size_t *mapped)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
> +	u32 *page_table, *pte_addr;
> +	u32 dte, pte_index;
> +	int ret;
> +
> +	/*
> +	 * IOMMU drivers are not supposed to lock the page table, however this
> +	 * driver does not safely handle the cache flushing or table
> +	 * installation across concurrent threads so locking is used as a simple
> +	 * solution.
> +	 */

No need for that comment - it's perfectly fine for IOMMU drivers to 
serialise pagetable accesses if they want to. Of course if they're the 
kind of IOMMU that will find itself in a big server system with hundreds 
on CPUs mapping and unmapping tens of thousands of network packets per 
second in parallel, then for sure it's inadvisable from a performance 
perspective, but for a little embedded IOMMU that's only going to be 
handling relatively long-lived media buffers there is absolutely nothing 
wrong with simple and straightforward. In fact if you had tried to do 
clever lock-free stuff here, I would definitely be asking "do you really 
need this?" :)

> +	spin_lock_irqsave(&vsi_domain->dt_lock, flags);
> +
> +	page_table = vsi_dte_get_page_table(vsi_domain, iova);
> +	if (IS_ERR(page_table)) {
> +		spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
> +		return PTR_ERR(page_table);
> +	}
> +
> +	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
> +	pte_index = vsi_iova_pte_index(iova);
> +	pte_addr = &page_table[pte_index];
> +	pte_dma = vsi_dte_pt_address(dte) + pte_index * sizeof(u32);
> +	ret = vsi_iommu_map_iova(vsi_domain, pte_addr, pte_dma, iova,
> +				 paddr, size, prot);
> +
> +	spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
> +	if (!ret)
> +		*mapped = size;
> +
> +	return ret;
> +}
> +
> +static int vsi_iommu_identity_attach(struct iommu_domain *domain,
> +				     struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	int ret;
> +
> +	if (WARN_ON(!iommu))
> +		return -ENODEV;

That can never happen. The domain is already validated against the 
device ops in __iommu_attach_group().

> +
> +	if (iommu->domain == domain)
> +		return 0;
> +
> +	iommu->domain = domain;
> +
> +	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);

Erm, what lock? vsi_identity_domain is a plain struct iommu_domain, so 
this vsi_domain pointer has container_of()ed out into other adjacent 
static data... :O

> +	list_del_init(&iommu->node);
> +	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
> +
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	WARN_ON_ONCE(ret < 0);
> +	if (ret > 0) {
> +		vsi_iommu_disable(iommu);
> +		pm_runtime_put(iommu->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct iommu_domain_ops vsi_identity_ops = {

Const.

> +	.attach_dev = vsi_iommu_identity_attach,
> +};
> +
> +static struct iommu_domain vsi_identity_domain = {
> +	.type = IOMMU_DOMAIN_IDENTITY,
> +	.ops = &vsi_identity_ops,
> +};
> +
> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	int ret;
> +
> +	if (WARN_ON(!iommu))
> +		return -ENODEV;

Similarly impossible.

> +
> +	/* iommu already attached */
> +	if (iommu->domain == domain)
> +		return 0;
> +
> +	ret = vsi_iommu_identity_attach(&vsi_identity_domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	iommu->domain = domain;
> +
> +	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
> +	list_add_tail(&iommu->node, &vsi_domain->iommus);
> +	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
> +
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	if (!ret || WARN_ON_ONCE(ret < 0))
> +		return 0;
> +
> +	ret = vsi_iommu_enable(iommu);
> +	if (ret)
> +		WARN_ON(vsi_iommu_identity_attach(&vsi_identity_domain, dev));
> +
> +	pm_runtime_put(iommu->dev);
> +
> +	return ret;
> +}
> +
> +static void vsi_iommu_domain_free(struct iommu_domain *domain)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	int i;
> +
> +	WARN_ON(!list_empty(&vsi_domain->iommus));
> +
> +	for (i = 0; i < NUM_DT_ENTRIES; i++) {
> +		u32 dte = vsi_domain->dt[i];
> +
> +		if (vsi_dte_is_pt_valid(dte)) {
> +			phys_addr_t pt_phys = vsi_dte_pt_address(dte);
> +			u32 *page_table = phys_to_virt(pt_phys);
> +
> +			dma_unmap_single(vsi_domain->dma_dev, pt_phys,
> +					 SPAGE_SIZE, DMA_TO_DEVICE);
> +			iommu_free_pages(page_table);
> +		}
> +	}
> +
> +	dma_unmap_single(vsi_domain->dma_dev, vsi_domain->dt_dma,
> +			 SPAGE_SIZE, DMA_TO_DEVICE);
> +	iommu_free_pages(vsi_domain->dt);
> +
> +	dma_unmap_single(vsi_domain->dma_dev, vsi_domain->pta_dma,
> +			 SPAGE_SIZE, DMA_TO_DEVICE);
> +	iommu_free_pages(vsi_domain->pta);
> +
> +	kfree(vsi_domain);
> +}
> +
> +static struct iommu_device *vsi_iommu_probe_device(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = vsi_iommu_get_from_dev(dev);
> +	struct device_link *link;
> +
> +	if (WARN_ON(!iommu))
> +		return ERR_PTR(-ENODEV);

Either don't have this check at all (since it's redundant if you're 
using fwspecs and of_xlate), or don't make it a WARN_ON (if you want the 
impression of supporting non-fwspec usage where probe_device is the one 
op where the core *does* give you "is this your client device?" calls).

> +	link = device_link_add(dev, iommu->dev,
> +			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> +	if (!link)
> +		dev_err(dev, "Unable to link %s\n", dev_name(iommu->dev));
> +
> +	dev_iommu_priv_set(dev, iommu);
> +	return &iommu->iommu;
> +}
> +
> +static void vsi_iommu_release_device(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +
> +	device_link_remove(dev, iommu->dev);
> +}
> +
> +static int vsi_iommu_of_xlate(struct device *dev,
> +			      const struct of_phandle_args *args)
> +{
> +	return iommu_fwspec_add_ids(dev, args->args, 1);

What are you adding here? Per the DT binding there are no IDs, so 
args->args_count will be 0 and args->args will be most likely be 
uninitialised stack.

> +}
> +
> +static struct iommu_ops vsi_iommu_ops = {

Const.

> +	.identity_domain = &vsi_identity_domain,
> +	.domain_alloc_paging = vsi_iommu_domain_alloc_paging,
> +	.probe_device = vsi_iommu_probe_device,
> +	.release_device = vsi_iommu_release_device,
> +	.device_group = generic_single_device_group,
> +	.of_xlate = vsi_iommu_of_xlate,
> +	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.attach_dev		= vsi_iommu_attach_device,
> +		.map_pages		= vsi_iommu_map,
> +		.unmap_pages		= vsi_iommu_unmap,
> +		.flush_iotlb_all	= vsi_iommu_flush_tlb_all,
> +		.iova_to_phys		= vsi_iommu_iova_to_phys,
> +		.free			= vsi_iommu_domain_free,
> +	}
> +};
> +
> +static const struct of_device_id vsi_iommu_dt_ids[] = {
> +	{
> +		.compatible = "verisilicon,iommu",
> +	},
> +	{
> +		.compatible = "rockchip,rk3588-iommu-1.2",

You can drop this - if the driver doesn't have any SoC-specific 
behaviour then we only need to match the generic compatible here. As 
long as the SoC-specific compatibles are in the binding, and thus in 
deployed DTBs, we can start making use of them in future as and when we 
have a reason to.

> +	},
> +	{ /* sentinel */ }
> +};
> +
> +static int vsi_iommu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct vsi_iommu *iommu;
> +	struct resource *res;
> +	int num_res = pdev->num_resources;
> +	int err, i;
> +
> +	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +	if (!iommu)
> +		return -ENOMEM;
> +
> +	iommu->dev = dev;
> +	iommu->num_mmu = 0;
> +
> +	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
> +				    GFP_KERNEL);
> +	if (!iommu->bases)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_res; i++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			continue;
> +		iommu->bases[i] = devm_ioremap_resource(&pdev->dev, res);

Consider devm_platform_ioremap_resource().

> +		if (IS_ERR(iommu->bases[i]))
> +			continue;
> +		iommu->num_mmu++;
> +	}
> +	if (iommu->num_mmu == 0)
> +		return PTR_ERR(iommu->bases[0]);
> +
> +	iommu->num_irq = platform_irq_count(pdev);
> +	if (iommu->num_irq < 0)
> +		return iommu->num_irq;
> +
> +	err = devm_clk_bulk_get_all(dev, &iommu->clocks);
> +	if (err >= 0)
> +		iommu->num_clocks = err;
> +	else if (err == -ENOENT)
> +		iommu->num_clocks = 0;
> +	else
> +		return err;
> +
> +	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
> +	if (err)
> +		return err;

I wonder if devm_clk_bulk_get_all_enabled() might help here, but if you 
do want to do any subsequent management then quite possibly it just 
shifts the complexity to making sure they're reenabled in all the paths 
where they can be released again :/

> +
> +	for (i = 0; i < iommu->num_irq; i++) {
> +		int irq = platform_get_irq(pdev, i);

As with num_mmu, according to your binding num_irq must be exactly 1. Do 
you really need the pretence of supporting more or fewer?

> +
> +		if (irq < 0)
> +			return irq;
> +
> +		err = devm_request_irq(iommu->dev, irq, vsi_iommu_irq,
> +				       IRQF_SHARED, dev_name(dev), iommu);
> +		if (err)
> +			goto err_unprepare_clocks;
> +	}
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	platform_set_drvdata(pdev, iommu);
> +
> +	pm_runtime_enable(dev);
> +
> +	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
> +	if (err)
> +		goto err_runtime_disable;
> +
> +	err = iommu_device_register(&iommu->iommu, &vsi_iommu_ops, dev);
> +	if (err)
> +		goto err_remove_sysfs;
> +
> +	return 0;
> +
> +err_remove_sysfs:
> +	iommu_device_sysfs_remove(&iommu->iommu);
> +err_runtime_disable:
> +	pm_runtime_disable(dev);
> +err_unprepare_clocks:
> +	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
> +	return err;
> +}
> +
> +static void vsi_iommu_shutdown(struct platform_device *pdev)
> +{
> +	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < iommu->num_irq; i++) {
> +		int irq = platform_get_irq(pdev, i);
> +
> +		devm_free_irq(iommu->dev, irq, iommu);

Most devm_free calls are suspect in general, and this one is certainly 
no exception. Even if it justifiable to suppress IRQs during shutdown, 
can you not simply disable interrupt generation at the IOMMU end, or at 
worst just do a disable_irq()? In the shutdown path we really don't want 
to be doing any more work than absolutely necessary.

> +	}
> +
> +	pm_runtime_force_suspend(&pdev->dev);
> +}
> +
> +static int __maybe_unused vsi_iommu_suspend(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_get_drvdata(dev);
> +
> +	if (iommu->domain == &vsi_identity_domain)
> +		return 0;
> +
> +	vsi_iommu_disable(iommu);

This seems simlarly dubious - if suspend doesn't need to explicitly save 
any additional context for a subsequent resume then it shouldn't really 
do anything, certainly not change the state of IOMMU translation. At 
best that's a waste of time, at worst it risks unexpected faults or 
memory corruption (if a nominally-suspended client device is actually 
still running).

> +	return 0;
> +}
> +
> +static int __maybe_unused vsi_iommu_resume(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_get_drvdata(dev);
> +
> +	if (iommu->domain == &vsi_identity_domain)
> +		return 0;
> +
> +	return vsi_iommu_enable(iommu);
> +}
> +
> +static const struct dev_pm_ops vsi_iommu_pm_ops = {
> +	SET_RUNTIME_PM_OPS(vsi_iommu_suspend, vsi_iommu_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +};

Consider DEFINE_RUNTIME_DEV_PM_OPS().

> +static struct platform_driver rockchip_vsi_iommu_driver = {
> +	.probe = vsi_iommu_probe,
> +	.shutdown = vsi_iommu_shutdown,
> +	.driver = {
> +		   .name = "vsi_iommu",
> +		   .of_match_table = vsi_iommu_dt_ids,
> +		   .pm = &vsi_iommu_pm_ops,
> +		   .suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(rockchip_vsi_iommu_driver);

I guess that does technically work out when this is built as a module, 
as the device_initcall() gets redefined to module_init() and the lack of 
module_exit() just prevents removal (which in practice would be 
prevented by held references anyway)... But it still looks a bit odd.

Thanks,
Robin.
