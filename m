From: Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/7] powerpc: Add interface to get msi region information
Date: Fri, 4 Oct 2013 05:19:10 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
	<20130924235812.GD9302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130924235812.GD9302-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org]
> On Behalf Of Bjorn Helgaas
> Sent: Wednesday, September 25, 2013 5:28 AM
> To: Bhushan Bharat-R65777
> Cc: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org;
> galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Wood Scott-
> B07421; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Bhushan Bharat-R65777
> Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
> 
> On Thu, Sep 19, 2013 at 12:59:17PM +0530, Bharat Bhushan wrote:
> > This patch adds interface to get following information
> >   - Number of MSI regions (which is number of MSI banks for powerpc).
> >   - Get the region address range: Physical page which have the
> >      address/addresses used for generating MSI interrupt
> >      and size of the page.
> >
> > These are required to create IOMMU (Freescale PAMU) mapping for
> > devices which are directly assigned using VFIO.
> >
> > Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  arch/powerpc/include/asm/machdep.h |    8 +++++++
> >  arch/powerpc/include/asm/pci.h     |    2 +
> >  arch/powerpc/kernel/msi.c          |   18 ++++++++++++++++
> >  arch/powerpc/sysdev/fsl_msi.c      |   39 +++++++++++++++++++++++++++++++++--
> >  arch/powerpc/sysdev/fsl_msi.h      |   11 ++++++++-
> >  drivers/pci/msi.c                  |   26 ++++++++++++++++++++++++
> >  include/linux/msi.h                |    8 +++++++
> >  include/linux/pci.h                |   13 ++++++++++++
> >  8 files changed, 120 insertions(+), 5 deletions(-)
> >
> > ...
> 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index
> > aca7578..6d85c15 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -30,6 +30,20 @@ static int pci_msi_enable = 1;
> >
> >  /* Arch hooks */
> >
> > +#ifndef arch_msi_get_region_count
> > +int arch_msi_get_region_count(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +#ifndef arch_msi_get_region
> > +int arch_msi_get_region(int region_num, struct msi_region *region) {
> > +	return 0;
> > +}
> > +#endif
> 
> This #define strategy is gone; see 4287d824 ("PCI: use weak functions for MSI
> arch-specific functions").  Please use the weak function strategy for your new
> MSI region functions.

ok

> 
> > +
> >  #ifndef arch_msi_check_device
> >  int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)  {
> > @@ -903,6 +917,18 @@ void pci_disable_msi(struct pci_dev *dev)  }
> > EXPORT_SYMBOL(pci_disable_msi);
> >
> > +int msi_get_region_count(void)
> > +{
> > +	return arch_msi_get_region_count();
> > +}
> > +EXPORT_SYMBOL(msi_get_region_count);
> > +
> > +int msi_get_region(int region_num, struct msi_region *region) {
> > +	return arch_msi_get_region(region_num, region); }
> > +EXPORT_SYMBOL(msi_get_region);
> 
> Please split these interface additions, i.e., the drivers/pci/msi.c,
> include/linux/msi.h, and include/linux/pci.h changes, into a separate patch.

ok

> 
> I don't know enough about VFIO to understand why these new interfaces are
> needed.  Is this the first VFIO IOMMU driver?  I see vfio_iommu_spapr_tce.c and
> vfio_iommu_type1.c but I don't know if they're comparable to the Freescale PAMU.
> Do other VFIO IOMMU implementations support MSI?  If so, do they handle the
> problem of mapping the MSI regions in a different way?

PAMU is an aperture type of IOMMU while other are paging type, So they are completely different from what PAMU is and handle that differently.

> 
> >  /**
> >   * pci_msix_table_size - return the number of device's MSI-X table entries
> >   * @dev: pointer to the pci_dev data structure of MSI-X device
> > function diff --git a/include/linux/msi.h b/include/linux/msi.h index
> > ee66f3a..ae32601 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -50,6 +50,12 @@ struct msi_desc {
> >  	struct kobject kobj;
> >  };
> >
> > +struct msi_region {
> > +	int region_num;
> > +	dma_addr_t addr;
> > +	size_t size;
> > +};
> 
> This needs some sort of explanatory comment.

Ok

-Bharat

> 
> >  /*
> >   * The arch hook for setup up msi irqs
> >   */
> > @@ -58,5 +64,7 @@ void arch_teardown_msi_irq(unsigned int irq);  int
> > arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);  void
> > arch_teardown_msi_irqs(struct pci_dev *dev);  int
> > arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
> > +int arch_msi_get_region_count(void);
> > +int arch_msi_get_region(int region_num, struct msi_region *region);
> >
> >  #endif /* LINUX_MSI_H */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > 186540d..2b26a59 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1126,6 +1126,7 @@ struct msix_entry {
> >  	u16	entry;	/* driver uses to specify entry, OS writes */
> >  };
> >
> > +struct msi_region;
> >
> >  #ifndef CONFIG_PCI_MSI
> >  static inline int pci_enable_msi_block(struct pci_dev *dev, unsigned
> > int nvec) @@ -1168,6 +1169,16 @@ static inline int
> > pci_msi_enabled(void)  {
> >  	return 0;
> >  }
> > +
> > +static inline int msi_get_region_count(void) {
> > +	return 0;
> > +}
> > +
> > +static inline int msi_get_region(int region_num, struct msi_region
> > +*region) {
> > +	return 0;
> > +}
> >  #else
> >  int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
> > int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int
> > *maxvec); @@ -1180,6 +1191,8 @@ void pci_disable_msix(struct pci_dev
> > *dev);  void msi_remove_pci_irq_vectors(struct pci_dev *dev);  void
> > pci_restore_msi_state(struct pci_dev *dev);  int
> > pci_msi_enabled(void);
> > +int msi_get_region_count(void);
> > +int msi_get_region(int region_num, struct msi_region *region);
> >  #endif
> >
> >  #ifdef CONFIG_PCIEPORTBUS
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body
> of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
