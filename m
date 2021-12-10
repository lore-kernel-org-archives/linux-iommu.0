Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E5C433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 17:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 183994239D;
	Fri, 10 Dec 2021 17:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kP1eEwmKohB4; Fri, 10 Dec 2021 17:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B3F49423AF;
	Fri, 10 Dec 2021 17:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E03AC006F;
	Fri, 10 Dec 2021 17:55:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93B89C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71B558272A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NhSy7RjJ8PLf for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 17:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id A574382716
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089A5142F;
 Fri, 10 Dec 2021 09:55:13 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3F863F73B;
 Fri, 10 Dec 2021 09:55:11 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 06/11] iommu/amd: Simplify pagetable freeing
Date: Fri, 10 Dec 2021 17:54:47 +0000
Message-Id: <b9a65dccb0b3335fd639567592fa1d73bcf71a77.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639157090.git.robin.murphy@arm.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

For reasons unclear, pagetable freeing is an effectively recursive
method implemented via an elaborate system of templated functions that
turns out to account for 25% of the object file size. Implementing it
using regular straightforward recursion makes the code simpler, and
seems like a good thing to do before we work on it further. As part of
that, also fix the types to avoid all the needless casting back and
forth which just gets in the way.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Comment the (pre-existing) level 2 optimisation logic

 drivers/iommu/amd/io_pgtable.c | 82 ++++++++++++++--------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 182c93a43efd..4165e1372b6e 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -84,49 +84,45 @@ static void free_page_list(struct page *freelist)
 	}
 }
 
-static struct page *free_pt_page(unsigned long pt, struct page *freelist)
+static struct page *free_pt_page(u64 *pt, struct page *freelist)
 {
-	struct page *p = virt_to_page((void *)pt);
+	struct page *p = virt_to_page(pt);
 
 	p->freelist = freelist;
 
 	return p;
 }
 
-#define DEFINE_FREE_PT_FN(LVL, FN)						\
-static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
-{										\
-	unsigned long p;							\
-	u64 *pt;								\
-	int i;									\
-										\
-	pt = (u64 *)__pt;							\
-										\
-	for (i = 0; i < 512; ++i) {						\
-		/* PTE present? */						\
-		if (!IOMMU_PTE_PRESENT(pt[i]))					\
-			continue;						\
-										\
-		/* Large PTE? */						\
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
-		    PM_PTE_LEVEL(pt[i]) == 7)					\
-			continue;						\
-										\
-		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
-		freelist = FN(p, freelist);					\
-	}									\
-										\
-	return free_pt_page((unsigned long)pt, freelist);			\
+static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
+{
+	u64 *p;
+	int i;
+
+	for (i = 0; i < 512; ++i) {
+		/* PTE present? */
+		if (!IOMMU_PTE_PRESENT(pt[i]))
+			continue;
+
+		/* Large PTE? */
+		if (PM_PTE_LEVEL(pt[i]) == 0 ||
+		    PM_PTE_LEVEL(pt[i]) == 7)
+			continue;
+
+		/*
+		 * Free the next level. No need to look at l1 tables here since
+		 * they can only contain leaf PTEs; just free them directly.
+		 */
+		p = IOMMU_PTE_PAGE(pt[i]);
+		if (lvl > 2)
+			freelist = free_pt_lvl(p, freelist, lvl - 1);
+		else
+			freelist = free_pt_page(p, freelist);
+	}
+
+	return free_pt_page(pt, freelist);
 }
 
-DEFINE_FREE_PT_FN(l2, free_pt_page)
-DEFINE_FREE_PT_FN(l3, free_pt_l2)
-DEFINE_FREE_PT_FN(l4, free_pt_l3)
-DEFINE_FREE_PT_FN(l5, free_pt_l4)
-DEFINE_FREE_PT_FN(l6, free_pt_l5)
-
-static struct page *free_sub_pt(unsigned long root, int mode,
-				struct page *freelist)
+static struct page *free_sub_pt(u64 *root, int mode, struct page *freelist)
 {
 	switch (mode) {
 	case PAGE_MODE_NONE:
@@ -136,19 +132,11 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 		freelist = free_pt_page(root, freelist);
 		break;
 	case PAGE_MODE_2_LEVEL:
-		freelist = free_pt_l2(root, freelist);
-		break;
 	case PAGE_MODE_3_LEVEL:
-		freelist = free_pt_l3(root, freelist);
-		break;
 	case PAGE_MODE_4_LEVEL:
-		freelist = free_pt_l4(root, freelist);
-		break;
 	case PAGE_MODE_5_LEVEL:
-		freelist = free_pt_l5(root, freelist);
-		break;
 	case PAGE_MODE_6_LEVEL:
-		freelist = free_pt_l6(root, freelist);
+		free_pt_lvl(root, freelist, mode);
 		break;
 	default:
 		BUG();
@@ -364,7 +352,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 
 static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 {
-	unsigned long pt;
+	u64 *pt;
 	int mode;
 
 	while (cmpxchg64(pte, pteval, 0) != pteval) {
@@ -375,7 +363,7 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 	if (!IOMMU_PTE_PRESENT(pteval))
 		return freelist;
 
-	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
+	pt   = IOMMU_PTE_PAGE(pteval);
 	mode = IOMMU_PTE_MODE(pteval);
 
 	return free_sub_pt(pt, mode, freelist);
@@ -512,7 +500,6 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 	struct protection_domain *dom;
 	struct page *freelist = NULL;
-	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
@@ -529,8 +516,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
-	root = (unsigned long)pgtable->root;
-	freelist = free_sub_pt(root, pgtable->mode, freelist);
+	freelist = free_sub_pt(pgtable->root, pgtable->mode, freelist);
 
 	free_page_list(freelist);
 }
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
