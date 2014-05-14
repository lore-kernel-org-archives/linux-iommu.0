From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 08/15] iommu/amd: Use pci_find_dma_isolation_root()
 for IOMMU groups
Date: Wed, 14 May 2014 12:34:50 +0200
Message-ID: <20140514103449.GE6026@8bytes.org>
References: <20140510145619.2997.429.stgit@bling.home>
 <20140510150311.2997.62903.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140510150311.2997.62903.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, bhelgaas@google.com, acooks@gmail.com, linux-kernel@vger.kernel.org, linux@horizon.com
List-Id: iommu@lists.linux-foundation.org

On Sat, May 10, 2014 at 09:03:11AM -0600, Alex Williamson wrote:
> The expectation is that the kernel and IVRS will produce the same
> result for topology based aliases while the kernel will also include
> device specific DMA quirks.

Is that expectation really true? There are PCIe devices out there that
don't use their own device-id for requests but another one that isn't
even visible as a PCI device (so the kernel has no pci_dev structure for
it). The IVRS table contains such information, but I am not sure whether
the PCI core finds the right requestor-id for those devices.

I've seen this on PCIe cards that where the vendor just used an PCI-X
chip with a PCIe-to-PCI-X bridge on the card. The PCI-X device is
visible for the OS but uses the requestor-id of the invisible bridge.


	Joerg
