Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A2107B8
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676591775; x=1708127775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OWhEULRO1wVKl8duRdQp1+gAv/eCywyZm4Oew0/Dexo=;
  b=Y1P94gcdbdr05esR6CW4zVfNS2d0kfqb+y8sZCYwpwR5szVkxHqrQRUj
   hS0YihtiKAQR9EizVRUHksHssJMlxTf3i2Z8uKEhp35spXfiwuzGqJ2KF
   gUxTW+haHM555V6fHUI8DwjAqvIcUwJ2m0w/uBKA0xaTtqTZkC7kTiiPR
   cvuX1/9TFIRud19w7KDMwCrLu9KJmgecZcIlbbMQDvd20oJLo5YhToJl3
   I5Zp98rlg1unj1RdviZW3QmVIDZDR9sWHdU4dSRRpodEEv8Zckta+YtTQ
   9PArubrLImJdcSCmg34DA5BZktxNlbXZD6ctGRVAG8duyVJpFzgZsJWGV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394342806"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="394342806"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 15:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779584641"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="779584641"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2023 15:56:13 -0800
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
Subject: [PATCH v3 3/5] iommu/sva: Stop using ioasid_set for SVA
Date: Thu, 16 Feb 2023 15:59:49 -0800
Message-Id: <20230216235951.3573059-4-jacob.jun.pan@linux.intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Instead SVA drivers can use a simple global IDA to allocate PASIDs for
each mm_struct.

Future work would be to allow drivers using the SVA APIs to reserve global
PASIDs from this IDA for their internal use, eg with the DMA API PASID
support.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 62 ++++++++++-----------------------------
 drivers/iommu/iommu-sva.h |  3 --
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index a3ee258936f0..17821ad5bf9b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,26 +9,13 @@
 #include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DECLARE_IOASID_SET(iommu_sva_pasid);
+static DEFINE_IDA(iommu_global_pasid_ida);
 
-/**
- * iommu_sva_alloc_pasid - Allocate a PASID for the mm
- * @mm: the mm
- * @min: minimum PASID value (inclusive)
- * @max: maximum PASID value (inclusive)
- *
- * Try to allocate a PASID for this mm, or take a reference to the existing one
- * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid and will be available for the lifetime of the mm.
- *
- * Returns 0 on success and < 0 on error.
- */
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
-	int ret = 0;
-	ioasid_t pasid;
+	int ret;
 
-	if (min == INVALID_IOASID || max == INVALID_IOASID ||
+	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
 	    min == 0 || max < min)
 		return -EINVAL;
 
@@ -37,39 +24,20 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (pasid_valid(mm->pasid)) {
 		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
+		else
+			ret = 0;
 		goto out;
 	}
 
-	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
-		ret = -ENOMEM;
-	else
-		mm_pasid_set(mm, pasid);
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+	if (ret < min)
+		goto out;
+	mm_pasid_set(mm, ret);
+	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
-
-/* ioasid_find getter() requires a void * argument */
-static bool __mmget_not_zero(void *mm)
-{
-	return mmget_not_zero(mm);
-}
-
-/**
- * iommu_sva_find() - Find mm associated to the given PASID
- * @pasid: Process Address Space ID assigned to the mm
- *
- * On success a reference to the mm is taken, and must be released with mmput().
- *
- * Returns the mm corresponding to this PASID, or an error if not found.
- */
-struct mm_struct *iommu_sva_find(ioasid_t pasid)
-{
-	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_find);
 
 void mm_pasid_init(struct mm_struct *mm)
 {
@@ -84,10 +52,10 @@ void mm_pasid_set(struct mm_struct *mm, u32 pasid)
 
 void mm_pasid_drop(struct mm_struct *mm)
 {
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
+	if (likely(!pasid_valid(mm->pasid)))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, mm->pasid);
 }
 
 /**
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 7215a761b962..c22d0174ad61 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -8,9 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
-
 /* I/O Page fault */
 struct device;
 struct iommu_fault;
-- 
2.25.1

