From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma mapping fixes for 4.19-rc2
Date: Sun, 2 Sep 2018 19:13:17 +0200
Message-ID: <20180902171317.GA31966@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19-2

for you to fetch changes up to 8c89ef7b6b64ba093239305f77a485905d03f7bf:

  of/platform: initialise AMBA default DMA masks (2018-09-02 10:04:31 +0200)

----------------------------------------------------------------
dma-mapping fixes for 4.19-rc2

A few fixes for the fallout of being a little more pedantic about
dma masks.

----------------------------------------------------------------
Christoph Hellwig (2):
      kernel/dma/direct: take DMA offset into account in dma_direct_supported
      sparc: set a default 32-bit dma mask for OF devices

Linus Walleij (1):
      of/platform: initialise AMBA default DMA masks

 arch/sparc/kernel/of_device_32.c | 4 ++++
 arch/sparc/kernel/of_device_64.c | 3 +++
 drivers/of/platform.c            | 4 ++++
 kernel/dma/direct.c              | 4 ++--
 4 files changed, 13 insertions(+), 2 deletions(-)
