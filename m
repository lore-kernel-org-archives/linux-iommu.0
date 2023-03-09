Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B952590
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349401; x=1709885401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSs8JiamAMJ1gh9lxGGRXZ1q0y+gsHyMnNUluMbRLa8=;
  b=HCbyRyjlteziCfaR7usvrMR4EdjEGO4e2Xth3JoIN98m7p+vV7P0lelV
   ty4pCrcdSslgBswKlF2Or82UUaqsbaEaf+1p9lRpQj2y/n6wAaCFiUkqJ
   pVxYyqaJGcmstgCzedQpDM7svzgEZDIJJYJM7wik2CdMkLRCF/jqnIvsB
   lbtLA/2LjCKsjMdsTVmw3YeaLmbUtcRuL+nE+MsMBrIm/2/MmF7Eri9Q7
   FCEHX0StVemHepAUglM9LaNrmP031yVqu+X04nCerIcTu3BLwnJmdJpgY
   N9M8zg4XBpNKxaJ/vR2Ik+nufOkUNkRz+vogqvKPhzOj1kc8kYdzfQBxi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023241"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023241"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471448"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471448"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:47 -0800
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH 12/12] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Thu,  9 Mar 2023 00:09:10 -0800
Message-Id: <20230309080910.607396-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/hw_pagetable.c          | 10 +++++++--
 drivers/iommu/iommufd/iommufd_test.h          | 10 +++++++++
 drivers/iommu/iommufd/selftest.c              | 15 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  8 +++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 0871da848447..15dd1743d888 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -339,7 +339,8 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 	 * data_len should not exceed the size of iommufd_invalidate_buffer.
 	 */
 	if (cmd->data_type == IOMMU_HWPT_TYPE_DEFAULT || !cmd->data_len ||
-	    cmd->data_type >= ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))
+	    (cmd->data_type != IOMMU_HWPT_TYPE_SELFTTEST &&
+	     cmd->data_type >= ARRAY_SIZE(iommufd_hwpt_invalidate_info_size)))
 		return -EOPNOTSUPP;
 
 	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
@@ -352,7 +353,12 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
-	klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
+	if (cmd->data_type != IOMMU_HWPT_TYPE_SELFTTEST)
+		klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		klen = sizeof(struct iommu_hwpt_invalidate_selftest);
+#endif
 	if (!klen) {
 		rc = -EINVAL;
 		goto out_put_hwpt;
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 4b60a6df0428..090e9d6abd87 100644
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
index a0d57f00f759..fe1caba9e2c5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -351,9 +351,24 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static void mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+					      void *user_data)
+{
+	struct iommu_hwpt_invalidate_selftest *inv_info = user_data;
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+
+	if (domain->type != IOMMU_DOMAIN_NESTED || !mock->parent)
+		return;
+
+	if (inv_info->flags & IOMMU_TEST_INVALIDATE_ALL)
+		mock->iotlb = 0;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
 };
 
 struct iommu_device mock_iommu_device = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 10f1592dc9e7..89a44479835d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -126,6 +126,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
 	TEST_LENGTH(iommu_hw_info, IOMMU_DEVICE_GET_HW_INFO);
 	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
+	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE);
 #undef TEST_LENGTH
 }
 
@@ -326,6 +327,13 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
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
index 211798190e5b..b1592b4f2049 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -167,6 +167,27 @@ static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
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
+		.data_type = IOMMU_HWPT_TYPE_SELFTTEST,
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
 static int _test_cmd_access_set_ioas(int fd, __u32 access_id,
 				     unsigned int ioas_id)
 {
-- 
2.34.1

