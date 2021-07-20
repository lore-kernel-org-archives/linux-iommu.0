Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75720C07E9D
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 02:08:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB9561164
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 02:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB9561164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCB3640130;
	Tue, 20 Jul 2021 02:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDyNMVwxcxQA; Tue, 20 Jul 2021 02:08:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A558140230;
	Tue, 20 Jul 2021 02:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 800BBC0010;
	Tue, 20 Jul 2021 02:08:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBD7C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 02:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D938D4046E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 02:08:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yrBmSAWINgC8 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 02:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C6014046D
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 02:08:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="274987747"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="274987747"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 19:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="453891950"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 19:08:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] iommu/vt-d: Report real pgsize bitmap to iommu core
Date: Tue, 20 Jul 2021 10:06:13 +0800
Message-Id: <20210720020615.4144323-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
References: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

The pgsize bitmap is used to advertise the page sizes our hardware supports
to the IOMMU core, which will then use this information to split physically
contiguous memory regions it is mapping into page sizes that we support.

Traditionally the IOMMU core just handed us the mappings directly, after
making sure the size is an order of a 4KiB page and that the mapping has
natural alignment. To retain this behavior, we currently advertise that we
support all page sizes that are an order of 4KiB.

We are about to utilize the new IOMMU map/unmap_pages APIs. We could change
this to advertise the real page sizes we support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 741d25ded717..240af636d51e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -85,24 +85,6 @@
 #define LEVEL_STRIDE		(9)
 #define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
 
-/*
- * This bitmap is used to advertise the page sizes our hardware support
- * to the IOMMU core, which will then use this information to split
- * physically contiguous memory regions it is mapping into page sizes
- * that we support.
- *
- * Traditionally the IOMMU core just handed us the mappings directly,
- * after making sure the size is an order of a 4KiB page and that the
- * mapping has natural alignment.
- *
- * To retain this behavior, we currently advertise that we support
- * all page sizes that are an order of 4KiB.
- *
- * If at some point we'd like to utilize the IOMMU core's new behavior,
- * we could change this to advertise the real page sizes we support.
- */
-#define INTEL_IOMMU_PGSIZES	(~0xFFFUL)
-
 static inline int agaw_to_level(int agaw)
 {
 	return agaw + 2;
@@ -736,6 +718,23 @@ static int domain_update_device_node(struct dmar_domain *domain)
 
 static void domain_update_iotlb(struct dmar_domain *domain);
 
+/* Return the super pagesize bitmap if supported. */
+static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
+{
+	unsigned long bitmap = 0;
+
+	/*
+	 * 1-level super page supports page size of 2MiB, 2-level super page
+	 * supports page size of both 2MiB and 1GiB.
+	 */
+	if (domain->iommu_superpage == 1)
+		bitmap |= SZ_2M;
+	else if (domain->iommu_superpage == 2)
+		bitmap |= SZ_2M | SZ_1G;
+
+	return bitmap;
+}
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
@@ -762,6 +761,7 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	else
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 
+	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
 	domain_update_iotlb(domain);
 }
 
@@ -5607,7 +5607,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
+	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.cache_invalidate	= intel_iommu_sva_invalidate,
 	.sva_bind_gpasid	= intel_svm_bind_gpasid,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
