From: Oza Pawandeep via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v7 0/3] PCI/IOMMU: Reserve IOVAs for PCI inbound memory
Date: Mon, 22 May 2017 22:09:39 +0530
Message-ID: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
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

iproc based PCI RC and Stingray SOC has limitaiton of addressing only 512GB
memory at once.

IOVA allocation honors device's coherent_dma_mask/dma_mask.
In PCI case, current code honors DMA mask set by EP, there is no
concept of PCI host bridge dma-mask,  should be there and hence
could truly reflect the limitation of PCI host bridge.

However assuming Linux takes care of largest possible dma_mask, still the
limitation could exist, because of the way memory banks are implemented.

for e.g. memory banks:
<0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
<0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
<0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
<0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */

When run User space (SPDK) which internally uses vfio in order to access
PCI EndPoint directly.

Vfio uses huge-pages which could come from 640G/0x000000a0. 
And the way vfio maps the hugepage is to have phys addr as iova,
and ends up calling VFIO_IOMMU_MAP_DMA ends up calling iommu_map,
inturn arm_lpae_map mapping iovas out of range.

So the way kernel allocates IOVA (where it honours device dma_mask) and
the way userspace gets IOVA is different.

dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>; will not work.

Instead we have to go for scattered dma-ranges leaving holes.
Hence, we have to reserve IOVA allocations for inbound memory.
The patch-set caters to only addressing IOVA allocation problem.

Changes since v7:
- Robin's comment addressed
where he wanted to remove depedency between IOMMU and OF layer.
- Bjorn Helgaas's comments addressed.

Changes since v6:
- Robin's comments addressed.

Changes since v5:
Changes since v4:
Changes since v3:
Changes since v2:
- minor changes, redudant checkes removed
- removed internal review

Changes since v1:
- address Rob's comments.
- Add a get_dma_ranges() function to of_bus struct..
- Convert existing contents of of_dma_get_range function to
  of_bus_default_dma_get_ranges and adding that to the
  default of_bus struct.
- Make of_dma_get_range call of_bus_match() and then bus->get_dma_ranges.


Oza Pawandeep (3):
  OF/PCI: expose inbound memory interface to PCI RC drivers.
  IOMMU/PCI: reserve IOVA for inbound memory for PCI masters
  PCI: add support for inbound windows resources

 drivers/iommu/dma-iommu.c | 44 ++++++++++++++++++++--
 drivers/of/of_pci.c       | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       | 30 +++++++++++++--
 include/linux/of_pci.h    |  7 ++++
 include/linux/pci.h       |  1 +
 5 files changed, 170 insertions(+), 8 deletions(-)

-- 
1.9.1
