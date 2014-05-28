From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 06/16] PCI: Quirk pci_for_each_dma_alias() for bridges
Date: Wed, 28 May 2014 13:09:32 -0600
Message-ID: <1401304172.2412.65.camel@ul30vt.home>
References: <20140522230230.2856.40017.stgit@bling.home>
	<20140522230801.2856.18629.stgit@bling.home>
	<20140528180018.GS11907@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140528180018.GS11907-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org, eddy0596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2014-05-28 at 12:00 -0600, Bjorn Helgaas wrote:
> On Thu, May 22, 2014 at 05:08:01PM -0600, Alex Williamson wrote:
> > Several PCIe-to-PCI bridges fail to provide a PCIe capability, causing
> > us to handle them as conventional PCI devices.  In some cases, this
> > may be correct, in others it's not.  Add a dev_flag bit to identify
> > devices to be handled as standard PCIe-to-PCI bridges.
> 
> Can you expand on the "in some cases, this may be correct, in others it's
> not"?  Do you mean that for some *devices* it's correct to handle them as
> conventional PCI, or in some *situations* it's correct?  Something else?

Yes, the example that I know of is the PCI bridge found on the root
complex of many Intel chipsets.  Older generations do not have a PCIe
capability and the requester ID behaves as a conventional PCI device,
using the bridge itself as the requester ID, newer version include a
PCIe capability and use the secondary bus as the requester ID.  Those
devices work correctly without this quirk.  The bridges in the next
patch obviously don't.

> I'd like to either remove that sentence or add a little more information to
> make it useful.

Ok, I'll note some of the above in a new commit log.

> I guess this probably goes along with the tests in
> quirk_use_pcie_bridge_dma_alias().

Yep.  For that, we need to look at the upstream device of the bridge, so
it won't flag any root complex bridges like those above, which is why it
could probably be applied to any bridge.  Thanks,

Alex

> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/pci/search.c |   10 ++++++++--
> >  include/linux/pci.h  |    2 ++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index 2c19f3f..df38f73 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -88,8 +88,14 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
> >  				continue;
> >  			}
> >  		} else {
> > -			ret = fn(tmp, PCI_DEVID(tmp->bus->number, tmp->devfn),
> > -				 data);
> > +			if (tmp->dev_flags & PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS)
> > +				ret = fn(tmp,
> > +					 PCI_DEVID(tmp->subordinate->number,
> > +						   PCI_DEVFN(0, 0)), data);
> > +			else
> > +				ret = fn(tmp,
> > +					 PCI_DEVID(tmp->bus->number,
> > +						   tmp->devfn), data);
> >  			if (ret)
> >  				return ret;
> >  		}
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9d4035c..85ab35e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -173,6 +173,8 @@ enum pci_dev_flags {
> >  	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
> >  	/* Flag to indicate the device uses dma_alias_devfn */
> >  	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 << 4),
> > +	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
> > +	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
> >  };
> >  
> >  enum pci_irq_reroute_variant {
> > 
