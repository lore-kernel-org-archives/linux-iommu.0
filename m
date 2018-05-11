From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/3] arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache
	line size)
Date: Fri, 11 May 2018 14:55:44 +0100
Message-ID: <20180511135547.34521-1-catalin.marinas@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Yang Li <pku.leo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

The previous version of this patch [1] didn't make it into 4.17 because
of the (compile-time) conflicts with the generic dma-direct.h changes.
I'm reposting it for 4.18 with some minor changes:

- phys_to_dma()/dma_to_phys() now gained underscores to match the
  generic dma-direct.h implementation

- the patch is split in three to make the changes clearer to the
  reviewers

If at some point in the future the generic swiotlb code gain
non-choerent DMA awareness, the last patch in the series could be
refactored. In the meantime, the simplest, non-intrusive approach is to
select ARCH_HAS_PHYS_TO_DMA on arm64 and force bounce buffering through
an arch-specific dma_capable() implementation.

Thanks,

Catalin

[1] http://lkml.kernel.org/r/20180228184720.25467-1-catalin.marinas-5wv7dgnIgG8@public.gmane.org

Catalin Marinas (3):
  Revert "arm64: Increase the max granular size"
  arm64: Increase ARCH_DMA_MINALIGN to 128
  arm64: Force swiotlb bounce buffering for non-coherent DMA with large
    CWG

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cache.h      |  6 +++---
 arch/arm64/include/asm/dma-direct.h | 43 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |  9 ++------
 arch/arm64/mm/dma-mapping.c         | 17 +++++++++++++++
 arch/arm64/mm/init.c                |  3 ++-
 6 files changed, 68 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-direct.h
