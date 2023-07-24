Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAE1FB3
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196677; x=1721732677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWEG8B8IVLnnYXlFA9j627UTPjfHZtc7JFjCLROvnNw=;
  b=I8xrzjKElGjO/zWKW8gFaYOsU6Pes+hfhm8yjNpzsLVs9IJZhTqSv4ab
   +ylR67nV99fT92BUwuC1ZF4RzyysVCdTCV1WY+cAsG2puN+7mzxXUNmrN
   OJn4Jvo/085bihvEfhzFJmfglEzIu3ituir9I/0XFB41K/fAX2EwelLJS
   gF4weJ6Zfw7h2AHjQY6zVZ3Y/7gQc3eHvfw7cMGQWhprK6FyJ/4xkuC3R
   +pkg67nClu1QOcEguHPLOi11tgob6Kz6q54fBjGLf5OAA1KBf18PNkr0H
   gBUa3IJILkG4kxrv2RgISc8d3WwmY9PAjHuTav1ALRjpQDDbF+o08fUR2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013333"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013333"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775882"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775882"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:23 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v3 14/17] iommufd/selftest: Add domain_alloc_user() support in iommu mock
Date: Mon, 24 Jul 2023 04:04:03 -0700
Message-Id: <20230724110406.107212-15-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Add mock_domain_alloc_user function and iommu_hwpt_selftest data structure
to support user space selftest program to allocate domains with user data.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c |  1 +
 drivers/iommu/iommufd/iommufd_test.h | 16 ++++++
 drivers/iommu/iommufd/selftest.c     | 84 +++++++++++++++++++++++++---
 include/linux/iommu.h                |  3 +
 4 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 9064e6d181b4..e30fce5d553b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -7,6 +7,7 @@
 
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index b7f4bee2ea1b..eeac8100844d 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -115,4 +115,20 @@ struct iommu_test_hw_info {
 	__u32 test_reg;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_type */
+#define IOMMU_HWPT_TYPE_SELFTTEST		0xdead
+
+/**
+ * struct iommu_hwpt_selftest
+ *
+ * @flags: page table entry attributes
+ * @test_config: default iotlb setup (value IOMMU_TEST_IOTLB_DEFAULT)
+ */
+struct iommu_hwpt_selftest {
+#define IOMMU_TEST_FLAG_NESTED		(1ULL << 0)
+	__u64 flags;
+#define IOMMU_TEST_IOTLB_DEFAULT	0xbadbeef
+	__u64 test_config;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index e40780db88b5..8364003efde3 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -84,7 +84,9 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 
 struct mock_iommu_domain {
 	struct iommu_domain domain;
+	struct mock_iommu_domain *parent;
 	struct xarray pfns;
+	u32 iotlb;
 };
 
 enum selftest_obj_type {
@@ -144,26 +146,81 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length)
 	return info;
 }
 
-static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+static const struct iommu_ops mock_ops;
+static struct iommu_domain_ops domain_nested_ops;
+
+static struct iommu_domain *
+__mock_domain_alloc(unsigned int iommu_domain_type,
+		    struct mock_iommu_domain *mock_parent,
+		    const struct iommu_hwpt_selftest *user_cfg)
 {
 	struct mock_iommu_domain *mock;
 
 	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
 		return &mock_blocking_domain;
 
-	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
-		return NULL;
-
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
-		return NULL;
-	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+		return ERR_PTR(-ENOMEM);
+	mock->parent = mock_parent;
+	mock->domain.type = iommu_domain_type;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
-	xa_init(&mock->pfns);
+	if (mock_parent) {
+		mock->iotlb = user_cfg->test_config;
+		mock->domain.ops = &domain_nested_ops;
+	} else {
+		mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
+		mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+		mock->domain.ops = mock_ops.default_domain_ops;
+		xa_init(&mock->pfns);
+	}
 	return &mock->domain;
 }
 
+static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+{
+	struct iommu_domain *domain;
+
+	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_BLOCKED &&
+		    iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
+		return NULL;
+	domain = __mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED, NULL, NULL);
+	if (IS_ERR(domain))
+		domain = NULL;
+	return domain;
+}
+
+static struct iommu_domain *mock_domain_alloc_user(struct device *dev,
+						   enum iommu_hwpt_type hwpt_type,
+						   struct iommu_domain *parent,
+						   const union iommu_domain_user_data *user_data)
+{
+	const struct iommu_hwpt_selftest *user_cfg = (struct iommu_hwpt_selftest *)user_data;
+	unsigned int iommu_domain_type = IOMMU_DOMAIN_UNMANAGED;
+	struct mock_iommu_domain *mock_parent = NULL;
+
+	/* Check union iommu_domain_user_data in include/linux/iommu.h */
+	static_assert(sizeof(struct iommu_hwpt_selftest) <= 16);
+
+	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
+	    hwpt_type != IOMMU_HWPT_TYPE_SELFTTEST)
+		return ERR_PTR(-EINVAL);
+
+	if (parent) {
+		if (hwpt_type != IOMMU_HWPT_TYPE_SELFTTEST)
+			return ERR_PTR(-EINVAL);
+		if (parent->ops != mock_ops.default_domain_ops)
+			return ERR_PTR(-EINVAL);
+		if (!user_cfg || !(user_cfg->flags & IOMMU_TEST_FLAG_NESTED))
+			return ERR_PTR(-EINVAL);
+		iommu_domain_type = IOMMU_DOMAIN_NESTED;
+		mock_parent = container_of(parent,
+					   struct mock_iommu_domain, domain);
+	}
+
+	return __mock_domain_alloc(iommu_domain_type, mock_parent, user_cfg);
+}
+
 static void mock_domain_free(struct iommu_domain *domain)
 {
 	struct mock_iommu_domain *mock =
@@ -324,6 +381,7 @@ static const struct iommu_ops mock_ops = {
 	.hw_info_type = IOMMU_HW_INFO_TYPE_SELFTEST,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
+	.domain_alloc_user = mock_domain_alloc_user,
 	.capable = mock_domain_capable,
 	.get_resv_regions = iommufd_test_get_resv_regions,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
@@ -337,6 +395,11 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static struct iommu_domain_ops domain_nested_ops = {
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+};
+
 static struct iommu_device mock_iommu_device = {
 	.ops = &mock_ops,
 };
@@ -353,7 +416,10 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
-	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
+	if ((hwpt->domain->type == IOMMU_DOMAIN_UNMANAGED &&
+	     hwpt->domain->ops != mock_ops.default_domain_ops) ||
+	    (hwpt->domain->type == IOMMU_DOMAIN_NESTED &&
+	     hwpt->domain->ops != &domain_nested_ops)) {
 		iommufd_put_object(&hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b8f09330b64e..e4835230d5f0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -237,6 +237,9 @@ struct iommu_iotlb_gather {
  * include/uapi/linux/iommufd.h.
  */
 union iommu_domain_user_data {
+#ifdef CONFIG_IOMMUFD_TEST
+	__u64 test[2];
+#endif
 };
 
 /**
-- 
2.34.1

