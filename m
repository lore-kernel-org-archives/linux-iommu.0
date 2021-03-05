Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18AC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 16:35:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B026508B
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 16:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B026508B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1E2C42FC6;
	Fri,  5 Mar 2021 16:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXpA_IX5atL5; Fri,  5 Mar 2021 16:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F78043302;
	Fri,  5 Mar 2021 16:35:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50AB9C000B;
	Fri,  5 Mar 2021 16:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39DC9C0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28D0983EB1
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vz3nOWRxigxv for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 16:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48A3783EC8
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:35:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B17911FB;
 Fri,  5 Mar 2021 08:35:29 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.48.219])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26A9E3F73B;
 Fri,  5 Mar 2021 08:35:28 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH 1/2] iommu/iova: Add rbtree entry helper
Date: Fri,  5 Mar 2021 16:35:22 +0000
Message-Id: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
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

Repeating the rb_entry() boilerplate all over the place gets old fast.
Before adding yet more instances, add a little hepler to tidy it up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c..c28003e1d2ee 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -27,6 +27,11 @@ static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
 static void free_global_cached_iovas(struct iova_domain *iovad);
 
+static struct iova *to_iova(struct rb_node *node)
+{
+	return rb_entry(node, struct iova, node);
+}
+
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn)
@@ -136,7 +141,7 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 {
 	struct iova *cached_iova;
 
-	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
+	cached_iova = to_iova(iovad->cached32_node);
 	if (free == cached_iova ||
 	    (free->pfn_hi < iovad->dma_32bit_pfn &&
 	     free->pfn_lo >= cached_iova->pfn_lo)) {
@@ -144,7 +149,7 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 	}
 
-	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
+	cached_iova = to_iova(iovad->cached_node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
 		iovad->cached_node = rb_next(&free->node);
 }
@@ -159,7 +164,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 	new = (start) ? &start : &(root->rb_node);
 	/* Figure out where to put new node */
 	while (*new) {
-		struct iova *this = rb_entry(*new, struct iova, node);
+		struct iova *this = to_iova(*new);
 
 		parent = *new;
 
@@ -198,7 +203,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		goto iova32_full;
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
-	curr_iova = rb_entry(curr, struct iova, node);
+	curr_iova = to_iova(curr);
 	retry_pfn = curr_iova->pfn_hi + 1;
 
 retry:
@@ -207,7 +212,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		new_pfn = (high_pfn - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
-		curr_iova = rb_entry(curr, struct iova, node);
+		curr_iova = to_iova(curr);
 	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
 
 	if (high_pfn < size || new_pfn < low_pfn) {
@@ -215,7 +220,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 			high_pfn = limit_pfn;
 			low_pfn = retry_pfn;
 			curr = &iovad->anchor.node;
-			curr_iova = rb_entry(curr, struct iova, node);
+			curr_iova = to_iova(curr);
 			goto retry;
 		}
 		iovad->max32_alloc_size = size;
@@ -331,7 +336,7 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 	assert_spin_locked(&iovad->iova_rbtree_lock);
 
 	while (node) {
-		struct iova *iova = rb_entry(node, struct iova, node);
+		struct iova *iova = to_iova(node);
 
 		if (pfn < iova->pfn_lo)
 			node = node->rb_left;
@@ -617,7 +622,7 @@ static int
 __is_range_overlap(struct rb_node *node,
 	unsigned long pfn_lo, unsigned long pfn_hi)
 {
-	struct iova *iova = rb_entry(node, struct iova, node);
+	struct iova *iova = to_iova(node);
 
 	if ((pfn_lo <= iova->pfn_hi) && (pfn_hi >= iova->pfn_lo))
 		return 1;
@@ -685,7 +690,7 @@ reserve_iova(struct iova_domain *iovad,
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
 		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
-			iova = rb_entry(node, struct iova, node);
+			iova = to_iova(node);
 			__adjust_overlap_range(iova, &pfn_lo, &pfn_hi);
 			if ((pfn_lo >= iova->pfn_lo) &&
 				(pfn_hi <= iova->pfn_hi))
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
