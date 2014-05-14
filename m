From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 08/15] iommu/amd: Use pci_find_dma_isolation_root()
	for IOMMU groups
Date: Wed, 14 May 2014 08:27:11 -0600
Message-ID: <1400077631.17639.185.camel@ul30vt.home>
References: <20140510145619.2997.429.stgit@bling.home>
	<20140510150311.2997.62903.stgit@bling.home>
	<20140514103449.GE6026@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140514103449.GE6026-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2014-05-14 at 12:34 +0200, Joerg Roedel wrote:
> On Sat, May 10, 2014 at 09:03:11AM -0600, Alex Williamson wrote:
> > The expectation is that the kernel and IVRS will produce the same
> > result for topology based aliases while the kernel will also include
> > device specific DMA quirks.
> 
> Is that expectation really true? There are PCIe devices out there that
> don't use their own device-id for requests but another one that isn't
> even visible as a PCI device (so the kernel has no pci_dev structure for
> it). The IVRS table contains such information, but I am not sure whether
> the PCI core finds the right requestor-id for those devices.
> 
> I've seen this on PCIe cards that where the vendor just used an PCI-X
> chip with a PCIe-to-PCI-X bridge on the card. The PCI-X device is
> visible for the OS but uses the requestor-id of the invisible bridge.

If we rely on the IVRS, then the set of devices with quirked aliases is
fixed by the platform vendor.  More often than not, I think that proves
to be ineffective.  I personally have a 990FX box with a single function
Marvell SATA controller that uses function 1 as the requester ID.  It's
running the latest BIOS and the IVRS isn't helping.  With this series,
we have the ability to add quirks to the kernel to fix those kinds of
issues for both AMD-Vi, VT-d, and any other IOMMU.

Here I've chosen that we get more value from using shared code so we
don't process IOMMU groups in a unique way for AMD-Vi.  Patch 09/15 uses
the PCI core alias when the IVRS doesn't provide one, perhaps a
compromise would be to also do the reverse and update dma_func_alias on
the device when the IVRS knows of a device quirk that the kernel
doesn't.  Then we could still use the common IOMMU group code and print
something to dmesg so that we can update the kernel quirks.  Thanks,

Alex
