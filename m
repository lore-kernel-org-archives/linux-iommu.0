From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/tegra: smmu: Add DMA window parser
Date: Fri, 18 May 2012 22:56:19 +0200
Message-ID: <20120518.235619.175499431618565933.hdoyu@nvidia.com>
References: <20120518085051.4a0fca863c5ab37cf8d42cb1@nvidia.com><1337323393-1035-1-git-send-email-hdoyu@nvidia.com><4FB66796.1030007@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FB66796.1030007-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stephen, Joerg,

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Fri, 18 May 2012 17:15:34 +0200:

> On 05/18/2012 12:43 AM, Hiroshi DOYU wrote:
> > This code was based on:
> >     "arch/microblaze/kernel/prom_parse.c"
> >     "arch/powerpc/kernel/prom_parse.c"
> > 
> > Can be promoted as a global function for general use.
> > 
> > Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Hiroshi,
> 
> Once this is accepted, it might be worth following up on the original
> of_get_dma_window thread and noting that once it's approved, an updated
> version of the patch will be needed to remove this code at the same time.
> 
> A couple comments below though:
> 
> > +static int of_get_dma_window(struct device_node *dn,
> > +			const char *propname, int index,
> > +			unsigned long *busno,
> > +			dma_addr_t *addr, size_t *size)
> > +{
> > +	const __be32 *dma_window, *end;
> > +	int bytes, cur_index = 0;
> 
> Since bytes is an out parameter from of_get_property, do you need to
> wrap the declaration in uninitialized_var() to prevent a compile warning
> like the other patch you sent me downstream?
> 
> > +	if (!dn || !addr || !size)
> > +		return -EINVAL;
> > +
> > +	if (!propname)
> > +		propname = "dma-window";
> > +
> > +	dma_window = of_get_property(dn, propname, &bytes);
> > +	if (!dma_window)
> > +		return -ENODEV;
> > +	end = dma_window + bytes / sizeof(*dma_window);
> > +
> > +	while (dma_window < end) {
> > +		u32 cells;
> > +		const void *prop;
> > +
> > +		/* busno is always one cell */
> > +		if (busno)
> > +			*busno = be32_to_cpup(dma_window++);
> 
> Shouldn't the ++ happen even if (!busno)?

Hm...the above code happens to work with our "dma-window" format right
now, but most likely this seems incmpatible with "ibm,dma-window"
format. I couldn't find the official format previously. I'm wondering
that those "(ibm,)dma-window" and "(ibm,)dma-range" may be able to be
generally used since those parameters are quite common to any
IOMMUs. I'll hold off those patches at least this time

Joerg, as Stephen proposed originally. Could you please revert or drop
the original one this time?

  [PATCH 1/2] iommu/tegra: smmu: Add device tree support for SMMU

PS: I'm being off-line'd mostly next four weeks, and my response would
be delayed.
