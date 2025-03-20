Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBF221F3A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478479; cv=none; b=oKQaXM1L9AkbclfMKGG8v/BZb58QvHVlEj9zYYJ/R494Q/+U67Yyhc0BYFM6tTrYjDnpyUpMJyCHwHTgnGEuSrliOAPBfanwlw0WAIFbJ4u2XzjuPKZzD0AItd+S4HgBlGWowSGq47ns/n1xHmYqb3gDh4S2J2Rc6WzBHCrAKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478479; c=relaxed/simple;
	bh=WGp0L982uazU3H2i0WCVGNWjXQHQC735ku8IPGA4aHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoEIZ2dEaMlJxxy9lUHpuo1FBbNZgqrwresXLbHq6/lmHlqoV7Yu5D78T1uAr6UokXnAw38xQ50zppY7+3eaqF4i3a1TdXJLzDXo1OFjqNlUgTKzOU3IP0ku47c/hbDOaoXwGGgx5+OQuphGQJV3abxLk8T7plEi94NFlQVWE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh/SvhHj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh/SvhHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478478; x=1774014478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGp0L982uazU3H2i0WCVGNWjXQHQC735ku8IPGA4aHY=;
  b=Yh/SvhHjFloPaDuLiWP5i/d7+SWDWRjvkmIDMEPrFlyG8BFW7soO201b
   xBp5pvVtRy6/lYzo5HFjxeQ/AC8vsV1JaIcS5CKdDjNVKIuz+MyKKiq4x
   6UucCTsYXosedYmPOrCbGwJrlsCxbzwTrIr2FkOkedFUo5xHBPuwaYUqn
   0V/fJz8q2tFZ/Wkgg//Q6Quh8etbqT+P9IfWKSKD8yYbk0agySdWndyq+
   ZKXVxENgx36PuQEYgURPMloCzTpGFR8yHz9C0jdMFjm084ME+dc03iCGt
   EFhmleTe5QnkvSGwCMKaAJrb3R2/J/RZ54bgm3kL9Xk38uAfJ7D8Hq2Fa
   A==;
X-CSE-ConnectionGUID: BYYgl7GaQbulP+2JtfUE4Q==
X-CSE-MsgGUID: 3lC9tTU8QfqnfGhgdM7ENA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063090"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: rgqFeY3pRGKlYcI26q+6/Q==
X-CSE-MsgGUID: wwMthMkQQlqiKUKZT78JvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319198"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:49 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Thu, 20 Mar 2025 06:47:43 -0700
Message-Id: <20250320134744.5777-18-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/iommufd_test.h |  31 ++++++
 drivers/iommu/iommufd/selftest.c     | 151 +++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1a066feb8697..efcb509f7d56 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -25,6 +25,11 @@ enum {
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
 	IOMMU_TEST_OP_TRIGGER_VEVENT,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
 };
 
 enum {
@@ -150,6 +155,32 @@ struct iommu_test_cmd {
 		struct {
 			__u32 dev_id;
 		} trigger_vevent;
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
index 691e7a23f300..37c9cd285541 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -223,10 +223,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
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
 
@@ -1683,6 +1702,129 @@ static int iommufd_test_trigger_vevent(struct iommufd_ucmd *ucmd,
 	return rc;
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
@@ -1766,6 +1908,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_trigger_iopf(ucmd, cmd);
 	case IOMMU_TEST_OP_TRIGGER_VEVENT:
 		return iommufd_test_trigger_vevent(ucmd, cmd);
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
@@ -1813,6 +1963,7 @@ int __init iommufd_test_init(void)
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 	mock_iommu.iommu_dev.max_pasids = (1 << MOCK_PASID_WIDTH);
+	pasid_1024_attached = false;
 
 	return 0;
 
-- 
2.34.1

