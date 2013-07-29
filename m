From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 03/22] ARM: tegra: Create a DT header defining
 swgroups ID
Date: Mon, 29 Jul 2013 12:53:36 +0200
Message-ID: <20130729.135336.943359637886118972.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-4-git-send-email-hdoyu@nvidia.com><51E5D220.1070708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E5D220.1070708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 17 Jul 2013 01:07:12 +0200:

> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
> > binding. "swgroup" is a group of H/W clients in Tegra SoC from S/W POV.
> > 
> > This will allow the same header to be used by both device tree files,
> > and drivers implementing this binding, which guarantees that the two
> > stay in sync. This also makes device trees more readable by using names
> > instead of magic numbers.
> 
> Why does the driver need these constants; shouldn't it simply support
> 0..n SW group IDs that all work the same way? Or, is there some reason
> for it to know the identities?
> 
> > diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
> 
> s/memory/iommu/?

This info would be used in PMC code as well, which H/W belongs to
which swgroup. So I use the term "memory(-client)" instead of "iommu".

> s/tegra-swgroup.h/tegra-smmu.h/?

Is "tegra-memory-clients.h" preferable, then?

> > +#define TEGRA_SWGROUP_AFI 0
> 
> Should this file document which values are valid for which SoCs? Should
> there be separate files for each SoC; I don't know if it's guaranteed
> that IDs won't be re-assigned between different SoCs.

I've checked all SoC which I can refer. Those IDs are calculated from
the register offset. But I haven't got any explicit guarantee from H/W
designers yet.

> > +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
> > +
> > +#define TEGRA30_SWGROUP_ALL	<0x00000000 0x000779ff>
> > +#define TEGRA114_SWGROUP_ALL	<0x00000000 0x01b659fe>
> 
> Are those 3 values needed by DT files, or just the driver?

Only from DT.
