From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
Date: Wed, 17 Dec 2014 16:35:29 +0100
Message-ID: <2299294.lPnEQgl4lK@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <3099591.NlcSS8Qjlv@wuerfel> <20141217144518.GE870@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141217144518.GE870@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Varun Sethi <Varun.Sethi@freescale.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wednesday 17 December 2014 14:45:18 Will Deacon wrote:
> On Wed, Dec 17, 2014 at 02:15:12PM +0000, Arnd Bergmann wrote:
> > On Wednesday 17 December 2014 12:09:49 Will Deacon wrote:
> > > On Tue, Dec 16, 2014 at 12:08:15PM +0000, Arnd Bergmann wrote:
> > > > On Monday 15 December 2014 18:09:33 Will Deacon wrote:
> > > For iommu_group creation, that could be done in the of code by treating the
> > > master IDs as bus IDs on a per-IOMMU bus; when a new device is probed, we
> > > can look at the set of devices with intersecting IDs and create a group
> > > containing those. This is similar to walking a PCI topology to establish DMA
> > > aliases.
> > > 
> > > The problem with all of this is how we distinguish the different ID formats
> > > in the `iommus' device-tree property. For the ARM SMMU, we could have:
> > > 
> > >   (1) [easy case] A device has a list of StreamIDs
> > > 
> > >   (2) A device has a list of SMR mask/value pairs
> > 
> > I was under the impression that using the format from (2), we could
> > describe all devices that fall into (1). In the worst case, we would
> > create an iommu group that is somewhat larger than one using discrete
> > StreamID values, but I would hope that this does not cause actual
> > troubles.
> 
> The icky part is that an ARM SMMU can have one of two indexing schemes in
> hardware:
> 
>   (1) The StreamID is used as a linear index into an (MMIO) table, which
>       has pointers to contexts (translation tables)
> 
>   (2) The StreamID is matched against a mask/value pair, which generates
>       an index into the same table mentioned above
> 
> Currently, the driver probes ID registers at runtime to figure out which
> indexing scheme is implemented. If we start encoding scheme-specific data in
> the device-tree, then the binding will differ based on hardware properties
> that aren't otherwise described. Is there precedent for this sort of thing
> elsewhere?

We should probably have different compatible strings in that case.
Is it always hardwired which scheme gets used, or can the SMMU
be reconfigured between the two?

> > If all devices on each iommu fall into either 1 or 2, but you never mix
> > the two on one iommu, this could be handled by supporting either
> > #iommu-cells=<1> or <2> in the smmu driver. That way, the xlate function
> > will know which method to apply by looking at the iommu's #iommu-cells
> > property.
> 
> Yes, that would work if you're ok with the above (i.e. we never see a mix
> on the same IOMMU instance).

Ok

> > >   (3) A (bus) device has a range translation for a downstream bus (e.g.
> > >       a PCI host controller which needs to convert RequesterID to StreamID).
> > > 
> > > From the SMMU driver's perspective, they will all look like of_xlate calls
> > > unless we augment the generic IOMMU bindings with extra properties to
> > > identify the format. It also makes it difficult to pick a sensible value for
> > > #iommu-cells, as it depends on the format.
> > 
> > I would hope that PCI is the only case we need to worry about for a while.
> > This means we just need to come up with another property or a set of properties
> > that we can put into a PCI host controller device node in order to describe
> > the mapping. These properties could be iommu-specific, so we add something
> > to the PCI core that calls a new iommu callback function that takes the
> > device node of the PCI host and the bus/device/function number as inputs.
> > 
> > In arm_setup_iommu_dma_ops(), we can then do something like
> > 
> > 	if (dev_is_pci(dev)) {
> > 		struct pci_dev *pdev = to_pci_dev(dev);
> > 		struct device_node *node;
> > 		unsigned int bdf;
> > 
> > 		node = find_pci_host_bridge(pdev->bus)->parent->of_node;
> > 		bdf = PCI_DEVID(pdev->bus->number, dev->devfn);
> > 
> > 		iommu_setup_pci_dev(pdev, node, bdf);
> > 	}
> 
> The other way to do this is have the IOMMU driver check dev_is_pci(dev)
> in add_device, then call an of_xlate_pci_bdf library function which could
> do the translation on-demand.

We'd still need to find the device node for the host controller in
common code, otherwise we don't have an of_xlate function to call.

	Arnd
