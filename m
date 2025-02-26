Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D62153E9
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570044; cv=none; b=sVBcalBJdQQpdMmRVgD0vIgNVO2qdWTtBuk2KtlEUHRfKYt3ts9y6OOoXRdlNzD3wwZ7gZKK0zyW8Ieefc5sNqZK2PKkhpJQ2+20DryID9n1Pfs426rJ9NDt9elr8Ji/qDMy9Lxwv/Ot5clEWnVkkIZZ7r6A8a66nNWnDQpS7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570044; c=relaxed/simple;
	bh=Ik1KRcPcv/7hHx5afwifoehJUAXtVKFZMxBEVQmpcHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IOY1MsKBUMqv+NA5giSiEq98yc4rci7rxur3MZH9Ffkgl2gFlJvPLzLMAfeTFUCZyZL5X36lOOo9Tv0MgaS5IxU78zwyXJiho4HrBKWgXzqbYRasEE9wCpOvMFuphsbq92919KkAhvwNiZB3BfoWOrE7AVi+RTQRbUduam3381U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZCnX/qB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZCnX/qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570043; x=1772106043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ik1KRcPcv/7hHx5afwifoehJUAXtVKFZMxBEVQmpcHM=;
  b=nZCnX/qBlFKJSxmY6T/sib7ia8EqvBi4P0xzqk3dMK18dBl2nxXWg08v
   vskM/UIbNNSkMWXpzkrV9jA+TuFAQux59vJw78kVwqqPptvdhJvEx3K7s
   fSj4KAA+K0vm3hVPpQTc8REICqGkmgWX9ffLcE7iiAQRFX/NTY3GeLCXp
   PFPCQQ5+IYkf6fVAc1JIekzhLWobUndKram3conCl2dhtfCYjBCodArWp
   dbifM0yV1rx7W8BfzRqFmmCb64DKRKd/PRi5hmGXdNCIzdt2p0jBpStrt
   G53n+I2hv0CKVVJt5AfMQuxUgHVXA74D542jgks1P2Xeu1VSIYZnDwqne
   A==;
X-CSE-ConnectionGUID: LKRA56yGSp+VRv43/Ao8ig==
X-CSE-MsgGUID: 3GQ/rPvhT5CcfvsdO6I48Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827108"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827108"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:36 -0800
X-CSE-ConnectionGUID: KVMSl8fBQFGWhGR8kNjc2Q==
X-CSE-MsgGUID: Ahd8Phr2Q+a6lJGdbxW/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171615"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:37 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 11/12] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Wed, 26 Feb 2025 03:40:31 -0800
Message-Id: <20250226114032.4591-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226114032.4591-1-yi.l.liu@intel.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
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

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  36 +++++
 drivers/iommu/iommufd/selftest.c     | 205 ++++++++++++++++++++++++++-
 2 files changed, 238 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a4306d5f4b7e..85715c17b2df 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -25,6 +25,11 @@ enum {
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
 	IOMMU_TEST_OP_MIX_REPLACE_HANDLE,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
 };
 
 enum {
@@ -151,6 +156,37 @@ struct iommu_test_cmd {
 			__u32 pt_id;
 			/* @id is stdev_id */
 		} mix_replace_handle;
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
+			__u32 pt_id;
+			/* @id is stdev_id */
+		} pasid_mix_replace_handle;
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
index 8ed1ee129584..056a97a0b50a 100644
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
 
@@ -1697,9 +1716,61 @@ static int iommufd_test_mixed_group_replace(struct iommufd_device *idev,
 	return ret;
 }
 
+static int iommufd_test_mixed_pasid_replace(struct iommu_domain *domain,
+					    struct iommufd_device *idev,
+					    ioasid_t pasid)
+{
+	struct iommu_group *group = idev->igroup->group;
+	struct iommu_attach_handle *handle;
+	struct device *dev = idev->dev;
+	int ret;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	mutex_lock(&idev->igroup->lock);
+	/* should fail as no previous attached handle or domain */
+	ret = iommu_replace_device_pasid_handle(domain, dev, pasid, handle);
+	if (ret != -EINVAL)
+		goto out_unlock;
+
+	ret = iommu_attach_device_pasid(domain, dev, pasid);
+	if (ret)
+		goto out_unlock;
+
+	if (PTR_ERR(iommu_attach_handle_get(group, pasid, 0)) != -ENOENT) {
+		ret = -ENODEV;
+		goto out_detach;
+	}
+
+	ret = iommu_replace_device_pasid_handle(domain, dev, pasid, handle);
+	if (ret)
+		goto out_detach;
+
+	if (handle != iommu_attach_handle_get(group, pasid, 0)) {
+		ret = -ENOENT;
+		goto out_detach;
+	}
+
+	ret = iommu_replace_device_pasid_handle(domain, dev, pasid, handle);
+	if (ret)
+		goto out_detach;
+
+	if (handle != iommu_attach_handle_get(group, pasid, 0))
+		ret = -ENOENT;
+
+out_detach:
+	iommu_detach_device_pasid(domain, dev, pasid);
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	kfree(handle);
+	return ret;
+}
+
 static int iommufd_test_mixed_handle_replace(struct iommufd_ucmd *ucmd,
 					     unsigned int device_id,
-					     u32 pt_id)
+					     ioasid_t pasid, u32 pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_device *idev;
@@ -1722,14 +1793,127 @@ static int iommufd_test_mixed_handle_replace(struct iommufd_ucmd *ucmd,
 	domain = hwpt->domain;
 
 	rc = iommufd_test_mixed_group_replace(idev, domain);
+	if (rc)
+		goto out_put_hwpt;
+
+	if (pasid != IOMMU_NO_PASID)
+		rc = iommufd_test_mixed_pasid_replace(domain, idev, pasid);
 
+out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
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
 
 out_dev_obj:
 	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return rc;
 }
 
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
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1812,8 +1996,22 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 	case IOMMU_TEST_OP_TRIGGER_IOPF:
 		return iommufd_test_trigger_iopf(ucmd, cmd);
 	case IOMMU_TEST_OP_MIX_REPLACE_HANDLE:
-		return iommufd_test_mixed_handle_replace(ucmd, cmd->id,
-						cmd->mix_replace_handle.pt_id);
+		return iommufd_test_mixed_handle_replace(
+			ucmd, cmd->id, IOMMU_NO_PASID,
+			cmd->mix_replace_handle.pt_id);
+	case IOMMU_TEST_OP_PASID_ATTACH:
+		return iommufd_test_pasid_attach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_REPLACE:
+		return iommufd_test_pasid_replace(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_MIX_REPLACE_HANDLE:
+		return iommufd_test_mixed_handle_replace(
+			ucmd, cmd->id,
+			cmd->pasid_mix_replace_handle.pasid,
+			cmd->pasid_mix_replace_handle.pt_id);
+	case IOMMU_TEST_OP_PASID_DETACH:
+		return iommufd_test_pasid_detach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_CHECK_DOMAIN:
+		return iommufd_test_pasid_check_domain(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1861,6 +2059,7 @@ int __init iommufd_test_init(void)
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 	mock_iommu.iommu_dev.max_pasids = (1 << 20);
+	pasid_1024_attached = false;
 
 	return 0;
 
-- 
2.34.1

