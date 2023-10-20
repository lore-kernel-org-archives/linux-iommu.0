Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5F12E51
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJC35/Nv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793874; x=1729329874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmwgRc80fGvIZ+07OlU/ados8MLJWNBOFdMd2h2m8n4=;
  b=VJC35/NvUHL2UWrDxVedvhwKMFBBf4sjOAiRY1lHOoIy6daOVNsq9qlE
   vElZipWj1ZWwRWj+JSAL8YXoghBqt1m9m6u2nwpv9RnDHFjDkjhfTuPZV
   ZUtSHLxvRn18YCJ2anKehaE00tnZs2QHhB0WB77D0AGv87ealzNmkFb+U
   9Q41NCiOzmj0IzF+kwbQrMbk6wn8pKhlcxRE6Kb44DW5NLd701psjVY1j
   sPHjr7dr5onY020+cdnplzD8UWWHMaYPTj7uRh3SM9na0pEC0zTUj5OhG
   shjr708btBwOL0iHxFcPNA89NQsedzIVHErfwKpMuGgexvFWYeYwlUxyb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472685510"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472685510"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750859682"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750859682"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2023 02:24:30 -0700
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
Subject: [PATCH v5 4/6] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date: Fri, 20 Oct 2023 02:24:24 -0700
Message-Id: <20231020092426.13907-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020092426.13907-1-yi.l.liu@intel.com>
References: <20231020092426.13907-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/selftest.c     | 43 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 440ec3d64099..a96838516db9 100644
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
index 5f513c5d6876..abd942cf3a79 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -404,9 +404,52 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(mock_nested);
 }
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array,
+				  u32 *error_code)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+	struct iommu_hwpt_invalidate_selftest inv;
+	int rc = 0;
+	int i, j;
+
+	if (domain->type != IOMMU_DOMAIN_NESTED)
+		return -EINVAL;
+
+	for (i = 0; i < array->entry_num; i++) {
+		rc = iommu_copy_struct_from_user_array(&inv, array,
+						       IOMMU_HWPT_DATA_SELFTEST,
+						       i, iotlb_id);
+		if (rc) {
+			*error_code = IOMMU_TEST_INVALIDATE_ERR_FETCH;
+			goto err;
+		}
+		/* Invalidate all mock iotlb entries and ignore iotlb_id */
+		if (inv.flags & IOMMU_TEST_INVALIDATE_ALL) {
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock_nested->iotlb[j] = 0;
+			continue;
+		}
+		/* Treat out-of-boundry iotlb_id as a request error */
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			*error_code = IOMMU_TEST_INVALIDATE_ERR_REQ;
+			rc = -EINVAL;
+			goto err;
+		}
+		mock_nested->iotlb[inv.iotlb_id] = 0;
+	}
+
+err:
+	array->entry_num = i;
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

