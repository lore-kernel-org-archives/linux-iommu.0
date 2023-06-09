Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A244BE53
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 09:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6UTjlDOTDxuFRSsuKmb0nZAUKvF8sbsg82tPA8ghGY5h7Q2mtQW5XOfGqwFMfmGkVA+GGss7bfr5X3QrGD5nH0YiMt40qma5iltI196BhA6dDZSYjMP/PJbssJliaKQREFbQoNwdV2TTST39x5bwYuOy9PuqtbE7ygWfHKg50HV4XcbzxZex+mzotCmhNZ0A5TAqUdI4QT2DA5hBxHQDOCEfimKGl3eYY5KHgdoshYkgntzHj6lxLBiv656HeKorutnjO5nb5/KN66qigzO5FVPonZJqCeKYJLpC9l0JIYViyVx0f0dtcenU+3EEh06dpM1claHcqaPA8ncvzw8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuuFU4H4dGCRJDHy445uOZ2Dw/2+lxYKbeFCLGCiyWE=;
 b=jKzISb1DJ3UZRIu3+BMwb1JipsgQ0gchrAFefX9rCEG9JnHQIkE4y3y6MSRj+M3ccZ+FE+8mhdiRGDFBpWBRQuQE7zz1FpXD72rkwHs7pSogAmLgwOmJFHU0QELqXZWuHKVKUB7VXqfoMuOprUcBz9KyDvmlHGlRN390rbpB1PXj/qgf4+WOUIXjq8vWSdttlVEZDZUSRYG9GrlWlOS6Ubud0hAYtxZJ1/X0mFPVGOQ9Hi5FFHxkeFER9m//s+FJPVUZo0PlDAsBJ94bRkLFoArXGZacq4bjWtn2ck9N/qlYy9AQh0pklQjer01EAy09RZi0I8124D0IAPEWDoMBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuuFU4H4dGCRJDHy445uOZ2Dw/2+lxYKbeFCLGCiyWE=;
 b=hRSL8SrAaqUS9Q70Ga3nbsFK0xU46++C0URFzkaUQosiedDipTMHlEcft4sTofQb78agGA+LNLE1rN/eLO6T5lRjS9irchTijoVT7hvC5R9mzxQJ5zW2LsNcnwOz4s1CcRNmpZIH2V1gtbW3lEQ7wOovHdqQomJrE4InuVaPWa0=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 09:06:56 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::56) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 09:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 09:06:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 04:06:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/2] iommu/amd: Use BIT/BIT_ULL macro to define bit fields
Date: Fri, 9 Jun 2023 09:06:30 +0000
Message-ID: <20230609090631.6052-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b7e360-9152-4d8b-7ba8-08db68c8dfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HpAromDyKEGpPsdtFdMCMPc5s5hTv69BxdaGzCQJVIlrOXCMQ9tAkjP9NHN3z8DceCWbf/uVhrrku1tcwSgGpzKpkPISmRlNP4WGRLjJzx/NjwODlj6E0TfiOuwN0YgImd6AW6Vpaae4Ed2s987vm3FgINpXY/GLC2WVFOEeO3tltEqlmOjN8JckBZC6LC3GAR72DPBsmjSXn7YFPVH92eXZvAbUPttCwRS+6RrB35CD14lMc2HrnJqDjHWkJLk0ZENbH+jE++8XyBeAtIhL/88HI65mog5AnS7aM2v/lsQvL48SDZIcr4WQrARBbL5fgN/dLKfWAiJ9+ysvALYRQk51jGsjDXUPGRxSW/Avlkf8ACvmc8MRaeOh1aVQaMNPCJuDw6NXN9k5X1jQAQRQGZhxDddAG22iamkmBzGh53bwqEx0bxD8++fKQdWr4LQq8Aj/SyEoScbYaa5wZJLUV+lbU3WzJSNAP16eAeCAS8zacQ0w3OTz7FU3Jj7jcBNDWE0sevUE42sujvs7ZaqenHMCax1xwzXFG7oi+06TjM4FfiNf/Nk1K+xMSZrNv4d/Wh4+75BemtPdkHwhGX1jBFohyxGsAZjwfNRIdySKUIIrk/hi4FxiE0nhcGYDNiMDOOIC8RuIl1qcpGh9WJtfh7ZYiORos1Hy7wSR+i3B1cg5q38HK2+2yhwWC+6b5hs6BobKwjSgu9J9ywCT2gsR2hQelZ3ZXpbH8vNFOL8cpGXbcCgl9SeYB6deIgKyvq+nEYZWdNjpM8z5VarcfR8JhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(110136005)(54906003)(82740400003)(81166007)(478600001)(8936002)(8676002)(4326008)(316002)(70586007)(356005)(41300700001)(70206006)(2616005)(16526019)(186003)(36860700001)(83380400001)(6666004)(47076005)(7696005)(1076003)(26005)(426003)(5660300002)(336012)(86362001)(44832011)(82310400005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:06:56.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b7e360-9152-4d8b-7ba8-08db68c8dfe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284

Make use of BIT macro when defining bitfields which makes it easy to read.

No functional change intended.

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 76 ++++++++++++++---------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ae0edeb379d4..a49cc2258a76 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -84,21 +84,21 @@
 
 
 /* Extended Feature Bits */
-#define FEATURE_PREFETCH	(1ULL<<0)
-#define FEATURE_PPR		(1ULL<<1)
-#define FEATURE_X2APIC		(1ULL<<2)
-#define FEATURE_NX		(1ULL<<3)
-#define FEATURE_GT		(1ULL<<4)
-#define FEATURE_IA		(1ULL<<6)
-#define FEATURE_GA		(1ULL<<7)
-#define FEATURE_HE		(1ULL<<8)
-#define FEATURE_PC		(1ULL<<9)
+#define FEATURE_PREFETCH	BIT_ULL(0)
+#define FEATURE_PPR		BIT_ULL(1)
+#define FEATURE_X2APIC		BIT_ULL(2)
+#define FEATURE_NX		BIT_ULL(3)
+#define FEATURE_GT		BIT_ULL(4)
+#define FEATURE_IA		BIT_ULL(6)
+#define FEATURE_GA		BIT_ULL(7)
+#define FEATURE_HE		BIT_ULL(8)
+#define FEATURE_PC		BIT_ULL(9)
 #define FEATURE_GATS_SHIFT	(12)
 #define FEATURE_GATS_MASK	(3ULL)
-#define FEATURE_GAM_VAPIC	(1ULL<<21)
-#define FEATURE_GIOSUP		(1ULL<<48)
-#define FEATURE_EPHSUP		(1ULL<<50)
-#define FEATURE_SNP		(1ULL<<63)
+#define FEATURE_GAM_VAPIC	BIT_ULL(21)
+#define FEATURE_GIOSUP		BIT_ULL(48)
+#define FEATURE_EPHSUP		BIT_ULL(50)
+#define FEATURE_SNP		BIT_ULL(63)
 
 #define FEATURE_PASID_SHIFT	32
 #define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
@@ -120,13 +120,13 @@
 #define PASID_MASK		0x0000ffff
 
 /* MMIO status bits */
-#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	(1 << 0)
-#define MMIO_STATUS_EVT_INT_MASK	(1 << 1)
-#define MMIO_STATUS_COM_WAIT_INT_MASK	(1 << 2)
-#define MMIO_STATUS_PPR_INT_MASK	(1 << 6)
-#define MMIO_STATUS_GALOG_RUN_MASK	(1 << 8)
-#define MMIO_STATUS_GALOG_OVERFLOW_MASK	(1 << 9)
-#define MMIO_STATUS_GALOG_INT_MASK	(1 << 10)
+#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	BIT(0)
+#define MMIO_STATUS_EVT_INT_MASK		BIT(1)
+#define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
+#define MMIO_STATUS_PPR_INT_MASK		BIT(6)
+#define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
+#define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
+#define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
 
 /* event logging constants */
 #define EVENT_ENTRY_SIZE	0x10
@@ -369,23 +369,23 @@
 /*
  * Bit value definition for I/O PTE fields
  */
-#define IOMMU_PTE_PR (1ULL << 0)
-#define IOMMU_PTE_U  (1ULL << 59)
-#define IOMMU_PTE_FC (1ULL << 60)
-#define IOMMU_PTE_IR (1ULL << 61)
-#define IOMMU_PTE_IW (1ULL << 62)
+#define IOMMU_PTE_PR	BIT_ULL(0)
+#define IOMMU_PTE_U	BIT_ULL(59)
+#define IOMMU_PTE_FC	BIT_ULL(60)
+#define IOMMU_PTE_IR	BIT_ULL(61)
+#define IOMMU_PTE_IW	BIT_ULL(62)
 
 /*
  * Bit value definition for DTE fields
  */
-#define DTE_FLAG_V  (1ULL << 0)
-#define DTE_FLAG_TV (1ULL << 1)
-#define DTE_FLAG_IR (1ULL << 61)
-#define DTE_FLAG_IW (1ULL << 62)
-
-#define DTE_FLAG_IOTLB	(1ULL << 32)
-#define DTE_FLAG_GIOV	(1ULL << 54)
-#define DTE_FLAG_GV	(1ULL << 55)
+#define DTE_FLAG_V	BIT_ULL(0)
+#define DTE_FLAG_TV	BIT_ULL(1)
+#define DTE_FLAG_IR	BIT_ULL(61)
+#define DTE_FLAG_IW	BIT_ULL(62)
+
+#define DTE_FLAG_IOTLB	BIT_ULL(32)
+#define DTE_FLAG_GIOV	BIT_ULL(54)
+#define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
 #define DTE_GLX_MASK	(3)
@@ -439,13 +439,13 @@
 #define MAX_DOMAIN_ID 65536
 
 /* Protection domain flags */
-#define PD_DMA_OPS_MASK		(1UL << 0) /* domain used for dma_ops */
-#define PD_DEFAULT_MASK		(1UL << 1) /* domain is a default dma_ops
+#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
+#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
 					      domain for an IOMMU */
-#define PD_PASSTHROUGH_MASK	(1UL << 2) /* domain has no page
+#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
 					      translation */
-#define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
-#define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
+#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
+#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
 
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
-- 
2.31.1

