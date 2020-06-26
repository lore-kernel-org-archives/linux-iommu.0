Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FAC433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7373208C7
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7373208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8F7687A87;
	Fri, 26 Jun 2020 08:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcsJbdAHkMGW; Fri, 26 Jun 2020 08:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E40A876FB;
	Fri, 26 Jun 2020 08:05:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18932C088C;
	Fri, 26 Jun 2020 08:05:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15863C088C
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 08:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F2C5C2078D
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 08:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lpvij1lvBUsX for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 08:05:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 6B0DB204BE
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 08:05:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6BD1E391; Fri, 26 Jun 2020 10:05:48 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/2] iommu/amd: Add helper functions to update
 domain->pt_root
Date: Fri, 26 Jun 2020 10:05:46 +0200
Message-Id: <20200626080547.24865-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626080547.24865-1-joro@8bytes.org>
References: <20200626080547.24865-1-joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
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

From: Joerg Roedel <jroedel@suse.de>

Do not call atomic64_set() directly to update the domain page-table
root and use two new helper functions.

This makes it easier to implement additional work necessary when
the page-table is updated.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 74cca1757172..5286ddcfc2f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -162,7 +162,18 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
-static u64 amd_iommu_domain_encode_pgtable(u64 *root, int mode)
+static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
+{
+	atomic64_set(&domain->pt_root, root);
+}
+
+static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
+{
+	amd_iommu_domain_set_pt_root(domain, 0);
+}
+
+static void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
+					 u64 *root, int mode)
 {
 	u64 pt_root;
 
@@ -170,7 +181,7 @@ static u64 amd_iommu_domain_encode_pgtable(u64 *root, int mode)
 	pt_root = mode & 7;
 	pt_root |= (u64)root;
 
-	return pt_root;
+	amd_iommu_domain_set_pt_root(domain, pt_root);
 }
 
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
@@ -1410,7 +1421,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	struct domain_pgtable pgtable;
 	unsigned long flags;
 	bool ret = true;
-	u64 *pte, root;
+	u64 *pte;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -1438,8 +1449,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	 * Device Table needs to be updated and flushed before the new root can
 	 * be published.
 	 */
-	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode);
-	atomic64_set(&domain->pt_root, root);
+	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
 
 	ret = true;
 
@@ -2319,7 +2329,7 @@ static void protection_domain_free(struct protection_domain *domain)
 		domain_id_free(domain->id);
 
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	atomic64_set(&domain->pt_root, 0);
+	amd_iommu_domain_clr_pt_root(domain);
 	free_pagetable(&pgtable);
 
 	kfree(domain);
@@ -2327,7 +2337,7 @@ static void protection_domain_free(struct protection_domain *domain)
 
 static int protection_domain_init(struct protection_domain *domain, int mode)
 {
-	u64 *pt_root = NULL, root;
+	u64 *pt_root = NULL;
 
 	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
 
@@ -2343,8 +2353,7 @@ static int protection_domain_init(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
-	root = amd_iommu_domain_encode_pgtable(pt_root, mode);
-	atomic64_set(&domain->pt_root, root);
+	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
 }
@@ -2713,8 +2722,8 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	/* First save pgtable configuration*/
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
-	/* Update data structure */
-	atomic64_set(&domain->pt_root, 0);
+	/* Remove page-table from domain */
+	amd_iommu_domain_clr_pt_root(domain);
 
 	/* Make changes visible to IOMMUs */
 	update_domain(domain);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
