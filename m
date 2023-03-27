Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E92CA2
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 23:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959060; x=1711495060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxhHJiwAc4IjPHQUnpcm01kWFsDqXPFpSF6ZqTd6+oU=;
  b=ExiSWJwBk6zr5ZTL9XQ8mF11T5na3B7NghNJZ39FpdC9gfW7u6UAZwoq
   I4arwZdd+rjs+e+uMWVFtjP4A9zXm/5L0lrs7l/KFwF2bT0yq/jbbKhJc
   EXggkQGEiaazI5YGowhOLW1GwohN2NFQkqxzICs3kgCyW6Hgop3Dpmty9
   eM4sup2orxhgZMhj6JKlNhienshH0GE5bD2/wTd8io5htlmKtEjaSbz7p
   Au3WCov1tc4DuJAR+ztrhpprAI1Xiag1E6gtuWDoa79B3xb0H3Y2rHPyz
   MpX0blRpJmKtQtmn8zw8GK5z3brekQp2nZ2wK+SM6Drscd/m53mNQLCXQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320817310"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320817310"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686144724"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686144724"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 16:17:38 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA PASIDs
Date: Mon, 27 Mar 2023 16:21:33 -0700
Message-Id: <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that use Intel ENQCMD to submit work must use global PASIDs in
that the PASID are stored in a per CPU MSR. When such device need to
submit work for in-kernel DMA with PASID, it must allocate PASIDs from
the same global number space to avoid conflict.

This patch introduces IOMMU SVA APIs to reserve and release global PASIDs.
It is expected that device drivers will use the allocated PASIDs to attach
to appropriate IOMMU domains for use.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/iommu.h     | 14 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c434b95dc8eb..84b9de84b3e0 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -148,6 +148,39 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+/**
+ * @brief
+ *	Reserve a PASID from the SVA global number space.
+ *
+ * @param min starting range, inclusive
+ * @param max ending range, inclusive
+ * @return The reserved PASID on success or IOMMU_PASID_INVALID on failure.
+ */
+ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
+{
+	int ret;
+
+	if (!pasid_valid(min) || !pasid_valid(max) ||
+	    min == 0 || max < min)
+		return IOMMU_PASID_INVALID;
+
+	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return IOMMU_PASID_INVALID;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
+
+void iommu_sva_release_pasid(ioasid_t pasid)
+{
+	if (!pasid_valid(pasid))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_release_pasid);
+
 /*
  * I/O page fault handler for SVA
  */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54f535ff9868..0471089dc1d0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1187,6 +1187,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
+void iommu_sva_release_pasid(ioasid_t pasid);
+
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1202,6 +1205,17 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+
+static inline ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void iommu_sva_release_pasid(ioasid_t pasid)
+{
+
+}
+
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
-- 
2.25.1

