Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED45525A
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282732; x=1726818732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0P+FnWlKseFjytOLElZ5wxbsLbUiz397Z6YutC//Gc=;
  b=WD56QF/MxnGL6rQawLZbFpkpCp2yFTZnS4mWg9Ax6YTlqD14otdHbEe6
   v9mQdSE3t2pqFX935Fk7SrvIm+vU6UXGn8/ufMytofabk7LBORnvECvSz
   kt+NHRpv9StVxycW0ab5oCAw0IPZP490IP7voJnxWhFMzOV10z1vBNGnr
   X1otacDKK7IDR9pJ7N8mpe6oS8jAjYXMi33LnBJkCgIY2oOmArG0Xn6X2
   TaplLzMZ6p8aOjhOvkBC3CjXXy3eml/Dd1GZI/LmwyLNdThDV4obm2w8K
   ysDLuB9wvOlm3+eN9IZAxF7DJGdWFfKYgnWed3nrsgP0USm9NlfJArnzd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832838"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649513"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649513"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:10 -0700
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
Subject: [PATCH v4 04/17] iommufd: Pass in hwpt_type/user_data to iommufd_hw_pagetable_alloc()
Date: Thu, 21 Sep 2023 00:51:25 -0700
Message-Id: <20230921075138.124099-5-yi.l.liu@intel.com>
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

iommu core already supports accepting user_data and hwpt_type to allocate
a user iommu_domain, which allows the caller iommufd_hw_pagetable_alloc()
to accept the hwpt_type and user_data too. Thus, pass them in.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  3 ++-
 drivers/iommu/iommufd/hw_pagetable.c    | 17 ++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e88fa73a45e6..e04900f101f1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -540,7 +540,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  0, immediate_attach);
+					  0, IOMMU_HWPT_TYPE_DEFAULT,
+					  NULL, immediate_attach);
 	if (IS_ERR(hwpt)) {
 		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 1d7378a6cbb3..554a9c3d740f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -62,6 +62,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
  * @flags: Flags from userspace
+ * @hwpt_type: Requested type of hw_pagetable
+ * @user_data: Optional user_data pointer
  * @immediate_attach: True if idev should be attached to the hwpt
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
@@ -75,6 +77,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, u32 flags,
+			   enum iommu_hwpt_type hwpt_type,
+			   struct iommu_user_data *user_data,
 			   bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
@@ -86,6 +90,11 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (user_data && hwpt_type == IOMMU_HWPT_TYPE_DEFAULT)
+		return ERR_PTR(-EINVAL);
+	if (user_data && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -97,8 +106,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
-						      IOMMU_HWPT_TYPE_DEFAULT,
-						      NULL, NULL);
+						      hwpt_type, NULL,
+						      user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -174,7 +183,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 
 	mutex_lock(&ioas->mutex);
 	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas,
-					  idev, cmd->flags, false);
+					  idev, cmd->flags,
+					  IOMMU_HWPT_TYPE_DEFAULT,
+					  NULL, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 947a797536e3..1d3b1a74e854 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -13,6 +13,7 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct iommu_user_data;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -248,6 +249,8 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, u32 flags,
+			   enum iommu_hwpt_type hwpt_type,
+			   struct iommu_user_data *user_data,
 			   bool immediate_attach);
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-- 
2.34.1

