Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41BD2E4
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 08:16:35 +0000 (UTC)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQgqZ2zlmzNmWv;
	Wed, 16 Aug 2023 16:12:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 16:16:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 16:16:29 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <iommu@lists.linux.dev>
CC: <jgg@ziepe.ca>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next] iommufd/selftest: fix unregister device
Date: Wed, 16 Aug 2023 16:13:18 +0800
Message-ID: <20230816081318.1232865-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

It should call platform_device_unregister() instead of
platform_device_del() to unregister the device.

Fixes: 23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a real driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/iommufd/selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 9223ff3f23f9..2d0ac02bbd67 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1073,7 +1073,7 @@ int __init iommufd_test_init(void)
 err_bus:
 	bus_unregister(&iommufd_mock_bus_type.bus);
 err_platform:
-	platform_device_del(selftest_iommu_dev);
+	platform_device_unregister(selftest_iommu_dev);
 err_dbgfs:
 	debugfs_remove_recursive(dbgfs_root);
 	return rc;
@@ -1086,6 +1086,6 @@ void iommufd_test_exit(void)
 				    &iommufd_mock_bus_type.bus,
 				    &iommufd_mock_bus_type.nb);
 	bus_unregister(&iommufd_mock_bus_type.bus);
-	platform_device_del(selftest_iommu_dev);
+	platform_device_unregister(selftest_iommu_dev);
 	debugfs_remove_recursive(dbgfs_root);
 }
-- 
2.25.1

