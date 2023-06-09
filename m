Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0614AA6
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biJdGD22wfk8oypIj+4DOmyGJksNvmX1sudhUuw6NtxVK9uCC2+7+t1D2ZBW3QvcQ4sTQ3QKQU+1WBKFMHCxRiDkYjRsJ2LJr3zj3K8J+zaQ0/6//fRNqVr6/EM7syJQwi20foUNHAOsH1wba2jY9KvhPm/amwM1parG9IADhQIqeCInWKwqwFP/mCbViM0CMDqLgBoX9vuBKlb74fSOcYWW36dpAXB8FMptESdJgUqRs1PncrFpWbZ6dyBk1cfh9zKunrKZT5FHBaeHGKIb3sOO7ttBW2aAjm9tWUIIQsZCga13emcM474J3dlQvmFoYxu356HAR5uNSgXlgckvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD4Q0YYyNHALuqDaXXMxsCzlTyNrThNmthbYedbUUZ4=;
 b=Q19CYiHgqd2FwPfMUu7/YXxo1mSEkJW3guP0SCSwqyl055tDfVZ3QArTdqItTLNGP5in6tyz03VuE8WzqVZWmVBnWMWPiAFgFl9ojIXLfCAWEqwVMysIsApHl+rqCl4qVP924jXY+SwWP/PGz44YgXHk6w+Bobjt+SvWvEAgNd9lTLFPFkfsaae2X+Sxsv/vLinFnMBL+RK0Kmajxg2SwO4Y2LrLLUxYbFUgEnCXlXqdGzTgw8IU+DjN5Aoz+8QXiQtx6gHNuCtFg/F0Qfjj8IckOg1xx/opJeHdo2LH85GUpS6m1lmIboibzivoem3iMrazHI64lae+j7yDxIbC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD4Q0YYyNHALuqDaXXMxsCzlTyNrThNmthbYedbUUZ4=;
 b=EHnKwQwRrPVHMOfin7rqiXPc3aXWhpN9StLeAZtG3wF4bpuq8M2nMtCKX3K6Pg0nZbl6f9J5H302FRyp2y7XSulpGtU+Z2vFHMUwoDPKbMC1xEKiQ3zz5QV1HEb/M/ACq8IB54426AM6CKHdAcmGupQQi8qdbIGt/wkH+PQZR7s=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 9 Jun
 2023 10:20:59 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::d9) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28 via Frontend
 Transport; Fri, 9 Jun 2023 10:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.25 via Frontend Transport; Fri, 9 Jun 2023 10:20:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:20:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 1/2] iommu/amd: Add separate interrupt handler for PPR and GA log
Date: Fri, 9 Jun 2023 10:20:24 +0000
Message-ID: <20230609102025.6498-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609102025.6498-1-vasant.hegde@amd.com>
References: <20230609102025.6498-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 357860f9-e0f8-4b8f-a6a8-08db68d3382b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mm7wMgsmZnJ3d23xYGMW6Ur6vjpSOYEfrpPf1H3OsC8kpM5zq7lasKHGu62YvcIhEuFGwwwtJFiERdKDP5+yW73K7fPeFK8QSGEhcOO6iGd4MIAgKnr/nRXRr1psHyJaQTAQxGydTvV0VmEgIh5Q0EjFaPuZpqMR0sxOUQgW4lqguwyf85wno/lseJsJsZ9V5h3X2+MrdYenL3sCGGgLz0NvGog/Uo7WDAfos/GyuITmNIVZ1aXExn12azwiBwzQL/gX3Zp8wcHKo5FShtRYDrt5qEEb+avK1WPWKwSZWhCmtsiJYQaVHfyMuFMrLwuW7+Oj6Qm5xzHxhp4fYG8zUxbM2PEgzc/se3SHZTp1e9bMBWRPUzadte8L/NFDprLqGmf4/ac1MVFWUVuRLXPXqwOEbm8vpOi29TSYX89YrvndEqwvWMYEKVrUc8dSikB+29xyeAmZjhwmmLZezO/uwhINDLAIJ9L9FiR/KApMgnzvH+EF9rSYsvjS/kteiYNQ0Yj/oSgEZRkEmt4oCvJU8j/Tj0Kpx0SA6xDkMdgjY+WsDBJomKvHgCOPdymH2zlN3sXxXxWo5VBcIgmaWLiV5GOgquOr9nFxo9nXJ+QA4gviBYYqjKNmkjbkAIklJCAcFzYPBtcLLDSmLR4Q7wHVj+84Z4Gk/Z1ULilkxOziXRpkGFaGrM+A6azGOepGMMKHuDXsbf4lJuDoceP3c2SrDnrMkheg1l0d73ge/HyftgMM0sr4c8NtK19zEFZ0Nl2SdUwbPzdsWkcpoKX5CQHNkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(336012)(41300700001)(47076005)(36756003)(356005)(82740400003)(83380400001)(81166007)(426003)(36860700001)(316002)(82310400005)(186003)(70586007)(26005)(70206006)(16526019)(1076003)(4326008)(2616005)(6666004)(478600001)(40460700003)(54906003)(2906002)(44832011)(7696005)(40480700001)(110136005)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:20:59.0017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357860f9-e0f8-4b8f-a6a8-08db68d3382b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

The AMD IOMMU has three different logs (Event, PPR and GA) and it can be
configured to send separate interrupt for each log type.
  - Event log is used whenever IOMMU reports events like IO_PAGE_FAULT,
    TLB_INV_TIMEOUT, etc,. During normal system operation this log is not
    used actively.

  - GA log is used to record device interrupt requests that could not be
    immediately delivered to the target virtual processor due the fact the
    target was not running. This is actively used when we do device
    passthrough to AVIC enabled guest.

  - PPR log is used to service the page fault request from device in Shared
    Virtual Addressing (SVA) mode where page table is shared by CPU and
    device. In this mode it will generate PPR interrupt frequently.

Currently we have single interrupt to handle all three logs. GA log and
PPR log usage is increasing. Hence, split interrupt handler thread
into three separate interrupt handler function. Following patch enables
separate interrupt for PPR and GA Log.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++
 drivers/iommu/amd/iommu.c     | 98 +++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 156f57b4f78c..e2857109e966 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -12,6 +12,9 @@
 #include "amd_iommu_types.h"
 
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
+irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
+irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
+irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3c179d548ecd..d427f7e3b869 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -841,57 +841,23 @@ static inline void
 amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 #endif /* !CONFIG_IRQ_REMAP */
 
-#define AMD_IOMMU_INT_MASK	\
-	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
-	 MMIO_STATUS_EVT_INT_MASK | \
-	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
-	 MMIO_STATUS_PPR_INT_MASK | \
-	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
-	 MMIO_STATUS_GALOG_INT_MASK)
-
-irqreturn_t amd_iommu_int_thread(int irq, void *data)
+static void amd_iommu_handle_irq(void *data, u32 int_mask, u32 overflow_mask,
+				 void (*int_handler)(struct amd_iommu *),
+				 void (*overflow_handler)(struct amd_iommu *))
 {
 	struct amd_iommu *iommu = (struct amd_iommu *) data;
 	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	u32 mask = int_mask | overflow_mask;
 
-	while (status & AMD_IOMMU_INT_MASK) {
+	while (status & mask) {
 		/* Enable interrupt sources again */
-		writel(AMD_IOMMU_INT_MASK,
-			iommu->mmio_base + MMIO_STATUS_OFFSET);
-
-		if (status & MMIO_STATUS_EVT_INT_MASK) {
-			pr_devel("Processing IOMMU Event Log\n");
-			iommu_poll_events(iommu);
-		}
-
-		if (status & (MMIO_STATUS_PPR_INT_MASK |
-			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
-			pr_devel("Processing IOMMU PPR Log\n");
-			iommu_poll_ppr_log(iommu);
-		}
+		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU PPR log overflow\n");
-			amd_iommu_restart_ppr_log(iommu);
-		}
+		if (int_handler)
+			int_handler(iommu);
 
-#ifdef CONFIG_IRQ_REMAP
-		if (status & (MMIO_STATUS_GALOG_INT_MASK |
-			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
-			pr_devel("Processing IOMMU GA Log\n");
-			iommu_poll_ga_log(iommu);
-		}
-
-		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU GA Log overflow\n");
-			amd_iommu_restart_ga_log(iommu);
-		}
-#endif
-
-		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU event log overflow\n");
-			amd_iommu_restart_event_logging(iommu);
-		}
+		if ((status & overflow_mask) && overflow_handler)
+			overflow_handler(iommu);
 
 		/*
 		 * Hardware bug: ERBT1312
@@ -908,6 +874,50 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		 */
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 	}
+}
+
+irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
+{
+	pr_devel("Processing IOMMU Event Log\n");
+	amd_iommu_handle_irq(data, MMIO_STATUS_EVT_INT_MASK,
+			     MMIO_STATUS_EVT_OVERFLOW_MASK,
+			     iommu_poll_events, amd_iommu_restart_event_logging);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
+{
+	pr_devel("Processing IOMMU PPR Log\n");
+	amd_iommu_handle_irq(data, MMIO_STATUS_PPR_INT_MASK,
+			     MMIO_STATUS_PPR_OVERFLOW_MASK,
+			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
+{
+
+	pr_devel("Processing IOMMU GA Log\n");
+#ifdef CONFIG_IRQ_REMAP
+	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
+			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
+			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
+#else
+	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
+			     MMIO_STATUS_GALOG_OVERFLOW_MASK, NULL, NULL);
+#endif
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread(int irq, void *data)
+{
+	amd_iommu_int_thread_evtlog(irq, data);
+	amd_iommu_int_thread_pprlog(irq, data);
+	amd_iommu_int_thread_galog(irq, data);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.31.1

