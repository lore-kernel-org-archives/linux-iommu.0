Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0AF19A
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=CdYTc5Ia0YbUKO+gsp8K0URr+sV5NDaKfSd1KCWBZRA=; b=Ip5W8PoiMER8SAxPaU9Z9UfNum
	kOZVLPWWxi5GfpciMTvPVrAVNhbHtBCNtuZ4z/QM0Hp5Vug57uLp6K7ybBzFukEVRsrEW1qgXsRWQ
	UxA35v2Zfnq2/KSZevJjOOl5O3KlPiarkFdI/74R/UGLK57uFauOJNyzaD01EKul79ynD1sTv8kMB
	GdWQRR75ULHUIaSIW5Es1xA0pD4XTi7BwZCAjcj5wwgtLLdUvbPsllCTdzVoRmL4WMKieOm/b7hSx
	g6r4cwOHcm8nQBQ4ab3SZ393tP3++/8AqzCJkuzk40j+pVERvZxar7kK1qwAVqQe+SKfxLdo7xKCx
	f/s+n39A==;
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8jGo-008zxU-Io; Fri, 23 Dec 2022 14:43:35 +0000
Date: Fri, 23 Dec 2022 15:43:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.2
Message-ID: <Y6W+k0hUkeRaXCTO@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 6feb57c2fd7c787aecf2846a535248899e7b70fa:

  Merge tag 'kbuild-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2022-12-19 12:33:32 -0600)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-2022-12-23

for you to fetch changes up to 3622b86f49f84e52fb41fee9eb55f9290613dfc3:

  dma-mapping: reject GFP_COMP for noncoherent allocations (2022-12-21 08:45:38 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.2

Fix up the sound code to not pass __GFP_COMP to the non-coherent DMA
allocator, as it copes with that just as badly as the coherent allocator,
and then add a check to make sure no one passes the flag ever again.

----------------------------------------------------------------
Christoph Hellwig (2):
      ALSA: memalloc: don't use GFP_COMP for non-coherent dma allocations
      dma-mapping: reject GFP_COMP for noncoherent allocations

 kernel/dma/mapping.c  | 4 ++++
 sound/core/memalloc.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)
