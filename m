From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 21/22] iommu/tegra: smmu: Support Multiple ASID
Date: Mon, 29 Jul 2013 12:31:55 +0200
Message-ID: <20130729.133155.1836775489422797370.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-22-git-send-email-hdoyu@nvidia.com><51E8535A.30605@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E8535A.30605-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 18 Jul 2013 22:43:06 +0200:

> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Support Multiple Address Space(AS). Tegra SMMU can have multiple
> > ASes. We reserve 2 of them for static assignment, AS[0] for system
> > default, AS[1] for AHB clusters as protected domain from others, where
> > there are many traditional pheripheral devices like USB, SD/MMC. They
> > should be isolated from some smart devices like host1x for system
> > robustness. Even if smart devices behaves wrongly, the traditional
> > devices(SD/MMC, USB) wouldn't be affected, and the system could
> > continue most likely.
> 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> 
> >  static int smmu_iommu_add_device(struct device *dev)
> >  {
> >  	int err;
> > -	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
> > +	u64 swgroup;
> > +	struct dma_iommu_mapping *map = NULL;
> > +
> > +	swgroup = smmu_of_get_memory_client(dev);
> > +	switch (swgroup) {
> > +	case TEGRA_SWGROUP_BIT(PPCS):
> > +		map = smmu_handle->map[SYSTEM_PROTECTED];
> > +		break;
> > +	default:
> > +		map = smmu_handle->map[SYSTEM_DEFAULT];
> 
> I already mentioned this, but just for completeness: What is
> smmu->num_as <= SYSTEM_DEFAULT?

I think that this belongs to the system operation policy. Which H/W
should be configured to which Address Space(AS). This put all AHB
clients(PPCS) into AS[1](SYSTEM_PROTECTED), and the rest into
AS[0](SYSTEM_DEFAULT). AHB clients are mainly traditional H/Ws like
USB and SD/MMC so that they should be kept separated from the smart
IOMMU clients like host1x.

Is there any place to configure this kind of board specific policy
rather than here?
