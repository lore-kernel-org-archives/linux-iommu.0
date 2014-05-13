From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Tue, 13 May 2014 19:55:29 +0200
Message-ID: <20140513175529.GD23770@8bytes.org>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

Sorry for taking so long with this. The code looks good and clean
overall, besides my second comment.

On Wed, Apr 02, 2014 at 12:47:37PM +0200, Laurent Pinchart wrote:
> +static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
> +{
> +	/*
> +	 * Disable the context. Flush the TLB as required when modifying the
> +	 * context registers.
> +	 *
> +	 * TODO: Is TLB flush really needed ?
> +	 */
> +	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
> +	ipmmu_tlb_sync(domain);

Isn't this the same as ipmmu_tlb_invalidate()?

> +static int ipmmu_attach_device(struct iommu_domain *io_domain,
> +			       struct device *dev)
> +{
> +	struct ipmmu_vmsa_device *mmu = dev->archdata.iommu;
> +	struct ipmmu_vmsa_domain *domain = io_domain->priv;
> +	const struct ipmmu_vmsa_master *master;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!mmu) {
> +		dev_err(dev, "Cannot attach to IPMMU\n");
> +		return -ENXIO;
> +	}
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +
> +	if (!domain->mmu) {
> +		/* The domain hasn't been used yet, initialize it. */
> +		domain->mmu = mmu;
> +		ret = ipmmu_domain_init_context(domain);
> +	} else if (domain->mmu != mmu) {
> +		/*
> +		 * Something is wrong, we can't attach two devices using
> +		 * different IOMMUs to the same domain.
> +		 */

Why not? This is something the IOMMU-API basically supports (multiple
devices behind different IOMMUs in the same domain). Can't you just use
the same page-table for different IOMMUs?


	Joerg


