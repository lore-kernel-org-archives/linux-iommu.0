From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping fix for 5.0-rc
Date: Sun, 27 Jan 2019 10:27:21 +0100
Message-ID: <20190127092721.GA22044@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Julien Grall <julien.grall@arm.com>, Stefano Stabellini <sstabellini@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

please pull the fix below, which fixed the xen swiotlb cache flusing
on arm64.

The following changes since commit 333478a7eb21245880c89aad166ad08478cc577d:

  Merge branch 'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux (2019-01-23 16:23:41 +1300)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.0-2

for you to fetch changes up to 60d8cd572f655aac6107a2330dced004ad1fe3d7:

  arm64/xen: fix xen-swiotlb cache flushing (2019-01-23 22:14:56 +0100)

----------------------------------------------------------------
Fix a xen-swiotlb regression on arm64

----------------------------------------------------------------
Christoph Hellwig (1):
      arm64/xen: fix xen-swiotlb cache flushing

 arch/arm/include/asm/xen/page-coherent.h   | 94 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/device.h            |  3 -
 arch/arm64/include/asm/xen/page-coherent.h | 76 +++++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c                |  4 +-
 drivers/xen/swiotlb-xen.c                  |  4 +-
 include/xen/arm/page-coherent.h            | 97 +-----------------------------
 6 files changed, 176 insertions(+), 102 deletions(-)
