Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DBBA48
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVkz7Vi+bEjT9H2BBBcvSlK9aPFghXsEXxidL7cOjFU0nyuqTmD7Ks7dy9gU30/cFmncZ3jKV14eQXi7AIe9cYbBPv2A7KRmYmFJaIcvaCyxg/6wC4JGJC02v8hHD1YJP3LMAjgdDPkgDiJkA9Yd0IZZRQ97UTPkW3qxiWlrP/JwTD3jVkcep9aqZ7M2uV5P2LMkJ3XNukmQGR89qtKed2aoXBImRoh4FVeUPlc9Y9B4qMPHq+3EViaAPLDeWnE329ve1UoKBfSHZsnvlUEupvlm5Nsk7CgDiehTMPDnmOK3z5pAEfni38RSJI693kCAjEYJY5tZvX74tLYRLpbzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9cTNbcTChKJbftvdmClycqFIbgEK2d+i/Y7vzrZ1iw=;
 b=GiFc6OO6B+HV0WnKftj7k2pOgoTW44CyRL+T7jjXaOEt+994/frlMQr932Hj5T0u9Ebivkk5s6YmK7j1eS3lDo4HWJNi4X6oE0J1jYBZQMq5vA/lj0KJRTqfQWOaLPfuRcIYldc7vw3wAAKuOQkbMjCR7Lg7k6M09rvD5eJdLQYruXrdi+RVnAMeipdIgM/k8hE8kOvq7OZ/KzNIlkWgCKVsVczph6c9gHE2p5w/CaA+LcpPN9Lh/sgiQrXgGvKwNVBC28ucivpMP6yf95oJSSTQdhJ5rdONOUpJ3fjb8rzaYsL7ADnfkmfJ9a6iTXC+Rb4HqqYfTCFavpeqoNy6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9cTNbcTChKJbftvdmClycqFIbgEK2d+i/Y7vzrZ1iw=;
 b=JhPw1/cbJ94r+PtMFCD7uEIu3wZPOmB3QWlJKf/jmVhEGyruwicTzUq9vHoEFZw8DgYvQNONQnlwte/rqPP+RxWTBXjHzbD1dT/8mt5w6gE1ejAu43Z/y9MaRQckHW5pV1tkfciQ2/sIyQWI1FREYWmmZ6haJXBtT+1JsxDs0Hw=
Received: from BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 12:03:21 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ee) by BYAPR06CA0031.outlook.office365.com
 (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 12:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 12:03:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:03:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 01/10] dma: Add SDXI device support
Date: Wed, 23 Aug 2023 12:02:11 +0000
Message-ID: <20230823120230.727935-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 865c48c9-49b9-46b3-2443-08dba3d0f230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vt1zp4KeIkqnbF0M1P+t2ZVy+cXBDt6UHYKW+HCJMlnFdv6fe6DfddX3ewIDD5kVy64m+pFV/ObOLf+2cfPAtxyPUuDjTCm4f5V+eIdcbMahvaZiDOdZBf4InhQEPH8EarS0lyzgQb/r5yeWxVpVUel+c1HF3mxc/+1sEly5o+OZlGRJeDCdMLGh8mKB6Elk6TJaDUQRLiDqrK1KGCztkFdBXEwo1o7Prn5xBHlHDKUXIJD/tmzAkAxUlCnBNssFHTKVnHTDLnrd+va/AcrfauhHsWVeLCB8Q+KfVo3qWDoXGMpjTNOtvXIqfKgINPcPlEz6F/uuDWFkSdMmkS0gSpVR0sNbrjzmLlSjS96GnPBKb6fK796BE+Hus/sp6Es50etBbhaOtIj3Pum28nnQ8oKbm0BedaE4vhL+b6fAezSv2dGpRtgRzanCqcS56Dzum3L6doOYkMYsLEUjktnLXQtcXXVE0l2M4UA7BJWn+hlUEEDLiXNUw4n7esUMy6IqKFKONCUHTstdekIEwhfAvHIaj7suS1oPFIg2EKiVu8EJh2/tNcaacfZynDLWZWjsZHuH9HIyC7WKyAlZBzOooMiPPHsMumIVdIm9J6+2LfyRbNtVk6S40o/6vtvYvx6q1OZ/n3oWqF7Suuzt0iNy5N4r8aBpRIqMQ89wH0uIdZ3InGw6sBMc9Hrwg713BmJ85HdUFzJC0hk6xiz1I+IOXXeqB3a9nYHUER7W4ahjAmdJ3IsDi0PNoBnCaeMh6VRRWGO30ZRFHZHKcpGxKuPiAw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(5660300002)(47076005)(40460700003)(36860700001)(83380400001)(30864003)(36756003)(2906002)(356005)(81166007)(82740400003)(86362001)(40480700001)(41300700001)(110136005)(54906003)(70586007)(70206006)(7696005)(316002)(2616005)(4326008)(8676002)(8936002)(478600001)(6666004)(26005)(16526019)(1076003)(426003)(336012)(44832011)(36900700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:03:21.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865c48c9-49b9-46b3-2443-08dba3d0f230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479

From: Wei Huang <wei.huang2@amd.com>

Smart Data Accelerator Interface (SDXI) DMA controller provides DMA
capabilities, plus other advanced data processing features, that can
offload the work for CPUs under different address spaces. This patch
adds SDXI device driver support.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/Kconfig        |   2 +
 drivers/dma/Makefile       |   1 +
 drivers/dma/sdxi/Kconfig   |  11 +
 drivers/dma/sdxi/Makefile  |   3 +
 drivers/dma/sdxi/core.c    | 428 +++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.c     | 441 ++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h     |  23 ++
 drivers/dma/sdxi/ioctl.c   | 440 ++++++++++++++++++++++++++++++
 drivers/dma/sdxi/ioctl.h   |  49 ++++
 drivers/dma/sdxi/pci.c     | 533 +++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/pci.h     | 130 +++++++++
 drivers/dma/sdxi/process.c | 285 ++++++++++++++++++++
 drivers/dma/sdxi/process.h |  71 +++++
 drivers/dma/sdxi/sdxi.h    | 414 ++++++++++++++++++++++++++++
 drivers/dma/sdxi/sq.c      | 295 ++++++++++++++++++++
 drivers/dma/sdxi/sq.h      |  67 +++++
 drivers/dma/sdxi/trace.c   |  10 +
 drivers/dma/sdxi/trace.h   | 115 ++++++++
 include/linux/pci_ids.h    |   2 +
 include/uapi/linux/sdxi.h  |  70 +++++
 20 files changed, 3390 insertions(+)
 create mode 100644 drivers/dma/sdxi/Kconfig
 create mode 100644 drivers/dma/sdxi/Makefile
 create mode 100644 drivers/dma/sdxi/core.c
 create mode 100644 drivers/dma/sdxi/dma.c
 create mode 100644 drivers/dma/sdxi/dma.h
 create mode 100644 drivers/dma/sdxi/ioctl.c
 create mode 100644 drivers/dma/sdxi/ioctl.h
 create mode 100644 drivers/dma/sdxi/pci.c
 create mode 100644 drivers/dma/sdxi/pci.h
 create mode 100644 drivers/dma/sdxi/process.c
 create mode 100644 drivers/dma/sdxi/process.h
 create mode 100644 drivers/dma/sdxi/sdxi.h
 create mode 100644 drivers/dma/sdxi/sq.c
 create mode 100644 drivers/dma/sdxi/sq.h
 create mode 100644 drivers/dma/sdxi/trace.c
 create mode 100644 drivers/dma/sdxi/trace.h
 create mode 100644 include/uapi/linux/sdxi.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 644c188d6a11..731d320499e7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -775,6 +775,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
 source "drivers/dma/lgm/Kconfig"
 
+source "drivers/dma/sdxi/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fd1ce29510..43c57226fd3b 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_SDXI) += sdxi/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
new file mode 100644
index 000000000000..10494042b20c
--- /dev/null
+++ b/drivers/dma/sdxi/Kconfig
@@ -0,0 +1,11 @@
+config SDXI
+	tristate "SDXI support"
+	default m
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select AMD_IOMMU_V2
+	help
+	  Enable support for Smart Data Accelerator Interface (SDXI) DMA
+	  controller. This controller provides DMA capabilities, plus other
+	  advanced data processing features, that can offload the work for
+	  CPUs.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
new file mode 100644
index 000000000000..dcb81f574a77
--- /dev/null
+++ b/drivers/dma/sdxi/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SDXI)	+= sdxi.o
+
+sdxi-objs := pci.o core.o sq.o dma.o ioctl.o process.o trace.o
diff --git a/drivers/dma/sdxi/core.c b/drivers/dma/sdxi/core.c
new file mode 100644
index 000000000000..187e2e0c660c
--- /dev/null
+++ b/drivers/dma/sdxi/core.c
@@ -0,0 +1,428 @@
+/*
+ * SDXI hardware device driver
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#define dev_fmt(fmt)    "SDXI: " fmt
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <asm/mmu.h>
+#include <linux/ptrace.h>
+
+#include "sdxi.h"
+#include "pci.h"
+#include "sq.h"
+#include "process.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+static bool dma_engine;
+module_param(dma_engine, bool, 0644);
+MODULE_PARM_DESC(dma_engine, "Enable DMA engine interface (default: false)");
+
+static void set_ctxt_l2_entry(struct sdxi_dev *sdxi,
+			      struct ctxt_l2_entry *l2_entry,
+			      struct ctxt_l1_entry *l1_table)
+{
+	struct device *dev = &sdxi->pdev->dev;
+	dma_addr_t l1_addr;
+
+	if (l1_table) {
+		/* already set, nothing to do. NB: maybe do checking */
+		if (l2_entry->valid)
+			return;
+
+		l1_addr = dma_map_single(dev, l1_table, L1_TABLE_SIZE,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, l1_addr)) {
+			dev_err(dev, "dma_map_single for L1 table failed\n");
+			return;
+		}
+
+		l2_entry->ctxt_l1_base = l1_addr >> L2_CTXT_L1_BASE_SHIFT;
+		l2_entry->valid = 1;
+	} else {
+		memset(l2_entry, 0, sizeof(*l2_entry));
+	}
+}
+
+static void set_ctxt_l1_entry(struct sdxi_dev *sdxi,
+			      struct ctxt_l1_entry *l1_entry,
+			      struct sdxi_ctxt *ctxt)
+{
+	struct device *dev = &sdxi->pdev->dev;
+
+	if (ctxt) {
+		/* NB: More need to be done */
+		ctxt->cce_addr = dma_map_single(dev, &ctxt->cce,
+						sizeof(struct ctxt_ctrl_entry),
+						DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, ctxt->cce_addr)) {
+			dev_err(dev, "dma_map for ctxt ctrl addr failed\n");
+			return;
+		}
+
+		/* akey handling */
+		ctxt->akey_addr = dma_map_single(dev, ctxt->akey,
+						 ctxt->akey_entries * sizeof(struct akey_entry),
+						 DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, ctxt->akey_addr))  {
+			dev_err(dev, "dma_map for akey table failed\n");
+			dma_unmap_single(dev, ctxt->cce_addr, sizeof(struct ctxt_ctrl_entry),
+					 DMA_TO_DEVICE);
+			return;
+		}
+
+		l1_entry->ctxt_ctrl_ptr = ctxt->cce_addr >> L1_CTXT_CTRL_PTR_SHIFT;
+		l1_entry->akey_tbl_ptr = ctxt->akey_addr >> L1_CTXT_AKEY_PTR_SHIFT;
+		l1_entry->akey_tbl_size = (ctxt->akey_entries * sizeof(struct akey_entry) >> 12) - 1;
+		l1_entry->cmd_grp0_support = sdxi->op_grp_cap;
+		l1_entry->valid = 1;
+		l1_entry->active = 1;
+
+		ctxt->akey[0].vl = 1;
+	} else {
+		memset(l1_entry, 0, sizeof(*l1_entry));
+	}
+}
+
+static void config_ctxt_table_entries(struct ctxt_l2_entry *l2_table,
+				      struct ctxt_l1_entry *l1_table,
+				      struct sdxi_ctxt *ctxt,
+				      bool clear)
+{
+	u16 id;
+	struct ctxt_l2_entry *l2_entry;
+	struct ctxt_l1_entry *l1_entry;
+	struct sdxi_dev *sdxi = ctxt->sdxi;
+
+	if (!ctxt || !l1_table || !l2_table)
+		return;
+
+	id = ctxt->id;
+	l2_entry = l2_table + ID_TO_L2_INDEX(id);
+	l1_entry = l1_table + ID_TO_L1_INDEX(id);
+
+	if (!clear) {
+		set_ctxt_l2_entry(sdxi, l2_entry, l1_table);
+		set_ctxt_l1_entry(sdxi, l1_entry, ctxt);
+	} else {
+		memset(l1_entry, 0, sizeof(*l1_entry));
+	}
+}
+
+static int config_ctxt_tables(struct sdxi_dev *sdxi,
+			      struct sdxi_ctxt *ctxt)
+{
+	u16 id, l2_idx, l1_idx;
+	struct ctxt_l2_entry *l2_table = sdxi->l2_table;
+	struct ctxt_l1_entry *l1_table;
+
+	if (!ctxt)
+		return -EINVAL;
+
+	id = ctxt->id;
+	l2_idx = ID_TO_L2_INDEX(id);
+	l1_idx = ID_TO_L1_INDEX(id);
+
+	/* allocate l1 table if needed */
+	l1_table = sdxi->l1_table_array[l2_idx];
+	if (!l1_table) {
+		gfp_t gfp_flags;
+		unsigned long order;
+
+		gfp_flags = GFP_KERNEL | __GFP_ZERO;
+		order = get_order(L1_TABLE_SIZE);
+		l1_table = (struct ctxt_l1_entry *)__get_free_pages(gfp_flags,
+								    order);
+
+		if (!l1_table)
+			return -ENOMEM;
+
+		sdxi->l1_table_array[l2_idx] = l1_table;
+	}
+
+	/* configure l2 and l1 entries */
+	config_ctxt_table_entries(l2_table, l1_table, ctxt, false);
+
+	return 0;
+}
+
+static void cleanup_ctxt_tables(struct sdxi_dev *sdxi,
+				struct sdxi_ctxt *ctxt)
+{
+	u16 id, l2_idx, l1_idx;
+	struct ctxt_l2_entry *l2_table = sdxi->l2_table;
+	struct ctxt_l1_entry *l1_table;
+
+	if (!ctxt)
+		return;
+
+	id = ctxt->id;
+	l2_idx = ID_TO_L2_INDEX(id);
+	l1_idx = ID_TO_L1_INDEX(id);
+
+	l1_table = sdxi->l1_table_array[l2_idx];
+	/* clear l1 entry */
+	config_ctxt_table_entries(l2_table, l1_table, ctxt, true);
+}
+
+static struct sdxi_ctxt *alloc_ctxt(struct sdxi_dev *sdxi)
+{
+	struct sdxi_ctxt *ctxt;
+	u16 id, l2_idx, l1_idx;
+	struct akey_entry *akey;
+	int entries = DEFAULT_AKEY_NUM;
+
+	if (sdxi->ctxt_count >= sdxi->max_cxts)
+		return NULL;
+
+	if (entries > sdxi->max_akeys)
+		return NULL;
+
+	/* search for an empty context slot */
+	for (id = 0; id < sdxi->max_cxts; id++) {
+		l2_idx = ID_TO_L2_INDEX(id);
+		l1_idx = ID_TO_L1_INDEX(id);
+
+		if (sdxi->ctxt_array[l2_idx] == NULL) {
+			int sz = sizeof(struct sdxi_ctxt *) * L1_TABLE_ENTRIES;
+			struct sdxi_ctxt **ptr = kzalloc(sz, GFP_KERNEL);
+
+			sdxi->ctxt_array[l2_idx] = ptr;
+			if (!(sdxi->ctxt_array[l2_idx]))
+				return NULL;
+		}
+
+		ctxt = (sdxi->ctxt_array)[l2_idx][l1_idx];
+		/* found one empty slot */
+		if (!ctxt)
+			break;
+	}
+
+	/* nothing found, bail... */
+	if (id == sdxi->max_cxts)
+		return NULL;
+
+	/* alloc context and initialize it */
+	ctxt = kzalloc(sizeof(struct sdxi_ctxt), GFP_KERNEL);
+	if (!ctxt)
+		return NULL;
+
+	akey = kzalloc(entries * sizeof(struct akey_entry), GFP_KERNEL);
+	if (!akey) {
+		kfree(ctxt);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&ctxt->list);
+	ctxt->sdxi = sdxi;
+	ctxt->id = id;
+	ctxt->akey_entries = entries;
+	ctxt->akey = akey;
+	ctxt->db_base = sdxi->dbs_bar + id * sdxi->db_stride;
+	ctxt->db = sdxi->dbs + id * sdxi->db_stride;
+
+	sdxi->ctxt_array[l2_idx][l1_idx] = ctxt;
+	list_add(&ctxt->list, &sdxi->ctxt_list);
+	sdxi->ctxt_count++;
+
+	return ctxt;
+}
+
+static void free_ctxt(struct sdxi_ctxt *ctxt)
+{
+	struct sdxi_dev *sdxi = ctxt->sdxi;
+
+	trace_sdxi_free_ctxt(sdxi, ctxt);
+
+	sdxi->ctxt_count--;
+	list_del(&ctxt->list);
+	kfree(ctxt->akey);
+	kfree(ctxt);
+}
+
+/* alloc context resources and populate context table */
+struct sdxi_ctxt *sdxi_ctxt_alloc(struct sdxi_dev *sdxi)
+{
+	struct sdxi_ctxt *ctxt = NULL;
+	unsigned long flags;
+	gfp_t gfp_flags;
+	struct device *dev = &sdxi->pdev->dev;
+	int ret;
+
+	spin_lock_irqsave(&sdxi->ctxt_lock, flags);
+
+	ctxt = alloc_ctxt(sdxi);
+	if (!ctxt)
+		goto err_out;
+
+	gfp_flags = GFP_KERNEL | __GFP_ZERO;
+	ctxt->dummy_buffer = (void *)__get_free_pages(gfp_flags, 0);
+	ctxt->dummy_buffer_addr = dma_map_single(dev, ctxt->dummy_buffer, 4096,
+                                                DMA_FROM_DEVICE);
+
+       ret = config_ctxt_tables(sdxi, ctxt);
+	if (ret) {
+		free_ctxt(ctxt);
+		ctxt = NULL;
+	}
+
+	trace_sdxi_create_ctxt(sdxi, ctxt);
+
+err_out:
+	spin_unlock_irqrestore(&sdxi->ctxt_lock, flags);
+	return ctxt;
+}
+
+/* clear context table and free context resources */
+void sdxi_ctxt_free(struct sdxi_ctxt *ctxt)
+{
+	struct sdxi_dev *sdxi = ctxt->sdxi;
+	unsigned long flags;
+
+	trace_sdxi_free_ctxt(sdxi, ctxt);
+
+	spin_lock_irqsave(&sdxi->ctxt_lock, flags);
+
+	cleanup_ctxt_tables(sdxi, ctxt);
+	free_pages((unsigned long)ctxt->dummy_buffer, 0);
+	free_ctxt(ctxt);
+
+	spin_unlock_irqrestore(&sdxi->ctxt_lock, flags);
+}
+
+struct sdxi_ctxt *sdxi_working_ctxt_init(struct sdxi_dev *sdxi,
+					 enum sdxi_ctxt_id id)
+{
+	struct device *dev = &sdxi->pdev->dev;
+	struct sdxi_ctxt *ctxt;
+	struct sdxi_sq *sq;
+
+	ctxt = sdxi_ctxt_alloc(sdxi);
+	if (!ctxt) {
+		dev_err(dev, "failed to alloc a new context\n");
+		return NULL;
+	}
+
+	/* check if context ID matches */
+	if (id < SDXI_ANY_CTXT_ID && ctxt->id != id) {
+		dev_err(dev, "failed to alloc a context with id=%d\n", id);
+		goto err_ctxt_id;
+	}
+
+	sq = sdxi_sq_alloc_default(ctxt);
+	if (!sq) {
+		dev_err(dev, "failed to alloc a submission queue (sq)\n");
+		goto err_sq_alloc;
+	}
+
+	return ctxt;
+
+err_sq_alloc:
+err_ctxt_id:
+	sdxi_ctxt_free(ctxt);
+
+	return NULL;
+}
+
+void sdxi_working_ctxt_exit(struct sdxi_ctxt *ctxt)
+{
+	struct sdxi_sq *sq;
+
+	if (!ctxt)
+		return;
+
+	sq = ctxt->sq;
+	if (!sq)
+		return;
+
+	sdxi_sq_free(sq);
+
+	sdxi_ctxt_free(ctxt);
+}
+
+/* NB: This might not be the best way of doing things. We want
+ * to allocate a new context for user space. However the question
+ * is which sdxi_device will host it? Right now this function just
+ * pick from the first in sdxi_device_list. But it certainly can
+ * be improved. Also move this function to sdxi.c file.
+ */
+struct sdxi_ctxt *sdxi_working_ctxt_alloc(void)
+{
+	struct list_head *curr;
+	struct sdxi_dev *sdxi;
+	struct sdxi_ctxt *ctxt;
+
+	if (list_empty(&sdxi_device_list))
+		return NULL;
+
+	list_for_each(curr, &sdxi_device_list) {
+		sdxi = list_entry(curr, struct sdxi_dev, list);
+
+		//ctxt = sdxi_working_ctxt_init(sdxi, SDXI_ANY_CTXT_ID);
+		ctxt = sdxi->kern_ctxt;
+		if (ctxt)
+			return ctxt;
+	}
+
+	return NULL;
+}
+
+/* Main entry point for SDXI device initial configuration */
+int sdxi_device_init(struct sdxi_dev *sdxi)
+{
+	struct sdxi_ctxt *admin_ctxt, *dma_ctxt, *kern_ctxt;
+	struct sdxi_desc desc;
+
+	/* init admin context */
+	admin_ctxt = sdxi_working_ctxt_init(sdxi, SDXI_ADMIN_CTXT_ID);
+	if (!admin_ctxt)
+		return -EINVAL;
+
+	/* init DMA context */
+	dma_ctxt = sdxi_working_ctxt_init(sdxi, SDXI_DMA_CTXT_ID);
+	if (!dma_ctxt)
+		goto err_dma_ctxt;
+
+	/* init in kernel API context */
+	kern_ctxt = sdxi_working_ctxt_init(sdxi, SDXI_KERNEL_CTXT_ID);
+	if (!kern_ctxt)
+		goto err_kern_ctxt;
+
+	sdxi->admin_ctxt = admin_ctxt;
+	sdxi->dma_ctxt = dma_ctxt;
+	sdxi->kern_ctxt = kern_ctxt;
+
+	build_admin_start_new(&desc, 0, 0, SDXI_DMA_CTXT_ID, SDXI_KERNEL_CTXT_ID, 0);
+	sdxi_sq_submit_desc(admin_ctxt->sq, &desc, false, 0);
+
+	/* register with DMA engine */
+	if (dma_engine)
+		sdxi_dma_register(sdxi->dma_ctxt);
+
+	return 0;
+err_kern_ctxt:
+	sdxi_working_ctxt_exit(dma_ctxt);
+err_dma_ctxt:
+	sdxi_working_ctxt_exit(admin_ctxt);
+
+	return -EINVAL;
+}
+
+void sdxi_device_exit(struct sdxi_dev *sdxi)
+{
+	if (dma_engine)
+		sdxi_dma_unregister(sdxi->dma_ctxt);
+
+	sdxi_working_ctxt_exit(sdxi->kern_ctxt);
+	sdxi_working_ctxt_exit(sdxi->dma_ctxt);
+	sdxi_working_ctxt_exit(sdxi->admin_ctxt);
+}
diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
new file mode 100644
index 000000000000..6a83c51e160f
--- /dev/null
+++ b/drivers/dma/sdxi/dma.c
@@ -0,0 +1,441 @@
+/*
+ * SDXI DMA engine implementation
+ *   Derived from ptdma code
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+
+#include "../dmaengine.h"
+#include "sdxi.h"
+#include "sq.h"
+
+
+static inline struct sdxi_dma_chan *to_sdxi_dma_chan(struct dma_chan *dma_chan)
+{
+	return container_of(dma_chan, struct sdxi_dma_chan, vc.chan);
+}
+
+static inline struct sdxi_dma_desc *to_sdxi_dma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct sdxi_dma_desc, vd);
+}
+
+static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+
+	vchan_free_chan_resources(&chan->vc);
+	/* NB: more configure with sdxi_ctxt? */
+}
+
+static void sdxi_dma_synchronize(struct dma_chan *c)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(c);
+
+	vchan_synchronize(&chan->vc);
+}
+
+static void sdxi_do_cleanup(struct virt_dma_desc *vd)
+{
+	struct sdxi_dma_desc *desc = to_sdxi_dma_desc(vd);
+	struct sdxi_dev *sdxi = desc->ctxt->sdxi;
+
+	kmem_cache_free(sdxi->dma_desc_cache, desc);
+}
+
+static int sdxi_dma_start_desc(struct sdxi_dma_desc *dma_desc)
+{
+	struct sdxi_dev *sdxi;
+	struct sdxi_cmd *sdxi_cmd;
+	struct sdxi_ctxt *ctxt;
+	struct sdxi_sq *sq;
+	struct sdxi_desc desc;
+
+
+	dma_desc->issued_to_hw = 1;
+
+	sdxi_cmd = &dma_desc->sdxi_cmd;
+	sdxi = sdxi_cmd->ctxt->sdxi;
+
+
+	sdxi->tdata.cmd = sdxi_cmd;
+
+	/* submit to sdxi context */
+	ctxt = dma_desc->ctxt;
+	memset(ctxt->dummy_buffer, 0, 4096);
+	((int *)ctxt->dummy_buffer)[0] = 1;
+	sq = ctxt->sq;
+
+	if (sdxi_cmd->len > MAX_DMA_COPY_BYTES)
+		return 1;
+
+	build_dma_copy(&desc, sdxi_cmd->len, 0, 0, 0, 0, sdxi_cmd->src_addr,
+		       sdxi_cmd->dst_addr, ctxt->dummy_buffer_addr);
+
+	/* Submit the command */
+	sdxi_cmd->index = sdxi_sq_submit_desc(sq, &desc, true, 0xFF);
+	sdxi_cmd->ret = 0; // TODO: get desc submit status & update ret value
+
+	return 0;
+}
+
+static struct sdxi_dma_desc *sdxi_next_dma_desc(struct sdxi_dma_chan *chan)
+{
+	/* Get the next DMA descriptor on the active list */
+	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
+
+	return vd ? to_sdxi_dma_desc(vd) : NULL;
+}
+
+static struct sdxi_dma_desc *sdxi_handle_active_desc(struct sdxi_dma_chan *chan,
+						     struct sdxi_dma_desc *desc)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	/* Loop over descriptors until one is found with commands */
+	do {
+		if (desc) {
+			if (!desc->issued_to_hw) {
+				/* No errors, keep going */
+				if (desc->status != DMA_ERROR)
+					return desc;
+			}
+
+			tx_desc = &desc->vd.tx;
+			vd = &desc->vd;
+		} else {
+			tx_desc = NULL;
+		}
+
+		spin_lock_irqsave(&chan->vc.lock, flags);
+
+		if (desc) {
+
+			if (desc->status != DMA_COMPLETE) {
+				if (desc->status != DMA_ERROR)
+					desc->status = DMA_COMPLETE;
+
+				dma_cookie_complete(tx_desc);
+				dma_descriptor_unmap(tx_desc);
+				list_del(&desc->vd.node);
+			} else {
+				/* Don't handle it twice */
+				tx_desc = NULL;
+			}
+		}
+
+		desc = sdxi_next_dma_desc(chan);
+
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+		if (tx_desc) {
+			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+			dma_run_dependencies(tx_desc);
+			vchan_vdesc_fini(vd);
+		}
+	} while (desc);
+
+	return NULL;
+}
+
+static void sdxi_cmd_callback(void *data, int err)
+{
+	struct sdxi_dma_desc *desc = data;
+	struct dma_chan *dma_chan;
+	struct sdxi_dma_chan *chan;
+	int ret;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	dma_chan = desc->vd.tx.chan;
+	chan = to_sdxi_dma_chan(dma_chan);
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	while (true) {
+		/* Check for DMA descriptor completion */
+		desc = sdxi_handle_active_desc(chan, desc);
+
+		/* Don't submit cmd if no descriptor or DMA is paused */
+		if (!desc)
+			break;
+
+		ret = sdxi_dma_start_desc(desc);
+		if (!ret)
+			break;
+
+		desc->status = DMA_ERROR;
+	}
+}
+
+static struct sdxi_dma_desc *sdxi_dma_alloc_dma_desc(struct sdxi_dma_chan *chan,
+					     unsigned long flags)
+{
+	struct sdxi_dma_desc *desc;
+
+	desc = kmem_cache_zalloc(chan->ctxt->sdxi->dma_desc_cache, GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->ctxt = chan->ctxt;
+
+	vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+	desc->ctxt->sdxi = chan->ctxt->sdxi;
+	desc->issued_to_hw = 0;
+	desc->status = DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct sdxi_dma_desc *sdxi_dma_create_desc(struct dma_chan *dma_chan,
+					  dma_addr_t dst,
+					  dma_addr_t src,
+					  unsigned int len,
+					  unsigned long flags)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc;
+	struct sdxi_cmd *sdxi_cmd;
+
+	desc = sdxi_dma_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	sdxi_cmd = &desc->sdxi_cmd;
+	sdxi_cmd->ctxt = chan->ctxt;
+	sdxi_cmd->ctxt->sdxi = chan->ctxt->sdxi;
+	sdxi_cmd->src_addr = src;
+	sdxi_cmd->dst_addr = dst;
+	sdxi_cmd->len = len;
+	sdxi_cmd->sdxi_cmd_callback = sdxi_cmd_callback;
+	sdxi_cmd->data = desc;
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *
+sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
+		   dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct sdxi_dma_desc *desc;
+
+	desc = sdxi_dma_create_desc(dma_chan, dst, src, len, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static struct dma_async_tx_descriptor *
+sdxi_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc;
+
+	desc = sdxi_dma_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc;
+	unsigned long flags;
+	bool engine_is_idle = true;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	desc = sdxi_next_dma_desc(chan);
+	if (desc)
+		engine_is_idle = false;
+
+	vchan_issue_pending(&chan->vc);
+
+	desc = sdxi_next_dma_desc(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was nothing active, start processing */
+	if (engine_is_idle)
+		sdxi_cmd_callback(desc, 0);
+}
+
+static void sdxi_check_trans_status(struct sdxi_dma_chan *chan)
+{
+	struct sdxi_ctxt *ctxt = chan->ctxt;
+	struct sdxi_sq *sq = ctxt->sq;
+	struct sdxi_cmd *cmd = ctxt->sdxi->tdata.cmd;
+
+	if (sq->cst_blk[cmd->index].comp_signal == 0xFE)
+		sdxi_cmd_callback(cmd->data, cmd->ret);
+}
+
+static enum dma_status sdxi_tx_status(struct dma_chan *dma_chan, dma_cookie_t cookie,
+				      struct dma_tx_state *tx_state)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+
+	sdxi_check_trans_status(chan);
+
+	return dma_cookie_status(dma_chan, cookie, tx_state);
+}
+
+static int sdxi_dma_pause(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	// TODO
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	return 0;
+}
+
+static int sdxi_dma_resume(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	// TODO
+	desc = sdxi_next_dma_desc(chan);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was something active, re-start */
+	if (desc)
+		sdxi_cmd_callback(desc, 0);
+
+	return 0;
+}
+
+static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vchan_get_all_descriptors(&chan->vc, &head);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&chan->vc, &head);
+	vchan_free_chan_resources(&chan->vc);
+
+	return 0;
+}
+
+int sdxi_dma_register(struct sdxi_ctxt *dma_ctxt)
+{
+	struct sdxi_dma_chan *chan;
+	struct sdxi_dev *sdxi = dma_ctxt->sdxi;
+	struct device *dev;
+	struct dma_device *dma_dev = &sdxi->dma_dev;
+	char *cmd_cache_name;
+	char *desc_cache_name;
+	int ret = 0;
+
+	if (!dma_ctxt)
+		return 0;
+
+	sdxi = dma_ctxt->sdxi;
+	dev = &sdxi->pdev->dev;
+
+	sdxi->sdxi_dma_chan = devm_kzalloc(dev, sizeof(*sdxi->sdxi_dma_chan),
+					   GFP_KERNEL);
+	if (!sdxi->sdxi_dma_chan)
+		return -ENOMEM;
+
+	sdxi->sdxi_dma_chan->ctxt = dma_ctxt;
+
+	cmd_cache_name = devm_kasprintf(dev, GFP_KERNEL,
+					"%s-dmaengine-cmd-cache",
+					dev_name(dev));
+	if (!cmd_cache_name)
+		return -ENOMEM;
+
+	desc_cache_name = devm_kasprintf(dev, GFP_KERNEL,
+					 "%s-dmaengine-desc-cache",
+					 dev_name(dev));
+	if (!desc_cache_name) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	sdxi->dma_desc_cache = kmem_cache_create(desc_cache_name,
+					       sizeof(struct sdxi_dma_desc), 0,
+					       SLAB_HWCACHE_ALIGN, NULL);
+	if (!sdxi->dma_desc_cache) {
+		ret = -ENOMEM;
+		goto err_cache;
+	}
+
+	dma_dev->dev = dev;
+	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->directions = DMA_MEM_TO_MEM;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
+
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	chan = sdxi->sdxi_dma_chan;
+	chan->ctxt->sdxi = sdxi;
+
+	/* Set base and prep routines */
+	dma_dev->device_free_chan_resources = sdxi_dma_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = sdxi_dma_prep_memcpy;
+	dma_dev->device_prep_dma_interrupt = sdxi_prep_dma_interrupt;
+	dma_dev->device_issue_pending = sdxi_dma_issue_pending;
+	dma_dev->device_tx_status = sdxi_tx_status;
+	dma_dev->device_pause = sdxi_dma_pause;
+	dma_dev->device_resume = sdxi_dma_resume;
+	dma_dev->device_terminate_all = sdxi_dma_terminate_all;
+	dma_dev->device_synchronize = sdxi_dma_synchronize;
+
+	chan->vc.desc_free = sdxi_do_cleanup;
+	vchan_init(&chan->vc, dma_dev);
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto err_reg;
+
+	return 0;
+
+err_reg:
+	kmem_cache_destroy(sdxi->dma_desc_cache);
+
+err_cache:
+	kmem_cache_destroy(sdxi->dma_cmd_cache);
+
+	return ret;
+}
+
+void sdxi_dma_unregister(struct sdxi_ctxt *dma_ctxt)
+{
+	dma_async_device_unregister(&dma_ctxt->sdxi->dma_dev);
+
+	kmem_cache_destroy(dma_ctxt->sdxi->dma_desc_cache);
+	kmem_cache_destroy(dma_ctxt->sdxi->dma_cmd_cache);
+}
diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
new file mode 100644
index 000000000000..950d94af868a
--- /dev/null
+++ b/drivers/dma/sdxi/dma.h
@@ -0,0 +1,23 @@
+/*
+ * DMA engine support
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+
+#include "../dma/dmaengine.h"
+#include "../dma/virt-dma.h"
+
+#include "sdxi.h"
+#include "sq.h"
+
+#ifndef __SDXI_DMA_H
+#define __SDXI_DMA_H
+
+#endif /* __SDXI_DMA_H */
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
new file mode 100644
index 000000000000..6b926795dc03
--- /dev/null
+++ b/drivers/dma/sdxi/ioctl.c
@@ -0,0 +1,440 @@
+/*
+ * SDXI IOCTL Interface
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/miscdevice.h>
+#include <linux/amd-iommu.h>
+#include <uapi/linux/sdxi.h>
+
+#include "ioctl.h"
+#include "process.h"
+#include "sdxi.h"
+#include "sq.h"
+
+static const char sdxi_dev_name[] = "sdxi";
+static int sdxi_char_dev_major = -1;
+static struct class *sdxi_class;
+struct device *sdxi_device;
+
+/*********************/
+/* SUPPORT FUNCTIONS */
+/*********************/
+static int sdxi_ctxt_doorbell_mmap(struct sdxi_process *process,
+				   struct vm_area_struct *vma)
+{
+	struct sdxi_ctxt *ctxt = process->ctxt;
+	struct sdxi_dev *sdxi = ctxt->sdxi;
+	phys_addr_t address;
+	int ret;
+
+	if (vma->vm_end - vma->vm_start != sdxi->db_stride)
+		return -EINVAL;
+
+	address = ctxt->db_base;
+
+	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
+		VM_DONTDUMP | VM_PFNMAP;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	pr_debug("pasid 0x%x mapping mmio page\n"
+		 "     target user address == 0x%08llX\n"
+		 "     physical address    == 0x%08llX\n"
+		 "     vm_flags            == 0x%04lX\n"
+		 "     size                == 0x%04lX\n",
+		 process->pasid, (unsigned long long) vma->vm_start,
+		 address, vma->vm_flags, PAGE_SIZE);
+
+	ret = io_remap_pfn_range(vma,
+				 vma->vm_start,
+				 address >> PAGE_SHIFT,
+				 sdxi->db_stride,
+				 vma->vm_page_prot);
+
+	return ret;
+}
+
+static int sdxi_ctxt_struct_mmap(struct sdxi_process *process,
+				 struct vm_area_struct *vma,
+				 unsigned int size, void *ptr)
+{
+	unsigned long pfn;
+	int ret;
+
+	if (!IS_ALIGNED(__pa(ptr), PAGE_SIZE)) {
+		pr_err("Non-aligned physical memory\n");
+		return -EINVAL;
+	}
+
+	if ((vma->vm_end - vma->vm_start) > size) {
+		pr_err("Incorrect mmap size: request=0x%lx, expected=0x%x\n",
+		       (vma->vm_end - vma->vm_start), size);
+		return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND
+		| VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP;
+
+	//vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	//pfn = PFN_DOWN(__pa(ptr));
+	pfn = virt_to_phys(ptr)>>PAGE_SHIFT;
+
+	/* mapping pages to user process */
+	ret = remap_pfn_range(vma, vma->vm_start, pfn, size, vma->vm_page_prot);
+
+	return ret;
+}
+
+
+static int sdxi_ioctl_get_version(struct file *filep, struct sdxi_process *p,
+				  void *data)
+{
+	struct sdxi_get_version_args *args = data;
+
+	args->major_version = SDXI_IOCTL_MAJOR_VER;
+	args->major_version = SDXI_IOCTL_MINOR_VER;
+
+	return 0;
+}
+
+static int sdxi_ioctl_get_dev_info(struct file *filep, struct sdxi_process *p,
+				   void *data)
+{
+	struct sdxi_get_dev_info_args *args = data;
+	struct list_head *curr;
+	struct sdxi_dev *sdxi;
+	u32 min_value;
+	bool first = true;
+
+	memset(args, 0, sizeof(*args));
+
+	if (list_empty(&sdxi_device_list))
+		return 0;
+
+	list_for_each(curr, &sdxi_device_list) {
+		sdxi = list_entry(curr, struct sdxi_dev, list);
+
+		if (!first) {
+			min_value = min_t(u32, sdxi->max_ring_entries,
+					  args->ctxt_max_ring_entries);
+			args->ctxt_max_ring_entries = min_value;
+
+			min_value = min_t(u32, sdxi->max_akeys,
+					  args->ctxt_max_akey_entries);
+			args->ctxt_max_akey_entries = min_value;
+
+			/* NB: handle dev_supported_op_grps */
+		} else {
+			args->ctxt_max_ring_entries = sdxi->max_ring_entries;
+			args->ctxt_max_akey_entries = sdxi->max_akeys;
+			args->dev_supported_op_grps = SDXI_DMA_OP_GROUP |
+				SDXI_ADMIN_OP_GROUP |
+				SDXI_ATOMIC_OP_GROUP |
+				SDXI_INTR_OP_GROUP;
+
+			first = false;
+		}
+	}
+
+	return 0;
+}
+
+static int sdxi_ioctl_create_ctxt(struct file *filep, struct sdxi_process *p,
+				  void *data)
+{
+	struct sdxi_create_ctxt_args *args = data;
+	struct sdxi_ctxt *ctxt;
+	int err = 0;
+
+	/* We actually skip the configuration from user. Need to be used */
+	ctxt = sdxi_working_ctxt_alloc();
+	if (IS_ERR(ctxt))
+		return -EINVAL;
+
+	mutex_lock(&p->mutex);
+
+	p->ctxt = ctxt;
+	err = sdxi_bind_process_to_device(p);
+	if (err) {
+		err = -ESRCH;
+		goto err_bind_process;
+	}
+
+	/* return values to caller */
+	args->pasid = p->pasid;
+	args->ctxt_id = p->ctxt->id;
+	args->ctxt_status_mmap_base = SDXI_MMAP_TYPE_CTXT_STATUS;
+	args->desc_ring_mmap_base = SDXI_MMAP_TYPE_DESC_RING;
+	args->write_index_mmap_base = SDXI_MMAP_TYPE_WRITE_INDEX;
+	args->doorbell_mmap_base = SDXI_MMAP_TYPE_DOORBELL;
+
+	/* setup akey */
+	ctxt->akey[1].vl = 1;
+	ctxt->akey[1].pv = 1;
+	ctxt->akey[1].pasid = p->pasid;
+
+	mutex_unlock(&p->mutex);
+
+	pr_debug("Context id %d was created successfully\n", args->ctxt_id);
+	return 0;
+
+err_bind_process:
+	mutex_unlock(&p->mutex);
+	return err;
+}
+
+static int sdxi_ioctl_close_ctxt(struct file *filep, struct sdxi_process *p,
+				 void *data)
+{
+	struct sdxi_close_ctxt_args *args = data;
+
+	mutex_lock(&p->mutex);
+
+	if (args->ctxt_id == p->ctxt->id) {
+		sdxi_unbind_process_to_device(p);
+		//sdxi_working_ctxt_exit(p->ctxt);
+	}
+
+	mutex_unlock(&p->mutex);
+
+	return 0;
+}
+
+/******************/
+/* FOPS FUNCTIONS */
+/******************/
+static int sdxi_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct sdxi_process *process;
+	unsigned long offset;
+	unsigned int size;
+	struct sdxi_sq *sq;
+
+	process = sdxi_get_process(current);
+	if (IS_ERR(process))
+		return PTR_ERR(process);
+
+	if (!process->ctxt)
+		return -EINVAL;
+
+	sq = process->ctxt->sq;
+	if (!sq)
+		return -EINVAL;
+
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	switch (offset & SDXI_MMAP_TYPE_MASK) {
+	case SDXI_MMAP_TYPE_DOORBELL:
+		return sdxi_ctxt_doorbell_mmap(process, vma);
+	case SDXI_MMAP_TYPE_CTXT_STATUS:
+		size = sq->ctxt_status_size;
+		return sdxi_ctxt_struct_mmap(process, vma, size, sq->ctxt_status);
+	case SDXI_MMAP_TYPE_WRITE_INDEX:
+		size = sq->write_index_size;
+		return sdxi_ctxt_struct_mmap(process, vma, size, sq->write_index);
+	case SDXI_MMAP_TYPE_DESC_RING:
+		size = sq->ring_size;
+		return sdxi_ctxt_struct_mmap(process, vma, size, sq->desc_ring);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+#define SDXI_IOCTL_DEF(ioctl, _func, _flags)				\
+	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
+			    .cmd_drv = 0, .name = #ioctl}
+
+static struct sdxi_ioctl_desc sdxi_ioctls[] = {
+	SDXI_IOCTL_DEF(SDXI_GET_VERSION,
+			sdxi_ioctl_get_version, 0),
+
+	SDXI_IOCTL_DEF(SDXI_GET_DEV_INFO,
+		      sdxi_ioctl_get_dev_info, 0),
+
+	SDXI_IOCTL_DEF(SDXI_CREATE_CTXT,
+		      sdxi_ioctl_create_ctxt, 0),
+
+	SDXI_IOCTL_DEF(SDXI_CLOSE_CTXT,
+		      sdxi_ioctl_close_ctxt, 0),
+};
+#define SDXI_IOCTL_COUNT ARRAY_SIZE(sdxi_ioctls)
+
+static long sdxi_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct sdxi_process *process;
+	sdxi_ioctl_t *func;
+	const struct sdxi_ioctl_desc *ioctl = NULL;
+	unsigned int nr = _IOC_NR(cmd);
+	char stack_kdata[128];
+	char *kdata = NULL;
+	unsigned int usize, asize;
+	u32 sdxi_size;
+	int retcode = -EINVAL;
+
+	if (nr >= SDXI_IOCTL_COUNT)
+		goto err_out;
+
+	ioctl = &sdxi_ioctls[nr];
+	sdxi_size = _IOC_SIZE(ioctl->cmd);
+	usize = asize = _IOC_SIZE(cmd);
+	if (sdxi_size > asize)
+		asize = sdxi_size;
+
+	cmd = ioctl->cmd;
+
+	dev_dbg(sdxi_device, "ioctl cmd 0x%x (#0x%x), arg 0x%lx\n", cmd, nr,
+		arg);
+
+	process = filep->private_data;
+	if (process->lead_thread != current->group_leader) {
+		dev_dbg(sdxi_device, "using SDXI IOCTL in wrong process\n");
+		retcode = -EBADF;
+		goto err_out;
+	}
+
+	func = ioctl->func;
+	if (unlikely(!func)) {
+		dev_dbg(sdxi_device, "no IOCTL function found\n");
+		retcode = -EINVAL;
+		goto err_out;
+	}
+
+	if (cmd & (IOC_IN | IOC_OUT)) {
+		if (asize <= sizeof(stack_kdata)) {
+			kdata = stack_kdata;
+		} else {
+			kdata = kmalloc(asize, GFP_KERNEL);
+			if (!kdata) {
+				retcode = -ENOMEM;
+				goto err_out;
+			}
+		}
+		if (asize > usize)
+			memset(kdata + usize, 0, asize - usize);
+	}
+
+	if (cmd & IOC_IN) {
+		if (copy_from_user(kdata, (void __user *)arg, usize) != 0) {
+			retcode = -EFAULT;
+			goto err_out;
+		}
+	} else if (cmd & IOC_OUT) {
+		memset(kdata, 0, usize);
+	}
+
+	retcode = func(filep, process, kdata);
+
+	if (cmd & IOC_OUT)
+		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
+			retcode = -EFAULT;
+
+err_out:
+	if (!ioctl)
+		dev_dbg(sdxi_device, "invalid ioctl: pid=%d, cmd=0x%02x, nr=0x%02x\n",
+			task_pid_nr(current), cmd, nr);
+
+	if (kdata != stack_kdata)
+		kfree(kdata);
+
+	if (retcode)
+		dev_dbg(sdxi_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
+			nr, arg, retcode);
+
+	return retcode;
+}
+
+static int sdxi_open(struct inode *inode, struct file *filep)
+{
+	struct sdxi_process *process;
+
+	if (iminor(inode) != 0)
+		return -ENODEV;
+
+	/* just create sdxi_process, but no context assigned yet */
+	process = sdxi_create_process(filep);
+	if (IS_ERR(process))
+		return PTR_ERR(process);
+
+	filep->private_data = process;
+
+	dev_dbg(sdxi_device, "process %d opened\n", process->pasid);
+
+	return 0;
+}
+
+static int sdxi_release(struct inode *inode, struct file *filep)
+{
+	struct sdxi_process *process = filep->private_data;
+
+	if (process) {
+		/* NB: check leftover work with sdxi_unref_process(process) */
+		sdxi_destroy_process(process);
+	}
+
+	return 0;
+}
+
+/*********************/
+/* CHARDEV INIT CODE */
+/*********************/
+static const struct file_operations sdxi_fops = {
+	.owner = THIS_MODULE,
+	.mmap = sdxi_mmap,
+	.unlocked_ioctl = sdxi_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.open = sdxi_open,
+	.release = sdxi_release,
+};
+
+int sdxi_chardev_init(void)
+{
+	int err = 0;
+
+	sdxi_char_dev_major = register_chrdev(0, sdxi_dev_name, &sdxi_fops);
+	err = sdxi_char_dev_major;
+	if (err < 0)
+		goto err_register_chrdev;
+
+	sdxi_class = class_create(THIS_MODULE, sdxi_dev_name);
+	err = PTR_ERR(sdxi_class);
+	if (IS_ERR(sdxi_class))
+		goto err_class_create;
+
+	sdxi_device = device_create(sdxi_class, NULL,
+				    MKDEV(sdxi_char_dev_major, 0),
+				    NULL, sdxi_dev_name);
+	err = PTR_ERR(sdxi_device);
+	if (IS_ERR(sdxi_device))
+		goto err_device_create;
+
+	return 0;
+
+err_device_create:
+	class_destroy(sdxi_class);
+err_class_create:
+	unregister_chrdev(sdxi_char_dev_major, sdxi_dev_name);
+err_register_chrdev:
+	return err;
+}
+
+void sdxi_chardev_exit(void)
+{
+	device_destroy(sdxi_class, MKDEV(sdxi_char_dev_major, 0));
+	class_destroy(sdxi_class);
+	unregister_chrdev(sdxi_char_dev_major, sdxi_dev_name);
+	sdxi_device = NULL;
+}
diff --git a/drivers/dma/sdxi/ioctl.h b/drivers/dma/sdxi/ioctl.h
new file mode 100644
index 000000000000..dedafec37673
--- /dev/null
+++ b/drivers/dma/sdxi/ioctl.h
@@ -0,0 +1,49 @@
+/*
+ * IOCTL related header
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ *
+ */
+
+#ifndef __SDXI_IOCTL_H
+#define __SDXI_IOCTL_H
+
+#include <linux/mmu_notifier.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/workqueue.h>
+
+#include "sdxi.h"
+#include "process.h"
+
+#define SDXI_IOCTL_MAJOR_VER 0
+#define SDXI_IOCTL_MINOR_VER 2
+
+typedef int sdxi_ioctl_t(struct file *filep, struct sdxi_process *p, void *data);
+
+struct sdxi_ioctl_desc {
+	unsigned int cmd;
+	int flags;
+	sdxi_ioctl_t *func;
+	unsigned int cmd_drv;
+	const char *name;
+};
+
+/* Use upper bits of mmap offset to access context specific information.
+ * BITS[42:40] - Encode MMAP types
+ *     01 : Descriptor ring
+ *     02 : Write index
+ *     03 : Context status
+ *     04 : Doorbell
+ */
+#define SDXI_MMAP_TYPE_SHIFT         40
+#define SDXI_MMAP_TYPE_DESC_RING     (0x1ULL << SDXI_MMAP_TYPE_SHIFT)
+#define SDXI_MMAP_TYPE_WRITE_INDEX   (0x2ULL << SDXI_MMAP_TYPE_SHIFT)
+#define SDXI_MMAP_TYPE_CTXT_STATUS   (0x3ULL << SDXI_MMAP_TYPE_SHIFT)
+#define SDXI_MMAP_TYPE_DOORBELL      (0x4ULL << SDXI_MMAP_TYPE_SHIFT)
+#define SDXI_MMAP_TYPE_MASK          (0x7ULL << SDXI_MMAP_TYPE_SHIFT)
+
+#endif /* __SDXI_IOCTL_H */
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
new file mode 100644
index 000000000000..db0ba908e4ea
--- /dev/null
+++ b/drivers/dma/sdxi/pci.c
@@ -0,0 +1,533 @@
+/*
+ * SDXI PCI device code
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+#include <linux/io.h>
+#include <linux/iomap.h>
+
+#include "sdxi.h"
+#include "pci.h"
+#include "process.h"
+
+LIST_HEAD(sdxi_device_list);
+
+u64 reg_read64(void __iomem *addr)
+{
+        u64 low, high;
+
+        low = ioread32(addr);
+        high = ioread32(addr + sizeof(u32));
+
+        return low | (high << 32);
+}
+
+void reg_write64(void __iomem *addr, u64 value)
+{
+        u32 low, high;
+
+        high = value >> 32;
+        low = value & 0xFFFFFFFF;
+
+        iowrite32(low, addr);
+        iowrite32(high, addr + sizeof(u32));
+}
+
+/* NB: Just print out for now. Need to expand to handle the errors */
+static void sdxi_print_err(struct sdxi_dev *sdxi, struct sdxi_err *err)
+{
+	struct device *dev = &sdxi->pdev->dev;
+
+	dev_err(dev, "error found\n");
+}
+
+static void sdxi_handle_err(struct sdxi_dev *sdxi)
+{
+	u64 read_ptr, write_ptr, offset;
+	struct sdxi_err *err_entry;
+
+	read_ptr = reg_read64(sdxi->ctrl_regs + ERR_LOG_READ_PTR_OFFSET);
+	write_ptr = reg_read64(sdxi->ctrl_regs + ERR_LOG_WRITE_PTR_OFFSET);
+
+	while (read_ptr != write_ptr) {
+		offset = (read_ptr * 64) % ((sdxi->err_log_num + 1) * 4096);
+		err_entry = (struct sdxi_err *)sdxi->err_log + offset;
+
+		sdxi_print_err(sdxi, err_entry);
+		read_ptr++;
+	}
+
+	reg_write64(sdxi->ctrl_regs + ERR_LOG_READ_PTR_OFFSET, read_ptr);
+	reg_write64(sdxi->ctrl_regs + ERR_LOG_STS_OFFSET, 0xB);
+}
+
+/*
+static void sdxi_do_cmd_complete(unsigned long data)
+{
+	struct sdxi_tasklet_data *tdata = (void *)data;
+	struct sdxi_cmd *cmd = tdata->cmd;
+
+	if (cmd->sdxi_cmd_callback)
+		cmd->sdxi_cmd_callback(cmd->data, cmd->ret);
+}
+*/
+
+static irqreturn_t sdxi_irq_thread(int irq, void *data)
+{
+	struct sdxi_dev *sdxi = (struct sdxi_dev *)data;
+	u64 status = reg_read64(sdxi->ctrl_regs + ERR_LOG_STS_OFFSET);
+
+	while (status & ERR_LOG_STATUS_MASK) {
+		printk(KERN_ERR "read status\n");
+		sdxi_handle_err(sdxi);
+		status = reg_read64(sdxi->ctrl_regs + ERR_LOG_STS_OFFSET);
+	}
+
+	/* sdxi_do_cmd_complete((ulong)&sdxi->tdata); */
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sdxi_irq_handler(int irq, void *data)
+{
+	return IRQ_WAKE_THREAD;
+}
+
+static int sdxi_pci_irq_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+	struct device *dev = &pdev->dev;
+	int msi_count;
+	int ret;
+
+	/* 1st irq for error + 1 for each context */
+	msi_count = sdxi->max_cxts + 1;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, msi_count,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_info(dev, "alloc MSI/MSI-X vectors failed\n");
+		return ret;
+	}
+
+	sdxi->irq_count = ret;
+	sdxi->err_irq.vector = pci_irq_vector(pdev, 0);
+	/* setup err log interrupt handler */
+	ret = request_threaded_irq(sdxi->err_irq.vector,
+				   sdxi_irq_handler, sdxi_irq_thread, 0,
+				   SDXI_DRV_NAME, &sdxi->err_irq);
+	if (ret) {
+		dev_err(dev, "cannot alloc irq handler for error irq\n");
+		goto err_irq0_alloc;
+	}
+
+	/* NB: alloc and setup ctxt_irqs here */
+	return 0;
+
+err_irq0_alloc:
+	pci_free_irq_vectors(pdev);
+	return ret;
+}
+
+static void sdxi_pci_irq_exit(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+
+	free_irq(sdxi->err_irq.vector, &sdxi->err_irq);
+	/* NB: free context IRQs */
+
+	pci_free_irq_vectors(pdev);
+}
+
+static void sdxi_pci_parse_cap(struct sdxi_dev *sdxi)
+{
+	u64 cap0, cap1;
+	u32 db_stride, max_ring_sz, max_rkey_sz;
+	u32 max_buff_sz, max_errlog_sz, max_akey_sz;
+
+	/* generic properties */
+	sdxi->max_pasids = pci_max_pasids(sdxi->pdev);
+
+	/* CAP0 */
+	cap0 = reg_read64(sdxi->ctrl_regs + MMIO_CAP0_OFFSET);
+	cap1 = reg_read64(sdxi->ctrl_regs + MMIO_CAP1_OFFSET);
+
+	sdxi->sfunc = cap0 & CAP0_SFUNC_MASK;
+	sdxi->is_vf = (cap0 >> CAP0_VF_SHIFT) & CAP0_VF_MASK;
+
+	db_stride = (cap0 >> CAP0_DB_STRIDE_SHIFT) & CAP0_DB_STRIDE_MASK;
+	sdxi->db_stride = 1 << (db_stride + 12);
+
+	max_ring_sz = (cap0 >> CAP0_MAX_RING_SZ_SHIFT) & CAP0_MAX_RING_SZ_MASK;
+	sdxi->max_ring_entries = 1ULL << (max_ring_sz + 10);
+
+	max_rkey_sz = (cap0 >> CAP0_MAX_RKEY_SZ_SHIFT) & CAP0_MAX_RKEY_SZ_MASK;
+	sdxi->max_rkeys = 1 << (max_rkey_sz + 8);
+
+	/* CAP1 */
+	max_buff_sz = cap1 & CAP1_MAX_BUFF_MASK;
+	sdxi->max_buffer = 2 << (max_buff_sz + 21);
+
+	sdxi->has_rkey = (cap1 >> CAP1_RKEY_SUP_SHIFT) & CAP1_RKEY_SUP_MASK;
+
+	max_errlog_sz = (cap1 >> CAP1_MAX_ERR_LOG_SZ_SHIFT) & CAP1_MAX_ERR_LOG_SZ_MASK;
+	sdxi->max_err_logs = 2 << (max_errlog_sz + 7);
+
+	max_akey_sz = (cap1 >> CAP1_MAX_AKT_SIZE_SHIFT) & CAP1_MAX_AKT_SIZE_MASK;
+	sdxi->max_akeys = 1 << (max_akey_sz + 8);
+
+	sdxi->max_cxts = ((cap1 >> CAP1_N_CXT_SHIFT) & CAP1_N_CXT_MASK) + 1;
+
+	sdxi->op_grp_cap = (cap1 >> CAP1_OP_GRP_CAP_SHIFT) & CAP1_OP_GRP_CAP_MASK;
+
+	pr_info("SDXI function [sfunc=0x%04x, vf=%d]:\n", sdxi->sfunc, sdxi->is_vf);
+	pr_info("  max contexts:     %d\n", sdxi->max_cxts);
+	pr_info("  max ring entries: 0x%llx\n", sdxi->max_ring_entries);
+	pr_info("  max rkeys/akeys:  %d/%d\n", sdxi->max_rkeys, sdxi->max_akeys);
+	pr_info("  op group cap:     0x%04x\n", sdxi->op_grp_cap);
+	pr_info("  err log size:     %d\n", sdxi->max_err_logs);
+}
+
+static int sdxi_pci_map(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+	struct device *dev = &pdev->dev;
+	int bars, ret;
+
+	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	ret = pcim_iomap_regions(pdev, bars, SDXI_DRV_NAME);
+	if (ret) {
+		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
+		return ret;
+	}
+
+	sdxi->dbs_bar = pci_resource_start(pdev, MMIO_DOORBELL_BAR);
+
+	sdxi->ctrl_regs = pcim_iomap_table(pdev)[MMIO_CTRL_REGS_BAR];
+	sdxi->dbs = pcim_iomap_table(pdev)[MMIO_DOORBELL_BAR];
+	if (!sdxi->ctrl_regs || !sdxi->dbs) {
+		dev_err(dev, "pcim_iomap_table failed\n");
+		pcim_iounmap_regions(pdev, bars);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void sdxi_pci_unmap(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+
+	pcim_iounmap(pdev, sdxi->ctrl_regs);
+	pcim_iounmap(pdev, sdxi->dbs);
+}
+
+static int sdxi_pci_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+	struct device *dev = &pdev->dev;
+	int dma_bits = 64;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "pcim_enbale_device failed\n");
+		return ret;
+	}
+
+	pci_set_master(pdev);
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));
+	if (ret) {
+		dev_err(dev, "failed to set DMA mask & coherent bits\n");
+		return ret;
+	}
+
+	ret = sdxi_pci_map(sdxi);
+	if (ret) {
+		dev_err(dev, "failed to map device IO resources\n");
+		return ret;
+	}
+
+	ret = sdxi_pci_irq_init(sdxi);
+	if (ret) {
+		sdxi_pci_unmap(sdxi);
+		return ret;
+	}
+
+	sdxi_pci_parse_cap(sdxi);
+
+	return 0;
+}
+
+static void sdxi_pci_exit(struct sdxi_dev *sdxi)
+{
+	sdxi_pci_irq_exit(sdxi);
+	sdxi_pci_unmap(sdxi);
+}
+
+static int sdxi_pci_enable(struct sdxi_dev *sdxi)
+{
+	struct device *dev = &sdxi->pdev->dev;
+	dma_addr_t l2_addr, rkey_addr, err_log_addr;
+	u64 ctrl0, ctrl2, status;
+
+	/* l2 table */
+	l2_addr = dma_map_single(dev, sdxi->l2_table, L2_TABLE_SIZE,
+				 DMA_TO_DEVICE);
+	l2_addr &= CXT_TABLE_BASE_PTR_MASK;
+	reg_write64(sdxi->ctrl_regs + CXT_TABLE_BASE_OFFSET, l2_addr);
+
+	/* rkey */
+	rkey_addr = dma_map_single(dev, sdxi->rkey,
+				   sdxi->rkey_num * sizeof(struct rkey_ent),
+				   DMA_FROM_DEVICE);
+	rkey_addr &= ERR_LOG_BASE_PTR_MASK;
+	rkey_addr |= 0x1;
+	rkey_addr |= (((sdxi->rkey_num >> 8) & RKEY_TABLE_SIZE_MASK) <<
+		      RKEY_TABLE_SIZE_SHIFT);
+
+	/* err log */
+	reg_write64(sdxi->ctrl_regs + ERR_LOG_CTRL_OFFSET, 0x1);
+
+	err_log_addr = dma_map_single(dev, sdxi->err_log,
+				      sdxi->err_log_num * sizeof(struct sdxi_err),
+				      DMA_FROM_DEVICE);
+	err_log_addr &= ERR_LOG_BASE_PTR_MASK;
+	err_log_addr |= 0x1;
+	reg_write64(sdxi->ctrl_regs + ERR_LOG_CFG_OFFSET, err_log_addr);
+
+	/* enable device */
+	ctrl0 = reg_read64(sdxi->ctrl_regs + MMIO_CTRL0_OFFSET);
+	ctrl0 &= ~CTRL0_ENABLE_MASK;
+	ctrl0 |= FUNC_REQ_ACTIVE;
+	//enable err_intr
+	ctrl0 |= (1 << CTRL0_FUNC_ERR_INT_EN_SHIFT);
+	reg_write64(sdxi->ctrl_regs + MMIO_CTRL0_OFFSET, ctrl0);
+
+	ctrl2 = reg_read64(sdxi->ctrl_regs + MMIO_CTRL2_OFFSET);
+	ctrl2 &= 0xFFFFFFFF0000FFFFULL;
+	ctrl2 |= 0x0000000000020000ULL;
+	ctrl2 &= 0x00000000FFFFFFFFULL;
+	ctrl2 |= (uint64_t)sdxi->op_grp_cap << 32;
+	reg_write64(sdxi->ctrl_regs + MMIO_CTRL2_OFFSET, ctrl2);
+
+	status = reg_read64(sdxi->ctrl_regs + MMIO_STATUS_0_OFFSET);
+	pr_info("  err log addr: v=0x%p:d=0x%llx\n"
+		"  rkey addr:    v=0x%p:d=0x%llx\n"
+		"  func status:  0x%lx"
+		"  ctrl2:        0x%llx",
+		sdxi->err_log, err_log_addr & ~0x1, sdxi->rkey, rkey_addr,
+		(unsigned long)status, (unsigned long long)ctrl2);
+
+	return 0;
+}
+
+static void sdxi_dump_errlog(struct sdxi_dev *sdxi)
+{
+	u64 err_ctl, err_sts, err_cfg, err_wrt, err_rd;
+
+	err_ctl = reg_read64(sdxi->ctrl_regs + ERR_LOG_CTRL_OFFSET);
+	err_sts = reg_read64(sdxi->ctrl_regs + ERR_LOG_STS_OFFSET);
+	err_cfg = reg_read64(sdxi->ctrl_regs + ERR_LOG_CFG_OFFSET);
+	err_wrt = reg_read64(sdxi->ctrl_regs + ERR_LOG_WRITE_PTR_OFFSET);
+	err_rd = reg_read64(sdxi->ctrl_regs + ERR_LOG_READ_PTR_OFFSET);
+}
+
+static void sdxi_pci_disable(struct sdxi_dev *sdxi)
+{
+	u64 ctrl0, status;
+
+	sdxi_dump_errlog(sdxi);
+	/* disable device */
+	ctrl0 = reg_read64(sdxi->ctrl_regs + MMIO_CTRL0_OFFSET);
+	ctrl0 &= ~CTRL0_ENABLE_MASK;
+	ctrl0 |= FUNC_REQ_SOFT_STOP;
+	reg_write64(sdxi->ctrl_regs + MMIO_CTRL0_OFFSET, ctrl0);
+
+	status = reg_read64(sdxi->ctrl_regs + MMIO_STATUS_0_OFFSET);
+	if (status != STATUS_STOPPED && status != STATUS_STP_ON_ERR)
+		pr_err("final function status: 0x%lx\n", (unsigned long)status);
+}
+
+static struct sdxi_dev *sdxi_device_alloc(struct device *dev)
+{
+	struct sdxi_dev *sdxi;
+	gfp_t gfp_flags;
+	unsigned long order;
+	int entries;
+
+	sdxi = kzalloc(sizeof(*sdxi), GFP_KERNEL);
+	if (!sdxi)
+		return NULL;
+
+	gfp_flags = GFP_KERNEL | __GFP_ZERO;
+	order = get_order(L2_TABLE_SIZE);
+	sdxi->l2_table = (void *)__get_free_pages(gfp_flags, order);
+	if (!sdxi->l2_table)
+		goto l2_fail;
+
+	/* rkey */
+	entries = DEFAULT_RKEY_NUM;
+	sdxi->rkey = kzalloc(entries * sizeof(struct rkey_ent), GFP_KERNEL);
+	if (!sdxi->rkey)
+		goto rkey_fail;
+	sdxi->rkey_num = entries;
+
+	/* error log */
+	entries = DEFAULT_ERR_LOG_NUM;
+	sdxi->err_log = kzalloc(entries * sizeof(struct sdxi_err), GFP_KERNEL);
+	if (!sdxi->err_log)
+		goto err_log_fail;
+	sdxi->err_log_num = entries;
+
+	spin_lock_init(&sdxi->ctxt_lock);
+	INIT_LIST_HEAD(&sdxi->ctxt_list);
+	list_add_tail(&sdxi->list, &sdxi_device_list);
+
+	return sdxi;
+
+err_log_fail:
+	kfree(sdxi->rkey);
+rkey_fail:
+	free_pages((unsigned long)sdxi->l2_table, order);
+l2_fail:
+	kfree(sdxi);
+	return NULL;
+}
+
+static void sdxi_device_free(struct sdxi_dev *sdxi)
+{
+	list_del(&sdxi->list);
+	kfree(sdxi->err_log);
+	kfree(sdxi->rkey);
+	free_pages((unsigned long)sdxi->l2_table, get_order(L2_TABLE_SIZE));
+	kfree(sdxi);
+}
+
+static int sdxi_pci_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct sdxi_dev *sdxi;
+	int ret;
+
+	sdxi = sdxi_device_alloc(dev);
+	if (!sdxi) {
+		dev_err(dev, "failed to allocate sdxi device\n");
+		return -ENOMEM;
+	}
+
+	sdxi->pdev = pdev;
+	pci_set_drvdata(pdev, sdxi);
+
+	ret = sdxi_pci_init(sdxi);
+	if (ret)
+		goto err_pci_init;
+
+	ret = sdxi_device_init(sdxi);
+	if (ret)
+		goto err_dev_init;
+
+	ret = sdxi_iommu_device_init(sdxi);
+	if (ret)
+		goto err_iommu_init;
+
+	ret = sdxi_pci_enable(sdxi);
+	if (ret)
+		goto err_pci_enable;
+
+	return 0;
+
+err_pci_enable:
+	sdxi_iommu_device_exit(sdxi);
+err_iommu_init:
+	sdxi_device_exit(sdxi);
+err_dev_init:
+	sdxi_pci_exit(sdxi);
+err_pci_init:
+	sdxi_device_free(sdxi);
+	return ret;
+}
+
+static void sdxi_pci_remove(struct pci_dev *pdev)
+{
+	struct sdxi_dev *sdxi = pci_get_drvdata(pdev);
+
+	sdxi_pci_disable(sdxi);
+	sdxi_iommu_device_exit(sdxi);
+	sdxi_device_exit(sdxi);
+	sdxi_pci_exit(sdxi);
+	sdxi_device_free(sdxi);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdxi_pci_suspend(struct device *dev)
+{
+	/* place holder, need to expand */
+	sdxi_iommu_suspend(NULL);
+
+	return 0;
+}
+
+static int sdxi_pci_resume(struct device *dev)
+{
+	/* place holder, need to expand */
+	sdxi_iommu_resume(NULL);
+
+	return 0;
+}
+
+static const struct dev_pm_ops sdxi_pci_pm_ops = {
+	.suspend	= sdxi_pci_suspend,
+	.resume		= sdxi_pci_resume,
+};
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct pci_device_id sdxi_id_table[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCEL_SDXI, 0xffffff) },
+	{0, }
+};
+MODULE_DEVICE_TABLE(pci, sdxi_id_table);
+
+static struct pci_driver sdxi_driver = {
+	.name = "sdxi",
+	.id_table = sdxi_id_table,
+	.probe = sdxi_pci_probe,
+	.remove = sdxi_pci_remove,
+	.driver = {
+		.pm = &sdxi_pci_pm_ops,
+	},
+};
+
+static int __init sdxi_module_init(void)
+{
+	int rc = 0;
+
+	rc = pci_register_driver(&sdxi_driver);
+	if (rc)
+		return rc;
+
+	rc = sdxi_chardev_init();
+
+	return rc;
+}
+
+static void __exit sdxi_module_exit(void)
+{
+	sdxi_chardev_exit();
+	pci_unregister_driver(&sdxi_driver);
+}
+
+MODULE_AUTHOR("Wei Huang <wei.huang2@amd.com>");
+MODULE_DESCRIPTION(SDXI_DRV_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+module_init(sdxi_module_init);
+module_exit(sdxi_module_exit);
+MODULE_SOFTDEP("pre: iommu_v2");
diff --git a/drivers/dma/sdxi/pci.h b/drivers/dma/sdxi/pci.h
new file mode 100644
index 000000000000..7343561ec1d5
--- /dev/null
+++ b/drivers/dma/sdxi/pci.h
@@ -0,0 +1,130 @@
+/*
+ * SDXI MMIO registers
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ *
+ */
+
+#ifndef __SDXI_PCI_H
+#define __SDXI_PCI_H
+
+#include <linux/io.h>
+
+/* MMIO BARs */
+#define MMIO_CTRL_REGS_BAR		0x0
+#define MMIO_DOORBELL_BAR		0x2
+
+/* MMIO register regions */
+#define MMIO_CTRL_STATUS_OFFSET		0x000000
+#define MMIO_CXT_TABLE_OFFSET		0x010000
+#define MMIO_ERR_LOG_CTRL_OFFSET	0x020000
+#define MMIO_MAILBOX_CTRL_OFFSET	0x030000
+
+/* MMIO ctrl and status register offsets */
+#define MMIO_CTRL0_OFFSET		0x000000
+#define MMIO_CTRL1_OFFSET		0x000008
+#define MMIO_CTRL2_OFFSET		0x000010
+#define MMIO_STATUS_0_OFFSET		0x000100
+#define MMIO_CAP0_OFFSET		0x000200
+#define MMIO_CAP1_OFFSET		0x000208
+
+/* MMIO control register 0 */
+#define CTRL0_ENABLE_MASK		0x3
+#define CTRL0_FUNC_PASID_V_MASK		0x1
+#define CTRL0_FUNC_PASID_V_SHIFT	0x2
+#define CTRL0_FUNC_ERR_INT_EN_MASK	0x1
+#define CTRL0_FUNC_ERR_INT_EN_SHIFT	0x4
+#define CTRL0_FUNC_PASID_MASK		0xFFFFF
+#define CTRL0_FUNC_PASID_SHIFT		0x8
+
+/* MMIO control register 1 */
+#define CTRL1_ALL_CXT_DB_MASK		0x1
+
+/* MMIO control register 2 */
+#define CTRL2_MAX_BUFF_CNTL_MASK	0xF
+#define CTRL2_MULTI_FUNC_EN_MASK	0x1
+#define CTRL2_MULTI_FUNC_EN_SHIFT	0x4
+#define CTRL2_MAX_AKT_SIZE_CNTL_MASK	0xF
+#define CTRL2_MAX_AKT_SIZE_CNTL_SHIFT	0x12
+#define CTRL2_N_CXT_CNTL_MASK		0xFFFF
+#define CTRL2_N_CXT_CNTL_SHIFT		0x10
+#define CTRL2_CMD_GRP0_EN_MASK		0xFFFFFFFF
+#define CTRL2_CMD_GRP0_EN_SHIFT		0x20
+
+/* MMIO status register 0 (offset: 0x00100) */
+#define STATUS0_GLOBAL_STATE_MASK	0x7
+
+/* status register 0 constants */
+#define STATUS_STOPPED			0x0
+#define STATUS_INIT			0x1
+#define STATUS_ACTIVE			0x2
+#define STATUS_SOFT_STP_REQ		0x3
+#define STATUS_HARD_STP_REQ		0x4
+#define STATUS_STP_ON_ERR		0x5
+
+/* MMIO capability register 0 */
+#define CAP0_SFUNC_MASK			0xFFFF
+#define CAP0_VF_SHIFT			16
+#define CAP0_VF_MASK			0x1
+#define CAP0_DB_STRIDE_SHIFT		20
+#define CAP0_DB_STRIDE_MASK		0x7
+#define CAP0_MAX_RING_SZ_SHIFT		24
+#define CAP0_MAX_RING_SZ_MASK		0x1F
+#define CAP0_MAX_RKEY_SZ_SHIFT		32
+#define CAP0_MAX_RKEY_SZ_MASK		0xF
+
+/* MMIO capability register 1 */
+#define CAP1_MAX_BUFF_MASK		0xF
+#define CAP1_RKEY_SUP_SHIFT		4
+#define CAP1_RKEY_SUP_MASK		0x1
+#define CAP1_RM_SHIFT			5
+#define CAP1_RM_MASK			0x1
+#define CAP1_MMIO64_SHIFT		6
+#define CAP1_MMIO64_MASK		0x1
+#define CAP1_MAX_ERR_LOG_SZ_SHIFT	8
+#define CAP1_MAX_ERR_LOG_SZ_MASK	0xF
+#define CAP1_MAX_AKT_SIZE_SHIFT		12
+#define CAP1_MAX_AKT_SIZE_MASK		0xF
+#define CAP1_N_CXT_SHIFT		16
+#define CAP1_N_CXT_MASK			0xFFFF
+#define CAP1_OP_GRP_CAP_SHIFT		32
+#define CAP1_OP_GRP_CAP_MASK		0xFFFFFFFF
+
+/* MMIO context and rkey table registers */
+#define CXT_TABLE_BASE_OFFSET		0x10000
+#define CXT_TABLE_BASE_PTR_MASK		0xFFFFFFFFFFFFF000
+
+#define RKEY_TABLE_BASE_OFFSET		0x10100
+#define RKEY_TABLE_EN_MASK		0x1
+#define RKEY_TABLE_SIZE_SHIFT		0x1
+#define RKEY_TABLE_SIZE_MASK		0xF
+#define RKEY_TABLE_BASE_PTR_SHIFT	0x1
+#define RKEY_TABLE_BASE_PTR_MASK	0xFFFFFFFFFFFFF000
+
+/* MMIO Error log control and status */
+#define ERR_LOG_CTRL_OFFSET		0x20000
+#define ERR_LOG_STS_OFFSET		0x20008
+#define ERR_LOG_CFG_OFFSET		0x20010
+#define ERR_LOG_WRITE_PTR_OFFSET	0x20020
+#define ERR_LOG_READ_PTR_OFFSET		0x20028
+#define ERR_LOG_BASE_PTR_MASK		0xFFFFFFFFFFFFF000
+#define ERR_LOG_STATUS_MASK		0x1
+
+#define FUNC_STATE_STOPPED	0x0
+#define FUNC_STATE_INIT		0x1
+#define FUNC_STATE_ACTIVE	0x2
+#define FUNC_STATE_SOFT_STOP	0x3
+#define FUNC_STATE_HARD_STOP	0x4
+#define FUNC_STATE_ERR_STOPPED	0x5
+
+#define FUNC_REQ_RESET		0x0
+#define FUNC_REQ_SOFT_STOP	0x1
+#define FUNC_REQ_HARD_STOP	0x2
+#define FUNC_REQ_ACTIVE		0x3
+
+u64 reg_read64(void __iomem *addr);
+void reg_write64(void __iomem *addr, u64 val);
+
+#endif /* __SDXI_PCI_H */
diff --git a/drivers/dma/sdxi/process.c b/drivers/dma/sdxi/process.c
new file mode 100644
index 000000000000..e75c9af0a336
--- /dev/null
+++ b/drivers/dma/sdxi/process.c
@@ -0,0 +1,285 @@
+/*
+ * User space process management (IOMMU, PASID, etc.)
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/idr.h>
+#include <linux/dma-fence-array.h>
+#include <linux/amd-iommu.h>
+#include <linux/hashtable.h>
+#include <asm/mmu.h>
+
+#include "process.h"
+
+#define SDXI_PROCESS_LIST_SIZE	16
+static DEFINE_MUTEX(process_list_mutex);
+static DEFINE_HASHTABLE(process_list, SDXI_PROCESS_LIST_SIZE);
+static DEFINE_SRCU(process_list_srcu);
+
+/**********************/
+/* PROCESS MANAGEMENT */
+/**********************/
+static struct sdxi_process *find_process_by_mm(const struct mm_struct *mm)
+{
+	struct sdxi_process *process;
+
+	hash_for_each_possible_rcu(process_list, process, list,
+				   (uintptr_t)mm) {
+		if (process->mm == mm)
+			return process;
+	}
+
+	return NULL;
+}
+
+static struct sdxi_process *find_process(const struct task_struct *thread)
+{
+	struct sdxi_process *p;
+	int idx;
+
+	idx = srcu_read_lock(&process_list_srcu);
+	p = find_process_by_mm(thread->mm);
+	srcu_read_unlock(&process_list_srcu, idx);
+
+	return p;
+}
+
+/****************************/
+/* PROCESS PASID MANAGEMENT */
+/****************************/
+static u32 pasid_alloc(struct sdxi_dev *sdxi)
+{
+	u32 ret = 0;
+
+	ret = ida_simple_get(&sdxi->pasid_ida, 1, sdxi->pasid_limit,
+			     GFP_KERNEL);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void pasid_free(struct sdxi_dev *sdxi, u32 pasid)
+{
+	if (pasid)
+		ida_simple_remove(&sdxi->pasid_ida, pasid);
+}
+
+void sdxi_unref_process(struct sdxi_process *p)
+{
+	/* NB: more checking to be done here based on kref count */
+}
+
+struct sdxi_process *sdxi_get_process(struct task_struct *thread)
+{
+	struct sdxi_process *process;
+
+	if (!thread->mm)
+		return ERR_PTR(-EINVAL);
+
+	process = find_process(thread);
+	if (!process)
+		return ERR_PTR(-EINVAL);
+
+	return process;
+}
+
+int sdxi_bind_process_to_device(struct sdxi_process *process)
+{
+	struct sdxi_ctxt *ctxt = process->ctxt;
+	struct sdxi_dev *sdxi;
+	int err;
+
+	if (!ctxt)
+		return -EINVAL;
+
+	sdxi = ctxt->sdxi;
+	/* alloc pasid */
+	process->pasid = pasid_alloc(sdxi);
+	if (process->pasid == 0)
+		return -EBUSY;
+
+	/* NB: more code to be added such as power management */
+	err = amd_iommu_bind_pasid(sdxi->pdev, process->pasid,
+				   process->lead_thread);
+
+	if (err) {
+		pasid_free(sdxi, process->pasid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void sdxi_unbind_process_to_device(struct sdxi_process *process)
+{
+	struct sdxi_ctxt *ctxt = process->ctxt;
+
+	if (!ctxt)
+		return;
+	amd_iommu_unbind_pasid(ctxt->sdxi->pdev, process->pasid);
+	pasid_free(ctxt->sdxi, process->pasid);
+}
+
+struct sdxi_process *sdxi_create_process(struct file *filep)
+{
+	struct task_struct *thread = current;
+	struct sdxi_process *process;
+	int err = -ENOMEM;
+
+	mutex_lock(&process_list_mutex);
+
+	process = kzalloc(sizeof(*process), GFP_KERNEL);
+	if (!process)
+		return ERR_PTR(err);
+
+	mutex_init(&process->mutex);
+	process->mm = thread->mm;
+	process->lead_thread = thread->group_leader;
+	hash_add_rcu(process_list, &process->list, (uintptr_t)process->mm);
+	get_task_struct(process->lead_thread);
+	mutex_unlock(&process_list_mutex);
+
+	return process;
+}
+
+void sdxi_destroy_process(struct sdxi_process *process)
+{
+	if (!process)
+		return;
+
+	mutex_lock(&process_list_mutex);
+
+	put_task_struct(process->lead_thread);
+	hash_del_rcu(&process->list);
+	mutex_destroy(&process->mutex);
+	kfree(process);
+
+	mutex_unlock(&process_list_mutex);
+}
+
+/***************************/
+/* DEVICE IOMMU MANAGEMENT */
+/***************************/
+#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
+static const u32 required_flags = AMD_IOMMU_DEVICE_FLAG_ATS_SUP |
+				  AMD_IOMMU_DEVICE_FLAG_PRI_SUP |
+				  AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+
+static void iommu_pasid_shutdown_cb(struct pci_dev *pdev, u32 pasid)
+{
+	pr_info("PASID shutdown called: device=%s, pasid=%d\n",
+		dev_name(&pdev->dev), pasid);
+}
+
+static int iommu_invalid_ppr_cb(struct pci_dev *pdev, u32 pasid,
+				unsigned long address, u16 flags)
+{
+	pr_info("Invalid ppr called: device=%s, pasid=%d\n",
+		dev_name(&pdev->dev), pasid);
+	return AMD_IOMMU_INV_PRI_RSP_INVALID;
+}
+
+/* Bind all processes of SDXI from IOMMU */
+static int iommu_bind_processes(struct sdxi_dev *sdxi)
+{
+	return 0;
+}
+
+/* Unbind all processes of SDXI from IOMMU */
+static void iommu_unbind_processes(struct sdxi_dev *sdxi)
+{
+}
+
+int sdxi_iommu_device_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi->pdev;
+	struct amd_iommu_device_info info;
+	int err;
+
+	info.flags = 0;
+	err = amd_iommu_device_info(pdev, &info);
+	if (err < 0) {
+		pr_err("No IOMMU device info found\n");
+		return -ENODEV;
+	}
+
+	if ((info.flags & required_flags) != required_flags) {
+		pr_err_once("Require IOMMU flags ATS %i, PRI %i, PASID %i\n",
+			    (info.flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP) != 0,
+			    (info.flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) != 0,
+			    (info.flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP) != 0);
+
+		return -ENODEV;
+	}
+
+	sdxi->pasid_limit = min_t(u32, sdxi->max_pasids, info.max_pasids);
+	/* According to design, IOMMU v2 will be picked automatically if device
+	 * supports PRI/ATS/PASID. Since SDXI device current doesn't declare
+	 * PRI/ATS/PASID, we have to force pasid_limit to IOMMU max_pasids.
+	 */
+	//sdxi->pasid_limit = sdxi->max_pasids;
+	err = amd_iommu_init_device(pdev, sdxi->pasid_limit);
+	if (err < 0) {
+		pr_err("Failed to init IOMMU for %s\n", dev_name(&pdev->dev));
+		return -ENXIO;
+	}
+
+	ida_init(&sdxi->pasid_ida);
+	sdxi->use_iommu_v2 = true;
+
+	return 0;
+}
+
+void sdxi_iommu_device_exit(struct sdxi_dev *sdxi)
+{
+	iommu_unbind_processes(sdxi);
+	amd_iommu_free_device(sdxi->pdev);
+}
+
+void sdxi_iommu_suspend(struct sdxi_dev *sdxi)
+{
+	if (!sdxi || !sdxi->use_iommu_v2)
+		return;
+
+	iommu_unbind_processes(sdxi);
+
+	amd_iommu_set_invalidate_ctx_cb(sdxi->pdev, NULL);
+	amd_iommu_set_invalid_ppr_cb(sdxi->pdev, NULL);
+	amd_iommu_free_device(sdxi->pdev);
+}
+
+int sdxi_iommu_resume(struct sdxi_dev *sdxi)
+{
+	int err;
+
+	if (!sdxi || !sdxi->use_iommu_v2)
+		return 0;
+
+	err = amd_iommu_init_device(sdxi->pdev, sdxi->pasid_limit);
+	if (err)
+		return -ENXIO;
+
+	amd_iommu_set_invalidate_ctx_cb(sdxi->pdev,
+					iommu_pasid_shutdown_cb);
+	amd_iommu_set_invalid_ppr_cb(sdxi->pdev,
+				     iommu_invalid_ppr_cb);
+
+	err = iommu_bind_processes(sdxi);
+	if (err) {
+		amd_iommu_set_invalidate_ctx_cb(sdxi->pdev, NULL);
+		amd_iommu_set_invalid_ppr_cb(sdxi->pdev, NULL);
+		amd_iommu_free_device(sdxi->pdev);
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_AMD_IOMMU_V2 */
diff --git a/drivers/dma/sdxi/process.h b/drivers/dma/sdxi/process.h
new file mode 100644
index 000000000000..6e50719c7de8
--- /dev/null
+++ b/drivers/dma/sdxi/process.h
@@ -0,0 +1,71 @@
+/*
+ * User space process management
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ *
+ */
+
+#ifndef __SDXI_PROCESS_H
+#define __SDXI_PROCESS_H
+
+#include <linux/mmu_notifier.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/workqueue.h>
+
+#include "sdxi.h"
+
+/* User Space Process Info */
+struct sdxi_process {
+	struct hlist_node list;
+
+	struct mutex mutex;
+	struct task_struct *lead_thread;
+	void *mm;				/* pointer to mm_struct */
+	struct mmu_notifier mmu_notifier;	/* mm_struct notifier */
+
+	struct sdxi_ctxt *ctxt;
+	u32 pasid;				/* no meaning if !ctxt */
+};
+
+/* SDXI Device IOMMU Management */
+#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
+int sdxi_iommu_device_init(struct sdxi_dev *sdxi);
+void sdxi_iommu_device_exit(struct sdxi_dev *sdxi);
+void sdxi_iommu_suspend(struct sdxi_dev *sdxi);
+int sdxi_iommu_resume(struct sdxi_dev *sdxi);
+#else
+static inline int sdxi_iommu_device_init(struct sdxi_dev *sdxi)
+{
+#if IS_MODULE(CONFIG_AMD_IOMMU_V2)
+	WARN_ONCE(1, "iommu_v2 module is not usable by SDXI");
+#endif
+	return 0;
+}
+
+static inline void sdxi_iommu_device_exit(struct sdxi_dev *sdxi)
+{
+}
+
+static inline void sdxi_iommu_suspend(struct sdxi_dev *sdxi)
+{
+}
+
+static inline int sdxi_iommu_resume(struct sdxi_dev *sdxi)
+{
+	return 0;
+}
+#endif /* CONFIG_AMD_IOMMU_V2 */
+
+/* User Process Management */
+struct sdxi_process *sdxi_create_process(struct file *filep);
+void sdxi_destroy_process(struct sdxi_process *p);
+int sdxi_bind_process_to_device(struct sdxi_process *p);
+void sdxi_unbind_process_to_device(struct sdxi_process *p);
+void sdxi_unref_process(struct sdxi_process *p);
+struct sdxi_process *sdxi_get_process(struct task_struct *thread);
+
+#endif /* __SDXI_PROCESS_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
new file mode 100644
index 000000000000..8e90693b1e79
--- /dev/null
+++ b/drivers/dma/sdxi/sdxi.h
@@ -0,0 +1,414 @@
+/*
+ * SDXI device driver header
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#ifndef __SDXI_H
+#define __SDXI_H
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/idr.h>
+
+#include "../virt-dma.h"
+
+#define SDXI_DRV_NAME		"sdxi"
+#define SDXI_DRV_DESC		"SDXI driver"
+
+/***************************/
+/*        DEFAULTSS        */
+/***************************/
+#define DEFAULT_ERR_LOG_NUM	64
+#define DEFAULT_RKEY_NUM	256
+#define DEFAULT_AKEY_NUM	256
+
+/***************************/
+/*          MACROS         */
+/***************************/
+extern struct list_head sdxi_device_list;
+#define for_each_sdxi(sdxi)						\
+	list_for_each_entry((sdxi), &sdxi_device_list, list)
+#define for_each_sdxi_safe(sdxi, next)					\
+	list_for_each_entry_safe((sdxi), (next), &sdxi_device_list, list)
+
+#define ID_TO_L2_INDEX(id)	(((id) >> 9) & 0x1FF)
+#define ID_TO_L1_INDEX(id)	((id) & 0x7F)
+#define IS_VF_DEVICE(sdxi)	((sdxi)->is_vf)
+
+/***************************/
+/*          CONSTS         */
+/***************************/
+#define L2_TABLE_ENTRIES	(1 << 9)
+#define L1_TABLE_ENTRIES	(1 << 7)
+#define L2_TABLE_SIZE		4096
+#define L1_TABLE_SIZE		4096
+
+#define OP_TYPE_DMA             0x001
+#define OP_TYPE_ADMIN           0x002
+#define OP_TYPE_ATOMIC          0x003
+#define OP_TYPE_INTR            0x004
+
+#define OP_DMA_NOP		0x01
+#define OP_DMA_WRT_IMM		0x02
+#define OP_DMA_COPY		0x03
+#define OP_DMA_REP_COPY		0x04
+#define OP_ADMIN_UPDATE_FUNC	0x00
+#define OP_ADMIN_UPDATE_CTXT	0x01
+#define OP_ADMIN_UPDATE_AKEY	0x02
+#define OP_ADMIN_START		0x03
+#define OP_ADMIN_STOP		0x04
+#define OP_ADMIN_INTR		0x05
+#define OP_ADMIN_SYNC		0x06
+#define OP_ATOMIC_SWAP		0x01
+#define OP_ATOMIC_UADD		0x02
+#define OP_ATOMIC_USUB		0x03
+#define OP_ATOMIC_AND		0x05
+#define OP_ATOMIC_OR		0x06
+#define OP_ATOMIC_XOR		0x07
+#define OP_ATOMIC_SMIN		0x08
+#define OP_ATOMIC_SMAX		0x09
+#define OP_ATOMIC_UMIN		0x0A
+#define OP_ATOMIC_UMAX		0x0B
+#define OP_ATOMIC_UCLAMPI	0x0C
+#define OP_ATOMIC_UCLAMPD	0x0D
+#define OP_ATOMIC_CMPSWAP	0x0E
+#define OP_INTR_INTERRUPT	0x00
+
+#define CTXT_STATE_STOPPED	0x0
+#define CTXT_STATE_RUNNING	0x1
+#define CTXT_STATE_STOPPING	0x2
+#define CTXT_STATE_ERR		0xF
+
+#define DESC_RING_BASE_PTR_SHIFT	6
+#define CTXT_STATUS_PTR_SHIFT		4
+#define WRT_INDEX_PTR_SHIFT		3
+
+#define L2_CTXT_L1_BASE_SHIFT		12
+
+#define L1_CTXT_CTRL_PTR_SHIFT		6
+#define L1_CTXT_AKEY_PTR_SHIFT		12
+
+#define MAX_DMA_COPY_BYTES		(1ULL << 32)
+
+/***************************/
+/*         STRUCTS         */
+/***************************/
+enum sdxi_ctxt_id {
+	SDXI_ADMIN_CTXT_ID = 0,
+	SDXI_DMA_CTXT_ID = 1,
+	SDXI_KERNEL_CTXT_ID = 2,
+	SDXI_ANY_CTXT_ID,
+};
+
+/* context status entry */
+struct sdxi_ctxt_status {
+	u64 state		: 4;	/* QW0 */
+	u64 rsvd1		: 60;
+	u64 read_idx;			/* QW1 */
+} __packed __aligned(16);
+
+/* Context Control Entry */
+struct ctxt_ctrl_entry {
+	u64 valid		: 1;	/* QW0 */
+	u64 rsvd1		: 1;
+	u64 qos			: 2;
+	u64 sh			: 1;
+	u64 rsvd2		: 1;
+	u64 desc_ring_base	: 58;
+	u64 desc_ring_size	: 32;	/* QW1 */
+	u64 rsvd3		: 32;
+	u64 rsvd4		: 4;	/* QW2 */
+	u64 ctxt_status_ptr	: 60;
+	u64 rsvd5		: 3;	/* QW3 */
+	u64 wrt_index_ptr	: 61;
+	u32 rsvd6[8];			/* QW4+ */
+} __packed __aligned(64);
+
+struct sdxi_desc {
+	u32 valid		: 1;
+	u32 seq			: 1;
+	u32 fence		: 1;
+	u32 chain		: 1;
+	u32 rsvd1		: 4;
+	u32 sub_type		: 8;
+	u32 type		: 11;
+	u32 rsvd2		: 5;
+	u32 body[13];
+	u64 comp_ptr;
+} __packed;
+
+struct cst_blk {
+	u64 comp_signal;		/* QW0 */
+	u32 rsvd1		: 31;	/* QW1 */
+	u32 er			: 1;
+	u32 rsvd2[5];			/* DW3+ */
+} __packed;
+
+/* Submission Queue */
+struct sdxi_sq {
+	struct sdxi_ctxt *ctxt;		/* owner */
+
+	u32 ring_entries;
+	u32 ring_size;
+	struct sdxi_desc *desc_ring;
+	dma_addr_t ring_dma;
+	struct cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+
+	u32 write_index_size;
+	u64 *write_index;
+	dma_addr_t write_index_dma;
+
+	u32 ctxt_status_size;
+	struct sdxi_ctxt_status *ctxt_status;
+	dma_addr_t ctxt_status_dma;
+
+	/* NB: define doorbell here */
+};
+
+struct sdxi_tasklet_data {
+	struct completion completion;
+	struct sdxi_cmd *cmd;
+};
+
+struct sdxi_cmd {
+	struct list_head entry;
+	struct work_struct work;
+	struct sdxi_ctxt *ctxt;
+	int ret;
+	size_t len;
+	u64 src_addr;
+	u64 dst_addr;
+	u64 index;  //index at descriptor ring
+	/* completion callback support */
+	void (*sdxi_cmd_callback)(void *data, int err);
+	void *data;
+};
+
+struct sdxi_dma_desc {
+	struct virt_dma_desc vd;
+	struct sdxi_ctxt *ctxt;
+	enum dma_status status;
+	bool issued_to_hw;
+	struct sdxi_cmd sdxi_cmd;
+};
+
+struct sdxi_dma_chan {
+	struct virt_dma_chan vc;
+	struct sdxi_ctxt *ctxt;
+};
+
+struct akey_entry {
+	u32 vl			: 1;	/* QW0 */
+	u32 iv			: 1;
+	u32 pv			: 1;
+	u32 ste			: 1;
+	u32 intr_num		: 11;
+	u32 rsvd1		: 1;
+	u32 tgt_sfunc		: 16;
+	u32 pasid		: 20;
+	u32 rsvd2		: 10;
+	u32 ph			: 2;
+	u32 stag	       	: 16;	/* QW1 */
+	u32 rsvd3		: 16;
+	u32 rkey		: 16;
+	u32 rsvd4		: 16;
+} __packed;
+
+/* Context */
+struct sdxi_ctxt {
+	struct list_head list;
+	struct sdxi_dev *sdxi;	/* owner */
+	unsigned int id;
+
+	resource_size_t db_base;	/* doorbell MMIO base addr */
+	void __iomem *db;		/* doorbell virt addr */
+
+	struct ctxt_ctrl_entry cce;
+	dma_addr_t cce_addr;		/* cce dma addr */
+
+	int akey_entries;
+	struct akey_entry *akey;
+	dma_addr_t akey_addr;		/* akey dma addr */
+
+	struct sdxi_sq *sq;
+
+	/* NB: might need to move to sdxi_device? */
+	struct sdxi_dma_chan sdxi_dma_chan;
+
+	struct sdxi_process *process;	/* process reprsentation */
+
+	/* FOR DEBUG */
+	unsigned long *dummy_buffer;
+	dma_addr_t dummy_buffer_addr;
+};
+
+/* RKey Table Entry */
+struct rkey_ent {
+	u32 vl			: 1;	/* QW0 */
+	u32 iv			: 1;
+	u32 pv			: 1;
+	u32 se			: 1;
+	u32 intr_num		: 11;
+	u32 rsvd1		: 1;
+	u32 req_sfunc		: 16;
+	u32 pasid		: 20;
+	u32 rsvd2		: 10;
+	u32 ph			: 2;
+	u32 stag		: 16;	/* QW1 */
+	u32 rsvd3		: 16;
+	u32 rsvd4;
+} __packed;
+
+/* Error Log Entry */
+struct sdxi_err {
+	u32 valid		: 1;	/* QW0 */
+	u32 type		: 11;
+	u32 sub_type		: 8;
+	u32 rsvd1		: 11;
+	u32 chain		: 1;
+	u32 err_ctxt_num	: 16;
+	u32 rsvd2		: 4;
+	u32 ctxt_num_valid	: 1;
+	u32 addr_valid		: 1;
+	u32 idx_valid		: 1;
+	u32 retry		: 1;
+	u32 err_sub_type	: 8;
+	u64 err_addr;			/* QW1 */
+	u64 err_idx;			/* QW2 */
+	u64 rsvd3[5];			/* QW3+ */
+} __packed;
+
+/* L1 Table Entry */
+struct ctxt_l1_entry {
+	u64 valid		: 1;	/* QW0 */
+	u64 active		: 1;
+	u64 pasid_valid		: 1;
+	u64 rsvd1		: 3;
+	u64 ctxt_ctrl_ptr	: 58;
+	u64 akey_tbl_size	: 4;	/* QW1 */
+	u64 rsvd2		: 8;
+	u64 akey_tbl_ptr	: 52;
+	u64 ctxt_pasid		: 20;	/* QW2 */
+	u64 max_buf		: 4;
+	u64 rsvd3		: 8;
+	u64 cmd_grp0_support	: 32;
+	u64 rsvd4;			/* QW3 */
+} __packed;
+
+/* L2 Table Entry */
+struct ctxt_l2_entry {
+	u64 valid		: 1;	/* QW0 */
+	u64 rsvd		: 11;
+	u64 ctxt_l1_base	: 52;
+} __packed;
+
+struct irq_entry {
+	int vector;
+};
+
+struct sdxi_dev {
+	struct list_head list;
+
+	/* physical device */
+	struct pci_dev *pdev;
+	resource_size_t ctrl_regs_bar;	/* ctrl registers base (BAR0) */
+	resource_size_t dbs_bar;	/* doorbells base (BAR2) */
+	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
+	void __iomem *dbs;		/* virt addr of doorbells */
+
+	/* hardware capabilities (from cap0 & cap1) */
+	u16 sfunc;			/* function's requester id */
+	bool is_vf;			/* is VF function? */
+	u32 db_stride;			/* doorbell stride in bytes */
+	u64 max_ring_entries;		/* max # of ring entries supported */
+	u32 max_rkeys;			/* max rkey # supported */
+
+	u64 max_buffer;			/* max supported buffer size bytes */
+	bool has_rkey;			/* is rkey functionality supported? */
+	u32 max_err_logs;		/* max err log entries supported */
+	u32 max_akeys;			/* max akey # supported */
+	u32 max_cxts;			/* max contexts # supported */
+	u32 op_grp_cap;			/* supported operatation group cap */
+
+	/* iommu support */
+	bool use_iommu_v2;		/* bound with iommu for pasid? */
+	u32 max_pasids;
+	u32 pasid_limit;
+	struct ida pasid_ida;
+
+	/* MSI */
+	unsigned int irq_count;
+	struct irq_entry err_irq;
+	struct irq_entry *ctxt_irqs;	/* NB: convert to a struct */
+
+	/* context management */
+	spinlock_t ctxt_lock;		/* context protection */
+	struct list_head ctxt_list;
+	int ctxt_count;
+	/* l2 table, pre-allocated with sdxi_device */
+	struct ctxt_l2_entry *l2_table;
+	/* list of context l1 tables, on-demand, access with [l2_idx] */
+	struct ctxt_l1_entry *l1_table_array[L2_TABLE_ENTRIES];
+	/* all contexts, on-demand, access with [l2_idx][l1_idx] */
+	struct sdxi_ctxt **ctxt_array[L2_TABLE_ENTRIES];
+
+	/* rkey table */
+	int rkey_num;
+	struct rkey_ent *rkey;
+
+	/* error log */
+	u32 err_log_num;
+	struct sdxi_err *err_log;
+
+	/* DMA engine */
+	struct dma_device dma_dev;
+	struct sdxi_dma_chan *sdxi_dma_chan;
+	struct kmem_cache *dma_cmd_cache;
+	struct kmem_cache *dma_desc_cache;
+	struct sdxi_tasklet_data tdata;
+
+	/* special contexts */
+	struct sdxi_ctxt *admin_ctxt;	/* admin context */
+	struct sdxi_ctxt *dma_ctxt;	/* DMA engine context */
+	struct sdxi_ctxt *kern_ctxt;	/* kernel space context */
+};
+
+/***************************/
+/*           API           */
+/***************************/
+/* Device Control */
+int sdxi_device_init(struct sdxi_dev *sdxi);
+void sdxi_device_exit(struct sdxi_dev *sdxi);
+
+/* Context Control */
+struct sdxi_ctxt *sdxi_ctxt_alloc(struct sdxi_dev *sdxi);
+struct sdxi_ctxt *sdxi_working_ctxt_random_alloc(void);
+void sdxi_ctxt_free(struct sdxi_ctxt *ctxt);
+struct sdxi_ctxt *sdxi_working_ctxt_init(struct sdxi_dev *sdxi,
+					 enum sdxi_ctxt_id);
+void sdxi_working_ctxt_exit(struct sdxi_ctxt *ctxt);
+struct sdxi_ctxt *sdxi_working_ctxt_alloc(void);
+
+/* Submission Queue */
+struct sdxi_sq *sdxi_sq_alloc(struct sdxi_ctxt *ctxt, int ring_size);
+struct sdxi_sq *sdxi_sq_alloc_default(struct sdxi_ctxt *ctxt);
+void sdxi_sq_free(struct sdxi_sq *sq);
+int sdxi_submit_desc(struct sdxi_sq *sq, struct sdxi_desc *desc);
+
+/* DMA Engine */
+int sdxi_dma_register(struct sdxi_ctxt *dma_ctxt);
+void sdxi_dma_unregister(struct sdxi_ctxt *dma_ctxt);
+
+/* Chardev (IOCTL) */
+int sdxi_chardev_init(void);
+void sdxi_chardev_exit(void);
+
+#endif /* __SDXI_H */
diff --git a/drivers/dma/sdxi/sq.c b/drivers/dma/sdxi/sq.c
new file mode 100644
index 000000000000..a9f39972bc65
--- /dev/null
+++ b/drivers/dma/sdxi/sq.c
@@ -0,0 +1,295 @@
+/*
+ * SDXI submission queue (sq) and descriptor management
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ *
+ */
+
+#include "sdxi.h"
+#include "pci.h"
+#include "sq.h"
+#include "trace.h"
+
+/* NB: take care of completion pointer */
+void build_admin_update_func(struct sdxi_desc *desc, bool vf, u16 vf_num)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	DESC_ADM_BUILD_VF(desc, vf, vf_num);
+	DESC_BUILD_TYPE(desc, OP_TYPE_ADMIN, OP_ADMIN_UPDATE_FUNC);
+}
+
+void build_admin_update_ctxt(struct sdxi_desc *desc, bool vf, u16 vf_num,
+			     bool v2, bool v1, bool ct, u16 ctxt_num,
+			     u16 ctxt_mask)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->body[0] |= (v2 << 0);
+	desc->body[0] |= (v1 << 1);
+	desc->body[0] |= (ct << 2);
+	DESC_ADM_BUILD_VF(desc, vf, vf_num);
+	DESC_ADM_BUILD_CTXT(desc, ctxt_num, ctxt_mask);
+	DESC_BUILD_TYPE(desc, OP_TYPE_ADMIN, OP_ADMIN_UPDATE_CTXT);
+}
+
+void build_admin_start(struct sdxi_desc *desc, bool dr, bool vf,
+		       u16 vf_num, u16 ctxt_num, u16 ctxt_mask,
+		       u64 doorbell)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->fence = 1;
+	desc->body[0] |= (dr << 14);
+	DESC_ADM_BUILD_VF(desc, vf, vf_num);
+	DESC_ADM_BUILD_CTXT(desc, ctxt_num, ctxt_mask);
+	desc->body[3] |= (doorbell & 0xFFFFFFFF);
+	desc->body[4] |= ((doorbell >> 32) & 0xFFFFFFFF);
+	DESC_BUILD_TYPE(desc, OP_TYPE_ADMIN, OP_ADMIN_START);
+}
+
+void build_admin_start_new(struct sdxi_desc *desc, bool vf, u16 vf_num,
+			   u16 ctxt_start, u16 ctxt_end, u64 doorbell)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->fence = 1;
+	DESC_ADM_BUILD_VF(desc, vf, vf_num);
+	DESC_ADM_BUILD_CTXT(desc, ctxt_start, ctxt_end);
+	desc->body[3] |= (doorbell & 0xFFFFFFFF);
+	desc->body[4] |= ((doorbell >> 32) & 0xFFFFFFFF);
+	DESC_BUILD_TYPE(desc, OP_TYPE_ADMIN, OP_ADMIN_START);
+	desc->comp_ptr = 0x1;
+}
+
+void build_admin_stop(struct sdxi_desc *desc, bool hs, bool vf,
+		      u16 vf_num, u16 ctxt_num, u16 ctxt_mask)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->fence = 1;
+	desc->body[0] |= (hs << 13);
+	DESC_ADM_BUILD_VF(desc, vf, vf_num);
+	DESC_ADM_BUILD_CTXT(desc, ctxt_num, ctxt_mask);
+	DESC_BUILD_TYPE(desc, OP_TYPE_ADMIN, OP_ADMIN_STOP);
+}
+
+void build_admin_sync(struct sdxi_desc *desc, bool vf, u16 vf_num,
+		      u16 ctxt_num, u16 ctxt_mask, u16 akey_num,
+		      u16 akey_mask)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->fence = 1;
+	DESC_ADM_BUILD_VF(desc, vf, vf_num);
+	DESC_ADM_BUILD_CTXT(desc, ctxt_num, ctxt_mask);
+	DESC_ADM_BUILD_AKEY(desc, akey_num, akey_mask);
+	DESC_BUILD_TYPE(desc, OP_TYPE_ADMIN, OP_ADMIN_SYNC);
+}
+
+void build_dma_nop(struct sdxi_desc *desc)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	DESC_BUILD_TYPE(desc, OP_TYPE_DMA, OP_DMA_NOP);
+}
+
+void build_dma_copy(struct sdxi_desc *desc, u32 size, u8 src_attr,
+		    u8 dst_attr, u16 src_akey, u16 dst_akey,
+		    u64 src_addr, u64 dst_addr, u64 comp_ptr)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->fence = 1;
+	desc->body[0] |= size;
+	desc->body[1] |= (src_attr & 0xF);
+	desc->body[1] |= ((dst_attr & 0xF) << 4);
+	desc->body[2] |= (src_akey & 0xFFFF);
+	desc->body[2] |= ((dst_akey & 0xFFFF) << 16);
+	desc->body[3] = (src_addr & 0xFFFFFFFF);
+	desc->body[4] = ((src_addr >> 32) & 0xFFFFFFFF);
+	desc->body[5] = (dst_addr & 0xFFFFFFFF);
+	desc->body[6] = ((dst_addr >> 32) & 0xFFFFFFFF);
+	desc->comp_ptr = comp_ptr;
+	desc->comp_ptr = 0x1;
+	DESC_BUILD_TYPE(desc, OP_TYPE_DMA, OP_DMA_COPY);
+}
+
+void build_dma_write_imm(struct sdxi_desc *desc, u32 size, u64 dst_addr,
+			u32 data)
+{
+	memset(desc, 0, sizeof(*desc));
+
+	desc->body[0] |= size-1;
+	desc->body[3] = (dst_addr & 0xFFFFFFFF);
+	desc->body[4] = ((dst_addr >> 32) & 0xFFFFFFFF);
+	desc->body[5] |= data;
+	DESC_BUILD_TYPE(desc, OP_TYPE_DMA, OP_DMA_WRT_IMM);
+}
+
+static inline void sdxi_sq_ring_doorbell(struct sdxi_sq *sq, u64 value)
+{
+	struct sdxi_ctxt *ctxt = sq->ctxt;
+
+	reg_write64(ctxt->db, value);
+}
+
+u64 sdxi_sq_submit_desc(struct sdxi_sq *sq, struct sdxi_desc *desc,
+			bool cst, u64 init_signal)
+{
+	struct device *dev = &sq->ctxt->sdxi->pdev->dev;
+	u64 dest;
+
+	/* check context status */
+	if (sq->ctxt_status->state != CTXT_STATE_RUNNING) {
+		dev_err(dev, "Context is not running\n");
+		return -EINVAL;
+	}
+
+	/* no more room for any descriptor */
+	if (*sq->write_index + 1 - sq->ctxt_status->read_idx > sq->ring_entries) {
+		dev_err(dev, "desc ring is full\n");
+		return -EINVAL;
+	}
+
+	/* NB: Atomic_INC */
+	desc->valid = 0;
+	dest = *sq->write_index;
+	dest %= sq->ring_entries;
+	memcpy(&sq->desc_ring[dest], desc, sizeof(struct sdxi_desc));
+	if (cst) {
+		memset(&sq->cst_blk[dest], 0, sizeof(struct cst_blk));
+		sq->cst_blk[dest].comp_signal = init_signal;
+		sq->desc_ring[dest].comp_ptr = sq->cst_blk_dma + dest * sizeof(struct cst_blk);
+	}
+	sq->desc_ring[dest].valid = 1;
+	/* make sure the update of valid bit is visible */
+	wmb();
+	*sq->write_index = dest + 1;
+
+	/* ring the door bell */
+	sdxi_sq_ring_doorbell(sq, *sq->write_index);
+
+	return dest;
+}
+
+/* Alloc sdxi_sq in kernel space */
+struct sdxi_sq *sdxi_sq_alloc(struct sdxi_ctxt *ctxt, int ring_entries)
+{
+	struct sdxi_dev *sdxi = ctxt->sdxi;
+	struct device *dev = &sdxi->pdev->dev;
+	struct sdxi_sq *sq;
+
+	sq = kzalloc(sizeof(*sq), GFP_KERNEL);
+	if (!sq)
+		return NULL;
+
+	/* alloc desc_ring */
+	if (ring_entries > sdxi->max_ring_entries) {
+		dev_err(dev, "Invalid descriptor ring entries\n");
+		goto err_ring_entries;
+	}
+
+	sq->ring_entries = ring_entries;
+	sq->ring_size = sizeof(struct sdxi_desc) * sq->ring_entries;
+	sq->desc_ring = kzalloc(sq->ring_size, GFP_KERNEL);
+	if (!sq->desc_ring)
+		goto err_desc_ring;
+	sq->ring_dma = dma_map_single(dev, sq->desc_ring, sq->ring_size,
+				      DMA_BIDIRECTIONAL);
+
+	/* alloc completion status block */
+	sq->cst_blk = kzalloc(ring_entries * sizeof(struct cst_blk), GFP_KERNEL);
+	if (!sq->cst_blk)
+		goto err_cst_blk;
+	sq->cst_blk_dma = dma_map_single(dev, sq->cst_blk, ring_entries * sizeof(struct cst_blk),
+					 DMA_FROM_DEVICE);
+
+	/* alloc ctxt status (NB: use page size) */
+	sq->ctxt_status_size = PAGE_SIZE;
+	sq->ctxt_status = kzalloc(sq->ctxt_status_size, GFP_KERNEL);
+	if (!sq->ctxt_status)
+		goto err_ctxt_status;
+	sq->ctxt_status_dma = dma_map_single(dev, sq->ctxt_status, sq->ctxt_status_size,
+					     DMA_FROM_DEVICE);
+
+	/* alloc write index (NB: use page size) */
+	sq->write_index_size = PAGE_SIZE;
+	sq->write_index = kzalloc(sq->write_index_size, GFP_KERNEL);
+	if (!sq->write_index)
+		goto err_write_index;
+	sq->write_index_dma = dma_map_single(dev, sq->write_index, sq->write_index_size,
+					     DMA_TO_DEVICE);
+
+	/* final setup */
+	if (ctxt->id == SDXI_ADMIN_CTXT_ID)
+		sq->ctxt_status->state = CTXT_STATE_RUNNING;
+	else if (ctxt->id == SDXI_DMA_CTXT_ID)
+		sq->ctxt_status->state = CTXT_STATE_RUNNING;
+
+	ctxt->cce.desc_ring_size = sq->ring_size >> 6;
+	ctxt->cce.desc_ring_base = sq->ring_dma >> DESC_RING_BASE_PTR_SHIFT;
+	ctxt->cce.ctxt_status_ptr = sq->ctxt_status_dma >> CTXT_STATUS_PTR_SHIFT;
+	ctxt->cce.wrt_index_ptr = sq->write_index_dma >> WRT_INDEX_PTR_SHIFT;
+
+	/* turn it on now */
+	sq->ctxt = ctxt;
+	ctxt->sq = sq;
+	ctxt->cce.valid = 1;
+
+	pr_info("sq created, id=%d, cce=%p\n"
+		"  desc ring addr:   v=0x%p:d=0x%llx\n"
+		"  write index addr: v=0x%p:d=0x%llx\n"
+		"  ctxt status addr: v=0x%p:d=0x%llx\n",
+		ctxt->id, &(ctxt->cce),
+		sq->desc_ring, virt_to_phys(sq->desc_ring),
+		sq->write_index, virt_to_phys(sq->write_index),
+		sq->ctxt_status, virt_to_phys(sq->ctxt_status));
+
+	/* dump SQ info */
+	trace_sdxi_create_sq(ctxt, sq);
+
+	return sq;
+
+err_write_index:
+	kfree(sq->ctxt_status);
+err_ctxt_status:
+	kfree(sq->cst_blk);
+err_cst_blk:
+	kfree(sq->desc_ring);
+err_desc_ring:
+err_ring_entries:
+	kfree(sq);
+	return NULL;
+}
+
+void sdxi_sq_free(struct sdxi_sq *sq)
+{
+	struct sdxi_ctxt *ctxt = sq->ctxt;
+	struct device *dev;
+
+	if (!ctxt)
+		return;
+
+	trace_sdxi_free_sq(ctxt, sq);
+
+	dev = &ctxt->sdxi->pdev->dev;
+	memset(&ctxt->cce, 0, sizeof(ctxt->cce));
+
+	kfree(sq->write_index);
+	kfree(sq->ctxt_status);
+	kfree(sq->cst_blk);
+	kfree(sq->desc_ring);
+
+	ctxt->sq = NULL;
+	kfree(sq);
+}
+
+/* Default size 1024 ==> 64KB descriptor ring, guaranteed */
+#define DEFAULT_DESC_RING_ENTRIES	1024
+struct sdxi_sq *sdxi_sq_alloc_default(struct sdxi_ctxt *ctxt)
+{
+	return sdxi_sq_alloc(ctxt, DEFAULT_DESC_RING_ENTRIES);
+}
diff --git a/drivers/dma/sdxi/sq.h b/drivers/dma/sdxi/sq.h
new file mode 100644
index 000000000000..7e2a6e8f4625
--- /dev/null
+++ b/drivers/dma/sdxi/sq.h
@@ -0,0 +1,67 @@
+/*
+ * Header for sq and descriptor management
+ *
+ * Copyright (C) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ *
+ */
+
+#ifndef __SDXI_SQ_H
+#define _SDXI_SQ_H
+
+#include "sdxi.h"
+
+#define DESC_BUILD_TYPE(d, t, s)		\
+	do {					\
+		(d)->valid = 1;			\
+		(d)->type = (t);		\
+		(d)->sub_type = (s);		\
+	} while (0)
+
+#define DESC_ADM_BUILD_VF(d, vf, vf_num)				\
+	do {								\
+		if (vf) {						\
+			(d)->body[0] |= ((vf_num) & 0xFFFF) << 16;	\
+			(d)->body[0] |= (1 << 15);			\
+		}							\
+	} while (0)
+
+#define DESC_ADM_BUILD_CTXT(d, start, end)			\
+	do {							\
+		(d)->body[1] |= ((start) & 0xFFFF);		\
+		(d)->body[1] |= ((end) & 0xFFFF) << 16;		\
+	} while (0)
+
+#define DESC_ADM_BUILD_AKEY(d, num, mask)			\
+	do {							\
+		(d)->body[2] |= ((num) & 0xFFFF);		\
+		(d)->body[2] |= ((mask) & 0xFFFF) << 16;	\
+	} while (0)
+
+void build_admin_update_func(struct sdxi_desc *desc, bool vf, u16 vf_num);
+void build_admin_update_ctxt(struct sdxi_desc *desc, bool vf, u16 vf_num,
+			     bool v2, bool v1, bool ct, u16 ctxt_num,
+			     u16 ctxt_mask);
+void build_admin_start(struct sdxi_desc *desc, bool dr, bool vf,
+		       u16 vf_num, u16 ctxt_num, u16 ctxt_mask,
+		       u64 doorbell);
+void build_admin_start_new(struct sdxi_desc *desc, bool vf, u16 vf_num,
+			   u16 ctxt_start, u16 ctxt_end, u64 doorbell);
+void build_admin_stop(struct sdxi_desc *desc, bool hs, bool vf,
+		      u16 vf_num, u16 ctxt_num, u16 ctxt_mask);
+void build_admin_sync(struct sdxi_desc *desc, bool vf, u16 vf_num,
+		      u16 ctxt_num, u16 ctxt_mask, u16 akey_num,
+		      u16 akey_mask);
+
+void build_dma_nop(struct sdxi_desc *desc);
+void build_dma_copy(struct sdxi_desc *desc, u32 size, u8 src_attr,
+		    u8 dst_attr, u16 src_akey, u16 dst_akey,
+		    u64 src_addr, u64 dst_dst, u64 comp_ptr);
+void build_dma_write_imm(struct sdxi_desc *desc, u32 size, u64 dst_addr,
+			 u32 data);
+
+u64 sdxi_sq_submit_desc(struct sdxi_sq *sq, struct sdxi_desc *desc, bool cst,
+			u64 init_signal);
+
+#endif /* __SDXI_SQ_H */
diff --git a/drivers/dma/sdxi/trace.c b/drivers/dma/sdxi/trace.c
new file mode 100644
index 000000000000..11cc3a3da140
--- /dev/null
+++ b/drivers/dma/sdxi/trace.c
@@ -0,0 +1,10 @@
+/*
+ * SDXI tracepoints
+ *
+ * Copyright (c) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+
+#include "trace.h"
+
diff --git a/drivers/dma/sdxi/trace.h b/drivers/dma/sdxi/trace.h
new file mode 100644
index 000000000000..3fcdb5709163
--- /dev/null
+++ b/drivers/dma/sdxi/trace.h
@@ -0,0 +1,115 @@
+/*
+ * SDXI tracepoints header
+ *
+ * Copyright (c) 2022 AMD, Inc. All rights reserved.
+ *
+ * Author: Wei Huang <wei.huang2@amd.com>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sdxi
+#define TRACE_INCLUDE_FILE trace
+
+#if !defined(_TRACE_SDXI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SDXI_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "sdxi.h"
+
+TRACE_EVENT(sdxi_create_ctxt,
+	    TP_PROTO(struct sdxi_dev *sdxi, struct sdxi_ctxt *ctxt),
+	    TP_ARGS(sdxi, ctxt),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(uint, ctxt_id)
+		    __field(void *, cce)
+		    __field(u64, cce_dma_addr)
+		    __field(void *, akey)
+		    __field(u64, akey_dma_addr)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = sdxi->sfunc;
+		    __entry->ctxt_id = ctxt->id;
+		    __entry->cce = &(ctxt->cce);
+		    __entry->cce_dma_addr = ctxt->cce_addr;
+		    __entry->akey = ctxt->akey;
+		    __entry->akey_dma_addr = ctxt->akey_addr;
+	    ),
+	    TP_printk("ctxt %d created (dev=0x%04x)\n"
+		      "  cce addr:  v=0x%p:d=0x%llx\n"
+		      "  akey addr: v=0x%p:d=0x%llx\n",
+		      __entry->ctxt_id, __entry->sfunc, __entry->cce,
+		      __entry->cce_dma_addr, __entry->akey, __entry->akey_dma_addr)
+);
+
+TRACE_EVENT(sdxi_free_ctxt,
+	    TP_PROTO(struct sdxi_dev *sdxi, struct sdxi_ctxt *ctxt),
+	    TP_ARGS(sdxi, ctxt),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(uint, ctxt_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = sdxi->sfunc;
+		    __entry->ctxt_id = ctxt->id;
+	    ),
+	    TP_printk("ctxt %d freed (dev=0x%04x)\n",
+		      __entry->ctxt_id, __entry->sfunc)
+);
+
+TRACE_EVENT(sdxi_create_sq,
+	    TP_PROTO(struct sdxi_ctxt *ctxt, struct sdxi_sq *sq),
+	    TP_ARGS(ctxt, sq),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(uint, ctxt_id)
+		    __field(void *, desc_ring)
+		    __field(u64, desc_ring_addr)
+		    __field(void *, write_index)
+		    __field(u64, write_index_addr)
+		    __field(void *, ctxt_status)
+		    __field(u64, ctxt_status_addr)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = ctxt->sdxi->sfunc;
+		    __entry->ctxt_id = ctxt->id;
+		    __entry->desc_ring = sq->desc_ring;
+		    __entry->desc_ring_addr = sq->ring_dma;
+		    __entry->write_index = sq->write_index;
+		    __entry->write_index_addr = sq->write_index_dma;
+		    __entry->ctxt_status = sq->ctxt_status;
+		    __entry->ctxt_status_addr = sq->ctxt_status_dma;
+	    ),
+	    TP_printk("sq created (ctxt=%d, dev=0x%04x)\n"
+		      "  desc ring addr:   v=0x%p:d=0x%llx\n"
+		      "  write index addr: v=0x%p:d=0x%llx\n"
+		      "  ctxt status addr: v=0x%p:d=0x%llx\n",
+		      __entry->ctxt_id, __entry->sfunc, __entry->desc_ring,
+		      __entry->desc_ring_addr, __entry->write_index,
+		      __entry->write_index_addr, __entry->ctxt_status,
+		      __entry->ctxt_status_addr)
+);
+
+TRACE_EVENT(sdxi_free_sq,
+	    TP_PROTO(struct sdxi_ctxt *ctxt, struct sdxi_sq *sq),
+	    TP_ARGS(ctxt, sq),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(uint, ctxt_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = ctxt->sdxi->sfunc;
+		    __entry->ctxt_id = ctxt->id;
+	    ),
+	    TP_printk("sq created (ctxt=%d, dev=0x%04x)\n",
+		      __entry->ctxt_id, __entry->sfunc)
+);
+
+#endif /* _TRACE_SDXI_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../drivers/dma/sdxi/
+
+#include <trace/define_trace.h>
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..a0314d65255c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -154,6 +154,8 @@
 #define PCI_BASE_CLASS_ACCELERATOR	0x12
 #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
 
+#define PCI_CLASS_ACCEL_SDXI           0x120100
+
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
diff --git a/include/uapi/linux/sdxi.h b/include/uapi/linux/sdxi.h
new file mode 100644
index 000000000000..4ab87d289c01
--- /dev/null
+++ b/include/uapi/linux/sdxi.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_SDXI_H
+#define __LINUX_SDXI_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define SDXI_MAJOR_VERSION	0
+#define SDXI_MINOR_VERSION	1
+
+struct sdxi_get_version_args {
+	__u32 major_version;		/* from SDXI */
+	__u32 minor_version;		/* from SDXI */
+};
+
+/* For sdxi_get_dev_info_args.dev_supported_op_grps */
+#define SDXI_DMA_OP_GROUP		(1U << 0)
+#define SDXI_ADMIN_OP_GROUP	(1U << 1)
+#define SDXI_ATOMIC_OP_GROUP	(1U << 2)
+#define SDXI_INTR_OP_GROUP	(1U << 3)
+#define SDXI_CONN_OP_GROUP	(1U << 4)
+#define SDXI_VENDOR_OP_GROUP	(1U << 5)
+
+struct sdxi_get_dev_info_args {
+	__u32 dev_max_buff_size;	/* from SDXI */
+	__u64 dev_supported_op_grps;	/* from SDXI */
+	__u32 ctxt_max_ring_entries;	/* from SDXI */
+	__u32 ctxt_max_akey_entries;	/* from SDXI */
+};
+
+/* For sdxi_create_ctxt_args.ctxt_type */
+#define SDXI_CTXT_TYPE_USER	0x0
+#define SDXI_CTXT_TYPE_KERNEL	0x1
+
+struct sdxi_create_ctxt_args {
+	__u32 ctxt_type;		/* to SDXI */
+	__u32 ring_entries;		/* to/from SDXI */
+
+	__u32 ctxt_id;			/* from SDXI */
+	__u32 pasid;			/* from SDXI */
+	__u64 ctxt_status_mmap_base;	/* from SDXI */
+	__u64 desc_ring_mmap_base;	/* from SDXI */
+	__u64 write_index_mmap_base;	/* from SDXI */
+	__u64 doorbell_mmap_base;	/* from SDXI */
+};
+
+struct sdxi_close_ctxt_args {
+	__u32 ctxt_id;			/* to SDXI */
+	__u32 pad;
+};
+
+#define SDXI_IOCTL_BASE 'S'
+#define SDXI_IO(nr)			_IO(SDXI_IOCTL_BASE, nr)
+#define SDXI_IOR(nr, type)		_IOR(SDXI_IOCTL_BASE, nr, type)
+#define SDXI_IOW(nr, type)		_IOW(SDXI_IOCTL_BASE, nr, type)
+#define SDXI_IOWR(nr, type)		_IOWR(SDXI_IOCTL_BASE, nr, type)
+
+#define SDXI_GET_VERSION			\
+		SDXI_IOR(0x01, struct sdxi_get_version_args)
+
+#define SDXI_GET_DEV_INFO			\
+		SDXI_IOR(0x02, struct sdxi_get_dev_info_args)
+
+#define SDXI_CREATE_CTXT			\
+		SDXI_IOWR(0x03, struct sdxi_create_ctxt_args)
+
+#define SDXI_CLOSE_CTXT				\
+		SDXI_IOWR(0x04, struct sdxi_close_ctxt_args)
+
+#endif /* __LINUX_SDXI_H */
-- 
2.31.1

