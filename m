Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF89C433E3
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:53:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19AB207D8
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19AB207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B9DE986D36;
	Wed, 27 May 2020 11:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SnmDa-hs5zn; Wed, 27 May 2020 11:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10F3D86D22;
	Wed, 27 May 2020 11:53:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1787C0891;
	Wed, 27 May 2020 11:53:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36204C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 333E986D15
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gieMK2baMUX1 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 11:53:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A32186D04
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:29 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2D471476; Wed, 27 May 2020 13:53:24 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 06/10] iommu/amd: Consolidate domain allocation/freeing
Date: Wed, 27 May 2020 13:53:09 +0200
Message-Id: <20200527115313.7426-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
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

Merge the allocation code paths of DMA and UNMANAGED domains and
remove code duplication.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 116 +++++++++-----------------------------
 1 file changed, 27 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5282ff6b8ea0..9e0737932e0c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -101,7 +101,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
-static int protection_domain_init(struct protection_domain *domain, int mode);
 static void detach_device(struct device *dev);
 static void update_and_flush_device_table(struct protection_domain *domain,
 					  struct domain_pgtable *pgtable);
@@ -1818,58 +1817,6 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-/*
- * Free a domain, only used if something went wrong in the
- * allocation path and we need to free an already allocated page table
- */
-static void dma_ops_domain_free(struct protection_domain *domain)
-{
-	struct domain_pgtable pgtable;
-
-	if (!domain)
-		return;
-
-	iommu_put_dma_cookie(&domain->domain);
-
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	atomic64_set(&domain->pt_root, 0);
-	free_pagetable(&pgtable);
-
-	if (domain->id)
-		domain_id_free(domain->id);
-
-	kfree(domain);
-}
-
-/*
- * Allocates a new protection domain usable for the dma_ops functions.
- * It also initializes the page table and the address allocator data
- * structures required for the dma_ops interface
- */
-static struct protection_domain *dma_ops_domain_alloc(void)
-{
-	struct protection_domain *domain;
-
-	domain = kzalloc(sizeof(struct protection_domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
-	if (protection_domain_init(domain, DEFAULT_PGTABLE_LEVEL))
-		goto free_domain;
-
-	domain->flags = PD_DMA_OPS_MASK;
-
-	if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
-		goto free_domain;
-
-	return domain;
-
-free_domain:
-	dma_ops_domain_free(domain);
-
-	return NULL;
-}
-
 /*
  * little helper function to check whether a given protection domain is a
  * dma_ops domain
@@ -2447,36 +2394,32 @@ static struct protection_domain *protection_domain_alloc(int mode)
 
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
-	struct protection_domain *pdomain;
-
-	switch (type) {
-	case IOMMU_DOMAIN_UNMANAGED:
-		pdomain = protection_domain_alloc(DEFAULT_PGTABLE_LEVEL);
-		if (!pdomain)
-			return NULL;
+	struct protection_domain *domain;
+	int mode = DEFAULT_PGTABLE_LEVEL;
 
-		pdomain->domain.geometry.aperture_start = 0;
-		pdomain->domain.geometry.aperture_end   = ~0ULL;
-		pdomain->domain.geometry.force_aperture = true;
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		mode = PAGE_MODE_NONE;
 
-		break;
-	case IOMMU_DOMAIN_DMA:
-		pdomain = dma_ops_domain_alloc();
-		if (!pdomain) {
-			pr_err("Failed to allocate\n");
-			return NULL;
-		}
-		break;
-	case IOMMU_DOMAIN_IDENTITY:
-		pdomain = protection_domain_alloc(PAGE_MODE_NONE);
-		if (!pdomain)
-			return NULL;
-		break;
-	default:
+	domain = protection_domain_alloc(mode);
+	if (!domain)
 		return NULL;
+
+	domain->domain.geometry.aperture_start = 0;
+	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.force_aperture = true;
+
+	if (type == IOMMU_DOMAIN_DMA) {
+		if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
+			goto free_domain;
+		domain->flags = PD_DMA_OPS_MASK;
 	}
 
-	return &pdomain->domain;
+	return &domain->domain;
+
+free_domain:
+	protection_domain_free(domain);
+
+	return NULL;
 }
 
 static void amd_iommu_domain_free(struct iommu_domain *dom)
@@ -2493,18 +2436,13 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (!dom)
 		return;
 
-	switch (dom->type) {
-	case IOMMU_DOMAIN_DMA:
-		/* Now release the domain */
-		dma_ops_domain_free(domain);
-		break;
-	default:
-		if (domain->flags & PD_IOMMUV2_MASK)
-			free_gcr3_table(domain);
+	if (dom->type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&domain->domain);
 
-		protection_domain_free(domain);
-		break;
-	}
+	if (domain->flags & PD_IOMMUV2_MASK)
+		free_gcr3_table(domain);
+
+	protection_domain_free(domain);
 }
 
 static void amd_iommu_detach_device(struct iommu_domain *dom,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
