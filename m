From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Mon, 4 Feb 2013 21:39:21 +0100
Message-ID: <20130204.223921.2367725583637314.hdoyu@nvidia.com>
References: <20130204195232.GA15278@8bytes.org><20130204.223114.121259250064618894.hdoyu@nvidia.com><51101BA1.5090208@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51101BA1.5090208-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Mon, 4 Feb 2013 21:35:45 +0100:

> >> This loop is purely for checking offset to be valid. And this loop is
> >> repeated in the smmu_write() function. I queued a patch on-top to make
> >> this more clear. Please double-check:
> > 
> > Actually I did the similar thing in the first version of this patch(*1)
> > 
> > +static inline void smmu_check_reg_range(size_t offs)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < smmu->nregs; i++) {
> > +	    BUG_ON(offs < smmu->regs[i] - smmu->regbase);
> > +	    		if (offs <= smmu->rege[i] - smmu->regbase)
> > +			   	 break;
> > +	 }
> > +}
> > 
> > *1:
> > http://lists.linuxfoundation.org/pipermail/iommu/2013-January/005072.html
> > 
> > Then, Stehpen pointed out about this check function(*2).
> > 
> > "... here, you'd be doing the loop every access anyway, so you may as
> > well not calculate regbase at all, move the body of
> > smmu_check_reg_range() into smmu_read()/smmu_write(), and do the access
> > inside the if statement inside the loop, with the per-range mapping."
> 
> Upon reflection, that comment probably isn't correct, since the only way
> to know where each register range begins, relative to the register
> numbers that the driver uses, is to calculate reg_base. So, I think you
> do need reg_base, and Joerg's latest patch seems reasonable.

Ok, now it's clear. Joerg, please get yours merged on the top of this.
