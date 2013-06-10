From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/9] Add support for ARM SMMU architectures 1 and 2
Date: Mon, 10 Jun 2013 19:34:36 +0100
Message-ID: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This patch series adds support for ARM's SMMU architectures 1 and 2 to
Linux. It has been tested with models of MMU-400 (AArch32) and MMU-500
(AArch32 and AArch64) coupled with four PL330s doing memory-to-memory
DMA.

The first six patches are preparatory and fix problems that I
encountered whilst trying to use both the ARM IOMMU API and the PL330
driver. The remaining patches add the device-tree binding, previously
discussed at:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/160663.html
  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162945.html

as well as the driver implementation and an update to the MAINTAINERS
file.

The driver is written only with single-stage (possibly stage 2), LPAE,
non-secure translation in mind. Nested translation may of course be added
later via KVM, but that will require some changes to the core IOMMU API
in Linux. Both arm and arm64 are supported, as well as chained SMMUs,
although we only install our translation in the SMMU furthest from the
device. We're also currently limited in our IPA size, due to input size
restrictions at stage 2. This can be resolved later by munging about in
the page table allocation code, where we currently re-use parts of the
CPU page table helpers.

Read and write protection is supported as far as the pte formats allow
(i.e. no write-only at stage-1) and memory attributes are either normal,
non-cacheable (default) or normal, cacheable, write-back, write-allocate.
TLB broadcasting is not used for either ASIDs (since we don't support
user tables for DMA in Linux) or VMIDs (which are instead used to tag
address spaces in order to limit the scope of TLB invalidation
operations).

Both 4k and 64k (AArch64 only) pages are supported, with the contiguous
hint bit being used in the pte entries for mappings that allow it.

Support for stream-indexing and non-coherent table walking is provided,
but untested.

All comments welcome,

Will


Will Deacon (9):
  dma: pl330: rip out broken, redundant ID probing
  dma: pl330: use dma_addr_t for describing bus addresses
  ARM: dma-mapping: convert DMA direction into IOMMU protection
    attributes
  ARM: dma-mapping: NULLify dev->archdata.mapping pointer on detach
  arm64: pgtable: use pte_index instead of __pte_index
  arm64: device: add iommu pointer to device archdata
  documentation: iommu: add description of ARM System MMU binding
  iommu: add support for ARM Ltd. System MMU architecture
  MAINTAINERS: add entry for ARM system MMU driver

 .../devicetree/bindings/iommu/arm,smmu.txt         |   70 +
 MAINTAINERS                                        |    6 +
 arch/arm/mm/dma-mapping.c                          |   20 +-
 arch/arm64/include/asm/device.h                    |    3 +
 arch/arm64/include/asm/pgtable.h                   |    4 +-
 drivers/dma/pl330.c                                |   29 +-
 drivers/iommu/Kconfig                              |   13 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/arm-smmu.c                           | 1965 ++++++++++++++++++++
 9 files changed, 2081 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
 create mode 100644 drivers/iommu/arm-smmu.c

-- 
1.8.2.2
