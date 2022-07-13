Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377715A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8BqCR6pTX1xn4vpPueMt0IncfJFJfCn/rxnbGmFzzVvmJUjViuiK23dGLjX0fAisW3cp0fMZ6KtQJPTyeoZou6WlsM2Spakj1sGi22QJjeyVSqcw5r2PQoCxpOTkt9YUvweXlEPDyS8eHCtT5TAy6Zcq/Plzo9KApAVs9MoAtig47fiL+HUQMqezAsQ7qrzMkWsLV5PtOqn9/2jI8i4w/eu1lM/5igXuHWrdqUddk7aYccypzeLiB6lQrZHa3FA+VJb5umLJbg5VPl5mglWg2BAVxMa36OMluOJffhnS/Gyv+5STfulhTYjRQllDqfOmxqZhr7kemxuElGXHMiTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slAYIuX/iA8/LJtjZKAILpTLJ9DghMkbTqy+A09xpn4=;
 b=BGEL68o5C/Huti/TDpDHAUMO3uNqOXYQKPJePnOKnWw1STGRHwKsIHG/SDiSKmeVKD/7WD21L7tO3FCqB33sET4jO5iRDzJMLl8HdIwtbeaV/FX9Wj3X41WTs/l0ZhKzCCwMKSyAk6SpMIAhk3mabuffrJil3awcpFRNsA5GCJbAB8W6Js4Phonun2cOwqu8siH0+hIz4Zhpu+NytoGpmJEg2MU5Uvj+O4iJ8AshuJymsVnxP6FNV8aXoRZNx/phxZ9qZNuZlIRIn/isBoFwNFnucvjfUrPorz+KjsG0SkV5JANTlfWuBHwGIOqPCzWZjkq0Jv4wo0/RJyztx6fdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slAYIuX/iA8/LJtjZKAILpTLJ9DghMkbTqy+A09xpn4=;
 b=CxDTDBV61CrY15Z/g0nFBt6Gza1aK595Vjh/MzU2/JkkxE6djPnK+bNnQj8k8wJKb9gXLZio7YUWcAtC/1pKX0AaIcmZ5UJKEPqIwMQIn1YiLgx4J1b9XRvBd/7k7dlBtVj2xmdeuXx/ppCOD/2rbwymErv4r8qSHVZi/aqxdF0=
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Wed, 13 Jul
 2022 05:32:39 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::55) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Wed, 13 Jul 2022 05:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 05:32:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 00:32:36 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 4/6] iommu/amd: Add support for Guest IO protection
Date: Wed, 13 Jul 2022 11:00:32 +0530
Message-ID: <20220713053034.12061-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713053034.12061-1-vasant.hegde@amd.com>
References: <20220713053034.12061-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c702e059-f12f-4271-8259-08da649119c4
X-MS-TrafficTypeDiagnostic: MW3PR12MB4491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FiR69cfPj8Gy6Bi0Mb06znXoNWCTk1tBx3ODr7r6zI6VvpaDZXyuti9YUeEXYCaxhRdovXpUWRoJVQWIjdJc5z775F0ABl2YXk1Uuy1hm8TzC7iVc50gV0wYH0KzxKVLUYUFAVjfZDMc4720ZNym8MnSoz149RaBGJuKE/atVG0bJ66n0o2g2PE52t0kKo7bY+d6KRb1n8y49pneyFs5C6OYdDlol3ymkKkRl2+lMQ+fmbEvOhOQhSl9K5EqNchlW9lqjugEQV76KYw8QaHax+Q5GfFe9Q3YVoaIdD8znFW0d9yrx2FMJKYeoyEHf7e1fNZv+xh14wCvk6/L4RVhOOHPubEK3NCROYca/K4CAvBjgK99Eu/L5G6lQQCW7HzNHz3ithM56Du7TDQOftwRoXts+NyikaSybv1U0f7v9PBGwnPIyhJI1tuCWl4olva0R8UFn//n5Cs2OUKpjE4kcLhOZw0W07FDe4WKiflqfVWvmcxq+FRqYTeOSBzQJshXNy7H1upRR5+3Xn8cpLXPsUQ2PaVErMcsVoCyuDWHuBfdu7oJDaEghYJE3UfaKaunzJMUuVOr6J4gSsFFcxksYANpkFTQezU84hBustIGVVWgSJkZUfoln4RRCNHhzgB0ps65nIw8/KsEzAUA8sbrRvG1IA3btY2IUilc1K8pZ4utGCaDPDGZwtufUtqFnzw7xLcQNzPPJR00aadovNUVwxaXWRQkfCEiO5YnmGcPfi5niV2j1oHIt78tQM8zDCrt5k5dztjFVRHiAiLCa1qBy3cBg5uHj2ew1tPNz9te1E19H0uc5KZzEfhvuaw/sn+h2nVEzrSVsnFbsQoWTmxSVn7to039n1LS/FpHdhQVlrU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(44832011)(40480700001)(82740400003)(7696005)(54906003)(110136005)(36860700001)(8936002)(26005)(2616005)(36756003)(40460700003)(41300700001)(86362001)(5660300002)(2906002)(70586007)(70206006)(4326008)(16526019)(81166007)(8676002)(316002)(1076003)(336012)(83380400001)(478600001)(6666004)(47076005)(356005)(426003)(82310400005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:32:39.1065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c702e059-f12f-4271-8259-08da649119c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU introduces support for Guest I/O protection where the request
from the I/O device without a PASID are treated as if they have PASID 0.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes in v2:
  - Added passthrough mode check
  - Added FEATURE_GT check

 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 13 +++++++++++++
 drivers/iommu/amd/iommu.c           |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a6d6a3c7c5f3..63bf521ba20c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,6 +93,7 @@
 #define FEATURE_HE		(1ULL<<8)
 #define FEATURE_PC		(1ULL<<9)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
+#define FEATURE_GIOSUP		(1ULL<<48)
 #define FEATURE_EPHSUP		(1ULL<<50)
 #define FEATURE_SNP		(1ULL<<63)
 
@@ -370,6 +371,7 @@
 #define DTE_FLAG_IW (1ULL << 62)
 
 #define DTE_FLAG_IOTLB	(1ULL << 32)
+#define DTE_FLAG_GIOV	(1ULL << 54)
 #define DTE_FLAG_GV	(1ULL << 55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
@@ -428,6 +430,7 @@
 #define PD_PASSTHROUGH_MASK	(1UL << 2) /* domain has no page
 					      translation */
 #define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
+#define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
 
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3c82d9c5f1c0..a2929d8b44f4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2026,6 +2026,17 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	init_iommu_perf_ctr(iommu);
 
+	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
+		if (!iommu_feature(iommu, FEATURE_GIOSUP) ||
+		    !iommu_feature(iommu, FEATURE_GT)) {
+			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		} else if (iommu_default_passthrough()) {
+			pr_warn("V2 page table doesn't support passthrough mode. Fallback to v1.\n");
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		}
+	}
+
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -2100,6 +2111,8 @@ static void print_iommu_info(void)
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
 			pr_info("X2APIC enabled\n");
 	}
+	if (amd_iommu_pgtable == AMD_IOMMU_V2)
+		pr_info("V2 page table enabled\n");
 }
 
 static int __init amd_iommu_init_pci(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 027ecd5fb4b2..2e67e6eecc31 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1553,6 +1553,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
+
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
@@ -1589,6 +1590,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
 		flags    |= tmp;
+
+		if (domain->flags & PD_GIOV_MASK)
+			pte_root |= DTE_FLAG_GIOV;
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-- 
2.31.1

