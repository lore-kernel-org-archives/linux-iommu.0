Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C253AF
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196666; x=1721732666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sy/10kzSsQE8Iw4y4z6S/RygUlRyD0M+tbsCuWgKxuA=;
  b=dnZ+vNlZ8q8Wmj7B8k2VNw+GwCW51V0e7RX3vTvhCc1gnQ6wqEG8S2hb
   RfY6aCAxpVanOdb9M25uIdx13o8dyk9wC9dqa5iyLyDLT9k0pbxTDHS+x
   FqIVvcNkaB4hFS3zB8kmhIxh79D1VqHuoSCZZkYGqJGlxxflQNxvIklJC
   7wiWlF7eBjKuIpXYV8uKv68YmBzxjGI2QzpcnNygIu6mmuJ7iiS+pwwxm
   47tAopMGcpNFXU4fw8d2Ls5uV48imV5OSjLwc7h9cfV/KUK9KSrEryPWn
   zHpp44baSCAF08dKNeSo6nY9642+yIo0Z8I1A2Gs+5C7ELm6LFrZHvPdU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013304"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013304"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775861"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775861"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:21 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v3 11/17] iommufd/selftest: Add IOMMU_TEST_OP_DEV_[ADD|DEL]_RESERVED to add/del reserved regions to selftest device
Date: Mon, 24 Jul 2023 04:04:00 -0700
Message-Id: <20230724110406.107212-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes test tool able to specify reserved regions to the selftest
device and hence able to validate the ioctl IOMMU_RESV_IOVA_RANGES.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  6 ++
 drivers/iommu/iommufd/selftest.c     | 82 ++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 3f3644375bf1..b7f4bee2ea1b 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -19,6 +19,8 @@ enum {
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
+	IOMMU_TEST_OP_DEV_ADD_RESERVED,
+	IOMMU_TEST_OP_DEV_DEL_RESERVED,
 };
 
 enum {
@@ -50,6 +52,10 @@ struct iommu_test_cmd {
 			__aligned_u64 start;
 			__aligned_u64 length;
 		} add_reserved;
+		struct {
+			__aligned_u64 start;
+			__aligned_u64 length;
+		} add_dev_reserved;
 		struct {
 			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 72d0c37e0b5e..271c6c261eb4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -93,6 +93,8 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	struct rw_semaphore reserved_rwsem;
+	struct rb_root_cached reserved_itree;
 };
 
 struct selftest_obj {
@@ -385,6 +387,10 @@ static struct mock_dev *mock_dev_create(void)
 	mutex_init(&mdev->dev.iommu->lock);
 	mdev->dev.iommu->iommu_dev = &mock_iommu_device;
 
+	/* Reserve range related fields */
+	init_rwsem(&mdev->reserved_rwsem);
+	mdev->reserved_itree = RB_ROOT_CACHED;
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_dev_iommu;
@@ -407,8 +413,20 @@ static struct mock_dev *mock_dev_create(void)
 	return ERR_PTR(rc);
 }
 
+static void mock_dev_remove_reserved_iovas(struct mock_dev *mdev)
+{
+	struct interval_tree_node *node;
+
+	while ((node = interval_tree_iter_first(&mdev->reserved_itree, 0,
+						ULONG_MAX))) {
+		interval_tree_remove(node, &mdev->reserved_itree);
+		kfree(node);
+	}
+}
+
 static void mock_dev_destroy(struct mock_dev *mdev)
 {
+	mock_dev_remove_reserved_iovas(mdev);
 	iommu_group_remove_device(&mdev->dev);
 	device_del(&mdev->dev);
 	kfree(mdev->dev.iommu);
@@ -536,6 +554,64 @@ static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int mock_dev_add_reserved_iova(struct mock_dev *mdev,
+				      unsigned long start, unsigned long last)
+{
+	struct interval_tree_node *reserved;
+
+	if (interval_tree_iter_first(&mdev->reserved_itree, start, last))
+		return -EADDRINUSE;
+
+	reserved = kzalloc(sizeof(*reserved), GFP_KERNEL_ACCOUNT);
+	if (!reserved)
+		return -ENOMEM;
+	reserved->start = start;
+	reserved->last = last;
+	interval_tree_insert(reserved, &mdev->reserved_itree);
+	return 0;
+}
+
+/* Add a reserved IOVA region to a device */
+static int iommufd_test_dev_add_reserved(struct iommufd_ucmd *ucmd,
+					 unsigned int device_id,
+					 unsigned long start, size_t length)
+{
+	struct selftest_obj *sobj;
+	struct mock_dev *mdev;
+	int rc;
+
+	sobj = iommufd_test_get_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	mdev = sobj->idev.mock_dev;
+	down_write(&mdev->reserved_rwsem);
+	rc = mock_dev_add_reserved_iova(sobj->idev.mock_dev,
+					start, start + length - 1);
+	up_write(&mdev->reserved_rwsem);
+	iommufd_put_object(&sobj->obj);
+	return rc;
+}
+
+/* Remove all reserved IOVA regions of a device */
+static int iommufd_test_dev_del_reserved(struct iommufd_ucmd *ucmd,
+					 unsigned int device_id)
+{
+	struct selftest_obj *sobj;
+	struct mock_dev *mdev;
+
+	sobj = iommufd_test_get_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	mdev = sobj->idev.mock_dev;
+	down_write(&mdev->reserved_rwsem);
+	mock_dev_remove_reserved_iovas(mdev);
+	up_write(&mdev->reserved_rwsem);
+	iommufd_put_object(&sobj->obj);
+	return 0;
+}
+
 /* Check that every pfn under each iova matches the pfn under a user VA */
 static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 				    unsigned int mockpt_id, unsigned long iova,
@@ -1025,6 +1101,12 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_add_reserved(ucmd, cmd->id,
 						 cmd->add_reserved.start,
 						 cmd->add_reserved.length);
+	case IOMMU_TEST_OP_DEV_ADD_RESERVED:
+		return iommufd_test_dev_add_reserved(ucmd, cmd->id,
+						     cmd->add_dev_reserved.start,
+						     cmd->add_dev_reserved.length);
+	case IOMMU_TEST_OP_DEV_DEL_RESERVED:
+		return iommufd_test_dev_del_reserved(ucmd, cmd->id);
 	case IOMMU_TEST_OP_MOCK_DOMAIN:
 		return iommufd_test_mock_domain(ucmd, cmd);
 	case IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE:
-- 
2.34.1

