Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4A56B9B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KNm/nI+B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqucSgv42CwcZDQrfDrCbALJIjhb1TkDln/rnUVQ0a0+YY/W4bMFD+KRElXA6qgEb2wa/BbX9By86OSUAOOmbNFeQ10NBk4a09I1WyOTWVdD1W2m3NY9wwfJORYNmLEtfu1Q7RGWpnl/u153IIuqw7Jz187ItbmMObrigP0o0Pp5BculNKsy6YX0JHABMKW1xXTiPDeYTDZ5bY2QgI0dfuo+4RydUm47owXnsMW0cVd4iND8vTFQGw9LdxSTv8Wjx6zh2fO1s1fpLwGy3vCzaYN5OOHGVEd4fZ5SdClEKtBaLbZM3CC+5LZlbqilhVNey7Vt1XMrAW4PogvbWv617Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zxd5ug39m0W+jXCnHqxIntKShSrfRcTSFC9eutSFZrU=;
 b=ZO/37DBV7X6IJkgLfSD07wN66fX5K/XpEtsEe8Y7gOTCwVTsC4DaiXQQDZg7jiSgRKHrPOfEJXN69gwC8Uzcl8rZ6P+0wInhp+mR3HqVM4KH/1g+qjnFy9MtZwoMRqnG+2mn8IIDwpMqrDaPUgeFS/UDSvNpVaPGSljn+wHa3ufq7xFf6A3g3FnUhiZEtUFqu9wyzgyvXoS8qzG3qvRLUmQLXztxes1QWOcoW69XAGlHXf+yBYq95osHAT6XOna8pDAx2TtHOcpe5PQLzkUjM1uXu0F2Vpvh8vpOrbZcql86OX3JpirU2ds7IKn2/bUmtdV2CNCHT1s31fAS+gFCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zxd5ug39m0W+jXCnHqxIntKShSrfRcTSFC9eutSFZrU=;
 b=KNm/nI+BJBx9gDdFecnyXjTHhJ6q2p1iNKbCLV0u/DTHYis+1qJwTN/RCrt/x08WAyRrbTQ+zHP+06qxbwJu+tkrwWKD3qxJh2qaAqvpJGvYs6xlGIj1htx2yBfcPXFFQacyjSQVaCaCGLPsk+I0VcxczIHfLQryebn3pgLhP/A=
Received: from DM6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:333::14)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:58:24 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::4c) by DM6PR03CA0081.outlook.office365.com
 (2603:10b6:5:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 08:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:58:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:57:59 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 13/16] iommu/amd: Refactor GCR3 table helper functions
Date: Tue, 12 Dec 2023 08:52:21 +0000
Message-ID: <20231212085224.6985-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bd9807-cd93-4508-c789-08dbfaf07f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ywI6KS5FVDeOdFTpJ+gOUSdXGmvUDhZFW+DUAisDgfkbZ3Zf4WDl5YbbUCjNeKM0A+USaiGUIawLqEwiZziXiCf9rdlDxdHop8TTwLXeWPvCFQJ7HSO/2GvQljtaZU7V6VWvwJsPdk185hOc+cRLsMPMc4n5Y17u6z+qMdqumJF0wQfwMqebJO6jrox4FrJruthnDQqLq/FnH3wvsnrT8iJUpTJvcWKHcVA+thpZFxE1zOzwtgWfzD/loV0XJOoE47tkMAfQid5EL94YPr/mOabUh0la2N0rkNhBmtFu5kSHus8Re6tI9WZS7DJTnhz5gy99MWcq06MVl3puOoVgvlmktpUSQuTOcYkeUANTS3erw+NvcVfXPjH377QX4j1BEeGtFMLfbUWJbgZjUCyKHH8TfKWWP7moKSZ1pCwaqI0SfbER9rEZ/suTPDTRZ/kkLb0+I2zxPw+MTOalHRgxFU+zpUE1Rl33qFgJnuRH2fGwcVXprVXHsvSLoEoVL5a3YQcyMCu9YPHld9kDBBlr8UTAUbapKTMaeOwyY+4e6+MLDD2TxEL8/7hwQo3zcduGWDAlpbWdfW54QLazvitTHvmWbrXD0jaPxLyqRB0sEQVq3PmKB0J8mshjJsLzZt48ZskPHGsGIl4HRPwUst5M81vrZACK/60PPe1oe6SpomK7cW4C8nssAGhH72Qu9qA8zVj/klhGZ7GA7/vKY9yTuCQMgKZ8R42juYBAklVixSgZUFHVMdyMuRZeUyZHmWzdmpDO17ntvJvpYo/sTxqEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(2616005)(1076003)(36756003)(7696005)(47076005)(478600001)(6666004)(110136005)(36860700001)(40460700003)(70206006)(54906003)(70586007)(8676002)(86362001)(4326008)(44832011)(316002)(356005)(82740400003)(81166007)(8936002)(40480700001)(336012)(426003)(83380400001)(26005)(16526019)(5660300002)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:58:24.0915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bd9807-cd93-4508-c789-08dbfaf07f92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
instead of GFP_ATOMIC for GCR3 table allocation. Also modify
set_dte_entry() to use new per device GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 55 +++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 584608b98f26..7e5f32817931 100644
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
@@ -1716,16 +1719,21 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 	}
 }
 
-static void free_gcr3_table(struct protection_domain *domain)
+static void free_gcr3_table(struct iommu_dev_data *dev_data)
 {
-	if (domain->glx == 2)
-		free_gcr3_tbl_level2(domain->gcr3_tbl);
-	else if (domain->glx == 1)
-		free_gcr3_tbl_level1(domain->gcr3_tbl);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
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
@@ -1744,22 +1752,23 @@ static int get_gcr3_levels(int pasids)
 	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
 }
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
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
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(dev_to_node(dev_data->dev),
+						 GFP_KERNEL);
+	if (gcr3_info->gcr3_tbl == NULL)
+		return -ENOMEM;
 
-	amd_iommu_domain_update(domain);
+	gcr3_info->glx = levels;
 
 	return 0;
 }
@@ -1875,6 +1884,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u16 domid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (domain_id_is_per_dev(domain))
 		domid = dev_data->domid;
@@ -1907,9 +1917,9 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
@@ -1937,7 +1947,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		/* GIOV is supported with V2 page table mode only */
+		if (pdom_is_v2_pgtbl_mode(domain))
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -2003,14 +2014,14 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		 * By default, setup GCR3 table to support MAX PASIDs
 		 * support by the IOMMU HW.
 		 */
-		ret = setup_gcr3_table(dev_data->domain, -1);
+		ret = setup_gcr3_table(dev_data, -1);
 		if (ret)
 			return ret;
 
 		ret = __set_gcr3(dev_data, 0,
 				 iommu_virt_to_phys(domain->iop.pgd));
 		if (ret) {
-			free_gcr3_table(dev_data->domain);
+			free_gcr3_table(dev_data);
 			return ret;
 		}
 	}
@@ -2034,7 +2045,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Clear GCR3 table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		__clear_gcr3(dev_data, 0);
-		free_gcr3_table(dev_data->domain);
+		free_gcr3_table(dev_data);
 	}
 
 	/* Update data structures */
-- 
2.31.1

