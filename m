Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A2AC4320A
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 12:46:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF4160EE4
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 12:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BF4160EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D822607F2;
	Tue, 17 Aug 2021 12:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZhWDTqrvqaEW; Tue, 17 Aug 2021 12:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DEBDD60684;
	Tue, 17 Aug 2021 12:46:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2291C001A;
	Tue, 17 Aug 2021 12:46:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3AD7C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 12:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D43CD40531
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 12:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uf_mStlH79ac for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 12:46:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F22394052A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 12:46:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195655134"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; d="scan'208";a="195655134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 05:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; d="scan'208";a="462385542"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 17 Aug 2021 05:46:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/vt-d: Fix incomplete cache flush in
 intel_pasid_tear_down_entry()
Date: Tue, 17 Aug 2021 20:43:21 +0800
Message-Id: <20210817124321.1517985-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817124321.1517985-1-baolu.lu@linux.intel.com>
References: <20210817124321.1517985-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Kumar Sanjay K <sanjay.k.kumar@intel.com>, iommu@lists.linux-foundation.org,
 Yi Sun <yi.y.sun@intel.com>
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

From: Liu Yi L <yi.l.liu@intel.com>

This fixes improper iotlb invalidation in intel_pasid_tear_down_entry().
When a PASID was used as nested mode, released and reused, the following
error message will appear:

[  180.187556] Unexpected page request in Privilege Mode
[  180.187565] Unexpected page request in Privilege Mode
[  180.279933] Unexpected page request in Privilege Mode
[  180.279937] Unexpected page request in Privilege Mode

Per chapter 6.5.3.3 of VT-d spec 3.3, when tear down a pasid entry, the
software should use Domain selective IOTLB flush if the PGTT of the pasid
entry is SL only or Nested, while for the pasid entries whose PGTT is FL
only or PT using PASID-based IOTLB flush is enough.

Fixes: 2cd1311a26673 ("iommu/vt-d: Add set domain DOMAIN_ATTR_NESTING attr")
Signed-off-by: Kumar Sanjay K <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Tested-by: Yi Sun <yi.y.sun@intel.com>
Link: https://lore.kernel.org/r/20210817042425.1784279-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  6 ++++++
 drivers/iommu/intel/pasid.c | 10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 5ff61c3d401f..c11bc8b833b8 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -99,6 +99,12 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
 }
 
+/* Get PGTT field of a PASID table entry */
+static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
+{
+	return (u16)((READ_ONCE(pte->val[0]) >> 6) & 0x7);
+}
+
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c6cf44a6c923..9ec374e17469 100644
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
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
