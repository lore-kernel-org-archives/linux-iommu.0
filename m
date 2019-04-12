From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping fixes for 5.1
Date: Fri, 12 Apr 2019 17:19:01 +0200
Message-ID: <20190412151901.GA14497@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.1-1

for you to fetch changes up to 8c5165430c0194df92369162d1c7f53f8672baa5:

  dma-debug: only skip one stackframe entry (2019-04-11 19:29:50 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.1

Fix a sparc64 sun4v_pci regression introduced in this merged window,
and a dma-debug stracktrace regression from the big refactor last
merge window.

----------------------------------------------------------------
Christoph Hellwig (1):
      sparc64/pci_sun4v: fix ATU checks for large DMA masks

Scott Wood (1):
      dma-debug: only skip one stackframe entry

 arch/sparc/kernel/pci_sun4v.c | 20 +++++++++++---------
 kernel/dma/debug.c            |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)
