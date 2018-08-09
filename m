From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory
	Controller driver
Date: Thu, 09 Aug 2018 17:22:59 +0300
Message-ID: <40363808.PZSQB5qk50@dimapc>
References: <20180804143003.15817-1-digetx@gmail.com>
	<16855111.9YhuyP46zb@dimapc> <20180809135924.GG21639@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180809135924.GG21639@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday, 9 August 2018 16:59:24 MSK Thierry Reding wrote:
> On Thu, Aug 09, 2018 at 02:39:03PM +0300, Dmitry Osipenko wrote:
> > On Thursday, 9 August 2018 14:17:46 MSK Thierry Reding wrote:
> > > On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> > > > GART contain registers needed by the Memory Controller driver, provide
> > > > access to the MC driver by utilizing its GART-integration facility.
> > > > 
> > > > Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > > 
> > > >  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> > > > index a004f6da35f2..f8b653e25914 100644
> > > > --- a/drivers/iommu/tegra-gart.c
> > > > +++ b/drivers/iommu/tegra-gart.c
> > > > @@ -31,6 +31,8 @@
> > > > 
> > > >  #include <linux/iommu.h>
> > > >  #include <linux/of.h>
> > > > 
> > > > +#include <soc/tegra/mc.h>
> > > > +
> > > > 
> > > >  #include <asm/cacheflush.h>
> > > >  
> > > >  /* bitmap of the page sizes currently supported */
> > > > 
> > > > @@ -41,6 +43,8 @@
> > > > 
> > > >  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
> > > >  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> > > >  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> > > > 
> > > > +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> > > > +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> > > > 
> > > >  #define GART_PAGE_SHIFT		12
> > > >  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> > > > 
> > > > @@ -63,6 +67,8 @@ struct gart_device {
> > > > 
> > > >  	struct device		*dev;
> > > >  	
> > > >  	struct iommu_device	iommu;		/* IOMMU Core handle */
> > > > 
> > > > +
> > > > +	struct tegra_mc_gart_handle mc_gart_handle;
> > > > 
> > > >  };
> > > >  
> > > >  struct gart_domain {
> > > > 
> > > > @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
> > > > 
> > > >  	return 0;
> > > >  
> > > >  }
> > > > 
> > > > +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> > > > +{
> > > > +	struct gart_device *gart = container_of(handle, struct 
gart_device,
> > > > +						mc_gart_handle);
> > > > +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> > > > +}
> > > > +
> > > > +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> > > > +{
> > > > +	struct gart_device *gart = container_of(handle, struct 
gart_device,
> > > > +						mc_gart_handle);
> > > > +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> > > > +}
> > > > +
> > > > 
> > > >  static int tegra_gart_probe(struct platform_device *pdev)
> > > >  {
> > > >  
> > > >  	struct gart_device *gart;
> > > > 
> > > > @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device
> > > > *pdev)>
> > > > 
> > > >  	gart->regs = gart_regs;
> > > >  	gart->iovmm_base = (dma_addr_t)res_remap->start;
> > > >  	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
> > > > 
> > > > +	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
> > > > +	gart->mc_gart_handle.error_req = tegra_gart_error_req;
> > > > 
> > > >  	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
> > > >  	if (!gart->savedata) {
> > > > 
> > > > @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device
> > > > *pdev)>
> > > > 
> > > >  	do_gart_setup(gart, NULL);
> > > >  	
> > > >  	gart_handle = gart;
> > > > 
> > > > +	tegra_mc_register_gart(&gart->mc_gart_handle);
> > > > 
> > > >  	return 0;
> > > >  
> > > >  }
> > > 
> > > I see now why you've did it this way. We have separate devices unlike
> > > with SMMU where it is properly modeled as part of the memory controller.
> > > I think we should consider breaking ABI at this point and properly merge
> > > both the memory controller and GART nodes. There's really no reason why
> > > they should be separate and we're jumping through multiple hoops to do
> > > what we need to do just because a few years back we made a mistake.
> > > 
> > > I know we're technically not supposed to break the DT ABI, but I think
> > > in this particular case we can make a good case for it. The current DT
> > > bindings are plainly broken, and obviously so. Also, we don't currently
> > > use the GART upstream for anything, so we can't break any existing
> > > systems either.
> > 
> > IIUC, that will require to break the stable DT ABI of the tegra20-mc,
> > which is working fine and does its job. I'm personally not seeing the
> > slight lameness of the current DT as a good excuse to break the ABI.
> > Let's then break DT ABI on all Tegra's and convert them all to genpd and
> > other goodies like assigned clock parents and clock rate.
> 
> genpd and assigned clocks are complementary, they can be switched to
> without breaking ABI.
> 
> And that's also different from the memory controller on Tegra20 where we
> just made the mistake of describing what is effectively one device as
> two separate devices. From what I can tell, the only reason this was
> done was because it mapped better to the Linux driver model where there
> is a framework to represent an IOMMU and a misunderstanding of how to
> work with the driver model and device tree.
> 
> As such, I would describe it as more of a bug in the DT that should be
> fixed rather than breaking the ABI.
> 
> And, like I said, we are in the somewhat fortunate situation that we
> don't actively use the GART, at least in upstream, yet. So even if we
> break ABI, nobody will notice anyway. Those are about as good pre-
> conditions as you're going to get for fixing ABI.

Please tell exactly what you're suggesting.

Current DT:

	mc: memory-controller@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x024
		       0x7000f03c 0x3c4>;
		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
		#reset-cells = <1>;
	};

	gart: iommu@7000f024 {
		compatible = "nvidia,tegra20-gart";
		reg = <0x7000f024 0x00000018	/* controller registers */
		       0x58000000 0x02000000>;	/* GART aperture */
		#iommu-cells = <0>;
	};



Variant 1 (break MC ABI):

	mc: memory-controller@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x400	/* controller registers */
		       0x58000000 0x02000000>;	/* GART aperture */
		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
		#reset-cells = <1>;
		#iommu-cells = <0>;
	};



Variant 2 (don't break MC ABI, extra code churning which seems will be worse 
than what it is now):

	mc: memory-controller@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x024
		       0x7000f03c 0x3c4
		       0x7000f024 0x00000018	/* GART registers */
		       0x58000000 0x02000000>;	/* GART aperture */;
		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
		#reset-cells = <1>;
		#iommu-cells = <0>;
	};
