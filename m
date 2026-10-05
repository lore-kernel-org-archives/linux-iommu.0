Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359036657B
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182542; cv=fail; b=FV7LB1KerRsRn8yvUH9/WQx0PGriYklg/SuYQ6IwEjiVdDKWs9ERN5G0zbqKh4ud6/kTFovChK0l3zfqxebTl1zCD9az5H/r+Y3yNSg2Xe/8FuyOz896/wCWtz1jddOkL234qRt2uMVnCEJVla9NuKUzHbEfIYUHL5KkbfWmSKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182542; c=relaxed/simple;
	bh=dnWaU68ybMHGAMd8MKZHozJFXgy/vilyK9cgiNRIZ1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2TKGJMaxFS8QjJNYBpF8ZqOVpJrLUG+fftEWTwtRuNXi6/yjZU4xzuC+BQzf+hyElW3wyYiCsJnPFC3a38dnxVwpKfMCLZ4djCtyb+zUbG5f1NhZpeSfKZAW7gRu/AphU64ty06mj8NTAS6+TL1p6FNCoBHMI1eAwVI8liohZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IkB0QhK4; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IkB0QhK4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRz+gOkEz4ad+3E2fA93YTkiFYuTFUzX2tAhdP9l+qrie643YVEqDnBV3Cp5y2YXz6A+YDrHpeq1+8+AEZNTBr0rim1X1l3E0BggDLK7ivtG+bbkL3+OG/OrScSIYK0RA+xQDs0KZwmCBztUwPYS7vj+/TKzaf8B0J2MwuPai7oWJPNcJQVjVLrSwFaPj5eOAE8wTwoFEZxnV8jbstaA1U2UfqqIrHJOEIvbRlHW2XVBQyvVqije702fZ5uwA/EK9DolTQMWxYhOn8CV3cbvyru1UZ4C6BXCCZ7COHCMGltvDlB33YpgY2mPBdI7HQL/qLX0KnCnSVzPgI/tQlcRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDlxqsEV7ybCSYJh8SEF4BKG5KLcjQGx5eOQJpeMUko=;
 b=oe3CZ4TfC8t9lG3BGXXk3/mSXsuY6Thrna6+urxAUNlvHZ8tpwNbxHwKNY98K1f/DubQFuJuUpuoliBVflPLzlUoFGcsGuCIAoJAtJWPDW3wxxD44ZnTqDa8NCZFIklz29ojq3LaAFQ9xX73rbN8ACsz5ZTftlICvym3JY4GEiEpA0cgJFGpPQ3x3OXagUnFGPrfs5DeeyMy9RNPpIS7SqY5X846E4T/kGy4YjBFOmQoxXleGfY536ZqiSPKUeJHcfB7ajK0FOa1GLhp/nPvtH/gXVa7DPJbHvr9FvGujQkUFfvsTF0lU4LIDa1w0FLhJCCCtzpPGIuGFoTtkNA9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDlxqsEV7ybCSYJh8SEF4BKG5KLcjQGx5eOQJpeMUko=;
 b=IkB0QhK4hRD+k49gpj+u2YwEawowxPrRDNJ+wlVy/9MSGrqXnC7eY9wdCmQlaKdL5JhXh4uC/Q32yqPi0+WZ391zPl0yhm2yA7wMYuaCBfivGBwQAN2SuvmQRNWVv7rHbw+dgrgqJAD9E2le0JdbNxDCkyuQKn/tFC67PMYNZRc=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 06:42:14 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::88) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:42:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:42:14 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:42:06 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/7] iommu/amd: preserve IOMMU and device state for live update
Date: Mon, 5 Oct 2026 06:40:14 +0000
Message-ID: <20261005064018.1558-5-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005064018.1558-1-Ankit.Soni@amd.com>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 657157b1-7a54-44de-d5b3-08df22abca86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|18002099003|22082099003|11063799006|6133799003|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	RRMMrngvTHPfDogU6kFmzuehF/91S+CbDWV3PDkbzOV2r0ymrFMMSYl3BA8s/HgPHS/0YmfghQURL6VhocothZDSUGk+cA38V9Mczw9OzdBI1vWVAVcbGLqvZcE4VeR6TpX4q9cvWizPla7Qqp0VpdkLrkqC+a27yHBm2tBoXYb6fEE+iIOo2Tgn+pU1qcu+0eL1t9Hy3BwqRP/l08V0ZDec8RWSMEDt3hVfjjPHstobOsFBeMCGzXzKCo00e6XmjePPmZz1HHFhIiF61gRqqw8t5hQ56vOl9UwJKrobxiOLkngKyZWbr+SfcFIqqgvnkesERW1SKnjxC4IuYk5EXPd2wnJh+E+ELFZT4IyhstnLQedTuG3ozmNtMsmM2ZqMuZsVBypoLs/te5Bevo5QVA+eJzJijEOSBlFw0pYEJfuvOVD5DIAtvUSISOKO0bKlTKyas8UA62/9ypNsX0TsIcUDXwn+Gowm35qC4PyaaMT+MMiRHSEj+mV/ouBAziF8Pqwzj/AhWPPDEwQHEIwkbChr3rU8HdsIz8QKBnG7U9D//DhST1QvZAez+NJ5LRowJ/RDOBBBbpPBxYnEk9wV5r2cfpm10OPjxoba60cJr2GZH2duEF78E5XSakb6jhKf6I1KSrbNTnILfd/HVaz6oZUvS3kD7gokXm+T/4b+ceoZs+faQqDA3YtwBcdeJppmxRSQD+C16rruaHPtoX7dPg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L+P2Emm4Z6Wuv4K59LDD5K2jKG/HY71/M/cJiU/GQ+Zmwx5exxpx69FUT9v9Jxx69/+fMWhCzfb/iJsF2jq+dTER6NNlTLyp/Um38AxqSlact11WO9HWjghbDxE3GiBXo/KcYEoHBpyHmuDnkPF+vQcRYOjGl9JicfvjltG800e8PTQdbPbHilCfKsjH62b9DtL6rm+BHyqcrFW418ccxqsTJ7AScHaakjL81sMh+kNo9JKVqw5jkpER9FVkQxs63U6/9QdbQMupQYBtAMkq0+oJGsOcItjcJiZj4/KQ0Ac/DyA9uoivwhbKqHqFSBk0ALYiXTxq9BRna2TOvA2PaFC1dz4DnBcHauRGw2H4afZotniHHrU+IlEesXMYaqkeSTyjqmdw+Ll5vZB6QX6gGcwg4ohBSQOoZwLriUzHffPYF8VVDVQUCfPvU0PibAw5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:42:14.1133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657157b1-7a54-44de-d5b3-08df22abca86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

Implement the .preserve and .preserve_device callbacks. Pin the PCI
segment's device table for KHO and record each device's domain ID,
page-table mode and GCR3 tree, so the next kernel can rebuild them.

The device table is shared by every IOMMU in a segment while the
callbacks run once per IOMMU, so the pin is reference counted.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/Makefile          |   1 +
 drivers/iommu/amd/amd_iommu.h       |  12 ++
 drivers/iommu/amd/amd_iommu_types.h |  14 ++
 drivers/iommu/amd/iommu.c           |   7 +
 drivers/iommu/amd/liveupdate.c      | 281 ++++++++++++++++++++++++++++
 5 files changed, 315 insertions(+)
 create mode 100644 drivers/iommu/amd/liveupdate.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 94b8ef2acb18..227bbe920c26 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -2,3 +2,4 @@
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a2fe804b038b..5cf32e4898dc 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -225,4 +225,16 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 struct iommu_domain *
 amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data);
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+/* LIVE UPDATE (drivers/iommu/amd/liveupdate.c) */
+int amd_iommu_preserve(struct iommu_device *iommu_dev,
+		       struct iommu_hw_ser *ser);
+void amd_iommu_unpreserve(struct iommu_device *iommu_dev,
+			  struct iommu_hw_ser *ser);
+int amd_iommu_preserve_device(struct device *dev,
+			      struct iommu_device_ser *device_ser);
+void amd_iommu_unpreserve_device(struct device *dev,
+				 struct iommu_device_ser *device_ser);
+#endif /* CONFIG_IOMMU_LIVEUPDATE */
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dbe20023456..fc9d98dfc6cd 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -596,6 +596,20 @@ struct amd_iommu_pci_seg {
 	 */
 	struct dev_table_entry *dev_table;
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/*
+	 * The device table is shared by every IOMMU in this PCI segment, but
+	 * the live-update .preserve callback runs once per IOMMU, and each of
+	 * those IOMMUs is preserved and unpreserved independently by the core.
+	 * KHO preservation is not refcounted, so the references are counted
+	 * here and the shared pages are pinned on the first and unpinned only
+	 * on the last -- otherwise one IOMMU being unpreserved would drop the
+	 * pin from underneath the devices still preserved behind every other
+	 * IOMMU in the segment.
+	 */
+	unsigned int dev_table_preserve_count;
+#endif
+
 	/*
 	 * The rlookup iommu table is used to find the IOMMU which is
 	 * responsible for a specific device. It is indexed by the PCI
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a83ce4521f7f..72df97b99589 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/percpu.h>
 #include <linux/cc_platform.h>
 #include <linux/crash_dump.h>
+#include <linux/iommu-liveupdate.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -3221,6 +3222,12 @@ const struct iommu_ops amd_iommu_ops = {
 	.page_response = amd_iommu_page_response,
 	.get_viommu_size = amd_iommufd_get_viommu_size,
 	.viommu_init = amd_iommufd_viommu_init,
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve_device	= amd_iommu_preserve_device,
+	.unpreserve_device	= amd_iommu_unpreserve_device,
+	.preserve		= amd_iommu_preserve,
+	.unpreserve		= amd_iommu_unpreserve,
+#endif
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/amd/liveupdate.c b/drivers/iommu/amd/liveupdate.c
new file mode 100644
index 000000000000..096a23bb4e7b
--- /dev/null
+++ b/drivers/iommu/amd/liveupdate.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD IOMMU (AMD-Vi) live update support.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ * Author: Ankit Soni <Ankit.Soni@amd.com>
+ */
+
+#include <linux/iommu-liveupdate.h>
+#include <linux/pci.h>
+
+#include "amd_iommu.h"
+#include "../iommu-pages.h"
+
+/* Each 4K GCR3 table level holds 512 u64 entries. */
+#define GCR3_ENTRIES_PER_LEVEL	512
+
+/**
+ * amd_iommu_preserve - Preserve one AMD IOMMU instance for live update
+ * @iommu_dev: Core handle for the IOMMU whose state is being preserved
+ * @ser: Serialized IOMMU-instance record to fill in
+ *
+ * Pins the PCI-segment Device Table. Command, event, PPR and GA buffers are
+ * not preserved: they are drained or quiesced at shutdown and the next kernel
+ * allocates fresh ones, matching Intel phase 1.
+ *
+ * Return: 0 on success, negative errno on failure (any pages pinned by this
+ * call are released before returning).
+ */
+int amd_iommu_preserve(struct iommu_device *iommu_dev, struct iommu_hw_ser *ser)
+{
+	struct amd_iommu *iommu = container_of(iommu_dev, struct amd_iommu, iommu);
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	int ret;
+
+	if (!pci_seg->dev_table_preserve_count) {
+		ret = iommu_preserve_pages(pci_seg->dev_table);
+		if (ret)
+			return ret;
+	}
+	pci_seg->dev_table_preserve_count++;
+
+	ser->type			= IOMMU_AMD;
+	ser->token			= iommu->mmio_phys;
+	ser->amd.mmio_phys		= iommu->mmio_phys;
+	ser->amd.dev_table_phys		= __pa(pci_seg->dev_table);
+	ser->amd.dev_table_size		= pci_seg->dev_table_size;
+	ser->amd.pci_seg_id		= pci_seg->id;
+	ser->amd.efr			= iommu->features;
+	ser->amd.efr2			= iommu->features2;
+
+	return 0;
+}
+
+/**
+ * amd_iommu_unpreserve - Release live-update state of one AMD IOMMU instance
+ * @iommu_dev: Core handle for the IOMMU whose state is being released
+ * @ser: Serialized IOMMU-instance record (unused; state is derived from @iommu)
+ *
+ * Reverse of amd_iommu_preserve(): once the last IOMMU of the segment has
+ * dropped its reference, unpins the shared Device Table.
+ */
+void amd_iommu_unpreserve(struct iommu_device *iommu_dev,
+			  struct iommu_hw_ser *ser)
+{
+	struct amd_iommu *iommu = container_of(iommu_dev, struct amd_iommu, iommu);
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	if (WARN_ON(!pci_seg->dev_table_preserve_count))
+		return;
+
+	if (!--pci_seg->dev_table_preserve_count)
+		iommu_unpreserve_pages(pci_seg->dev_table);
+}
+
+/*
+ * Map the domain's page-table mode onto its handoff wire value. Done with an
+ * explicit switch rather than a cast so that renumbering
+ * enum protection_domain_mode cannot silently change the ABI.
+ */
+static u32 pd_mode_to_ser(enum protection_domain_mode pd_mode)
+{
+	switch (pd_mode) {
+	case PD_MODE_V1:
+		return IOMMU_AMD_SER_PD_MODE_V1;
+	case PD_MODE_V2:
+		return IOMMU_AMD_SER_PD_MODE_V2;
+	default:
+		return IOMMU_AMD_SER_PD_MODE_NONE;
+	}
+}
+
+static void unpreserve_gcr3_level(u64 *tbl, int level)
+{
+	int i;
+
+	if (level > 0) {
+		for (i = 0; i < GCR3_ENTRIES_PER_LEVEL; i++) {
+			u64 *child;
+
+			if (!(tbl[i] & GCR3_VALID))
+				continue;
+
+			child = iommu_phys_to_virt(tbl[i] & PAGE_MASK);
+			unpreserve_gcr3_level(child, level - 1);
+		}
+	}
+
+	iommu_unpreserve_pages(tbl);
+}
+
+static int preserve_gcr3_level(u64 *tbl, int level)
+{
+	u64 *child;
+	int i, ret;
+
+	ret = iommu_preserve_pages(tbl);
+	if (ret)
+		return ret;
+
+	if (level == 0)
+		return 0;
+
+	for (i = 0; i < GCR3_ENTRIES_PER_LEVEL; i++) {
+		if (!(tbl[i] & GCR3_VALID))
+			continue;
+
+		child = iommu_phys_to_virt(tbl[i] & PAGE_MASK);
+		ret = preserve_gcr3_level(child, level - 1);
+		if (ret)
+			goto err_unwind;
+	}
+
+	return 0;
+
+err_unwind:
+	while (--i >= 0) {
+		if (!(tbl[i] & GCR3_VALID))
+			continue;
+
+		child = iommu_phys_to_virt(tbl[i] & PAGE_MASK);
+		unpreserve_gcr3_level(child, level - 1);
+	}
+	iommu_unpreserve_pages(tbl);
+	return ret;
+}
+
+/*
+ * A nested attach programs the DTE from the guest's own descriptor instead of
+ * from dev_data: the DOMID is the viommu's host domain ID for that guest domain,
+ * the GCR3 pointer is the guest's, and dev_data->domain is never assigned, so it
+ * still refers to whatever was attached before -- the nest parent, or nothing at
+ * all (see set_dte_nested()). None of that is recoverable from the state
+ * amd_iommu_preserve_device() serializes, and the core cannot filter it out
+ * either: a device on a nested domain is preserved against the domain of its
+ * paging parent, which is a legitimately preserved domain, so every check up to
+ * this point passes (see find_hwpt_paging()).
+ *
+ * Guest translation that this kernel set up itself always has a host-allocated
+ * GCR3 table behind it, which is what tells the two apart.
+ */
+static bool dev_is_nested_attached(struct iommu_dev_data *dev_data)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	if (!dev_table)
+		return false;
+
+	return (READ_ONCE(dev_table[dev_data->devid].data[0]) & DTE_FLAG_GV) &&
+	       !dev_data->gcr3_info.gcr3_tbl;
+}
+
+/**
+ * amd_iommu_preserve_device - Preserve per-device live-update state
+ * @dev: The device being preserved
+ * @device_ser: Serialized per-device record to fill in
+ *
+ * The device's DTE rides across the kexec inside the preserved Device Table and
+ * keeps being used by the hardware, so everything the DTE still points at
+ * afterwards must be KHO-pinned. For a PASID-capable device that is the GCR3
+ * directory tree; the domain's page tables are pinned by the core when it
+ * preserves the domain. Anything not pinned must instead be dropped from the
+ * DTE, which is what amd_iommu_clear_unpreserved_dtes() does at shutdown.
+ *
+ * Records the domain ID the DTE tags this device with, and the domain's
+ * page-table mode so the next kernel can confirm its own default agrees before
+ * adopting the preserved tables. Both describe the DTE only as long as it was
+ * programmed from dev_data, so a device whose DTE came from a guest descriptor
+ * instead is refused outright; see dev_is_nested_attached().
+ *
+ * The walk runs during the quiesced live-update window, where the device is
+ * owned by its userspace driver and no PASID is being attached or detached, so
+ * the GCR3 tree is stable and no iommu-group lock is taken.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int amd_iommu_preserve_device(struct device *dev,
+			      struct iommu_device_ser *device_ser)
+{
+	struct gcr3_tbl_info *gcr3_info;
+	struct iommu_dev_data *dev_data;
+	int ret;
+
+	if (!dev_is_pci(dev)) {
+		dev_err(dev, "cannot preserve non-PCI device\n");
+		return -EOPNOTSUPP;
+	}
+
+	dev_data = dev_iommu_priv_get(dev);
+	if (!dev_data)
+		return -EINVAL;
+
+	if (dev_is_nested_attached(dev_data)) {
+		dev_err(dev, "cannot preserve device attached to a nested domain\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!dev_data->domain)
+		return -EINVAL;
+
+	/* Page-table mode is a domain property, independent of PASID use. */
+	device_ser->amd.pd_mode = pd_mode_to_ser(dev_data->domain->pd_mode);
+
+	gcr3_info = &dev_data->gcr3_info;
+	if (!gcr3_info->gcr3_tbl) {
+		/*
+		 * Non-PASID device: the DTE's DOMID field holds the plain
+		 * protection-domain ID (see amd_iommu_set_dte_v1()), and there
+		 * is no GCR3 tree to pin.
+		 */
+		device_ser->domain_iommu_ser.attachment_id = dev_data->domain->id;
+		device_ser->amd.gcr3_tbl_phys = 0;
+		device_ser->amd.gcr3_glx = 0;
+		return 0;
+	}
+
+	/* PASID device: pin the whole GCR3 directory tree. */
+	ret = preserve_gcr3_level(gcr3_info->gcr3_tbl, gcr3_info->glx);
+	if (ret)
+		return ret;
+
+	/*
+	 * For a GCR3 device the DTE's DOMID field holds gcr3_info->domid, not
+	 * domain->id (see set_dte_gcr3_table()).
+	 */
+	device_ser->domain_iommu_ser.attachment_id = gcr3_info->domid;
+	device_ser->amd.gcr3_tbl_phys = __pa(gcr3_info->gcr3_tbl);
+	device_ser->amd.gcr3_glx = gcr3_info->glx;
+
+	return 0;
+}
+
+/**
+ * amd_iommu_unpreserve_device - Release per-device live-update state
+ * @dev: The device whose state is being released
+ * @device_ser: Serialized per-device record (unused)
+ *
+ * Reverse of amd_iommu_preserve_device(): unpins the GCR3 tree of a
+ * PASID-capable device. The DTE itself lives in the shared Device Table
+ * released by amd_iommu_unpreserve().
+ */
+void amd_iommu_unpreserve_device(struct device *dev,
+				 struct iommu_device_ser *device_ser)
+{
+	struct gcr3_tbl_info *gcr3_info;
+	struct iommu_dev_data *dev_data;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	dev_data = dev_iommu_priv_get(dev);
+	if (!dev_data)
+		return;
+
+	gcr3_info = &dev_data->gcr3_info;
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	unpreserve_gcr3_level(gcr3_info->gcr3_tbl, gcr3_info->glx);
+}
-- 
2.43.0

