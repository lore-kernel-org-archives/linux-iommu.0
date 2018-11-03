From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping fix for 4.20
Date: Sat, 3 Nov 2018 09:42:10 +0100
Message-ID: <20181103084210.GA1429@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following changes since commit 8adcc59974b8a65b7eac7d503364837c297139bc:

  Merge branch 'work.misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-11-01 20:19:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-2

for you to fetch changes up to f62717551b2b7d72fc2a3975539117d350bad84d:

  arm64: fix warnings without CONFIG_IOMMU_DMA (2018-11-02 19:27:22 +0100)

----------------------------------------------------------------
Avoid compile warnings on non-default arm64 configs

----------------------------------------------------------------
Christoph Hellwig (1):
      arm64: fix warnings without CONFIG_IOMMU_DMA

 arch/arm64/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)
