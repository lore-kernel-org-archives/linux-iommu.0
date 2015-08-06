From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.3
Date: Thu, 6 Aug 2015 16:07:50 +0100
Message-ID: <20150806150749.GF25483@arm.com>
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
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Here are the arm-smmu and io-pgtable updates I have for 4.3. Main
changes include:

  * Preparation for MSI support for SMMUv3 devices (full support will
    likely come in 4.4, since the IRQ core needs some work to support
    non-PCI devices).

  * A couple of minor fixes in the SMMUv3 driver

  * Support for the dma-coherent propery on SMMUv1/2 devices

  * Removal of the DMA API abuse for flushing page tables out to a
    non-coherent walker. This raised some questions about the DMA API
    Documentation, so I've put these last in the series in case you
    decide not to include them (but I think they're a welcome clean-up).

Please pull,

Will

--->8

The following changes since commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f:

  Linux 4.2-rc4 (2015-07-26 12:26:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to f5b831907da3e64bfb0288089a5c07124266b1a5:

  iommu/io-pgtable: Remove flush_pgtable callback (2015-08-06 14:35:40 +0100)

----------------------------------------------------------------
Marc Zyngier (2):
      iommu/arm-smmu: Fix enabling of PRIQ interrupt
      iommu/arm-smmu: Fix MSI memory attributes to match specification

Robin Murphy (9):
      iommu/arm-smmu: Sort out coherency
      iommu/io-pgtable-arm: Allow appropriate DMA API use
      iommu/arm-smmu: Clean up DMA API usage
      iommu/arm-smmu: Clean up DMA API usage
      iommu/ipmmu-vmsa: Clean up DMA API usage
      iommu/io-pgtable-arm: Centralise sync points
      iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
      iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
      iommu/io-pgtable: Remove flush_pgtable callback

Will Deacon (2):
      iommu/arm-smmu: Limit 2-level strtab allocation for small SID sizes
      iommu/arm-smmu: Treat unknown OAS as 48-bit

 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 +
 drivers/iommu/Kconfig                              |   3 +-
 drivers/iommu/arm-smmu-v3.c                        |  66 +++++------
 drivers/iommu/arm-smmu.c                           |  45 +++-----
 drivers/iommu/io-pgtable-arm.c                     | 126 +++++++++++++++------
 drivers/iommu/io-pgtable.h                         |   9 +-
 drivers/iommu/ipmmu-vmsa.c                         |  19 +---
 7 files changed, 157 insertions(+), 117 deletions(-)
