Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79A627
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916208; x=1707452208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yLfWIPfMZf4ex+xdPNvOR4QIAocyXgXzIiZTA67s30A=;
  b=Pi9xs+rZbc/Qd9yPRWaWD9sTr6RsSwgNVK1gUn5i6UaXw8ob3Cgp0zKz
   5HgFBRLmwAlg/Cx1lLECRpyX9Pt+UhwfAvuhdWixI3z88iO5/gbn4Qtdr
   0sOUaVi+WxXVe2PfzrbwioBcS3FPGhVOmrxqUCMWfn6//OcfvisvAuM5G
   V874k3/ev6iTSMu3bAJzlo1W70eY9LDURzd8LrFbwCgGkotEKpMMRKKMw
   0vOR4uV1P4lnLus4s6oZp5JgjQDkud9DX3k3yPcrsqdhpH94fiocL9cWx
   eWo247leILR4oUW6SZ3z8nSBrSTCrBCn4LCWQ/x1R5cGcxPymRlQHcp4g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600706"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982084"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982084"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:45 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware information
Date: Wed,  8 Feb 2023 20:16:37 -0800
Message-Id: <20230209041642.9346-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu op get the IOMMU hardware capabilities for iommufd.
This information will be used by any vIOMMU driver which is owned by
userspace.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the kernel
driver. If a need for common parameters, implemented similarly by several
drivers, arises then there is room in the design to grow a generic parameter
set as well. No warpper API is added as it is supposed to be used by
iommufd only.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h        | 8 ++++++++
 include/uapi/linux/iommufd.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cb586d054c57..97b398d19fd2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/ioasid.h>
 #include <uapi/linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
+ * @hw_info: IOMMU hardware capabilities. The type of the returned data is
+ *           defined in include/uapi/linux/iommufd.h. The data buffer is
+ *           allocated in the IOMMU driver and the caller should free it
+ *           after use. Return the data buffer if success, or ERR_PTR on
+ *	      failure.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
@@ -252,6 +258,7 @@ struct iommu_iotlb_gather {
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
+	void *(*hw_info)(struct device *dev, u32 *length);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
@@ -280,6 +287,7 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
+	enum iommu_device_data_type driver_type;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 98ebba80cfa1..2309edb55028 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -344,4 +344,10 @@ struct iommu_vfio_ioas {
 	__u16 __reserved;
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
+
+/**
+ * enum iommu_device_data_type - IOMMU hardware Data types
+ */
+enum iommu_device_data_type {
+};
 #endif
-- 
2.34.1

