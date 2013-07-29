From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 14/22] iommu/tegra: smmu: Register platform_device to
 IOMMU dynamically
Date: Mon, 29 Jul 2013 13:27:52 +0200
Message-ID: <20130729.142752.1020949402019811407.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-15-git-send-email-hdoyu@nvidia.com><51E84D51.2030404@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E84D51.2030404-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 18 Jul 2013 22:17:21 +0200:

> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Register platform_devices to IOMMU dynamically via
> > ops->{add,remove}_device().
> 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> 
> > +/*
> > + * ASID[0] for the system default
> > + * ASID[1] for PPCS, which has SDMMC
> 
> I have no idea what PPCS is. The patch description for 21/22 implies
> much more than SDMMC is "in PPCS"...

"PPCS" is all AHB bus children/(client).

> > + * ASID[2][3].. open for drivers, first come, first served.
> > + */
> > +enum {
> > +	SYSTEM_DEFAULT,
> > +	SYSTEM_PROTECTED,
> > +};
> 
> Why hard-code this mapping? Can't devices be assigned to ASIDs based on
> a DT property? I assume there's nothing in the SMMU HW that requires
> specific ASIDs to be used?

Right. Where should those policy be passed, board DT files?

> I don't see anything in this series which implements the "open for
> drivers" part of the description for ASID 2/3/...

I expect that some smart HW(host1x) will use AS[2/3] for their smarter usage.
