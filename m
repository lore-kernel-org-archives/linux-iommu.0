Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C181C
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349374; x=1709885374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6a+QAIRGPkjHfuRSA0kkXfLfQHx0PbJp4L/PN4a0aE=;
  b=egUgiFPoCCdg1TfUGNcINs8lSywjtIfYjLVI0iW6ViD/X2mNkovuw3bX
   lkx0wVvzHvc0eyBwPRz14yRU7uqe7usd+rQ9FhpcvlNHPNe1Tb/TvyO/e
   rNy8Bn0n+/cFB8DtL1fBWey0uOmfk+JR5U9+RKX577s75GI6btkXmADSG
   toMxrZOrxZoxHof1RUpSZ0SWAQAmF1hGtGpTCzFgMbDKbtsbM3aelXbJg
   s48V9hrTyEx6qR/kcnv1qjlpSqR+kCmpjF30l3H65pXx/Bldd1i/wDMD6
   LmQRckHMrHNdsiMo61ldFjKVMBQVrqd4gHeoE1oFSvp6p/TKTTZRDyr/m
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023049"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471371"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471371"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:24 -0800
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to iommufd_hw_pagetable_alloc()
Date: Thu,  9 Mar 2023 00:09:02 -0800
Message-Id: <20230309080910.607396-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested translation has stage-1 and stage-2 page tables. A stage-1 page
table is managed by user space, and it needs to work with a stage-2 page
table, which is a parent hwpt for the stage-1 hwpt.

iommu core already supports accepting parent iommu_domain and user_data
to allocate an iommu_domain. This makes iommufd_hw_pagetable_alloc() to
accept the parent hwpt and user_data, and relays them to iommu core, to
prepare for supporting hw_pagetable allocation with user_data.

Also, add a parent pointer in struct iommufd_hw_pagetable for taking and
releasing its refcount.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  2 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 28 ++++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |  5 ++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5c352807d946..19cd6df46c6a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -558,7 +558,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  immediate_attach);
+					  NULL, NULL, immediate_attach);
 	if (IS_ERR(hwpt)) {
 		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 84b4a11e62f8..16e92a1c150b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -24,6 +24,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	if (hwpt->domain)
 		iommu_domain_free(hwpt->domain);
 
+	if (hwpt->parent)
+		refcount_dec(&hwpt->parent->obj.users);
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
@@ -46,6 +48,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
+ * @parent: Optional parent HWPT to associate with the domain with
+ * @user_data: Optional user_data pointer
  * @immediate_attach: True if idev should be attached to the hwpt
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
@@ -54,14 +58,20 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach)
+			   struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *parent,
+			   void *user_data, bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommu_domain *parent_domain = NULL;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (parent && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -70,9 +80,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+	if (parent) {
+		hwpt->parent = parent;
+		parent_domain = parent->domain;
+		refcount_inc(&parent->obj.users);
+	}
 
 	if (ops->domain_alloc_user)
-		hwpt->domain = ops->domain_alloc_user(idev->dev, NULL, NULL);
+		hwpt->domain = ops->domain_alloc_user(idev->dev,
+						      parent_domain, user_data);
 	else
 		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
 	if (!hwpt->domain) {
@@ -80,6 +96,11 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/* It must be either NESTED or UNMANAGED, depending on parent_domain */
+	if ((parent_domain && hwpt->domain->type != IOMMU_DOMAIN_NESTED) ||
+	    (!parent_domain && hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED))
+		goto out_abort;
+
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
 	 * iommus have a per-PTE bit that controls it and need to decide before
@@ -150,7 +171,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
+					  NULL, NULL, false);
 	mutex_unlock(&ioas->mutex);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 05b5ad66f716..182c074eecdc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -243,6 +243,7 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
+	struct iommufd_hw_pagetable *parent;
 	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
 	bool auto_domain : 1;
@@ -254,7 +255,9 @@ struct iommufd_hw_pagetable {
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach);
+			   struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *parent,
+			   void *user_data, bool immediate_attach);
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-- 
2.34.1

