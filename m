From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 00/13] iommu/arm-smmu: Updates for 4.3
Date: Mon,  3 Aug 2015 14:25:42 +0100
Message-ID: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This is the ARM SMMU driver queue I currently have for 4.3. The diffstat
is slightly noisy since Robin cleaned up the DMA API usage in the
io-pgtable code so the client drivers no longer need to perform
dma_map_page hacks in order to clean the CPU caches on non-coherent
systems.

Other changes include some MSI prep., a couple of minor fixes for
SMMUv3 and honouring of the dma-coherent property for SMMUv1/2.

In the absence of any issues, I plan to send a pull request to Joerg
later this week.

Cheers,

Will

--->8

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
 drivers/iommu/arm-smmu-v3.c                        |  65 +++++------
 drivers/iommu/arm-smmu.c                           |  45 +++-----
 drivers/iommu/io-pgtable-arm.c                     | 126 +++++++++++++++------
 drivers/iommu/io-pgtable.h                         |   9 +-
 drivers/iommu/ipmmu-vmsa.c                         |  19 +---
 7 files changed, 156 insertions(+), 117 deletions(-)

-- 
2.1.4
