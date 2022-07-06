Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACCFCCA47B
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 03:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E12CB40AD1;
	Wed,  6 Jul 2022 03:00:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E12CB40AD1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fIwUF1VL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KO2vGrJpACTe; Wed,  6 Jul 2022 03:00:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A68A040A8B;
	Wed,  6 Jul 2022 03:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A68A040A8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA98C0071;
	Wed,  6 Jul 2022 03:00:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71CB7C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F20C40ACA
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F20C40ACA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7l1RpyKbasF for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 03:00:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 957E840A8B
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 957E840A8B
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657076412; x=1688612412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LImdZq86xx+dG7JHLesZkhPMUf7odOMmhfDwO8VtyYY=;
 b=fIwUF1VLDDfC7OjTeq0dQ0v9ld63AsKgDMalAuwmd4cQ91D3I2Xiu49/
 mc0gY3P24fp21rp2uY2MA1awXwGCPR0EtRGayNjG8yiU+vqWlIFZlBV8q
 hwD97jJI4ej0ik8BILIZiX9uIGqwybVcj+tqMcG8nPGWE1ClkchAZu6DH
 Ujt164PeOef/MvfiPdC3AAyn8RMyxqKRm73+CCY59ocrKeuQwXS9t0M24
 yiWOxjjOQvXVInNbWknV3WyIWNvilJ7FjpG18HNzDFflbgHDKJkhaVZWw
 vbMN2bfzRasBhkFsWiTExea7sdNjcM3oUHDydR8AUyq+yTiJx2ePULgT7 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409586"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="272409586"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 20:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="567875225"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 08/11] iommu/vt-d: Check device list of domain in domain
 free path
Date: Wed,  6 Jul 2022 10:55:21 +0800
Message-Id: <20220706025524.2904370-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
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

When the IOMMU domain is about to be freed, it should not be set on any
device. Instead of silently dealing with some bug cases, it's better to
trigger a warning to report and fix any potential bugs at the first time.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3d53de8c7634..a94fb69e1f9a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -294,7 +294,6 @@ static LIST_HEAD(dmar_satc_units);
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
@@ -1841,10 +1840,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);
-
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
 
@@ -1852,6 +1847,9 @@ static void domain_exit(struct dmar_domain *domain)
 		put_pages_list(&freelist);
 	}
 
+	if (WARN_ON(!list_empty(&domain->devices)))
+		return;
+
 	kfree(domain);
 }
 
@@ -2333,16 +2331,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static void domain_remove_dev_info(struct dmar_domain *domain)
-{
-	struct device_domain_info *info, *tmp;
-
-	spin_lock(&device_domain_lock);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(info);
-	spin_unlock(&device_domain_lock);
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
