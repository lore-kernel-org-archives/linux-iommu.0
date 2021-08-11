Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB6DC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AC860FC0
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62AC860FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C79C40593;
	Wed, 11 Aug 2021 12:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WNhRpokAzsDN; Wed, 11 Aug 2021 12:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 445C640560;
	Wed, 11 Aug 2021 12:22:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0547CC001A;
	Wed, 11 Aug 2021 12:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A255FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FB1982EA5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D77Zw40N-FF9 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:22:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDE2F81A64
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DBF2106F;
 Wed, 11 Aug 2021 05:22:31 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FF3F3F718;
 Wed, 11 Aug 2021 05:22:29 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v4 20/24] iommu: Express DMA strictness via the domain type
Date: Wed, 11 Aug 2021 13:21:34 +0100
Message-Id: <47083d69155577f1367877b1594921948c366eb3.1628682049.git.robin.murphy@arm.com>
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

Eliminate the iommu_get_dma_strict() indirection and pipe the
information through the domain type from the beginning. Besides
the flow simplification this also has several nice side-effects:

 - Automatically implies strict mode for untrusted devices by
   virtue of their IOMMU_DOMAIN_DMA override.
 - Ensures that we only end up using flush queues for drivers
   which are aware of them and can actually benefit.
 - Allows us to handle flush queue init failure by falling back
   to strict mode instead of leaving it to possibly blow up later.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Remember to update iommu_def_domain_type accordingly from
    iommu_set_dma_strict() too
---
 drivers/iommu/dma-iommu.c | 10 ++++++----
 drivers/iommu/iommu.c     | 14 +++++---------
 include/linux/iommu.h     |  1 -
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 207c8febdac9..01fa83229118 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -363,13 +363,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && !dev_is_untrusted(dev) &&
-	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
+	/* If the FQ fails we can simply fall back to strict mode */
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-					  iommu_dma_entry_dtor))
+					  iommu_dma_entry_dtor)) {
 			pr_warn("iova flush queue initialization failed\n");
-		else
+			domain->type = IOMMU_DOMAIN_DMA;
+		} else {
 			cookie->fq_domain = domain;
+		}
 	}
 
 	return iova_reserve_iommu_regions(dev, domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 982545234cf3..55ca5bf3cafc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -136,6 +136,9 @@ static int __init iommu_subsys_init(void)
 		}
 	}
 
+	if (!iommu_default_passthrough() && !iommu_dma_strict)
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
+
 	pr_info("Default domain type: %s %s\n",
 		iommu_domain_type_str(iommu_def_domain_type),
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
@@ -355,17 +358,10 @@ early_param("iommu.strict", iommu_dma_setup);
 void iommu_set_dma_strict(void)
 {
 	iommu_dma_strict = true;
+	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
 
-bool iommu_get_dma_strict(struct iommu_domain *domain)
-{
-	/* only allow lazy flushing for DMA domains */
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		return iommu_dma_strict;
-	return true;
-}
-EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
-
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5629ae42951f..923a8d1c5e39 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -504,7 +504,6 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
 void iommu_set_dma_strict(void);
-bool iommu_get_dma_strict(struct iommu_domain *domain);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
