Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34521171BA
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694523598; x=1726059598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CH0kLtQV/Lrtt2u1C1f8cD+t2SUUqoIwKlnXYe5Qiqk=;
  b=bNG97GLa5Rxvbsh0RMYwtn2PdPq0HPf8cZEvGFnhBcjObM9rjqOcp0ud
   1Tg99gMcAcNFfZpHA2Yo4Ey4zojRaKVQmzSAuo0bRJk5zGfgxgnS1GvYM
   rXpXZ/9F7lT+Vj2V4RUZ5Ycmbr4WaxTfQU953GVwWliXuB5PwO88QJivC
   UIFDHbsXUcAnuXXWjYTXs1zuElxckpQZsuC+hLU93bv4EnAiPoZepcGJL
   5ajnx/xznG4o42x4lESlCLDyi0RZ18GX99ZYkeGnNc++LPLlbQncbG2AP
   xcPLR9qNDzyTW8Ocpvwdza7/9SFSQeTXTxosJfED7q6+purirndOvJoBb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378277330"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378277330"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858799347"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858799347"
Received: from tongshi-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.255.28.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:55 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v4 4/6] mm: Add structure to keep sva information
Date: Tue, 12 Sep 2023 20:59:34 +0800
Message-Id: <20230912125936.722348-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912125936.722348-1-tina.zhang@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
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

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index db2510da28c1..b9c9f14a95cc 100644
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
index 36c5b43999e6..9f4efed85f74 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -670,6 +670,7 @@ struct mm_cid {
 #endif
 
 struct kioctx_table;
+struct iommu_mm_data;
 struct mm_struct {
 	struct {
 		/*
@@ -883,6 +884,7 @@ struct mm_struct {
 
 #ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
+		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
 		/*
-- 
2.34.1

