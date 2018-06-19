From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma-mapping file renames for Linux 4.18
Date: Tue, 19 Jun 2018 06:43:58 +0200
Message-ID: <20180619044358.snyej666melspv46@infradead.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

below is a rename of the assorted dma-mapping files to that they live
under kernel/dma and lose their dma-* prefixes.  If there is any time
to do this it is right after -rc1, so let me know if this is something
you'd take.


The following changes since commit be779f03d563981c65cc7417cc5e0dbbc5b89d30:

  Merge tag 'kbuild-v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2018-06-13 08:40:34 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git for-linus

for you to fetch changes up to cf65a0f6f6ff7631ba0ac0513a14ca5b65320d80:

  dma-mapping: move all DMA mapping code to kernel/dma (2018-06-14 08:50:37 +0200)

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-mapping: use obj-y instead of lib-y for generic dma ops
      dma-mapping: move all DMA mapping code to kernel/dma

 Documentation/driver-api/infrastructure.rst        |  4 +-
 MAINTAINERS                                        |  9 +---
 drivers/base/Makefile                              |  3 --
 include/linux/dma-contiguous.h                     |  2 +-
 init/Kconfig                                       |  4 --
 kernel/Makefile                                    |  1 +
 kernel/dma/Kconfig                                 | 50 ++++++++++++++++++++++
 kernel/dma/Makefile                                | 11 +++++
 .../base/dma-coherent.c => kernel/dma/coherent.c   |  0
 .../dma-contiguous.c => kernel/dma/contiguous.c    |  0
 lib/dma-debug.c => kernel/dma/debug.c              |  0
 lib/dma-direct.c => kernel/dma/direct.c            |  0
 drivers/base/dma-mapping.c => kernel/dma/mapping.c |  2 +-
 lib/dma-noncoherent.c => kernel/dma/noncoherent.c  |  0
 {lib => kernel/dma}/swiotlb.c                      |  0
 lib/dma-virt.c => kernel/dma/virt.c                |  2 -
 lib/Kconfig                                        | 47 +-------------------
 lib/Makefile                                       |  6 ---
 18 files changed, 69 insertions(+), 72 deletions(-)
 create mode 100644 kernel/dma/Kconfig
 create mode 100644 kernel/dma/Makefile
 rename drivers/base/dma-coherent.c => kernel/dma/coherent.c (100%)
 rename drivers/base/dma-contiguous.c => kernel/dma/contiguous.c (100%)
 rename lib/dma-debug.c => kernel/dma/debug.c (100%)
 rename lib/dma-direct.c => kernel/dma/direct.c (100%)
 rename drivers/base/dma-mapping.c => kernel/dma/mapping.c (99%)
 rename lib/dma-noncoherent.c => kernel/dma/noncoherent.c (100%)
 rename {lib => kernel/dma}/swiotlb.c (100%)
 rename lib/dma-virt.c => kernel/dma/virt.c (98%)
