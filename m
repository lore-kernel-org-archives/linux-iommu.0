Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4239B48E;
	Thu, 10 Sep 2026 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011277; cv=fail; b=Oi6iAA+1BR5XcRmz6V58O3PyxnuWI029/hM1CWj4wk+sELcm1ElR1cWRiCVEAWpxxt2mVw+lHxXdgRDuUu6UfTJIhWsRunUWLUwhtK3tq37RWiQ970uO3CSnx6+fhXuNREPeX3NRl/Oci7t7Gv/U/qGAcbybXgJwFQW4W0eVePI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011277; c=relaxed/simple;
	bh=4736cWY4vqqohisgRKlLBlR3jvOBw3lhn1McAZHG8XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrD6qiFHhTT8RWA2XwuD6LkoWxv3ZMhK0nxYvvGI8lHejZPkL2r2OwOxUNqIu8fSKlD/y7cH9JNSIhokrykgtHBSLQc+VlF8YLLw3/3Kpu8y3hcHIGbPn+GqeBdGx4TdFudS/rOvh67ZymprA0gsOuglCjbA0gr92UM5AcZ3vxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H+yiEFcj; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H+yiEFcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTVzQrX6MymaMqxQLLWSLwRVdtjByhCaAVUjuGrinRb1+cSxzj/0F94KCMM5myeV8m0CiDwChuexYijz2YIWKiQRlMticL5aJNRkiEHX773F+3RxH78yanzjQdL5Q5dsN3PxAnBOnaJoInb6iktXJh7+W0do6b/ZFZwAxSdVox4rYpdBNF/7+CLR8Azqncra80Px3ji0Z0l6i8UdnqrZZhtRMWqMs6afgqX+A7Wvf1/xzYIOsRv7tQb1YQxj3e9524+Njvsl2mwf34GLzrMxnI51/3guxDu7zsZszmCiNlwg1dZVUFVyHczQtqHB7eC5bAq3hN7WbgZb1Uj+JSp32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aSvNQ5GYhLgwH3JSuWxrnC/T0tSa6usxfg4eftxz2k=;
 b=gvurqFKmEcpSst9VWUf35ibCwQlfiwoyHaS2sofTu+T+O960Cxvo7anZxJyJ7LPoZSMcvJIAoNQvQGpNJX9CcLn2a+Hi0exABujbiu1YlMVZCsLvfHXUk6SPqEN4itQdnpBKYc3EWdmgjyfAqLrYnWecQjaRCCdxotJXB5fFDHEsMyx1vX9L374WyJxANmRLGdoBwHrij+exiQmWDa2p68P0LppslLnPu9twRc+G6YNAqiU0vWeqoiF5rkBXNg8d90yGRA67r5gekrzejVR14mkh2kXOGF3WVIZJzQX1gnSJCuLj3RL+4fT6I8QBI7VwVJ0Xf6cuvQ3ExBeIcWtGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aSvNQ5GYhLgwH3JSuWxrnC/T0tSa6usxfg4eftxz2k=;
 b=H+yiEFcj9G5g5Nk4qH5D64Wdfxo2SrgqjKpacx9Oq6gbeg6rDZSBzFC6z7VvdBT8dsZqON5aXx3lCoqN2K3hjSD3ALP6CSPtrlFNxR6A8tME9nrcs7rDlmNgwMp8Aerj7UMAdwB23OYhtJHH9Y7ZTbNioVYyjwL4clU9KeFCMIDa//0p0rx5fVsg1wfvheCzxUKOsF3MJGiiYrk4w0iDB5F3coTVm7CSHVgEANcnGBeoE7fosYomurwjRiaQYsfYtG9qHT3Glw19VxOMUtT+zndbvO8GYvvOLCW+Fr0ITMIxgBtP3TWdY10otLd+jIblb8mxkpqzDpceihkXghLcBw==
Received: from DS2PEPF0000455D.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::515) by SJ2PR12MB9190.namprd12.prod.outlook.com
 (2603:10b6:a03:554::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 03:34:19 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:b) by DS2PEPF0000455D.outlook.office365.com
 (2603:10b6:f:fc00::515) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu,
 10 Sep 2026 03:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:34:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [PATCH v1 5/8] iommu: Let a driver mark an IOMMU as confidential
Date: Wed, 9 Sep 2026 20:32:48 -0700
Message-ID: <a2b4ecab20635c1b0defa47407af23ff901c778d.1789010941.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789010941.git.nicolinc@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 79587abc-5fd4-4e0e-e481-08df0eec658a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3jnSfWtOigBAFoxa59d2zTTmt4kb190qjD9z57wiUWLpK+B8vNrd6ylArLGp/E4L8VWEUCXTqcQ8MOqFrQQC1qyF+p6F772X553tCx4Ovt16jlXmfY/OsuFIzNhqU+aftQ7I1pxCK5jhZ85lyS0V+SjyP8QGAR0h9gQYZqIswfgexHe6+eFZH9gDedsXGNVrC0XWiaSZ/luh4LM1mc1+brioL22mVgK98kQQF8Gc/TTjKSzsCMq+NZ/n6Yq/3Yy87Ynz5E/Ztl+cmtAFVs7yF7r1EEMA2FzCRETr7nj1ngPfpmesoU8QqobpDRfAp22ItZwnkD26URRHXF2ZjFaX8rkM3k/LFjWM6fYNpIT/5XGtQZsSG6nMIxYBieriO2g/UMW5ChHmxOI4WTPPxFbsCXZcgkideab/Jr3yWUux5WfTSATaoLtLXFlGasM9kSV4BauRPwYWifnDWEgWyynUaoLU65/udVe/Dkre0bdSjXivREG4ZfDdKUI811yPTHi3gTJi6Kj1OnPU8C9HTkOXQC0G+8DYqFQCTTDQVKdIjR4HdO/G81KU1Xmdk4e/cHLu4cCzMJIHHNlXcE27JlnxnO9SctIxvbnoZFEgJBOLhbC/md8ZsrfHOODXNTPzgHO11Yqe6etrf4fKXO41C477f26x/R8MIcEVs06Hlra07qqxX0EPHv0eApH2PwosZPEj5fd8+APcJACp7HYHJsVdMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4orO/DBsS/BPMD8m1hewdDL7zmGdWGsucMdkl3DtTSnc8q5dB7VVPQQO3UN2QOa3KxUWybl4jP0ZtA9arDXAaU0a76GnPZuZCGRWhap5tgfb2jDVmjYyPFvpOOMj/a/q3S7txaknol9u2mlbSzPoBGVTTor8CV+crhpOgwdaFzfGWuF1LzK5MqYuP+8ePj21FxJdVjQ53YzOJQOO4/F2LcaZqqen/bTmf/JMxuQ7EG9nNsfZe6kezA0zfnA84g2k/RfiT1AQatxRoyGARqqp52z9rlMY0qG0joDOexK0jr7Ba0tiJLO49zjOQJhw2lqk3fwmql28fDAcBPEutMxMKS9qTgMMg7mvBAlWfZLGnrdBhyx3f/iFoxPMKfug234E7IUYKfo+dePp9u81eEfnqBH5wm6/pjU886a50FKniTHi7HAhIEJLGeUYHOlljMvu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:18.7644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79587abc-5fd4-4e0e-e481-08df0eec658a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

An IOMMU inside a confidential VM needs private memory for its queues and
tables. Later changes also need to identify it when handling TDISP devices.

Add a confidential marker and a helper for IOMMU drivers. The helper also
marks the IOMMU device as able to access private memory. Drivers must call
it before iommu_device_register().

Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 10 ++++++++++
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14a..bd68532e7f3be 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -822,6 +822,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @confidential: this instance runs inside a confidential VM. Set by the driver
+ *                before any dma allocation.
  */
 struct iommu_device {
 	struct list_head list;
@@ -831,6 +833,7 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+	bool confidential;
 };
 
 /**
@@ -890,6 +893,8 @@ struct dev_iommu {
 int iommu_device_register(struct iommu_device *iommu,
 			  const struct iommu_ops *ops,
 			  struct device *hwdev);
+void iommu_device_set_confidential(struct iommu_device *iommu,
+				   struct device *hwdev);
 void iommu_device_unregister(struct iommu_device *iommu);
 int  iommu_device_sysfs_add(struct iommu_device *iommu,
 			    struct device *parent,
@@ -1423,6 +1428,11 @@ static inline int iommu_device_register(struct iommu_device *iommu,
 	return -ENODEV;
 }
 
+static inline void iommu_device_set_confidential(struct iommu_device *iommu,
+						 struct device *hwdev)
+{
+}
+
 static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 {
 	return NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9af..feff390727d13 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
+#include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
@@ -313,6 +314,25 @@ int iommu_device_register(struct iommu_device *iommu,
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
 
+/**
+ * iommu_device_set_confidential - Mark an IOMMU instance as confidential
+ * @iommu: the IOMMU instance
+ * @hwdev: the struct device of @iommu, whose own DMA reaches private memory
+ *
+ * Declare that @iommu runs inside a confidential VM
+ *
+ * Call this before @iommu makes any DMA allocation of its own, and not merely
+ * before iommu_device_register(). Queues and tables allocated any earlier land
+ * in shared memory that the hypervisor can read.
+ */
+void iommu_device_set_confidential(struct iommu_device *iommu,
+				   struct device *hwdev)
+{
+	iommu->confidential = true;
+	dma_set_cc_private(hwdev, true);
+}
+EXPORT_SYMBOL_GPL(iommu_device_set_confidential);
+
 void iommu_device_unregister(struct iommu_device *iommu)
 {
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
-- 
2.43.0

