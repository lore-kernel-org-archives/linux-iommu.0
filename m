From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 04/06] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
Date: Tue, 29 Dec 2015 02:14:22 +0200
Message-ID: <2341043.PcEjBaApc7@avalon>
References: <20151215120212.26216.61530.sendpatchset@little-apple> <20151215120249.26216.25148.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151215120249.26216.25148.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Tuesday 15 December 2015 21:02:49 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Introduce a bitmap for context handing and convert the
> interrupt routine to go handle all registered contexts.
> 
> At this point the number of contexts are still limited.

That's all nice, but without seeing support for multiple contexts it's hard to 
tell if the implementation is correct for multiple context purpose.

> The purpose of this patch is to remove the use of the
> ARM specific mapping variable from ipmmu_irq().

Why do you want to do that ?

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/iommu/ipmmu-vmsa.c |   37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> --- 0007/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 13:14:35.540513000 +0900
> @@ -8,6 +8,7 @@
>   * the Free Software Foundation; version 2 of the License.
>   */
> 
> +#include <linux/bitmap.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> @@ -26,12 +27,16 @@
> 
>  #include "io-pgtable.h"
> 
> +#define IPMMU_CTX_MAX 1
> +
>  struct ipmmu_vmsa_device {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct list_head list;
> 
>  	unsigned int num_utlbs;
> +	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);

We have up to 4 context on Gen2 and 8 on Gen3, a bitmap might be slightly 
overkill.

> +	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
> 
>  	struct dma_iommu_mapping *mapping;
>  };
> @@ -319,6 +324,7 @@ static struct iommu_gather_ops ipmmu_gat
>  static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>  {
>  	phys_addr_t ttbr;
> +	int ret;
> 
>  	/*
>  	 * Allocate the page table operations.
> @@ -348,10 +354,16 @@ static int ipmmu_domain_init_context(str
>  		return -EINVAL;
> 
>  	/*
> -	 * TODO: When adding support for multiple contexts, find an unused
> -	 * context.
> +	 * Find an unused context.

We need to support multiple devices per context or we will very soon run out 
of contexts. How to pick a proper context is a topic that needs to be 
researched, I believe IOMMU groups might come into play.

>  	 */
> -	domain->context_id = 0;
> +	ret = bitmap_find_free_region(domain->mmu->ctx, IPMMU_CTX_MAX, 0);
> +	if (ret < 0) {
> +		free_io_pgtable_ops(domain->iop);
> +		return ret;
> +	}
> +
> +	domain->context_id = ret;
> +	domain->mmu->domains[ret] = domain;

This requires locking to protect against races with the interrupt handler.

> 
>  	/* TTBR0 */
>  	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
> @@ -395,6 +407,8 @@ static int ipmmu_domain_init_context(str
> 
>  static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
>  {
> +	bitmap_release_region(domain->mmu->ctx, domain->context_id, 0);
> +
>  	/*
>  	 * Disable the context. Flush the TLB as required when modifying the
>  	 * context registers.
> @@ -460,16 +474,16 @@ static irqreturn_t ipmmu_domain_irq(stru
>  static irqreturn_t ipmmu_irq(int irq, void *dev)
>  {
>  	struct ipmmu_vmsa_device *mmu = dev;
> -	struct iommu_domain *io_domain;
> -	struct ipmmu_vmsa_domain *domain;
> -
> -	if (!mmu->mapping)
> -		return IRQ_NONE;
> +	irqreturn_t status = IRQ_NONE;
> +	unsigned int k;

i is a perfectly fine loop counter :-)

> -	io_domain = mmu->mapping->domain;
> -	domain = to_vmsa_domain(io_domain);
> +	/* Check interrupts for all active contexts */
> +	for (k = find_first_bit(mmu->ctx, IPMMU_CTX_MAX);
> +	     k < IPMMU_CTX_MAX && status == IRQ_NONE;
> +	     k = find_next_bit(mmu->ctx, IPMMU_CTX_MAX, k))

You can just loop over mmu->domains and skip NULL entries.

> +		status = ipmmu_domain_irq(mmu->domains[k]);

Only the status of the last domain is taken into account.

> -	return ipmmu_domain_irq(domain);
> +	return status;
>  }
> 
>  /* ------------------------------------------------------------------------
> @@ -788,6 +802,7 @@ static int ipmmu_probe(struct platform_d
> 
>  	mmu->dev = &pdev->dev;
>  	mmu->num_utlbs = 32;
> +	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
> 
>  	/* Map I/O memory and request IRQ. */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

-- 
Regards,

Laurent Pinchart

