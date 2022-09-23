Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DD15B0
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 00:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894089; x=1695430089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2H9F9xIz7YWs3e5xk2mJfS9/CmaMe/dKpZPvyRF2Q4=;
  b=RCwZhttw/Sk4v2Pqohan4CyjkXGd81w+sxHipbc5lgVo24TiAYWi5z84
   xzopfEJ+vMmqJVtqqmNfEU4GIsGDvfro02AfQodrLc9YDE+AIfq7skZqV
   8m4chrIjlW5c5IcFuRC0MhF0giTu/8dXHyO9FzMEDIO9QQ6qoZY2uZ8Mh
   B0mpY5M4RutyziUfg6UqGrpMl8X/CQu2bIqmoM8zgYujIO6CJUY4yn2IS
   Y3qpN8Y99rmCVqksAv+/nakQRYD7/+y17B+NBWnQ81ErqRFG88LlPV547
   NSd07/b69yn1D7pZmCJ73z2yJIQt37NP2JaJHhyz6BIx5NDHViWCuFZPn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278871"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278871"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650759995"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support
Date: Fri, 23 Sep 2022 08:42:04 +0800
Message-Id: <20220923004206.3630441-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

This renaming better describes it is for first level page table (a.k.a
first stage page table since VT-d spec 3.4).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220916071326.2223901-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h     | 2 +-
 drivers/iommu/intel/cap_audit.c | 4 ++--
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/intel/pasid.c     | 2 +-
 drivers/iommu/intel/svm.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8f29a183467d..99cc75ecac63 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -146,7 +146,7 @@
 /*
  * Decoding Capability Register
  */
-#define cap_5lp_support(c)	(((c) >> 60) & 1)
+#define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
 #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
 #define cap_read_drain(c)	(((c) >> 55) & 1)
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 3ee68393122f..806986696841 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -37,7 +37,7 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_MHMV_MASK);
 	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_IRO_MASK);
 
-	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, fl5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, write_drain, CAP_WD_MASK);
@@ -84,7 +84,7 @@ static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type
 		goto out;
 	}
 
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, read_drain, CAP_RD_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, write_drain, CAP_WD_MASK);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6d04ee5ea3ab..81a449b5cb91 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -404,7 +404,7 @@ static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
 {
 	unsigned long fl_sagaw, sl_sagaw;
 
-	fl_sagaw = BIT(2) | (cap_5lp_support(iommu->cap) ? BIT(3) : 0);
+	fl_sagaw = BIT(2) | (cap_fl5lp_support(iommu->cap) ? BIT(3) : 0);
 	sl_sagaw = cap_sagaw(iommu->cap);
 
 	/* Second level only. */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index ccaf32949254..c30ddac40ee5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -519,7 +519,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if ((flags & PASID_FLAG_FL5LP) && !cap_5lp_support(iommu->cap)) {
+	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
 		pr_err("No 5-level paging support for first-level on %s\n",
 		       iommu->name);
 		return -EINVAL;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d1cab931dcb0..7d08eb034f2d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,7 +164,7 @@ void intel_svm_check(struct intel_iommu *iommu)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-	    !cap_5lp_support(iommu->cap)) {
+	    !cap_fl5lp_support(iommu->cap)) {
 		pr_err("%s SVM disabled, incompatible paging mode\n",
 		       iommu->name);
 		return;
-- 
2.34.1

