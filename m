From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 00/12] Generic DT bindings for PCI and ARM SMMU
Date: Mon, 29 Feb 2016 13:46:09 +0000
Message-ID: <cover.1456514380.git.robin.murphy@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's an initial dump of what I've been doing for full generic binding
support on SMMUv2. I'm posting it as one big series because it all fits
together, but the OF and arm64 patches should be free to go through
their respective trees without horribly breaking anything (I think...)

Currently this just brings platform and PCI generic binding support to
the level of the old binding, and adds proper group creation - I have
more ongoing work on top of this to remove the stream ID limits and start
filling in SMR support, which will probably show up added/folded in to
subsequent revisions.

I've put a branch together (based on the SMMU changes in -next) here:

  git://linux-arm.org/linux-rm iommu/generic

Tested on Juno (MMU-401) and LS2085 (MMU-500) for both PCI and platform
devices, plus various combinations of stream ID aliasing between the
two. Since we don't yet have a robust solution for dealing with MSI
doorbells downstream of translation, there are some temporary hacks that
I've been running with on the iommu/msi branch.

Robin.
---

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (11):
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  arm64/dma-mapping: Extend DMA ops workaround to PCI devices
  arm64/dma-mapping: Remove default domain workaround
  iommu/arm-smmu: Streamline SMMU data lookup
  iommu/arm-smmu: Factor out mmu-masters handling
  iommu/arm-smmu: Refactor master/group config handling
  iommu/arm-smmu: Simplify mmu-masters handling
  Docs: dt: document ARM SMMU generic binding usage
  iommu/arm-smmu: Generic IOMMU DT bindings support
  iommu/arm-smmu: Group platform devices appropriately

 .../devicetree/bindings/iommu/arm,smmu.txt         |  40 +-
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++
 arch/arm64/mm/dma-mapping.c                        |  56 +-
 drivers/iommu/arm-smmu.c                           | 733 ++++++++++++---------
 drivers/iommu/of_iommu.c                           |  43 +-
 drivers/of/irq.c                                   |  70 +-
 drivers/of/of_pci.c                                | 102 +++
 include/linux/of_pci.h                             |   8 +
 8 files changed, 765 insertions(+), 458 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.7.2.333.g70bd996.dirty
