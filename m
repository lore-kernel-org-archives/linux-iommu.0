From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Partial BAR Address Allocation
Date: Wed, 22 Feb 2017 17:39:44 -0600
Message-ID: <20170222233944.GB4359@bhelgaas-glaptop.roam.corp.google.com>
References: <35c6bec9-58e8-a1f7-5a85-d80c23480d32@codeaurora.org>
	<20170222184440.GA2132@bhelgaas-glaptop.roam.corp.google.com>
	<43c1ff36-fc50-8ea4-02fe-7b1d573a1efd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43c1ff36-fc50-8ea4-02fe-7b1d573a1efd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+cc Joerg, iommu list]

On Wed, Feb 22, 2017 at 03:44:53PM -0500, Sinan Kaya wrote:
> On 2/22/2017 1:44 PM, Bjorn Helgaas wrote:
> > There is no way for a driver to say "I only need this memory BAR and
> > not the other ones."  The reason is because the PCI_COMMAND_MEMORY bit
> > enables *all* the memory BARs; there's no way to enable memory BARs
> > selectively.  If we enable memory BARs and one of them is unassigned,
> > that unassigned BAR is enabled, and the device will respond at
> > whatever address the register happens to contain, and that may cause
> > conflicts.
> > 
> > I'm not sure this answers your question.  Do you want to get rid of
> > 32-bit BAR addresses because your host bridge doesn't have a window to
> > 32-bit PCI addresses?  It's typical for a bridge to support a window
> > to the 32-bit PCI space as well as one to the 64-bit PCI space.  Often
> > it performs address translation for the 32-bit window so it doesn't
> > have to be in the 32-bit area on the CPU side, e.g., you could have
> > something like this where we have three host bridges and the 2-4GB
> > space on each PCI root bus is addressable:
> > 
> >   pci_bus 0000:00: root bus resource [mem 0x1080000000-0x10ffffffff] (bus address [0x80000000-0xffffffff])
> >   pci_bus 0001:00: root bus resource [mem 0x1180000000-0x11ffffffff] (bus address [0x80000000-0xffffffff])
> >   pci_bus 0002:00: root bus resource [mem 0x1280000000-0x12ffffffff] (bus address [0x80000000-0xffffffff])
> 
> The problem is that according to PCI specification BAR addresses and
> DMA addresses cannot overlap.
> 
> From PCI-to-PCI Bridge Arch. spec.: "A bridge forwards PCI memory
> transactions from its primary interface to its secondary interface
> (downstream) if a memory address is in the range defined by the
> Memory Base and Memory Limit registers (when the base is less than
> or equal to the limit) as illustrated in Figure 4-3. Conversely, a
> memory transaction on the secondary interface that is within this
> address range will not be forwarded upstream to the primary
> interface."
> 
> To be specific, if your DMA address happens to be in
> [0x80000000-0xffffffff] and root port's aperture includes this
> range; the DMA will never make to the system memory.
> 
> Lorenzo and Robin took some steps to carve out PCI addresses out of
> DMA addresses in IOMMU drivers by using iova_reserve_pci_windows()
> function.
> 
> However, I see that we are still exposed when the operating system
> doesn't have any IOMMU driver and is using the SWIOTLB for instance. 

Hmmm.  I guess SWIOTLB assumes there's no address translation in the
DMA direction, right?  If there's no address translation in the PIO
direction, PCI bus BAR addresses are identical to the CPU-side
addresses.  In that case, there's no conflict because we already have
to assign BARs so they never look like a system memory address.

But if there *is* address translation in the PIO direction, we can
have conflicts because the bridge can translate CPU-side PIO accesses
to arbitrary PCI bus addresses.

> The FW solution I'm looking at requires carving out some part of the
> DDR from before OS boot so that OS doesn't reclaim that area for
> DMA.

If you want to reach system RAM, I guess you need to make sure you
only DMA to bus addresses outside the host bridge windows, as you said
above.  DMA inside the windows would be handled as peer-to-peer DMA.

> I'm not very happy with this solution. I'm also surprised that there
> is no generic solution in the kernel takes care of this for all root
> ports regardless of IOMMU driver presence.

The PCI core isn't really involved in allocating DMA addresses,
although there definitely is the connection with PCI-to-PCI bridge
windows that you mentioned.  I added IOMMU guys, who would know a lot
more than I do.

Bjorn
