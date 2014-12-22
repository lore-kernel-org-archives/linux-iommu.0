From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 22 Dec 2014 14:36:01 +0100
Message-ID: <7693528.krAZff0s6I@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<2983977.dWWQcFZRoJ@wuerfel> <20141221100451.GA23242@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141221100451.GA23242-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sunday 21 December 2014 10:04:51 Will Deacon wrote:
> On Wed, Dec 17, 2014 at 07:48:29PM +0000, Arnd Bergmann wrote:
> > On Wednesday 17 December 2014 17:17:52 Will Deacon wrote:
> > > > > > I would hope that PCI is the only case we need to worry about for a while.
> > > > > > This means we just need to come up with another property or a set of properties
> > > > > > that we can put into a PCI host controller device node in order to describe
> > > > > > the mapping. These properties could be iommu-specific, so we add something
> > > > > > to the PCI core that calls a new iommu callback function that takes the
> > > > > > device node of the PCI host and the bus/device/function number as inputs.
> > > > > > 
> > > > > > In arm_setup_iommu_dma_ops(), we can then do something like
> > > > > > 
> > > > > >   if (dev_is_pci(dev)) {
> > > > > >           struct pci_dev *pdev = to_pci_dev(dev);
> > > > > >           struct device_node *node;
> > > > > >           unsigned int bdf;
> > > > > > 
> > > > > >           node = find_pci_host_bridge(pdev->bus)->parent->of_node;
> > > > > >           bdf = PCI_DEVID(pdev->bus->number, dev->devfn);
> > > > > > 
> > > > > >           iommu_setup_pci_dev(pdev, node, bdf);
> > > > > >   }
> > > > > 
> > > > > The other way to do this is have the IOMMU driver check dev_is_pci(dev)
> > > > > in add_device, then call an of_xlate_pci_bdf library function which could
> > > > > do the translation on-demand.
> > > > 
> > > > We'd still need to find the device node for the host controller in
> > > > common code, otherwise we don't have an of_xlate function to call.
> > > 
> > > I guess I was hoping that the translation code could be generic. I don't
> > > really see anything special about adding a constant to a magic number to
> > > obtain another magic number.
> > > 
> > 
> > If that's all we need, that's fine.
> > 
> > I was fearing that we'd get different host controllers using different
> > parts of the bdf number. E.g. one might pass down just bus/device
> > while another uses bus/device/function, so we'd need a shift and
> > an offset.
> 
> We could still encode that as adding a constant, modulo the streamid
> width though, right? I agree that it would be nasty, because we'd have to
> list a whole bunch of offsets for each function rather than group things
> into ranges. Still, it gives us something to start with.
> 
> FWIW, this (adding an offset) is also the direction that the ACPI IORT
> description is going in, so at least we have parity there.

Ok, in that case, I think just using the 'iommus' property would work,
with yet another format to cover the SMMU case of passing a range
of StreamIDs. With #iommu-cells=<3>, we can have a tuple of
mask/value/length that would be able to cover all cases.

> > As part of the AMD review I found out that their SMMU implementation
> > only has 15 bits of address space, while bdf is 16 bits, so they
> > cut off the top bit and get aliasing between bus 0+n and bus 128+n.
> > 
> > Another SoC might have more aliasing if they have multiple domains.
> 
> This particular aliasing is probably going to be pretty common; the ARM
> SMMU typically only supports 15-bit StreamIDs (there is an extension to
> 16-bit, but I haven't seen one built yet and the driver doesn't even support
> it).

In case of AMD, I asked the maintainers to put a bus-range = <0 127> into
the PCI host node to address that. I've seen something similar while
discussing another SoC that had multiple PCI hosts connected to the
same SMMU and my comment back then was a recommendation to not have distinct
bus-range properties in each one (e.g. <0 31>, <32 63>, <64 95>, <96 127>
for four hosts), but I suppose that is actually the cleanest way to deal
with it.

Do you think it's possible that we might have to deal with a single PCI host
that is connected two different SMMU instances for the purposes of extending
the StreamID space from 15 to 16 bits? I think we would have trouble
expressing this with the current syntax.

	Arnd
