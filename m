Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A98BE5
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnmCUSzKrOO/oygx7ihGfxskU5W9YO218WVFKys175UMyaRFPm0Q4x0Su8A8QliwrQqfZEqtjePC9MIv5gE1NJPOqjyUXUp678l0l7KMgieDKM0J08kQLSF9OGNFXIdL5X81BYltaGlFmpY7GOfsHbDMhsoSRSjXaTjQoyEPaUeOxRU0SiCjUGPCQ/qW+oUPKREQn78IPV1xsGBoQ2Y32wUNB1Y0LRVRqi7wjwUiuwe5aYBcgoHsU1AjkhqRXEkkzhosDldh+vsI+cjB1NbqxGg4aL5FRlmMEpU8kjlPsU3w3KmNgNNiIJeoiYBsXxynaBlMXj7osLcsN80Rn3A9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHedAP8wSbIxHtv4NGKfhPphjuZYqKut4WLDVp0CT+M=;
 b=lmyqlGXAHWcmWHY5ws63yY8FXRb3a9TsmRg3VDTPaORi4qUIYYbYJrShI+b8klNVsRfcv/HNyEs1zGqIs3QUd4DKYP1c/ekhHQjAVUWcgbIHYB8AXqTM/I2pgbLzDDWZcDQ6buYouLagKQ+iLjdxcmCXX3E33dtaDMNuU59fbbSMHeNvt/ak8FefzfwEfCoH88iAxyV7IJZXiPDKbHZlDzu3PDLfjclMKy2mgzlp0i66vN6pzEJrkRLZ9VKg6VBVaXNknS8D8M/cnYjMhdr+3YhG+RLJSioJl79AtCpGJ2At3NHHxLEL20O9DO0jsqQ2xobyg1c//+JUCRuTuG2OeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHedAP8wSbIxHtv4NGKfhPphjuZYqKut4WLDVp0CT+M=;
 b=NNyxgIJoxPwC9M9X6luNy40vFU224CWJ3G5KhKvCIIo2oO3FaIacupxtWGuxL8d+sa+LGn34VAYNFE1gdBWWKDVrkb6J73JY7MjGe8Xn2L+bY06I9HvPfqvGHMWXdB2OZvnTjrT1oiEJ+xtgM/PpffTr3UVzYKZVUHC0VoDRC8w=
Received: from CY5P221CA0094.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::19) by
 CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Mon, 19 Jun 2023 13:30:57 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::19) by CY5P221CA0094.outlook.office365.com
 (2603:10b6:930:9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 13:30:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:30:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH v2 2/2] iommu/amd: Enable separate interrupt for PPR and GA log
Date: Mon, 19 Jun 2023 13:30:08 +0000
Message-ID: <20230619133008.6221-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619133008.6221-1-vasant.hegde@amd.com>
References: <20230619133008.6221-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 648112c8-9b7e-409c-bd92-08db70c96a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GTEsFKHW6ZI5qmru42Pu0NR5ki7o93FDp6sxU8NHlpGLCikWSnHvh/Q0YWMmNPyn6jP/7OsBG4wOU3InlT4CC/UpjAqXzoDJpEIPkMHLLHYpl84RMPhhhBol9rMWLvs/nvJfXZPhnqrC2O9jY+sjvUAY+6KQOH7zIrsW7jswzI99dwBRLz5CoFWGqXjmeaJ+Dvi0sVN8gLKeaacKGyCL4Vb4FHf0M0dg/8XWOelsAFhcvNDQMrhmKewKlqRaqHqhDih22EGKbDqDtI6aMLK0xy4pKXqNSK+g9z981R4aqqMNfATEMre4Cevn/ohSyhT2hCXG4NaSma3cxeyxenK4wguTiIPJKA0qt77UEtbERsXBFa520W1nOT4D4UdxJQfp5fn/Q0biGE5UoYhHxBqH3SXSXEMaAGihNRjc7LxIbclPbj5bM7MDo7w8xjcwFj8BaUW6cKCtfDibaQS1kg0nZcCWzZQqHtZ4ZvptAjgLVblYZ8WmxXl+ydS5odCmkDPHaepidC0anSmpbGD/VqtuMxIsaeLS075j1JM8ZuVdP45N9hWxGZ+BDBJ/nKlT19D/rxkY4Hk2xytNhHgKfgqUmhgp5d0QnzBC2cQWlMEv8XANFg3S9zH/W6eCPz9TFe6WmFyl3LFYo4wSp/6zU6Lu531yFuLs8fQnE7223q2G0FB9pxIpgv6mald7HGvDvE56evUPxaegismIqCuSoNmgEROxjkTAXErP3FmfExtz3F39Asv/2qwaMyJ7pqviFgw3u5fG1QbDvhwqE6HNmJ111w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(186003)(70586007)(82310400005)(8936002)(70206006)(8676002)(16526019)(82740400003)(5660300002)(110136005)(54906003)(40460700003)(4326008)(6666004)(7696005)(316002)(478600001)(41300700001)(36756003)(26005)(1076003)(40480700001)(336012)(426003)(356005)(81166007)(47076005)(86362001)(83380400001)(44832011)(2906002)(36860700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:30:57.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648112c8-9b7e-409c-bd92-08db70c96a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

AMD IOMMU has three log buffers (i.e. Event, PPR, and GA). These logs can
be configured to generate different interrupts when an entry is inserted
into a log buffer.

However, current implementation share single interrupt to handle all three
logs. With increasing usages of the GA (for IOMMU AVIC) and PPR logs (for
IOMMUv2 APIs and SVA), interrupt sharing could potentially become
performance bottleneck.

Hence, separate IOMMU interrupt into use three separate vectors and irq
threads with corresponding name, which will be displayed in the
/proc/interrupts as "AMD-Vi<x>-[Evt/PPR/GA]", where "x" is an IOMMU id.

Note that this patch changes interrupt handling only in IOMMU x2apic mode
(MMIO 0x18[IntCapXTEn]=1). In legacy mode it will continue to use single
MSI interrupt.

Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
Reviewed-by: Alexey Kardashevskiy<aik@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  9 ++++++
 drivers/iommu/amd/init.c            | 50 ++++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2266badc6d0a..7011b746d38e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -705,12 +705,21 @@ struct amd_iommu {
 	/* event buffer virtual address */
 	u8 *evt_buf;
 
+	/* Name for event log interrupt */
+	unsigned char evt_irq_name[16];
+
 	/* Base of the PPR log, if present */
 	u8 *ppr_log;
 
+	/* Name for PPR log interrupt */
+	unsigned char ppr_irq_name[16];
+
 	/* Base of the GA log, if present */
 	u8 *ga_log;
 
+	/* Name for GA log interrupt */
+	unsigned char ga_irq_name[16];
+
 	/* Tail of the GA log, if present */
 	u8 *ga_log_tail;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e78d7c4f41bd..30f09e786f7b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2335,6 +2335,7 @@ static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq
 		struct irq_data *irqd = irq_domain_get_irq_data(domain, i);
 
 		irqd->chip = &intcapxt_controller;
+		irqd->hwirq = info->hwirq;
 		irqd->chip_data = info->data;
 		__irq_set_handler(i, handle_edge_irq, 0, "edge");
 	}
@@ -2361,22 +2362,14 @@ static void intcapxt_unmask_irq(struct irq_data *irqd)
 	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
 	xt.destid_24_31 = cfg->dest_apicid >> 24;
 
-	/**
-	 * Current IOMMU implementation uses the same IRQ for all
-	 * 3 IOMMU interrupts.
-	 */
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + irqd->hwirq);
 }
 
 static void intcapxt_mask_irq(struct irq_data *irqd)
 {
 	struct amd_iommu *iommu = irqd->chip_data;
 
-	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
-	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
-	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+	writeq(0, iommu->mmio_base + irqd->hwirq);
 }
 
 
@@ -2439,7 +2432,8 @@ static struct irq_domain *iommu_get_irqdomain(void)
 	return iommu_irqdomain;
 }
 
-static int iommu_setup_intcapxt(struct amd_iommu *iommu)
+static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
+				  int hwirq, irq_handler_t thread_fn)
 {
 	struct irq_domain *domain;
 	struct irq_alloc_info info;
@@ -2453,6 +2447,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
 	info.data = iommu;
+	info.hwirq = hwirq;
 
 	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
 	if (irq < 0) {
@@ -2461,7 +2456,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	}
 
 	ret = request_threaded_irq(irq, amd_iommu_int_handler,
-				   amd_iommu_int_thread, 0, "AMD-Vi", iommu);
+				   thread_fn, 0, devname, iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
 		irq_domain_remove(domain);
@@ -2471,6 +2466,37 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	return 0;
 }
 
+static int iommu_setup_intcapxt(struct amd_iommu *iommu)
+{
+	int ret;
+
+	snprintf(iommu->evt_irq_name, sizeof(iommu->evt_irq_name),
+		 "AMD-Vi%d-Evt", iommu->index);
+	ret = __iommu_setup_intcapxt(iommu, iommu->evt_irq_name,
+				     MMIO_INTCAPXT_EVT_OFFSET,
+				     amd_iommu_int_thread_evtlog);
+	if (ret)
+		return ret;
+
+	snprintf(iommu->ppr_irq_name, sizeof(iommu->ppr_irq_name),
+		 "AMD-Vi%d-PPR", iommu->index);
+	ret = __iommu_setup_intcapxt(iommu, iommu->ppr_irq_name,
+				     MMIO_INTCAPXT_PPR_OFFSET,
+				     amd_iommu_int_thread_pprlog);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_IRQ_REMAP
+	snprintf(iommu->ga_irq_name, sizeof(iommu->ga_irq_name),
+		 "AMD-Vi%d-GA", iommu->index);
+	ret = __iommu_setup_intcapxt(iommu, iommu->ga_irq_name,
+				     MMIO_INTCAPXT_GALOG_OFFSET,
+				     amd_iommu_int_thread_galog);
+#endif
+
+	return ret;
+}
+
 static int iommu_init_irq(struct amd_iommu *iommu)
 {
 	int ret;
-- 
2.31.1

