Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB54C8A
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vs3yMy7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295194; x=1729831194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=raHfLOyUT/cgO/Fuk4Cjp01wel7WAQ3Es/qEWcqGals=;
  b=Vs3yMy7zjm13bDhTlE3Qj1R+j+0MbJtO0tokr/2aS7A0Q5kIY54+5Ox3
   EEou/gksnDYBg0h7lqwFfp+yXVDI6ZmD4TsUB9Kom/Ki3Otb1fO1oVB60
   Z4iMD2NR9bd66kGz64fB+nfolqRMZ6ANO/sni3e6zfTZFQ4I5ux3lCu9H
   akS1cVb9tt/3+H0mj7pzEy6IMc6t/W/ITF6RuL8sUG6/wP5b4zZnRD0pf
   /78DsJbEvJDHD5ZUrUW7hAA3aSieRBiaNzctvTo3Hlit6f6rvSc0Fm0wL
   pVejyo7XU4zniSdBMi++VIGtjR5MtiLZ7KyoY8ip7ZYQhr8PkXowFVStH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014552"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931357"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931357"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:46 -0700
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
	xin.zeng@intel.com
Subject: [PATCH v7 10/10] iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs
Date: Wed, 25 Oct 2023 21:39:38 -0700
Message-Id: <20231026043938.63898-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026043938.63898-1-yi.l.liu@intel.com>
References: <20231026043938.63898-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

The IOMMU_HWPT_ALLOC ioctl now supports passing user_data to allocate a
user-managed domain for nested HWPTs. Add its coverage for that. Also,
update _test_cmd_hwpt_alloc() and add test_cmd/err_hwpt_alloc_nested().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 115 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  30 +++--
 3 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 76a4351e3434..6ed328c863c4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -264,6 +264,121 @@ TEST_F(iommufd_ioas, ioas_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, alloc_hwpt_nested)
+{
+	const uint32_t min_data_len =
+		offsetofend(struct iommu_hwpt_selftest, iotlb);
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id[2] = {};
+	uint32_t parent_hwpt_id = 0;
+	uint32_t parent_hwpt_id_not_work = 0;
+	uint32_t test_hwpt_id = 0;
+
+	if (self->device_id) {
+		/* Negative tests */
+		test_err_hwpt_alloc(ENOENT, self->ioas_id, self->device_id, 0,
+				    &test_hwpt_id);
+		test_err_hwpt_alloc(EINVAL, self->device_id, self->device_id, 0,
+				    &test_hwpt_id);
+
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &parent_hwpt_id);
+
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
+				    &parent_hwpt_id_not_work);
+
+		/* Negative nested tests */
+		test_err_hwpt_alloc_nested(EINVAL, self->device_id,
+					   parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_NONE, &data,
+					   sizeof(data));
+		test_err_hwpt_alloc_nested(EOPNOTSUPP, self->device_id,
+					   parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST + 1, &data,
+					   sizeof(data));
+		test_err_hwpt_alloc_nested(EINVAL, self->device_id,
+					   parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   min_data_len - 1);
+		test_err_hwpt_alloc_nested(EFAULT, self->device_id,
+					   parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST, NULL,
+					   sizeof(data));
+		test_err_hwpt_alloc_nested(
+			EOPNOTSUPP, self->device_id, parent_hwpt_id,
+			IOMMU_HWPT_ALLOC_NEST_PARENT, &nested_hwpt_id[0],
+			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+		test_err_hwpt_alloc_nested(EINVAL, self->device_id,
+					   parent_hwpt_id_not_work, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+
+		/* Allocate two nested hwpts sharing one common parent hwpt */
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id, 0,
+					   &nested_hwpt_id[1],
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+
+		/* Negative test: a nested hwpt on top of a nested hwpt */
+		test_err_hwpt_alloc_nested(EINVAL, self->device_id,
+					   nested_hwpt_id[0], 0, &test_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		/* Negative test: parent hwpt now cannot be freed */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
+
+		/* Attach device to nested_hwpt_id[0] that then will be busy */
+		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id[0]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[0]));
+
+		/* Switch from nested_hwpt_id[0] to nested_hwpt_id[1] */
+		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id[1]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[1]));
+		test_ioctl_destroy(nested_hwpt_id[0]);
+
+		/* Detach from nested_hwpt_id[1] and destroy it */
+		test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id[1]);
+
+		/* Detach from the parent hw_pagetable and destroy it */
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(parent_hwpt_id);
+		test_ioctl_destroy(parent_hwpt_id_not_work);
+	} else {
+		test_err_hwpt_alloc(ENOENT, self->device_id, self->ioas_id, 0,
+				    &parent_hwpt_id);
+		test_err_hwpt_alloc_nested(ENOENT, self->device_id,
+					   parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_err_hwpt_alloc_nested(ENOENT, self->device_id,
+					   parent_hwpt_id, 0,
+					   &nested_hwpt_id[1],
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     nested_hwpt_id[0]);
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     nested_hwpt_id[1]);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index ff735bdd833e..f590417cd67a 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,7 +615,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info), NULL))
 		return -1;
 
-	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id))
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id,
+				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index e263bf80a977..050e9751321c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -154,13 +154,17 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 							   pt_id, NULL))
 
 static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
-				__u32 flags, __u32 *hwpt_id)
+				__u32 flags, __u32 *hwpt_id, __u32 data_type,
+				void *data, size_t data_len)
 {
 	struct iommu_hwpt_alloc cmd = {
 		.size = sizeof(cmd),
 		.flags = flags,
 		.dev_id = device_id,
 		.pt_id = pt_id,
+		.data_type = data_type,
+		.data_len = data_len,
+		.data_uptr = (uint64_t)data,
 	};
 	int ret;
 
@@ -172,12 +176,24 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 	return 0;
 }
 
-#define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id) \
-	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, \
-					  pt_id, flags, hwpt_id))
-#define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id) \
-	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, \
-						  pt_id, flags, hwpt_id))
+#define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id)                  \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,   \
+					  hwpt_id, IOMMU_HWPT_DATA_NONE, NULL, \
+					  0))
+#define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)   \
+	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(                      \
+				     self->fd, device_id, pt_id, flags, \
+				     hwpt_id, IOMMU_HWPT_DATA_NONE, NULL, 0))
+
+#define test_cmd_hwpt_alloc_nested(device_id, pt_id, flags, hwpt_id,         \
+				   data_type, data, data_len)                \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
+					  hwpt_id, data_type, data, data_len))
+#define test_err_hwpt_alloc_nested(_errno, device_id, pt_id, flags, hwpt_id, \
+				   data_type, data, data_len)                \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
+					  hwpt_id, data_type, data, data_len))
 
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
-- 
2.34.1

