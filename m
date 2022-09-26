Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C232F50
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198496; x=1695734496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LlA/u/VYUbmCHDKN9YVHV+hnazEB1G6k/0nGrQd6dQ=;
  b=duvkHvCXeXO1ftkf70/hvMm+hpxhK6jkqmuEvNi9SqK56TSYIAbJleuZ
   oiV9owxMS6bSblmxnku5XhPk0nt+MgFTsTzI5+q07ngx763RdwjGWicFP
   d8X/6NbsnG+L0rxkr3bN1j7cQ09Ps/TGNFJZmjlaCRB2UP/jbBepi2FIv
   j+VVNpYaqGeZijqdy9YFB0E5FJ91RrraL63cBRDPWo/1llFcV9icxSwvD
   7Bq1rN+YORbidpj2cgZbHa5EJW75I8li9HuLgKNn0DNXvmIZtFdT2WJ7n
   Iyl+SpULwn2cT53x4w9O3/6txeNtg6fM1INqOljW61ndcI6HOSI8x8Kx4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288162545"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="288162545"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525668"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525668"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support
Date: Mon, 26 Sep 2022 21:15:27 +0800
Message-Id: <20220926131529.4045281-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
References: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
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
index af17177b6d76..7410d6232cbb 100644
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

