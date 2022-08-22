Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84885656
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IynWQwuvKQj2zQWKQEeRgNviPfklztyfRPoZFsR2Bho=; b=D2mjhazKc7q2hFbo0lpeetG9vA
	HcYi18m5B9jToI7Hba5gzV9WdvcrSm7wlni0IEsiwYebnivXQHi9plrpZ26PBzLJrlc0rHercl0qt
	Kv/f+3Tbovtww9Lp5Pa3DCn5RIms2m0gaDLbfQSBUF8MWPH/azwEEpapMYlYdM/0/pFEoGeH/WGwQ
	Wvy6uzxFr7XAwcp0NR+NW3p7RowkK8WQ0c7ajCoaXv+3JL3efV+eZniC/RYfPNzse4BVD5c7siqAY
	RbqieLw33eLdDyYM2dic3XOFtHaCjVM5BdfcvAUCIAuWWGtnzwWqXM3hgMZkBuaF6zoQnB5CBXPRI
	jn0K+rZA==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ0gG-005Kaf-H1; Mon, 22 Aug 2022 06:13:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dma-pool: factor out a calculate_pool_size helper
Date: Mon, 22 Aug 2022 08:12:53 +0200
Message-Id: <20220822061255.151688-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822061255.151688-1-hch@lst.de>
References: <20220822061255.151688-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to calculate the pool size from dma_atomic_pool_init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/pool.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 4d40dcce7604b..37008d4f6d7af 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -184,6 +184,14 @@ static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
 	return pool;
 }
 
+static size_t calculate_pool_size(unsigned long zone_pages)
+{
+	unsigned long pages = zone_pages / (SZ_1G / SZ_128K);
+
+	pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
+	return max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
+}
+
 static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
@@ -192,11 +200,9 @@ static int __init dma_atomic_pool_init(void)
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
-	if (!atomic_pool_size) {
-		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
-		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
-		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
-	}
+	if (!atomic_pool_size)
+		atomic_pool_size = calculate_pool_size(totalram_pages());
+
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
-- 
2.30.2

