Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC0372
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917133; x=1707453133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ja+t+nxs1FvQ3VSNmIfqBCGaB8PSH4Fy0AP9hils4l4=;
  b=kxOBJI/HWMz5SdNBJrmpRl55WYWQCKHIDEwPNGHoh+2wgm0mu45driiN
   rg3J4vtXmPhnb8M77g+bTULFSZKNAWkwbO3+DLuSYs6TQyttjmdbJGpzb
   deR6HR/OMz2rSSLIj41CzUgNt62XFgAmj8JU2u8tVnyiqjGfuiFfUFU0a
   P7M2Q4A2NMjpxV/epWn0gElTrA7zfiNvHpTz7tS4LTM01V2HvOkq5fQuV
   NB0ceVgqAS5y09FCBWj68KIBlB/SzYZjxA2Cz3e5s95hEKu/WFL0W7plE
   UXiz1ShjQY9lOYSi7AN9mlMvLxCakj6oZzugtyulC6Hvmyqf1n0czvOSI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298749"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298749"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447547"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447547"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:12 -0800
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
Subject: [PATCH 08/17] iommufd: Split iommufd_hw_pagetable_alloc()
Date: Wed,  8 Feb 2023 20:31:44 -0800
Message-Id: <20230209043153.14964-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to a helper which accepts the parent hw_pagetable pointer and user_data
pointer. This is a prepareation for supporting userspace hw_pagetable
allocation as caller needs to pass the two parameters to domain_alloc_user
op.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 41 ++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index bda21ec737cf..ee97d2f3cf43 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -22,24 +22,23 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	mutex_destroy(&hwpt->devices_lock);
 }
 
-/**
- * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
- * @ictx: iommufd context
- * @ioas: IOAS to associate the domain with
- * @dev: Device to get an iommu_domain for
- *
- * Allocate a new iommu_domain and return it as a hw_pagetable.
- */
-struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct device *dev)
+static struct iommufd_hw_pagetable *
+__iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
+			     struct iommufd_ioas *ioas,
+			     struct device *dev,
+			     struct iommufd_hw_pagetable *parent,
+			     void *user_data)
 {
 	const struct iommu_ops *ops;
+	struct iommu_domain *parent_domain = NULL;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (WARN_ON(!ioas && !parent))
+		return ERR_PTR(-EINVAL);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -50,7 +49,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
+	if (parent)
+		parent_domain = parent->domain;
+
+	hwpt->domain = ops->domain_alloc_user(dev, parent_domain, user_data);
 	if (!hwpt->domain) {
 		rc = -ENOMEM;
 		goto out_abort;
@@ -75,3 +77,18 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	iommufd_object_abort(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
+
+/**
+ * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
+ * @ictx: iommufd context
+ * @ioas: IOAS to associate the domain with
+ * @dev: Device to get an iommu_domain for
+ *
+ * Allocate a new iommu_domain and return it as a hw_pagetable.
+ */
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			   struct device *dev)
+{
+	return __iommufd_hw_pagetable_alloc(ictx, ioas, dev, NULL, NULL);
+}
-- 
2.34.1

