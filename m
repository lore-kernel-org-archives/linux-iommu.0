Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25F1CCB4E;
	Tue, 19 Nov 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035990; cv=none; b=XZEDgl43BW8yEjELXTi5IfPbuVe+3tiVb6OLoht9ot4wM/JUTsSsDkgiDaohgFhiLiPqz6jD3vE/WntvsYYlM5ausJJgPkazGmGoMD8XT7gSTfh+iKClTKBl1DyqGh3F5mLQulZHfEC7IAvSio9rvFnU5H1oTrmr+qr41E+yT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035990; c=relaxed/simple;
	bh=kNFKP00vrl29RQkgzndsha0c5Kc84pQElYaDjacxbW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qL5BwJhLEcDk3/vDfZXhDIGwEMxkASxCs11SkfwHn1nT3fcuLk+0/296lr2S/FW2liXpzvSEcCNaNRhJaKbP6HB2s+E7KxDd7RzJHaacIqdv341OeVD0szy3b2Aaf0eH8EfqxVN8yATs+dyGC7q4zGuRe1hHhagaRHzUpa/ymkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4YHL+uh1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4YHL+uh1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=meMfgCL8e3mDNwnv+OdXGEo7YSmW3g/92lGJR0fMyB8=; b=4YHL+uh1FuMhMYmunDIeHQZNSW
	I/2aBX32BYGP1e5fGvGzt9niflWntyjJ7YqfFU0zdg7Af1oQH3DhSVpjj7yncNZXgUJlTRLoI6GPP
	yWWwmfe62gj+/piER5Z9kzYv4bPq1AMOY4i/wPiBaHO6I6CYH3AzNeYafWyVQ4S7bV4B35TtHNjBa
	1RzRdYhsE2TcA7hhi9wWD7zUKtl9KYH4d3SyGY/OsJdTCBunmaJq+ZvhDwAkfPbTRBYnkKDvcRyqe
	W+FpN0T7KmfvF6UF/qA7c5mV9JuAtcZHQ809xA1GlqKdgR+mQJlLsuS4PS1VYIdXvhX5sdzHYCmJt
	p1bLr28w==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDRgK-0000000D9uj-0Bs1;
	Tue, 19 Nov 2024 17:06:28 +0000
Date: Tue, 19 Nov 2024 18:06:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.13
Message-ID: <ZzzFkZHDxrgq2B9i@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit e42b1a9a2557aa94fee47f078633677198386a52:

  Merge tag 'spi-fix-v6.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2024-10-28 11:16:33 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-19

for you to fetch changes up to 22293c33738c14bb84b9d3e771bc37150e7cf8e7:

  dma-mapping: save base/size instead of pointer to shared DMA pool (2024-11-14 10:45:09 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 6.13

 - improve the DMA API tracing code (Sean Anderson)
 - misc cleanups (Christoph Hellwig, Sui Jingfeng)
 - fix pointer abuse when finding the shared DMA pool (Geert Uytterhoeven)
 - fix a deadlock in dma-debug (Levi Yun)

----------------------------------------------------------------
Christoph Hellwig (3):
      dma-debug: store a phys_addr_t in struct dma_debug_entry
      dma-debug: remove DMA_API_DEBUG_SG
      dma-mapping: drop unneeded includes from dma-mapping.h

Geert Uytterhoeven (1):
      dma-mapping: save base/size instead of pointer to shared DMA pool

Levi Yun (1):
      dma-debug: fix a possible deadlock on radix_lock

Sean Anderson (5):
      dma-mapping: use macros to define events in a class
      dma-mapping: trace dma_alloc/free direction
      dma-mapping: use trace_dma_alloc for dma_alloc* instead of using trace_dma_map
      dma-mapping: trace more error paths
      dma-mapping: fix swapped dir/flags arguments to trace_dma_alloc_sgt_err

Sui Jingfeng (1):
      dma-mapping: remove an outdated comment from dma-map-ops.h

 arch/powerpc/platforms/pseries/svm.c |   1 +
 include/linux/dma-map-ops.h          |   2 +-
 include/linux/dma-mapping.h          |   4 -
 include/trace/events/dma.h           | 213 ++++++++++++++++++++++++++++-------
 kernel/dma/Kconfig                   |  17 ---
 kernel/dma/coherent.c                |  14 ++-
 kernel/dma/debug.c                   |  89 ++++++---------
 kernel/dma/mapping.c                 |  37 ++++--
 8 files changed, 242 insertions(+), 135 deletions(-)
