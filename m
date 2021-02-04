Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD2BC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:53:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E1B64DE7
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E1B64DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D583486B1A;
	Thu,  4 Feb 2021 01:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sbGwYLcVom24; Thu,  4 Feb 2021 01:52:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5C0686A84;
	Thu,  4 Feb 2021 01:52:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6A77C0174;
	Thu,  4 Feb 2021 01:52:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF9CC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5556B273B5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6ydaq2XarZD for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:52:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id E1A3E27261
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:52:54 +0000 (UTC)
IronPort-SDR: YzqYNnandGQGPktWPigZiyeQaRMFOLiXs2go4dAaeRaA+2yjWNKDR91pC+xKo7L3naBamUz8Q9
 O8wCBUlpDIqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245227138"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="245227138"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 17:52:54 -0800
IronPort-SDR: l1dqz7xFeywNroOVGx5+9HAyodRmb5bnIepKNlJcwyxcJ/lBkMGusy7vJAL1FfEywPIOqkBt7L
 xoXMNtbKpEHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="406911204"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 17:52:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/7] iommu/vt-d: Move capability check code to cap_audit files
Date: Thu,  4 Feb 2021 09:43:57 +0800
Message-Id: <20210204014401.2846425-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
References: <20210204014401.2846425-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Chuck Lever <chuck.lever@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Kyung Min Park <kyung.min.park@intel.com>

Move IOMMU capability check and sanity check code to cap_audit files.
Also implement some helper functions for sanity checks.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
Link: https://lore.kernel.org/r/20210130184452.31711-1-kyung.min.park@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cap_audit.c | 20 +++++++++
 drivers/iommu/intel/cap_audit.h | 20 +++++++++
 drivers/iommu/intel/iommu.c     | 76 +--------------------------------
 3 files changed, 42 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 049bc0c76a00..b12e421a2f1a 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -183,3 +183,23 @@ int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
 
 	return -EFAULT;
 }
+
+bool intel_cap_smts_sanity(void)
+{
+	return ecap_smts(intel_iommu_ecap_sanity);
+}
+
+bool intel_cap_pasid_sanity(void)
+{
+	return ecap_pasid(intel_iommu_ecap_sanity);
+}
+
+bool intel_cap_nest_sanity(void)
+{
+	return ecap_nest(intel_iommu_ecap_sanity);
+}
+
+bool intel_cap_flts_sanity(void)
+{
+	return ecap_flts(intel_iommu_ecap_sanity);
+}
diff --git a/drivers/iommu/intel/cap_audit.h b/drivers/iommu/intel/cap_audit.h
index a6a1530441b7..74cfccae0e81 100644
--- a/drivers/iommu/intel/cap_audit.h
+++ b/drivers/iommu/intel/cap_audit.h
@@ -107,4 +107,24 @@ enum cap_audit_type {
 	CAP_AUDIT_HOTPLUG_IRQR,
 };
 
+bool intel_cap_smts_sanity(void);
+bool intel_cap_pasid_sanity(void);
+bool intel_cap_nest_sanity(void);
+bool intel_cap_flts_sanity(void);
+
+static inline bool scalable_mode_support(void)
+{
+	return (intel_iommu_sm && intel_cap_smts_sanity());
+}
+
+static inline bool pasid_mode_support(void)
+{
+	return scalable_mode_support() && intel_cap_pasid_sanity();
+}
+
+static inline bool nested_mode_support(void)
+{
+	return scalable_mode_support() && intel_cap_nest_sanity();
+}
+
 int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b948f43c6a97..ecd36e456de3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1864,25 +1864,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  */
 static bool first_level_by_default(void)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	static int first_level_support = -1;
-
-	if (likely(first_level_support != -1))
-		return first_level_support;
-
-	first_level_support = 1;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu) || !ecap_flts(iommu->ecap)) {
-			first_level_support = 0;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return first_level_support;
+	return scalable_mode_support() && intel_cap_flts_sanity();
 }
 
 static struct dmar_domain *alloc_domain(int flags)
@@ -5058,60 +5040,6 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static inline bool scalable_mode_support(void)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu)) {
-			ret = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-static inline bool iommu_pasid_support(void)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!pasid_supported(iommu)) {
-			ret = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-static inline bool nested_mode_support(void)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
-			ret = false;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
@@ -5352,7 +5280,7 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		int ret;
 
 		if (!dev_is_pci(dev) || dmar_disabled ||
-		    !scalable_mode_support() || !iommu_pasid_support())
+		    !scalable_mode_support() || !pasid_mode_support())
 			return false;
 
 		ret = pci_pasid_features(to_pci_dev(dev));
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
