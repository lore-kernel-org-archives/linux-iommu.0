Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56D620
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816674; x=1715352674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vk4v/ikHz47XNGzTNt9NSUfHhuFlUp40YbtiK2s2Voo=;
  b=CZmjGCwiBvtdp4F6Z+hfm4zuheTjzPhOSs3+BGmM3PAlTmDNkD85PsJV
   MtrVz+ebWyqnQQYtfXQErkc7owXtSxUcGkJGWz5XMAbvAcFiBQ6I1Uya6
   u2NjBnGZ+9FtTciiBScvWPjpwPH+flqpT31GmW8Jek111VYmpyoqE/CSb
   PiPVKKH7ZtGRlBKd8ZDwVXrRMULCB/bqaIdsu7XqOAWq1I2PEejm8XNdj
   +Ggad9FaXc/Ebo6mDVhHbw9FEY/3BPqxWMxiD+mf+XMya9E4iGMYBHUWe
   pgbrurjeMRsJ0C0DeaYzjTnEuHQY9BozIBu522dpaWBtsdm8BgxSueHAW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025428"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025428"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355151"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355151"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:13 -0700
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
Subject: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d stage-1 domain allocation
Date: Thu, 11 May 2023 07:51:01 -0700
Message-Id: <20230511145110.27707-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
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
 include/uapi/linux/iommufd.h | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 06dcad6ab082..c2658394827a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -353,9 +353,64 @@ struct iommu_vfio_ioas {
 /**
  * enum iommu_hwpt_type - IOMMU HWPT Type
  * @IOMMU_HWPT_TYPE_DEFAULT: default
+ * @IOMMU_HWPT_TYPE_VTD_S1: Intel VT-d stage-1 page table
  */
 enum iommu_hwpt_type {
 	IOMMU_HWPT_TYPE_DEFAULT,
+	IOMMU_HWPT_TYPE_VTD_S1,
+};
+
+/**
+ * enum iommu_hwpt_intel_vtd_flags - Intel VT-d stage-1 page
+ *				     table entry attributes
+ * @IOMMU_VTD_PGTBL_SRE: Supervisor request
+ * @IOMMU_VTD_PGTBL_EAFE: Extended access enable
+ * @IOMMU_VTD_PGTBL_PCD: Page-level cache disable
+ * @IOMMU_VTD_PGTBL_PWT: Page-level write through
+ * @IOMMU_VTD_PGTBL_EMTE: Extended mem type enable
+ * @IOMMU_VTD_PGTBL_CD: PASID-level cache disable
+ * @IOMMU_VTD_PGTBL_WPE: Write protect enable
+ */
+enum iommu_hwpt_intel_vtd_flags {
+	IOMMU_VTD_PGTBL_SRE = 1 << 0,
+	IOMMU_VTD_PGTBL_EAFE = 1 << 1,
+	IOMMU_VTD_PGTBL_PCD = 1 << 2,
+	IOMMU_VTD_PGTBL_PWT = 1 << 3,
+	IOMMU_VTD_PGTBL_EMTE = 1 << 4,
+	IOMMU_VTD_PGTBL_CD = 1 << 5,
+	IOMMU_VTD_PGTBL_WPE = 1 << 6,
+	IOMMU_VTD_PGTBL_LAST = 1 << 7,
+};
+
+/**
+ * struct iommu_hwpt_intel_vtd - Intel VT-d specific user-managed
+ *                               stage-1 page table info
+ * @flags: Combination of enum iommu_hwpt_intel_vtd_flags
+ * @pgtbl_addr: The base address of the user-managed stage-1 page table.
+ * @pat: Page attribute table data to compute effective memory type
+ * @emt: Extended memory type
+ * @addr_width: The address width of the untranslated addresses that are
+ *              subjected to the user-managed stage-1 page table.
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific data for creating hw_pagetable to represent
+ * the user-managed stage-1 page table that is used in nested translation.
+ *
+ * In nested translation, the stage-1 page table locates in the address
+ * space that defined by the corresponding stage-2 page table. Hence the
+ * stage-1 page table base address value should not be higher than the
+ * maximum untranslated address of stage-2 page table.
+ *
+ * The paging level of the stage-1 page table should be compatible with
+ * the hardware iommu. Otherwise, the allocation would be failed.
+ */
+struct iommu_hwpt_intel_vtd {
+	__u64 flags;
+	__u64 pgtbl_addr;
+	__u32 pat;
+	__u32 emt;
+	__u32 addr_width;
+	__u32 __reserved;
 };
 
 /**
@@ -391,6 +446,8 @@ enum iommu_hwpt_type {
  * +------------------------------+-------------------------------------+-----------+
  * | IOMMU_HWPT_TYPE_DEFAULT      |               N/A                   |    IOAS   |
  * +------------------------------+-------------------------------------+-----------+
+ * | IOMMU_HWPT_TYPE_VTD_S1       |      struct iommu_hwpt_intel_vtd    |    HWPT   |
+ * +------------------------------+-------------------------------------+-----------+
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
-- 
2.34.1

