From: Oza Pawandeep via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v2 0/3] OF/PCI address PCI inbound memory limitations
Date: Fri,  5 May 2017 17:27:15 +0530
Message-ID: <1493985437-2748-1-git-send-email-oza.oza@broadcom.com>
Reply-To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

It is possible that PCI device supports 64-bit DMA addressing,
and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
however PCI host bridge may have limitations on the inbound 
transaction addressing.

This is particularly problematic on ARM/ARM64 SOCs where the 
IOMMU (i.e. SMMU) translates IOVA to PA for in-bound transactions
only after PCI Host has forwarded these transactions on SOC IO bus. 

This means, on such ARM/ARM64 SOCs the IOVA of in-bound transactions
has to honor the addressing restrictions of the PCI Host.

Current device framework and OF framework integration assumes
dma-ranges in a way where memory-mapped devices define their
dma-ranges. (child-bus-address, parent-bus-address, length).

of_dma_configure is specifically written to take care of memory
mapped devices but no implementation exists for pci devices.

For e.g. iproc based SOCs and other SOCs (such as rcar) have
PCI world dma-ranges.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;

This patchset
reserves the IOVA ranges for PCI masters based
on the PCI world dma-ranges.
fix of_dma_get_range to cater to PCI dma-ranges.
fix of_dma_get_range which currently returns size 0 for PCI devices.

IOVA allocation patch:
[PATCH 2/3] iommu/pci: reserve iova for PCI masters

Fix of_dma_get_range bug and address PCI master.
[PATCH 3/3] PCI/of fix of_dma_get_range; get PCI specific

Base patch for both of the above patches:
[PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters

Changes since v2:
- Remove internal detailes such as reviewed by	

Changes since v1:
- Remove internal GERRIT details from patch descriptions
- address Rob's comments.
- Add a get_dma_ranges() function to of_bus struct..
- Convert existing contents of this function to of_bus_default_dma_get_ranges
  and adding that to the default of_bus struct.
- Make of_dma_get_range call of_bus_match() and then bus->get_dma_ranges.
- no revison for [PATCH 2/3] iommu/pci: reserve iova for PCI masters; since under discussion with Robin
  
Oza Pawandeep (3):
  of/pci/dma: fix DMA configuration for PCI masters
  iommu/pci: reserve iova for PCI masters
  PCI/of fix of_dma_get_range; get PCI specific dma-ranges

 drivers/iommu/dma-iommu.c | 35 +++++++++++++++++++++
 drivers/of/address.c      | 52 ++++++++++++++++++++++++++++++++
 drivers/of/of_pci.c       | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h    |  7 +++++
 4 files changed, 171 insertions(+)

-- 
1.9.1
