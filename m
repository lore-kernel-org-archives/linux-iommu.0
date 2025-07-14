Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4198248F5F;
	Mon, 14 Jul 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494920; cv=none; b=MAc9l/Q8f8oYw5+dZiPL9CGGRbtsjL0rnVl2MezvOaVrSfaAGYeo6Uk/NM6TJq/XIZUavs74Sn8tRlueddofJ/onDs4d1ZavTSv/+Y3MGTG7AB9j/TXUmmKvajjUdMDMP8+ImIB9GSSwGJ2r0EfGELcFsSs9W+kdL177NJ9aF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494920; c=relaxed/simple;
	bh=wJpZOrDsWmR3OsD6VllKDLh4xwGIWO/czyVInoIGEZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUfUYmjev/Z7pMo/MFw4uf4OR2LxllfNuxj2wLiZqZOVDG+WJO2L6u1J8jXGgSKztGV2mBVChpnbbE7y7GfYdLemifaCfZeWbsd8972OX4+xuV5xaLk/ZXH2G5lYYeNbiCc6sINu1OSTAA+GRF8IdI8SUuYy6+psYc0AX6mSjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trqiWccH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trqiWccH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D4C4CEED;
	Mon, 14 Jul 2025 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752494917;
	bh=wJpZOrDsWmR3OsD6VllKDLh4xwGIWO/czyVInoIGEZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trqiWccHinVvUiKTbjbxlGMWU2TqEjXG1ph1pc6e/dbRniwMVzHuzjWYIgSx5zY/S
	 n5D2uxRV0KYpkK68a/cJLoWy6EL5T9gOnR/gn3oho6w6PNt2yN6auNj2N1sBc0hxNS
	 K7z1j2Wv5C+a4VkQX0nNSSHfaFqWPjmx6ML5znRkgmLNdCJ2EePrQ/dJOumtQ5juQO
	 MhHt4tzV/51KIrhrRL9QZrSi7xdFmlq2knGX0kFd2yhT+A5MBEqSPA4mRQwLs4Hq9C
	 nnfsZtPAl49b3+Q/oRzYUboKsiFIYphlM4myKDlEK5iq8hI2vUEMXC15ObePthXA9C
	 Q/UnTDZpVVzxw==
Date: Mon, 14 Jul 2025 13:08:31 +0100
From: Will Deacon <will@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <aHTzPwTob8_5rtBS@willie-the-truck>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710082450.125585-4-benjamin.gaignard@collabora.com>

Hi,

On Thu, Jul 10, 2025 at 10:24:44AM +0200, Benjamin Gaignard wrote:
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> new file mode 100644
> index 000000000000..15322b9929af
> --- /dev/null
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -0,0 +1,781 @@
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
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
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
> +	void __iomem *regs;
> +	struct clk_bulk_data *clocks;
> +	int num_clocks;
> +	struct iommu_device iommu;
> +	struct list_head node; /* entry in vsi_iommu_domain.iommus */
> +	struct iommu_domain *domain; /* domain to which iommu is attached */
> +	spinlock_t lock;
> +	int irq;
> +};
> +
> +struct vsi_iommu_domain {
> +	struct list_head iommus;
> +	struct device *dev;
> +	u32 *dt;
> +	dma_addr_t dt_dma;
> +	struct iommu_domain domain;
> +	u64 *pta;
> +	dma_addr_t pta_dma;
> +	spinlock_t lock;
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
> +#define VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE	0x38C
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
> +#define VSI_DTE_PT_VALID		BIT(0)
> +
> +#define VSI_PAGE_DESC_LO_MASK		0xfffff000
> +#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
> +#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)

How does this page-table format relate to the one supported already by
rockchip-iommu.c? From a quick glance, I suspect this is a derivative
and so ideally we'd be able to have a common implementation of the
page-table code which can be used by both of the drivers.

Similarly:

> +static void vsi_iommu_domain_free(struct iommu_domain *domain)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&vsi_domain->lock, flags);
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
> +			dma_unmap_single(vsi_domain->dev, pt_phys,
> +					 SPAGE_SIZE, DMA_TO_DEVICE);
> +			iommu_free_pages(page_table);
> +		}
> +	}
> +
> +	dma_unmap_single(vsi_domain->dev, vsi_domain->dt_dma,
> +			 SPAGE_SIZE, DMA_TO_DEVICE);
> +	iommu_free_pages(vsi_domain->dt);
> +
> +	dma_unmap_single(vsi_domain->dev, vsi_domain->pta_dma,
> +			 SPAGE_SIZE, DMA_TO_DEVICE);
> +	iommu_free_pages(vsi_domain->pta);
> +
> +	spin_unlock_irqrestore(&vsi_domain->lock, flags);
> +
> +	kfree(vsi_domain);
> +}

is almost a carbon copy of rk_iommu_domain_free(), so it seems that
there's room for code re-use even beyond the page-table support.

I think that also means we'll want Heiko's Ack before we merge anything.

Will
