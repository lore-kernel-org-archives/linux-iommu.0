Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EE100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvrHcywCE6IwPYv7khIY408w44hrsnc2hb/ShoYjfnP4f0wkHqXkXdETOXm5aEZdNR1j2wf1UnyW2WcXqlPd8yKdnDaxRZa6IzJbZPEiUrMlS/w+VDcFCNr1r9ANdDpsrWPgSuhcmM5HMpdaENwoW1/qSMO8WkBi4niY0lLdqAtpVwZAfgRMFD48FD5+fOmnj33ExE3iIPwQ8TCvV7q8sRGSAyzeAt+DQG2TyyWBOOsaHP2gNdWrSzfRmcDfSJqMhKgbJJFtBrUkZGXcXjaawYLPcatagZ0IRR+gItBF92DKPw6Xk0e3foPaZPSYEvZWXyt2qKXhthXMp77HLd71DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKwN0/KtGpLkH1adqjnD/HrgVpt+daQjzI2kVbRLl2E=;
 b=lqLBciWJ+3JewOqOmvmImiWL9Re/gDTRTaCkFNSnA4orBV+Tnu419QzN0EPWdZ1PnB1GfrsPzKS7iA40NmA0cHlj3jkZDtJ+rfXekTr4wrrGqf4Q4v9WrIOZFQYjNE+vYu8s0r9H65fplEOYTDyufXbI1Dixem6apwVLUrFH0xMmPu6VX5n+zuKB7AOLBJjSmStdtO6V/bEd23KpEMvltGzuy+HdXZ4j1nm4rTCbWcez/ZShodJRvSggqSYFDJti1g8Vb1ANc3D69mTNVl5sjkl0Gn0BnV1M3T21xTqzNLlNv1agx80DhxSaOzly5iRZCpPiSSppC5pf4rpaj63tiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKwN0/KtGpLkH1adqjnD/HrgVpt+daQjzI2kVbRLl2E=;
 b=cdoIBU+gOIpREBuQ+5pdx592+Hk2RkEFfEZx+WrOBNM+A2CFFNYpiGi1eO8drEDWb28AWAwM5cySi5YouYMA/CFgqj54mdNxY883iOmaHhnRvvamvNMvNRippqMXO7yhp5R8WyjD5SLM2j9WwjXWMG+2jpwRVHPmq4eVEdj6AZ0=
Received: from SJ0PR05CA0192.namprd05.prod.outlook.com (2603:10b6:a03:330::17)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.35; Wed, 12 Jul
 2023 14:18:25 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:330:cafe::42) by SJ0PR05CA0192.outlook.office365.com
 (2603:10b6:a03:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:18:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:18:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 10/21] iommu/amd: Modify logic for checking GT and PPR features
Date: Wed, 12 Jul 2023 14:15:05 +0000
Message-ID: <20230712141516.154144-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a549181-6fd2-4a74-cb4c-08db82e2daaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7GFcDftJHKo/SuEwLRbM4FUF7PIWfFKhutYrKMhTDvMxGrlEm8szZsug+zo7t5xiH2KNwcVjolXakiGyVU5s6ol1ZTmyTM7W2QUu/xAR3YaO265YJjcYmkwptPlcFSDR1AXF1JkA9P0CkxvnOW+gu4QqaUJxULNlbuxszejwbp1wl8DuV8fv1EIVOYxjFMGtK9unWyBCIKFCk9rajITnks4iO4wlGkYGWLUIDhyn7hwob93+mchzCIlvIihPJhwLjjtO10pQkfrCRlgIMKZzKXv/m2kVhO45IZ2b6n1sZGFeSIb2z1TvzncwJRMZRMUj1078013xLUAp6yX8k6fuRv1KFki3sppvccKnPuH/SSxxMOjRmUMVBXde2pZpLI6clAQ2J+nsCb2QWzu6SZCSucgd2qSOMMriXHRcS9KlZyhgKXk6DuJj/Yawx3oh4plKiGimPdCtjI7Ug5OIIr2BpSy719cs4hje4J/vc9bw8Fr7oaeJ5FKQMW0qsHH4afHwj5CxC4257K8M1RWiKmyBi5LJjodqLic3E13ssZ0nqeYg58OfJDKFtn2VAHjQZjqfmoVkQmbYfQz1LZw4pw+YhsoFtCgjctvs5QjcXkQPC5U8xo4s27jdipUiLkPDhP8z/cUT9zyoQr2HLaJIGVNrkU7SKr2QtTrB3t8ymqXylL0lgYrDUtVmm3mSM63ySWUhimWWLh+g5+mrAVG6KXtINxx8ruFSkoDvbRlPHVngK2mrHnxxnJfWmeSne1MQqzYN5jqyGXDVKKZ9P3zVZ9DpCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(8676002)(8936002)(54906003)(110136005)(7696005)(6666004)(40480700001)(2906002)(316002)(5660300002)(44832011)(4326008)(70206006)(70586007)(40460700003)(426003)(36756003)(478600001)(336012)(186003)(86362001)(82310400005)(16526019)(356005)(81166007)(47076005)(82740400003)(83380400001)(1076003)(2616005)(26005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:18:24.5121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a549181-6fd2-4a74-cb4c-08db82e2daaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In order to support v2 page table, IOMMU driver need to check if the
hardware can support Guest translation (GT) and Peripheral Page Requet
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
 drivers/iommu/amd/amd_iommu_types.h |  7 ++++---
 drivers/iommu/amd/init.c            | 14 +-------------
 drivers/iommu/amd/iommu.c           |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

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
index 1d3a35a460d0..346c32343417 100644
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
index c90d97762c33..982d5450595c 100644
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

