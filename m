Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DC30F92E
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945610; cv=fail; b=gxkX4GoQIRLhIqSSpLfvVEbxek5BR0Xa0+424hODOfYuM3KyW58ceohp8bCx+mCzZ7Pz7oQIYngxU41QBpUHBZfWS0ZL8V0W8kpOVWbNZRq3/dxF3ASPA2GarVim0kV3AViUQ6YStXtiAVeEVi1PY7zCToOT3FKkmjyEDOulXgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945610; c=relaxed/simple;
	bh=b3lszFwUdThhNfhmXUopoMzs6TwbksDYeobMknMGhsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQnjt3F9dyPUlrtaRb3LYZ+5yTCR1RK7Zj29cXzuFSfiVDWRpiUZNEAgZz4PRjmbj01HWxcV7RwNzD3spwutE+MOs+Cp+4d6CeREXr4IJrPc0angVwzSFD4C+5Hpqa0IibWaHBU33CGONfLjBnBi5ut/E9q+VqFfXvJQGJB01aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dIQAOai4; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dIQAOai4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHuLXv3sBiqOJ0lGUenxkjgY6X3rMAh7iCebv95xEWPwBA6pZfIlacHGdvYkhT3+50LEkPs0Nxyid0Wla+5irl4YK7HPHyNtXpyGK1V9eziubrlr2v2mt7bu8AkBaK3aTrXYyX+WpvtSJhY8r3sG1JEXDpYEDUJcfu3xaGJzRqHXdneaBmMUokmZbbzyScHGLvIsxraX4E3ZKxyYCLV3w9n4Y5evFZYO+gLSmvhT6pXq+9sb7/OQoVCTiCuGLdytJI/mQjYYuzGWFOZOAZXN+taAVO55HFsIdRGOGXaZfD3QU4M2eZYHqyjLs2d0khdWYSfIObgthZhMvjAx60Ocyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7mV1ndQGR8lKDIDNF9bb6zMNGuwbVJrXxncSN1ezf0=;
 b=rEC84knn4oXW54nRCQe+fiYbEYhF/9RTDzNg+YgR6GMSQvfB7oV/Pt2QD5u9JMixd/65W1LDbGbWquawX2vswEsAFDZa4y9bfl/L5NWgIUo/h8pbIcBa4pGmfRVnOJGYCyEWAHdW9H55Kcpq3K9i7FTPuPDMzOsyMAEZGs+I6pqt+tf9hYpg5UjjDaNXskmMurO0LS88n3t3I2FoenK4jenPD9pBEn0u2JGnpIRHw5STDAej0j/MBNt25m8xiG5AzvR2EBgd53G+7jYf7MspMBVGMn/f8Jz1l+jxG5Tw4isPUjRVBApOY2BFNQfzL2S31ZJZ14gLCOm1yndV4PuRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7mV1ndQGR8lKDIDNF9bb6zMNGuwbVJrXxncSN1ezf0=;
 b=dIQAOai44y1nibgmS9Q0LbU4QirC45Trz6Px3YDdMsCp2guyBecrVH8IQp3ItgBjj9ITf/EgDkZCad7W0vux5h4w62pTN9e1Z/ahkD8oaeaaaw6egYRFIi9qxou7UkITp75PYRhqqPFedRXhE31QjIl9ByEgUhmJGPYGuf5amfg=
Received: from CH0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:76::8)
 by DSSPR12MB999235.namprd12.prod.outlook.com (2603:10b6:8:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:20:03 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::5a) by CH0PR04CA0003.outlook.office365.com
 (2603:10b6:610:76::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:20:03 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 25/26] iommu/amd: Handle set/get command for AMD vIOMMU
Date: Thu, 28 May 2026 05:17:37 +0000
Message-ID: <20260528051738.596013-26-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DSSPR12MB999235:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa1e24b-bc5e-484f-0fd2-08debc78c60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YK544KEe1dJzOWqJeW1CX/mvKJB+ICGtSXcjmMm37S2/4kI7pn7GSlpiPnaaJN3Ro4qDlG7U+a7oG6D75b6SdpR4caleyAALRgjZ8p6WmjpwEdTFOpxFCgVhCHGNNcTV9F5ygRUK0o9k5MPUdezDTYshRSJ4kGrJvc+YOv/Owr0/Lb6QmLHEq1LisEuMR4JnceajNANpJan0X4KrpYepUVBIpKsjQ8vQJGNG7RUL4Ga1Kut6tJzspV0J+hQmzyFk/p7WS/NVzCcIRNFv5WWTdXfEeP0WXb5XgBvWo6l0lpuN2oF6OtHYkE/UzaB/Tf0S5QQNnmgbAAKuQPpF88lS2DzFWGZBw7wQoJFaskX/jlh0yrfaUz6rmdHakZ6a4rmHzV2fwIpLDi9glGN+XFZtj5EDISmrAQB9pkruaL77lpmfjKS8mNDTQaUqN5Irb9ChbVrqZYO8Lb5ASP71ICjiGZXel9DomrXqa3dm3lBJY5TSuNmqjXUBdTWBSNmt48vHHTD1hEsY4nedFnPszSYUt9S0PpYkibmoULGKHyKtP+XyCFc9X5M7sgOK5VvUvXWKl4a4TbPikIsZyECn1tfUQOeEE9ioJif8YZftnYhrhOF37Mj6XeAmWWkJS6rkpt7U2fiJLcOmMT8Rqbp/kb6uJ60Nd3l/c4b4FGKsWICj/G8ff3OzS/CGc7JX4XGajb5mrjWAtLIHdWDs+X8Z7Pf9Ew8xQQYsFvzrbeYotyfhBoU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lLNj4fN+mWauJ0Rrrkmh126HqfLBQ4Yc88hCBJWVO1d6XHeUVyb8ByWK9YjNXnCT84RVvxtNIpH2dqEGhUOPEg2VC7RNSFlM8XdUvjdWRW0hc1pZN3QYvCGYWRXsZ23wW5Xi510Du53koHNfO9YJ+vBwznW+9/as+dZSVep36eKC0JekHF/bjojbUEGbB77VD/GLnnyMggzCtOomqnHeEIpOmGCzjtvyVcwMDkMoSP88ivPeDo+XWBiQKOGbQefoMF9ajLEOAU4LHTcQrV5iQVK0j+SCAPGP164EbVJHVL63+BPLM2NHQr7/8M7ifAd0A1XfgVUZhJmAcFFYn0ixNNfgk8ZQqVtNbLb4He/lUeIBlG91By8MUgm3opGoEpj76NGrWwbb2QTZjESTEmy9Ra74NjcdR5XpflFS/HGCtX/XINz1G0GJqYhNX4XDPEHd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:20:03.7579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa1e24b-bc5e-484f-0fd2-08debc78c60b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999235

Guest kernel programs guest Command Buffer, Event Log, and PPR Log
(a.k.a hardware queue) settings via guest control MMIO register
(guest MMIO offset 0x18). Accesses to the register is trapped by VMM (QEMU)
and information is passed as IOMMU_VIOMMU_OPTION to host IOMMU driver via
struct iommufd_viommu_ops set_command() and get_command().

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
 drivers/iommu/amd/vfctrl_mmio.c     | 146 ++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/vfctrl_mmio.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 12c3fe83e4ce..afbefda87f57 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o trans_devid.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o trans_devid.o vfctrl_mmio.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 70d060a85e66..44a185bfa39e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -191,10 +191,15 @@
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
index 3a8f41baaab9..c4ef374b68ec 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -23,6 +23,11 @@ int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
 
 void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
 				   u16 guestId, u16 gDevId);
+
+int amd_viommu_guest_mmio_write(struct iommufd_viommu *viommu, u16 offset, u64 value);
+
+int amd_viommu_guest_mmio_read(struct iommufd_viommu *viommu, u16 offset, u64 *value);
+
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -53,6 +58,16 @@ static inline void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hD
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
index 7e6381e5a06b..53dda68c5a0a 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -317,4 +317,6 @@ static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.vdevice_init = _amd_viommu_vdevice_init,
 	.get_hw_queue_size = _amd_viommu_get_hw_queue_size,
 	.hw_queue_init = _amd_viommu_hw_queue_init,
+	.set_command = amd_viommu_guest_mmio_write,
+	.get_command = amd_viommu_guest_mmio_read,
 };
diff --git a/drivers/iommu/amd/vfctrl_mmio.c b/drivers/iommu/amd/vfctrl_mmio.c
new file mode 100644
index 000000000000..ece94f2212ec
--- /dev/null
+++ b/drivers/iommu/amd/vfctrl_mmio.c
@@ -0,0 +1,146 @@
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
+		pr_err("%s: invalid offset=%#x\n", __func__, offset);
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

