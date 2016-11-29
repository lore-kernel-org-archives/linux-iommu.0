From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.10
Date: Tue, 29 Nov 2016 17:28:22 +0000
Message-ID: <20161129172822.GI30283@arm.com>
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
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these arm-smmu updates for 4.10. The bulk of the changes here
are the IORT support from Lorenzo, which also touches ACPI and PCI core
code. Rafael and Bjorn have acked the relevant changes, but it makes sense
to send it via you to avoid conflicts with the ARM SMMU drivers, which are
modified to work with ACPI-based probing.

The other changes are largely cosmetic (constification and cleanup), but
the MMU-500 configuration change from Nipun results in a hefty performance
boost in bypass mode.

Thanks,

Will

--->8

The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:

  Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 643b8e4d86f8b1a62cf5cd9ea221e9bc0d531d18:

  ACPI/IORT: Introduce iort_iommu_configure (2016-11-29 15:57:48 +0000)

----------------------------------------------------------------
Bhumika Goyal (3):
      iommu/arm-smmu: Constify iommu_gather_ops structures
      iommu/arm-smmu: Constify iommu_gather_ops structures
      iommu/io-pgtable-arm: Use const and __initconst for iommu_gather_ops structures

Kefeng Wang (1):
      iommu/io-pgtable-arm: Use for_each_set_bit to simplify the code

Lorenzo Pieralisi (16):
      ACPI: Add FWNODE_ACPI_STATIC fwnode type
      ACPI/IORT: Introduce linker section for IORT entries probing
      ACPI/IORT: Add support for IOMMU fwnode registration
      iommu: Make of_iommu_set/get_ops() DT agnostic
      iommu/arm-smmu: Convert struct device of_node to fwnode usage
      iommu/arm-smmu-v3: Convert struct device of_node to fwnode usage
      ACPI: Implement acpi_dma_configure
      ACPI/IORT: Add node match function
      ACPI/IORT: Add support for ARM SMMU platform devices creation
      iommu/arm-smmu-v3: Split probe functions into DT/generic portions
      iommu/arm-smmu-v3: Add IORT configuration
      iommu/arm-smmu: Split probe functions into DT/generic portions
      iommu/arm-smmu: Add IORT configuration
      ACPI/IORT: Replace rid map type with type mask
      ACPI/IORT: Add single mapping function
      ACPI/IORT: Introduce iort_iommu_configure

Nipun Gupta (1):
      iommu/arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching of bypass entries

 drivers/acpi/arm64/iort.c          | 585 ++++++++++++++++++++++++++++++++++++-
 drivers/acpi/glue.c                |   4 +-
 drivers/acpi/scan.c                |  45 +++
 drivers/iommu/arm-smmu-v3.c        | 104 +++++--
 drivers/iommu/arm-smmu.c           | 175 ++++++++---
 drivers/iommu/io-pgtable-arm-v7s.c |   5 +-
 drivers/iommu/io-pgtable-arm.c     |   7 +-
 drivers/iommu/iommu.c              |  40 +++
 drivers/iommu/of_iommu.c           |  39 ---
 drivers/pci/probe.c                |   3 +-
 include/acpi/acpi_bus.h            |   2 +
 include/asm-generic/vmlinux.lds.h  |   1 +
 include/linux/acpi.h               |  26 ++
 include/linux/acpi_iort.h          |  14 +
 include/linux/fwnode.h             |   3 +-
 include/linux/iommu.h              |  14 +
 include/linux/of_iommu.h           |  12 +-
 17 files changed, 955 insertions(+), 124 deletions(-)
