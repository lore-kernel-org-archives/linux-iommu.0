From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 16/22] iommu/tegra: smmu: Get "nvidia,swgroup" from DT
Date: Mon, 29 Jul 2013 13:39:50 +0200
Message-ID: <20130729.143950.524913713971518557.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-17-git-send-email-hdoyu@nvidia.com><51E84FFA.8020509@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E84FFA.8020509-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 18 Jul 2013 22:28:42 +0200:

> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > This provides the info about which H/W Accelerators are supported on
> > Tegra SoC. This info is passed from DT. This is necessary to have the
> > unified SMMU driver among Tegra SoCs. Instead of using platform data,
> > DT passes "nvidia,swgroup" now. DT is mandatory in Tegra.
> 
> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> 
> > +- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
> > +  Each bit represents one swgroup. The assignments may be found in header
> > +  file <dt-bindings/memory/tegra-swgroup.h>.
> 
> There needs to be a default for this field if one is not specified so
> that existing DTs continue to work without modification.

Only enabling PPCS(AHB) can be an option because PPCS has SD/MMC where
rootfs can be located ususally.

> How many cells big is this property?

64

> Is this really a bitmap of HWAs? Surely it's a bitmap of SMMU client
> IDs?

At least this info can be used for PMC too.

.....
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> 
> > @@ -265,7 +265,7 @@ struct smmu_client {
> >  	struct device		*dev;
> >  	struct list_head	list;
> >  	struct smmu_as		*as;
> > -	u32			hwgrp;
> > +	u64			hwgrp;
> 
> Why is that "hwgrp" not "swgrp"? Don't they represent the same
> thing?

They are same but initial SMMU driver used the term "hwgroup". Should
this be renamed with another patch or can it be left as it is?

....
> >  static int __smmu_client_set_hwgrp(struct smmu_client *c,
> > -				   unsigned long map, int on)
> > +				   u64 map, int on)
> >  {
> >  	int i;
> >  	struct smmu_as *as = c->as;
> > @@ -398,12 +400,11 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
> >  	if (!on)
> >  		map = smmu_client_hwgrp(c);
> >  
> > -	for_each_set_bit(i, &map, HWGRP_COUNT) {
> > +	for_each_set_bit(i, (unsigned long *)&map,
> > +			 sizeof(map) * BITS_PER_BYTE) {
> 
> Why change the type if it just forces you to add this cast?

u32 map; -> u64 map;

for_each_set_bit() expects "unsigned long *" for any length of bitmap.
