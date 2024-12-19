Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB7225A4E
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614878; cv=none; b=hfHHBxQFqmSv1/lPPKt4/OgCypgk+0ENHV1cCdCP/o1SAtPQwvxWm9dgcNTpzeLJ3MZEmrKEZYykwLird3quRZa9YPjShVLh0XvkZ+m/7HmyVbV4VcQvU+y5CdeET6McLl9US4xn0KepP+1tT2OqQOt6vkKviPBtqd74pCQDEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614878; c=relaxed/simple;
	bh=arLKPB93jAJbJrb3J0xmj1dYdiRJQ8IlgY3jLcqddyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MljK/6tO57Gr2oy5MK/g3cywCtlgSKIGHcqUxHUBD+gN9U62r4dkUafqzASUBOZENpeKVK5FcwzQYYHYKIscMJVFNvD9abFKI7DdsCkOYaReCoF/BU9AnUPLdk3jiSkvci7sitmPelYMyOhbA/34tIGbKzTYDH7I+8tOkiD68Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrYlkiyH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrYlkiyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614877; x=1766150877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=arLKPB93jAJbJrb3J0xmj1dYdiRJQ8IlgY3jLcqddyw=;
  b=UrYlkiyHi7TfIIAmpg+bzRsfBBIyMhZX4E7C9P0AcSJT69tI8S5Z/dCc
   kJc6HG2UVZ79JTH7Oc//Joo/mrp43trh8VUpDy64PaJiUh9kjRpUg7JA4
   AFvX6crUcRmGYVTBiY3Yi0zReBoa7uadQNBKQh/VZy7wywNkjbltuM9XS
   EzEroLYGbtLGXnSTreAeW51TeRiLc3B8XBHY08C92CZocZgZqF0XGkJtc
   PcdxVhXuPp5so6jFOicvmHQyyqsGY/0QjtF+KPY19OPxdJ77VUEqB7LuL
   JxorC0oAkw1lwt4LIiWIVOAYMrtkeH+8F3LE5BYeUB3/azOm0ATSz2RSO
   A==;
X-CSE-ConnectionGUID: Yc2nuwizRA+9KYQZ9jJE5Q==
X-CSE-MsgGUID: TpA9hmsZSpuyxBbraB2ODQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542310"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542310"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:51 -0800
X-CSE-ConnectionGUID: 4BdgJTSkQJKFbcyh74Ahig==
X-CSE-MsgGUID: xBbyhg1ZSrS54MXMiUT13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177337"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:51 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 11/14] iommufd/selftest: Add set_dev_pasid in mock iommu
Date: Thu, 19 Dec 2024 05:27:43 -0800
Message-Id: <20241219132746.16193-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callback is needed to make pasid_attach/detach path complete for mock
device. A nop is enough for set_dev_pasid.

A MOCK_FLAGS_DEVICE_PASID is added to indicate a pasid-capable mock device
for the pasid test cases. Other test cases will still create a non-pasid
mock device. While the mock iommu always pretends to be pasid-capable.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  1 +
 drivers/iommu/iommufd/selftest.c     | 45 +++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a6b7a163f636..bdc979557272 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -48,6 +48,7 @@ enum {
 enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
 	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
+	MOCK_FLAGS_DEVICE_PASID = 1 << 2,
 };
 
 enum {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..3f49ef72ba91 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -200,8 +200,16 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 	return 0;
 }
 
+static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
+{
+	return 0;
+}
+
 static const struct iommu_domain_ops mock_blocking_ops = {
 	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop
 };
 
 static struct iommu_domain mock_blocking_domain = {
@@ -343,11 +351,15 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	struct mock_iommu_domain_nested *mock_nested;
 	struct mock_iommu_domain *mock_parent;
 
-	if (flags)
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!parent || parent->ops != mock_ops.default_domain_ops)
 		return ERR_PTR(-EINVAL);
 
+	if ((flags & IOMMU_HWPT_ALLOC_PASID) &&
+	    !dev->iommu->iommu_dev->max_pasids)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mock_parent = to_mock_domain(parent);
 	if (!mock_parent)
 		return ERR_PTR(-EINVAL);
@@ -365,7 +377,8 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-				 IOMMU_HWPT_ALLOC_NEST_PARENT;
+				 IOMMU_HWPT_ALLOC_NEST_PARENT |
+				 IOMMU_HWPT_ALLOC_PASID;
 	struct mock_dev *mdev = to_mock_dev(dev);
 	bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
 	struct mock_iommu_domain *mock;
@@ -375,6 +388,10 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	if ((flags & ~PAGING_FLAGS) || (has_dirty_flag && no_dirty_ops))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if ((flags & IOMMU_HWPT_ALLOC_PASID) &&
+	    !dev->iommu->iommu_dev->max_pasids)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
@@ -585,7 +602,11 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct mock_iommu_domain_nested *mock_nested;
 
-	if (flags)
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if ((flags & IOMMU_HWPT_ALLOC_PASID) &&
+	    !mock_viommu->core.iommu_dev->max_pasids)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mock_nested = __mock_domain_alloc_nested(user_data);
@@ -720,6 +741,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -780,6 +802,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
@@ -839,11 +862,16 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	struct property_entry prop[] = {
+		PROPERTY_ENTRY_U32("pasid-num-bits", 20),
+		{},
+	};
 	struct mock_dev *mdev;
 	int rc, i;
 
 	if (dev_flags &
-	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
+	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY |
+		    MOCK_FLAGS_DEVICE_HUGE_IOVA | MOCK_FLAGS_DEVICE_PASID))
 		return ERR_PTR(-EINVAL);
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
@@ -866,6 +894,14 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (rc)
 		goto err_put;
 
+	if (dev_flags & MOCK_FLAGS_DEVICE_PASID) {
+		rc = device_create_managed_software_node(&mdev->dev, prop, NULL);
+		if (rc) {
+			dev_err(&mdev->dev, "add pasid-num-bits property failed, rc: %d", rc);
+			goto err_put;
+		}
+	}
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_put;
@@ -1724,6 +1760,7 @@ int __init iommufd_test_init(void)
 	init_completion(&mock_iommu.complete);
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+	mock_iommu.iommu_dev.max_pasids = (1 << 20);
 
 	return 0;
 
-- 
2.34.1

