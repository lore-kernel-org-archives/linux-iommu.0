From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3 v2] iommu/fsl: Enable default DMA window for PCIe
	devices
Date: Tue, 3 Dec 2013 18:15:22 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A606B8F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1381922582-28724-1-git-send-email-Varun.Sethi@freescale.com>
	<1381922582-28724-3-git-send-email-Varun.Sethi@freescale.com>
	<1386020016.25738.240.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386020016.25738.240.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Tuesday, December 03, 2013 3:04 AM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Yoder Stuart-B08248;
> Wood Scott-B07421; Bhushan Bharat-R65777
> Subject: Re: [PATCH 2/3 v2] iommu/fsl: Enable default DMA window for PCIe
> devices
> 
> On Wed, 2013-10-16 at 16:53 +0530, Varun Sethi wrote:
> > Once the PCIe device assigned to a guest VM (via VFIO) gets detached
> > from the iommu domain (when guest terminates), its PAMU table entry is
> > disabled. So, this would prevent the device from being used once it's
> assigned back to the host.
> >
> > This patch allows for creation of a default DMA window corresponding
> > to the device and subsequently enabling the PAMU table entry. Before
> > we enable the entry, we ensure that the device's bus master capability
> is disabled (device quiesced).
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/fsl_pamu.c        |   43 ++++++++++++++++++++++++++++---
> -----
> >  drivers/iommu/fsl_pamu.h        |    1 +
> >  drivers/iommu/fsl_pamu_domain.c |   46
> ++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 78 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> > cba0498..fb4a031 100644
> > --- a/drivers/iommu/fsl_pamu.c
> > +++ b/drivers/iommu/fsl_pamu.c
> > @@ -225,6 +225,21 @@ static struct paace *pamu_get_spaace(struct paace
> *paace, u32 wnum)
> >  	return spaace;
> >  }
> >
> > +/*
> > + * Defaul PPAACE settings for an LIODN.
> > + */
> > +static void setup_default_ppaace(struct paace *ppaace) {
> > +	pamu_init_ppaace(ppaace);
> > +	/* window size is 2^(WSE+1) bytes */
> > +	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
> > +	ppaace->wbah = 0;
> > +	set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
> > +	set_bf(ppaace->impl_attr, PAACE_IA_ATM,
> > +		PAACE_ATM_NO_XLATE);
> > +	set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
> > +		PAACE_AP_PERMS_ALL);
> > +}
> >  /**
> >   * pamu_get_fspi_and_allocate() - Allocates fspi index and reserves
> subwindows
> >   *                                required for primary PAACE in the
> secondary
> > @@ -253,6 +268,24 @@ static unsigned long
> pamu_get_fspi_and_allocate(u32 subwin_cnt)
> >  	return (spaace_addr - (unsigned long)spaact) / (sizeof(struct
> > paace));  }
> >
> > +/* Reset the PAACE entry to the default state */ void
> > +enable_default_dma_window(int liodn) {
> > +	struct paace *ppaace;
> > +
> > +	ppaace = pamu_get_ppaace(liodn);
> > +	if (!ppaace) {
> > +		pr_debug("Invalid liodn entry\n");
> > +		return;
> > +	}
> > +
> > +	memset(ppaace, 0, sizeof(struct paace));
> > +
> > +	setup_default_ppaace(ppaace);
> > +	mb();
> > +	pamu_enable_liodn(liodn);
> > +}
> > +
> >  /* Release the subwindows reserved for a particular LIODN */  void
> > pamu_free_subwins(int liodn)  { @@ -752,15 +785,7 @@ static void
> > __init setup_liodns(void)
> >  				continue;
> >  			}
> >  			ppaace = pamu_get_ppaace(liodn);
> > -			pamu_init_ppaace(ppaace);
> > -			/* window size is 2^(WSE+1) bytes */
> > -			set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
> > -			ppaace->wbah = 0;
> > -			set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
> > -			set_bf(ppaace->impl_attr, PAACE_IA_ATM,
> > -				PAACE_ATM_NO_XLATE);
> > -			set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
> > -				PAACE_AP_PERMS_ALL);
> > +			setup_default_ppaace(ppaace);
> >  			if (of_device_is_compatible(node, "fsl,qman-portal"))
> >  				setup_qbman_paace(ppaace, QMAN_PORTAL_PAACE);
> >  			if (of_device_is_compatible(node, "fsl,qman")) diff --
> git
> > a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h index
> > 8fc1a12..0edcbbbb 100644
> > --- a/drivers/iommu/fsl_pamu.h
> > +++ b/drivers/iommu/fsl_pamu.h
> > @@ -406,5 +406,6 @@ void get_ome_index(u32 *omi_index, struct device
> > *dev);  int  pamu_update_paace_stash(int liodn, u32 subwin, u32
> > value);  int pamu_disable_spaace(int liodn, u32 subwin);
> >  u32 pamu_get_max_subwin_cnt(void);
> > +void enable_default_dma_window(int liodn);
> >
> >  #endif  /* __FSL_PAMU_H */
> > diff --git a/drivers/iommu/fsl_pamu_domain.c
> > b/drivers/iommu/fsl_pamu_domain.c index 966ae70..dd6cafc 100644
> > --- a/drivers/iommu/fsl_pamu_domain.c
> > +++ b/drivers/iommu/fsl_pamu_domain.c
> > @@ -340,17 +340,57 @@ static inline struct device_domain_info
> *find_domain(struct device *dev)
> >  	return dev->archdata.iommu_domain;
> >  }
> >
> > +/* Disable device DMA capability and enable default DMA window */
> > +static void disable_device_dma(struct device_domain_info *info,
> > +				int enable_dma_window)
> 
> nit, bool?
> 
> > +{
> > +#ifdef CONFIG_PCI
> > +	if (info->dev->bus == &pci_bus_type) {
> > +		struct pci_dev *pdev = NULL;
> 
> nit, unnecessary initialization
> 
> > +		pdev = to_pci_dev(info->dev);
> > +		if (pci_is_enabled(pdev))
> > +			pci_disable_device(pdev);
> 
> This looks suspicious.  What's the case where you're finding devices
> where this is needed?  Logically the driver that called
> pci_enable_device() should also call pci_disabled_device() when it's
> done.  Maybe there's a case to be made that we can't rely on the driver,
> but then maybe there should be a pr_debug/info here to notify that
> somebody left the device running.  There might also be the question of
> whether you should test the busmaster bit in the command register rather
> than trusting these indirect paths if it's really for cleanup.  Thanks,
> 
Once the device is detached from the domain, we enable a default DMA window for the device. Before enabling the default window, I want to ensure that device DMA is disabled. VFIO subsystem handles this for vfio-pci. But, can we assume that this would always be the case?

-Varun
