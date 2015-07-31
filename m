From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 0/3] arm64: IOMMU-backed DMA mapping
Date: Fri, 31 Jul 2015 18:18:26 +0100
Message-ID: <cover.1438362603.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's an update following Catalin's feedback on v4[1].

Changes this round:
- Rebased onto linux-next
  - IOVA alignment fix applied already
  - iommu_iova_cache_init() is now iova_cache_get()
- Tidied up iommu_dma_alloc()
  - Simplified pgprot handling
  - Removed redundant memset
  - Skip coherent page-flushing in a simpler way
- Spotted a bug in iommu_dma_init_domain() where the checks for
  reinitialising an existing domain were backwards.

If it is going to be down to me to tackle all the driver fixes and
conversion of arch/arm dma_ops, I'd still much rather have this
code merged first as a stable base to work with (and un-block arm64
in the meantime). Have we decided yet whether this should go via the
IOMMU tree or the arm64 tree?

Thanks,
Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/10181

Robin Murphy (3):
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/dma-mapping.h |  15 +-
 arch/arm64/mm/dma-mapping.c          | 449 +++++++++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 534 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |  84 ++++++
 include/linux/iommu.h                |   1 +
 8 files changed, 1084 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
