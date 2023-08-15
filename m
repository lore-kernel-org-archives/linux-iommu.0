Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84210788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afulK+dEHcfTHjr8BNbLyu03LGAleHaUob8vla1BI0ciJfkejtCCWkQhfWBODbO+68OLkhVqCZyLJYdnQVG+VtIBhyDCuuGbPYyOq6YM/cOYTdiIZ0K6R6d1rMhSmhYkVmsWPmhBgLDvFFv2+HPi4jpLL/Is2vHw/+OdmMJt/wQguxfw9ZwHzhzT3YpJqOxyeV6A+eKzRYHfajISEhV94TqIU4bWi4Vl7YP1wuUj24TZrYn11BYqOoivPKuz/X75yLb8R3FcIir9Z3KLggk50yEAnG3axRetqvg99yvnWQ1GwfmVbbqeQkE5hircgQjXnzvoowrJkODCJK11m9WOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2zrW5oRddmJCD0hcwsOnKzqv/ImVT0FJJXg8qKNaWg=;
 b=Y9MVAEDCGYlBsT6ggxP7sLJw8VZs6ffhf5cr9PREaNnh2sgyV8n7BH6uNDGzHuIqxNL/900gJoDfVufEETmVL+IthEszywQLJ3BFsv/xOn+zxlpYVtKAYFlfC+5ttabOnw/X9BIMomEIc2zhwMVHoiTFj28NvFn2QyoByt7fCC5ik3h/3PmX7W2HYpc7j9sQyRYO9tKNdKy4SGy0RwgX5KpGPqrFWzYiWOt6WO+l9kafVPXichoVBmTHj5eFLyeyKzDNosJUVkkiBEpPmn3/i50hLCZpQH0zrcq5bdvexk/C0soZCDAGxfXdvc2aM2kIyYxC2q6A+ShbbAhefJTDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2zrW5oRddmJCD0hcwsOnKzqv/ImVT0FJJXg8qKNaWg=;
 b=WHEufgFvhHK5D+BGcG06rXVOhaPC/NUjsmp1LCAO3QOE9igbWUu6+R74LpCznKahDhl6ypaG2NMce4IK54cRjhU6bbTacECTdE/C1Z/9RsrLiK2oS5YsYYmIuhKcKta84cE0jZKR2kx7kOn67OazTSzaBMiuY8vSkVx1RFxZvyg=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:24:45 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::96) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:24:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:24:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 08/14] iommu/amd: Consolidate feature detection and reporting logic
Date: Tue, 15 Aug 2023 10:21:56 +0000
Message-ID: <20230815102202.565012-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: b388eb5d-9120-4ccc-1438-08db9d79d8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MUVa8DiJg5d7mKNnf/+v5tgvWytOohszO4RGmjmxLmMz4N2G9ejD+Dr76B02AmT8tkDy68S7tKeFcWEQpDXNKUPwnBuX0F1RSGpgE1s7nuVLLaIcoRYcduXGad0RCzFwm4K+2oFOa38dLByOxFf0pI63eGB5gQcyiagOCOINME6K6wBOV6YpJTS8PyltL1tMUEf3fpTUsikl7WSBIlVosIBzMAirVvF5a7NO/gwF+ylaMNo4VAUrq5PNKBbdscPoslGpyLwClSkGlfzDoRoTO2UiF2jGxs1jJCm3TR1HG8RYNAyy3WU3DPxtkqi7VqSool5pmGYbEUhNwuKg8o2BjAJ34XHTHNQfpcxLMjIyQ4wB3Ghuj15+IV1MNY26tuaEeeo8CNdfSbm1UgsedL5e3jhYkKyehwfe9gVHIQNuW6XglNUOJMggjhmcyHP+mkITOntGmmfhNmpYb/b03gmQEc6SgGgEiUWd8fjZyvtuFGZy0UTBsZy7aNvSx48Zw3cH17p/6JsVTItIm7LvfSPQbCceRukGgWUTQ3t6A3zzmgUnzLv/jpPt4RRNi8HmBs3Mlu439Novw5u5kXsDamJ1ho38yJoAnsmVStaKPietxjEXi7jE1cu+W2ZC3PexoUuogB9c0kjVLXFwVIMU/DK2tPxPMCnZRu6lB/mOLHfZfgfV9xzKfkvAwXA1zOyIM99qv4tqyxXaPuidC+hu4nKlCwlipZrq73m8nNGKoI4y55WRGascKQIXftBtW7zoCYn86SCO6OS7V3Dg9X0GLJ/Bzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(1800799006)(186006)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(16526019)(26005)(1076003)(8936002)(336012)(41300700001)(8676002)(70206006)(70586007)(316002)(36860700001)(2616005)(47076005)(83380400001)(426003)(7696005)(81166007)(478600001)(40460700003)(40480700001)(110136005)(54906003)(6666004)(86362001)(4326008)(36756003)(82740400003)(356005)(5660300002)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:24:45.6505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b388eb5d-9120-4ccc-1438-08db9d79d8e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Currently, IOMMU driver assumes capabilities on all IOMMU instances to be
homogeneous. During early_amd_iommu_init(), the driver probes all IVHD
blocks and do sanity check to make sure that only features common among all
IOMMU instances are supported. This is tracked in the global amd_iommu_efr
and amd_iommu_efr2, which should be used whenever the driver need to check
hardware capabilities.

Therefore, introduce check_feature() and check_feature2(), and modify
the driver to adopt the new helper functions.

In addition, clean up the print_iommu_info() to avoid reporting redundant
EFR/EFR2 for each IOMMU instance.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 17 ++++--
 drivers/iommu/amd/amd_iommu_types.h |  4 ++
 drivers/iommu/amd/init.c            | 90 ++++++++++++-----------------
 drivers/iommu/amd/iommu.c           |  4 +-
 4 files changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6bf55de9fbeb..242e25ba2f93 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -90,9 +90,19 @@ static inline bool is_rd890_iommu(struct pci_dev *pdev)
 	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
 }
 
-static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
+static inline bool check_feature(u64 mask)
 {
-	return !!(iommu->features & mask);
+	return !!(amd_iommu_efr & mask);
+}
+
+static inline bool check_feature2(u64 mask)
+{
+	return !!(amd_iommu_efr2 & mask);
+}
+
+static inline int check_feature_gpt_level(void)
+{
+	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
 }
 
 static inline u64 iommu_virt_to_phys(void *vaddr)
@@ -148,8 +158,5 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode);
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
-extern u64 amd_iommu_efr;
-extern u64 amd_iommu_efr2;
-
 extern bool amd_iommu_snp_en;
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a8d264026f7f..22bdfb0ddfb7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -897,6 +897,10 @@ extern bool amd_iommu_force_isolation;
 /* Max levels of glxval supported */
 extern int amd_iommu_max_glx_val;
 
+/* Global EFR and EFR2 registers */
+extern u64 amd_iommu_efr;
+extern u64 amd_iommu_efr2;
+
 /*
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2b01dfde6cab..4399c0d139f1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -270,7 +270,7 @@ int amd_iommu_get_num_iommus(void)
  * Iterate through all the IOMMUs to get common EFR
  * masks among all IOMMUs and warn if found inconsistency.
  */
-static void get_global_efr(void)
+static __init void get_global_efr(void)
 {
 	struct amd_iommu *iommu;
 
@@ -302,16 +302,6 @@ static void get_global_efr(void)
 	pr_info("Using global IVHD EFR:%#llx, EFR2:%#llx\n", amd_iommu_efr, amd_iommu_efr2);
 }
 
-static bool check_feature_on_all_iommus(u64 mask)
-{
-	return !!(amd_iommu_efr & mask);
-}
-
-static inline int check_feature_gpt_level(void)
-{
-	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
-}
-
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
  * Default to IVHD EFR since it is available sooner
@@ -397,7 +387,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
 	u64 entry = start & PM_ADDR_MASK;
 
-	if (!check_feature_on_all_iommus(FEATURE_SNP))
+	if (!check_feature(FEATURE_SNP))
 		return;
 
 	/* Note:
@@ -867,7 +857,7 @@ static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 	void *buf = (void *)__get_free_pages(gfp, order);
 
 	if (buf &&
-	    check_feature_on_all_iommus(FEATURE_SNP) &&
+	    check_feature(FEATURE_SNP) &&
 	    set_memory_4k((unsigned long)buf, (1 << order))) {
 		free_pages((unsigned long)buf, order);
 		buf = NULL;
@@ -1046,7 +1036,7 @@ static void iommu_enable_xt(struct amd_iommu *iommu)
 
 static void iommu_enable_gt(struct amd_iommu *iommu)
 {
-	if (!iommu_feature(iommu, FEATURE_GT))
+	if (!check_feature(FEATURE_GT))
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
@@ -1985,7 +1975,7 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	u64 val;
 	struct pci_dev *pdev = iommu->dev;
 
-	if (!iommu_feature(iommu, FEATURE_PC))
+	if (!check_feature(FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
@@ -2012,8 +2002,8 @@ static ssize_t amd_iommu_show_features(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
-	return sysfs_emit(buf, "%llx:%llx\n", iommu->features2, iommu->features);
+	return sysfs_emit(buf, "EFR:%llx, EFR2:%llx\n",
+			  amd_iommu_efr, amd_iommu_efr2);
 }
 static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
 
@@ -2049,9 +2039,9 @@ static void __init late_iommu_features_init(struct amd_iommu *iommu)
 	features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
 	features2 = readq(iommu->mmio_base + MMIO_EXT_FEATURES2);
 
-	if (!iommu->features) {
-		iommu->features = features;
-		iommu->features2 = features2;
+	if (!amd_iommu_efr) {
+		amd_iommu_efr = features;
+		amd_iommu_efr2 = features2;
 		return;
 	}
 
@@ -2059,12 +2049,12 @@ static void __init late_iommu_features_init(struct amd_iommu *iommu)
 	 * Sanity check and warn if EFR values from
 	 * IVHD and MMIO conflict.
 	 */
-	if (features != iommu->features ||
-	    features2 != iommu->features2) {
+	if (features != amd_iommu_efr ||
+	    features2 != amd_iommu_efr2) {
 		pr_warn(FW_WARN
 			"EFR mismatch. Use IVHD EFR (%#llx : %#llx), EFR2 (%#llx : %#llx).\n",
-			features, iommu->features,
-			features2, iommu->features2);
+			features, amd_iommu_efr,
+			features2, amd_iommu_efr2);
 	}
 }
 
@@ -2090,12 +2080,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	late_iommu_features_init(iommu);
 
-	if (iommu_feature(iommu, FEATURE_GT)) {
+	if (check_feature(FEATURE_GT)) {
 		int glxval;
 		u32 max_pasid;
 		u64 pasmax;
 
-		pasmax = iommu->features & FEATURE_PASID_MASK;
+		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
 		pasmax >>= FEATURE_PASID_SHIFT;
 		max_pasid  = (1 << (pasmax + 1)) - 1;
 
@@ -2103,7 +2093,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
 
-		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
+		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
 
 		if (amd_iommu_max_glx_val == -1)
@@ -2112,13 +2102,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
 	}
 
-	if (iommu_feature(iommu, FEATURE_GT) &&
-	    iommu_feature(iommu, FEATURE_PPR)) {
+	if (check_feature(FEATURE_GT) &&
+	    check_feature(FEATURE_PPR)) {
 		iommu->is_iommu_v2   = true;
 		amd_iommu_v2_present = true;
 	}
 
-	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
+	if (check_feature(FEATURE_PPR) && alloc_ppr_log(iommu))
 		return -ENOMEM;
 
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
@@ -2130,8 +2120,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	init_iommu_perf_ctr(iommu);
 
 	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
-		if (!iommu_feature(iommu, FEATURE_GIOSUP) ||
-		    !iommu_feature(iommu, FEATURE_GT)) {
+		if (!check_feature(FEATURE_GIOSUP) ||
+		    !check_feature(FEATURE_GT)) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
 			amd_iommu_pgtable = AMD_IOMMU_V1;
 		}
@@ -2181,35 +2171,29 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 static void print_iommu_info(void)
 {
+	int i;
 	static const char * const feat_str[] = {
 		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
 		"IA", "GA", "HE", "PC"
 	};
-	struct amd_iommu *iommu;
-
-	for_each_iommu(iommu) {
-		struct pci_dev *pdev = iommu->dev;
-		int i;
-
-		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 
-		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pr_info("Extended features (%#llx, %#llx):", iommu->features, iommu->features2);
+	if (amd_iommu_efr) {
+		pr_info("Extended features (%#llx, %#llx):", amd_iommu_efr, amd_iommu_efr2);
 
-			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
-				if (iommu_feature(iommu, (1ULL << i)))
-					pr_cont(" %s", feat_str[i]);
-			}
+		for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
+			if (check_feature(1ULL << i))
+				pr_cont(" %s", feat_str[i]);
+		}
 
-			if (iommu->features & FEATURE_GAM_VAPIC)
-				pr_cont(" GA_vAPIC");
+		if (check_feature(FEATURE_GAM_VAPIC))
+			pr_cont(" GA_vAPIC");
 
-			if (iommu->features & FEATURE_SNP)
-				pr_cont(" SNP");
+		if (check_feature(FEATURE_SNP))
+			pr_cont(" SNP");
 
-			pr_cont("\n");
-		}
+		pr_cont("\n");
 	}
+
 	if (irq_remapping_enabled) {
 		pr_info("Interrupt remapping enabled\n");
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
@@ -2907,7 +2891,7 @@ static void enable_iommus_vapic(void)
 	}
 
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC)) {
+	    !check_feature(FEATURE_GAM_VAPIC)) {
 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
 		return;
 	}
@@ -3819,7 +3803,7 @@ int amd_iommu_snp_enable(void)
 		return -EINVAL;
 	}
 
-	amd_iommu_snp_en = check_feature_on_all_iommus(FEATURE_SNP);
+	amd_iommu_snp_en = check_feature(FEATURE_SNP);
 	if (!amd_iommu_snp_en)
 		return -EINVAL;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f8319214064d..896f78a3d79b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1295,7 +1295,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 
 void iommu_flush_all_caches(struct amd_iommu *iommu)
 {
-	if (iommu_feature(iommu, FEATURE_IA)) {
+	if (check_feature(FEATURE_IA)) {
 		amd_iommu_flush_all(iommu);
 	} else {
 		amd_iommu_flush_dte_all(iommu);
@@ -1639,7 +1639,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		flags |= DTE_FLAG_IOTLB;
 
 	if (ppr) {
-		if (iommu_feature(iommu, FEATURE_EPHSUP))
+		if (check_feature(FEATURE_EPHSUP))
 			pte_root |= 1ULL << DEV_ENTRY_PPR;
 	}
 
-- 
2.31.1

