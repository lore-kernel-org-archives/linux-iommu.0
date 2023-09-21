Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6268C01
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282754; x=1726818754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnoyrdNaukKvkcgP5+o7fz8ah/R0pg8Imwn58lDhpQA=;
  b=L8meungJ9O9gK79zqdMpS3EKYOtOi89fnAY+F05CjfsE4ENBua7MuXG5
   LAsBPFgOGNPY06lIRIeG1lTfDTQlzdA782I7Gd07PcXL478XD7gcCpVf1
   TcQKEID1YZ6rnaa7ME7j+Mu0Gsoe7DEYH5K6igY6/a3n2sEUVT7EzOP5g
   ROSRhr5q12KNf8AAFraN5fLe50S7x0PsUNSJHHuSlTOJIAGlyLiQyyaus
   Iv8bK3omkUoUyh0L4qi63P+x+Sj9qy3cZ38CvbFbZbaMQVojocmSWEjTW
   Af/gxy6+nlG/dtNyU5CaceC4uQzcS68r7IkF3yYxGD+fnV18FdrnNM5rv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832973"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832973"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649586"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649586"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:18 -0700
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
	joao.m.martins@oracle.com
Subject: [PATCH v4 15/17] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date: Thu, 21 Sep 2023 00:51:36 -0700
Message-Id: <20230921075138.124099-16-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
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

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 17 +++++++++++
 drivers/iommu/iommufd/selftest.c     | 44 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7f997234a1a8..748349dd5bf4 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -127,4 +127,21 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+/**
+ * struct iommu_hwpt_invalidate_selftest
+ *
+ * @flags: invalidate flags
+ * @iotlb_id: invalidate iotlb entry index
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @iotlb_id will be ignored
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_ALL	(1ULL << 0)
+	__u32 flags;
+	__u32 iotlb_id;
+};
+
+#define IOMMU_TEST_INVALIDATE_ERR_FETCH	0xdeadbeee
+#define IOMMU_TEST_INVALIDATE_ERR_REQ	0xdeadbeef
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index bd967317927f..ebb2abc40c4a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -428,9 +428,53 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array,
+				  u32 *error_code)
+{
+	const size_t min_len =
+		offsetofend(struct iommu_hwpt_invalidate_selftest, iotlb_id);
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	struct iommu_hwpt_invalidate_selftest inv;
+	int rc = 0;
+	int i, j;
+
+	if (domain->type != IOMMU_DOMAIN_NESTED || !mock->nested)
+		return -EINVAL;
+
+	for (i = 0; i < array->entry_num; i++) {
+		rc = iommu_copy_user_data_from_array(&inv, array,
+						     i, sizeof(inv), min_len);
+		if (rc) {
+			*error_code = IOMMU_TEST_INVALIDATE_ERR_FETCH;
+			goto err;
+		}
+		/* Invalidate all mock iotlb entries and ignore iotlb_id */
+		if (inv.flags & IOMMU_TEST_INVALIDATE_ALL) {
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock->iotlb[j] = 0;
+			continue;
+		}
+		/* Treat out-of-boundry iotlb_id as a request error */
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			*error_code = IOMMU_TEST_INVALIDATE_ERR_REQ;
+			rc = -EINVAL;
+			goto err;
+		}
+		mock->iotlb[inv.iotlb_id] = 0;
+	}
+
+err:
+	array->entry_num = i;
+	return rc;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
 };
 
 static inline struct iommufd_hw_pagetable *
-- 
2.34.1

