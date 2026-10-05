Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A974DA535
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228701; cv=fail; b=Gbmm9An14sMUlH6QH5pJCAdFS/TYkQD5W85yWRlulMajde37tUzFUOW3mvYYhdJ4TaaO6F1Zwp5gmwkl9hBSP34cfTt9YOI3MT4W4dfoPh5+dCeHFCUH6iS8EnOH4NqfvZ4RNujEw500RZR4mEVF4NOSWTra5lOSi7Vyrl2yIc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228701; c=relaxed/simple;
	bh=jBts9hXEvrAaMQFOLC8VrQEhPXD4hh3CX7Jl6EClZ7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWo8EI1tRiWVFxVixglKisCbpNlthyvEPEYXsVoQ3gmoIOrxdyDvpJFbi37/7z6+WRf0EuVh46FZoNT3l3uz1mvxp80dPok5E1pLJi/ZjkBOKCTl6Y9k5twZ7gNIyrhQVLOatZPSlV1EiuYK0KJN9fRkR4YAukhIg4xty6Pe4EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WCiv6ZK8; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WCiv6ZK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykz9tboMRGIbM08aC4ebcv6DCsMR8XSjQTBraPYRHCkSQCnQY4dDcvhoTlBDzFNcKKqeS6tauilHbfYnzat6QCcQI9fYMk9p0uN07laOouaolf/MloPksBBOS9PkQg9L1KwmhFSETUoyefJDFOVhT98v7YK0l4mtUyoZX3qM8ARnyulK4wGopAlIwAORuydwHv/W5ybmetka7gblSb/JX3hw48jQWoT1icfsOLSVtVxFmO++t88tQZ07edXF143BsuZ58zy7i7rlGeRFqyDZMupGcOZU/HaWkWy1VkbvAfb2LFb/L3koJpQn/EahjOYxNT6JAC64NPerlxSHVLXVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQVC9+jKRlI0ceNCRPGupu1dWp70TE7T6WFHtaOILF4=;
 b=aIOyt8CrlGrOCl7g6S7Ib1z9Kb03SXRtmVSt5G2V8++Ju/Tlp6hYhL8fXK24fNwj9ZeXDbu05fz9QpXIZMi62IT3cgnUO0m1xsexFe956QyD1DPzTh4FYDvBYdIH8lG2ry+AcT8EMQ++3ce8+5/axHWXze+xIz9+JX308MBU89bK7fRF5JfdKRziX5zoHBK2AhyHhdbG++ZnLHR9fFxkdil51OEUgmX+gxuuACb+KGfx/Ijnfhu4iZXhRto++fiUsCModvE3yW2lq8y3sUBToXfN/XKxmP1xzwwxv7bRog9kWXr4pKC/p7XwWkAES2H4skVidP9K7bv7Edz0P3HMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQVC9+jKRlI0ceNCRPGupu1dWp70TE7T6WFHtaOILF4=;
 b=WCiv6ZK8flTG3UFdIs0iOd2GAD6jGTyw+njXbNILBaeMpVM1eeA7RvRwxhP/ZZlcWbub3x37GEvIs26YJSC8519egYO/XH3zdTLfRTfw3n1t+imxedKCWlK4IkY8uinXj/hSNCIPr9q265Ho+QE6Jp0eaUdGbIUedBi5ufxwHpbKkjMsKjty3ezX1m8nWCEf0qLhay7gc19sqs1UC2qIwnCaW999TjHFW2gmeNo6LxW2LzhNdwgvTWIyFrcqcJXjgnamCVn3aDRh7bDxO+tJJ5/ExOQYEUBr7fmtE23CmHesELeWVENMGUBx4RW4c5A+w/G4ru6bwzby/66KdCGS/g==
Received: from SJ2P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::12)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:33 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::a) by SJ2P220CA0001.outlook.office365.com
 (2603:10b6:a03:5da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 06/11] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Date: Mon, 5 Oct 2026 12:30:49 -0700
Message-ID: <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 415b4e36-1ecc-487b-13e0-08df2317433f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|7416014|6133799003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nzcjs33logIW3ddKecq+8EEI9wLhSJSIiPy3C6nSGpBgPZ5njfCrrSDS+wXmmBExV3SkrmCJOjz11vpSPMt/W3F6qTLQn4vnTDGE4fYooK8cnxcukrKxbB9h+7XHlZwbnjZf+fL1gN9Ug/uvHD0kJxjf6UHtONyGxM4MnsH750NMfbzrGLEmaBVJCByHF0hAvSg+/spHJJ2aU6GAJ0S0CxwrynpdGRNvDn0/WyMe15yhWh5mxV3FU+xxzHPONh4CR4qul2mCYna4U8D5gWFw67D1wHWzWtsplvipr/lGELZkPI8F1u9dszCSjztPFCVwYUrCRQ0kJleIEAGAjhrf6g+92lgbyUWNg6wfbXysDScHW/tUVvNsPuiKDKYGMyah9HlWe1hR5t3ioSli1IFo4XBkz99jmM+qpj2srwiajOSxL6C66nyobQulg3hDux7fq340YlsKRGOTD0uSmTSCw5/eW4Cy1OGNsCBzneSTCO2Q0VG6BTQtriIgQbjaQ6Z76Ossuau5q1i7kz/zT/3fN3YCiXZxSuVi5LyTg6Vc51zZ/kGshHI+7nKne1fempVQuN+vIbmf/lXV2AhlkGh3jyLdDsr0skqpt7FrA0wkeVH+xn//sy1l3aJukF6hyTFCpmN34HD4VjA5YxGDMXIzq0DkTGyTre6DhBF5mRAaYt2O05MTsR+VY/UL1e4hiQa9Q3ROj6QjXanXgYLgvbf4Dg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(7416014)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7naiqcKhMwiIQHMeOfR8CFpf2A39AnS4Mgo33uCuLAn4AbeBAVWn7V+jgVoKsd+QVai9+IvYrs3FinpJSd4hYHGY49XWF0Rh2+VqWHtdnu3DjMdULq9zx+WyCDORgCdzwF5WfQrh4+S5x3J0Q9nEk+/uZ6wTwFY32gKHgyuqqXQCt17F1HMEXuJJ3U0dYETCCdCAD9CXRwnmLGIHAfmnfP45lDwdNLVFgflOln+UxH3rYg8HMBNijCMlp9Nyq6G1yad4Vp5mW29AjyZm4Hhg/jaGo7ng3FXeeESt0TUUzt6XZhBuOBc69AC3N5a8kQg/9MZyp11n9kCezbNPV+gfsja/Kemcvcaj86imKSu0X+AR6WKoHG3oYluSL0LX1oxP6kcQneGIKb02f0apnsHjkfdMafFvKchoVYda8336BAec/plEgr7wOh78QAtWbX4W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:32.9198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415b4e36-1ecc-487b-13e0-08df2317433f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
in-flight DMAs reusing the crashed kernel's page tables until the endpoint
device drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adoption functions that memremap the
stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
some basic validations against the values read from the registers. If tests
fail, it means the stream table cannot be trusted, so toss it entirely. To
avoid OOM due to a potentially corrupted stream table, the memremap for l2
tables is done lazily on the kdump kernel's demand.

The new option will be set in a following change, once the device reset and
the RMR setup are reworked not to overwrite the adopted stream table, and
the crashed kernel's in-use ASIDs and VMIDs are reserved.

Keep all kdump functions and kexec helpers in a new arm-smmu-v3-kexec file,
which will be shared with the liveupdate series in the future.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |   3 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 398 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  21 +-
 5 files changed, 441 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89deea..9a7bebe16f395 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -109,6 +109,9 @@ config ARM_SMMU_V3_IOMMUFD
 
 	  Say Y here if you are doing development and testing on this feature.
 
+config ARM_SMMU_V3_KEXEC
+	def_bool CRASH_DUMP
+
 config ARM_SMMU_V3_KUNIT_TEST
 	tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66bb..89a27de8dd2f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 559bfa8cbc5e0..a1f947e7d9fe4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -986,6 +986,7 @@ struct arm_smmu_device {
  * invalidated CONT
  */
 #define ARM_SMMU_OPT_FULL_CONT_RANGE_INV (1 << 6)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 7)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1312,6 +1313,26 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 }
 #endif /* CONFIG_TEGRA241_CMDQV */
 
+#ifdef CONFIG_CRASH_DUMP
+int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
+int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
+					    u32 sid, phys_addr_t base, u32 span,
+					    struct arm_smmu_strtab_l2 **l2table);
+#else /* CONFIG_CRASH_DUMP */
+static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+					phys_addr_t base, u32 span,
+					struct arm_smmu_strtab_l2 **l2table)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 struct arm_vsmmu {
 	struct iommufd_viommu core;
 	struct arm_smmu_device *smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
new file mode 100644
index 0000000000000..6bbc369df86bb
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#define dev_fmt(fmt) "kexec: " fmt
+
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "arm-smmu-v3.h"
+
+/*
+ * Common helpers for a kexec'd kernel to parse, validate, and walk through the
+ * previous kernel's SMMU table structures, shared by the kdump adoption and a
+ * future live-update restoration.
+ *
+ * The common helpers are read-only against the previous kernel's structures: a
+ * table that is not yet mapped by this kernel gets a transient memremap during
+ * a walk, followed by an immediate memunmap. They never allocate memory or take
+ * ownership of the previous kernel's tables; the callers make those decisions.
+ */
+
+/**
+ * arm_smmu_kexec_parse_strtab_2lvl() - Validate a 2-level stream table
+ * @smmu: SMMU device of this kernel
+ * @cfg_reg: STRTAB_BASE_CFG register value set by the previous kernel
+ * @base: stream table base address extracted from the STRTAB_BASE register
+ * @num_l1_ents: pointer to return the number of L1 entries
+ *
+ * Validate the 2-level stream table geometry in @cfg_reg and @base's alignment
+ * against this kernel's hardware limits.
+ *
+ * Return: 0 on success with @num_l1_ents set, or -EINVAL on a bad geometry
+ */
+static int arm_smmu_kexec_parse_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, phys_addr_t base,
+					    u32 *num_l1_ents)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	u32 num_ents;
+	size_t size;
+
+	if (log2size < split || log2size > smmu->sid_bits) {
+		dev_err(smmu->dev, "log2size %u out of range [%u, %u]\n",
+			log2size, split, smmu->sid_bits);
+		return -EINVAL;
+	}
+	if (split != STRTAB_SPLIT) {
+		dev_err(smmu->dev,
+			"unsupported STRTAB_SPLIT %u (expected %u)\n", split,
+			STRTAB_SPLIT);
+		return -EINVAL;
+	}
+
+	/*
+	 * Bound the entry count before the shift, as a log2size wider than what
+	 * this kernel itself supports would overflow it.
+	 */
+	if (log2size - split > ilog2(STRTAB_MAX_L1_ENTRIES)) {
+		dev_err(smmu->dev, "l1 entries 2^%u exceeds max %u\n",
+			log2size - split, STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	num_ents = 1U << (log2size - split);
+
+	size = num_ents * sizeof(struct arm_smmu_strtab_l1);
+	/*
+	 * According to spec (6.3.24), HW aligns the base down to the L1 table
+	 * size, i.e. min 64 bytes, so an unaligned base would make this kernel
+	 * read another table.
+	 */
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned l1 stream table base %pa\n",
+			&base);
+		return -EINVAL;
+	}
+
+	*num_l1_ents = num_ents;
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_parse_strtab_linear() - Validate a linear stream table
+ * @smmu: SMMU device of this kernel
+ * @cfg_reg: STRTAB_BASE_CFG register value set by the previous kernel
+ * @base: stream table base address extracted from the STRTAB_BASE register
+ * @num_ents: pointer to return the number of STEs
+ *
+ * Validate the linear stream table geometry in @cfg_reg and @base's alignment
+ * against this kernel's own limits.
+ *
+ * Return: 0 on success with @num_ents set, or -EINVAL on a bad geometry
+ */
+static int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, phys_addr_t base,
+					      u32 *num_ents)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	unsigned int max_log2size = smmu->sid_bits;
+	size_t size;
+
+	/* Cap the size at what this kernel itself would have allocated */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		max_log2size = min_t(
+			unsigned int, max_log2size,
+			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES));
+
+	/* num_ents is limited to a u32, so cap log2size at 31 */
+	max_log2size = min(max_log2size, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "unsupported log2size %u (> %u)\n", log2size,
+			max_log2size);
+		return -EINVAL;
+	}
+
+	size = (1U << log2size) * sizeof(struct arm_smmu_ste);
+	/*
+	 * According to spec (6.3.24), HW aligns the base down to the table size
+	 * and ignores the low bits, so an unaligned base would make this kernel
+	 * read a different table.
+	 */
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
+		return -EINVAL;
+	}
+
+	*num_ents = 1U << log2size;
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_check_strtab_l1_desc() - Check one stream table L1 descriptor
+ * @smmu: SMMU device of this kernel
+ * @l1_desc: L1 descriptor value from the previous kernel's stream table
+ * @idx: index of the L1 descriptor, for diagnostics
+ * @l2_base: pointer to return the L2 table's physical address
+ *
+ * Return: 1 if the descriptor is unused, 0 if it is valid with @l2_base set, or
+ * -EINVAL if it is malformed
+ */
+static int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
+					       u64 l1_desc, u32 idx,
+					       phys_addr_t *l2_base)
+{
+	phys_addr_t base = l1_desc & STRTAB_L1_DESC_L2PTR_MASK;
+	u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l1_desc);
+
+	/* L1STD.L2Ptr is invalid */
+	if (!span)
+		return 1;
+
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev, "L1[%u] unsupported span %u (vs %u)\n", idx,
+			span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	/*
+	 * A valid descriptor never carries a null pointer. Also, HW aligns the
+	 * pointer down to the L2 table size, so an unaligned pointer would make
+	 * this kernel read a different table.
+	 */
+	if (!base || !IS_ALIGNED(base, sizeof(struct arm_smmu_strtab_l2))) {
+		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n", idx,
+			&base);
+		return -EINVAL;
+	}
+
+	*l2_base = base;
+	return 0;
+}
+
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Helper functions of the kdump stream table adoption for ARM SMMUv3
+ *
+ * When the crashed kernel left the SMMU enabled with in-flight DMAs, the kdump
+ * kernel adopts the crashed kernel's stream tables, instead of doing a regular
+ * reset, to keep in-flight DMAs translating until the endpoint device drivers
+ * re-probe and quiesce their devices.
+ *
+ * Note:
+ *  - Adoption only starts on an SMMU that the crashed kernel left enabled, as a
+ *    disabled SMMU (CR0_SMMUEN=0) could hold meaningless register values.
+ *  - Values read from the crashed kernel's registers get structural validation
+ *    only (format, size, span, alignment, and ID range); the physical addresses
+ *    are not vetted, as the kdump kernel has no record of which pages held the
+ *    tables.
+ *  - A structural inconsistency at adoption time tosses the entire adoption and
+ *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
+ *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
+ *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
+ *    rejects that device alone, as its blast radius is bounded to the bus.
+ *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
+ *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
+ *    the real hardware. Callers of these functions are responsible for gating
+ *    ARM_SMMU_FEAT_COHERENCY once during the probe.
+ */
+
+int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
+					    u32 sid, phys_addr_t base, u32 span,
+					    struct arm_smmu_strtab_l2 **l2table)
+{
+	struct arm_smmu_strtab_l2 *table;
+	size_t size;
+
+	/*
+	 * Retest the span in case the L1 descriptor has been overwritten since
+	 * the adopt. Reject this master's insert; panic or SMMU-disable would
+	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
+	 * would break all other SIDs in the same bus (PCI case). The corruption
+	 * blast radius is already bounded to that bus range.
+	 */
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev,
+			"L1[%u] span %u changed since adopt (was %u)\n",
+			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
+
+	/* Same live-corruption check as the span; reject an overwritten base */
+	if (!base || !IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n",
+			arm_smmu_strtab_l1_idx(sid), &base);
+		return -EINVAL;
+	}
+
+	/*
+	 * This L2 table is mapped lazily per master; devres frees it at unbind,
+	 * as with the dmam_alloc_coherent() used for a fresh L2.
+	 */
+	table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+	if (IS_ERR(table)) {
+		dev_err(smmu->dev,
+			"failed to adopt l2 stream table for SID %u\n", sid);
+		return PTR_ERR(table);
+	}
+
+	*l2table = table;
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, phys_addr_t base)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_l1_ents;
+	size_t size;
+	int ret, i;
+
+	ret = arm_smmu_kexec_parse_strtab_2lvl(smmu, cfg_reg, base,
+					       &num_l1_ents);
+	if (ret)
+		return ret;
+
+	cfg->l2.num_l1_ents = num_l1_ents;
+
+	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	cfg->l2.l1tab = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->l2.l1tab)
+		return -ENOMEM;
+
+	cfg->l2.l2ptrs =
+		kcalloc(num_l1_ents, sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
+	if (!cfg->l2.l2ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		phys_addr_t l2_base;
+
+		ret = arm_smmu_kexec_check_strtab_l1_desc(smmu, l2ptr, i,
+							  &l2_base);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * If the crashed kernel's l1 descriptors are deeply corrupted,
+		 * blindly memremapping every l2 table here could lead to OOM.
+		 *
+		 * Defer the l2 memremap to arm_smmu_init_l2_strtab(), so peak
+		 * memory is bounded by the kdump kernel's actual demand.
+		 */
+	}
+
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, phys_addr_t base)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_ents;
+	size_t size;
+	int ret;
+
+	ret = arm_smmu_kexec_parse_strtab_linear(smmu, cfg_reg, base,
+						 &num_ents);
+	if (ret)
+		return ret;
+
+	/*
+	 * We might end up with a num_ents != sid_bits, which is fine, since the
+	 * ARM_SMMU_OPT_KDUMP_ADOPT case bypasses arm_smmu_write_strtab().
+	 */
+	cfg->linear.num_ents = num_ents;
+
+	size = num_ents * sizeof(struct arm_smmu_ste);
+	cfg->linear.table = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->linear.table)
+		return -ENOMEM;
+	return 0;
+}
+
+static void arm_smmu_kdump_adopt_cleanup(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		kfree(cfg->l2.l2ptrs);
+		if (cfg->l2.l1tab)
+			memunmap(cfg->l2.l1tab);
+	} else {
+		if (cfg->linear.table)
+			memunmap(cfg->linear.table);
+	}
+}
+
+int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
+	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
+	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
+	int ret;
+
+	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");
+
+	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
+		/*
+		 * Both kernels run on the same hardware, so it's impossible for
+		 * kdump kernel to see the support for linear stream table only.
+		 */
+		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
+			ret = -EINVAL;
+		else
+			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
+							       base);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/*
+		 * The kdump kernel need not match the crashed kernel. An older
+		 * crashed kernel that predates two-level stream table support
+		 * may have used a linear table on 2-level-capable hardware, so
+		 * enforce the same format here to match the adopted table.
+		 */
+		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
+		if (!ret)
+			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+	} else {
+		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err;
+	}
+
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
+				       smmu);
+	/* devm_add_action_or_reset ran the cleanup upon failure */
+	if (ret) {
+		dev_warn(smmu->dev, "failed to set up cleanup action\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_warn(smmu->dev, "falling back to full reset\n");
+	/*
+	 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so that the
+	 * full-reset fallback uses the hardware-supported format.
+	 */
+	if (was_2lvl)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
+	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
+	return ret;
+}
+#endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 42cd30c79211e..db80b980d1dd9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2034,11 +2034,23 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	struct arm_smmu_strtab_l2 **l2table;
+	u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
 
-	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
+	l2table = &cfg->l2.l2ptrs[l1_idx];
 	if (*l2table)
 		return 0;
 
+	/* Deferred adoption of the crashed kernel's L2 table */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[l1_idx].l2ptr);
+		phys_addr_t base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (span)
+			return arm_smmu_kdump_adopt_deferred_l2_strtab(
+				smmu, sid, base, span, l2table);
+	}
+
 	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
 				       &l2ptr_dma, GFP_KERNEL);
 	if (!*l2table) {
@@ -2050,8 +2062,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_initial_stes((*l2table)->stes,
 				   ARRAY_SIZE((*l2table)->stes));
-	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
-				      l2ptr_dma);
+	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
 	return 0;
 }
 
@@ -4869,6 +4880,10 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    !arm_smmu_kdump_adopt_strtab(smmu))
+		return 0;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
-- 
2.43.0

