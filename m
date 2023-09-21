Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F95CBD
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282889; x=1726818889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+z5+5JtzJUHTDziH7GhRN2oy4j2s7kOBGRou6Rfz7PQ=;
  b=jVJC9mfbx5m/eyn4XOC0Iwp96IC9fZe2shbA0FWVaVrIHf+1oO/U/BpN
   5QTLGA6qVWLe2G4fiQnIdkSph1dpIrw25TW4Dnkzj+xARcpq5a8VWtEzn
   vn4/k7rCgumW7xzMNP9vnRfhf3ndDA5CVGy7xXVKQJJicwwOZyV4uoBAk
   G6MhZ3JjtK6mgLCxxhpNsJgUsJ04zGqI3jnSULsgidMrPjAwB82ruEddM
   +3oEfpwsbBIEarg4YOSi30j3ILZiDbLbYntsU89Hbg4hcuPd+e2l44/Ar
   SE1J65Q5ppdVBytcniKMS7iKCQUhig5qRH5jISI9facbZQ6WmxjC11o/v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764374"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764374"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523013"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523013"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:43 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v5 01/11] iommufd: Add data structure for Intel VT-d stage-1 domain allocation
Date: Thu, 21 Sep 2023 00:54:21 -0700
Message-Id: <20230921075431.125239-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds IOMMU_HWPT_TYPE_VTD_S1 for stage-1 hw_pagetable of Intel VT-d
and the corressponding data structure for userspace specified parameter
for the domain allocation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2083a0309a9b..18a502e206c3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -358,12 +358,42 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 };
 
+/**
+ * enum iommu_hwpt_vtd_s1_flags - Intel VT-d stage-1 page table
+ *                                entry attributes
+ * @IOMMU_VTD_S1_SRE: Supervisor request
+ * @IOMMU_VTD_S1_EAFE: Extended access enable
+ * @IOMMU_VTD_S1_WPE: Write protect enable
+ */
+enum iommu_hwpt_vtd_s1_flags {
+	IOMMU_VTD_S1_SRE = 1 << 0,
+	IOMMU_VTD_S1_EAFE = 1 << 1,
+	IOMMU_VTD_S1_WPE = 1 << 2,
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1 - Intel VT-d stage-1 page table
+ *                            info (IOMMU_HWPT_TYPE_VTD_S1)
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_flags
+ * @pgtbl_addr: The base address of the stage-1 page table.
+ * @addr_width: The address width of the stage-1 page table
+ * @__reserved: Must be 0
+ */
+struct iommu_hwpt_vtd_s1 {
+	__aligned_u64 flags;
+	__aligned_u64 pgtbl_addr;
+	__u32 addr_width;
+	__u32 __reserved;
+};
+
 /**
  * enum iommu_hwpt_type - IOMMU HWPT Type
  * @IOMMU_HWPT_TYPE_DEFAULT: default
+ * @IOMMU_HWPT_TYPE_VTD_S1: Intel VT-d stage-1 page table
  */
 enum iommu_hwpt_type {
 	IOMMU_HWPT_TYPE_DEFAULT,
+	IOMMU_HWPT_TYPE_VTD_S1,
 };
 
 /**
-- 
2.34.1

