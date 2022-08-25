Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0F1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOu+Np5C4fC07MqZJe3Oh3OjoH62IsYg3Vh1qb+L3u6eVTx+9wcQmW0BlQbx696a87Q/ozTRZ1DXQJB7Ybqwn9SF5opxpI8BkwveqhaeCO7c30+Y/TtGqI7npjqAQTLhT9oCGC6iu/U2qZZhx4YidkyIJvT0s5ZOWjgRrmfx8YZbI+90J3ct831PVUj1MArTNrmRymKDYq2vQn7+iOFRIbT/PoiPQhCiXQD9JCX7vjMqM1S1J4IDBn4aije4ZMLUANXba/lzjZ5JMR6uiGZ4VS5GCC2+m/gIZLNVqvBMRwgOirS8bIYJKk2DDl8fyPFwZfCoQlAeDHm2re9NPICG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXePn/hWOzKQo0SfHLlV2dQKEbfC29ga8x9w4gCMeJk=;
 b=Yq/x3RceJmpjUiGZYrFwfDBDLH68V+n0ANM4u/EDJnYW1SKDxcR1HQ+hKX+EJHbyhLb+FHGq+LYfin7YXZFIcDEDXvwr6r+Dtq2OP7e9L7Q2eWu/KW5p0Fu4MTEaeK0qLtHGjd/C+bmlfLQzwq8uAftVUkWRbsnvNvNUWHWE7qKo8BfRSc2pSL9MpGKBUizsKzgN6TonzWbFD28T5qykhgO1DoWTJo5wpNPwmC0eV04tK6iBjaSxEFjWSq45JRbmF5rTSlw9aTo7QEDxlxAPn9KsE1ZoOiual/8pCT/2AWM0CFgEhWVSNYtn6nl7scerxsZsT0q4XTLwIty86CZLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXePn/hWOzKQo0SfHLlV2dQKEbfC29ga8x9w4gCMeJk=;
 b=NiyhPPK8SGRYbTRLGMoF+1UtHPClw2FD7ro19PsgEjNZQJJqe+BRbxgrvB78cnmQQCizZL0vOWygKKJhkvaOq+4abm4lVlkHIZu8OHOPmwpN7xv63OqGyHC30s/RGP9CWZRENXja0On2tJs+SoGWfFb651nVx3NHJqCLKaLYxtE=
Received: from DS7PR03CA0238.namprd03.prod.outlook.com (2603:10b6:5:3ba::33)
 by DM6PR12MB4844.namprd12.prod.outlook.com (2603:10b6:5:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 06:44:39 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::33) by DS7PR03CA0238.outlook.office365.com
 (2603:10b6:5:3ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 06:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:44:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:44:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 7/9] iommu/amd: Add support for Guest IO protection
Date: Thu, 25 Aug 2022 06:39:37 +0000
Message-ID: <20220825063939.8360-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0c35264-90b5-4f7b-f8bc-08da866548a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4844:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W6mipM+uxXmpyxIF5JyPJ2sLcPcZwERpn4asvNd8/Wtl/ylzwaYRXqpSPzWGfe2Ayx4ldWFqQ/2RDncgjzNao9nOHuOuMJbR0SComsGBZCE9rW7QsZ6PiqR8/gHK4Rtlox7hEqoCSeSFj41F5cE8zWVKlOlB7OCVM2Dh+4wm0Ji0WGrfJwxSAzZOfW5CXlpgbv6WbITmRvI9Y/KbXeM0PjLDuhj3+91uxVawUVyvrnQYlEWsDH3q9xHhhvELy0oIDEBm/qQjZA8QkvFJybW/WOngPU19D8cQ7tXbtO3roQutfrRbXWE49TnRgBahl0tQN4UVStap2mMeNnZ9WEgBfquTg9TJ3aj1hn/M0JO288Eh7O3oHa3CWoGDNINhq1N7/oXNyE5wN4U7wxcoOVEJJ454cs1K6YQi1FpPV2CqzGTsTseCDUijb9k4ZY8sdaB8WpKVPnB8NyJtHpiYX62YgCOaOBUEhOXH9WnSVuPe9LPglYpwPLJDBKvKogiuubdY4WZmSVtFlwwWP0qLBmA++U4hqVgYXrIJ2dW2EjVM0Eg0ZHEZor/34ux1CH9sQ3//bxxt+5eVw34bF9lDbiblmcoqiy7ARShKjW1PTfWZfTxwpbldchHPh0iDj2GDtUIgkGgnMeSkY09m3PNiq8luJQEju2e6myhk9lGsLa7b3X4SyYqf/aQkUM1QT9lpyeA9oCtDzlSflA2B5Kl+z9cOk+yh+6ohG1tCApVAdi6xi/KxTd8/GWvurv+x6itBBJmw/w9foj+iC6d8ShEZXb3UJyGBuxbKlAr+HK69LzMALsN8BuUSfEooP76V7kfX19sh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(86362001)(7696005)(47076005)(40460700003)(82310400005)(26005)(16526019)(8936002)(2906002)(186003)(478600001)(426003)(41300700001)(1076003)(336012)(356005)(44832011)(2616005)(5660300002)(70206006)(82740400003)(40480700001)(54906003)(8676002)(4326008)(81166007)(110136005)(70586007)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:44:39.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c35264-90b5-4f7b-f8bc-08da866548a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4844

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
 drivers/iommu/amd/iommu.c           |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4f94682c1350..3a6051f2e42e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -94,6 +94,7 @@
 #define FEATURE_HE		(1ULL<<8)
 #define FEATURE_PC		(1ULL<<9)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
+#define FEATURE_GIOSUP		(1ULL<<48)
 #define FEATURE_EPHSUP		(1ULL<<50)
 #define FEATURE_SNP		(1ULL<<63)
 
@@ -371,6 +372,7 @@
 #define DTE_FLAG_IW (1ULL << 62)
 
 #define DTE_FLAG_IOTLB	(1ULL << 32)
+#define DTE_FLAG_GIOV	(1ULL << 54)
 #define DTE_FLAG_GV	(1ULL << 55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DTE_GLX_SHIFT	(56)
@@ -429,6 +431,7 @@
 #define PD_PASSTHROUGH_MASK	(1UL << 2) /* domain has no page
 					      translation */
 #define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
+#define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
 
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d86496114ca5..2ed23fd16014 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2080,6 +2080,17 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
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
 
@@ -2160,6 +2171,8 @@ static void print_iommu_info(void)
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
 			pr_info("X2APIC enabled\n");
 	}
+	if (amd_iommu_pgtable == AMD_IOMMU_V2)
+		pr_info("V2 page table enabled\n");
 }
 
 static int __init amd_iommu_init_pci(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7d52ecea0298..95081a30ffe3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1597,6 +1597,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
 		flags    |= tmp;
+
+		if (domain->flags & PD_GIOV_MASK)
+			pte_root |= DTE_FLAG_GIOV;
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-- 
2.31.1

