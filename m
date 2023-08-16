Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0492D302
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:46:29 +0000 (UTC)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjqH2FpzztS2F;
	Wed, 16 Aug 2023 17:42:51 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:46:27 +0800
From: liulongfang <liulongfang@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v13 4/4] Documentation: add debugfs description for vfio
Date: Wed, 16 Aug 2023 17:42:05 +0800
Message-ID: <20230816094205.37389-5-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230816094205.37389-1-liulongfang@huawei.com>
References: <20230816094205.37389-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

From: Longfang Liu <liulongfang@huawei.com>

1.Add two debugfs document description file to help users understand
how to use the accelerator live migration driver's debugfs.
2.Update the file paths that need to be maintained in MAINTAINERS

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../ABI/testing/debugfs-hisi-migration        | 36 +++++++++++++++++++
 Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++
 MAINTAINERS                                   |  2 ++
 3 files changed, 63 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
 create mode 100644 Documentation/ABI/testing/debugfs-vfio

diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
new file mode 100644
index 000000000000..791dd8a09575
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hisi-migration
@@ -0,0 +1,36 @@
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration data of the vfio device.
+		These data include device status data, queue configuration
+		data and some task configuration data.
+		The output format of the data is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration attributes of the vfio device.
+		it include device status attributes and data length attributes
+		The output format of the attributes is defined by the live
+		migration driver.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Trigger the HiSilicon accelerator device to perform
+		the io test through the read operation. If successful,
+		it returns the execution result of mailbox. If fails,
+		it returns error log result.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Trigger the Hisilicon accelerator device to perform
+		the state saving operation of live migration through the read
+		operation, and output the operation log results.
+
diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
new file mode 100644
index 000000000000..086a8c52df35
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-vfio
@@ -0,0 +1,25 @@
+What:		/sys/kernel/debug/vfio
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices, it's a common directory for all vfio devices.
+		Each device should create a device subdirectory under this
+		directory by referencing the public registration interface.
+
+What:		/sys/kernel/debug/vfio/<device>/migration
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	This debugfs file directory is used for debugging
+		of vfio devices that support live migration.
+		The debugfs of each vfio device that supports live migration
+		could be created under this directory.
+
+What:		/sys/kernel/debug/vfio/<device>/migration/state
+Date:		Aug 2023
+KernelVersion:  6.6
+Contact:	Longfang Liu <liulongfang@huawei.com>
+Description:	Read the live migration status of the vfio device.
+		The status of these live migrations includes:
+		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..d4fb7547b687 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22304,6 +22304,7 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
+F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
 F:	include/linux/vfio.h
@@ -22321,6 +22322,7 @@ M:	Longfang Liu <liulongfang@huawei.com>
 M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-hisi-migration
 F:	drivers/vfio/pci/hisilicon/
 
 VFIO MEDIATED DEVICE DRIVERS
-- 
2.24.0

