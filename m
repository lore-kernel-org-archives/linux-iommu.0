Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB822DFAB
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577595; cv=none; b=kifKg4h0YLJfcG8OnSd8QRqyFc8q9e3TScC5K79WfmNIPZciZYzsiYtdRWySFgcYi5i4G1mmSrZRs9ZNIoZ//CAstTWKHr8AMThmJkh+h19WYr7DQydTQp1cgqihozNwHjd/HDjZ9Eht07ZBdwebCe/kDrkI/DyTNL2Rbz9ItFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577595; c=relaxed/simple;
	bh=qfQPAbtYZ6y1ItOjWoPBnMiU6rtaRROJ8b+mXBRZCvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiYtSEOdmmnUfDhHeyxWbhvH14WZ+BM2JlRfdVf30hXJcwVmSTPpaf2x4CZ/btuV7W5J2rLOuHEo80TbW4eKCA4C4EQkMAecNuQYTjjy0qttrhDXtkpy+TLav/ZadxpzNUrnUMO+/AOiLA/03pG3ktcd1Cudk64RMgHm6XndhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVZdESTh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVZdESTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577594; x=1774113594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qfQPAbtYZ6y1ItOjWoPBnMiU6rtaRROJ8b+mXBRZCvk=;
  b=cVZdESThdqFT8WXHeVpDsSZYsFdl+0qf1jdT4qR9Qo3HEvvZimkWCKC0
   YwyslJ9m42mJDUVKvbQebLWS5QN0wII3paC796fpPl20C8gvJl6PNDaIZ
   ekmad3lRaDTW9lyJwqtbGXMjMdWJJJE4Mn2Sr/oVufXnt2nVsEao557C/
   6plIa31SsgBT8Q3UrVUnL9JKUmiIMngI/zLfg+Z4e6C9z7dRjJQZwNVBF
   y491nZlT2I78sKCOvf0Sjmy9xOslwsHJ8iC9dZomvAuWjlJ6E3va2YAPZ
   2rjw4L8g9Mrllxil/H4tHYGt/mm46wJKQE/CdRSigCngDwOTx/XTyqQyz
   Q==;
X-CSE-ConnectionGUID: zp379x1RR6iDQoudYFhT2A==
X-CSE-MsgGUID: BTetXxaKRL67X+v+dJbWcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976837"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976837"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:48 -0700
X-CSE-ConnectionGUID: dt2s+StqQ1y9/Y9IFxxXQA==
X-CSE-MsgGUID: x01e9xa4TVKEJ7knwvB6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914521"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:47 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 15/18] iommufd/selftest: Add set_dev_pasid in mock iommu
Date: Fri, 21 Mar 2025 10:19:37 -0700
Message-Id: <20250321171940.7213-16-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: Minor tweaks. Detail refer to discussion in v10 of this patch
---
 drivers/iommu/iommufd/iommufd_test.h |  4 +++
 drivers/iommu/iommufd/selftest.c     | 37 ++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

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
index 0b3f5cbf242b..aa3da0adc4e1 100644
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
@@ -862,11 +873,17 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	struct property_entry prop[] = {
+		PROPERTY_ENTRY_U32("pasid-num-bits", 0),
+		{},
+	};
+	const u32 valid_flags = MOCK_FLAGS_DEVICE_NO_DIRTY |
+				MOCK_FLAGS_DEVICE_HUGE_IOVA |
+				MOCK_FLAGS_DEVICE_PASID;
 	struct mock_dev *mdev;
 	int rc, i;
 
-	if (dev_flags &
-	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
+	if (dev_flags & ~valid_flags)
 		return ERR_PTR(-EINVAL);
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
@@ -890,6 +907,15 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (rc)
 		goto err_put;
 
+	if (dev_flags & MOCK_FLAGS_DEVICE_PASID)
+		prop[0] = PROPERTY_ENTRY_U32("pasid-num-bits", MOCK_PASID_WIDTH);
+
+	rc = device_create_managed_software_node(&mdev->dev, prop, NULL);
+	if (rc) {
+		dev_err(&mdev->dev, "add pasid-num-bits property failed, rc: %d", rc);
+		goto err_put;
+	}
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_put;
@@ -1778,6 +1804,7 @@ int __init iommufd_test_init(void)
 	init_completion(&mock_iommu.complete);
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+	mock_iommu.iommu_dev.max_pasids = (1 << MOCK_PASID_WIDTH);
 
 	return 0;
 
-- 
2.34.1

