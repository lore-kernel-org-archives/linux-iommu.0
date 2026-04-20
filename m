Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C362E62AC
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674573; cv=fail; b=aoreWmvMHsdVmXNTKZmTvJv/7fRTF4pl2cUG5Qu9XwNqdbK0MtGkVwYWckW0sL1L57zY/mOk5lj9vWknHXaZLaGkL/Mg7cSuERUxGVJVBjwyipzHyHtXKkuvyf8WnX2kag68S0xxAe1+BgOfVCRGrRHjzeYpcmF373ILoCYz1Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674573; c=relaxed/simple;
	bh=//iWnHENulmCZzPiE8pfs+Pq9mLld7jHplkgqy9h8mI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAXtDkZv6YR9YKS9h8tGbzy8OrWG3Rude3UayXv9DPHbuon5lJs18KOHclMv39ZNR8K1/XqY/f1HbUOvoZbFy1x+By1tmHIiJ+ZCE9neRvMNAbVXTAlsRj/DmKCqTCB/Luna+HcTNltQszE9N4tRT5tDirKPgR8P51XDwX8dOx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DtnTgPPL; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DtnTgPPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBn1/EDRGJ11yliAQCGx9YfgsIeJkDmutCHnZYGCe2rDYTQhngo86yZyKmr80rYVv5hYn9UoG3t3FzPlZNHW7dRks60QBR/TI8SAf3j6Twz+aeixVDkvyFLmCs2vQ8R/AJcnazh1RPOGS2eOW+qq8Jk7+yXqJ7h5FTq8d7zwlenWFPp/M8jhKE9/iKmzuFs7nmMUTZAGzGXvFGtTkrYTQOMbuZ1j6HPFZTVzxW2cYZga9VsqcTHnk2IPY/1RoiKRiMgv+Plojx4MJyo/v1jJNYDU84ShvoC/wphJoIeQqqgvlf+YRXSEN48Dw6rUo8iyTVf1bRZYjML4VNgtC7aadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/aM0F2rfOzX6nzwRzFo8elx+HVVX+y8+JUs2wW5V4o=;
 b=KScBqJzkHD8JgM6+JvoKUcMj4cScfsA20EK2pzBfrNYq510gt2x5gQ02PP/bTZV2N/Z/w+Pw4BGX4lNCsctLfOFsVcXiv0V5n7yZqsmDJbaI0Nmmy+kmZEPmmnal8cB/9ieVG3+SAVB2WKd3YRYQ9+Oqv4IRypIw6MT0iR+l+h2HknmKYDEsdyI+lxutgBcknkHbJ97Vh4WBtjufnvZdF+GHDzGNk30QxhkYmuhjAVWlbhVAaP9fYnnbwQTCbwQzuN642i2dzz0fEgM+yQvNCKHl27zhjuZUMP3DK8cBM6iWpcif5QewBJlcOt1WWK2EPTSbd4ds2/7IVRxj9gQiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/aM0F2rfOzX6nzwRzFo8elx+HVVX+y8+JUs2wW5V4o=;
 b=DtnTgPPLgN1uqZQYn/iblmh3RX5wQtBTCaDksEMXSQofrKILldEArIOyqSALBpoFP0pjC33PoRKgr5nZAzBPhCHW8A1wZOVlTZ3zVKURkLF1+D70BeZ8nO9X4QwVxoAk1ubEQA/qGKRMDkie/B6LurWsevR736gaVyt6bye3nfM=
Received: from CH5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610:1f0::8)
 by SA6PR12MB999199.namprd12.prod.outlook.com (2603:10b6:806:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 08:42:47 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::59) by CH5PR05CA0002.outlook.office365.com
 (2603:10b6:610:1f0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 08:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 08:42:47 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 03:42:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bp@alien8.de>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 1/2] iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
Date: Mon, 20 Apr 2026 08:42:03 +0000
Message-ID: <20260420084204.12263-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420084204.12263-1-vasant.hegde@amd.com>
References: <20260420084204.12263-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA6PR12MB999199:EE_
X-MS-Office365-Filtering-Correlation-Id: 921d8b85-12db-4214-393c-08de9eb8cca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pv1zQxIksfemeBmUC7XZeyUnL76hwWt9Vv4UmU80PXEe8sAV1kqqQV2yS7ySDTrbLTfNaMJia99PTJvmavFw1h4kJymjwELpEl2Tf99THK8zwtIYrOeUCppzjttOlJVwBczbtOooPjlTNghFMldy/HcvnpaoB4GoikcMDiE2yYV9QrguVylUDAHbja9vPg0tNbhOAmTMJl4CIg+l95SSyRWZgoVo8S2gMHa2jB68Bqoj6PlwdQerCGcPWfOYT0Cjnr9eKEaJnreg9WiIKDljFaD2nacOE+zA1RzIFjmQw5IGnG/uwQTMtSCpME1XaMPFEAHIRsQCCfSceGLnyNzFYshzz0mGRZsxboJAThS98PKidpWr9DVJ/IBVCs3S1GgZZP0pwVAvUhM1JWNIQBPEYfq9jFLn6UyKwPIMOhgzJYTV1tFO98UIP5hUdsw996TP4VH0l2P/mTcAME7ilPzAjDU9dtrMdGR02L3vPptTKj/LZ7cOM/EmIedRUSQGlw0Ae88VeIrFgNNWmMXCS+jscVryBzOa2gBiS/WfolfAUaR08jtww2jRsqZrChZ8pKjGvEudwLn6Qcala0NSs7rMZbVkAfOhzZJ0LkWZrcB7O0ztuKiJCT+dlZ7Z4jruU8qbsAgOobcIiTSI+wjFpG/EzAhPPluUcl6nipI8x9swPCmP/Bowtehc1p/KoMtHT6XBKeiZxfkAL1r3G6RIBqqcCrZpOOhJi678gEyYo9OFxhwRNXszfo9ewmzBicMbuQR8ImZHywgEB6HN0gowHY3uOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wG8yfvGIygh5Y4CgGbekXgBE7Bx+WyrfzUQo0fNN8STCLM+8xbwxe0apBbAe3Vl37ShvHOnNmJCDpVOZw4rKCHWVuMjdxEE6x3bxP2ww3/iKQGuqXqdUVGks/YIuRlOIGz50CYV4qWGPqiLW4CKjKrq+mVBt42RFE61nLqq9Lz8hpuNPiii+XLyho/cZkROASdEbX3rk4vu6gFyejxfdbBIt52R+cuiAaJIxv+TdhK7XJKLnPMJypMHzn5MI2T28KU7LTvFNch14PddEWGCUDOZx1F4AK8jYZOd9Gcj5GTp/NYdm5qO1csU8bQFHhu3Ko+B2tLEl+MJNO3SLIBdUO0Ch2e+qe73dY5oFCI68W3UWENJ58YywNgVczO0GGdTdMxCWqK74uoRg5Hm+4Wpxe7wZeROFTXCjEugnpxRDtt2usLaTWRi758TmFc3fCcvN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:42:47.7197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d8b85-12db-4214-393c-08de9eb8cca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999199

Due to CVE-2023-20585, the Event log buffer must use the maximum supported
size (512K) on Milan/Genoa (Family 0x19) systems when SNP is enabled,
to mitigate a potential security vulnerability. All other systems continue to
use the default Event log buffer size (8K).

Apply the errata fix by making the following changes:

* Introduce new global variable (amd_iommu_evtlog_size) to have event log
  buffer size. Adjust variable size for family 0x19.

* Since 'iommu_snp_enable()' must be called after the core IOMMU subsystem
  is initialized, it cannot be moved to the early init stage. The SNP errata
  must also be applied after the 'iommu_snp_enable()' check. Therefore,
  'alloc_event_buffer()' and 'iommu_enable_event_buffer()' are now called
  in the IOMMU_ENABLED state, after the errata is applied.

* Adjust alloc_event_buffer() and iommu_enable_event_buffer() to handle
  all IOMMU instances.

* Also rename EVT_* macros to make it more readable.

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
Cc: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  10 ++-
 drivers/iommu/amd/init.c            | 110 +++++++++++++++++++---------
 drivers/iommu/amd/iommu.c           |   2 +-
 4 files changed, 86 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1342e764a548..f1c486dcf0f3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -11,6 +11,8 @@
 
 #include "amd_iommu_types.h"
 
+extern int amd_iommu_evtlog_size;
+
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771436..c3430c09bc5c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/msi.h>
 #include <linux/list.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/iommufd.h>
@@ -141,7 +142,6 @@
 #define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
 
 /* event logging constants */
-#define EVENT_ENTRY_SIZE	0x10
 #define EVENT_TYPE_SHIFT	28
 #define EVENT_TYPE_MASK		0xf
 #define EVENT_TYPE_ILL_DEV	0x1
@@ -259,8 +259,12 @@
 #define MMIO_CMD_BUFFER_TAIL(x) FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
 
 /* constants for event buffer handling */
-#define EVT_BUFFER_SIZE		8192 /* 512 entries */
-#define EVT_LEN_MASK		(0x9ULL << 56)
+#define EVTLOG_ENTRY_SIZE	0x10
+#define EVTLOG_SIZE_SHIFT	56
+#define EVTLOG_SIZE_DEF		SZ_8K /* 512 entries */
+#define EVTLOG_LEN_MASK_DEF	(0x9ULL << EVTLOG_SIZE_SHIFT)
+#define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
+#define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
 /* Constants for PPR Log handling */
 #define PPR_LOG_ENTRIES		512
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39efb4..74effb847f48 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -132,6 +132,8 @@ struct ivhd_entry {
 	u8 uid;
 } __attribute__((packed));
 
+int amd_iommu_evtlog_size = EVTLOG_SIZE_DEF;
+
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
  * ranges for devices and regions that should be unity mapped.
@@ -864,35 +866,47 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
 }
 
 /* allocates the memory where the IOMMU will log its events to */
-static int __init alloc_event_buffer(struct amd_iommu *iommu)
+static int __init alloc_event_buffer(void)
 {
-	iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL,
-					      EVT_BUFFER_SIZE);
+	struct amd_iommu *iommu;
 
-	return iommu->evt_buf ? 0 : -ENOMEM;
+	for_each_iommu(iommu) {
+		iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL,
+						      amd_iommu_evtlog_size);
+		if (!iommu->evt_buf)
+			return -ENOMEM;
+	}
+
+	return 0;
 }
 
-static void iommu_enable_event_buffer(struct amd_iommu *iommu)
+static void iommu_enable_event_buffer(void)
 {
+	struct amd_iommu *iommu;
 	u64 entry;
 
-	BUG_ON(iommu->evt_buf == NULL);
+	for_each_iommu(iommu) {
+		BUG_ON(iommu->evt_buf == NULL);
 
-	if (!is_kdump_kernel()) {
-		/*
-		 * Event buffer is re-used for kdump kernel and setting
-		 * of MMIO register is not required.
-		 */
-		entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
-		memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
-			    &entry, sizeof(entry));
-	}
+		if (!is_kdump_kernel()) {
+			/*
+			 * Event buffer is re-used for kdump kernel and setting
+			 * of MMIO register is not required.
+			 */
+			entry = iommu_virt_to_phys(iommu->evt_buf);
+			entry |= (amd_iommu_evtlog_size == EVTLOG_SIZE_DEF) ?
+				EVTLOG_LEN_MASK_DEF : EVTLOG_LEN_MASK_MAX;
+
+			memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
+				    &entry, sizeof(entry));
+		}
 
-	/* set head and tail to zero manually */
-	writel(0x00, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
-	writel(0x00, iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
+		/* set head and tail to zero manually */
+		writel(0x00, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+		writel(0x00, iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
 
-	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
+		iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
+	}
 }
 
 /*
@@ -981,15 +995,20 @@ static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 	return 0;
 }
 
-static int __init remap_event_buffer(struct amd_iommu *iommu)
+static int __init remap_event_buffer(void)
 {
+	struct amd_iommu *iommu;
 	u64 paddr;
 
 	pr_info_once("Re-using event buffer from the previous kernel\n");
-	paddr = readq(iommu->mmio_base + MMIO_EVT_BUF_OFFSET) & PM_ADDR_MASK;
-	iommu->evt_buf = iommu_memremap(paddr, EVT_BUFFER_SIZE);
+	for_each_iommu(iommu) {
+		paddr = readq(iommu->mmio_base + MMIO_EVT_BUF_OFFSET) & PM_ADDR_MASK;
+		iommu->evt_buf = iommu_memremap(paddr, amd_iommu_evtlog_size);
+		if (!iommu->evt_buf)
+			return -ENOMEM;
+	}
 
-	return iommu->evt_buf ? 0 : -ENOMEM;
+	return 0;
 }
 
 static int __init remap_command_buffer(struct amd_iommu *iommu)
@@ -1041,10 +1060,6 @@ static int __init alloc_iommu_buffers(struct amd_iommu *iommu)
 		ret = remap_command_buffer(iommu);
 		if (ret)
 			return ret;
-
-		ret = remap_event_buffer(iommu);
-		if (ret)
-			return ret;
 	} else {
 		ret = alloc_cwwb_sem(iommu);
 		if (ret)
@@ -1053,10 +1068,6 @@ static int __init alloc_iommu_buffers(struct amd_iommu *iommu)
 		ret = alloc_command_buffer(iommu);
 		if (ret)
 			return ret;
-
-		ret = alloc_event_buffer(iommu);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
@@ -2890,7 +2901,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_init_flags(iommu);
 	iommu_set_device_table(iommu);
 	iommu_enable_command_buffer(iommu);
-	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
@@ -2954,7 +2964,6 @@ static void early_enable_iommus(void)
 			iommu_disable_event_buffer(iommu);
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
-			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
@@ -3067,6 +3076,7 @@ static void amd_iommu_resume(void *data)
 	for_each_iommu(iommu)
 		early_enable_iommu(iommu);
 
+	iommu_enable_event_buffer();
 	amd_iommu_enable_interrupts();
 }
 
@@ -3396,6 +3406,23 @@ static __init void iommu_snp_enable(void)
 #endif
 }
 
+static void amd_iommu_apply_erratum_snp(void)
+{
+#ifdef CONFIG_KVM_AMD_SEV
+	if (!amd_iommu_snp_en)
+		return;
+
+	/* Errata fix for Family 0x19 */
+	if (boot_cpu_data.x86 != 0x19)
+		return;
+
+	/* Set event log buffer size to max */
+	amd_iommu_evtlog_size = EVTLOG_SIZE_MAX;
+	pr_info("Applying erratum: Increase Event log size to 0x%x\n",
+		amd_iommu_evtlog_size);
+#endif
+}
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3432,6 +3459,21 @@ static int __init state_next(void)
 	case IOMMU_ENABLED:
 		register_syscore(&amd_iommu_syscore);
 		iommu_snp_enable();
+
+		amd_iommu_apply_erratum_snp();
+
+		/* Allocate/enable event log buffer */
+		if (is_kdump_kernel())
+			ret = remap_event_buffer();
+		else
+			ret = alloc_event_buffer();
+
+		if (ret) {
+			init_state = IOMMU_INIT_ERROR;
+			break;
+		}
+		iommu_enable_event_buffer();
+
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
 		break;
@@ -4034,7 +4076,7 @@ int amd_iommu_snp_disable(void)
 		return 0;
 
 	for_each_iommu(iommu) {
-		ret = iommu_make_shared(iommu->evt_buf, EVT_BUFFER_SIZE);
+		ret = iommu_make_shared(iommu->evt_buf, amd_iommu_evtlog_size);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f4623b5..02b5eaae6843 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1009,7 +1009,7 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 		iommu_print_event(iommu, iommu->evt_buf + head);
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + EVENT_ENTRY_SIZE) % EVT_BUFFER_SIZE;
+		head = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
 		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 	}
 
-- 
2.31.1

