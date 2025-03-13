Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41F26659C
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869362; cv=none; b=W7+iWHR2EdQsvkfVWI2a/72cUMu0CxZe60UW7Wa7jPFVIykW2+u3gwa1FkV2bj0vGckNSsZ/KhJiOJoGHuKKJsrLgcQ8cJ/p0m8yb2hF6DACgkD3CqFFutStqIsbw9zTGM36L7WFc9Sy7p5breA3k3fv8cNbIvQj3ZTNP5pCrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869362; c=relaxed/simple;
	bh=+n7kgAtrBtGxhNwDrjU/n2dnwPEDxYzT0t1ScOGiRKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmTg4A8LYckDoCr5AdcXCfnUFLq91BybQBUvoLfwdK30XsYDxl5zpquShNQJU5DeRTGzGCetUoZ41IioMus3D7IAMz/dBh/LSqI9t7kX7l2wojSM5OaJeNJUHobKZcZvz46orZCZDlupdTPIvA2by2Zaul8eARPnlACIWykKLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foePIm9x; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foePIm9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869360; x=1773405360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+n7kgAtrBtGxhNwDrjU/n2dnwPEDxYzT0t1ScOGiRKM=;
  b=foePIm9xFWxj3DIxhfXKb5Qp82/noo1BtP3APZtkX8RopMq+5I5vqiKp
   YSTJFUPbmtTPtjfYN1vZtpcIUALosQdwy+CfHg5LQ9HdUpdtwHXQUIrSf
   LifCkyBTiai1ztocSpva7v3vRp2jmLzdtgSiG4hBVv4en2Tz8BnrcsnUK
   QWjyHOXxbp4gqqBhmZAbRbD9sbqYVSvY1kwbyvTeu7v6aRzLLoGt3Z5dB
   hgbuMj3GF7suUZZeK0nXQi9NAZJIEs+i3FB1P0cLpcsPyAbDZKjejqYRQ
   tY+ydg0aTLbDwva3yzuzPwIylWN/C7mRG++i0EDipwwKyazFEGsYqtGKo
   g==;
X-CSE-ConnectionGUID: DoeIlVMhSCKYcm8/PRucOw==
X-CSE-MsgGUID: H7ABDIPeQiCv0b6jztAWng==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863996"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:42 -0700
X-CSE-ConnectionGUID: /6I5Yd1lS3+ioF9n4VJR1w==
X-CSE-MsgGUID: pyg5sZ4lSoSvtbh8ThNrXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005563"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:42 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 20/21] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Thu, 13 Mar 2025 05:35:31 -0700
Message-Id: <20250313123532.103522-21-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds 5 test ops for pasid attach/replace/detach testing. There are
ops to attach/detach pasid, and also op to check the attached domain of
a pasid.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v8 -> v9: Dropped the code for mixed_replace test
---
 drivers/iommu/iommufd/iommufd_test.h |  31 ++++++
 drivers/iommu/iommufd/selftest.c     | 151 +++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index bdc979557272..d034b6b8266a 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,11 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
 };
 
 enum {
@@ -146,6 +151,32 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 cache;
 		} check_dev_cache;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id
+			 * pasid#1024 is for special test, do not use it
+			 * in normal case.
+			 */
+		} pasid_attach;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id
+			 * pasid#1024 is for special test, do not use it
+			 * in normal case.
+			 */
+		} pasid_replace;
+		struct {
+			__u32 pasid;
+			/* @id is stdev_id */
+		} pasid_detach;
+		struct {
+			__u32 pasid;
+			__u32 hwpt_id;
+			__u64 out_result_ptr;
+			/* @id is stdev_id */
+		} pasid_check;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d5b662d1671b..25df7aaadad7 100644
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
 
@@ -1631,6 +1650,129 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
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
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
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
+static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
+				   &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_sobj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		iommufd_device_detach(sobj->idev.idev,
+				      cmd->pasid_attach.pasid);
+
+out_sobj:
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
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
+				    &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_sobj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_sobj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return 0;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1712,6 +1854,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
@@ -1759,6 +1909,7 @@ int __init iommufd_test_init(void)
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 	mock_iommu.iommu_dev.max_pasids = (1 << 20);
+	pasid_1024_attached = false;
 
 	return 0;
 
-- 
2.34.1

