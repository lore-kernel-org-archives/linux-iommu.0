Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAAEA8
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718580; x=1709254580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0qyjUJXtQ22gjOJkGfAodz2FNGnPAkWpKsE9lPkA68=;
  b=CftZOXJuDhic7WSvCIEHKfEaTeoB8ohr5rP8Klc3QbHJ/iadychHHswW
   GT4MmVg5NpE5cRUksbvqfTGjXe8FvOESqBH0oH04FSy3DSmWJuYjj9Xpc
   ZgznZqZCaG3etOZ8YuFvKN7+5qcQKHHkH4zi+vZLEVcRWiGZZhyzIocZt
   zqz/NsvUzKlKidMGRjfa5LXHL/Ey8/mcd8ywKPIAaJ6WYjmRs8qu71LPP
   LqMex5gZOScUunyFr3XWLHmHB+jtUd+0FdGxrrmTKiIzK3vtRJra4cTiK
   1Uh0rXaxDGkiT/gXdulg7Rgs9rSeT9HNGaLnsI0QBGYQbq2xUvQMYh1dl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397141490"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="397141490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624708997"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="624708997"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2023 16:56:12 -0800
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
Subject: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Date: Wed,  1 Mar 2023 16:59:58 -0800
Message-Id: <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global PASID allocation is under IOMMU SVA code since it is the primary
use case.  However, some architecture such as VT-d, global PASIDs are
necessary for its internal use of DMA API with PASID.

This patch introduces SVA APIs to reserve and release global PASIDs.

Link: https://lore.kernel.org/all/20230301235646.2692846-4-jacob.jun.pan@linux.intel.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 25 +++++++++++++++++++++++++
 include/linux/iommu.h     | 14 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 8c92a145e15d..cfdeafde88a9 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -149,6 +149,31 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
+{
+	int ret;
+
+	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
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
+void iommu_sva_unreserve_pasid(ioasid_t pasid)
+{
+	if (!pasid_valid(pasid))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unreserve_pasid);
+
 /*
  * I/O page fault handler for SVA
  */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 39a97bd8f04a..8ba07eb03d32 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1192,6 +1192,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
+void iommu_sva_unreserve_pasid(ioasid_t pasid);
+
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1207,6 +1210,17 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+
+static inline ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void iommu_sva_unreserve_pasid(ioasid_t pasid)
+{
+
+}
+
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.25.1

