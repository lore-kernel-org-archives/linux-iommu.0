Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12586627
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916214; x=1707452214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FvzP1cm3MJo8mMYBDAYm1g80hB7lsWqyw4EEdmHNXb4=;
  b=i0Ldvd2C85ZkVDQucDYMPCjKGWKUiWVzf6G6azTjFyNcobQYrxBj6ppS
   M+k7+qOwg47gkXaAT7ULLXLOFztTb+IxaSDawrOM8WODq6rVMWxeiJyLX
   QdVFB56Vp7zj90ANQtqcFXvZxXRSg3B06e5f7gT6FIHnKUrZEpfntCIL9
   A9U+vup1PK9HJa2fchy2pQkl2zqouQwkpCIcPa7F0qxilTJ7mSiAG0Cgo
   bARedUUu1kZQ4rokXeXG6kaDbzLM4z8r2GwDr2exS1RUWxmlnv2b0SsIT
   ap2Aih2z97OZCRYiMyE9X130FP1WeiftzlpA6L6iPF0owryqPsubMB0uR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600748"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982117"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982117"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:51 -0800
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
Subject: [PATCH 4/6] iommufd/device: Add mock_device support in iommufd_device_get_info()
Date: Wed,  8 Feb 2023 20:16:40 -0800
Message-Id: <20230209041642.9346-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prepares for adding selftest for IOMMU_DEVICE_GET_INFO. Selftest
uses mock device, while physical device uses iommufd_device, so add
a helper iommufd_obj_dev() to get struct device from the iommufd_object
for a given dev_id.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 22 ++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/selftest.c        |  7 +++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3b64aef24807..470838e6902d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -145,6 +145,20 @@ static int iommufd_zero_fill_user(u64 ptr, int bytes)
 	return 0;
 }
 
+static struct device *
+iommufd_obj_dev(struct iommufd_object *obj)
+{
+	struct device *dev = NULL;
+
+	if (obj->type == IOMMUFD_OBJ_DEVICE)
+		dev = container_of(obj, struct iommufd_device, obj)->dev;
+#ifdef CONFIG_IOMMUFD_TEST
+	else if (obj->type == IOMMUFD_OBJ_SELFTEST)
+		dev = iommufd_selftest_obj_to_dev(obj);
+#endif
+	return dev;
+}
+
 int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_device_info *cmd = ucmd->cmd;
@@ -159,11 +173,15 @@ int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 		return -EOPNOTSUPP;
 
 	dev_obj = iommufd_get_object(ucmd->ictx, cmd->dev_id,
-				     IOMMUFD_OBJ_DEVICE);
+				     IOMMUFD_OBJ_ANY);
 	if (IS_ERR(dev_obj))
 		return PTR_ERR(dev_obj);
 
-	dev = container_of(dev_obj, struct iommufd_device, obj)->dev;
+	dev = iommufd_obj_dev(dev_obj);
+	if (!dev) {
+		rc = -EINVAL;
+		goto out_put;
+	}
 
 	ops = dev_iommu_ops(dev);
 	if (!ops || !ops->hw_info) {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4a0a1a7fdae1..7748117e36f9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -284,6 +284,7 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 			       struct device *mock_dev);
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt);
+struct device *iommufd_selftest_obj_to_dev(struct iommufd_object *obj);
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
 extern size_t iommufd_test_memory_limit;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b94870f93138..2ecde22a60f4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -802,6 +802,13 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 	}
 }
 
+struct device *iommufd_selftest_obj_to_dev(struct iommufd_object *obj)
+{
+	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
+
+	return &sobj->idev.mock_dev;
+}
+
 int iommufd_test(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
-- 
2.34.1

