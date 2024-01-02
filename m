Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5F14F81
	for <iommu@lists.linux.dev>; Tue,  2 Jan 2024 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ7XGWmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206323; x=1735742323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaKsYJmpoP1J2+af2wMppPzhvG3pSWEOhFLhzXoh4BU=;
  b=SQ7XGWmcMMEXeLWbwFSSmggU35beTFTVYQUudWAsLgG73FP1ABO9ukuG
   RBqf8u9DDCX/6TfjHuNtaF2GRxI9pr70ST+awzZcqrTnkGwokXbY7uS/m
   ArQwMGdrPN8C4lkyIOyrfqkWUPM8XpgHcd8j9/ZiLpYg/WNOdvQhg3ZvW
   mbRxfyOLwmcwKT50oj922xjJrpVtS5LH67lNq2ojHIhdPTs0XUI8u7KoT
   vKHRVVXt1jmwXMRQQ1kZmP+zFXX4dPjJI/qVWIxCqblk/DyTEFUi8hSrl
   knIE7z2WLic2FORom7p7ozBQqD2ykh2olEJTlQ9X7Qvk+G/ssLNsivOME
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10270455"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10270455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923234282"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923234282"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2024 06:38:42 -0800
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com,
	j.granados@samsung.com
Subject: [PATCH v10 04/10] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date: Tue,  2 Jan 2024 06:38:28 -0800
Message-Id: <20240102143834.146165-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102143834.146165-1-yi.l.liu@intel.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Add mock_domain_cache_invalidate_user() data structure to support user
space selftest program to cover user cache invalidation pathway.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 34 ++++++++++++++++
 drivers/iommu/iommufd/selftest.c     | 60 ++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7910fbe1962d..2eef5afde711 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -148,4 +148,38 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_invalidate_data_type */
+#define IOMMU_HWPT_INVALIDATE_DATA_SELFTEST 0xdeadbeef
+#define IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
+
+/**
+ * enum iommu_hwpt_invalidate_selftest_error - Hardware error of invalidation
+ * @IOMMU_TEST_INVALIDATE_FAKE_ERROR: Fake hw error per test program's request
+ */
+enum iommu_hwpt_invalidate_selftest_error {
+	IOMMU_TEST_INVALIDATE_FAKE_ERROR = (1 << 0)
+};
+
+/**
+ * struct iommu_hwpt_invalidate_selftest - Invalidation data for Mock driver
+ *                                         (IOMMU_HWPT_INVALIDATE_DATA_SELFTEST)
+ * @flags: Invalidate flags
+ * @iotlb_id: Invalidate iotlb entry index
+ * @hw_error: One of enum iommu_hwpt_invalidate_selftest_error
+ * @__reserved: Must be 0
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @iotlb_id will be ignored
+ * @hw_error meaningful only if the request is processed successfully.
+ * If IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR is set in @flags, report a
+ * hw error back, cache would not be invalidated in this case.
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL	(1 << 0)
+#define IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR	(1 << 1)
+	__u32 flags;
+	__u32 iotlb_id;
+	__u32 hw_error;
+	__u32 __reserved;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 022ef8f55088..ebc6c15abf67 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -473,9 +473,69 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(mock_nested);
 }
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+	u32 hw_error = 0, processed = 0;
+	struct iommu_hwpt_invalidate_selftest inv;
+	int i = 0, j;
+	int rc = 0;
+
+	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_SELFTEST) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	for ( ; i < array->entry_num; i++) {
+		rc = iommu_copy_struct_from_user_array(&inv, array,
+						       IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+						       i, __reserved);
+		if (rc)
+			break;
+
+		if ((inv.flags & ~(IOMMU_TEST_INVALIDATE_FLAG_ALL |
+				  IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR)) ||
+		    inv.__reserved) {
+			rc = -EOPNOTSUPP;
+			break;
+		}
+
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			rc = -EINVAL;
+			break;
+		}
+
+		if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR) {
+			hw_error = IOMMU_TEST_INVALIDATE_FAKE_ERROR;
+		} else if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all mock iotlb entries and ignore iotlb_id */
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock_nested->iotlb[j] = 0;
+		} else {
+			mock_nested->iotlb[inv.iotlb_id] = 0;
+		}
+
+		inv.hw_error = hw_error;
+		rc = iommu_respond_struct_to_user_array(array, i, (void *)&inv,
+							sizeof(inv));
+		if (rc)
+			break;
+
+		processed++;
+	}
+
+out:
+	array->entry_num = processed;
+	return rc;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
 };
 
 static inline struct iommufd_hw_pagetable *
-- 
2.34.1

