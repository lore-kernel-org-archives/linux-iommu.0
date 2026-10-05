Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5239368D5F
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182591; cv=fail; b=GYUo5HN14S0yjE7mjQCmOB9LnsgKhvje4xHwPed+1hw+L/LRgfkYha7SV2Nz0bIQ1kzLUElZO8Cnk39LLbzotrUCiVMKBnf8XT07cn3/lKznRakbi0UwNREHUPk28+xJhWg9grFfbKp1PcyQ3xd4cg0+VwW5UodTvObSDKQVWe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182591; c=relaxed/simple;
	bh=A35Y87jz8lgxteeWEFovL2YpoqVNvCFbnHN6DIZEiQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8Q7rMGqE+vb7gEVsBYcyf2loN82uGl4ZM54nRGPV1QGXKOs/3UpK4bQtSOsj+45UZUFdcNHCjLv9X/ZBW5aPkcCtFAAn/l0rcvaph8czCGZ1Oz4UoseMOYdOz/E0ISHRs6meY8X7+9i23rHQ+R4JgcgeIS0z0OyGR/86Ldvjsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l0EOom1V; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l0EOom1V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaKUhAT0M3Ee/iuZUeud/aGwcSXo80Pv76LK+CKdL9NB/lN9yTTCuimfuu0jmjA6q3j7wrr+4F0ij1rfIxjNvdnUSEk3UJx5h9MW6CGNp7lKEuYqc45l66xUehJvpMtrBODHWsbpFrEGfigwOGvwVlcTB+bUFPEJJ872QWiwjslYxxA93RYFqT/R99GEt2R76dJISZ4yxmabSkCcZ9eHmxP3l5meIofK53N8posUTfJOcCbDczPiPStqKwoL9BUyB2ihzIKZM9AZpQ2rc7HspHwER+9V+pe36jxDWE9ZRVd+G46mUEZ2qI7etZkH70OHExakyC2IFpnAyPyiLmURLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI2PAjoLEQgTfPxlNEIfcCzJJZGIKBEvr7BOp3PKmMA=;
 b=Eoxm5FCXXAFLOdMnh4S2mn/wfT7ppTr35bmd6fSIh2RvQErKguA5lFzQuE+MKxhjyaMdzKF4pBxxY+PwYeeK6RJifEsgauOHIecAJ4Dzd6FCUNpNg0tv+iGtN5H/mQo4vtBAAN/8BKoQjwM1c6l5dds2yny+/ZoDZdcFtx6W1QiGAdbkx/X2wgunL4ub8A0Ttpl590YnuDeFMyqAZ8FgVzUFaeUW0M/1YQuMwTybdVerW71A5jEWczYkjX8p5aNUkIAiT0x/etgwbp16erJ3N2yV7MQ69rpxc5HqZmNeU/nFVbMHnbPvom3dWhAFZypKGWZYkt+MFsrf+PNszFuVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI2PAjoLEQgTfPxlNEIfcCzJJZGIKBEvr7BOp3PKmMA=;
 b=l0EOom1VnKhrzaOXvSny9mcOtZm11O8yWydqFVDGSuOY/TAUkZBmBBH9Ut7ry+rQj2kif5b5tlnvEQpKJ1jyB1rm4nlrHOUkVDKfuDm+mBHXvoCYbYT5XBItY49dsdwbm1CaWjQapNJn3y/pTWX9fq28GBmWxtSPY0GUiBZ1wcQ=
Received: from SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::21)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:42:36 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::54) by SJ0P220CA0023.outlook.office365.com
 (2603:10b6:a03:41b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:42:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:42:35 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:42:27 -0500
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
Subject: [RFC PATCH 5/7] iommu/amd: clear unpreserved DTEs and quiesce logs at live-update shutdown
Date: Mon, 5 Oct 2026 06:40:15 +0000
Message-ID: <20261005064018.1558-6-Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: a025e71c-3a96-4689-1b9a-08df22abd76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|7416014|22082099003|18002099003|5023799004|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nEpBRqu1rASD1DTduy0z9hOVtm9zIOVcK7WXk33kIMeo7dpBRBMS+7VYP5KkTqSEp1WwmXJUAX6/enuuDylKDY+Hg3OpwRDDvy3v3FSTxEyZbBy8wrcIKe8o68GRYwqS/bQ4vunnLG06UhdVV3q+bjSUZL+JGOsf2CazA4nhMTAfA6fFPahznUVwFe9XjIynd0aW0UO0fSBy+yCvzjgJzgCUGMkgD3gyqYhVx+qTztn7UNmc+9jd77TxSeDoSGkjXVqXhvgoKaGzzxAca/hCBBz0Ipa0eT5iIsrQW82OTFLxA6gT+QRUgSmRJEFXBNwvtnrO+lfrpMAk3wLo1P2FO0qrOeSLsvyjM3Pp48C1vGzA9+W6gHuP1IzG1YTUqmo96ubmNfcEnCCDCbWk3vVUMZvxrrSu4A8Vv7vtTx6vuMZpMHC4nFjtAsdkpf8z2ZatmZp/Bh/h78hiOxO8bhDBi+LZbK9hsYuDf7MUBBpTq0FiPWGCpUDDp25OLL3NCU/TvSkjhrPvaynjow4NskDcYntFgc0Frg9YjRn6ILHPp9GCqlF3+UeQpkBNhlZ+1YUdKaJipxR7JKGDgVbs2wxGTTsOGY31AZpBxiW+bpQmsn/hc1dYLoxSw6+oJqiUjAoTFNmqYPBvuXWfMT0WjQVbe/GG0ZbWKFcHrjiAh7wq22vEGP5g5N1pg+h3jmptSJhTnaGtN8t5gsFaZkxVA6g4WQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(7416014)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nwZNJhhyd+UcFkue7VbN39xUW4cJ8q1UcX1xR4BwyldsbKMuI1erYo9C/m3xNket+AIaqqSgCPxxwNML6hnJM3TKTdXMdX5C3JOdYmC4BcR/5KCb4WfCXNqniWhHTOGPHY8iE88kgCL8xb647xbc15W8v+/i7L84c3bJr3D8og5B5DuXixE84zUsqCfuQbe4MNa6GiZeFw0dE3Dync9Xp8bMwG3PJhR8IkmE2OQzoYij3QWovlF5DSgdYNufVomZlotM7vhzpwFONMSql/Ey/7dbUelfBKaiWX1huhLKSpl6gM6zhyoTcBlM3jrcvcjK4hX9VYIA8z1cLkL1gmstgZJ1BliJR1SSDn8+l41f2VRzghcEfsC/IjsXk4G/Pc1ocVnNXYPAfkY9iVfVfOeaT2XzEWkc/kYy3cwng/VLF/mZgrHcuTiOAtHou6eRa3VT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:42:35.7600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a025e71c-3a96-4689-1b9a-08df22abd76e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687

Keep translation enabled on the units carrying preserved devices, but
block every device that was not preserved, so the next kernel cannot
translate through page tables it did not inherit.

Then stop the command, event, PPR and GA engines and wait for each to
report itself idle. Those buffers are not preserved, so an engine still
running would write into pages the next kernel is free to reuse.

If an engine does not go idle within the timeout, panic rather than
continue. Completing the handover would leave a running DMA engine
writing into pages the next kernel owns, and that corruption is both
silent and impossible to attribute later. Failing the live update is the
lesser harm.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  5 ++
 drivers/iommu/amd/init.c       | 88 +++++++++++++++++++++++++++++++++-
 drivers/iommu/amd/liveupdate.c | 83 ++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 5cf32e4898dc..4402724bfd06 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -236,5 +236,10 @@ int amd_iommu_preserve_device(struct device *dev,
 			      struct iommu_device_ser *device_ser);
 void amd_iommu_unpreserve_device(struct device *dev,
 				 struct iommu_device_ser *device_ser);
+void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu)
+{
+}
 #endif /* CONFIG_IOMMU_LIVEUPDATE */
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 40726dfef273..3b46d46f7143 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -32,6 +32,7 @@
 #include <asm/sev.h>
 
 #include <linux/crash_dump.h>
+#include <linux/iommu-liveupdate.h>
 
 #include "amd_iommu.h"
 #include "../irq_remapping.h"
@@ -3045,6 +3046,91 @@ static void disable_iommus(void)
 #endif
 }
 
+/*
+ * Bound the wait for a log engine to report itself idle. An engine only has
+ * to finish a write it has already started, which takes microseconds, so this
+ * is ample. It is deliberately far shorter than MMIO_STATUS_TIMEOUT because
+ * this runs on the live-update shutdown path, where any stall is downtime.
+ */
+#define LU_LOG_QUIESCE_RETRIES	10000		/* x 10us = 100ms */
+
+/*
+ * Clearing a log's enable bit only requests a stop; the engine may still be
+ * completing a write. Each log reports its real state in a separate "running"
+ * status bit, so wait for that to clear before handing over.
+ */
+static void wait_log_stopped(struct amd_iommu *iommu, u32 run_mask,
+			     const char *name)
+{
+	u32 status;
+	int i;
+
+	for (i = 0; i < LU_LOG_QUIESCE_RETRIES; ++i) {
+		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+		if (!(status & run_mask))
+			return;
+		udelay(10);
+	}
+
+	/*
+	 * The buffer is not preserved, so the next kernel is free to reuse
+	 * these pages. An engine still running here would keep writing into
+	 * them after the kexec, corrupting whatever the next kernel puts
+	 * there. That corruption is silent and unattributable, so refuse the
+	 * handover instead of completing one we cannot prove is safe.
+	 */
+	panic("AMD-Vi: IOMMU:%d %s log still running at handover; refusing to hand over a running DMA engine\n",
+	      iommu->index, name);
+}
+
+/*
+ * Stop the hardware writing event/PPR/GA logs and reading the command
+ * buffer, without turning translation off. Call after DTE cleanup: the
+ * cache flush still needs the command buffer. The next kernel allocates
+ * fresh buffers.
+ */
+static void amd_iommu_quiesce_logs(struct amd_iommu *iommu)
+{
+	/*
+	 * The completion wait at the end of amd_iommu_clear_unpreserved_dtes()
+	 * has already drained the command buffer, so there is nothing left for
+	 * the hardware to read.
+	 */
+	iommu_disable_command_buffer(iommu);
+
+	iommu_feature_disable(iommu, CONTROL_EVT_INT_EN);
+	iommu_disable_event_buffer(iommu);
+	wait_log_stopped(iommu, MMIO_STATUS_EVT_RUN_MASK, "event");
+
+	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
+	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
+	wait_log_stopped(iommu, MMIO_STATUS_GALOG_RUN_MASK, "GA");
+
+	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
+	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
+	iommu_feature_disable(iommu, CONTROL_PPR_EN);
+	wait_log_stopped(iommu, MMIO_STATUS_PPR_RUN_MASK, "PPR");
+}
+
+static void amd_iommu_shutdown(void)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		if (iommu_preserved_state(&iommu->iommu)) {
+			amd_iommu_clear_unpreserved_dtes(iommu);
+			amd_iommu_quiesce_logs(iommu);
+		} else {
+			iommu_disable(iommu);
+		}
+	}
+
+#ifdef CONFIG_IRQ_REMAP
+	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
+		amd_iommu_irq_ops.capability &= ~(1 << IRQ_POSTING_CAP);
+#endif
+}
+
 /*
  * Suspend/Resume support
  * disable suspend until real resume implemented
@@ -3500,7 +3586,7 @@ static int __init state_next(void)
 		break;
 	case IOMMU_ACPI_FINISHED:
 		early_enable_iommus();
-		x86_platform.iommu_shutdown = disable_iommus;
+		x86_platform.iommu_shutdown = amd_iommu_shutdown;
 		init_state = IOMMU_ENABLED;
 		break;
 	case IOMMU_ENABLED:
diff --git a/drivers/iommu/amd/liveupdate.c b/drivers/iommu/amd/liveupdate.c
index 096a23bb4e7b..a3a9ebea5138 100644
--- a/drivers/iommu/amd/liveupdate.c
+++ b/drivers/iommu/amd/liveupdate.c
@@ -279,3 +279,86 @@ void amd_iommu_unpreserve_device(struct device *dev,
 
 	unpreserve_gcr3_level(gcr3_info->gcr3_tbl, gcr3_info->glx);
 }
+
+/*
+ * Reset one non-preserved device's DTE to the blocked state during live-update
+ * shutdown. Every unpreserved device is reset so the next kernel starts from a
+ * clean slate for it and cannot translate through a domain whose page tables
+ * were not preserved.
+ */
+static int clear_unpreserved_dte(struct device *dev,
+				 struct iommu_device *iommu_dev, void *arg)
+{
+	struct amd_iommu *iommu = container_of(iommu_dev, struct amd_iommu,
+					       iommu);
+	struct dev_table_entry new = {};
+	struct iommu_dev_data *dev_data;
+
+	dev_data = dev_iommu_priv_get(dev);
+	if (!dev_data)
+		return 0;
+
+	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
+		return 0;
+
+	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
+
+	return 0;
+}
+
+static void clear_irq_dtes(struct amd_iommu *iommu)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u32 devid;
+	u64 dte2;
+
+	if (!amd_iommu_irq_remap)
+		return;
+
+	/*
+	 * Interrupt remapping tables are not preserved. Clear the interrupt
+	 * fields on every DTE so none still points at a table the next kernel
+	 * is free to recycle. DTE_DATA2_INTR_MASK is everything in data[2]
+	 * except the guest page-table level, which preserved devices still
+	 * need. The GCR3 pointer lives in data[0] and data[1], so it is not
+	 * affected.
+	 *
+	 * This must run after the clear_unpreserved_dte() pass, because
+	 * write_dte_upper128() deliberately copies DTE_DATA2_INTR_MASK back
+	 * from the old entry. Clearing a DTE therefore keeps its interrupt
+	 * fields, and only this walk removes them.
+	 *
+	 * The walk is by raw devid, so there is no iommu_dev_data to take
+	 * dte_lock on, and looking one up per entry would make this O(n^2).
+	 * Going without the lock is safe only because amd_iommu_shutdown()
+	 * runs from native_machine_shutdown(), after the other CPUs are
+	 * stopped and interrupts are off, so nothing can race these writes.
+	 */
+	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
+		dte2 = READ_ONCE(dev_table[devid].data[2]);
+		if (!(dte2 & DTE_IRQ_REMAP_ENABLE))
+			continue;
+
+		WRITE_ONCE(dev_table[devid].data[2],
+			   dte2 & ~DTE_DATA2_INTR_MASK);
+	}
+}
+
+/**
+ * amd_iommu_clear_unpreserved_dtes - Quiesce non-preserved devices at shutdown
+ * @iommu: The IOMMU whose device table is being cleaned up
+ */
+void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu)
+{
+	struct iommu_dev_iter iter = {
+		.fn = clear_unpreserved_dte,
+		.iommu = &iommu->iommu,
+	};
+
+	iommu_for_each_dev(&iter);
+	clear_irq_dtes(iommu);
+
+	amd_iommu_flush_all_caches(iommu);
+}
-- 
2.43.0

