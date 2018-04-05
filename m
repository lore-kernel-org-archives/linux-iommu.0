From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [GIT PULL] dma-mapping updates for 4.17
Date: Thu, 5 Apr 2018 11:19:32 +0200
Message-ID: <20180405091932.GA30280@infradead.org>
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

Very light this round as the interesting dma mapping changes went
through the x86 tree:

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17

for you to fetch changes up to 1f674e16f9ce6eb20ee2e81ae7514737376874de:

  usb: gadget: Add NO_DMA dummies for DMA mapping API (2018-03-16 19:58:28 +0100)

----------------------------------------------------------------
dma-mapping updates for 4.17:
 - provide proper stubs for architectures not supporting dma (Geert)

----------------------------------------------------------------
Geert Uytterhoeven (5):
      dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
      dma-coherent: Add NO_DMA dummies for managed DMA API
      mm: Add NO_DMA dummies for DMA pool API
      scsi: Add NO_DMA dummies for SCSI DMA mapping API
      usb: gadget: Add NO_DMA dummies for DMA mapping API

 include/linux/dma-mapping.h | 19 ++++++++++++++-----
 include/linux/dmapool.h     | 30 +++++++++++++++++++++++-------
 include/linux/usb/gadget.h  | 12 ++++++++++++
 include/scsi/scsi_cmnd.h    |  5 +++++
 4 files changed, 54 insertions(+), 12 deletions(-)
