Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092A3EB80E
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288185; cv=none; b=eFHM8fUoopWa8rbxTveFWZe51MlsC+UU5Bh6bL36oQUXbociH9K5gUk6xo5yJcj4CtWXrV5wdXkPStt7YISrTq4+GoLM4U/B7d8WKNeHkP4A7UuB6onTGIsgRLCSMEDnL6RJRid33BVv+1cJdT/WS6wWCoLNpuMEwqTu9PH743w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288185; c=relaxed/simple;
	bh=+pcb7LuXkbo3aBtQmSBVWs1SQGD2dEcdUgC3VViAPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rt6gb0I8khl0KAtiR7YX+8s81Plzg2Vms6TeqXX6sRpCqt2JR6QC2bMs2xkbSka/hAS00m5iYQjdqDWrklnrYXn6wVKU3nJDldC+ECy1KGuUwd9yobFDHv4zjUhCEoCBlz6sjyokqtR43B+2Nv2/Hu/YOt8l8p05Q34HyaIX6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vSpjbdxd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vSpjbdxd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=eZVBFBhd4oOB+QKs5AJD8QAzmM6latD3F6TpFObjOwY=; b=vSpjbdxd4sV1QSSRYBCrLHV3xS
	zPxaw+8mx8cKwLgpT4yb38AINyNmRvxAFQJVS83pch3s4teNZ8cvLS36ngVSVNSlr5+cNlhQc21T4
	oL10Bi18WtlZzuJNaup90zVVBk07wJnepwN8nityhhfbkz/CDzy+AwWHI5mM39CbftgbjWnjm8SrH
	pFgJ4YS/7Cy1byV0Oz9ifTTc9Tv8sBqKeF/9xqVsMWHP5JqvmGlGwfo5dHSQ/40136sDunlWNfJ72
	RjNU4UpTYAGQXsx+mIZmwNw04X6cfaYVMeXk1/nEGPoHZfWj8cu0sv3NH96dqD8lddaHQZ+czKpb2
	hVqtBfbg==;
Received: from [212.185.66.20] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE3sh-00000000hLP-0d1r;
	Tue, 06 Oct 2026 12:02:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	iommu@lists.linux.dev
Subject: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA optimized limitation"
Date: Tue,  6 Oct 2026 14:02:48 +0200
Message-ID: <20261006120248.147654-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This turns down to cause up to 15% performance regressions on standard
large transfer workloads.  Revert it and hope the IOVA allocator can
eventually be fixed to remove the need for the original workaround.

This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5440cf18b55b..82e308fe4f4c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3747,7 +3747,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 */
 	dev->ctrl.max_hw_sectors = min_t(u32,
 			NVME_MAX_BYTES >> SECTOR_SHIFT,
-			dma_opt_mapping_size(&pdev->dev) >> 9);
+			dma_max_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
-- 
2.53.0

