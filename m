Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB3BD3F
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676591774; x=1708127774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTjH8sjCWG8ibJ5uW/TsS619qIGDKnMfps4jWoiMNBE=;
  b=VE8ANlBVlYaB4cgr4PFcKA/nPVlPGDptZnAR7x3D9Ppc6hD3NDS67snB
   gLhDdrcSPTYSwQGKYm4P53ltP3QmuMW4GcDJtPk1Db+zrDlFI0zFqnUZz
   3IVl4CnWC8ZiJe5YqFBcyM5Tx/q1yxc5Y2dgg6+jV94VBnDTmrO9leAaM
   3QpM9aJoxKk0eHYa7AecVtT0KNYhQTvh6kvIgFo1sE8n2ql8fYdkgmXyx
   6gCfEKPxQRKUb/zyCsOJJDyRXJjxCmE976PQN1y1HdPUp7hJR5CKLGari
   qVGKniIE3SyaJSfW+3qfMLC/5sfPgU/CK19D4H5aOCOzpbZl65UdPSXG7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394342792"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="394342792"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 15:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779584632"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="779584632"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2023 15:56:12 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	X86 Kernel <x86@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 2/5] iommu/sva: Move PASID helpers to sva code
Date: Thu, 16 Feb 2023 15:59:48 -0800
Message-Id: <20230216235951.3573059-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing to remove IOASID infrastructure, PASID management will be
under SVA code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
 include/linux/sched/mm.h  | 22 +++-------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..a3ee258936f0 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -71,6 +71,25 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
 
+void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+
+/* Associate a PASID with an mm_struct: */
+void mm_pasid_set(struct mm_struct *mm, u32 pasid)
+{
+	mm->pasid = pasid;
+}
+
+void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_free(mm->pasid);
+		mm->pasid = INVALID_IOASID;
+	}
+}
+
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..c488c7241102 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,6 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -452,24 +451,9 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 #endif
 
 #ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = INVALID_IOASID;
-}
-
-/* Associate a PASID with an mm_struct: */
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
-{
-	mm->pasid = pasid;
-}
-
-static inline void mm_pasid_drop(struct mm_struct *mm)
-{
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
-}
+void mm_pasid_init(struct mm_struct *mm);
+void mm_pasid_set(struct mm_struct *mm, u32 pasid);
+void mm_pasid_drop(struct mm_struct *mm);
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
-- 
2.25.1

