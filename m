Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A2C47E48
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 13:04:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B060613C4
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 13:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B060613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F32A8414BE;
	Thu, 15 Jul 2021 13:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLHWV4vaiuzc; Thu, 15 Jul 2021 13:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34135403F9;
	Thu, 15 Jul 2021 13:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DCA3C0010;
	Thu, 15 Jul 2021 13:04:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D84D5C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 13:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B8B2483DC5
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 13:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8l8h3COrzDs4 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 13:04:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C1CC82EF1
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 13:04:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37E031B;
 Thu, 15 Jul 2021 06:04:37 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B35513F694;
 Thu, 15 Jul 2021 06:04:36 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH v2] iommu: Streamline iommu_iova_to_phys()
Date: Thu, 15 Jul 2021 14:04:24 +0100
Message-Id: <f564f3f6ff731b898ff7a898919bf871c2c7745a.1626354264.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

If people are going to insist on calling iommu_iova_to_phys()
pointlessly and expecting it to work, we can at least do ourselves a
favour by handling those cases in the core code, rather than repeatedly
across an inconsistent handful of drivers.

Since all the existing drivers implement the internal callback, and any
future ones are likely to want to work with iommu-dma which relies on
iova_to_phys a fair bit, we may as well remove that currently-redundant
check as well and consider it mandatory.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v2: Lowered the priority of the ops check per Baolu's suggestion, only
    even further to the point of non-existence :)
---
 drivers/iommu/amd/io_pgtable.c              | 3 ---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ---
 drivers/iommu/iommu.c                       | 5 ++++-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index bb0ee5c9fde7..182c93a43efd 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -493,9 +493,6 @@ static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned lo
 	unsigned long offset_mask, pte_pgsize;
 	u64 *pte, __pte;
 
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return iova;
-
 	pte = fetch_pte(pgtable, iova, &pte_pgsize);
 
 	if (!pte || !IOMMU_PTE_PRESENT(*pte))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3e87a9cf6da3..c9fdd0d097be 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2481,9 +2481,6 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY)
-		return iova;
-
 	if (!ops)
 		return 0;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0f181f76c31b..0d04eafa3fdb 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1317,9 +1317,6 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY)
-		return iova;
-
 	if (!ops)
 		return 0;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 43a2041d9629..d4ba324fb0bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2371,7 +2371,10 @@ EXPORT_SYMBOL_GPL(iommu_detach_group);
 
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
-	if (unlikely(domain->ops->iova_to_phys == NULL))
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return iova;
+
+	if (domain->type == IOMMU_DOMAIN_BLOCKED)
 		return 0;
 
 	return domain->ops->iova_to_phys(domain, iova);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
