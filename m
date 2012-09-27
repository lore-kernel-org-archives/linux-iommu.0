From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Thu, 27 Sep 2012 15:34:07 -0600
Message-ID: <1348781647.2320.264.camel@ul30vt.home>
References: <20120918164955.12296.28799.sendpatchset@tmingo.houston.hp.com>
	<1348778200.2320.241.camel@ul30vt.home>
	<9774516974AF5F4C8A2C3C69CD3412332338F452@G1W3651.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9774516974AF5F4C8A2C3C69CD3412332338F452-KNyhpuZufFMSZAcGdq5asR6epYMZPwEe5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Mingarelli, Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-09-27 at 21:10 +0000, Mingarelli, Thomas wrote:
> Alex,
> 
> Are you suggesting that a solution is to prevent devices with RMRRs
> from being placed in the SI Domain in the first place (when pt mode is
> used)?

No, it seems like it's preferable that devices with RMRRs stay in the si
domain if the device supports 64bit DMA.  They're likely to cause less
problems there and we can ignore the RMRRs in the si domain.  The
problem I'm trying to address is that the domain you're setting up with
RMRRs is only used for dma_ops (ie. host driver use).  If the device is
attached to a guest, that domain gets discarded and the device is added
to yet another domain, potentially with other devices.  That domain is
missing RMRRs, so now your device is going to generate VT-d faults.  The
device can then get removed from that domain, in which case the RMRRs
should be removed, and again a new dma_ops domain needs to get created
with RMRRs.

It really seems like RMRRs are incompatible with IOMMU API use though.
If an RMRR is setup for a VM domain, that's bad because a) it gives the
VM direct access to that range of host memory, and b) it interferes with
the guest use of the address space.  a) is also bad for isolating
devices on the host, but the spec makes it available for abuse.  For b),
it's not hard to imagine an RMRR range on the host that overlaps with
DMA'able space on the guest.  Data is read or written to the host memory
instead of the guest memory.  So maybe the right answer is to make
intel_iommu_attach_device return error if requested to act on a device
with RMRR ranges.  Thanks,

Alex

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org] 
> Sent: Thursday, September 27, 2012 3:37 PM
> To: Mingarelli, Thomas
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Knippers, Linda; Khan, Shuah; Don Dutile; David Woodhouse
> Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
> 
> [adding David Woodhouse]
> 
> On Tue, 2012-09-18 at 16:49 +0000, Tom Mingarelli wrote:
> > When a 32bit PCI device is removed from the SI Domain, the RMRR information
> > for this device becomes invalid and needs to be reprocessed to avoid DMA
> > Read errors. These errors are evidenced by the Present bit being cleared in
> > the device's context entry. Fixing this problem with an enhancement to process
> > the RMRR info when the device is assigned to another domain. The Bus Master bit
> > is cleared during the move to another domain and during the reprocessing of
> > the RMRR info so no DMA can take place at this time.
> > ----
> > PATCH v1: https://lkml.org/lkml/2012/6/15/204
> > 
> > drivers/iommu/intel-iommu.c |   47 ++++++++++++++++++++++++++++++++++++++++--
> >  1 files changed, 44 insertions(+), 3 deletions(-)
> > 
> > Signed-off-by: Thomas Mingarelli <thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
> > 
> > diff -up ./drivers/iommu/intel-iommu.c.ORIG ./drivers/iommu/intel-iommu.c
> > --- ./drivers/iommu/intel-iommu.c.ORIG	2012-09-18 09:58:25.147976889 -0500
> > +++ ./drivers/iommu/intel-iommu.c	2012-09-18 10:39:43.286672765 -0500
> > @@ -2706,11 +2706,39 @@ static int iommu_dummy(struct pci_dev *p
> >  	return pdev->dev.archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
> >  }
> >  
> > +static int reprocess_rmrr(struct device *dev)
> > +{
> > +	struct dmar_rmrr_unit *rmrr;
> > +	struct pci_dev *pdev;
> > +	int i, ret;
> > +
> > +	pdev = to_pci_dev(dev);
> > +
> > +	for_each_rmrr_units(rmrr) {
> > +		for (i = 0; i < rmrr->devices_cnt; i++) {
> > +			/*
> > +			 * Here we are just concerned with
> > +			 * finding the one device that was
> > +			 * removed from the si_domain and
> > +			 * re-evaluating its RMRR info.
> > +			 */
> 
> I'm still not sure why this comment is wrapped so tightly.
> 
> > +			if (rmrr->devices[i] != pdev)
> > +				continue;
> > +			pr_info("IOMMU: Reprocess RMRR information for device %s.\n",
> > +				pci_name(pdev));
> > +			ret = iommu_prepare_rmrr_dev(rmrr, pdev);
> > +			if (ret)
> > +				pr_err("IOMMU: Reprocessing RMRR reserved region for device failed");
> 
> This could be "if (iommu_prepare_rmrr...)" because...
> 
> > +		}
> > +	}
> > +return 0;
> 
> Why does return anything?  Looks like it could be a void function since
> you're not returning the only possible error case above and not checking
> the return value below.  You're missing an indent here anyway.
> 
> > +}
> > +
> >  /* Check if the pdev needs to go through non-identity map and unmap process.*/
> >  static int iommu_no_mapping(struct device *dev)
> >  {
> >  	struct pci_dev *pdev;
> > -	int found;
> > +	int found, current_bus_master;
> >  
> >  	if (unlikely(dev->bus != &pci_bus_type))
> >  		return 1;
> > @@ -2731,9 +2759,22 @@ static int iommu_no_mapping(struct devic
> >  			 * 32 bit DMA is removed from si_domain and fall back
> >  			 * to non-identity mapping.
> >  			 */
> > -			domain_remove_one_dev_info(si_domain, pdev);
> >  			printk(KERN_INFO "32bit %s uses non-identity mapping\n",
> > -			       pci_name(pdev));
> > +				pci_name(pdev));
> 
> White space damage?  Change this to a pr_info if you really want to
> touch it.
> 
> > +			/*
> > +			 * If a device gets this far we need to clear the Bus
> > +			 * Master bit before we start moving devices from domain
> > +			 * to domain. We will also reset the Bus Master bit
> > +			 * after reprocessing the RMRR info. However, we only
> > +			 * do both the clearing and setting if needed.
> > +			 */
> > +			current_bus_master = pdev->is_busmaster;
> > +			if (current_bus_master)
> > +				pci_clear_master(pdev);
> > +			domain_remove_one_dev_info(si_domain, pdev);
> > +			reprocess_rmrr(dev);
> > +			if (current_bus_master)
> > +				pci_set_master(pdev);
> 
> I don't know any better way to halt DMA since we can't move the device
> to a new domain atomically, but what about the other cases where we
> switch domains?  For instance, what if some unsuspecting user tries to
> assign the device to a guest?  I think it's generally inadvisable to
> assign a devices with RMRRs to a guest, but if they do, they're going to
> run into the same problem.  The RMRRs aren't reprocessed for the VM
> domain and again aren't reprocessed when returned to a standard device
> domain.  Even more fun, if assigned to a VM domain, RMRRs should be
> added with the device and removed if the device is later detached from
> the domain.
> 
> The lazy solution might be to disallow devices with RMRRs from being
> attached via the IOMMU API interfaces (do we need more reasons not to
> use RMRRs?).  Otherwise we need to be proactive about setting up a new
> domain with RMRR entries for every case and correctly tracking RMRRs for
> VM domains.  Thanks,
> 
> Alex
> 
> >  			return 0;
> >  		}
> >  	} else {
> 
> 
> 
