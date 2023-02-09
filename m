Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B8648
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917148; x=1707453148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCH59LZj1tXUKHsvjYU9esem/j0fJFX1kfEeZP2CZtg=;
  b=MSf6FZZPFBkPxJ2LaQSZJP2PFUkfaQRF5NyWvdONbV/qo9i5n42YPR1D
   /THGN2KQ4REyoYy4ZaQLp1F5h0miFgmJUH/IbQEXqxaJmZS/RG3HMLCim
   Mok6lpIXGJMkpiX7SGOn7yFGCNi8+HEY4UzMsD3YMt/1EVCDCE5/Ls63/
   qUHBO6PH5WqdpAJ4f1+yWGEIUhUg55nMuWwRn10O3TgfJ/SapaAnhXJ7t
   RTQ4svCOvM3BGgpnbeGx6OSwqoc5n1yhnbTMyYvs4y7AeoXVp3pdlZ8PJ
   R+qF2INsypR9tqnVfU8UT4UV4Z2WWgHm2PNCIboRoFEHnyzo1MTs9SMGq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298855"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298855"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447600"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447600"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:23 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 14/17] iommufd/selftest: Add IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE test op
Date: Wed,  8 Feb 2023 20:31:50 -0800
Message-Id: <20230209043153.14964-15-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

This allows to detach/attach the mock_dev to a specified domain/hwpt.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c       |  1 -
 drivers/iommu/iommufd/iommufd_test.h |  5 +++
 drivers/iommu/iommufd/selftest.c     | 54 ++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 826441c6005d..bf803975062c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -964,7 +964,6 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
  * Creating a real iommufd_device is too hard, bypass creating a iommufd_device
  * and go directly to attaching a domain.
  */
-
 int iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 				   struct iommufd_hw_pagetable *hwpt)
 {
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1605ff2b1a90..a73ab51afe79 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -10,6 +10,7 @@
 enum {
 	IOMMU_TEST_OP_ADD_RESERVED = 1,
 	IOMMU_TEST_OP_MOCK_DOMAIN,
+	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 	IOMMU_TEST_OP_MD_CHECK_MAP,
 	IOMMU_TEST_OP_MD_CHECK_REFS,
 	IOMMU_TEST_OP_CREATE_ACCESS,
@@ -53,6 +54,10 @@ struct iommu_test_cmd {
 			__u32 out_device_id;
 			__u32 out_hwpt_id;
 		} mock_domain;
+		struct {
+			__u32 device_id;
+			__u32 hwpt_id;
+		} mock_domain_replace;
 		struct {
 			__aligned_u64 iova;
 			__aligned_u64 length;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5f841d1d9e96..3623a42648d5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -98,6 +98,7 @@ struct selftest_obj {
 	union {
 		struct {
 			struct iommufd_hw_pagetable *hwpt;
+			struct iommufd_ioas *ioas;
 			struct iommufd_ctx *ictx;
 			struct device mock_dev;
 		} idev;
@@ -308,6 +309,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.ictx = ucmd->ictx;
 	sobj->type = TYPE_IDEV;
+	sobj->idev.ioas = ioas;
 	sobj->idev.mock_dev.bus = &mock_bus;
 	sobj->idev.mock_dev.iommu = &iommu;
 
@@ -341,6 +343,56 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/* Replace the mock domain with a manually allocated hw_pagetable */
+static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
+					    struct iommu_test_cmd *cmd)
+{
+	struct iommufd_object *dev_obj, *hwpt_obj;
+	struct iommufd_hw_pagetable *hwpt;
+	struct selftest_obj *sobj;
+	int rc;
+
+	hwpt_obj = iommufd_get_object(ucmd->ictx,
+				      cmd->mock_domain_replace.hwpt_id,
+				      IOMMUFD_OBJ_HW_PAGETABLE);
+	if (IS_ERR(hwpt_obj))
+		return PTR_ERR(hwpt_obj);
+
+	hwpt = container_of(hwpt_obj, struct iommufd_hw_pagetable, obj);
+
+	dev_obj = iommufd_get_object(ucmd->ictx,
+				     cmd->mock_domain_replace.device_id,
+				     IOMMUFD_OBJ_SELFTEST);
+	if (IS_ERR(dev_obj)) {
+		rc = PTR_ERR(dev_obj);
+		goto out_hwpt_obj;
+	}
+
+	sobj = container_of(dev_obj, struct selftest_obj, obj);
+	if (sobj->type != TYPE_IDEV) {
+		rc = -EINVAL;
+		goto out_dev_obj;
+	}
+
+	iommufd_device_selftest_detach(sobj->idev.ictx, sobj->idev.hwpt);
+
+	rc = iommufd_device_selftest_attach(ucmd->ictx, hwpt);
+	if (rc)
+		goto out_reattach;
+	sobj->idev.hwpt = hwpt;
+
+	rc = 0;
+	goto out_dev_obj;
+
+out_reattach:
+	iommufd_device_selftest_attach(ucmd->ictx, sobj->idev.hwpt);
+out_dev_obj:
+	iommufd_put_object(dev_obj);
+out_hwpt_obj:
+	iommufd_put_object(hwpt_obj);
+	return rc;
+}
+
 /* Add an additional reserved IOVA to the IOAS */
 static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
 				     unsigned int mockpt_id,
@@ -847,6 +899,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 						 cmd->add_reserved.length);
 	case IOMMU_TEST_OP_MOCK_DOMAIN:
 		return iommufd_test_mock_domain(ucmd, cmd);
+	case IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE:
+		return iommufd_test_mock_domain_replace(ucmd, cmd);
 	case IOMMU_TEST_OP_MD_CHECK_MAP:
 		return iommufd_test_md_check_pa(
 			ucmd, cmd->id, cmd->check_map.iova,
-- 
2.34.1

