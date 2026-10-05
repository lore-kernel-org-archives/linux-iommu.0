Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224313C9C4
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183939; cv=none; b=D1XcGc+Pt6cYGa+gq+yWL4YtsRz7MuqWFa3q2NBgIy/GonDS6UcgF+Sy4BtvQWEOFiKZZ2zEqav0Jc2M2oaspHxlKtLoWihK70i38DOnTl4EWa3ORp8M8JPFsR858bz/YeQDujqHye9SIH2hj89CkQuiUR1nlvxNAJku9DWuJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183939; c=relaxed/simple;
	bh=bOMfemk3uY28fNnYGUGWntGo8SXhMDB3X38cDyx5epo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=gnSDcBSUcnXdRAve1Nvd6KbvTcAWqMvOoLw6ztQ75X1MHG039Bd7zueJNV8BnSLtQpGe/kik7UpfazAqyU5jemOOqSiiKBlqgBLrYaBjsGfSxHFh8CKyPyJKXorpr0j+pnpkN5v5KrF3W+MpItC3jBp49JFcRMiuvsEpgPxP+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IUkx1HND; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IUkx1HND"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261005070529euoutp02e90b6b805a1fd9e5cbb87c5e0c841764~bkEshA9i_2589225892euoutp02P
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 07:05:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261005070529euoutp02e90b6b805a1fd9e5cbb87c5e0c841764~bkEshA9i_2589225892euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791183929;
	bh=LI1PY/lp2Uaq3ccGVqctwJ7GhEhUeqzl4hfjynZeaG8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IUkx1HNDA0Ce0WVEr0ao5DI7gy0CMBPsbPTzPoH85+3oggsJMvxhJOxmMxm36/r28
	 Js3UdcmTu5NNN2QVFUR7zJwIdhN9iflz37cpmw4aOb55MYN4sZJqCGFLJwdqHBP8bV
	 dBD4t3FwZKIO32AV80IxRIAyj0Zx1bC2v7SJR89E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c~bkEsU7ZkM1887318873eucas1p1T;
	Mon,  5 Oct 2026 07:05:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261005070528eusmtip1b88e4c060af8fd0102f58eef95fae4dd~bkErlAe2r2672226722eusmtip1G;
	Mon,  5 Oct 2026 07:05:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Petr Tesarik
	<petr.tesarik.ext@huawei.com>, Andreas Greve <andreas.greve@a-greve.de>,
	James Dingwall <james@dingwall.me.uk>
Subject: [PATCH] swiotlb: fix default_swiotlb_limit() for non-growable
 default pool
Date: Mon,  5 Oct 2026 09:05:17 +0200
Message-ID: <20261005070518.1590097-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c
X-EPHeader: CA
X-CMS-RootMailID: 20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c
References: <CGME20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c@eucas1p1.samsung.com>

Commit ad96ce3252db ("swiotlb: determine potential physical address
limit") changed default_swiotlb_limit() to return the maximum physical
address that could ever be used by dynamically allocated pools, so that
the value stays constant when CONFIG_SWIOTLB_DYNAMIC=y. However,
io_tlb_default_mem.phys_limit is returned even when the default pool
cannot grow, e.g. when swiotlb_init_remap() is called with a remap
callback.

This breaks Xen dom0 on x86: pci_xen_swiotlb_init() passes SWIOTLB_ANY
and xen_swiotlb_fixup(), so phys_limit is set to the top of dom0 memory,
although xen_swiotlb_fixup() makes the default pool below the 32-bit
boundary. xen_swiotlb_dma_supported() then rejects 32-bit DMA masks,
even though the bounce buffer is perfectly usable by such devices.

Return phys_limit only if the default pool can actually grow, otherwise
report the real end of the default pool, like in the
!CONFIG_SWIOTLB_DYNAMIC case.

Reported-by: Andreas Greve <andreas.greve@a-greve.de>
Reported-by: James Dingwall <james@dingwall.me.uk>
Fixes: ad96ce3252db ("swiotlb: determine potential physical address limit")
Closes: https://lore.kernel.org/xen-devel/f74668db-52fd-4575-8372-7bfdf10d62ac@a-greve.de/
Cc: stable@vger.kernel.org
Assisted-by: Claude Opus 5.5 (1M context) <noreply@anthropic.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/swiotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa2f1c4588b9..5edea93ec635 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1844,10 +1844,10 @@ phys_addr_t default_swiotlb_base(void)
 phys_addr_t default_swiotlb_limit(void)
 {
 #ifdef CONFIG_SWIOTLB_DYNAMIC
-	return io_tlb_default_mem.phys_limit;
-#else
-	return io_tlb_default_mem.defpool.end - 1;
+	if (io_tlb_default_mem.can_grow)
+		return io_tlb_default_mem.phys_limit;
 #endif
+	return io_tlb_default_mem.defpool.end - 1;
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.43.0

