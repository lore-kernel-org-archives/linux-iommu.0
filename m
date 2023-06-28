Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BB33D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh5nRglQyRZjw9cA31kdjAo3jhLCV+Av+snvyJbA8a3raXDdWRm0cp0sOJgMfj/SK6ZefTclhCK5nvEikL+I3OoaOVdBFchRq/BseO3mxebSWnYqPBVn09R7aIDJ8k/3WV/a68eqTFifDuG+45QJiQVLaI4bs2Pd5KsPdsz5pZwgT7cIER+iNIRVBqVG9PLk6I8/2+vo5f9tjgizxKJ8b2rFC7Eo2+MSSpEYJZrx0uGKHlaivDoIGxASUxbZKSDpaY+mpDSXKT4owkziewCms2WiXun6d4HZledjiZ7dYar6CIv0DrU15H7HjkTCKKfvQNW3VqRzQ5otiPVFsJj7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHedAP8wSbIxHtv4NGKfhPphjuZYqKut4WLDVp0CT+M=;
 b=RhJNzgOj74h7a48zAiOhW4HyLBVGtSLZXTNFSL84vs5Iee64bqNDucsNefvEZtIQySUskZSZATtdhRUDFpABxTU30B5cORY15AJEs5P1BkiCgDWRdB8hfoRTPoBEtxGfkJrtpYjGQj2muzvuK7u/maxiktdbP3eJGwHqbjxYZSwRtB9S42O5BcGu0PDOeJAUzmIyjukLVIf+9gT3k/SrEi0dn7//V/KAXA+qVcXhm6ubf/HYedapc3v7WnnT6WiWGxf2+RKWM9VwrVIW/7QefrhGoub9Hlb8BymT1jMS56oUWCnZ+HtxINd/v9c+rImBqGuxw/OcaO2pepElt8kTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHedAP8wSbIxHtv4NGKfhPphjuZYqKut4WLDVp0CT+M=;
 b=RtHuYo0dN5Or4tEQbxo19xo+DsOLT4murd47Sh7zYW/CiB1J+x1r4pOJgWiOlMK6uAWsrLbnjxy0tE2Anm0UNqj/zKIHKRFAV0Eri5p2kGFbFKBxxvkySNMJ/cT6NWGczIyU3xxTW5kmbIGSi0Go+vnhQEPq3UFo+/1GU+s5DHs=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 05:33:12 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::64) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 05:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:33:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:33:09 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
	<jsnitsel@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>, "Alexey
 Kardashevskiy" <aik@amd.com>
Subject: [PATCH v3 2/2] iommu/amd: Enable separate interrupt for PPR and GA log
Date: Wed, 28 Jun 2023 05:32:22 +0000
Message-ID: <20230628053222.5962-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628053222.5962-1-vasant.hegde@amd.com>
References: <20230628053222.5962-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|SJ0PR12MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7e9aa3-af0c-4d38-bcf9-08db77992a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CY70R5+x/JoYpqJ7vkWOGGKgHqoyrNWZkqHComW0LZjmhZi6F2ImPlHRgJNhQv0p0vE+yjXyDCwI0mNcIfUYop+ZudNpXmtVajAznP//k/KEOgc2jdUy1yL46MBoP9FLYsUtD5yaJgD1V1wnhNXSOwU8bBusTWNPGM2edUVADpHP9/gKcF3jCalXa+FhyxQ/cCoITD4xr6J5Wora365Ci4Sd7TKl/0acQaDogfH+95xcqOokATHeqQFHNz0OZG/qST7GD3jELlvgylYeEMdE9APAGLsuGHzPh9I3Io/0INcgtWXVftPQ27O7VHE+TOWA+k/WN7SnNTz2ajnhz+oPco2Cs/dP2maNn2ZKsKBR8X0JwdkMBDju30PKZbO6U/DTWEuqP3yBid4FLHmMWnlq9ihtpk86w3VssFci6cyltHDztAP8YRGXFgEiVcL3ZqXZa58j0CGleyAkWLZe3UONnpio4xyoHhpFn9c+5qH42F+yemHNxtaAmSUYLn2QPBpn4ZBb/iqIFdoBvpU+U79WGEsNEFolTo6M98w1EXSd/pBGLhOLWSxImRnCZDsx3sMf8dz8SCLmSMSU2YQPYGsSLppap4PG9QE6+NQvi2n2zHb1Gob+ZEKf/aD0gPlc85QXA+4LKf9gHJZrCl4VlNggf3wMS5WYfHBaG3KsJ6kl2i9cG/XUHHKJeB9LvUZFXe3hGLa6cv+AdhbozAOyeK8kCw6KNsbi8q/Km7kEKeNllk8zYRpmw3jg80VFK/VNjAwWKICs9PpF+7ciXb+2DYHHag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(36756003)(40460700003)(70206006)(5660300002)(356005)(4326008)(8936002)(8676002)(86362001)(41300700001)(316002)(82740400003)(81166007)(70586007)(40480700001)(44832011)(47076005)(1076003)(186003)(16526019)(2906002)(426003)(26005)(7696005)(83380400001)(6666004)(54906003)(110136005)(478600001)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:33:12.2226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7e9aa3-af0c-4d38-bcf9-08db77992a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423

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

