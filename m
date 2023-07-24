Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECA5396
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197220; x=1721733220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbYmkqlWfiZyr5V+MfSLsZH2Swvwd5lpXr1iZWBr3EE=;
  b=MSvp9e2sN848cFYttNBtWZ1Fi6GLG4epnQUZoh7sRVgdjL3ncRatX7Xf
   R2+/sBmeSNsAx19ehSLt8JMs0LhMaqXV64UFN/7qz5+X2woWv/LKpR46P
   53V0BhftSv9FhrDVgbPinADsux7BHg7R2DAqSpUSjZXD9oEb6xlnyjj/5
   LKS4Cr2zUKlF+cZGkBtK4jR6mYZ8/yEkPCeOZDuopGnAnQEhGCeiNEUB9
   HHKwrA6Yot3vUxRFROndjtzaZRl/xuIDANMgpH5GAqFmafmuGcz659J/3
   I3Zmw5+n/M0XI3STqyEKEBlXrIS2Rttp5yPGGjWoCgz5DWFKsreQT8d0G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347014923"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347014923"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415485"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415485"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:38 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v4 01/12] iommufd: Add data structure for Intel VT-d stage-1 domain allocation
Date: Mon, 24 Jul 2023 04:13:23 -0700
Message-Id: <20230724111335.107427-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
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
 include/uapi/linux/iommufd.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ede822e5acbb..90b0d3f603a7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -351,12 +351,45 @@ struct iommu_vfio_ioas {
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
 
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
+ * struct iommu_hwpt_vtd_s1 - Intel VT-d specific user-managed stage-1
+ *                            page table info (IOMMU_HWPT_TYPE_VTD_S1)
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_flags
+ * @pgtbl_addr: The base address of the stage-1 page table.
+ * @addr_width: The address width of the stage-1 page table
+ * @__reserved: Must be 0
+ *
+ * VT-d specific data for creating a stage-1 page table that is used
+ * in nested translation.
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

