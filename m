Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50E648
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917139; x=1707453139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O06cP82mf2Ud/xjs3OV3gC0AxWz7oGEuUUE6NIRSTvA=;
  b=NMouoEuNWvSm1g0CqDF8s48lzYqZ92AxgPPsAf9HiNCjEQJ/APSI6sND
   4YPfT+wPtlEeZ40y0m/ATk299Eo2KVfF/GVwzLvUqAJm4rURCjUddXF1y
   JKfF+uWVpawZzzd4NljqQg2936XKvoQ39h7QAg/h4ovajvphoVI+zy36S
   Jr5kziv6LpOdYR7J6XD3N2rTr09eDTdQoOHhtBfy2czFSh0QUz47SsKOz
   ERytaKsVi2M7LBl7Gcs+HZfq7i4C0hfz/sro4ep2/7TJdqhOtpbbaHICB
   A9ecA8FDO8VM4fWhbB0mzqmcYtN8wLbEzbpSEDRPUZY7apBNCCJQOMbZN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298798"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298798"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447580"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447580"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:18 -0800
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
Subject: [PATCH 11/17] iommufd: Add infrastructure for user-managed hw_pagetable allocation
Date: Wed,  8 Feb 2023 20:31:47 -0800
Message-Id: <20230209043153.14964-12-yi.l.liu@intel.com>
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

Nested translation has stage-1 and stage-2 hw_pagetables, and both needs
userspace to allocate. Stage-1 hw_pagetable needs to work with a stage-2
hw_pagetable. This adds a parent pointer in struct iommufd_hw_pagetable
to link stage-1 hw_pagetable with a stage-2 hw_pagetable. Hence iommufd
core can accept user-managed hw_pagetable allocation request.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  5 +++++
 drivers/iommu/iommufd/hw_pagetable.c    | 21 +++++++++++++++------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index cdc4ab36f52d..6d948fa418d5 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -301,6 +301,9 @@ static int iommufd_device_attach_ioas(struct iommufd_device *idev,
 	struct io_pagetable *iopt;
 	int rc;
 
+	if (hwpt->parent)
+		hwpt = hwpt->parent;
+
 	iopt = &hwpt->ioas->iopt;
 
 	rc = iopt_table_enforce_group_resv_regions(iopt, idev->dev,
@@ -321,6 +324,8 @@ static int iommufd_device_attach_ioas(struct iommufd_device *idev,
 static void iommufd_device_detach_ioas(struct iommufd_device *idev,
 				       struct iommufd_hw_pagetable *hwpt)
 {
+	if (hwpt->parent)
+		hwpt = hwpt->parent;
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 }
 
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 998d01490a74..02dee8e8d958 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -15,8 +15,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 
 	WARN_ON(!list_empty(&hwpt->devices));
 
-	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
-	list_del(&hwpt->hwpt_item);
+	if (!hwpt->parent) {
+		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+		list_del(&hwpt->hwpt_item);
+	} else {
+		refcount_dec(&hwpt->parent->obj.users);
+	}
 	iommu_domain_free(hwpt->domain);
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
@@ -58,13 +62,18 @@ __iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 
+	hwpt->parent = parent;
 	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
 	mutex_init(&hwpt->devices_lock);
-	rc = iopt_table_add_domain(&ioas->iopt, hwpt->domain);
-	if (rc)
-		goto out_free_domain;
-	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
+	if (!parent) {
+		rc = iopt_table_add_domain(&ioas->iopt, hwpt->domain);
+		if (rc)
+			goto out_free_domain;
+		list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
+	} else {
+		refcount_inc(&parent->obj.users);
+	}
 
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index ee5344baf135..5ef034451f4b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -241,6 +241,7 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
+	struct iommufd_hw_pagetable *parent;
 	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
 	bool auto_domain : 1;
-- 
2.34.1

