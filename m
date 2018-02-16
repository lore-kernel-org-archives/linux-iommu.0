From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma-mapping fixes for Linux 4.16
Date: Fri, 16 Feb 2018 10:40:03 -0800
Message-ID: <20180216184003.4e2u7a6nwm24fdvp@infradead.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.16-2

for you to fetch changes up to 7bcfab202ca71bece02b283cdd104301c07eece4:

  powerpc/macio: set a proper dma_coherent_mask (2018-02-13 08:58:53 -0800)

----------------------------------------------------------------
A few dma-mapping fixes for the fallout from the changes in rc-1.

----------------------------------------------------------------
Christoph Hellwig (4):
      dma-direct: mark as is_phys
      dma-direct: comment the dma_direct_free calling convention
      dma-mapping: fix a comment typo
      powerpc/macio: set a proper dma_coherent_mask

Corentin Labbe (1):
      ia64: fix build failure with CONFIG_SWIOTLB

 arch/ia64/kernel/Makefile      | 1 -
 drivers/macintosh/macio_asic.c | 1 +
 include/linux/dma-mapping.h    | 2 +-
 lib/dma-direct.c               | 5 +++++
 4 files changed, 7 insertions(+), 2 deletions(-)
