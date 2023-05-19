Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7D17AB1
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684528083; x=1716064083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+xmCxqgxRu8Z3wchCjq462VY+6PyTOcidcJbKWPInrY=;
  b=EqJk843jcAB71zBiYiR3KmRokq4V5MPgj48fzIexTJRaiFMitPsbahNB
   ln+QLlnHl4O/ms/qyJQtL8pvsiVD4lzXnauesT3nOY1okJl0g/2wBkx9w
   ndcts+3RTcWvQvNosF5ji1LkKkUY4QhHaU/U5cm4VREjJh9fvFa3a+pyk
   rBTfnkYRem/D34Mc7rWpulhqeJ5OgCUnGJ+uFQ3p+w2DW9KQ9gAhMAKIK
   2/io9lIX3lgfHBLM35yqe1GZFNXf3c2+6MnuwGydg/1CfZP48QoDEJipz
   fB9jX/usbj3EnnplAApSvnV0EOb+/vk+I03gA27JUpTIJyPj+vme1mhPr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="418175368"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="418175368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 13:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876967797"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876967797"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2023 13:27:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	narayan.ranganathan@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 2/4] iommu: Move global PASID allocation from SVA to core
Date: Fri, 19 May 2023 13:32:21 -0700
Message-Id: <20230519203223.2777255-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global PASID can be used beyond SVA. For example, drivers that use
Intel ENQCMD to submit work must use global PASIDs in that PASID
is stored in a per CPU MSR. When such device need to submit work
for in-kernel DMA with PASID, it must allocate PASIDs from the same
global number space to avoid conflict.

This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
Reserved PASIDs, currently only RID_PASID, are excluded from the global
PASID allocation.

It is expected that device drivers will use the allocated PASIDs to
attach to appropriate IOMMU domains for use.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v6: explicitly exclude reserved a range from SVA PASID allocation
    check mm PASID compatibility with device
v5: move PASID range check inside API so that device drivers only pass
    in struct device* (Kevin)
v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
---
 drivers/iommu/iommu-sva.c | 33 ++++++++++++++-------------------
 drivers/iommu/iommu.c     | 24 ++++++++++++++++++++++++
 include/linux/iommu.h     | 10 ++++++++++
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 9821bc44f5ac..7fe8e977d8eb 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,33 +10,33 @@
 #include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DEFINE_IDA(iommu_global_pasid_ida);
 
 /* Allocate a PASID for the mm within range (inclusive) */
-static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
 {
+	ioasid_t pasid;
 	int ret = 0;
 
-	if (min == IOMMU_PASID_INVALID ||
-	    max == IOMMU_PASID_INVALID ||
-	    min == 0 || max < min)
-		return -EINVAL;
-
 	if (!arch_pgtable_dma_compat(mm))
 		return -EBUSY;
 
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (mm_valid_pasid(mm)) {
-		if (mm->pasid < min || mm->pasid > max)
-			ret = -EOVERFLOW;
+		if (mm->pasid <= dev->iommu->max_pasids)
+			goto out;
+		dev_err(dev, "current mm PASID %d exceeds device range %d!",
+			mm->pasid, dev->iommu->max_pasids);
+		ret = -ERANGE;
 		goto out;
 	}
 
-	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < min)
+	pasid = iommu_alloc_global_pasid_dev(dev);
+	if (pasid == IOMMU_PASID_INVALID) {
+		ret = -ENOSPC;
 		goto out;
-	mm->pasid = ret;
+	}
+	mm->pasid = pasid;
 	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
@@ -63,15 +63,10 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 {
 	struct iommu_domain *domain;
 	struct iommu_sva *handle;
-	ioasid_t max_pasids;
 	int ret;
 
-	max_pasids = dev->iommu->max_pasids;
-	if (!max_pasids)
-		return ERR_PTR(-EOPNOTSUPP);
-
 	/* Allocate mm->pasid if necessary. */
-	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
+	ret = iommu_sva_alloc_pasid(mm, dev);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -216,5 +211,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (likely(!mm_valid_pasid(mm)))
 		return;
 
-	ida_free(&iommu_global_pasid_ida, mm->pasid);
+	iommu_free_global_pasid(mm->pasid);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..786cb0f3acdf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -39,6 +39,7 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+static DEFINE_IDA(iommu_global_pasid_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -3393,3 +3394,26 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
+{
+	int ret;
+	ioasid_t max;
+
+	max = dev->iommu->max_pasids;
+	ret = ida_alloc_range(&iommu_global_pasid_ida, IOMMU_FIRST_GLOBAL_PASID, max, GFP_KERNEL);
+	if (ret < 0)
+		return IOMMU_PASID_INVALID;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
+
+void iommu_free_global_pasid(ioasid_t pasid)
+{
+	if (WARN_ON(pasid == IOMMU_PASID_INVALID))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_free_global_pasid);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d8327f2b6fcc..fb4061c97d49 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -191,6 +191,7 @@ enum iommu_dev_features {
 };
 
 #define IOMMU_DEF_RID_PASID	(0U) /* Reserved for DMA w/o PASID */
+#define IOMMU_FIRST_GLOBAL_PASID	(1U) /*starting range for allocation */
 #define IOMMU_PASID_INVALID	(-1U)
 typedef unsigned int ioasid_t;
 
@@ -722,6 +723,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 struct iommu_domain *
 iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 			       unsigned int type);
+ioasid_t iommu_alloc_global_pasid_dev(struct device *dev);
+void iommu_free_global_pasid(ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1083,6 +1086,13 @@ iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 {
 	return NULL;
 }
+
+static inline ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
 /**
-- 
2.25.1

