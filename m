Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1A13FED
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0a5ITJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160197; x=1729696197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=37BvLwwRACjyNHJ7JoZu+0CeXs+e2+FlLHXXOtygDGg=;
  b=J0a5ITJFsqXhu9yhY1T93j2Cp1IF8vV4SwvbkTNKnPOiZCVWKGTEf7Xn
   LaA96vCLvFDP/T/YOL3suJuiMyJE9P9z89D01dSA8h9mbzwAzLLWPG1+d
   2VRkIF6l8m7sVf+y6mREgFAhIb85SIF/3jjSIqeIf/C4qB4mtHt6Y5xpd
   cdNpad/ZNnB259MQR3fdCxLk1Tr0Lh78FmrfjXhpx8G+wOVBvWpLVfJ2X
   aoDglNZtsZNFE65jFe2ogynLKYMNZSpf4wLQgNqg+bsJchLiqZ56uKiGB
   IrnwWiKPNxSW7AQqgyj6KVfgqtKxFvbZVW1v4PeKwp/fodArkfqrJSN0r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418203035"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418203035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486181"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:21 -0700
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
Subject: [PATCH v6 06/10] iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
Date: Tue, 24 Oct 2023 08:06:05 -0700
Message-Id: <20231024150609.46884-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Allow iommufd_hwpt_alloc() to have a common routine but jump to different
allocators corresponding to different user input pt_obj types, either an
IOMMUFD_OBJ_IOAS for a PAGING hwpt or an IOMMUFD_OBJ_HWPT_PAGING as the
parent for a NESTED hwpt.

Also, move the "flags" validation to the hwpt allocator (paging), so that
later the hwpt_nested allocator can do its own separate flags validation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 46 ++++++++++++++++++----------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ddce4189753f..fbe09e2473bc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -82,6 +82,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
 			  bool immediate_attach)
 {
+	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -91,6 +93,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (flags && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (flags & ~valid_flags)
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(ictx, hwpt_paging,
 					     IOMMUFD_OBJ_HWPT_PAGING,
@@ -169,35 +173,41 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
-	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
-	struct iommufd_ioas *ioas;
 	int rc;
 
-	if ((cmd->flags & ~(IOMMU_HWPT_ALLOC_NEST_PARENT |
-			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING)) ||
-	    cmd->__reserved)
+	if (cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ioas = iommufd_get_ioas(ucmd->ictx, cmd->pt_id);
-	if (IS_ERR(ioas)) {
-		rc = PTR_ERR(ioas);
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = -EINVAL;
 		goto out_put_idev;
 	}
 
-	mutex_lock(&ioas->mutex);
-	hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
-						cmd->flags, false);
-	if (IS_ERR(hwpt_paging)) {
-		rc = PTR_ERR(hwpt_paging);
-		goto out_unlock;
+	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
+		struct iommufd_hwpt_paging *hwpt_paging;
+
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		mutex_lock(&ioas->mutex);
+		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
+							cmd->flags, false);
+		if (IS_ERR(hwpt_paging)) {
+			rc = PTR_ERR(hwpt_paging);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_paging->common;
+	} else {
+		rc = -EINVAL;
+		goto out_put_pt;
 	}
-	hwpt = &hwpt_paging->common;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
@@ -209,8 +219,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
-	mutex_unlock(&ioas->mutex);
-	iommufd_put_object(&ioas->obj);
+	if (ioas)
+		mutex_unlock(&ioas->mutex);
+out_put_pt:
+	iommufd_put_object(pt_obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
 	return rc;
-- 
2.34.1

