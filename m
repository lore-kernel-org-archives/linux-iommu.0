From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Mon, 23 Jul 2018 23:16:05 +0100
Message-ID: <cover.1532382222.git.robin.murphy@arm.com>
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
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst the common firmware code invoked by dma_configure() initialises
devices' DMA masks according to limitations described by the respective
properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
the dma_set_mask() API leads to that information getting lost when
well-behaved drivers probe and set a 64-bit mask, since in general
there's no way to tell the difference between a firmware-described mask
(which should be respected) and whatever default may have come from the
bus code (which should be replaced outright). This can break DMA on
systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
only knows its maximum supported address size, not how many of those
address bits might actually be wired up between any of its input
interfaces and the associated DMA master devices. Similarly, some PCIe
root complexes only have a 32-bit native interface on their host bridge,
which leads to the same DMA-address-truncation problem in systems with a
larger physical memory map and RAM above 4GB (e.g. [2]).

These patches attempt to deal with this in the simplest way possible by
generalising the specific quirk for 32-bit bridges into an arbitrary
mask which can then also be plumbed into the firmware code. In the
interest of being minimally invasive, I've only included a point fix
for the IOMMU issue as seen on arm64 - there may be further tweaks
needed in DMA ops (e.g. in arch/arm/ and other OF users) to catch all
possible incarnations of this problem, but at least any that I'm not
fixing here have always been broken. It is also noteworthy that
of_dma_get_range() has never worked properly for the way PCI host
bridges are passed into of_dma_configure() - I'll be working on
further patches to sort that out once this part is done.

Changes since v1 (RFC):
- Pull in patch #1 (previously sent separately) to avoid conflicts
- Fix up comment and silly build-breaking typo in patch #2
- Add patches #6 and #7 since fiddling with coherent masks no longer
  serves a reasonable purpose

Robin.


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html

Robin Murphy (7):
  ACPI/IORT: Support address size limit for root complexes
  dma-mapping: Generalise dma_32bit_limit flag
  ACPI/IORT: Set bus DMA mask as appropriate
  of/device: Set bus DMA mask as appropriate
  iommu/dma: Respect bus DMA limit for IOVAs
  ACPI/IORT: Don't set default coherent DMA mask
  OF: Don't set default coherent DMA mask

 arch/x86/kernel/pci-dma.c |  2 +-
 drivers/acpi/arm64/iort.c | 50 ++++++++++++++++++++++++++++-----------
 drivers/iommu/dma-iommu.c |  3 +++
 drivers/of/device.c       | 21 ++++++++--------
 include/linux/device.h    |  6 ++---
 kernel/dma/direct.c       |  6 ++---
 6 files changed, 57 insertions(+), 31 deletions(-)

-- 
2.17.1.dirty
