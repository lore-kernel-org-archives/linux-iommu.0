Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BD3AE71D
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860275; cv=fail; b=PcG58dL8ZYV2rKkco51ruOql9HeL3oTXCthvlpzlnIrbYUxqLMxzEWSjGj4f0k/nvdTMO7xoYxR1/tyPCpd0MfrNa6Me7MjWLUQTgZH9Pjw/07iTaAnv2u7DcbaPV0dl4pTifNrR+z6Elw8AbEeHb4yCuPik5zbWJ+JsgF516pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860275; c=relaxed/simple;
	bh=fICo+oi8GM/yZsQRUomkjRpalNFsypkrMG9uudc5G9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtGEgxcvDy2S3RtyUBTqp6HGULkCdOG6eUo0z4Ume+3XfPdkf+CEQcoOiZkslOiCLuX/LCs9NysiV3YEgg44anINimeiG8YjeDX0SgnywModmDsmmufpU6qkos6SLu63hYfKAnvH071oJKJlnZLbn4l9VQE9tLnSHwaw+LLb3oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGylTndf; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGylTndf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYwnbVz54ohzkFsFPpawiUr59RI1Xh4o+IUVa439f9txZ8E3316VqaIiOLNFcQbceOISRmaD8k79EAu0tbKIDUhY01T3VR3oMChVmJglFV2e9VU2CIczjfC1CPJJkXy2XFjNFWDW1e+1wr2TdYG5+Nz6BOB1HzXodQEyFZl7vVfN1ZMhTwyEMZaQga+AXadd/m/fvpoloFqi+yLyb4vKtE/N4/5ksdCOFpj/5XdtmLbjhPZHf32NRl7acJXaJWtSl7SmC2rimsxtnnhcwokompHxYGv8Azhjc3QneV2XaueqnXa2wt8NYYfNOgAHlwxrlQtzahsPaz+6aLKSGTUe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utgS17TVNrDA66Vtl7qtHr1W2MOFtSE7M1309hNq/Cg=;
 b=dEpeCr2L8GmuLLVMTU2bvTbAiYrQFiTp230vcOkdH9fHwWRFkRszA7W3YBJ1Uzs1cArfEgEcOfk5KBYs32NwrdnFuY+BT+Iz/ptRY9u11eAOfndsA3tA0lr5fBg+ExsnRXaO6XOr55yE1ZLE0YjeMr4ZxgQtJW1igeNA9TXr1BOmdoRn/Lph4w94decicDf1IX3BLRdCyavQpmAW0GCmfa1SFcQ0LxoGq7T8XPcILhDHHuTNjJWTqzC4iZI8duTvOwkxS3r52GByzlQXaqaAcG8iEm00scFeQv7ZKs2XyNdJijT7POqBOfoyYCi1kRUpoU7Uk6Phqj6vMTB/rLFNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utgS17TVNrDA66Vtl7qtHr1W2MOFtSE7M1309hNq/Cg=;
 b=iGylTndfVS2OEsAOX6FCYoU1joCLH9GU6WAoeib8Sajrjlxn5AutauHs29yMnS+XPwTfwYx9hrXJjHkTgeD8sdb9xLkjgh9bkS2kiL9vkfZbC4+tXHf1XYbL3pNkrpG+Uk40l8neiQIfflmoQjI7V7G+aV9rX4TnNvM0DY8Z9wk=
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:44:28 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::6c) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:27 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:44:16 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 21/22] iommu/amd: Handle set/get option for AMD vIOMMU hw_queue
Date: Mon, 30 Mar 2026 08:42:05 +0000
Message-ID: <20260330084206.9251-22-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9723698d-cbeb-4967-fb1d-08de8e388dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z+BldpbD44/xIvf3sj2ZQGcBZZpcPeDIO+PhuhNpLxngo5hGSYGXsOEMNwglxTDqsybWiaZ86Dn9pw/gfgtGKYUAtfeyJRPhp4obuJwY4HiTge5aquMCZI3KFSognj0/2p0jxD5m6069kCzZUnfA6AbrkOkUO7qvbi1ODNhBu4IUAmNMswf4Yyw1xcM5Zd9+/u7ApeB3kthy+udKYl4oiO5rLZup4i8BEL2d1LTpP3WmWQ1wzL6n+qaEBOQ3RyXLw0JvxWVsxekxXqjxh+nhQcR2B+Y86/EODYnkMtBZop8M8AilvzReUslldTws7+Ncvg9VEBAljPlg2yLrU2RKC0VihGSIxOBKHpp8uGd2UJP5rpvg9utdBnfYidwXBl/m1mRvk0/U7WZof+QjeMjKaS9HmwP+1/XZWCzcs1lgQ8nxPNhxvwILdk/cDnLTxB5WrzVx1QY4fS7kj+8CCbcU9GLiN+/ZPxmdkImKy9QzcXxyOiR1UIe5RiPeqhZ3qz9lmYN0T4wgYFPnJOHfyFgJZLrR4+7HG1sGIUxSqHwZ9hqrIg4QGtg79VbZCpvy2MZc4sclNPlhCQGnpJDoxcSBLJb652lA0NXwKAulat5EJvqmRLsgniY+U05jMWnMg9XnDJr21XbvrvMmpQ3BMEqg8uw3Haqcbxns4Dlumwy4eO1lZh5WXvZBbjk+AFZSyyM4E75VF/dC4pUuq6DtzZMlGykisP7YSeP0UzRT2+NaKED0VXV23QOxWXFOAHdmxJbtnSkL6OldXDPtYd0f1PZJjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bv6UDNCUurlBmhvIE/rx5vVKkqq+J5jMN+M2nnve9qUzBznMvsBSkadHQ/nDhlKZbqCIXiCY3lfptwuaFDLC28d/klpythjH9z0xZ7G+rYOK61Qxnd60LFKlEoH0iKLKf4GGdfIbxRwhMzdoq7d8H7XkYuiDksDBiSeRR3usNA+R1LXnffZQo1nkHwVU/zMFHyUqZMrxP6ybNQ5KXh406owLXUoLm+HxM+ipxTNK1aN7dSoQOCy0IJ0MQTZSGs0X8bO3kgY3zIww8N5QGdHZHi63IIsrtiv/v+KysvjQy2DflYNTdqeerqZ4xB5BYCKGqKDAJi1dexEWnu36c3dzxbA4IGzbSO/fyc6f3ZsbMxY2x2s3NW02vV9ujE79VRn8/qH6mIL8EVApKU8/6mk/Sdb2GB9+senUepEasDUTYnT8JrwGYs4Zg4yF/G9INoHu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:27.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9723698d-cbeb-4967-fb1d-08de8e388dba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

Guest kernel programs guest Command Buffer, Event Log, and PPR Log
(a.k.a hardware queue) settings via guest control MMIO register
(guest MMIO offset 0x18). Accesses to the register is trapped by VMM (QEMU)
and information is passed as IOMMU_VIOMMU_OPTION to host IOMMU driver via
struct iommufd_viommu_ops set_option() and get_option().

Provides AMD IOMMU driver hooks to handle set/get operations for the
guest control MMIO register, which uses key parameter as AMD IOMMU MMIO
offset. The value parameter contains the value of the corresponding guest
MMIO register, which is converted to the format of AMD vIOMMU VF Control
MMIO registers then programed onto the hardware.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |   5 +
 drivers/iommu/amd/amd_viommu.h      |  15 +++
 drivers/iommu/amd/iommufd.c         |   2 +
 drivers/iommu/amd/vfctrl_mmio.c     | 145 ++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/vfctrl_mmio.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index e1e824b9c7b0..a5049fd7f789 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o vfctrl_mmio.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1cd50a4008fb..ff72023fa512 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -194,10 +194,15 @@
 #define CONTROL_GAM_EN		25
 #define CONTROL_GALOG_EN	28
 #define CONTROL_GAINT_EN	29
+#define CONTROL_DUALPPRLOG_EN   30
+#define CONTROL_DUALEVTLOG_EN   32
+#define CONTROL_PPR_AUTO_RSP_EN 39
+#define CONTROL_BLKSTOPMRK_EN   41
 #define CONTROL_NUM_INT_REMAP_MODE	43
 #define CONTROL_NUM_INT_REMAP_MODE_MASK	0x03
 #define CONTROL_NUM_INT_REMAP_MODE_2K	0x01
 #define CONTROL_EPH_EN		45
+#define CONTROL_PPR_AUTO_RSP_AON 48
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
 #define CONTROL_GCR3TRPMODE	58
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 93e44f8b6012..bd4e7481ee0c 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -21,6 +21,11 @@ int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
 
 void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
 				   u16 guestId, u16 gDevId);
+
+int amd_viommu_guest_mmio_write(struct iommufd_viommu *viommu, u16 offset, u64 value);
+
+int amd_viommu_guest_mmio_read(struct iommufd_viommu *viommu, u16 offset, u64 *value);
+
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -47,6 +52,16 @@ static inline void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hD
 {
 }
 
+static inline int amd_viommu_guest_mmio_write(struct iommufd_viommu *viommu, u16 offset, u64 value)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int amd_viommu_guest_mmio_read(struct iommufd_viommu *viommu, u16 offset, u64 *value)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 6f766254a390..b10cbff02288 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -242,4 +242,6 @@ static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.vdevice_init = _amd_viommu_vdevice_init,
 	.get_hw_queue_size = _amd_viommu_get_hw_queue_size,
 	.hw_queue_init = _amd_viommu_hw_queue_init,
+	.set_option = amd_viommu_guest_mmio_write,
+	.get_option = amd_viommu_guest_mmio_read,
 };
diff --git a/drivers/iommu/amd/vfctrl_mmio.c b/drivers/iommu/amd/vfctrl_mmio.c
new file mode 100644
index 000000000000..1dcccc24e847
--- /dev/null
+++ b/drivers/iommu/amd/vfctrl_mmio.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <linux/amd-iommu.h>
+
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/ioctl.h>
+#include <linux/iommufd.h>
+#include <uapi/linux/iommufd.h>
+#include <linux/mem_encrypt.h>
+
+#include <asm/iommu.h>
+#include <asm/set_memory.h>
+
+#include "amd_iommu.h"
+#include "amd_iommu_types.h"
+#include "amd_viommu.h"
+#include "../iommu-pages.h"
+
+#define GET_CTRL_BITS(reg, bit, msk)	(((reg) >> (bit)) & (ULL(msk)))
+#define SET_CTRL_BITS(reg, bit1, bit2, msk) \
+	((((reg) >> (bit1)) & (ULL(msk))) << (bit2))
+
+int amd_viommu_guest_mmio_read(struct iommufd_viommu *viommu, u16 offset, u64 *value)
+{
+	u8 __iomem *vfctrl, *vf;
+	u64 val, tmp = 0;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int gid = aviommu->gid;
+
+	vf = VIOMMU_VF_MMIO_BASE(iommu, gid);
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	switch (offset) {
+	case MMIO_CONTROL_OFFSET:
+	{
+		/* VFCTRL offset 20h */
+		val = readq(vfctrl + 0x20);
+		tmp |= SET_CTRL_BITS(val, 8, CONTROL_CMDBUF_EN, 1); // [12]
+		tmp |= SET_CTRL_BITS(val, 9, CONTROL_COMWAIT_EN, 1); // [4]
+
+		/* VFCTRL offset 28h */
+		val = readq(vfctrl + 0x28);
+		tmp |= SET_CTRL_BITS(val, 8, CONTROL_EVT_LOG_EN, 1); // [2]
+		tmp |= SET_CTRL_BITS(val, 9, CONTROL_EVT_INT_EN, 1); // [3]
+		tmp |= SET_CTRL_BITS(val, 10, CONTROL_DUALEVTLOG_EN, 3); // [33:32]
+
+		/* VFCTRL offset 30h */
+		val = readq(vfctrl + 0x30);
+		tmp |= SET_CTRL_BITS(val, 8, CONTROL_PPRLOG_EN, 1); // [13]
+		tmp |= SET_CTRL_BITS(val, 9, CONTROL_PPRINT_EN, 1); // [14]
+		tmp |= SET_CTRL_BITS(val, 10, CONTROL_PPR_EN, 1); // [15]
+		tmp |= SET_CTRL_BITS(val, 11, CONTROL_DUALPPRLOG_EN, 3); // [31:30]
+		tmp |= SET_CTRL_BITS(val, 13, CONTROL_PPR_AUTO_RSP_EN, 1); // [39]
+		tmp |= SET_CTRL_BITS(val, 14, CONTROL_BLKSTOPMRK_EN, 1); // [41]
+		tmp |= SET_CTRL_BITS(val, 15, CONTROL_PPR_AUTO_RSP_AON, 1); // [42]
+
+		*value = tmp;
+		break;
+	}
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	pr_debug("%s: iommu_devid=%#x, gid=%u, offset=%#x, value=%#llx\n",
+		 __func__, iommu->devid, gid, offset, *value);
+	return 0;
+}
+EXPORT_SYMBOL(amd_viommu_guest_mmio_read);
+
+int amd_viommu_guest_mmio_write(struct iommufd_viommu *viommu, u16 offset, u64 value)
+{
+	u8 __iomem *vfctrl, *vf;
+	u64 val, tmp, ctrl = value;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int gid = aviommu->gid;
+
+	pr_debug("%s: iommu_devid=%#x, gid=%u, offset=%#x, value=%#llx\n",
+		 __func__, iommu->devid, gid, offset, value);
+
+	vf = VIOMMU_VF_MMIO_BASE(iommu, gid);
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	switch (offset) {
+	case MMIO_CONTROL_OFFSET:
+	{
+		/* VFCTRL offset 20h */
+		val = readq(vfctrl + 0x20);
+		val &= ~(0x3ULL << 8);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_CMDBUF_EN, 1); // [12]
+		val |= (tmp << 8);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_COMWAIT_EN, 1); // [4]
+		val |= (tmp << 9);
+		writeq(val, vfctrl + 0x20);
+
+		/* VFCTRL offset 28h */
+		val = readq(vfctrl + 0x28);
+		val &= ~(0xFULL << 8);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_EVT_LOG_EN, 1); // [2]
+		val |= (tmp << 8);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_EVT_INT_EN, 1); // [3]
+		val |= (tmp << 9);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_DUALEVTLOG_EN, 3); // [33:32]
+		val |= (tmp << 10);
+		writeq(val, vfctrl + 0x28);
+
+		/* VFCTRL offset 30h */
+		val = readq(vfctrl + 0x30);
+		val &= ~(0xFFULL << 8);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_PPRLOG_EN, 1); // [13]
+		val |= (tmp << 8);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_PPRINT_EN, 1); // [14]
+		val |= (tmp << 9);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_PPR_EN, 1); // [15]
+		val |= (tmp << 10);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_DUALPPRLOG_EN, 3); // [31:30]
+		val |= (tmp << 11);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_PPR_AUTO_RSP_EN, 1); // [39]
+		val |= (tmp << 13);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_BLKSTOPMRK_EN, 1); // [41]
+		val |= (tmp << 14);
+		tmp = GET_CTRL_BITS(ctrl, CONTROL_PPR_AUTO_RSP_AON, 1); // [42]
+		val |= (tmp << 15);
+		writeq(val, vfctrl + 0x30);
+		break;
+	}
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(amd_viommu_guest_mmio_write);
-- 
2.34.1

