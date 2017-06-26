From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.13
Date: Mon, 26 Jun 2017 11:42:42 +0100
Message-ID: <20170626104241.GE1691@arm.com>
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
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these arm-smmu updates for 4.13. The headline feature is Robin's
conversion of the page table code to a lockless implementation, which
significantly closes the DMA performance gap when compared to a system with
the SMMU in bypass mode. We'll look at improving unmap performance further
in the next cycle.

Other than that, we have a healthy crop of errata workarounds:

  * Cavium forgot to hook up all the registers in their implementation ...
  * ... but they did remember to OR all the interrupts together (including
    across devices!)
  * Hisilicon forgot to implement the PREFETCH command (we already handled
    this for DT, but not ACPI)

Due to the interaction with ACPI IORT, there are some IORT changes included
here that have been acked-by Lorenzo. Note that there's a trivial conflict
with the kvm-arm tree in linux-next, since both trees add a line to
silicon-errata.txt.

We also have some minor cleanups and a bump to the CMDQ timeout.

Cheers,

Will

--->8

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to f935448acf462c26142e8b04f1c8829b28d3b9d8:

  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126 (2017-06-23 17:58:04 +0100)

----------------------------------------------------------------
Arvind Yadav (3):
      iommu/io-pgtable-arm-v7s: constify dummy_tlb_ops.
      iommu: arm-smmu-v3: make of_device_ids const
      iommu: arm-smmu: Handle return of iommu_device_register.

Geetha Sowjanya (1):
      iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

Linu Cherian (2):
      ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3 model
      iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74

Robert Richter (1):
      iommu/arm-smmu-v3, acpi: Add temporary Cavium SMMU-V3 IORT model number definitions

Robin Murphy (9):
      iommu/arm-smmu: Plumb in new ACPI identifiers
      iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
      iommu/io-pgtable-arm: Improve split_blk_unmap
      iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
      iommu/io-pgtable: Introduce explicit coherency
      iommu/io-pgtable-arm: Support lockless operation
      iommu/io-pgtable-arm-v7s: Support lockless operation
      iommu/arm-smmu: Remove io-pgtable spinlock
      iommu/arm-smmu-v3: Remove io-pgtable spinlock

Sunil Goutham (1):
      iommu/arm-smmu-v3: Increase CMDQ drain timeout value

Will Deacon (2):
      iommu/io-pgtable: depend on !GENERIC_ATOMIC64 when using COMPILE_TEST with LPAE
      iommu/io-pgtable-arm: Use dma_wmb() instead of wmb() when publishing table

shameer (1):
      iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH quirk(erratum 161010701)

 Documentation/arm64/silicon-errata.txt             |   3 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  12 ++
 drivers/acpi/arm64/iort.c                          |  83 ++++++--
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 229 ++++++++++++++-------
 drivers/iommu/arm-smmu.c                           |  64 +++---
 drivers/iommu/io-pgtable-arm-v7s.c                 | 183 ++++++++++------
 drivers/iommu/io-pgtable-arm.c                     | 189 +++++++++++------
 drivers/iommu/io-pgtable.h                         |   6 +
 9 files changed, 523 insertions(+), 248 deletions(-)
