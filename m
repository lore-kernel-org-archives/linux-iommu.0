Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B0257B
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014074; cv=none; b=t+EZo3GK93Qm3YEJJOswcP40w5VIA9nOJ5hYnLWuLVT1BBOjkyoVPf0SuXY0tCgeR36WcVQDLUbZfELyTarvLRNrhM50kVyuZB9Mt6aqCLD48Et3pHMYVQNd70rUIPSCbxO31xb+XMPZGPW//GGoC7jfjc6UQKlbjroDV2nTXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014074; c=relaxed/simple;
	bh=esC5dlr9hQCztJI48DmwwI4rn4aGp0UyH5qd00wWzjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcpFBMcTnLbCN7wGm2LZn4bpHNjdDuct9FL4uDdAE2o2vf1QAKfqH68P1ssbxm5uG4qvcfMj7i8g1zQnrTMXELNfe4eoB9TxySaWfH17uegd2S5JkCXJR9rQ/IkaPJsYHIubRvsljUUiCNO2Yh54OfdN9uf/oX/mzQyO1roDlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bl4qA0Ta; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bl4qA0Ta"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zrOkskwhUtyVuCfX87KKhtiIXIHolO4tv5bWIAEJrTw=; b=Bl4qA0TanREu9rGrahXS2GfhAL
	BvlV9MDr+CgHUzkQcEGORfOLMMAHyusyiHqYgBSaYEzdVm/sKTLBq0VmvreB6PzH0XCiYIyrPdaDu
	PJP8uWZXyzLxk5cqCBcfcKElAwxyZ3kV+DJyoa28imBeziK+oI1GLz0RO9DqcYvQt+N3LwL0sH2gE
	Pg5+dDCUBM5B0/xKag5kVQ8W225ry9YKI1bTfgH1tQGFUpr/YqBu9V+05hGF+jdjC5K627db06mNJ
	UvG3NGuwGVRm1Qn0jBJqIT67GeLJICY8GTJxJc+HnW43yzrb5Mz7b+JamEMw0ohiX0zfpsvW1DdFW
	zeHhhakg==;
Received: from 2a02-8389-2341-5b80-4a66-5554-3273-f061.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4a66:5554:3273:f061] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssNFc-0000000FErP-1WP9;
	Sun, 22 Sep 2024 14:07:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Leon Romanovsky <leon@kernel.org>
Subject: iommu-dma direct call fixups
Date: Sun, 22 Sep 2024 16:07:33 +0200
Message-ID: <20240922140743.1596763-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this fixes a reported regression with the direct dma-iommu calls when
using the dma_alloc_noncontigous API, and also removes the not actually
needed stubs in iommu-dma.h that I noticed while looking at the header
again.

Diffstat:
 drivers/iommu/dma-iommu.c   |   33 ++++++++++++
 include/linux/dma-map-ops.h |   19 -------
 include/linux/iommu-dma.h   |  114 +++++---------------------------------------
 kernel/dma/mapping.c        |   37 +++-----------
 4 files changed, 57 insertions(+), 146 deletions(-)
