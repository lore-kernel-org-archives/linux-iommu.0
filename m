Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC418014
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692353437; x=1723889437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fe5keaRRZoV2YWbVwMtrDDrbxfsPkN3V0+LTY8Uy8EQ=;
  b=c4sDd0Ur+C75kWL7rBC9sop/CmkTU5yORIA5ZWm2BemQWlQr9ye/l+Bm
   UX5C+W8NkgvP++og1QLYMB2YcVPDjz5X8F7VGl5F8vlojsLycBxEoxePH
   lnFOqm/uVDg223bcRy7aBadi+1Tl4DsXbQu59n16z6Kfx3oLyKUH5Kjl8
   uVTucqgQN6dEAk3vqiflB9BHBa6lEnkKN6wxFJuwZoL4ECQX+GPlMWw3s
   Xd8KLql2KYDQufVKSz23n8N0AvZqbaAqsPiEd2vxy6kO7YvYHQIjL83/v
   5HibhGHP3KGmiZVwiLgb+xnhhQCd4Tdouhoye9Hw3XP6PZYKVmCuACWcW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370526292"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="370526292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858624990"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="858624990"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 03:10:35 -0700
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
Subject: [PATCH v9 2/5] iommu: Add new iommu op to get iommu hardware information
Date: Fri, 18 Aug 2023 03:10:30 -0700
Message-Id: <20230818101033.4100-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818101033.4100-1-yi.l.liu@intel.com>
References: <20230818101033.4100-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu op to get the IOMMU hardware capabilities for
iommufd. This information will be used by any vIOMMU driver which is owned
by userspace.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the kernel
driver. If a need for common parameters, implemented similarly by several
drivers, arises then there's room in the design to grow a generic
parameter set as well. No wrapper API is added as it is supposed to be
used by iommufd only.

Different IOMMU hardware would have different hardware information. So the
information reported differs as well. To let the external user understand
the difference, enum iommu_hw_info_type is defined. For the iommu drivers
that are capable to report hardware information, it should have a unique
iommu_hw_info_type and return to caller. For the driver doesn't report
hardware information, caller just uses IOMMU_HW_INFO_TYPE_NONE if a type
is required.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        | 5 +++++
 include/uapi/linux/iommufd.h | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e0245aa82b75..bd6a1110b294 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,6 +228,10 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
+ * @hw_info: report iommu hardware information. The data buffer returned by this
+ *           op is allocated in the iommu driver and freed by the caller after
+ *           use. The information type is one of enum iommu_hw_info_type defined
+ *           in include/uapi/linux/iommufd.h.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
@@ -257,6 +261,7 @@ struct iommu_iotlb_gather {
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

