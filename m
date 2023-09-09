Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986ED30F83
	for <iommu@lists.linux.dev>; Sat,  9 Sep 2023 08:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=A5OyE9ck9pXtZ7PRW6mzEU0ltGOZcopG2sL7ZBFQZOI=; b=iq2JnxDzQDUhRItXCkTWnUPFdP
	7PUDPUn0fIgIXjsLvevqIf5BgRIr4K4SMBUzAdq6aUdbMqOuAB5u9tvRpA+a4Lux6ZPIE9t4QHI+t
	e5bX313rFWdWFSletGQFgRcx4wBJCD4xatTWQW9npNnjPjIP4FXZnOA6YZSXa/iqeAFFZu8D0zuKD
	6qHxLkyw380P7ZdCoB4fhGaHD381PYpfEvPLac7el8ZKZ125bXLBrBibGNz9TeJn9irwUItM2+mq7
	G3/450Cqe18VfU1A9dsowYYepGA1bOprnCrkSyXywhwZeWqvgw5oilueeeK0wIyVfyHqAyPLqPM/5
	WztK0lxw==;
Received: from [190.171.152.147] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qetcK-00FDPm-2H;
	Sat, 09 Sep 2023 08:47:01 +0000
Date: Sat, 9 Sep 2023 05:46:57 -0300
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.6
Message-ID: <ZPwxAWSXvmJNgj0X@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit d069ed288ac74c24e2b1c294aa9445c80ed6c518:

  swiotlb: optimize get_max_slots() (2023-08-08 10:29:21 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-09

for you to fetch changes up to f875db4f20f4ec2e4fa3b3be0e5081976e0b5dad:

  Revert "dma-contiguous: check for memory region overlap" (2023-09-08 05:58:32 -0300)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.6

 - move a dma-debug call that prints a message out from a lock that's
   causing problems with the lock order in serial drivers (Sergey Senozhatsky)
 - fix the CONFIG_DMA_NUMA_CMA Kconfig entry to have the right dependency
   on not default to y (Christoph Hellwig)
 - move an ifdef a bit to remove a __maybe_unused that seems to trip up
   some sensitivities (Christoph Hellwig)
 - revert a bogus check in the CMA allocator (Zhenhua Huang)

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-contiguous: fix the Kconfig entry for CONFIG_DMA_NUMA_CMA
      dma-pool: remove a __maybe_unused label in atomic_pool_expand

Sergey Senozhatsky (1):
      dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock

Zhenhua Huang (1):
      Revert "dma-contiguous: check for memory region overlap"

 kernel/dma/Kconfig      |  2 +-
 kernel/dma/contiguous.c |  5 -----
 kernel/dma/debug.c      | 20 +++++++++++++++-----
 kernel/dma/pool.c       |  4 ++--
 4 files changed, 18 insertions(+), 13 deletions(-)
