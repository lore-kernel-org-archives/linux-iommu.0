Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D02F44
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUTZnQFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295191; x=1729831191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGpQoHBpgo+OtwHOFnMkEmlWaRuCkfvoPjSEMKpnnvY=;
  b=ZUTZnQFexo3MdbJSB9MbB7YPEkyE/ZA1ivlh863GJknxpezZDHQWURVS
   2DEnt1jgNbGBtSznUh/RPnnpTwjlkc96MKoBobwpQ/Pd23zYvt8BSNv13
   mG4kyEgX/OYtyatYvmqz1UO/KzdOXUt45xAEb1svsUJLsNFBchJjjYAdz
   O1f6ByJvP7QjXk3fe9TPbQvVuR0rpYLgzGwtB+vPgSPjqj8YM8jYFG0TG
   NM4Tr82NhgRHxCuLTusMlhV/iM5jaa/OTk8U+4WOZTO71vMnjhhKOtVXY
   Bjg19k2QegRD58KJcVeKXtOwdOPgF6oQtJo1o/Y3PNMQMLu9zRlqPcvfp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014495"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931321"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931321"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:45 -0700
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v7 06/10] iommu: Pass in parent domain with user_data to domain_alloc_user op
Date: Wed, 25 Oct 2023 21:39:34 -0700
Message-Id: <20231026043938.63898-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026043938.63898-1-yi.l.liu@intel.com>
References: <20231026043938.63898-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_alloc_user op already accepts user flags for domain allocation, add
a parent domain pointer and a driver specific user data support as well.
The user data would be tagged with a type for iommu drivers to add their
own driver specific user data per hw_pagetable.

Add a struct iommu_user_data as a bundle of data_ptr/data_len/type from an
iommufd core uAPI structure. Make the user data opaque to the core, since
a userspace driver must match the kernel driver. In the future, if drivers
share some common parameter, there would be a generic parameter as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c            |  9 ++++++---
 drivers/iommu/intel/iommu.c          |  7 ++++++-
 drivers/iommu/iommufd/hw_pagetable.c |  3 ++-
 drivers/iommu/iommufd/selftest.c     |  7 ++++++-
 include/linux/iommu.h                | 27 ++++++++++++++++++++++++---
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index caad10f9cee3..b399c5741378 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2219,12 +2219,15 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }
 
-static struct iommu_domain *amd_iommu_domain_alloc_user(struct device *dev,
-							u32 flags)
+static struct iommu_domain *
+amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			    struct iommu_domain *parent,
+			    const struct iommu_user_data *user_data)
+
 {
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
 
-	if (flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	return do_iommu_domain_alloc(type, dev, flags);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eb92a201cc0b..fe67f8d77b09 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4076,7 +4076,9 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
@@ -4086,6 +4088,9 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (parent || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6bce9af0cb8d..198ecbd536f7 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -108,7 +108,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt_paging->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
+		hwpt->domain =
+			ops->domain_alloc_user(idev->dev, flags, NULL, NULL);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 068928ba7950..d71007234896 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -241,7 +241,9 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags)
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
 {
 	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 	struct iommu_domain *domain;
@@ -250,6 +252,9 @@ mock_domain_alloc_user(struct device *dev, u32 flags)
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (parent || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 	    (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bc303cb2af37..2ddd99f55471 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -265,6 +265,21 @@ struct iommu_dirty_ops {
 				    struct iommu_dirty_bitmap *dirty);
 };
 
+/**
+ * struct iommu_user_data - iommu driver specific user space data info
+ * @type: The data type of the user buffer
+ * @uptr: Pointer to the user buffer for copy_from_user()
+ * @len: The length of the user buffer in bytes
+ *
+ * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
+ * @type, @uptr and @len should be just copied from an iommufd core uAPI struct.
+ */
+struct iommu_user_data {
+	unsigned int type;
+	void __user *uptr;
+	size_t len;
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -279,8 +294,12 @@ struct iommu_dirty_ops {
  *                     parameters as defined in include/uapi/linux/iommufd.h.
  *                     Unlike @domain_alloc, it is called only by IOMMUFD and
  *                     must fully initialize the new domain before return.
- *                     Upon success, a domain is returned. Upon failure,
- *                     ERR_PTR must be returned.
+ *                     Upon success, if the @user_data is valid and the @parent
+ *                     points to a kernel-managed domain, the new domain must be
+ *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
+ *                     NULL while the @user_data can be optionally provided, the
+ *                     new domain must support __IOMMU_DOMAIN_PAGING.
+ *                     Upon failure, ERR_PTR must be returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -313,7 +332,9 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
+	struct iommu_domain *(*domain_alloc_user)(
+		struct device *dev, u32 flags, struct iommu_domain *parent,
+		const struct iommu_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.34.1

