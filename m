Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D2C432BE
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE2361019
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CE2361019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 242A583A41;
	Wed, 11 Aug 2021 12:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBdoXvke5cHs; Wed, 11 Aug 2021 12:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5D92836F0;
	Wed, 11 Aug 2021 12:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DDA5C001A;
	Wed, 11 Aug 2021 12:22:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74D42C001F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57D284056A
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ldmFpdUkRXx for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id B66F140569
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613CD13A1;
 Wed, 11 Aug 2021 05:22:29 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85BEB3F718;
 Wed, 11 Aug 2021 05:22:27 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v4 19/24] iommu/vt-d: Prepare for multiple DMA domain types
Date: Wed, 11 Aug 2021 13:21:33 +0100
Message-Id: <31a8ef868d593a2f3826a6a120edee81815375a7.1628682049.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
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

In preparation for the strict vs. non-strict decision for DMA domains
to be expressed in the domain type, make sure we expose our flush queue
awareness by accepting the new domain type, and test the specific
feature flag where we want to identify DMA domains in general. The DMA
ops reset/setup can simply be made unconditional, since iommu-dma
already knows only to touch DMA domains.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7e168634c433..8fc46c9d6b96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -582,7 +582,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	int iommu_id;
 
 	/* si_domain and vm domain should not get here. */
-	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
+	if (WARN_ON(!iommu_is_dma_domain(&domain->domain)))
 		return NULL;
 
 	for_each_domain_iommu(iommu_id, domain)
@@ -1034,7 +1034,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain_use_first_level(domain)) {
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
-				if (domain->domain.type == IOMMU_DOMAIN_DMA)
+				if (iommu_is_dma_domain(&domain->domain))
 					pteval |= DMA_FL_PTE_ACCESS;
 			}
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
@@ -2345,7 +2345,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if (domain_use_first_level(domain)) {
 		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
-		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
+		if (iommu_is_dma_domain(&domain->domain)) {
 			attr |= DMA_FL_PTE_ACCESS;
 			if (prot & DMA_PTE_WRITE)
 				attr |= DMA_FL_PTE_DIRTY;
@@ -4528,6 +4528,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 
 	switch (type) {
 	case IOMMU_DOMAIN_DMA:
+	case IOMMU_DOMAIN_DMA_FQ:
 	case IOMMU_DOMAIN_UNMANAGED:
 		dmar_domain = alloc_domain(0);
 		if (!dmar_domain) {
@@ -5197,12 +5198,8 @@ static void intel_iommu_release_device(struct device *dev)
 
 static void intel_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-
-	if (domain && domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, 0, U64_MAX);
-	else
-		set_dma_ops(dev, NULL);
+	set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
