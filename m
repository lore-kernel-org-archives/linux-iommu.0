Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048515EA1
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJh8NXOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697007107; x=1728543107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkJWDBRQ1jsnIIVUcbi2Qvjz1LAX/o3/l8N0hK1jUv8=;
  b=aJh8NXOj0p0958qreRBB1HMP+ui4lyIR5nRJ6M82MT0ImsEeFaU0S98d
   oJ+atrvpWzqiTu+KggnS7L1eZAbzZmbuuZiPn/Sq7MvH+fznu7jmczU29
   6VWMkGHJZRjnGmdHgRpHq7MvEI64VXaBTlgEjve8uo2jFvZalYIv7vfwt
   R++1i6WjTPnvZHGE3zCbOnJ1KusO6GNdkDEtUljmJk3baWhJGVpvjxBoP
   sUHF4VHXNAuLb2TnQyCzRTog22+u3Ksrkxyc+aGkvotNQJAa5wJptjBKe
   yz07jZhGIZcUSEqQe2g+kbxPPex0era3CEUy8q/vL3TrdQHP5Lmiz0CN1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387436963"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387436963"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824050259"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824050259"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 23:51:42 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [v6 PATCH 3/5] mm: Add structure to keep sva information
Date: Wed, 11 Oct 2023 14:51:30 +0800
Message-Id: <20231011065132.102676-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231011065132.102676-1-tina.zhang@intel.com>
References: <20231011065132.102676-1-tina.zhang@intel.com>
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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a4eab6697fe1..dc1f98e12f4b 100644
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
2.39.3

