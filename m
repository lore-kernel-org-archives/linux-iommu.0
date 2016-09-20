From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.9
Date: Tue, 20 Sep 2016 11:25:34 +0100
Message-ID: <20160920102534.GC17978@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these significant arm-smmu updates for 4.9. The vast majority
of the code here is Robin's series to move the drivers over to the
generic DT bindings, which finally hooks up the DMA API and MSI mapping
for host machines. This has been stewing for a while and is now at the
point where I feel it's much better in mainline than languishing outside.

A consequence of that is that there are some non-trivial changes outside
of the drivers, but these are all acked by the relevant subsystem
maintainers.

Other stuff here includes some non-critical fixes to the queue handling
on SMMUv3 and a small devm cleanup that missed the boat last time around.

Cheers,

Will

--->8

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 82db33dc5e49fb625262d81125625d07a0d6184e:

  iommu/io-pgtable-arm: Check for v7s-incapable systems (2016-09-16 09:34:23 +0100)

----------------------------------------------------------------
Jean-Philippe Brucker (2):
      iommu/arm-smmu: Fix event queues synchronization
      iommu/arm-smmu: Fix polling of command queue

Mark Rutland (1):
      Docs: dt: add PCI IOMMU map bindings

Peng Fan (1):
      iommu/arm-smmu: Drop devm_free_irq when driver detach

Robin Murphy (23):
      iommu/arm-smmu: Support v7s context format
      of/irq: Break out msi-map lookup (again)
      iommu/of: Handle iommu-map property for PCI
      iommu: Introduce iommu_fwspec
      Docs: dt: document ARM SMMUv3 generic binding usage
      iommu/arm-smmu: Fall back to global bypass
      iommu/arm-smmu: Implement of_xlate() for SMMUv3
      iommu/arm-smmu: Support non-PCI devices with SMMUv3
      iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
      iommu/arm-smmu: Handle stream IDs more dynamically
      iommu/arm-smmu: Consolidate stream map entry state
      iommu/arm-smmu: Keep track of S2CR state
      iommu/arm-smmu: Refactor mmu-masters handling
      iommu/arm-smmu: Streamline SMMU data lookups
      iommu/arm-smmu: Add a stream map entry iterator
      iommu/arm-smmu: Intelligent SMR allocation
      iommu/arm-smmu: Convert to iommu_fwspec
      Docs: dt: document ARM SMMU generic binding usage
      iommu/arm-smmu: Wire up generic configuration support
      iommu/arm-smmu: Set domain geometry
      iommu/dma: Add support for mapping MSIs
      iommu/dma: Avoid PCI host bridge windows
      iommu/io-pgtable-arm: Check for v7s-incapable systems

Will Deacon (1):
      iommu/arm-smmu: Disable interrupts whilst holding the cmdq lock

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   8 +-
 .../devicetree/bindings/iommu/arm,smmu.txt         |  61 +-
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.h          |   2 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 561 ++++++------
 drivers/iommu/arm-smmu.c                           | 995 ++++++++++-----------
 drivers/iommu/dma-iommu.c                          | 161 +++-
 drivers/iommu/io-pgtable-arm-v7s.c                 |   4 +
 drivers/iommu/iommu.c                              |  58 ++
 drivers/iommu/of_iommu.c                           |  52 +-
 drivers/irqchip/irq-gic-v2m.c                      |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   |   3 +
 drivers/of/irq.c                                   |  78 +-
 drivers/of/of_pci.c                                | 102 +++
 include/linux/device.h                             |   3 +
 include/linux/dma-iommu.h                          |  12 +-
 include/linux/iommu.h                              |  39 +
 include/linux/of_pci.h                             |  10 +
 20 files changed, 1430 insertions(+), 897 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
