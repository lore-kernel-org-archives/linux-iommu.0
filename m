From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Wed, 17 Dec 2014 14:45:18 +0000
Message-ID: <20141217144518.GE870@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<2447060.c0PHi7y3cP@wuerfel> <20141217120948.GB870@arm.com>
	<3099591.NlcSS8Qjlv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3099591.NlcSS8Qjlv@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 17, 2014 at 02:15:12PM +0000, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 12:09:49 Will Deacon wrote:
> > On Tue, Dec 16, 2014 at 12:08:15PM +0000, Arnd Bergmann wrote:
> > > On Monday 15 December 2014 18:09:33 Will Deacon wrote:
> > > > > Using a single domain is a bit of a waste of resources in my case, so an 
> > > > > evolution would be to create four domains and assign devices to them based on 
> > > > > a policy. The policy could be fixed (round-robin for instance), or 
> > > > > configurable (possibly through DT, although it's really a policy, not a 
> > > > > hardware description).
> > > 
> > > I think in case of the ARM SMMU, we concluded that the grouping is indeed
> > > best done in DT, because of there is no good algorithmic way to come
> > > up with a set of bitmasks that make up a proper grouping into domains.
> > 
> > I think that's a slightly different case. The `grouping' in the DT, is on a
> > per-master basis where a master may have a set of StreamIDs, which can be
> > expressed in a more efficient (per-IOMMU) manner that cannot easily be
> > determined at runtime.
> > 
> > For iommu_group creation, that could be done in the of code by treating the
> > master IDs as bus IDs on a per-IOMMU bus; when a new device is probed, we
> > can look at the set of devices with intersecting IDs and create a group
> > containing those. This is similar to walking a PCI topology to establish DMA
> > aliases.
> > 
> > The problem with all of this is how we distinguish the different ID formats
> > in the `iommus' device-tree property. For the ARM SMMU, we could have:
> > 
> >   (1) [easy case] A device has a list of StreamIDs
> > 
> >   (2) A device has a list of SMR mask/value pairs
> 
> I was under the impression that using the format from (2), we could
> describe all devices that fall into (1). In the worst case, we would
> create an iommu group that is somewhat larger than one using discrete
> StreamID values, but I would hope that this does not cause actual
> troubles.

The icky part is that an ARM SMMU can have one of two indexing schemes in
hardware:

  (1) The StreamID is used as a linear index into an (MMIO) table, which
      has pointers to contexts (translation tables)

  (2) The StreamID is matched against a mask/value pair, which generates
      an index into the same table mentioned above

Currently, the driver probes ID registers at runtime to figure out which
indexing scheme is implemented. If we start encoding scheme-specific data in
the device-tree, then the binding will differ based on hardware properties
that aren't otherwise described. Is there precedent for this sort of thing
elsewhere?

> If all devices on each iommu fall into either 1 or 2, but you never mix
> the two on one iommu, this could be handled by supporting either
> #iommu-cells=<1> or <2> in the smmu driver. That way, the xlate function
> will know which method to apply by looking at the iommu's #iommu-cells
> property.

Yes, that would work if you're ok with the above (i.e. we never see a mix
on the same IOMMU instance).

> >   (3) A (bus) device has a range translation for a downstream bus (e.g.
> >       a PCI host controller which needs to convert RequesterID to StreamID).
> > 
> > From the SMMU driver's perspective, they will all look like of_xlate calls
> > unless we augment the generic IOMMU bindings with extra properties to
> > identify the format. It also makes it difficult to pick a sensible value for
> > #iommu-cells, as it depends on the format.
> 
> I would hope that PCI is the only case we need to worry about for a while.
> This means we just need to come up with another property or a set of properties
> that we can put into a PCI host controller device node in order to describe
> the mapping. These properties could be iommu-specific, so we add something
> to the PCI core that calls a new iommu callback function that takes the
> device node of the PCI host and the bus/device/function number as inputs.
> 
> In arm_setup_iommu_dma_ops(), we can then do something like
> 
> 	if (dev_is_pci(dev)) {
> 		struct pci_dev *pdev = to_pci_dev(dev);
> 		struct device_node *node;
> 		unsigned int bdf;
> 
> 		node = find_pci_host_bridge(pdev->bus)->parent->of_node;
> 		bdf = PCI_DEVID(pdev->bus->number, dev->devfn);
> 
> 		iommu_setup_pci_dev(pdev, node, bdf);
> 	}

The other way to do this is have the IOMMU driver check dev_is_pci(dev)
in add_device, then call an of_xlate_pci_bdf library function which could
do the translation on-demand.

Will
