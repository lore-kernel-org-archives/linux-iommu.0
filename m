Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DB53373;
	Tue, 24 Sep 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159160; cv=none; b=IBS7iCo+moGv2c66PDbgL8+3lkb+ndhfOyZfViDW4Gx7jK67/Ur7pM++d37+fqbjPVRaBSuNcnfhR2BFwhtFwDTimfzgRTQos8Kqh+kzcgUBGMt1YEGhcuCcwyRYHGelerrFUygtVZpPzAygCamy35XOquGe0TYq9Zf8xbTaFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159160; c=relaxed/simple;
	bh=+czLGlaqsYQEgDA6uOX2TIM07wUp7DCqpQ1RSdiFd4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SzUQQ8Ykv38b8ysjF83uv1+uTeDtEbk9y9GC7NpEgQN2KqZIoXvzWJGhkWtGLtjYTvy889IQi1ws+3Ld6Li+l6YZnQheVCpG+mzy3NMX4J6R7fUPL1+afnuVYU2YxT0p4VIsDPuPhY6xI243JEWmCigtmTaISC1MFIo4x6kVN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hbxdEGw6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbxdEGw6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=dgZD0WccF5QojPYETT7JzmM0yE7LqTl10iAGH+T0z/Q=; b=hbxdEGw6iQAYn+6ClyXqzNJMpj
	yP1QpWkFNOI0DongiBIeCM7H6NjM2//l2rcHinS8tK1jexIBlCUWSbgzkKGTQrmmg1lgRYIKxSXHf
	j3/BGmc5hr/Np9rWeYWxqt+DjqvcNiTmSHH2QK3baskYR3w5PlS0P87/3LmZ6cuxgl5nDWt/H0OY4
	IJ23Ih1VbZsbOI4LYqtOFUd27/sac/CpDRjOy6k1BBB1TAe9jTWHmnq1feOAUeABa1JokHZKcG+lT
	nuIPBOScbijTxgQ5XuG5vs0S0Es9a7hs/7dHjwaoMz2rANpK6/brvP4LNkGeZpe9Ld0fxo7CJzAv0
	YVCOxq3A==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssyzl-00000001FGr-00Vd;
	Tue, 24 Sep 2024 06:25:57 +0000
Date: Tue, 24 Sep 2024 08:25:53 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.12
Message-ID: <ZvJbcRLlblu7s2kd@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 88264981f2082248e892a706b2c5004650faac54:

  Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext (2024-09-21 09:44:57 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-24

for you to fetch changes up to b348b6d17fd1d5d89b86db602f02bea54a754bd8:

  dma-mapping: report unlimited DMA addressing in IOMMU DMA path (2024-09-23 08:38:56 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.12

 - sort out a few issues with the direct calls to iommu-dma
   (Christoph Hellwig, Leon Romanovsky)

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-mapping: fix vmap and mmap of noncontiougs allocations
      iommu/dma: remove most stubs in iommu-dma.h

Leon Romanovsky (1):
      dma-mapping: report unlimited DMA addressing in IOMMU DMA path

 drivers/iommu/dma-iommu.c   |  33 +++++++++++++
 include/linux/dma-map-ops.h |  19 --------
 include/linux/iommu-dma.h   | 114 ++++++--------------------------------------
 kernel/dma/mapping.c        |  43 ++++++-----------
 4 files changed, 62 insertions(+), 147 deletions(-)
