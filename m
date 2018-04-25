From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma mapping fixes for 4.17-rc3
Date: Wed, 25 Apr 2018 07:22:25 +0200
Message-ID: <20180425052225.GA2350@infradead.org>
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

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-3

for you to fetch changes up to 60695be2bb6b0623f8e53bd9949d582a83c6d44a:

  dma-mapping: postpone cpu addr translation on mmap (2018-04-23 14:44:24 +0200)

----------------------------------------------------------------
A few small dma-mapping fixes for Linux 4.17-rc3:

 - don't loop to try GFP_DMA allocations if ZONE_DMA is not actually
   enabled (regression in 4.16)
 - don't try to do virt_to_page before we know we actuall have a
   valid page in dma_common_mmap
 - a comment fixup related to the above fix

----------------------------------------------------------------
Jacopo Mondi (1):
      dma-mapping: postpone cpu addr translation on mmap

Robin Murphy (1):
      dma-coherent: clarify dma_mmap_from_dev_coherent documentation

Takashi Iwai (1):
      dma-direct: don't retry allocation for no-op GFP_DMA

 drivers/base/dma-coherent.c | 5 +++--
 drivers/base/dma-mapping.c  | 6 ++----
 lib/dma-direct.c            | 3 ++-
 3 files changed, 7 insertions(+), 7 deletions(-)
