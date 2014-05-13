From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Tue, 13 May 2014 23:04:10 +0200
Message-ID: <2227683.61UxrJHGnf@avalon>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20140513175529.GD23770@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140513175529.GD23770@8bytes.org>
Sender: linux-sh-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Tuesday 13 May 2014 19:55:29 Joerg Roedel wrote:
> Hi Laurent,
> 
> Sorry for taking so long with this.

No worries. As long as the driver gets in v3.16 (wink wink :-)) that's fine

> The code looks good and clean overall, besides my second comment.
> 
> On Wed, Apr 02, 2014 at 12:47:37PM +0200, Laurent Pinchart wrote:
> > +static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain
> > *domain)
> > +{
> > +	/*
> > +	 * Disable the context. Flush the TLB as required when modifying the
> > +	 * context registers.
> > +	 *
> > +	 * TODO: Is TLB flush really needed ?
> > +	 */
> > +	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
> > +	ipmmu_tlb_sync(domain);
> 
> Isn't this the same as ipmmu_tlb_invalidate()?

ipmmu_tlb_invalidate() performs a read-update-write operation on the IMCTR 
register to set the FLUSH bit without modifying the other bits, while this 
function writes the FLUSH bit and sets all other bits (including the enable 
bit) to zero. The difference is thus important.

> > +static int ipmmu_attach_device(struct iommu_domain *io_domain,
> > +			       struct device *dev)
> > +{
> > +	struct ipmmu_vmsa_device *mmu = dev->archdata.iommu;
> > +	struct ipmmu_vmsa_domain *domain = io_domain->priv;
> > +	const struct ipmmu_vmsa_master *master;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	if (!mmu) {
> > +		dev_err(dev, "Cannot attach to IPMMU\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	spin_lock_irqsave(&domain->lock, flags);
> > +
> > +	if (!domain->mmu) {
> > +		/* The domain hasn't been used yet, initialize it. */
> > +		domain->mmu = mmu;
> > +		ret = ipmmu_domain_init_context(domain);
> > +	} else if (domain->mmu != mmu) {
> > +		/*
> > +		 * Something is wrong, we can't attach two devices using
> > +		 * different IOMMUs to the same domain.
> > +		 */
> 
> Why not? This is something the IOMMU-API basically supports (multiple
> devices behind different IOMMUs in the same domain). Can't you just use
> the same page-table for different IOMMUs?

I might be able to (I'll need to check first though), but I don't really see 
what the use cases for sharing a common page table between separate IOMMUs 
would be. Could you please elaborate a bit ? Given that we're getting close to 
the v3.16 merge window, would it be acceptable to fix (if needed) that as a 
follow-up patch, as the driver is already usable as-is ?

-- 
Regards,

Laurent Pinchart

