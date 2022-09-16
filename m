Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC4259D
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 07:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663312414; x=1694848414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JdPEauhVoSZUn0BhkPy6l+faBPrGg3t+hYhqeeZE5iI=;
  b=UZMMpiVrzdMhqIcIowBxJQSEPZINjX5a9QQ9E03nrpcdWgM2G49c5pcA
   T/NCwKhvEigLXf1WbprWV3PvmaR/0POivu9f4A6XAgKDmsDjZjS2H2OkF
   AHcY/LoJGdC0W9mwfPtpHtZtlyUyYHw1hZaoXMTVj/AkTtyJLv6p/RsgP
   Fvs1mWFfyd5OyNLwPOrOQ3yTuUDeY6fWzJYnSz1LiGN4Y5pEXzv64/MIN
   7a8TWX96Pd19Tdv1DKqaow8U8Hdev5lyP27QBPytFeyABiu7PvvKorMXf
   AY9vq2zAaWAONUq2L5u7u7KLHXCBnLKxUKLEeeE76BJtWcfMmsVrdtv6f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297654805"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="297654805"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 00:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="613172481"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2022 00:13:28 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com
Cc: kevin.tian@intel.com,
	baolu.lu@intel.com,
	yi.l.liu@intel.com,
	raghunathan.srinivasan@intel.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support
Date: Fri, 16 Sep 2022 00:13:26 -0700
Message-Id: <20220916071326.2223901-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This renaming better describes it is for first level page table (a.k.a
first stage page table since VT-d spec 3.4).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/cap_audit.c | 4 ++--
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/intel/iommu.h     | 2 +-
 drivers/iommu/intel/pasid.c     | 2 +-
 drivers/iommu/intel/svm.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
index 664499dddf0c..3bcff81f2890 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -399,7 +399,7 @@ static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
 {
 	unsigned long fl_sagaw, sl_sagaw;
 
-	fl_sagaw = BIT(2) | (cap_5lp_support(iommu->cap) ? BIT(3) : 0);
+	fl_sagaw = BIT(2) | (cap_fl5lp_support(iommu->cap) ? BIT(3) : 0);
 	sl_sagaw = cap_sagaw(iommu->cap);
 
 	/* Second level only. */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 74b0e19e23ee..631688efbf98 100644
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
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5e7e8b020a5..c6433a8de418 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -529,7 +529,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if ((flags & PASID_FLAG_FL5LP) && !cap_5lp_support(iommu->cap)) {
+	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
 		pr_err("No 5-level paging support for first-level on %s\n",
 		       iommu->name);
 		return -EINVAL;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8bcfb93dda56..cd8fb4e44259 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -181,7 +181,7 @@ void intel_svm_check(struct intel_iommu *iommu)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-	    !cap_5lp_support(iommu->cap)) {
+	    !cap_fl5lp_support(iommu->cap)) {
 		pr_err("%s SVM disabled, incompatible paging mode\n",
 		       iommu->name);
 		return;
-- 
2.34.1

