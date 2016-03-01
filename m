From: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
Date: Tue, 1 Mar 2016 17:57:29 +0100
Message-ID: <20160301165728.GA7292@jlawryno-MOBL1>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160225143841.GA8726@localhost>
	<36D38C1F74839847A52A484C31F3E51A62180790@irsmsx105.ger.corp.intel.com>
	<20160229224417.GD3653@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160229224417.GD3653@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 29, 2016 at 04:44:17PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 25, 2016 at 03:41:51PM +0000, Lawrynowicz, Jacek wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> > > Sent: Thursday, February 25, 2016 3:39 PM
> > > To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > > Cc: Lawrynowicz, Jacek <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; linux-
> > > pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; Joerg
> > > Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>; David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>;
> > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > > Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
> > > 
> > > On Wed, Feb 24, 2016 at 01:44:06PM -0600, Bjorn Helgaas wrote:
> > > > From: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> What about my questions on the code itself, below?
> 

Sorry but I'm not able to answer it.
Maybe Joerg or David could help here?

> > > > ---
> > > >  drivers/iommu/iommu.c |   17 ++++++++++-------
> > > >  drivers/pci/pci.c     |   11 +++++++++--
> > > >  drivers/pci/probe.c   |    1 +
> > > >  drivers/pci/search.c  |   14 +++++++++-----
> > > >  include/linux/pci.h   |    4 +---
> > > >  5 files changed, 30 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 0e3b009..a214e19 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -659,9 +659,15 @@ static struct iommu_group
> > > *get_pci_function_alias_group(struct pci_dev *pdev,
> > > >  	return NULL;
> > > >  }
> > > >
> > > > +static bool dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
> > > > +{
> > > > +	return dev->dma_alias_mask &&
> > > > +	       test_bit(devfn, dev->dma_alias_mask);
> > > > +}
> > > > +
> > > >  /*
> > > > - * Look for aliases to or from the given device for exisiting groups.  The
> > > > - * dma_alias_devfn only supports aliases on the same bus, therefore the
> > > search
> > > > + * Look for aliases to or from the given device for existing groups. DMA
> > > > + * aliases are only supported on the same bus, therefore the search
> > > 
> > > I'm trying to reconcile this statement that "DMA aliases are only
> > > supported on the same bus" (which was there even before this patch)
> > > with the fact that pci_for_each_dma_alias() does not have that
> > > limitation.
> > > 
> > > >   * space is quite small (especially since we're really only looking at pcie
> > > >   * device, and therefore only expect multiple slots on the root complex or
> > > >   * downstream switch ports).  It's conceivable though that a pair of
> > > > @@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias_group(struct
> > > pci_dev *pdev,
> > > >  			continue;
> > > >
> > > >  		/* We alias them or they alias us */
> > > > -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)
> > > &&
> > > > -		     pdev->dma_alias_devfn == tmp->devfn) ||
> > > > -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > -		     tmp->dma_alias_devfn == pdev->devfn)) {
> > > > -
> > > > +		if (dma_alias_is_enabled(pdev, tmp->devfn) ||
> > > > +		    dma_alias_is_enabled(tmp, pdev->devfn)) {
> > > >  			group = get_pci_alias_group(tmp, devfns);
> > > 
> > > We basically have this:
> > > 
> > >   for_each_pci_dev(tmp) {
> > >     if (<pdev and tmp are DMA aliases>)
> > >       group = get_pci_alias_group();
> > >       ...
> > >   }
> > > 
> > > The DMA alias stuff relies on PCI internals, so it doesn't doesn't
> > > seem quite right to use things like PCI_DEV_FLAGS_DMA_ALIAS_DEVFN and
> > > dma_alias_devfn here in the IOMMU code.
> > > 
> > > I'm trying to figure out why we don't do something like the following
> > > instead:
> > > 
> > >   callback(struct pci_dev *pdev, u16 alias, void *opaque)
> > >   {
> > >     struct iommu_group *group;
> > > 
> > >     group = get_pci_alias_group();
> > >     if (group)
> > >       return group;
> > > 
> > >     return 0;
> > >   }
> > > 
> > >   pci_for_each_dma_alias(pdev, callback, ...);
> > > 
> > > Is the existing code some sort of optimization, e.g., checking
> > > PCI_DEV_FLAGS_DMA_ALIAS_DEVFN is cheaper than using
> > > pci_for_each_dma_alias()?
> > > 
> > > It seems like this won't work for some very unlikely but theoretically
> > > possible topologies, e.g.,
> > > 
> > >   PCIe Root Complex/IOMMU
> > >     PCIe switch A
> > >       PCIe to conventional PCI bridge
> > >         PCI to PCIe Root Complex
> > > 	  PCIe NTB
> > > 
> > > Here, I think the IOMMU will only see RIDs from PCIe switch A, but the
> > > current code only looks at DMA aliases that are on the same bus as the
> > > PCIe NTB.  Wouldn't using pci_for_each_dma_alias() handle this
> > > correctly?
> > > 
> > > >  			if (group) {
> > > >  				pci_dev_put(tmp);
> 
> 
