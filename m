Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7559CC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2030F80C59;
	Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbgldhSAeUiy; Thu,  9 Dec 2021 23:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AB7F80C5B;
	Thu,  9 Dec 2021 23:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D94BBC001E;
	Thu,  9 Dec 2021 23:36:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74C9BC0012;
 Thu,  9 Dec 2021 23:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5918E42635;
 Thu,  9 Dec 2021 23:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="yrJquY5V";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="AQVq+JfE"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjC4tZRR3tps; Thu,  9 Dec 2021 23:04:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 821B342619;
 Thu,  9 Dec 2021 23:04:40 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id A15E258025B;
 Thu,  9 Dec 2021 18:04:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 09 Dec 2021 18:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=uSnT9wX9f4RMq
 YBTDyi5K0c2MPG9GRSJQ2BdfgYLu1Y=; b=yrJquY5Vxp9aHnRf1yxk/mrjinrMk
 puUT86QJ3m3xejhByD6AGOCAMlWkM4ic+/fTJsjGrrOlrGgw+A5D8LaeKXrgQs5K
 XyW9WKm3mTXS7i27T8wFG+DgqoPVTrmGsWSFISPxdXkmsGRVN00OIGqTecWzeVtj
 JyOw1zdKO6tBcX7/CEazWnk4ZPnIEbYhy//29o88prEDHcSN5qSP9EPVigm2Srh/
 vOa84XBnLXIMVs/hU/df53IlEn08xNSacedy2WSCALroQ0NROQkPd4l0SUT4aNN6
 gRZPtBQt+VBrfOncH0bDf/73yxhHM6qJwSS4DDOaJjx3R158ZPTX2RnKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=uSnT9wX9f4RMqYBTDyi5K0c2MPG9GRSJQ2BdfgYLu1Y=; b=AQVq+JfE
 lFDq+6QUOYTBvKLjaTXK0jnW0c9jpLBUM1WhMe8NY5jNBBfgSQYDKtDratHPUlQp
 sTEGcUYldmZ3hm4TllzwO3DjdaT0tAQMSJlWDOvtwNFzimFTi5cCZDnc1QpY/2gI
 O9SyXfzO4SjmT51Ujnstws3Jtl7Kc4JBTOMhhlYWtkuT7NNLNiUw1JYvJvRQ9/gB
 T7h/Th+4MX/sfEi2vcnLzQN6WaSopOvf5U3sp8dd6TgnUiUAAOC8XKXVj3seJLXN
 0DUIZ1TnJcWCcs4yumsuCl15ys/edoz4MnEUoCbNRUxJhlQn/OHJvrjOpTwtt9wX
 vR6qrSjGWm+ZGg==
X-ME-Sender: <xms:houyYXo2UaCMhdwzrPsUASB_AjBU2-VtIa4KDxO2DW_KNySeyD0juw>
 <xme:houyYRrq84WXQAXKEqDIwIxbxbprwwlG8kpnen6Y4YmYaMrnmejk_o_dblfLINU6L
 29JlHllLvEBIMNshw>
X-ME-Received: <xmr:houyYUNhhoBGrbQJP7RH87Gh2L-nfv9BKNkG_ENwUD8BgCXc8EyzNX-lxz2C5vHQ37JbJQAR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:houyYa4HQX3J5SVelIDGoSq8cSgPVHZwVTosHjfcQy3l6m3o9v_TKg>
 <xmx:houyYW5dQvbsiXKespuU4N6x0MC6_a48W5AVL4kMYgQFAYC5maNTgA>
 <xmx:houyYSg4gYCmnKIF-RDJ-4hhe-8PVPFLZJXq_ENBhzubCaE4u8LoAQ>
 <xmx:h4uyYWwqapDJS_QzqajhhXE7IEK_4nnU1oDXPelIE51DF24d6jSrEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:38 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/7] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
Date: Thu,  9 Dec 2021 18:04:10 -0500
Message-Id: <20211209230414.2766515-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Dec 2021 23:36:06 +0000
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Zi Yan <ziy@nvidia.com>

alloc_migration_target() is used by alloc_contig_range() and non-LRU
movable compound pages can be migrated. Current code does not allocate the
right page size for such pages. Check THP precisely using
is_transparent_huge() and add allocation support for non-LRU compound
pages.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d487a399253b..2ce3c771b1de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1563,7 +1563,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
 	}
 
-	if (PageTransHuge(page)) {
+	if (is_transparent_hugepage(page)) {
 		/*
 		 * clear __GFP_RECLAIM to make the migration callback
 		 * consistent with regular THP allocations.
@@ -1572,13 +1572,17 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
+	if (PageCompound(page)) {
+		gfp_mask |= __GFP_COMP;
+		order = compound_order(page);
+	}
 	zidx = zone_idx(page_zone(page));
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
 	new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
 
-	if (new_page && PageTransHuge(new_page))
+	if (new_page && is_transparent_hugepage(page))
 		prep_transhuge_page(new_page);
 
 	return new_page;
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
