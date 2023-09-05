Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC14379
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 06:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VKfcUZ86TZT2GiIlvErDGETaTcWKGuD89U1H9/xTNPo=; b=Hm174494/tFRub37zV8kfA8z0P
	Pmrt4PpdrXp+zjJrDgzE/P3IrcAcgBHWvjLtwVf00ZO8/9gj5/2b/TF8p86QJtEbe9PKEL+uKR+k4
	oWFzZsLN9j9o5kOxDK1xcwB9YcQYeeH7b1fByVicejQPW3WxxJmyupwRaC+iApShi2Gg9yxjUEOCw
	CkwFNzzBtTCCozEgS7EB1r+qYJKy9NSG8GeLYTIw3xnhwyv+cEqSPB1oR6QBq4HydF48HCAQ781l8
	zK2cbc8rVJXKuhL/iH/tZsHTSkz2p154rlRJo9tqp/wJIqmsaIBzGqPQEVb4ofVKonerjDOzoWJHW
	XyFCcFxQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPnp-005LsQ-2F;
	Tue, 05 Sep 2023 06:44:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	petr.tesarik.ext@huawei.com
Cc: iommu@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] swiotlb: add the missing dynamic swiotlb check in is_swiotlb_buffer
Date: Tue,  5 Sep 2023 08:44:41 +0200
Message-Id: <20230905064441.127588-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit 1395706a1490 ("swiotlb: search the software IO TLB only if the
device makes use of it") claims to avoid the dynamic swiotlb lookup
unless dynamic allocations are actually used.  And while it adds all
the infrastructure for doing that, it misses the final bit of actually
checking the flag.  Actually add the check for this functionality to
work.

Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
Reported-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b4536626f8ff35..a188025389836b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -172,13 +172,17 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 	if (!mem)
 		return false;
 
-	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
-		/* Pairs with smp_wmb() in swiotlb_find_slots() and
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	if (dev->dma_uses_io_tlb) {
+		/*
+		 * Pairs with smp_wmb() in swiotlb_find_slots() and
 		 * swiotlb_dyn_alloc(), which modify the RCU lists.
 		 */
 		smp_rmb();
 		return swiotlb_find_pool(dev, paddr);
 	}
+#endif
+
 	return paddr >= mem->defpool.start && paddr < mem->defpool.end;
 }
 
-- 
2.39.2

