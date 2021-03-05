Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538ECC433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 16:35:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8666508B
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 16:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8666508B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD2766ECE9;
	Fri,  5 Mar 2021 16:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-M9Xki3nAOW; Fri,  5 Mar 2021 16:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6387605B3;
	Fri,  5 Mar 2021 16:35:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86076C000B;
	Fri,  5 Mar 2021 16:35:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 215B4C0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1F7B4ED35
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73U4DKqEoNxu for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 16:35:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E2394ED2F
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:35:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC1412FC;
 Fri,  5 Mar 2021 08:35:30 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.48.219])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 794773F73B;
 Fri,  5 Mar 2021 08:35:29 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH 2/2] iommu/iova: Improve restart logic
Date: Fri,  5 Mar 2021 16:35:23 +0000
Message-Id: <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
Cc: vjitta@codeaurora.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When restarting after searching below the cached node fails, resetting
the start point to the anchor node is often overly pessimistic. If
allocations are made with mixed limits - particularly in the case of the
opportunistic 32-bit allocation for PCI devices - this could mean
significant time wasted walking through the whole populated upper range
just to reach the initial limit. We can improve on that by implementing
a proper tree traversal to find the first node above the relevant limit,
and set the exact start point.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index c28003e1d2ee..471c48dd71e7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -154,6 +154,43 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 		iovad->cached_node = rb_next(&free->node);
 }
 
+static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
+{
+	struct rb_node *node, *next;
+	/*
+	 * Ideally what we'd like to judge here is whether limit_pfn is close
+	 * enough to the highest-allocated IOVA that starting the allocation
+	 * walk from the anchor node will be quicker than this initial work to
+	 * find an exact starting point (especially if that ends up being the
+	 * anchor node anyway). This is an incredibly crude approximation which
+	 * only really helps the most likely case, but is at least trivially easy.
+	 */
+	if (limit_pfn > iovad->dma_32bit_pfn)
+		return &iovad->anchor.node;
+
+	node = iovad->rbroot.rb_node;
+	while (to_iova(node)->pfn_hi < limit_pfn)
+		node = node->rb_right;
+
+search_left:
+	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
+		node = node->rb_left;
+
+	if (!node->rb_left)
+		return node;
+
+	next = node->rb_left;
+	while (next->rb_right) {
+		next = next->rb_right;
+		if (to_iova(next)->pfn_lo >= limit_pfn) {
+			node = next;
+			goto search_left;
+		}
+	}
+
+	return node;
+}
+
 /* Insert the iova into domain rbtree by holding writer lock */
 static void
 iova_insert_rbtree(struct rb_root *root, struct iova *iova,
@@ -219,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
 			high_pfn = limit_pfn;
 			low_pfn = retry_pfn;
-			curr = &iovad->anchor.node;
+			curr = iova_find_limit(iovad, limit_pfn);
 			curr_iova = to_iova(curr);
 			goto retry;
 		}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
