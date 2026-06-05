Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 39F9B21883E
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620025; cv=none; b=lT6ZSc1WgTkScBBGFcpB010vscfJ+Ghox7JYIa6tMgxyb8wAWQIrVl3u7C1NViH4hJeD+BIGvHifV3kBTBUMKWBjcKnVx6hqxAqZTB0Uj+yXATCIw8OV5LW/iZYCLe1OrzzuaInivptbrs7zX8W4uxXKcIyhuhr48XwUDKDC5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620025; c=relaxed/simple;
	bh=KPj9bNQzAWWv6RiO1fk9816+3TLZ4d6u5NN4FM8XAfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVeWsreefnEevdGpZEn7mS9oiydH0zUyBxzckPLnHHuqKpGb8OenpF0ksEJTpXbymtAjnY6QSMerpUHr6bxtX0I9UEWaQ162kSXXCQTWTDCaTcIlyplp5NnxGp//b8MAIPegrfuVbcFmVXZ3JVF9WennBl+pji0MuGhfxNkunNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=N9HfUPxb; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="N9HfUPxb"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/intel: Prevent variable pollution in cache_tag_flush_range()
Date: Fri, 5 Jun 2026 08:39:50 +0800
Message-ID: <20260605003950.1720-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc10.internal.baidu.com (172.31.3.20) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780620010;
	bh=hB+Iq6Djm8O3GHlZoIyH0vDln+WNC/ceWfjCPNDcgQg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=N9HfUPxbijVIIbJoAZPaxC+jAJO7o1I88YW/ugMZtmgmDCJNNx9M/ammhIxCQgK6D
	 BjhB1LrzpYMaC7xOip19/jaISW3l/95PhPAWEryl1XnKjMLEPoYjPilfyDLr7eXS1m
	 dnjxQLeL9DXhnDlwVrQegVwnpsZEVHhtTjs1seT/cEpIretL0SkGVe30dBW0wxC+UC
	 oC+R65hziD1jmS5EnNCuVTrsSv/2WVabx+JORJfWSQ3k09iioqwGNXuQuFUuoUa8x7
	 3UgHJGDugjf0UQhXe9fcS52WvOjlIyNBWzUAt32cHSj5HzkzetW17+aVVWor0RNIO3
	 0Ou8pkmBuZ0fQ==

From: Li RongQing <lirongqing@baidu.com>

The loop in cache_tag_flush_range() modifies local 'addr' and 'mask'
variables that persist across iterations. When CACHE_TAG_NESTING_DEVTLB
overrides them for a full flush and falls through, subsequent tags
incorrectly receive the modified values instead of the original range.

Fix by creating per-iteration local copies initialized from the original
parameters, ensuring each tag processes the intended flush range.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/intel/cache.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index fdc8881..9253025 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -437,6 +437,9 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
+		unsigned long flush_addr = addr;
+		unsigned long flush_mask = mask;
+
 		if (iommu && iommu != tag->iommu)
 			qi_batch_flush_descs(iommu, domain->qi_batch);
 		iommu = tag->iommu;
@@ -444,7 +447,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 		switch (tag->type) {
 		case CACHE_TAG_IOTLB:
 		case CACHE_TAG_NESTING_IOTLB:
-			cache_tag_flush_iotlb(domain, tag, addr, mask, ih);
+			cache_tag_flush_iotlb(domain, tag, flush_addr, flush_mask, ih);
 			break;
 		case CACHE_TAG_NESTING_DEVTLB:
 			/*
@@ -454,15 +457,15 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			 * affected by a change in S2. So just flush the entire
 			 * device cache.
 			 */
-			addr = 0;
-			mask = MAX_AGAW_PFN_WIDTH;
+			flush_addr = 0;
+			flush_mask = MAX_AGAW_PFN_WIDTH;
 			fallthrough;
 		case CACHE_TAG_DEVTLB:
-			cache_tag_flush_devtlb_psi(domain, tag, addr, mask);
+			cache_tag_flush_devtlb_psi(domain, tag, flush_addr, flush_mask);
 			break;
 		}
 
-		trace_cache_tag_flush_range(tag, start, end, addr, mask);
+		trace_cache_tag_flush_range(tag, start, end, flush_addr, flush_mask);
 	}
 	qi_batch_flush_descs(iommu, domain->qi_batch);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
-- 
2.9.4

