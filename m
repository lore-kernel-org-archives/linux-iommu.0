Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AD267383
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869359; cv=none; b=YBnCYqy0Jc+z2J5FXZh4OaYyI5l8ogYlLgGw7lCEkz0tDzOf0WcDEBUxwBFOxlr2fHuYeTjvoZuIc5lzBVNGm+wMNZMnfl5v2CXYmiGU41QNxcwHTMpV5Ibl9mhDAGQA7CuVvXx35Kg3LYSsozhf/hOidpWNyb1/RHsfHq9c8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869359; c=relaxed/simple;
	bh=0QU568dI0BoC3LjfbSVlxK5ad9QRgnuahbNmdalusL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tR5nquqg7g7WXSQ9ajqoxUwvfsQAPGRJLRNsLfInG5Uy4J0AFYJkdx5XeUs4WLmv/cHEZ06Ed7S2WL9GRO4yG56Ausim4IsQgIcRwpggQHtxzvRe63qDs74GxiS4h7CQH/KNG5CTTHrVK00OFu1rD3ySZ/Si7T34MOLjxtHMUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/reB/JS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/reB/JS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869358; x=1773405358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0QU568dI0BoC3LjfbSVlxK5ad9QRgnuahbNmdalusL0=;
  b=B/reB/JSSCisKDwnQo3Uq5jyPqFEna8JkpWlOdQvrQNMBGMH4rx1s5v/
   +oNcdok8+2oammzh7d4VC3geGf8i2ITfJDvPlLoDVHS+azLm8y/TqLkzd
   stAt/7dBHthvwkcAF0H7TUxEhrN57ZmeL66a4YuLJugagtKLUtxKi7Jrv
   pN7MPaINMgLFs22CM8MLn7fH/iqEvyxqKBk1pLLBeY+bY1hEOgXHdlevg
   EU0O1d3v9iDhhN3hm51wG77sa58ecJTAvYVjy2Se8GA9KMCm45aewwkPp
   O2Ey214bXUEhyjkItZ+1Ttve2cQq/QD7oHvmhiLDZkJAmXnYSlQ52bpqT
   g==;
X-CSE-ConnectionGUID: P6HMm6o8TPCXj4XKLi08Tg==
X-CSE-MsgGUID: hKcSRhnDROG/S37YfXzeeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863990"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863990"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:41 -0700
X-CSE-ConnectionGUID: OR+OBvAGSmGB91y7nyvIYA==
X-CSE-MsgGUID: FBY3OtW6Q2in8+FBoDFM/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005554"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:41 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 18/21] iommufd/selftest: Add set_dev_pasid in mock iommu
Date: Thu, 13 Mar 2025 05:35:29 -0700
Message-Id: <20250313123532.103522-19-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/iommufd_test.h |  1 +
 drivers/iommu/iommufd/selftest.c     | 33 ++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

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
index 84ad7b639fb3..29faf3fac8e6 100644
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
@@ -343,7 +351,7 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	struct mock_iommu_domain_nested *mock_nested;
 	struct mock_iommu_domain *mock_parent;
 
-	if (flags)
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!parent || parent->ops != mock_ops.default_domain_ops)
 		return ERR_PTR(-EINVAL);
@@ -365,7 +373,8 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-				 IOMMU_HWPT_ALLOC_NEST_PARENT;
+				 IOMMU_HWPT_ALLOC_NEST_PARENT |
+				 IOMMU_HWPT_ALLOC_PASID;
 	struct mock_dev *mdev = to_mock_dev(dev);
 	bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
 	struct mock_iommu_domain *mock;
@@ -585,7 +594,7 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
 	struct mock_iommu_domain_nested *mock_nested;
 
-	if (flags)
+	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mock_nested = __mock_domain_alloc_nested(user_data);
@@ -720,6 +729,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -780,6 +790,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
@@ -839,11 +850,16 @@ static void mock_dev_release(struct device *dev)
 
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
@@ -866,6 +882,14 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
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
@@ -1724,6 +1748,7 @@ int __init iommufd_test_init(void)
 	init_completion(&mock_iommu.complete);
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+	mock_iommu.iommu_dev.max_pasids = (1 << 20);
 
 	return 0;
 
-- 
2.34.1

