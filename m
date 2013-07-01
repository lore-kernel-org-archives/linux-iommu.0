From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 19/23] iommu/tegra: smmu: Unfied driver for Tegra SoCs
Date: Mon, 1 Jul 2013 10:32:59 +0200
Message-ID: <20130701.113259.1041478084393668638.hdoyu@nvidia.com>
References: <1372238906-9346-20-git-send-email-hdoyu@nvidia.com><20130626110747.GP27083@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130626110747.GP27083@manwe>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 13:07:47 +0200:

> * PGP Signed by an unknown key
> 
> On Wed, Jun 26, 2013 at 12:28:22PM +0300, Hiroshi Doyu wrote:
> > Support multiple generation of Tegra SoCs with this unified
> > SMMU driver. Necessary info is expected to be passed from DT.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/tegra-smmu.c | 80 ++--------------------------------------------
> >  1 file changed, 3 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 6e82df3..ae71721 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * IOMMU API for SMMU in Tegra30
> > + * IOMMU API for SMMU in Tegra SoC
> 
> Maybe "Tegra30 and later SoCs" given that Tegra20 has no compatible
> IOMMU?
> 
> > -MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
> > +MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra SoC");
> 
> Same here.

Currently most of Tegra SoC has SMMU, and which doesn't have can be
identified from DT. IMHO, we don't have to be so strict on this
decritpions. Otherwise, we would need to list up which one (doesn't)
has whenever a new one comes?
