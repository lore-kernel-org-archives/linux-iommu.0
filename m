Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735EC4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 04:26:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CE56054E
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 04:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2CE56054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB0AE404BB;
	Tue, 17 Aug 2021 04:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S0v8IfAjjGV7; Tue, 17 Aug 2021 04:26:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86A4A404C8;
	Tue, 17 Aug 2021 04:26:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4CEC0023;
	Tue, 17 Aug 2021 04:26:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 602A9C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66C3A83613
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4SwjQJKFgR1u for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC86883626
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215717242"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; d="scan'208";a="215717242"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 21:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; d="scan'208";a="449126352"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2021 21:26:29 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: iommu@lists.linux-foundation.org,
	baolu.lu@linux.intel.com
Subject: [PATCH v1 2/3] iommu/vt-d: Add present bit check in pasid entry setup
 helper functions
Date: Tue, 17 Aug 2021 12:24:24 +0800
Message-Id: <20210817042425.1784279-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817042425.1784279-1-yi.l.liu@intel.com>
References: <20210817042425.1784279-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: yi.y.sun@intel.com, jun.j.tian@intel.com
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

The helper functions is not capable to modify the pasid entries which
are still in use. So should have a check against present bit.

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel/pasid.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 02e10491184b..b1d0c2945c9a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -534,6 +534,10 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
+/*
+ * This function flushes cache for a newly setup pasid table entry.
+ * Caller of it should not modify the in-use pasid table entries.
+ */
 static void pasid_flush_caches(struct intel_iommu *iommu,
 				struct pasid_entry *pte,
 			       u32 pasid, u16 did)
@@ -585,6 +589,10 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	if (WARN_ON(!pte))
 		return -EINVAL;
 
+	/* Caller must ensure PASID entry is not in use. */
+	if (pasid_pte_is_present(pte))
+		return -EBUSY;
+
 	pasid_clear_entry(pte);
 
 	/* Setup the first level page table pointer: */
@@ -684,6 +692,10 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 		return -ENODEV;
 	}
 
+	/* Caller must ensure PASID entry is not in use. */
+	if (pasid_pte_is_present(pte))
+		return -EBUSY;
+
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_slptr(pte, pgd_val);
@@ -723,6 +735,10 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 		return -ENODEV;
 	}
 
+	/* Caller must ensure PASID entry is not in use. */
+	if (pasid_pte_is_present(pte))
+		return -EBUSY;
+
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
