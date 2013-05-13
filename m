From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] pci: Add PCI walk function and PCIe bridge test
Date: Mon, 13 May 2013 08:49:08 -0600
Message-ID: <1368456548.5520.1.camel@ul30vt.home>
References: <20130510210937.32592.21950.stgit@bling.home>
	<20130510211845.32592.77464.stgit@bling.home>
	<C5ECD7A89D1DC44195F34B25E172658D50609A@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D50609A-RL0Hj/+nBVCMXPU/2EZmt64g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org" <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-05-13 at 13:51 +0000, Sethi Varun-B16395 wrote:
> Would these functions be used outside drivers/iommu? We recently added pci.h under drivers/iommu, maybe we can add a new file for these functions as well.

The intention is to make them generic enough for pci-core, unlike
pci_find_upstream_pcie_bridge, which was rather specific to iommu usage.
Thanks,

Alex

> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Alex Williamson
> > Sent: Saturday, May 11, 2013 2:49 AM
> > To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org
> > Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
> > Subject: [PATCH 1/3] pci: Add PCI walk function and PCIe bridge test
> > 
> > These will replace pci_find_upstream_pcie_bridge, which is difficult to
> > use and rather specific to intel-iommu usage.  A quirked
> > pci_is_pcie_bridge function is provided to work around non-compliant
> > PCIe-to-PCI bridges such as those found in
> > https://bugzilla.kernel.org/show_bug.cgi?id=44881
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/pci/search.c |   57
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h  |   23 ++++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c index
> > d0627fa..0357f74 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -17,6 +17,63 @@
> >  DECLARE_RWSEM(pci_bus_sem);
> >  EXPORT_SYMBOL_GPL(pci_bus_sem);
> > 
> > +/* Test for PCIe bridges. */
> > +bool pci_is_pcie_bridge(struct pci_dev *pdev) {
> > +	if (!pci_is_bridge(pdev))
> > +		return false;
> > +
> > +	if (pci_is_pcie(pdev))
> > +		return true;
> > +
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	/*
> > +	 * If we're not on the root bus, look one device upstream of the
> > +	 * current device.  If that device is PCIe and is not a PCIe-to-PCI
> > +	 * bridge, then the current device is effectively PCIe as it must
> > +	 * be the PCIe-to-PCI bridge.  This handles several bridges that
> > +	 * violate the PCIe spec by not exposing a PCIe capability:
> > +	 * https://bugzilla.kernel.org/show_bug.cgi?id=44881
> > +	 */
> > +	if (!pci_is_root_bus(pdev->bus)) {
> > +		struct pci_dev *parent = pdev->bus->self;
> > +
> > +		if (pci_is_pcie(parent) &&
> > +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> > +
> > +			return true;
> > +	}
> > +#endif
> > +	return false;
> > +}
> > +
> > +/*
> > + * Walk upstream from the given pdev for the first device returning
> > + * true for the provided match function.  If no match is found, return
> > + * NULL.  *last records the previous step in the walk.
> > + */
> > +struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
> > +					   bool (*match)(struct pci_dev *),
> > +					   struct pci_dev **last)
> > +{
> > +	*last = NULL;
> > +
> > +	if (match(pdev))
> > +		return pdev;
> > +
> > +	*last = pdev;
> > +
> > +	while (!pci_is_root_bus(pdev->bus)) {
> > +		*last = pdev;
> > +		pdev = pdev->bus->self;
> > +
> > +		if (match(pdev))
> > +			return pdev;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * find the upstream PCIe-to-PCI bridge of a PCI device
> >   * if the device is PCIE, return NULL
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > bd8ec30..e87423a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1855,6 +1855,29 @@ static inline struct eeh_dev
> > *pci_dev_to_eeh_dev(struct pci_dev *pdev)  #endif
> > 
> >  /**
> > + * pci_walk_up_to_first_match - Generic upstream search function
> > + * @pdev: starting PCI device to search
> > + * @match: match function to call on each device (true = match)
> > + * @last: last device examined prior to returned device
> > + *
> > + * Walk upstream from the given device, calling match() at each device.
> > + * Returns the first device matching match().  If the root bus is
> > +reached
> > + * without finding a match, return NULL.  last returns the N-1 step in
> > + * the search path.
> > + */
> > +struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
> > +					   bool (*match)(struct pci_dev *),
> > +					   struct pci_dev **last);
> > +
> > +/**
> > + * pci_is_pcie_bridge - Match a PCIe bridge device
> > + * @pdev: device to test
> > + *
> > + * Return true if the given device is a PCIe bridge, false otherwise.
> > + */
> > +bool pci_is_pcie_bridge(struct pci_dev *pdev);
> > +
> > +/**
> >   * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a
> > device
> >   * @pdev: the PCI device
> >   *
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> 
