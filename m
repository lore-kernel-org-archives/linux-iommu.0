Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DE4C4332F
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA6BF40288;
	Tue, 23 Nov 2021 14:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFeKGP5kU0Na; Tue, 23 Nov 2021 14:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F24F403A7;
	Tue, 23 Nov 2021 14:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47640C0037;
	Tue, 23 Nov 2021 14:11:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56C24C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40EAB6076C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8n6HwD8L74u for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:10:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82DBB60759
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03E26150C;
 Tue, 23 Nov 2021 06:10:59 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC4C63F66F;
 Tue, 23 Nov 2021 06:10:57 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 4/9] iommu/amd: Simplify pagetable freeing
Date: Tue, 23 Nov 2021 14:10:39 +0000
Message-Id: <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1637671820.git.robin.murphy@arm.com>
References: <cover.1637671820.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
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
 drivers/iommu/amd/io_pgtable.c | 78 +++++++++++++---------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 182c93a43efd..f92ecb3e21d7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -84,49 +84,41 @@ static void free_page_list(struct page *freelist)
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
@@ -136,19 +128,11 @@ static struct page *free_sub_pt(unsigned long root, int mode,
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
@@ -364,7 +348,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 
 static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 {
-	unsigned long pt;
+	u64 *pt;
 	int mode;
 
 	while (cmpxchg64(pte, pteval, 0) != pteval) {
@@ -375,7 +359,7 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 	if (!IOMMU_PTE_PRESENT(pteval))
 		return freelist;
 
-	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
+	pt   = IOMMU_PTE_PAGE(pteval);
 	mode = IOMMU_PTE_MODE(pteval);
 
 	return free_sub_pt(pt, mode, freelist);
@@ -512,7 +496,6 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 	struct protection_domain *dom;
 	struct page *freelist = NULL;
-	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
@@ -529,8 +512,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
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
