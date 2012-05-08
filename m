From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Tue, 8 May 2012 08:03:09 +0200
Message-ID: <20120508.090309.468358565052949753.hdoyu@nvidia.com>
References: <4FA410DD.3090105@wwwdotorg.org><20120507.144758.1558303336683449254.hdoyu@nvidia.com><4FA7F316.7070904@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA7F316.7070904-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Mon, 7 May 2012 18:06:46 +0200
Message-ID: <4FA7F316.7070904-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

> On 05/07/2012 05:47 AM, Hiroshi Doyu wrote:
> > Stephen Warren wrote at Fri, 4 May 2012 19:24:45 +0200:
> ...
> >> Perhaps the simplest way is to represent those chunks as separate reg
> >> entries:
> >>
> >>     mc@7000f010 {
> >>         compatible = "nvidia,tegra30-mc";
> >>         reg = <0x7000f010 0x1d4 0x70000228 0xd4>;
> >>     };
> >>
> >>     smmu@0x70000050 {
> >>         compatible = "nvidia,tegra30-smmu";
> >>         reg = <0x70000010 0x2c 0x70000228 0x5c>;
> >>     };
> ...
> > Ok, let's start with the simplest way, and improve later with nice
> > framework.
>
> Uggh. So that patch is for the SMMU, but this thread is about the GART.
> Also, attaching patches makes it more difficult to review them, since
> them may not appear inline when reading the mail, and certainly don't
> when replying. Anyway...
>
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>
> > +#include <mach/tegra-ahb.h>
>
> Note that this patch therefor depends on the AHB series that you just
> posted, and isn't applied anywhere yet.

Right.

FYI: the AHB series:
http://article.gmane.org/gmane.linux.ports.tegra/4657


> > +static int get_reg_bank(u32 offset)
> >  {
> > -	writel(val, smmu->regs + offs);
> > +	int i;
> > +	const struct smmu_reg_bank {
> > +		u32 start;
> > +		size_t size;
> > +	} r[] = {
> > +		{
> > +			.start = 0x10,
> > +			.size = 0x2c,
> > +		},
> > +		{
> > +			.start = 0x1f0,
> > +			.size = 0x10,
> > +		},
> > +		{
> > +			.start = 0x228,
> > +			.size = 0x5c,
> > +		},
> > +	};
> > +
> > +	for (i = 0; i < ARRAY_SIZE(r); i++) {
> > +		BUG_ON(offset < r[i].start);
> > +		if (offset < r[i].start + r[i].size)
> > +			return i;
> > +	}
> > +	BUG();
> > +	return 0; /* Never reach here */
> >  }
>
> While stylistically nice, I'm not sure that will be as likely to
> optimize out as the simple if/else code I gave as an example. I suppose
> it's not a big deal though.

Ok, you meant compiler optimization. I'll compare their output and may
use the original(yours) if the original is better.

> >  static int tegra_smmu_probe(struct platform_device *pdev)
>
> > +	err = of_get_dma_window(dev->of_node, "dma-window", 0, NULL,
> > +				&base, &size);
>
> So this also relies on the generic DMA window parsing patch too. I don't
> think that's checked in anywhere yet right?

Yes. I'll ask the feedback on that patch.

> > +	size >>= SMMU_PAGE_SHIFT;
> > +	if (!size)
> > +		return -ENODEV;
>
> It seems like this should validate that !(size & ((1 << SMMU_PAGE_SHIFT)
> - 1)) too?

Yes

> This patch looks like it adds the full implementation of device tree
> support, yet doesn't add any documentation for the binding.

I'll add the doc.

> Finally, I assume you're going to post a similar patch for the Tegra20
> GART, so its register ranges don't overlap the Tegra20 MC?

Right.
