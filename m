Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF4211F
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691481003; x=1723017003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lp2BCntolGG4mTS6F0ktq7rcph+RoXn5XygwILHKL8k=;
  b=b+OcLxLyYKmn8HZhmcdZMurUZgysFe6LsZ/DKEvKUEgPUmMc4peRZchu
   hcUk/tw5kzEnURHzJy0jhLwOUmunA1mBXXtG/96fCVQXtSK4LMEfYzK5S
   zEz7NIm/o8sS9hSc+0x+lv+zlLaLWJeZIRwzkofws4tFhr1OZ2EBqr1FC
   +Y9jddeA+SrZB8o8BXVEwJczJylZMkEVBCP5iYE7h8bTDd++0RzoKfRlc
   LZJSWWAg0cU8XqBQE8DH1BREOa+Rq7qeom3EMmqPKdabu4m9oUgBMC5XN
   7Xzmu0HGaeFF0O8pYKQh1+bycVeSrcotpkF9qZJM99SKUvBkpuGR/QCNX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078682"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078682"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146338"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146338"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:50:00 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 3/5] mm: Add structure to keep sva information
Date: Tue,  8 Aug 2023 15:49:42 +0800
Message-Id: <20230808074944.7825-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Introduce iommu_mm_data structure to keep sva information (pasid and the
related sva domains). Add iommu_mm pointer, pointing to an instance of
iommu_mm_data structure, to mm.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 30e4d1ca39b5..435d1c1afd23 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -670,6 +670,11 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
+struct iommu_mm_data {
+	u32			pasid;
+	struct list_head	sva_domains;
+};
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..3fd65b7537f0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -595,6 +595,7 @@ struct mm_cid {
 #endif
 
 struct kioctx_table;
+struct iommu_mm_data;
 struct mm_struct {
 	struct {
 		/*
@@ -808,6 +809,7 @@ struct mm_struct {
 
 #ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
+		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
 		/*
-- 
2.17.1

