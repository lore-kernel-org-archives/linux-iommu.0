Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97986221F33
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478478; cv=none; b=Gkzy0OUiTgXO1Qb1Zdl0lp59yG4drElrLul5m2fT20bcuQVf157+hEgvGIxNHsnNwCIyniuqRzAz7lD6l1slFlPDvO1tO9qwKJH9+B9POKiZplU1lAj6o7fD98ax0DbuGS3ZVlD/34DgDx1Z20lf2OQ/ka0O0gTMg6sMc8MCiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478478; c=relaxed/simple;
	bh=7GJh9KAIolFycvYwkgpLVOF+wq5SE+HN9+BMr2Q0pBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5EwZkhl/OiYduvdrNztUtqGAc5P5937UnmT0/e59i/Kz6f7AO1A6OzvFw9EXQWSax8SexZaHWBel+4gMVRXD/nbRwsi8DocGuiedLyrEfj7PtMtt/bMP6l3mrD6aXJrh6xpKh4CUvj6eYT49lI+a1Oamx4Lv4Nd1WcfcWxNZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhVPjDr3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhVPjDr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478476; x=1774014476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7GJh9KAIolFycvYwkgpLVOF+wq5SE+HN9+BMr2Q0pBc=;
  b=jhVPjDr3DRxlYLbLr7N0QCLI5X+jEeT5PZW7Njxmwke9Jl0uaTi0aeRk
   piWLp1GCDlxuJJPzUE3AXuybxkZSqhG0tDOPP9JyA2X6rjfVxmMxPLh2B
   z5gorrpdSNKZdVeCUo59tMTe6s/iprzmDEuTTrveion0hRa39NK3xVpHF
   G4ZAJTLnVXHXqgd8PM4yMof+8Db3dgr3sYgXEqFt8zM8r56VwSqTuDWF9
   voURv1LEsJXBj06W5Xe3IKldoLyeTNAYDgyQEpcxgMbh+gC2h//XlLrbP
   9XenG8lqKFhJWyJ/wUTtfIragGgdpr6Qf8apBjCKqxaBZd0ahOclpwfLv
   g==;
X-CSE-ConnectionGUID: WbePi4aRR42WQqgSzm3AFw==
X-CSE-MsgGUID: unBTcjPAQ1KZvnnVpWAn6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063083"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: CGNWWSlRTqe9DASFwhpzHQ==
X-CSE-MsgGUID: gzd3Ku5MTyqjnOS0NGi8mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319190"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:49 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 15/18] iommufd/selftest: Add set_dev_pasid in mock iommu
Date: Thu, 20 Mar 2025 06:47:41 -0700
Message-Id: <20250320134744.5777-16-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
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

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v9 -> v10: Added MOCK_PASID_WIDTH to replace 20
---
 drivers/iommu/iommufd/iommufd_test.h |  4 ++++
 drivers/iommu/iommufd/selftest.c     | 33 ++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 87e9165cea27..1a066feb8697 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -49,6 +49,7 @@ enum {
 enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
 	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
+	MOCK_FLAGS_DEVICE_PASID = 1 << 2,
 };
 
 enum {
@@ -154,6 +155,9 @@ struct iommu_test_cmd {
 };
 #define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
 
+/* Mock device/iommu PASID width */
+#define MOCK_PASID_WIDTH 20
+
 /* Mock structs for IOMMU_DEVICE_GET_HW_INFO ioctl */
 #define IOMMU_HW_INFO_TYPE_SELFTEST	0xfeedbeef
 #define IOMMU_HW_INFO_SELFTEST_REGVAL	0xdeadbeef
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 0b3f5cbf242b..c26730375a72 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -223,8 +223,16 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
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
@@ -366,7 +374,7 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	struct mock_iommu_domain_nested *mock_nested;
 	struct mock_iommu_domain *mock_parent;
 
-	if (flags)
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!parent || parent->ops != mock_ops.default_domain_ops)
 		return ERR_PTR(-EINVAL);
@@ -388,7 +396,8 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-				 IOMMU_HWPT_ALLOC_NEST_PARENT;
+				 IOMMU_HWPT_ALLOC_NEST_PARENT |
+				 IOMMU_HWPT_ALLOC_PASID;
 	struct mock_dev *mdev = to_mock_dev(dev);
 	bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
 	struct mock_iommu_domain *mock;
@@ -608,7 +617,7 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct mock_iommu_domain_nested *mock_nested;
 
-	if (flags)
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mock_nested = __mock_domain_alloc_nested(user_data);
@@ -743,6 +752,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -803,6 +813,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
@@ -862,11 +873,16 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	struct property_entry prop[] = {
+		PROPERTY_ENTRY_U32("pasid-num-bits", MOCK_PASID_WIDTH),
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
@@ -890,6 +906,14 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
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
@@ -1778,6 +1802,7 @@ int __init iommufd_test_init(void)
 	init_completion(&mock_iommu.complete);
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+	mock_iommu.iommu_dev.max_pasids = (1 << MOCK_PASID_WIDTH);
 
 	return 0;
 
-- 
2.34.1

