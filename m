From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping fix for 4.20
Date: Wed, 19 Dec 2018 15:24:19 +0100
Message-ID: <20181219142419.GA1112@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit 6531e115b7ab84f563fcd7f0d2d05ccf971aaaf9:

  Merge branch 'akpm' (patches from Andrew) (2018-12-14 15:35:30 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-4

for you to fetch changes up to c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f:

  dma-direct: do not include SME mask in the DMA supported check (2018-12-17 18:02:11 +0100)

----------------------------------------------------------------
dma-mapping fix for 4.21

Fix a regression in dma-direct that didn't take account the magic AMD
memory encryption mask in the DMA address.

----------------------------------------------------------------
Lendacky, Thomas (1):
      dma-direct: do not include SME mask in the DMA supported check

 kernel/dma/direct.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
