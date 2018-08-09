From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory Controller driver
Date: Thu, 09 Aug 2018 14:39:03 +0300
Message-ID: <16855111.9YhuyP46zb@dimapc>
References: <20180804143003.15817-1-digetx@gmail.com> <20180804143003.15817-3-digetx@gmail.com> <20180809111746.GG21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809111746.GG21639@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thursday, 9 August 2018 14:17:46 MSK Thierry Reding wrote:
> On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> > GART contain registers needed by the Memory Controller driver, provide
> > access to the MC driver by utilizing its GART-integration facility.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> > 
> >  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> > index a004f6da35f2..f8b653e25914 100644
> > --- a/drivers/iommu/tegra-gart.c
> > +++ b/drivers/iommu/tegra-gart.c
> > @@ -31,6 +31,8 @@
> > 
> >  #include <linux/iommu.h>
> >  #include <linux/of.h>
> > 
> > +#include <soc/tegra/mc.h>
> > +
> > 
> >  #include <asm/cacheflush.h>
> >  
> >  /* bitmap of the page sizes currently supported */
> > 
> > @@ -41,6 +43,8 @@
> > 
> >  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
> >  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> >  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> > 
> > +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> > +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> > 
> >  #define GART_PAGE_SHIFT		12
> >  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> > 
> > @@ -63,6 +67,8 @@ struct gart_device {
> > 
> >  	struct device		*dev;
> >  	
> >  	struct iommu_device	iommu;		/* IOMMU Core handle */
> > 
> > +
> > +	struct tegra_mc_gart_handle mc_gart_handle;
> > 
> >  };
> >  
> >  struct gart_domain {
> > 
> > @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
> > 
> >  	return 0;
> >  
> >  }
> > 
> > +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> > +{
> > +	struct gart_device *gart = container_of(handle, struct gart_device,
> > +						mc_gart_handle);
> > +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> > +}
> > +
> > +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> > +{
> > +	struct gart_device *gart = container_of(handle, struct gart_device,
> > +						mc_gart_handle);
> > +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> > +}
> > +
> > 
> >  static int tegra_gart_probe(struct platform_device *pdev)
> >  {
> >  
> >  	struct gart_device *gart;
> > 
> > @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device
> > *pdev)> 
> >  	gart->regs = gart_regs;
> >  	gart->iovmm_base = (dma_addr_t)res_remap->start;
> >  	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
> > 
> > +	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
> > +	gart->mc_gart_handle.error_req = tegra_gart_error_req;
> > 
> >  	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
> >  	if (!gart->savedata) {
> > 
> > @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device
> > *pdev)> 
> >  	do_gart_setup(gart, NULL);
> >  	
> >  	gart_handle = gart;
> > 
> > +	tegra_mc_register_gart(&gart->mc_gart_handle);
> > 
> >  	return 0;
> >  
> >  }
> 
> I see now why you've did it this way. We have separate devices unlike
> with SMMU where it is properly modeled as part of the memory controller.
> I think we should consider breaking ABI at this point and properly merge
> both the memory controller and GART nodes. There's really no reason why
> they should be separate and we're jumping through multiple hoops to do
> what we need to do just because a few years back we made a mistake.
> 
> I know we're technically not supposed to break the DT ABI, but I think
> in this particular case we can make a good case for it. The current DT
> bindings are plainly broken, and obviously so. Also, we don't currently
> use the GART upstream for anything, so we can't break any existing
> systems either.

IIUC, that will require to break the stable DT ABI of the tegra20-mc, which is 
working fine and does its job. I'm personally not seeing the slight lameness 
of the current DT as a good excuse to break the ABI. Let's then break DT ABI 
on all Tegra's and convert them all to genpd and other goodies like assigned 
clock parents and clock rate.
