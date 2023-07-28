Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688447494
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNX2/65wh7yAEaLiNhEdTp0qMQUUmayu2S4eopzxbIJZkqwHBdYESRQc6eGNji5VvIkjZS+qcIfQj3fciYwiokj+gWKG8UcMeFRJHKs7m4xzmYfbDcu665NjG/s9O9JZHi3b02D7BPddv/LlKLF1A9FfghOp1SZqFqOD81ZGpL9a3XcYNhtNMMmwuHPYF0B6ggzVP7jZbfmJDALSOh7cOD9AMfSsSWicNOUS1WSwfPz6ZmvaGnYxTZGqZ2gf8JyT1YG4HCUg1JgZm8GX/wyZ8SJi+g2vvF+S6ZzzfmMfWuHRxhs0tdHmetd15oj80h16fYxP6x1j0tfK2uoEgvgNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ0MRSGn8gBH9b8nVGT55uPXuSonCMkzWC2s3us/rJM=;
 b=OJd6BYWKlQ56yKqHbmGwzTSQ9Lu2/F08Fg7prZlXt9d6WaUkkq7PdDxXWUjwxcVEa+/QxI2Q5FKQiAKG/FlPyR6X90AJa9RJGh/BFAsU6ILEA7+KJbsU900+0l4c8OcVMD5K6d/Hgtug0poTiqY6K59NKWUBVtzv+yA5nNRZTmEzhzHSzmrgeAWQKkrVcv3RngquIDXAKNRZx1YQCf5Qt3ndFcHtqnxgrm2E/sQwbtKU7SqxcjtXfNZDhG+5PsCMG3zRyLB1zQjoGsee+LUd86zjoSNOIkwZBsAKKGhbqUize5DdHkbyxPhX15sI4BvR/h6HxRzP5ERds0csidI0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ0MRSGn8gBH9b8nVGT55uPXuSonCMkzWC2s3us/rJM=;
 b=m4kR08qXnaTeMlD3JiJeeHyfyUyaA0Z8pt9dvLInPjBSssULOdMKXA0o37cQjfHzzj0rzGDBA/orJNRmp3buZeeo5JjgbG7SHVrdjPFKDlwZeEoOxBKMrzKvGvrZPs4uMMkTMqv4QQsebLTeG+/IbzF7LzrKsHS40QggBKyj4UE=
Received: from BN0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:e8::33)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:39:24 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::5d) by BN0PR04CA0058.outlook.office365.com
 (2603:10b6:408:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:39:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:39:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 10/16] iommu/amd: Modify logic for checking GT and PPR features
Date: Fri, 28 Jul 2023 05:36:03 +0000
Message-ID: <20230728053609.165183-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: c27e0083-c080-4cf7-3e97-08db8f2d003f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1910eHW2bH716B96M0A5zjcvcdDLx27e91/TKmditD339xnjv5DBOfnzLBbnVlQH58iPUtzQbHq+KL5zTAcCiu5LBXp7GkWbV9bwM9BkF/W12KVQdpp+IT0U6BChrCQEQUn81Xxjmrg+XbVQzFYpZPvTb1vs6KoUjyzHs1/+FheknTAvZ2lYbPDp8j6GtTsjro+4ZZD8YL9t3xFkBIYZgAIPJ2VwQPlVVHopuErMSY/vDvwWZCa38/4lhewR8/ZgQuIPH+RAmxbN2F5Uz8YiflVC0cNDr9M7CgnP7+sFm4SWlw2/UBdKoAe3FkLf0xya4pXJSlahoPfiRNXLIp+zpv8QzO7jI8fqLqOJBgp72BIzi1mgbLV6zGZAV3iZ34B7qcGb/XJL7+Gk87I+fD3NjEn+rjISOwR0i0ndTsa49kLF+uTS5uGCOiRLMYvV0mzNBvfvP4isqBzd1iFaRRMNw/NPO7Hx/vIW4cuZMsPxnNbh0CnHoT9W3ovusvIygErwTy6eXf36py/RDeivj4iVkLxbehytqPFJ+lzcQshzYj6re3Xx91a4lZmdEkXt18UWFzQA2YAcGcBcb0XTnEovUxTShdhZZ8RKVuJudJz3B4Qih+UEOjaGzoFHCrW7P51HktvXv1Y4vN1jjCV0S7fZ2D1w5uC475UpqYkHR8p29/ANO1tA8IYtMBKJ7Hulz16M2ZKdydFRr7rypp32cmp2/Bp2+UoU2lKNnzmQ+FsNOqtC+c+mOi2ePyNLEVZCPDQtM3Z4qiMFWehgRZdow1iYog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(316002)(110136005)(81166007)(7696005)(356005)(6666004)(54906003)(478600001)(82740400003)(5660300002)(41300700001)(8676002)(70206006)(8936002)(4326008)(2616005)(70586007)(336012)(16526019)(36860700001)(83380400001)(26005)(1076003)(426003)(186003)(47076005)(86362001)(44832011)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:39:24.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27e0083-c080-4cf7-3e97-08db8f2d003f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In order to support v2 page table, IOMMU driver need to check if the
hardware can support Guest Translation (GT) and Peripheral Page Requet
(PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
features. There variables area redundant since we could simply just check
the global EFR mask.

Therefore, replace it with a helper function with appropriate name.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
 drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
 drivers/iommu/amd/init.c            | 14 +-------------
 drivers/iommu/amd/iommu.c           |  2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a5a350ee36fe..0605f02fa711 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -95,6 +95,17 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
 	return !!(iommu->features & mask);
 }
 
+static inline bool check_feature_on_all_iommus(u64 mask)
+{
+	return !!(amd_iommu_efr & mask);
+}
+
+static inline bool amd_iommu_gt_ppr_supported(void)
+{
+	return (check_feature_on_all_iommus(FEATURE_GT) &&
+		check_feature_on_all_iommus(FEATURE_PPR));
+}
+
 static inline u64 iommu_virt_to_phys(void *vaddr)
 {
 	return (u64)__sme_set(virt_to_phys(vaddr));
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 13c582a2454a..bbb5ac4f0d39 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -484,6 +484,10 @@ extern bool amdr_ivrs_remap_support;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+/* Global EFR and EFR2 registers */
+extern u64 amd_iommu_efr;
+extern u64 amd_iommu_efr2;
+
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
 #define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
@@ -679,9 +683,6 @@ struct amd_iommu {
 	/* Extended features 2 */
 	u64 features2;
 
-	/* IOMMUv2 */
-	bool is_iommu_v2;
-
 	/* PCI device id of the IOMMU device */
 	u16 devid;
 
@@ -890,8 +891,6 @@ extern unsigned long *amd_iommu_pd_alloc_bitmap;
 /* Smallest max PASID supported by any IOMMU in the system */
 extern u32 amd_iommu_max_pasid;
 
-extern bool amd_iommu_v2_present;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2b01dfde6cab..1f56478ae74e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -187,7 +187,6 @@ bool amd_iommu_iotlb_sup __read_mostly = true;
 
 u32 amd_iommu_max_pasid __read_mostly = ~0;
 
-bool amd_iommu_v2_present __read_mostly;
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -302,11 +301,6 @@ static void get_global_efr(void)
 	pr_info("Using global IVHD EFR:%#llx, EFR2:%#llx\n", amd_iommu_efr, amd_iommu_efr2);
 }
 
-static bool check_feature_on_all_iommus(u64 mask)
-{
-	return !!(amd_iommu_efr & mask);
-}
-
 static inline int check_feature_gpt_level(void)
 {
 	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
@@ -2112,12 +2106,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
 	}
 
-	if (iommu_feature(iommu, FEATURE_GT) &&
-	    iommu_feature(iommu, FEATURE_PPR)) {
-		iommu->is_iommu_v2   = true;
-		amd_iommu_v2_present = true;
-	}
-
 	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
 		return -ENOMEM;
 
@@ -3693,7 +3681,7 @@ bool amd_iommu_v2_supported(void)
 	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
 	 * setting up IOMMUv1 page table.
 	 */
-	return amd_iommu_v2_present && !amd_iommu_snp_en;
+	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a0b0deb6fbcb..1f707944b23f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -392,7 +392,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
 	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		dev_data->iommu_v2 = iommu->is_iommu_v2;
+		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
-- 
2.31.1

