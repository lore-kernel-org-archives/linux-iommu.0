From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma-mapping fixes for Linux 4.21-rc1
Date: Sun, 6 Jan 2019 19:28:46 +0100
Message-ID: <20190106182846.GA10665@infradead.org>
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
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

please pull regression fixes, and code removals enabling them for
4.21-rc1.

The following changes since commit 96d4f267e40f9509e8a66e2b39e8b95655617693:

  Remove 'type' argument from access_ok() function (2019-01-03 18:57:57 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.21-1

for you to fetch changes up to 8270f3a11ceef64bdb0ab141180e8d2f17c619ec:

  dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations (2019-01-05 08:28:29 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 4.21-rc1

Fix various regressions introduced in this cycles:

 - fix dma-debug tracking for the map_page / map_single consolidatation
 - properly stub out DMA mapping symbols for !HAS_DMA builds to avoid
   link failures
 - fix AMD Gart direct mappings
 - setup the dma address for no kernel mappings using the remap
   allocator

----------------------------------------------------------------
Christoph Hellwig (7):
      dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs
      dma-mapping: implement dmam_alloc_coherent using dmam_alloc_attrs
      dma-mapping: remove dmam_{declare,release}_coherent_memory
      dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA
      dma-mapping: remove a few unused exports
      x86/amd_gart: fix unmapping of non-GART mappings
      dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations

 Documentation/driver-model/devres.txt |   1 -
 arch/x86/kernel/amd_gart_64.c         |  10 +-
 include/linux/dma-debug.h             |  11 +-
 include/linux/dma-mapping.h           | 340 +++++++++++++++++++---------------
 kernel/dma/coherent.c                 |   2 -
 kernel/dma/debug.c                    |  19 +-
 kernel/dma/mapping.c                  |  94 ----------
 kernel/dma/remap.c                    |  13 +-
 8 files changed, 215 insertions(+), 275 deletions(-)
