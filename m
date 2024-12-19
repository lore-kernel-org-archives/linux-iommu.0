Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B1226162
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614880; cv=none; b=A6nf4DKb2YOqDHK4GTE0szv2isfKRcx9PlAhMXWH5Ja4PZIzaLgiJH7cZ+8z5IhNnb8tx2Y3pcErsmj4vRz8AhgWj2qRkBUGLesZb2y++eVc6e/NVc3HBOJPs51fU94bbsRt/lRX8V3Oe9PKH+9vn2a9Il437Ixu6QLsLuOYwDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614880; c=relaxed/simple;
	bh=KSCZPhSkCV7VsrXUHQGEcpzO0fucWSD+GH/d58mUwZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnsSwvHBeOBJX/WNO9Xnw/Hyrxs8EZjvU1Vb7UPlpOjAowUMpdnHthNHLr8o/L3hRJzEkaevT3/h3CUTnhLXWOzzd57mP4b6INFkBAdCjWY4az4IrIEzvM4SU3lWN1drO3+ZWh081UPWUhex+hQjhe+e0qRTRtJA6Zqi04sKK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ixy9qLee; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ixy9qLee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614878; x=1766150878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSCZPhSkCV7VsrXUHQGEcpzO0fucWSD+GH/d58mUwZQ=;
  b=Ixy9qLeevC4rhTEkfInxp3zIPjA9Cqv+oGgytpKWR6OpkdMThFi9cz2a
   7wsdeXk4dd/e6mxEKMv/0rAIiSHiqQUd86L8dmFeiJpmLD3pzhFtnlSkb
   9W+982x1A3MTQIRyYxFyXOlS8cBqaE9Xm9OAKJwPMwvrkBmdDjXFp1zjH
   0hHbCHvNAwoHZXmAk+Tre4+cLJVYK8UQAVScNV124sc2w/CgU3fu5cEBD
   l7VgDNJUjiuU7wNDLv+MRuPufoP0iI+VH6SRBsBvlc+ty0spIDj6SnB+d
   3Omjfk3tfqlwNLNkBo9aXUbmdxjckBQK+831Zna3tMncCmPrkMbFyub36
   w==;
X-CSE-ConnectionGUID: EBg2FNHoStqP6Yv431ODsA==
X-CSE-MsgGUID: 1P1CwS7bRmqiSIIBCekBKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542322"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542322"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:51 -0800
X-CSE-ConnectionGUID: ivDjIhpNRR2xwCV4XH3lNw==
X-CSE-MsgGUID: DFiyjWNoSD+gpW5wZqpYPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177345"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:51 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 13/14] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Thu, 19 Dec 2024 05:27:45 -0800
Message-Id: <20241219132746.16193-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds 4 test ops for pasid attach/replace/detach testing. There are
ops to attach/detach pasid, and also op to check the attached domain of
a pasid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  30 ++++++
 drivers/iommu/iommufd/selftest.c     | 154 +++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index bdc979557272..b3af7db97bc0 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,10 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
 };
 
 enum {
@@ -146,6 +150,32 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 cache;
 		} check_dev_cache;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_ATTACH
+			 * pasid#1024 is for special test, avoid use it
+			 * in normal case.
+			 */
+		} pasid_attach;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_ATTACH
+			 * pasid#1024 is for special test, avoid use it
+			 * in normal case.
+			 */
+		} pasid_replace;
+		struct {
+			__u32 pasid;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_DETACH */
+		} pasid_detach;
+		struct {
+			__u32 pasid;
+			__u32 hwpt_id;
+			__u64 out_result_ptr;
+			/* @id is stdev_id for IOMMU_TEST_OP_HWPT_GET_DOMAIN */
+		} pasid_check;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 515435640e35..289221c7b3b5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -200,10 +200,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 	return 0;
 }
 
+static bool pasid_1024_attached;
+
 static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
 					 struct device *dev, ioasid_t pasid,
 					 struct iommu_domain *old)
 {
+	/*
+	 * First attach with pasid 1024 succ, second attach would fail.
+	 * This is helpful to test the case in which the iommu core needs
+	 * to rollback to old domain due to driver failure.
+	 */
+	if (pasid == 1024) {
+		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
+			pasid_1024_attached = false;
+		} else if (pasid_1024_attached) {
+			pasid_1024_attached = false;
+			// Fake an error to fail the replacement
+			return -ENOMEM;
+		} else {
+			pasid_1024_attached = true;
+		}
+	}
+
 	return 0;
 }
 
@@ -1643,6 +1662,132 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_pasid_attach(sobj->idev.idev,
+					 cmd->pasid_attach.pasid,
+					 &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_dev_obj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		iommufd_device_pasid_detach(sobj->idev.idev,
+					    cmd->pasid_attach.pasid);
+
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
+				      struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_pasid_replace(sobj->idev.idev,
+					  cmd->pasid_attach.pasid,
+					  &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_dev_obj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	iommufd_device_pasid_detach(sobj->idev.idev,
+				    cmd->pasid_detach.pasid);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return 0;
+}
+
+static inline struct iommufd_hw_pagetable *
+iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
+{
+	struct iommufd_object *pt_obj;
+
+	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj))
+		return ERR_CAST(pt_obj);
+
+	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
+	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
+		iommufd_put_object(ucmd->ictx, pt_obj);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+}
+
+static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
+					   struct iommu_test_cmd *cmd)
+{
+	struct iommu_domain *attached_domain, *expect_domain = NULL;
+	struct iommufd_hw_pagetable *hwpt = NULL;
+	struct iommu_attach_handle *handle;
+	struct selftest_obj *sobj;
+	struct mock_dev *mdev;
+	bool result;
+	int rc = 0;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	mdev = sobj->idev.mock_dev;
+
+	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
+					 cmd->pasid_check.pasid, 0);
+	if (IS_ERR(handle))
+		attached_domain = NULL;
+	else
+		attached_domain = handle->domain;
+
+	if (cmd->pasid_check.hwpt_id) {
+		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
+		if (IS_ERR(hwpt)) {
+			rc = PTR_ERR(hwpt);
+			goto out_put_dev;
+		}
+		expect_domain = hwpt->domain;
+	}
+
+	result = (attached_domain == expect_domain) ? 1 : 0;
+	if (copy_to_user(u64_to_user_ptr(cmd->pasid_check.out_result_ptr),
+			 &result, sizeof(result)))
+		rc = -EFAULT;
+	if (hwpt)
+		iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_put_dev:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1724,6 +1869,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.flags);
 	case IOMMU_TEST_OP_TRIGGER_IOPF:
 		return iommufd_test_trigger_iopf(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_ATTACH:
+		return iommufd_test_pasid_attach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_REPLACE:
+		return iommufd_test_pasid_replace(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_DETACH:
+		return iommufd_test_pasid_detach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_CHECK_DOMAIN:
+		return iommufd_test_pasid_check_domain(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1771,6 +1924,7 @@ int __init iommufd_test_init(void)
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 	mock_iommu.iommu_dev.max_pasids = (1 << 20);
+	pasid_1024_attached = false;
 
 	return 0;
 
-- 
2.34.1

