Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF27100B9
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691508929; x=1723044929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxfubDWI2gwfOBW2/jdEN8IlvwFA21yaOXGd5zVExW0=;
  b=Huj1lb4lK6H7yZussazsHe6hz4H/oGtzqLkIPma75twvKp3Ljh5tNeQ7
   kTL0WwVy8N6KFwz/qwVFJCDhHPmpt86XgES6p0cS/QhNUxww4/ejR6Jhr
   yekKGiJiSxTJLqLc06Y796FyydmbtodchmknEJbTGuNUE/mMKRzoPGQp1
   jZc8rSJBy4/mHaIfsHgYbOh0Mg5ieVtvSjicHjRRcONylrrhWttgZv0Nd
   vEwVWR+Yc0W4LnDus1Ss69JRpyOxAlNrJ46ProCJh1Qx30+6Z4OqiuapO
   3wCbAhIolvv9++i29WKEF0kdo0Pfa8Tc8ER7H0IUno0b4JITHHyWqxM2i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350449301"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="350449301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855126974"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="855126974"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2023 08:35:13 -0700
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
Subject: [PATCH v6 2/4] iommu: Add new iommu op to get iommu hardware information
Date: Tue,  8 Aug 2023 08:35:08 -0700
Message-Id: <20230808153510.4170-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808153510.4170-1-yi.l.liu@intel.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu op to get the IOMMU hardware capabilities for
iommufd. This information will be used by any vIOMMU driver which is
owned by userspace.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the kernel
driver. If a need for common parameters, implemented similarly by several
drivers, arises then there's room in the design to grow a generic parameter
set as well. No wrapper API is added as it is supposed to be used by
iommufd only.

Different IOMMU hardware would have different hardware information. So the
information reported differs as well. To let the external user understand
the difference. enum iommu_hw_info_type is defined. For the iommu drivers
that are capable to report hardware information, it should have a unique
iommu_hw_info_type and return to caller. For the driver doesn't report
hardware information, caller just uses IOMMU_HW_INFO_TYPE_NONE if a type
is required.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        | 9 +++++++++
 include/uapi/linux/iommufd.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e0245aa82b75..f2d6a3989713 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,6 +228,14 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
+ * @hw_info: IOMMU hardware information. The type of the returned data is
+ *           marked by the output type of this op. Type is one of
+ *           enum iommu_hw_info_type defined in include/uapi/linux/iommufd.h.
+ *           The drivers that support this op should define a unique type
+ *           in include/uapi/linux/iommufd.h. The data buffer returned by this
+ *           op is allocated in the IOMMU driver and the caller should free it
+ *           after use. Return the data buffer if success, or ERR_PTR on
+ *           failure.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
@@ -257,6 +265,7 @@ struct iommu_iotlb_gather {
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
+	void *(*hw_info)(struct device *dev, u32 *length, u32 *type);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8245c01adca6..ac11ace21edb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -370,4 +370,13 @@ struct iommu_hwpt_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
+
+/**
+ * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
+ *                           info
+ */
+enum iommu_hw_info_type {
+	IOMMU_HW_INFO_TYPE_NONE,
+};
 #endif
-- 
2.34.1

