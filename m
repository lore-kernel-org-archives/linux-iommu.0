From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma mapping fix for 4.19-rc6
Date: Fri, 28 Sep 2018 17:54:47 -0700
Message-ID: <20180929005447.GA3397@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit bfb0e9b490bc15f243009359745a9d8a94089dc4:

  Merge tag 'usb-4.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2018-09-25 17:54:55 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19-3

for you to fetch changes up to 974c24c5bed75b53e229a6f68a0533b6d5f48feb:

  dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration (2018-09-25 15:11:58 -0700)

----------------------------------------------------------------
fix a missing Kconfig symbol for commits introduced in 4.19-rc

----------------------------------------------------------------
Christoph Hellwig (1):
      dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration

 kernel/dma/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
