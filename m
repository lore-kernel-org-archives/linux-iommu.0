Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299B53B3
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282732; x=1726818732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yi3c68gD4hTElDHskv0VcpfkQgw6vI/1kl3oI770f+E=;
  b=GLMjtdnrXSzqS4l5pujIWpbE1bYw1iM9XP7/PD+diKpNOWkrwN4mE5ie
   hv7o70y8CJtcETUl144j0IT8zqiEIjNxSuZfP/wGu5o8cn+TQT6xppctp
   F9qCIqtKYJdIEkgWFjpq7f7Gn0Njf/v3eZYc3gVmZYkrMqgW3LakX/Ae/
   IFl6Ikkdz+LDHgmcuIPTWaNhPwP1y8IPEtaY46Pr/QskmjVaOZ0Ii4Q8L
   u3xtndFcuvJfL3WMmCobwjvyFBGPOren4egv6428leryeN6vNgR7OCBcm
   OYhjsLArprFIQgjLQ9ANd1dsubTFBCs8rhsvV313ioQsScPF1e8zRUtHN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832850"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649516"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649516"
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
Subject: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT alloc/destroy/abort functions
Date: Thu, 21 Sep 2023 00:51:26 -0700
Message-Id: <20230921075138.124099-6-yi.l.liu@intel.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

As one of the previous commits mentioned, a user-managed HWPT will have
some different attributes/members. It'd be more clear by having separate
allocators. Since the existing iommufd_hw_pagetable_alloc() serves well
kernel-managed HWPTs, apply some minimal updates to mark it as a kernel-
managed HWPT allocator.

Also, add a pair of function pointers (abort and destroy) in the struct,
to separate different cleanup routines. Then rename the existing cleanup
functions to iommufd_kernel_managed_hwpt_destroy/abort() linked to the
HWPT in the allocator.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 34 ++++++++++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h |  3 +++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 554a9c3d740f..1cc7178121d1 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,7 +8,7 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
-void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
+static void iommufd_kernel_managed_hwpt_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
@@ -27,7 +27,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
-void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
+void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
+{
+	container_of(obj, struct iommufd_hw_pagetable, obj)->destroy(obj);
+}
+
+static void iommufd_kernel_managed_hwpt_abort(struct iommufd_object *obj)
 {
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
@@ -42,6 +47,11 @@ void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
 	iommufd_hw_pagetable_destroy(obj);
 }
 
+void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
+{
+	container_of(obj, struct iommufd_hw_pagetable, obj)->abort(obj);
+}
+
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->enforce_cache_coherency)
@@ -57,7 +67,7 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 }
 
 /**
- * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
+ * iommufd_hw_pagetable_alloc() - Get a kernel-managed iommu_domain for a device
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
@@ -66,9 +76,9 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @user_data: Optional user_data pointer
  * @immediate_attach: True if idev should be attached to the hwpt
  *
- * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
- * will be linked to the given ioas and upon return the underlying iommu_domain
- * is fully popoulated.
+ * Allocate a new iommu_domain (must be IOMMU_DOMAIN_UNMANAGED) and return it as
+ * a kernel-managed hw_pagetable. The HWPT will be linked to the given ioas and
+ * upon return the underlying iommu_domain is fully popoulated.
  *
  * The caller must hold the ioas->mutex until after
  * iommufd_object_abort_and_destroy() or iommufd_object_finalize() is called on
@@ -103,6 +113,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+	hwpt->abort = iommufd_kernel_managed_hwpt_abort;
+	hwpt->destroy = iommufd_kernel_managed_hwpt_destroy;
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
@@ -121,6 +133,16 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		}
 	}
 
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	/* Driver is buggy by mixing user-managed op in kernel-managed ops */
+	if (WARN_ON_ONCE(hwpt->domain->ops->cache_invalidate_user)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
 	 * iommus have a per-PTE bit that controls it and need to decide before
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1d3b1a74e854..3e89c3d530f3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -234,6 +234,9 @@ struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
 
+	void (*abort)(struct iommufd_object *obj);
+	void (*destroy)(struct iommufd_object *obj);
+
 	union {
 		struct { /* kernel-managed */
 			struct iommufd_ioas *ioas;
-- 
2.34.1

