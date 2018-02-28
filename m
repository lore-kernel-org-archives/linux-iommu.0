From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping fixe for Linux 4.16
Date: Wed, 28 Feb 2018 10:12:18 -0800
Message-ID: <20180228181218.66ewjh3kyk2duidw@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit a638af00b27266c09ab7ac69141e6f4ac6c00eff:

  Merge tag 'usb-4.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2018-02-22 12:13:01 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.16-3

for you to fetch changes up to af1da686843750809738c01e153320106e890804:

  dma-debug: fix memory leak in debug_dma_alloc_coherent (2018-02-22 15:02:33 -0800)

----------------------------------------------------------------
A single fix for a memory leak regression in the dma-debug code.

----------------------------------------------------------------
Miles Chen (1):
      dma-debug: fix memory leak in debug_dma_alloc_coherent

 lib/dma-debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
