Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDD1C6A1
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FqI84LKA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSKj3YXqC+OsBz1ec8ac10E/WRAYzO8fqk6jn1jCp/w7VKddeZW2v0gg2MF1WwMW4+Auzdkc7ZT2lbTrNSm7BaFEpMimISR6WjaALHGikxlI+pUrv4ujUAWRcgMH0CcZnKBozDX88XzoOgFv0xO4/VVoKxLQD1LREjX/f4s+6lZVfht8i6C7VH2QAaLYFXz1gEqf1z8f31fhbdCKZzeH7oFtiVbfZjB9jk0FHTDkeGsHUT2XQgqUao0si1HEPFrC0q6WrMW7lx0MRyTeHIHCXCap1kfym1DQ9iZUD9p82fPRt4OKrQUQfgSMt4grMypWramY2xmrO+s60+VBgTnE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwmoNaw033IGZJqwrwAhVQXoGdFXSc4Vq4EshJICCbI=;
 b=LupG+bjy4IiTi6sw236pXigjLdjYIwtzMZ31KonaGthKTQ3LYkd7tXjW2HlU4MTqjbucdRuBJKOa9rL8krSkr/0SmX10pdlXZIx+lWxobTOpVXJhAfPyzEK+3HmgQeBfJLNgpib2iiSP7YMaSWQCCI8EvPoqPguOZhIYhF+97lG243fM2zqBdafIUAJyiJWx6N2r1ukOXAQdYjlhemqgKAWwMYYqljrcWvnBKACWuHfiE87/X+Ulp4ShXbb88fI6U/+fVZXIeMLDhHwLX02YLB+wpqGRA5RSZ/GcnUMGQuuHFMwCXnzQBGy6O3GGXXXRrq1RiJq+zg0OSj7Vp2RsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwmoNaw033IGZJqwrwAhVQXoGdFXSc4Vq4EshJICCbI=;
 b=FqI84LKAC6tQ0XFU01d9Kbrs4gIOe3dVdNsXTPfzWDzaOfjNg2mRT7FGZ+ycfYX5AltDDexhvsrfSQuDsxsRmQvkumqZB6dgsqgySPkJ1d/IT7TETqB6yREZtGhRUvixTRYgcgcvmRUXSCdN3ECO3mLqF40aZ++eeBZd1byPDP0=
Received: from MN2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:d4::32)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 16:57:38 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::78) by MN2PR04CA0019.outlook.office365.com
 (2603:10b6:208:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:57:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:57:35 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Date: Tue, 16 Jan 2024 16:53:32 +0000
Message-ID: <20240116165335.6043-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: b6376bc6-b8f0-484d-4194-08dc16b43ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pJ3AZC04WnPW+H33NlT7NxlKzpjsGWjwimArZtF4FkkuQ+n5eS2YVYdRNMusy4WhiPA9xpVU+UWGYAkyw8s78JbOc9aZbo3rVEytx8M69s9ME+UtIxAU4xu8VG1tl29vTFJ9qX/VT+otRr6QTj9iO6bf69ReG3E8J8X2k/mNMEHGMy7qfwHpL6va8EwuPuBpbZqNRWTZqlJc7UTuDi7lRR8CN3cOn4r56iT1Ijc01TjOiKzbfFeL0T+AB9nyZw6y08K5mc/8WeXj4+MjxXTgkFr9ZLXj2MGA/RQXSPZ8uX3W0jFrQZ96wVX/dcrv7s9VvuZT1fLBL80rma8jpeS+5iwC1+hRrPHrvAHBb9UkocMqEi2gwunNIPE0BrDmlE5G8WyBK0mbA3VTQ2K0P3eshSSiHjv0wrev2JjGyE+3byvMdNFw5lOYD56JNuawD7UZhALLBj5QaPhrfjZyDQ7NnpsmYVKY1WJ+vEhtLX7uwbYGGRizluoAAL0N4gU8tfabNEZ59GmANYkgWI+EQWzs+1mBrFGcOa7AZ+x6FDJmblxpF2rUVe39EhhdfRy8LKc2nxugTqiJPtiqfez94FaZfSQbZDilbPF4qrBI8Mwp3Xa2Dt6ME/8J1L0v/7grcOXJfiEfvRQskVwfkUfS2o/Sm14ldJqCYT+V/fhY1ZRfe7bQNMZRtgKt2jKOxan/uMVutiH1ul33swMrzpZQIO2WSzfF+dfd9/LmFEPHFeLuOT7wCK89izH12wtDAul7Ke5SDJ6qV5mGuro7jgqHU0h6mw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2906002)(478600001)(6666004)(5660300002)(36860700001)(7696005)(356005)(4326008)(81166007)(36756003)(44832011)(426003)(83380400001)(26005)(41300700001)(70206006)(54906003)(47076005)(8936002)(86362001)(2616005)(70586007)(1076003)(8676002)(82740400003)(336012)(316002)(16526019)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:57:38.0826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6376bc6-b8f0-484d-4194-08dc16b43ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
instead of GFP_ATOMIC for GCR3 table allocation. Also modify
set_dte_entry() to use new per device GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 53 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b6b7b55c3682..4f7e0dc3a2f4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -79,6 +79,9 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data);
+
 /****************************************************************************
  *
  * Helper functions
@@ -1710,16 +1713,19 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 	}
 }
 
-static void free_gcr3_table(struct protection_domain *domain)
+static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 {
-	if (domain->glx == 2)
-		free_gcr3_tbl_level2(domain->gcr3_tbl);
-	else if (domain->glx == 1)
-		free_gcr3_tbl_level1(domain->gcr3_tbl);
+	if (gcr3_info->glx == 2)
+		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
+	else if (gcr3_info->glx == 1)
+		free_gcr3_tbl_level1(gcr3_info->gcr3_tbl);
 	else
-		BUG_ON(domain->glx != 0);
+		WARN_ON_ONCE(gcr3_info->glx != 0);
+
+	gcr3_info->glx = 0;
 
-	free_page((unsigned long)domain->gcr3_tbl);
+	free_page((unsigned long)gcr3_info->gcr3_tbl);
+	gcr3_info->gcr3_tbl = NULL;
 }
 
 /*
@@ -1738,22 +1744,22 @@ static int get_gcr3_levels(int pasids)
 	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
 }
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
+			    int nid, int pasids)
 {
 	int levels = get_gcr3_levels(pasids);
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
-		return -ENOMEM;
+	if (gcr3_info->gcr3_tbl)
+		return -EBUSY;
 
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
+	if (gcr3_info->gcr3_tbl == NULL)
+		return -ENOMEM;
 
-	amd_iommu_domain_update(domain);
+	gcr3_info->glx = levels;
 
 	return 0;
 }
@@ -1851,6 +1857,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u16 domid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (domain_id_is_per_dev(domain))
 		domid = dev_data->gcr3_info.domid;
@@ -1883,9 +1890,9 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (domain->dirty_tracking)
 		pte_root |= DTE_FLAG_HAD;
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
-		u64 glx  = domain->glx;
+	if (gcr3_info && gcr3_info->gcr3_tbl) {
+		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+		u64 glx  = gcr3_info->glx;
 		u64 tmp;
 
 		pte_root |= DTE_FLAG_GV;
@@ -1913,7 +1920,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		/* GIOV is supported with V2 page table mode only */
+		if (pdom_is_v2_pgtbl_mode(domain))
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -1974,14 +1982,15 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	/* Init GCR3 table and update device table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		/* By default, setup GCR3 table to support single PASID */
-		ret = setup_gcr3_table(dev_data->domain, 1);
+		ret = setup_gcr3_table(&dev_data->gcr3_info,
+				       dev_to_node(dev_data->dev), 1);
 		if (ret)
 			return ret;
 
 		ret = update_gcr3(dev_data, 0,
 				  iommu_virt_to_phys(domain->iop.pgd), true);
 		if (ret) {
-			free_gcr3_table(dev_data->domain);
+			free_gcr3_table(&dev_data->gcr3_info);
 			return ret;
 		}
 	}
@@ -2003,7 +2012,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Clear GCR3 table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		update_gcr3(dev_data, 0, 0, false);
-		free_gcr3_table(dev_data->domain);
+		free_gcr3_table(&dev_data->gcr3_info);
 	}
 
 	/* Update data structures */
-- 
2.31.1

