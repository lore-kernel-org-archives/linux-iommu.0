Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75851D2D0
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815434; x=1715351434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrDK8GkK0LqwlZMb1ilRfBE7tsHA7HCzaP978cfWRvc=;
  b=HQLNb6hl55wexpZiudr8UpqwudbNqLypLQvzdJ2HY/zlQXQ6QkrXo7c9
   /+AwT2fCI+k4pl7kzuu3zafTr+cjPbomfZDi5Vx49IFOD+pQPxNQnZD6j
   LjY3qYZaSd+/JzgB/HZUdC7nQkFwpzFFh5DFEW+6rBBvS2n8Pz6GvajuP
   C91nfSkRdLSwQQATJ87jsAFH8UWVm99nrIVexk2SXLQofCP5StTPkjyzs
   UnuQdHwbjEwYgAVz7X5aznx0C3q/orHyre4igKNM9Ek16YNHbRDF46vDY
   35UMFY+Zcc3C/+NKzYipncFNVlXD5j3KZ+WUs1mV6H1+4eBz04yIw7rXB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378639872"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378639872"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874004429"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="874004429"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2023 07:30:29 -0700
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
Subject: [PATCH v3 2/4] iommu: Add new iommu op to get iommu hardware information
Date: Thu, 11 May 2023 07:30:22 -0700
Message-Id: <20230511143024.19542-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143024.19542-1-yi.l.liu@intel.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
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
iommu_hw_info_type. The iommu_hw_info_type is stored in struct iommu_ops.
For the driver doesn't report hardware information, just use
IOMMU_HW_INFO_TYPE_NONE.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        | 16 ++++++++++++++++
 include/uapi/linux/iommufd.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e7d70548e597..a748d60206e7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <uapi/linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -222,6 +223,11 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
+ * @hw_info: IOMMU hardware information. The type of the returned data is
+ *           marked by @hw_info_type. The data buffer returned by this op
+ *           is allocated in the IOMMU driver and the caller should free it
+ *           after use. Return the data buffer if success, or ERR_PTR on
+ *           failure.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
@@ -246,11 +252,20 @@ struct iommu_iotlb_gather {
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @hw_info_type: One of enum iommu_hw_info_type defined in
+ *                include/uapi/linux/iommufd.h. It is used to tag the type
+ *                of data returned by .hw_info callback. The drivers that
+ *                support .hw_info callback should define a unique type
+ *                in include/uapi/linux/iommufd.h. For the drivers that do
+ *                not implement .hw_info callback, this field is
+ *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, such drivers
+ *                do not need to care this field.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
+	void *(*hw_info)(struct device *dev, u32 *length);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
@@ -279,6 +294,7 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
+	enum iommu_hw_info_type hw_info_type;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8245c01adca6..99bf0715f545 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -370,4 +370,11 @@ struct iommu_hwpt_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
+
+/**
+ * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ */
+enum iommu_hw_info_type {
+	IOMMU_HW_INFO_TYPE_NONE,
+};
 #endif
-- 
2.34.1

