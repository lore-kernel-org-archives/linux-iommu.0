From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma-mapping updates for Linux 4.15
Date: Tue, 14 Nov 2017 21:59:40 +0200
Message-ID: <20171114195940.mqin47tr3t7zkopq@infradead.org>
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

please pull these dma-mapping updates:


The following changes since commit 33d930e59a98fa10a0db9f56c7fa2f21a4aef9b9:

  Linux 4.14-rc5 (2017-10-15 21:01:12 -0400)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.15

for you to fetch changes up to c9eb6172c328dde7e14812f94f8da87b691e41b5:

  dma-mapping: turn dma_cache_sync into a dma_map_ops method (2017-10-19 16:37:49 +0200)

----------------------------------------------------------------
A couple of dma-mapping updates:

 - turn dma_cache_sync into a dma_map_ops instance and remove
   implementation that purely are dead because the architecture
   doesn't support noncoherent allocations
 - add a flag for busses that need DMA configuration (Robin Murphy)

----------------------------------------------------------------
Christoph Hellwig (11):
      floppy: consolidate the dummy fd_cacheflush definition
      x86: make dma_cache_sync a no-op
      frv: make dma_cache_sync a no-op
      ia64: make dma_cache_sync a no-op
      microblaze: make dma_cache_sync a no-op
      mn10300: make dma_cache_sync a no-op
      powerpc: make dma_cache_sync a no-op
      unicore32: make dma_cache_sync a no-op
      xtensa: make dma_cache_sync a no-op
      sh: make dma_cache_sync a no-op
      dma-mapping: turn dma_cache_sync into a dma_map_ops method

Robin Murphy (1):
      drivers: flag buses which demand DMA configuration

 arch/alpha/include/asm/dma-mapping.h      |  2 --
 arch/alpha/include/asm/floppy.h           |  2 --
 arch/cris/include/asm/dma-mapping.h       |  6 -----
 arch/frv/include/asm/dma-mapping.h        |  7 ------
 arch/hexagon/include/asm/dma-mapping.h    |  3 ---
 arch/ia64/include/asm/dma-mapping.h       | 11 ---------
 arch/m32r/include/asm/dma-mapping.h       |  5 ----
 arch/m68k/include/asm/dma-mapping.h       |  6 -----
 arch/metag/include/asm/dma-mapping.h      | 10 --------
 arch/microblaze/include/asm/dma-mapping.h | 39 -------------------------------
 arch/microblaze/kernel/dma.c              | 17 ++++++++++++++
 arch/mips/include/asm/dma-mapping.h       |  3 ---
 arch/mips/mm/dma-default.c                |  7 +++---
 arch/mn10300/include/asm/dma-mapping.h    | 10 --------
 arch/nios2/include/asm/dma-mapping.h      |  9 -------
 arch/parisc/include/asm/dma-mapping.h     |  8 -------
 arch/parisc/kernel/pci-dma.c              |  8 +++++++
 arch/powerpc/include/asm/dma-mapping.h    |  7 ------
 arch/powerpc/include/asm/floppy.h         |  2 --
 arch/s390/include/asm/dma-mapping.h       |  5 ----
 arch/sh/include/asm/dma-mapping.h         |  7 +++---
 arch/sh/kernel/dma-nommu.c                | 17 +++++++-------
 arch/sh/mm/consistent.c                   |  6 ++---
 arch/sparc/include/asm/dma-mapping.h      |  8 -------
 arch/sparc/include/asm/floppy_32.h        |  1 -
 arch/sparc/include/asm/floppy_64.h        |  1 -
 arch/tile/include/asm/dma-mapping.h       |  9 -------
 arch/unicore32/include/asm/cacheflush.h   |  9 -------
 arch/unicore32/include/asm/dma-mapping.h  | 22 -----------------
 arch/unicore32/mm/proc-syms.c             |  3 ---
 arch/x86/include/asm/dma-mapping.h        |  7 ------
 arch/xtensa/include/asm/dma-mapping.h     |  3 ---
 arch/xtensa/kernel/pci-dma.c              | 23 ------------------
 drivers/amba/bus.c                        |  1 +
 drivers/base/platform.c                   |  1 +
 drivers/block/floppy.c                    |  4 ++++
 drivers/gpu/host1x/bus.c                  |  1 +
 drivers/of/device.c                       |  8 +------
 drivers/pci/pci-driver.c                  |  1 +
 drivers/sh/maple/maple.c                  |  5 ++--
 include/linux/device.h                    |  4 ++++
 include/linux/dma-mapping.h               | 13 +++++++++++
 42 files changed, 71 insertions(+), 250 deletions(-)
