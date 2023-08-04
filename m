Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D81FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5WaIe1ZIalrGsT8yE42mqXaUJoXsPs1/GkEiHg4buP5Qdb3PYbfjkcrxO5j6S80RGPVFU8ieZW0Ka1CU5Vxq1JTPoj3AtPgL1slvru2ioqN9pp2GpLkwrmBSEMkmoV57u6LilXK+g1+K1UzhEcoOqEtYuA5Hf8/o+Xas7qvtFOp1YKAknfMQhJhDI0Nvv+tsYyMzIfzM6nTGRbUFaoObf7nVjoAo2aODkUB4qJsfReufHmTErzzWXsGsrKu9sXTEiYBRAsZdklgYHo+q/YbuJNKi1cwByPY9hZyg29F9LPnTkInZzz5z9Fo6qWrHPmtitrN8ACeWU7S4F/LuBGcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O52Fsk3Db+T0TKP6eTmdFi50IAgVCVvdscUzWzlnoFE=;
 b=bfiNnVWdPZuWeAgkeFzCDvOdsXXmE9wLDr9gKmQzW2JIDegPXN4a1PuQyhn78ipCw9IjxykMyrBEQpMdqwwmaQooknbRweijTctuZtZFfS/law4kxzPdtCSuabzu8h+DHELsxHC/StVZEzYufHYfQZd81X4DPauVwWWff9k3xq28C6XcV8pjEpm4QMkGDeebb3ItShZEhN89V198bP9QDFx8J1ocZrSEefRC4QYwzcKzecHkomlNJ9YmEOOL/kKaZVgcnO2fkP6rJwk89L+5zrMLygmfbWMb/HrKJABxpSSrtaY++N4VgngKzm5630nKRY81kTYHrLbKJt+v12PcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O52Fsk3Db+T0TKP6eTmdFi50IAgVCVvdscUzWzlnoFE=;
 b=iBonX+jdaKPdXM43WZ1OS0hbXqmZFTUDCkr2V5lVPViNfVXI9Q3zaiHrUIotMZD5ysjc72fM8sByKMHsDXJqvP+4WJb6fgjQMkh8yzBrV7t7nn3bIhaj47rTKC1TziMeEVo0hkpZFWDtsRHB1rzGo8C6LnN1LLV6CE1kHGTIJDE=
Received: from CYZPR11CA0006.namprd11.prod.outlook.com (2603:10b6:930:8d::10)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 06:45:48 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::3d) by CYZPR11CA0006.outlook.office365.com
 (2603:10b6:930:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:45:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:45:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR features
Date: Fri, 4 Aug 2023 06:42:10 +0000
Message-ID: <20230804064216.835544-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 704f8402-c0a9-4cb1-0491-08db94b66fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R4Q4vkFrJzB3kLkmjtzuzKpN+Afy2id3Gg8VdPCL9Fy1/WfDlJgPjPLWmXa9PRsxZF9l+iyxCDhEvT6vkMTrpvMtFQZXK1mbD5HzfpQnfJgXVOHFgxHwkctz/6WOHB5Slp/E66ypm+uqPyeHSZe9PUlnUL8dAWK6mHseNce+qWcnOedeFgo8dleGN0kNv57cJgLvHzVzMzKXDvC2Af8mmWUTTocWwFSINDnzQ62B8jkCy9l+0Rd7S/Y8U4YMMQI5uhm3gMdOIE5vogFOQIpP4gAAjhyY69GOTaflIsB6t8F/CJIrRsMwPmzQH9BKfhpnK/jKrqRcrsl7rfzxjvCwcgLdhj1RxKdZ9o37Fgr6FXOUTItIXqShN+0NABqWyMWD4vf4RYbQ04bmyXT1yc0vra3ve3LnVaXlbuDtEvCuBqtL6EMpjVEnW1zqh9291stH+JP965pMK9EgRwKx2Nr+Vn2XH7h6sP75pOg0UEjQJfhiINMuJwdFchsF8wSe3Gn0cZU5k//kvsnk07WVv4yP6p3W2cEmE4Nk5lW6PCGUG6JZaTy5lpk6rru8XE9RPpIem8+iKY9eK6JQ+vzmho4ZMtiCauOzwzxftp5vJHGo6nzANEbogvWVyjd+fVyOfPickDsLR1hMrEZUiOtl+cb1M1CVVBVFCuDexg5JvpwC+Osawx79NPdjKQ4Zg2/v+SaNlEoRY2dwli/1BPPOjd3/DDzUVVQFUkiO/WReLrrpr5CIBH7ARCoM/ljShNysKL99ZKXNFudR31O95GtmK6GkYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(1800799003)(451199021)(186006)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(2616005)(1076003)(8676002)(26005)(83380400001)(336012)(47076005)(2906002)(36860700001)(316002)(4326008)(70586007)(5660300002)(426003)(70206006)(44832011)(8936002)(41300700001)(6666004)(7696005)(110136005)(478600001)(40480700001)(54906003)(356005)(81166007)(36756003)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:45:47.9407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704f8402-c0a9-4cb1-0491-08db94b66fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270

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
index 22b38712b28b..e5b2dbf841c6 100644
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

