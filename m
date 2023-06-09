Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F414AA6
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOhdWVAybEg0+8oz4a/PHLxWKGB+2szGL8RAaYdm3SrwnpbEBK3bhhbc8i27Fp67c20PZiVr+Ll2DjH1i6BjU3A+fT77IRhM09qQI/Pn/w93OmFXfUUeod/ZS0Uc3KIhk5jG/P42G9qBJRczJtlfyC6HBg1wTTQJcB1vLLzv/ZWcNpZeEYo9ufCvDpNEKUYG889oCTDuGl7mzPw0GihXZGA30G2Xb7PrSFCx9aSR+BylGBUHd/TNQ12Bm6LOYiAFkJZCYO1zK5g47CGKFLtk17qrGrTDo93yDQhc96MS3JS8tUsFGfZUs1sErE40ODoSFMsZ77L4UARH5RV9sMrAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLIHBaCxneJIQa3Ep7iV+B7qQyraTy8/i0Kj/P8EyyI=;
 b=nAHoIixgB1JrQGgWyejflQsIk6dfHT+KgWJFZ2pMqm2jfAbcgy4cmiPNpP4uhPd5lcwj2KxSnlAJQatkE1D6Vt9/LxOzmjRpss+aT2xYczK8ZyBOdRdw0EMoZCSEOXwbXQjxjjdKheHVDa1QMPVLQsMnfTBzqxkND4qIpIY2i1qA6oOSWYWwn4GsLMgRUevIZpRUcD9HW744dakjogBYTD+762jMlaJ+BxYG2OYzWXYbEyj8iBDFa4NL4dwJHIoV1O/G5N/TZ+GQWZ0/Ir8zAvyQV5KCzwYJkZ7IIkuEf82omtl2r0luOSIvdbAaKU50/KvsfHUoo+KOQcmp9d900A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLIHBaCxneJIQa3Ep7iV+B7qQyraTy8/i0Kj/P8EyyI=;
 b=V3EuYupZ7CLtyunmcuEfBmh1Emc20Gyfz/US32k1DapNB2gCXLXXccD5SQtGnGe97iQ+OJA8l+iOmJ+VjHacn8Ufshx4lS1dK5ph3ong3XPtHesmS3O92hDadFEzwVFinemOYOI/17vKkKt9JC5glymqfbFoszYSrFvFVtVJUIM=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 10:21:14 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::6f) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.25 via Frontend Transport; Fri, 9 Jun 2023 10:21:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:21:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH 2/2] iommu/amd: Enable separate interrupt for PPR and GA log
Date: Fri, 9 Jun 2023 10:20:25 +0000
Message-ID: <20230609102025.6498-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a97108-5b01-4816-d676-08db68d34123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C6k/5THSDXramjlZXNE2g/XgGkwYdyEEuVzRYtJzs4WMSNFarJMybVJDOHLxdwhCgaDKc177cNi4LkI1iw/m6j+ki3eMStDTFlj9jwhK2cKspqwhujUKDpxCgnwbSLkQS0iEVokhL065z1UG4xka1b57zwZVbAVp67hC136QFRxLz47g5/DKGGbcnyotdNzW5CS2BLY+fRtFkSg9J1BgQslcB29c/KpNXK17OeBaG51YViAEEXCHsFWGVj/8Wid/iRFnCY0kdWk78UmcEsm3+HKZsP6E4AwHWZFTyG+N0iXuJWMjvp+1wUUG0oTUwlRZ4v3LDh3ynRriV+Frt9vfAZKRDplZezcQy7kE+rfpMq8nfD3WIyj59b/MQpFZjhI4g4m0qtfSk6LGaOWRLVXkqsyHAAR6PIy8zBxS2JZyA8m2h5zvmtNCs2hE7vXXDsI+pQmqn2fzqQiilo6fXXw7HeyBXr1S2pspGmfRs0MKiJSWo6dRQEZgkf1la9esHmLZ4+zd8FvHWE2fcGkrLakTTpPX7viAyZD0DWkLQQvyFoQmXPgn2g1ILwowZfJS/gaS89qFXtWFyfHk11kcTAub6bJD3Z2bU1WEu7qHi4PQoY0RoCEFgi/BhrFY84WWoRwjEmxTgpIeEr3YM1H6v9br4gTA+NhtQSxh9u6Mmq7bG2GC3boIBpqb/f+hQkWIHCV1ShGUnizYtjhe6DlLaZRE2/0SMH3A9B9SLnxxYzEVeuitBYQAU+/P6FqT/HXNoniIO+tWLe7ns2jTZ44H1w1Ufg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(5660300002)(8676002)(8936002)(36756003)(4326008)(6666004)(54906003)(110136005)(478600001)(40460700003)(316002)(41300700001)(7696005)(336012)(81166007)(356005)(44832011)(16526019)(1076003)(26005)(47076005)(186003)(82740400003)(426003)(83380400001)(2616005)(86362001)(36860700001)(82310400005)(2906002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:21:14.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a97108-5b01-4816-d676-08db68d34123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

AMD IOMMU supports separate interrupt for event, ppr and ga log. It has
separate interrupt control register for same. So far we were using
single interrupt to handle all three interrupts.

Add separate interrupt for event, ppr and ga log. `hwirq` is
set to INTCAPXT register offset. We will use hwirq to [un]mask irqs.

Also add support for irq naming. It will display proper name for irq
(AMD-Vi<X>-[Evt/PPR/GA]) instead of generic name (AMD-Vi).

Note that this patch changes interrupt handling only in IOMMU x2apic mode
(MMIO 0x18[IntCapXTEn]=1). In legacy mode it will continue to use single
MSI interrupt.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  9 ++++++
 drivers/iommu/amd/init.c            | 48 +++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a993e1bdb70b..65e18b590a54 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -704,12 +704,21 @@ struct amd_iommu {
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
index 9908cd4f1c31..a174426da088 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2331,6 +2331,7 @@ static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq
 		struct irq_data *irqd = irq_domain_get_irq_data(domain, i);
 
 		irqd->chip = &intcapxt_controller;
+		irqd->hwirq = info->hwirq;
 		irqd->chip_data = info->data;
 		__irq_set_handler(i, handle_edge_irq, 0, "edge");
 	}
@@ -2357,22 +2358,14 @@ static void intcapxt_unmask_irq(struct irq_data *irqd)
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
 
 
@@ -2435,7 +2428,8 @@ static struct irq_domain *iommu_get_irqdomain(void)
 	return iommu_irqdomain;
 }
 
-static int iommu_setup_intcapxt(struct amd_iommu *iommu)
+static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
+				  int hwirq, irq_handler_t thread_fn)
 {
 	struct irq_domain *domain;
 	struct irq_alloc_info info;
@@ -2449,6 +2443,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
 	info.data = iommu;
+	info.hwirq = hwirq;
 
 	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
 	if (irq < 0) {
@@ -2457,7 +2452,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	}
 
 	ret = request_threaded_irq(irq, amd_iommu_int_handler,
-				   amd_iommu_int_thread, 0, "AMD-Vi", iommu);
+				   thread_fn, 0, devname, iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
 		irq_domain_remove(domain);
@@ -2467,6 +2462,35 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
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
+	snprintf(iommu->ga_irq_name, sizeof(iommu->ga_irq_name),
+		 "AMD-Vi%d-GA", iommu->index);
+	ret = __iommu_setup_intcapxt(iommu, iommu->ga_irq_name,
+				     MMIO_INTCAPXT_GALOG_OFFSET,
+				     amd_iommu_int_thread_galog);
+
+	return ret;
+}
+
 static int iommu_init_irq(struct amd_iommu *iommu)
 {
 	int ret;
-- 
2.31.1

