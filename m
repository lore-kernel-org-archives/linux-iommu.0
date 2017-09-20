From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] a dma-mapping fix for 4.14-rc2
Date: Wed, 20 Sep 2017 14:25:39 -0700
Message-ID: <20170920212539.y3xbs3uvkkyyoxxc@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

below is a single fix for an issue that crept in with the previous pull
request.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.14-2

for you to fetch changes up to 6d57339890c9a9dfcd4ba4f8931b911b962968e3:

  dma-coherent: fix rmem_dma_device_init regression (2017-09-17 08:20:02 -0700)

----------------------------------------------------------------
A fix for a fix that went in this merge window from Arnd.

----------------------------------------------------------------
Arnd Bergmann (1):
      dma-coherent: fix rmem_dma_device_init regression

 drivers/base/dma-coherent.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)
