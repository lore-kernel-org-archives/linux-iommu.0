From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 04/13] pci: New pci_dma_quirk()
Date: Wed, 16 May 2012 22:06:53 -0600
Message-ID: <1337227613.6954.306.camel@bling.home>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225555.30496.80525.stgit@bling.home>
	<20120517033914.GF22069@truffala.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120517033914.GF22069-MK4v0fQdeXQXU02nzanrWNbf9cGiqdzd@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-05-17 at 13:39 +1000, David Gibson wrote:
> On Fri, May 11, 2012 at 04:55:55PM -0600, Alex Williamson wrote:
> > Integrating IOMMU groups more closely into the driver core allows
> > us to more easily work around DMA quirks.  The Ricoh multifunction
> > controller is a favorite example of devices that are currently
> > incompatible with IOMMU isolation as all the functions use the
> > requestor ID of function 0 for DMA.  Passing this device into
> > pci_dma_quirk returns the PCI device to use for DMA.  The IOMMU
> > driver can then construct an IOMMU group including both devices.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> > 
> >  drivers/pci/quirks.c |   22 ++++++++++++++++++++++
> >  include/linux/pci.h  |    2 ++
> >  2 files changed, 24 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4bf7102..6f9f7f9 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3109,3 +3109,25 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
> >  
> >  	return -ENOTTY;
> >  }
> > +
> > +struct pci_dev *pci_dma_quirk(struct pci_dev *dev)
> > +{
> > +	struct pci_dev *dma_dev = dev;
> > +
> > +	/*
> > +	 * https://bugzilla.redhat.com/show_bug.cgi?id=605888
> > +	 *
> > +	 * Some Ricoh devices use the function 0 source ID for DMA on
> > +	 * other functions of a multifunction device.  The DMA devices
> > +	 * is therefore function 0, which will have implications of the
> > +	 * iommu grouping of these devices.
> > +	 */
> > +	if (dev->vendor == PCI_VENDOR_ID_RICOH &&
> > +	    (dev->device == 0xe822 || dev->device == 0xe230 ||
> > +	     dev->device == 0xe832 || dev->device == 0xe476)) {
> > +		dma_dev = pci_get_slot(dev->bus,
> > +				       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > +	}
> 
> Hrm.  This seems like a very generic name for a function performing a
> very specific test.  We could well have devices with the same problem
> in future, so shouldn't this be set up so the same quirk can be easily
> added to new device ids without changing the function code itself.

I've since added a USB quirk here to group all the USB functions in a
slot.  I'll take a closer look at the quirk helpers to see if anything
makes this easier, but I didn't see much point in spending a lot of time
over-optimizing this for 1 or 2 quirks that we can just step through in
a monolithic function.  Thanks,

Alex
