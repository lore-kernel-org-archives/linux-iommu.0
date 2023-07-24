Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AC1FB3
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196679; x=1721732679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vlk7hKfSz0vf7ls07gWGHz24yNzmZ+WhjoD4+B5vePM=;
  b=XwhXfb7NxqQDvXbv+H1Z2UiMKNm9EJpavWMqFJrpEkTLZJmbxahksv7A
   QaXa/IUS7bx9cZUfGGcJZrbDvVXp+Rq0MgtDET3sKEMqM3boVzxvSp50z
   YfTVi9fkxJSb1zYfpjkZHwjoBzEVLicGKucJmxeEncQRC1YCFZXDGSGy2
   apEpntQDQ9FiohFK/eNe4Mp+9oj5rxGwFUTuqoGg4OlPIroZClTdf9jMq
   YX28Gope/8ev8Bvu1XsVSeDE2a5tqtGj8eFNr03GTp7clXWH52GZVJ/VP
   aY6bZXiO3t+TFhcAGqVqCZm4a/YyB9I5hq7QHWRVeebAhazn6JpxO+E0S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013383"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013383"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775899"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775899"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:25 -0700
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
Subject: [PATCH v3 17/17] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Mon, 24 Jul 2023 04:04:06 -0700
Message-Id: <20230724110406.107212-18-yi.l.liu@intel.com>
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

Add a mock_domain_cache_invalidate_user() and a corresponding struct
iommu_hwpt_invalidate_selftest, to allow to test IOMMU_HWPT_INVALIDATE
from user space, by using the new IOMMU_TEST_OP_MD_CHECK_IOTLB.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          | 10 ++++++++++
 drivers/iommu/iommufd/selftest.c              | 19 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  8 ++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 20 +++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 93fcbb57b904..9768d0c9e347 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -135,4 +135,14 @@ struct iommu_hwpt_selftest {
 	__u64 test_config;
 };
 
+/**
+ * struct iommu_hwpt_invalidate_selftest
+ *
+ * @flags: invalidate flags
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_ALL	(1ULL << 0)
+	__u64 flags;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 92c37716804e..5f3e1f2a24e7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -395,9 +395,28 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static int mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+					     void *user_data)
+{
+	struct iommu_hwpt_invalidate_selftest *inv_info = user_data;
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+
+	if (domain->type != IOMMU_DOMAIN_NESTED || !mock->parent)
+		return -EINVAL;
+
+	if (inv_info->flags & IOMMU_TEST_INVALIDATE_ALL)
+		mock->iotlb = 0;
+
+	return 0;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.cache_invalidate_user_data_len =
+		sizeof(struct iommu_hwpt_invalidate_selftest),
 };
 
 static struct iommu_device mock_iommu_device = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 942860365cb6..bf0082d88a38 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -115,6 +115,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
 	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
 	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
+	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE);
 	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
 	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
 	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
@@ -323,6 +324,13 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
+		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		test_err_cmd_hwpt_invalidate(EINVAL, parent_hwpt_id);
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0]);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0);
+		test_cmd_hwpt_invalidate(nested_hwpt_id[1]);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[1], 0);
+
 		/* Attach device to nested_hwpt_id[0] that then will be busy */
 		test_cmd_mock_domain_replace(self->stdev_id,
 					     nested_hwpt_id[0]);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 5e75dfac65e9..9b3e5f36c4a3 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -169,6 +169,26 @@ static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
 		     _test_cmd_hwpt_alloc_nested(self->fd, device_id,         \
 						 parent_id, hwpt_id))
 
+static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id)
+{
+	struct iommu_hwpt_invalidate_selftest data = {
+		.flags = IOMMU_TEST_INVALIDATE_ALL,
+	};
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = hwpt_id,
+		.data_len = sizeof(data),
+		.data_uptr = (uint64_t)&data,
+	};
+
+	return ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+}
+
+#define test_cmd_hwpt_invalidate(hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_invalidate(self->fd, hwpt_id))
+#define test_err_cmd_hwpt_invalidate(_errno, hwpt_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_hwpt_invalidate(self->fd, hwpt_id))
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
-- 
2.34.1

