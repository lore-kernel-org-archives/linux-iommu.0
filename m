From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: possible dmar_init_reserved_ranges() error
Date: Mon, 19 Dec 2016 15:20:44 -0600
Message-ID: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rwright-ZPxbGqLxI0U@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi guys,

I have some questions about dmar_init_reserved_ranges().  On systems
where CPU physical address space is not identity-mapped to PCI bus
address space, e.g., where the PCI host bridge windows have _TRA
offsets, I'm not sure we're doing the right thing.

Assume we have a PCI host bridge with _TRA that maps CPU addresses
0x80000000-0x9fffffff to PCI bus addresses 0x00000000-0x1fffffff, with
two PCI devices below it:

  PCI host bridge domain 0000 [bus 00-3f]
  PCI host bridge window [mem 0x80000000-0x9fffffff] (bus 0x00000000-0x1fffffff]
  00:00.0: BAR 0 [mem 0x80000000-0x8ffffffff] (0x00000000-0x0fffffff on bus)
  00:01.0: BAR 0 [mem 0x90000000-0x9ffffffff] (0x10000000-0x1fffffff on bus)

The IOMMU init code in dmar_init_reserved_ranges() reserves the PCI
MMIO space for all devices:

  pci_iommu_init()
    intel_iommu_init()
      dmar_init_reserved_ranges()
        reserve_iova(0x80000000-0x8ffffffff)
        reserve_iova(0x90000000-0x9ffffffff)

This looks odd because we're reserving CPU physical addresses, but
the IOVA space contains *PCI bus* addresses.  On most x86 systems they
would be the same, but not on all.

Assume the driver for 00:00.0 maps a page of main memory for DMA.  It
may receive a dma_addr_t of 0x10000000:

  00:00.0: intel_map_page() returns dma_addr_t 0x10000000
  00:00.0: issues DMA to 0x10000000

What happens here?  The DMA access should go to main memory.  In
conventional PCI it would be a peer-to-peer access to device 00:01.0.
Is there enough PCIe smarts (ACS or something?) to do otherwise?

The dmar_init_reserved_ranges() comment says "Reserve all PCI MMIO to
avoid peer-to-peer access."  Without _TRA, CPU addresses and PCI bus
addresses would be identical, and I think these reserve_iova() calls
*would* prevent this situation.  So maybe we're just missing a
pcibios_resource_to_bus() here?

Bjorn
