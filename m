Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E129CE6;
	Fri, 19 Jul 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721366679; cv=none; b=KjuUDRmLpXnjOflOH89Qafo5o/nl9dwA8L3gnQwDZLONvd/2wbje0qspRVJA/9keo+pppykFdNFLzlIjR57qH+g+DU9YMZNXoFF3e3AMdHtbDTXLog2OEBl6Lr8NVpU5K4ww0K8Mx8Fj0WXOG3BqE2LJi2YHFGK2aG9v09pl30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721366679; c=relaxed/simple;
	bh=lTdLQBQakKrY8+X23Yv3VA6oiUJ7yz6FI1dSo+lImWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DenO7XhZObXOfj2e8KQRIN9I8Jjub1FXCVySdn3gHvDqn93hNjUObEWvz2dtzfRNC3d83Bnha6WEMmSxv7DUDGa5W5HoOxRvUHIHQew8LsfGiGvFEr6r/RXZX/c3+YAkEXVY60IPlql66a4cOn9Q401hvZAueWi+NNar0zF7ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ynnR9A6+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ynnR9A6+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bGXWiZa6SAWVTT9HaynJ4PvadCWnBTJWJunRLZKF+9Y=; b=ynnR9A6+bofsFfbdPnXrXppruh
	2zhd4c0eEA6SPOP1ssRfy+oAEK0qZlXGyAfM/BcaqEliqXTCD820K7/ngxrVUfynM84zCuwsf6i9v
	FYP9WBwTUwptK5PcHRBFYSr5Dzz6A9ZU8sMcka4f1pOywi0UBAYX8j8iUMTYVLb5hR8nnQHOhc4vG
	esGFs27Xtoq8RPYEWEJmEcZaYptPgs+huwjZHkskMcpHqEzO4FrH0/7a+uMVFcrGUuG3m5RUv1aoM
	2L+eDh9VhjyJzXopBP43prAeu+rNLtsQzMJNxHkj7ro8MKP4JB4Koccuwf6vHuZECJNVvyj9E0eqJ
	ir7FfYgQ==;
Received: from [2001:4bb8:2c0:de35:58bc:2c5c:f3fd:8e63] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUg6U-00000001dTZ-3kjH;
	Fri, 19 Jul 2024 05:24:27 +0000
Date: Fri, 19 Jul 2024 07:24:22 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.11
Message-ID: <Zpn4hhOk6GAgXjLf@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-07-19

for you to fetch changes up to b69bdba5a37eb6224039e9572e0e98fc3a931fee:

  swiotlb: fix kernel-doc description for swiotlb_del_transient (2024-07-13 07:36:10 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.11

 - reduce duplicate swiotlb pool lookups (Michael Kelley)
 - minor small fixes (Yicong Yang, Yang Li)

----------------------------------------------------------------
Michael Kelley (1):
      swiotlb: reduce swiotlb pool lookups

Yang Li (1):
      swiotlb: fix kernel-doc description for swiotlb_del_transient

Yicong Yang (1):
      dma-mapping: benchmark: Don't starve others when doing the test

 drivers/iommu/dma-iommu.c   |  11 ++---
 drivers/xen/swiotlb-xen.c   |  31 ++++++++-----
 include/linux/scatterlist.h |   2 +-
 include/linux/swiotlb.h     | 105 ++++++++++++++++++++++++++------------------
 kernel/dma/direct.c         |  10 ++---
 kernel/dma/direct.h         |   9 ++--
 kernel/dma/map_benchmark.c  |  16 +++++++
 kernel/dma/swiotlb.c        |  68 +++++++++++++++-------------
 8 files changed, 146 insertions(+), 106 deletions(-)
