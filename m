Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB78DF5C
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:44:29 +0000 (UTC)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjn059JCzNmm7;
	Wed, 16 Aug 2023 17:40:52 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:44:23 +0800
From: liulongfang <liulongfang@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v13 0/4] add debugfs to migration driver
Date: Wed, 16 Aug 2023 17:42:01 +0800
Message-ID: <20230816094205.37389-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

Add a debugfs function to the migration driver in VFIO to provide
a step-by-step test function for the migration driver.

When the execution of live migration fails, the user can view the
status and data during the migration process separately from the
source and the destination, which is convenient for users to analyze
and locate problems.

Changes v12 -> v13
	Solve the problem of open and close competition to debugfs.

Changes v11 -> v12
	Update loading conditions of vfio debugfs.

Changes v10 -> v11
	Delete the device restore function in debugfs.

Changes v9 -> v10
	Update the debugfs file of the live migration driver.

Changes v8 -> v9
	Update the debugfs directory structure of vfio.

Changes v7 -> v8
	Add support for platform devices.

Changes v6 -> v7
	Fix some code style issues.

Changes v5 -> v6
	Control the creation of debugfs through the CONFIG_DEBUG_FS.

Changes v4 -> v5
	Remove the newly added vfio_migration_ops and use seq_printf
	to optimize the implementation of debugfs.

Changes v3 -> v4
	Change the migration_debug_operate interface to debug_root file.

Changes v2 -> v3
	Extend the debugfs function from hisilicon device to vfio.

Changes v1 -> v2
	Change the registration method of root_debugfs to register
	with module initialization.

Longfang Liu (4):
  vfio/migration: Add debugfs to live migration driver
  hisi_acc_vfio_pci: extract public functions for container_of
  hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
  Documentation: add debugfs description for vfio

 .../ABI/testing/debugfs-hisi-migration        |  36 +++
 Documentation/ABI/testing/debugfs-vfio        |  25 ++
 MAINTAINERS                                   |   2 +
 drivers/vfio/Makefile                         |   1 +
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 215 +++++++++++++++++-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   3 +
 drivers/vfio/vfio.h                           |  14 ++
 drivers/vfio/vfio_debugfs.c                   |  80 +++++++
 drivers/vfio/vfio_main.c                      |   5 +-
 include/linux/vfio.h                          |   7 +
 10 files changed, 377 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 Documentation/ABI/testing/debugfs-vfio
 create mode 100644 drivers/vfio/vfio_debugfs.c

-- 
2.24.0

