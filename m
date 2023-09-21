Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37005239
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282729; x=1726818729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvPPNNrDP2tXqIqwpVeYqNI5pvCMrqvAU0Xuz1h8Bs8=;
  b=jfIXy3HURl+asWR+p1urWGTtRg6+BQh40lfN8ZwPi0NqCath937J3qYV
   I9HK1xv8ODvsuCX3fLb7WqtIKdX0DEV3t/tk4uIfqsx1SPNEwyxzEpsvy
   HIK8je45O8FxKlLHvHZ8dCU0N2k2WW+9v1QnE58KXvzm0y4OQW+FuvL1i
   aTZ4bdkdPtVXlL82j81GOvuO3Kw0dobCpvZ2OB8j8x5U0BU1HjSiACk8a
   LvMS9WhZ1QWvKS60Pzc1oyghAmXyFkJnwY6XTgdDuWKr8CiNVbPvvIY/m
   IhMh6tUj8cIJqAKP8s/mg9e9eUd0Zuxbm1VqCMhmd9F6XXYH2yvzTRmAl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832804"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649491"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649491"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:07 -0700
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
Subject: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for domain_alloc_user op
Date: Thu, 21 Sep 2023 00:51:22 -0700
Message-Id: <20230921075138.124099-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_alloc_user op already accepts user flags for domain allocation,
add hwpt_type and user_data support as well. This op chooses to make the
special parameters opaque to the core. This suits the current usage model
where accessing any of the IOMMU device special parameters does require
a userspace driver that matches the kernel driver. If a need for common
parameters, implemented similarly by several drivers, arises then there
is room in the design to grow a generic parameter set as well.

Define enum iommu_hwpt_type to differentiate the user parameters used by
different iommu vendor drivers in the future. For backward compatibility
and the allocations without any specified hwpt_type or user parameters,
add an IOMMU_HWPT_TYPE_DEFAULT in the list.

Also, add a struct iommu_user_data as a package of data_ptr and data_len
from an iommufd core uAPI structure, then provide a helper function for
a driver to run data length sanity and copy a defined hwpt_type specific
driver user data.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c          |  5 ++-
 drivers/iommu/iommufd/hw_pagetable.c |  4 ++-
 drivers/iommu/iommufd/selftest.c     |  5 ++-
 include/linux/iommu.h                | 51 ++++++++++++++++++++++++++--
 include/uapi/linux/iommufd.h         |  8 +++++
 5 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 491bcde1ff96..4ffc939a71f0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4075,7 +4075,10 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      enum iommu_hwpt_type hwpt_type,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 26a8a818ffa3..1d7378a6cbb3 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -96,7 +96,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
+		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+						      IOMMU_HWPT_TYPE_DEFAULT,
+						      NULL, NULL);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b54cbfb1862b..2205a552e570 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -171,7 +171,10 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags)
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       enum iommu_hwpt_type hwpt_type,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 660dc1931dc9..12e12e5563e6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <uapi/linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -227,6 +228,41 @@ struct iommu_iotlb_gather {
 	bool			queued;
 };
 
+/**
+ * struct iommu_user_data - iommu driver specific user space data info
+ * @uptr: Pointer to the user buffer for copy_from_user()
+ * @len: The length of the user buffer in bytes
+ *
+ * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
+ * Both @uptr and @len should be just copied from an iommufd core uAPI structure
+ */
+struct iommu_user_data {
+	void __user *uptr;
+	size_t len;
+};
+
+/**
+ * iommu_copy_user_data - Copy iommu driver specific user space data
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_data: Pointer to a struct iommu_user_data for user space data info
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int iommu_copy_user_data(void *dst_data,
+				       const struct iommu_user_data *src_data,
+				       size_t data_len, size_t min_len)
+{
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (src_data->len < min_len || data_len < src_data->len)
+		return -EINVAL;
+	return copy_struct_from_user(dst_data, data_len,
+				     src_data->uptr, src_data->len);
+}
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -237,11 +273,17 @@ struct iommu_iotlb_gather {
  * @domain_alloc: allocate iommu domain
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters like flags defined as enum iommufd_ioas_map_flags
+ *                     and the @hwpt_type that is defined as enum iommu_hwpt_type
  *                     in include/uapi/linux/iommufd.h. Different from the
  *                     domain_alloc op, it requires iommu driver to fully
  *                     initialize a new domain including the generic iommu_domain
- *                     struct. Upon success, a domain is returned. Upon failure,
- *                     ERR_PTR must be returned.
+ *                     struct.
+ *                     Upon success, if the @user_data is valid and the @parent
+ *                     points to a kernel-managed domain, the new domain must be
+ *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
+ *                     NULL while the @user_data can be optionally provided, the
+ *                     new domain must be IOMMU_DOMAIN_UNMANAGED type.
+ *                     Upon failure, ERR_PTR must be returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -274,7 +316,10 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
+						  enum iommu_hwpt_type hwpt_type,
+						  struct iommu_domain *parent,
+						  const struct iommu_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4a7c5c8fdbb4..3c8660fe9bb1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 };
 
+/**
+ * enum iommu_hwpt_type - IOMMU HWPT Type
+ * @IOMMU_HWPT_TYPE_DEFAULT: default
+ */
+enum iommu_hwpt_type {
+	IOMMU_HWPT_TYPE_DEFAULT,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
-- 
2.34.1

