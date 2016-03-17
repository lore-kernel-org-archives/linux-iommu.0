From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 02/04] iommu/ipmmu-vmsa: Rework interrupt code and use
	bitmap for context
Date: Thu, 17 Mar 2016 11:56:11 +0200
Message-ID: <1686102.s8m2vfSUhC@avalon>
References: <20160315042136.22103.26570.sendpatchset@little-apple>
	<20160315042155.22103.74587.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160315042155.22103.74587.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Tuesday 15 March 2016 13:21:55 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Introduce a bitmap for context handing and convert the
> interrupt routine to go handle all registered contexts.
> 
> At this point the number of contexts are still limited.
> 
> Also remove the use of the ARM specific mapping variable
> from ipmmu_irq() to allow compile on ARM64.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
> Changes since V1: (Thanks to Laurent for feedback!)
> - Use simple find_first_zero()/set_bit()/clear_bit() for context
>   management.
> - For allocation rely on spinlock held when calling
>   ipmmu_domain_init_context()

I'm afraid this is still racy. That spinlock belongs to the domain, and we 
have multiple domains. You need to add a new lock in the ipmmu_vmsa_device 
structure.

> - For test/free use atomic bitops
> - Return IRQ_HANDLED if any of the contexts generated interrupts
> 
> drivers/iommu/ipmmu-vmsa.c |   47 +++++++++++++++++++++++++++++------------
> 1 file changed, 35 insertions(+), 12 deletions(-)
> 
> --- 0003/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-03-15 12:42:18.940513000 +0900
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
> +	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
> 
>  	struct dma_iommu_mapping *mapping;
>  };
> @@ -296,6 +301,7 @@ static struct iommu_gather_ops ipmmu_gat
>  static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>  {
>  	u64 ttbr;
> +	int ret;
> 
>  	/*
>  	 * Allocate the page table operations.
> @@ -325,10 +331,17 @@ static int ipmmu_domain_init_context(str
>  		return -EINVAL;
> 
>  	/*
> -	 * TODO: When adding support for multiple contexts, find an unused
> -	 * context.
> +	 * Find an unused context.
>  	 */
> -	domain->context_id = 0;
> +	ret = find_first_zero_bit(domain->mmu->ctx, IPMMU_CTX_MAX);
> +	if (ret == IPMMU_CTX_MAX) {
> +		free_io_pgtable_ops(domain->iop);
> +		return -EBUSY;
> +	}
> +
> +	domain->context_id = ret;
> +	domain->mmu->domains[ret] = domain;
> +	set_bit(ret, domain->mmu->ctx);
> 
>  	/* TTBR0 */
>  	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
> @@ -372,6 +385,8 @@ static int ipmmu_domain_init_context(str
> 
>  static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
>  {
> +	clear_bit(domain->context_id, domain->mmu->ctx);
> +
>  	/*
>  	 * Disable the context. Flush the TLB as required when modifying the
>  	 * context registers.
> @@ -389,10 +404,15 @@ static void ipmmu_domain_destroy_context
>  static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  {
>  	const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
> -	struct ipmmu_vmsa_device *mmu = domain->mmu;
> +	struct ipmmu_vmsa_device *mmu;
>  	u32 status;
>  	u32 iova;
> 
> +	if (!domain)
> +		return IRQ_NONE;

Can this happen, as you test for the corresponding context bit before calling 
this function ?

> +
> +	mmu = domain->mmu;
> +
>  	status = ipmmu_ctx_read(domain, IMSTR);
>  	if (!(status & err_mask))
>  		return IRQ_NONE;
> @@ -437,16 +457,18 @@ static irqreturn_t ipmmu_domain_irq(stru
>  static irqreturn_t ipmmu_irq(int irq, void *dev)
>  {
>  	struct ipmmu_vmsa_device *mmu = dev;
> -	struct iommu_domain *io_domain;
> -	struct ipmmu_vmsa_domain *domain;
> -
> -	if (!mmu->mapping)
> -		return IRQ_NONE;
> +	irqreturn_t status = IRQ_NONE;
> +	unsigned int i;
> 
> -	io_domain = mmu->mapping->domain;
> -	domain = to_vmsa_domain(io_domain);
> +	/* Check interrupts for all active contexts */

Nitpicking, could you add a period at the end of the sentence to match the 
existing comment style ?

> +	for (i = 0; i < IPMMU_CTX_MAX; i++) {
> +		if (!test_bit(i, mmu->ctx))

test_bit() isn't atomic. Let's use explicit locking in every location where 
the contexts bitmap is accessed in a racy way.

> +			continue;
> +		if (ipmmu_domain_irq(mmu->domains[i]) == IRQ_HANDLED)
> +			status = IRQ_HANDLED;
> +	}
> 
> -	return ipmmu_domain_irq(domain);
> +	return status;
>  }
> 
>  /* ------------------------------------------------------------------------
> @@ -774,6 +796,7 @@ static int ipmmu_probe(struct platform_d
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
