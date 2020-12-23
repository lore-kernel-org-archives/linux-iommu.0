Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95EAC433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 00:50:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E69C207D8
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 00:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E69C207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B54AD869EA;
	Wed, 23 Dec 2020 00:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1hc29Is1Fhz; Wed, 23 Dec 2020 00:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 51DCD869BA;
	Wed, 23 Dec 2020 00:50:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 472D1C1DA2;
	Wed, 23 Dec 2020 00:50:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D4AC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 27A0885F58
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHK4xVC0llRK for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 00:50:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 357EB85F5A
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:50:53 +0000 (UTC)
IronPort-SDR: 9LF7tnQ7KV2jLRiOWqqen6I60SIH6MO7fvDrKO+PS2ywWSzyDeBOwt6N2Iik0+tjyfiHRJKade
 HCLwPw8jo9ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="173372351"
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="173372351"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 16:50:26 -0800
IronPort-SDR: 2VngZnENosOFLL8IwtjWxLIeaXzuOn4BQbSmaeWtHmaEZnziC3JSLVTVc8nBBMp7Zs+kq41JtQ
 sjTBtBkn0NGQ==
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="397599462"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.146])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 16:50:25 -0800
From: Kyung Min Park <kyung.min.park@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 2/3] iommu/vt-d: Move capability check code to cap_audit
 files
Date: Tue, 22 Dec 2020 16:29:03 -0800
Message-Id: <20201223002904.13872-3-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223002904.13872-1-kyung.min.park@intel.com>
References: <20201223002904.13872-1-kyung.min.park@intel.com>
Cc: ravi.v.shankar@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 dwmw2@infradead.org, ricardo.neri@intel.com, kyung.min.park@intel.com,
 will@kernel.org
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

Move IOMMU capability check and sanity check code to cap_audit files.
Also implement some helper functions for sanity checks.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/cap_audit.c | 20 +++++++++
 drivers/iommu/intel/cap_audit.h | 20 +++++++++
 drivers/iommu/intel/iommu.c     | 76 +--------------------------------
 3 files changed, 42 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 4a062fc719d2..cf5326eb1d72 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -186,3 +186,23 @@ int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
 
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
index 866236581dd3..1ce1dc314950 100644
--- a/drivers/iommu/intel/cap_audit.h
+++ b/drivers/iommu/intel/cap_audit.h
@@ -103,4 +103,24 @@ enum cap_audit_type {
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
index 592cb6dd5d3a..676f6900f4dc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1846,25 +1846,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
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
@@ -5663,60 +5645,6 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
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
@@ -5970,7 +5898,7 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		int ret;
 
 		if (!dev_is_pci(dev) || dmar_disabled ||
-		    !scalable_mode_support() || !iommu_pasid_support())
+		    !scalable_mode_support() || !pasid_mode_support())
 			return false;
 
 		ret = pci_pasid_features(to_pci_dev(dev));
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
