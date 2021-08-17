Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C331DC432BE
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 04:26:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A60A60F38
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 04:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A60A60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 494B740256;
	Tue, 17 Aug 2021 04:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLsm_yw1CANE; Tue, 17 Aug 2021 04:26:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04A28402C9;
	Tue, 17 Aug 2021 04:26:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3927C0010;
	Tue, 17 Aug 2021 04:26:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66B9DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D77E835FB
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6_MTOBhtsDun for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFE8B83638
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215717244"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; d="scan'208";a="215717244"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 21:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; d="scan'208";a="449126360"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2021 21:26:31 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: iommu@lists.linux-foundation.org,
	baolu.lu@linux.intel.com
Subject: [PATCH v1 3/3] iommu/vt-d: Fix Unexpected page request in Privilege
 Mode
Date: Tue, 17 Aug 2021 12:24:25 +0800
Message-Id: <20210817042425.1784279-4-yi.l.liu@intel.com>
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

This patch fixes the below error. This is due to improper iotlb invalidation
in intel_pasid_tear_down_entry().

[  180.187556] Unexpected page request in Privilege Mode
[  180.187565] Unexpected page request in Privilege Mode
[  180.279933] Unexpected page request in Privilege Mode
[  180.279937] Unexpected page request in Privilege Mode

Per chapter 6.5.3.3 of VT-d spec 3.3, when tear down a pasid entry, software
should use Domain selective IOTLB flush if the PGTT of the pasid entry is
SL only or Nested, while for the pasid entries whose PGTT is FL only or PT
using PASID-based IOTLB flush is enough.

Fixes: 1c4f88b7f1f9 ("iommu/vt-d: Shared virtual address in scalable mode")
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Kumar Sanjay K <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Tested-by: Yi Sun <yi.y.sun@intel.com>
---
 drivers/iommu/intel/pasid.c | 10 ++++++++--
 drivers/iommu/intel/pasid.h |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b1d0c2945c9a..07c390aed1fe 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -511,7 +511,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 				 u32 pasid, bool fault_ignore)
 {
 	struct pasid_entry *pte;
-	u16 did;
+	u16 did, pgtt;
 
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (WARN_ON(!pte))
@@ -521,13 +521,19 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		return;
 
 	did = pasid_get_domain_id(pte);
+	pgtt = pasid_pte_get_pgtt(pte);
+
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
 
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+
+	if (pgtt == PASID_ENTRY_PGTT_PT || pgtt == PASID_ENTRY_PGTT_FL_ONLY)
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+	else
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 5ff61c3d401f..637141d71092 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -99,6 +99,11 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
 }
 
+static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
+{
+	return (READ_ONCE(pte->val[0]) >> 6) & 0x7;
+}
+
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
