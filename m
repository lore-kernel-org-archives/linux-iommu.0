Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8882F3B;
	Sat, 30 Nov 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732951934; cv=none; b=CWf9Dqn3v3nUX3yWqxp4dXFTYEVl/nXJLSt98SmGSK9m6IiV2OtrRmVO05fGEpDP4+Ddyr1/CDbwkJlZlqwe1LQl/tCDG9ZP4k9kjFUS/SmAO80pzjf2Z/r51EBs/KrHGxaEhF1fXST9rA+VJcXnzWANnIy5qfqzIuf+0vEmqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732951934; c=relaxed/simple;
	bh=6YMG6y2Kkc+7uY7RG8Hi/vjdkJelv9vecIQ8ViSNtAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i8iug7Vhe+7qFNYae+k52IamNJBFAdfhrE8hr4BqNalA5qJUfGyf7NVLUr/JHvBXZlfrBIakwdFtlDDomPaQtOw1IRgPb6RGJ1FL2jfe3yRdw6x6/ZsymqnAdP5jfvjp10F69Oe9Dqirogb46pfrdIxm1kLmJspACC6fZCw35q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SUBqivC9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SUBqivC9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8MZ4ngk1qOxllnRLjNQ8Wt4T5xxHz6hB4mpn7yWaUD0=; b=SUBqivC9PNUSXZDDSypJIqGfF4
	Ndt3xd8KUvZArhKrPSGNmcIK6LxI3BBlhsegjVkMdgAcZeQxyC9le9mj/5d8wkDQpxR8vwy58he4r
	TtUHhR97PohjCbad1YdnMSbyTUOeoYqA1h/DgHs/CpNPhgk3STv30Cqu1Abzr1YLbmTJk7PZ23p0g
	6V0HfQS6j1ionaQzpq2FX70eqAdpw511WjVmo5fDXulR5Vk43WmELFy7/gNF2GLUhAWMRV3gIMVx8
	S3W3k7/MzEs/fxYWGfywE+b9ZBk/SxGPJR37AoH8LzrBXD1SU321xESr49RQnRnFfU5g/+SWDuqv+
	qslTvUNQ==;
Received: from 2a02-8389-2341-5b80-0664-dc97-c221-7f73.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:664:dc97:c221:7f73] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tHHxY-00000001a29-2ml8;
	Sat, 30 Nov 2024 07:32:09 +0000
Date: Sat, 30 Nov 2024 08:32:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.13
Message-ID: <Z0q_dVrMZGDv9cvY@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 22293c33738c14bb84b9d3e771bc37150e7cf8e7:

  dma-mapping: save base/size instead of pointer to shared DMA pool (2024-11-14 10:45:09 +0100)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-30

for you to fetch changes up to aef7ee7649e02f7fc0d2e5e532f352496976dcb1:

  dma-debug: fix physical address calculation for struct dma_debug_entry (2024-11-28 10:19:16 +0100)

----------------------------------------------------------------
dma-mapping fix for Linux 6.13

 - fix physical address calculation for struct dma_debug_entry
   (Fedor Pchelkin)

----------------------------------------------------------------
Fedor Pchelkin (1):
      dma-debug: fix physical address calculation for struct dma_debug_entry

 kernel/dma/debug.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)
