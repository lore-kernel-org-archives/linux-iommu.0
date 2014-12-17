From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Wed, 17 Dec 2014 17:17:52 +0000
Message-ID: <20141217171752.GB30307@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<3099591.NlcSS8Qjlv@wuerfel> <20141217144518.GE870@arm.com>
	<2299294.lPnEQgl4lK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2299294.lPnEQgl4lK@wuerfel>
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

On Wed, Dec 17, 2014 at 03:35:29PM +0000, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 14:45:18 Will Deacon wrote:
> > On Wed, Dec 17, 2014 at 02:15:12PM +0000, Arnd Bergmann wrote:
> > > On Wednesday 17 December 2014 12:09:49 Will Deacon wrote:
> > The icky part is that an ARM SMMU can have one of two indexing schemes in
> > hardware:
> > 
> >   (1) The StreamID is used as a linear index into an (MMIO) table, which
> >       has pointers to contexts (translation tables)
> > 
> >   (2) The StreamID is matched against a mask/value pair, which generates
> >       an index into the same table mentioned above
> > 
> > Currently, the driver probes ID registers at runtime to figure out which
> > indexing scheme is implemented. If we start encoding scheme-specific data in
> > the device-tree, then the binding will differ based on hardware properties
> > that aren't otherwise described. Is there precedent for this sort of thing
> > elsewhere?
> 
> We should probably have different compatible strings in that case.
> Is it always hardwired which scheme gets used, or can the SMMU
> be reconfigured between the two?

It's a hard-wired thing that is advertised in a read-only ID register. I'm
not too keen on a different compatible string for that, because there are
all sorts of features like this that could quickly get messy. How about
using #iommu-cells to distinguish between them, as Robin suggested? If
iommu-cells is #2, then we're going to be using stream-matching and fail
the probe if it's not supported by the IOMMU.

> > > I would hope that PCI is the only case we need to worry about for a while.
> > > This means we just need to come up with another property or a set of properties
> > > that we can put into a PCI host controller device node in order to describe
> > > the mapping. These properties could be iommu-specific, so we add something
> > > to the PCI core that calls a new iommu callback function that takes the
> > > device node of the PCI host and the bus/device/function number as inputs.
> > > 
> > > In arm_setup_iommu_dma_ops(), we can then do something like
> > > 
> > > 	if (dev_is_pci(dev)) {
> > > 		struct pci_dev *pdev = to_pci_dev(dev);
> > > 		struct device_node *node;
> > > 		unsigned int bdf;
> > > 
> > > 		node = find_pci_host_bridge(pdev->bus)->parent->of_node;
> > > 		bdf = PCI_DEVID(pdev->bus->number, dev->devfn);
> > > 
> > > 		iommu_setup_pci_dev(pdev, node, bdf);
> > > 	}
> > 
> > The other way to do this is have the IOMMU driver check dev_is_pci(dev)
> > in add_device, then call an of_xlate_pci_bdf library function which could
> > do the translation on-demand.
> 
> We'd still need to find the device node for the host controller in
> common code, otherwise we don't have an of_xlate function to call.

I guess I was hoping that the translation code could be generic. I don't
really see anything special about adding a constant to a magic number to
obtain another magic number.

Will
