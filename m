Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7220EC
	for <iommu@lists.linux.dev>; Sun, 27 Aug 2023 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693125866; x=1724661866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70XGMLhmcN9XLJ88A4WPccc77MlMNOgnetntb6B7rBs=;
  b=dw2PaDw2/7mOq6BR/IHkvYfjcAHrokZmGHFS//EHA888nTbshtwUkv6y
   uDkDac2dpEWmGorUkJEBFBLYleKjHehdQHVUIdn7+3FmbpUgqQ/CleHrS
   GvrKV2rmeZBVdOqnhrMA9wWP884LIgsyehRkZJmxOFNrR4+SMynbQWNnf
   WMpTFstPDnHNtwpJxQJ9iYl7a44My2BrgRSV9nQ0CeVDMdZLiHHw4bIsL
   gHp9dZhjkPvBbWpJl0jeejG/eFiI6JeroPPOeWbD1Vc4YOwEhaqrSqiTt
   jAQYP5q5KwRzjSf0QSa62n13NCyKhaI/KWHSjMDWuZKx+CEJ0Bnx7E7t8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="359919924"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="359919924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 01:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="984561811"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="984561811"
Received: from yzhu-ivm3.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.213.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 01:44:23 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 3/5] mm: Add structure to keep sva information
Date: Sun, 27 Aug 2023 16:43:59 +0800
Message-Id: <20230827084401.819852-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827084401.819852-1-tina.zhang@intel.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce iommu_mm_data structure to keep sva information (pasid and the
related sva domains). Add iommu_mm pointer, pointing to an instance of
iommu_mm_data structure, to mm.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ab8784dfdbd98..937f3abc26f2e 100644
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
index 5e74ce4a28cd6..3fd65b7537f0e 100644
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
2.34.1

