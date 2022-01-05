Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB31FC433F5
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 21:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 821DE6FBB7;
	Wed,  5 Jan 2022 21:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRU61FuV5Mdh; Wed,  5 Jan 2022 21:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E3656FBC5;
	Wed,  5 Jan 2022 21:48:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2955C0070;
	Wed,  5 Jan 2022 21:48:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42D5EC001E;
 Wed,  5 Jan 2022 21:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E62983281;
 Wed,  5 Jan 2022 21:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="Gnw5kDEv";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="AEIybQwU"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8u8fN2Sk6gQ; Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1AD183268;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 82E62580516;
 Wed,  5 Jan 2022 16:48:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 05 Jan 2022 16:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=pLhfLGipzI8++
 qIYMIVnkD5rDV8QoVpF5W3LR+3/IwA=; b=Gnw5kDEvRJbOmlvoEvQ4vpKG7S8SK
 j1uu9JA2H2vtlHmY099jZo9uhUqNplL221UZxxWi+kHEMyPceoZkdK2p7+Tx3hze
 GMvmLX15SjHzUzKPoJC+pamMGxn73Tui3GMN+JAO5QTamS5hCjQ8dBhpcXXHjQG9
 Myz+ZVi8CB6lYahF5KghMzqj1aDHAj05t5Ub8VuHPGI+Hm2n6zveQGMe7MG/sHOJ
 vj9NG7hfG8ue3GU6uoDuNLBvY5MQXtPIOUjzLxW8yYfZ3DCBhZnMMntbBcuer2Ko
 BkaWE4NqlvBkEKtNV5dymaUNWqZBZSy1mb2x0cZyBeSYF2+iy7PjoxtKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=pLhfLGipzI8++qIYMIVnkD5rDV8QoVpF5W3LR+3/IwA=; b=AEIybQwU
 Bc1S4r9mo8e/ZMtEZcXVTF6muGnmR9mczNKkfx5ZlTQPpJs4piw9GhQkuFHUFjGM
 yNQ1nU/dsySLhoLyiFzdNy8bQaqc2HT0vSOQNqYd4+N0o5UWBInRVpGOw/oiNKS0
 lmFkv5kU3BZTCm/osmv0mkgFBzh0m3pmkbMLMUcHuOh7dxWwoNKMazib8+2Mq1K2
 UM+mpLiLDibOWX5C7oMRIZSbTojBAtkWPJ/at9ESR8huXzTBFzHMWcH/98q5WvAP
 X6Iahi7RbyxXhocqm5DWjf04XK0Xr/kX2mzTsbKmbd41fBtSDUgwzaeQGxUAhTsA
 NJ0myAio5iyJ+A==
X-ME-Sender: <xms:KRLWYXgJbYYomj09YaKZvJffXG3--n1E19sF9rW04i4EsGDhZOLatg>
 <xme:KRLWYUD0hEVqOYh_O1a6Rbb1C3sMVJvWKQ_tzmNzRVE5Exmw1M53AJFwFHe0blaMy
 8f7qHEox9H5c2d1Cw>
X-ME-Received: <xmr:KRLWYXHXba88Nt0fqWBicghRi_AGs-v9IOKVKJblSdPpgHJRU-KbmUFbFQk4eU2VwLuVcKJ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:KRLWYUStY0C_yNp3tnXJg3h-VZlU3vlqaZI9NfCcDMZKj-HqA6OBsA>
 <xmx:KRLWYUyiD-cGy-aT2pFUZUoguosb-4450_lqWtS2mMa-Mqw-DvvTdw>
 <xmx:KRLWYa7-bnQSHbm8b1coARXyZRnyOmoJmGcFg6bzebrso1OKTgDFcA>
 <xmx:KRLWYfr0NFMz910K1mT81YWcSwpmDW8BBw2N18y7MOfApSsbK3ospg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:24 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
Date: Wed,  5 Jan 2022 16:47:51 -0500
Message-Id: <20220105214756.91065-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
MIME-Version: 1.0
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
 mm/migrate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..b1851ffb8576 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1546,9 +1546,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
-	}
-
-	if (PageTransHuge(page)) {
+	} else if (is_transparent_hugepage(page)) {
 		/*
 		 * clear __GFP_RECLAIM to make the migration callback
 		 * consistent with regular THP allocations.
@@ -1556,14 +1554,19 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		gfp_mask &= ~__GFP_RECLAIM;
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
+	} else if (PageCompound(page)) {
+		/* for non-LRU movable compound pages */
+		gfp_mask |= __GFP_COMP;
+		order = compound_order(page);
 	}
+
 	zidx = zone_idx(page_zone(page));
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
 	new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
 
-	if (new_page && PageTransHuge(new_page))
+	if (new_page && is_transparent_hugepage(page))
 		prep_transhuge_page(new_page);
 
 	return new_page;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
