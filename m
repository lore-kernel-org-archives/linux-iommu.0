Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075C1B272
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ds6GwcZX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnwF6Sntmy5EVVlpeIxWDU7wzr3ZyPvZIPMiQZ8qZtd67iknx8h8DMagjfjxCjmOaRtFY8gqS6yVWt7khRkjlOdOO2sPpN+9QuawiEKtUlifMCk5gCTGFfxoQyQzcmjm41qqzN9OkHGLudQvUFPVhUJtRPBe5s2x7QvIWmRcBKGmmwwGC4CpKBaiNRKOOMBSgQPZOYSFx0WMfcaD/ndiQxJzL0Y13krvUHE2eXaNt3cqL8OiXS/L32LanyvIHKIfcQoehMtlQHapsudFZnCRtlAIbFwWpamPAh7M23plycFB/my4pMwHu++HKAz0ST4At5e0ZOp7y3P8rJBfA/eRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySMUP8OlZzuR5E8GyqMXgX1bUFVppG/WPO+E+Mn78/s=;
 b=O0qUotYp+oop8J31GIK6Cvx3N9iV8aLEj01wHr38G9Sd46d4REi5x/7eLXm6A3AyQTfPbN/dp5pSjb14AG4hymg2ew2brUX8h7lwW9RvdgzVHxYH+AuBHI5cobl8WmJxwrHuCBtWwYU9tVvQ0F/tNe7lgAqi3eG7MTHQuYttfGxSjOmjq7e0GmatykIBBLmJO+zKzwBJEz69jzWCkar6sTgGDoZAEz18t1jEdZ5FTOk2OFubuToItfmn9RzsXOwR5SP1gMsZIMhis3gxFBrxE9ZkCjtJh7lh1AnkoLPV7/SkKOWUXho3V5x2oXMLtec7g89LVD9/GTZuUeEVhQmJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySMUP8OlZzuR5E8GyqMXgX1bUFVppG/WPO+E+Mn78/s=;
 b=Ds6GwcZXq51+gEd1u644ki3TMM+/Pc444g9AaSbp1z+tj7E76zoP8yLmHltVjbT4K4rHQovE/NdG4vDBeitSS4aGmDi6ieud16NyJ1SG2GT8zREROF2FOuwC40uloDNGD21n9JC4poICuhLUEJSSh1goyriRaU6HZwTXk2NVYVg=
Received: from SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::24)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:21:27 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::6c) by SA1P222CA0191.outlook.office365.com
 (2603:10b6:806:3c4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 15:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:21:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:21:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 12/13] iommu/amd: Refactor GCR3 table helper functions
Date: Fri, 13 Oct 2023 15:16:51 +0000
Message-ID: <20231013151652.6008-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2938220f-9684-4b59-5815-08dbcc001182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3nhjnnVzCpwtmG1b+S3SHYbLwxTkNSMbxJ/MCdhy7dIe7Vzv/EMa699af9+h1vi89qAGgk5KWXTx1O3b5G7mL5uyd8HuRWeKWjYznf5UhnIoKRAGAiuq3OrmIgwIS+9UQFnYgvBAJHaiJBGps8WU1ehBUK/J7NVzVez+0uUJyfrJWNbwgZeJnL6DBfb0r48IPx3slNvkA/Y0YvxhRxgGSz/PoQPQ5HMstk7OuLCr+0rBPte2JcyLclj5ulhndyAr4XInF8ENJVheVgjDTLn1ir28RehUaHorrFCiT6mk0Fz7jWepAxVEXDfHQT6FJg/7O2juEIlYGKhbLVQKaO2gnOlsLgEJOjP7wYmvU1O14du5hQvZsc5TKacRTrUi0gZm1wlx8yb5bQ6M6/fU6385OJyh99srfI2+oM16aTXETSt0GsIXS1kY/pgQr0AVJKUTwSc3PVt0aXLVX02kmxLuN58RWFvyi6jSpRGR4W6YgRwDYnZayUAF7BeBO4vxxDhewYZ22VGBVjwVULIwNraMYr1HH11G0UKPV3PmtLjmYBa2uqrPt5RejF/9q2NDrGgcP3XtN5OBzx2ZeofBfzd60DEJwOIth8yD2MvBkmhKlsZ98eCPJiFCIAOAmwwu9+4EI0TUasKoDF3UNOFBjCzQ8yLddzglIK1GsgH/dVGHFXx0Xot22JBYDLDbYIjU1okD1W1E5aCXp48X5vlgb1vgRCKDzQrdgKW5/rXrLO1tBBfW+HKwQQGNdkG+exqWipERIteH6f/KMyrmOXOPJ35nLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(2616005)(16526019)(478600001)(6666004)(7696005)(26005)(336012)(426003)(4326008)(47076005)(2906002)(44832011)(83380400001)(70206006)(70586007)(110136005)(5660300002)(41300700001)(8936002)(316002)(8676002)(54906003)(81166007)(36860700001)(356005)(82740400003)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:21:26.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2938220f-9684-4b59-5815-08dbcc001182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Also modify
set_dte_entry() to use new per device GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 57 +++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 302ae7ed6d7c..988341ec499d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1801,16 +1801,26 @@ static void free_gcr3_tbl_level2(u64 *tbl)
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
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
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
+
+	set_dte_entry(iommu, dev_data);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
 
-	free_page((unsigned long)domain->gcr3_tbl);
+	free_page((unsigned long)gcr3_info->gcr3_tbl);
+	gcr3_info->gcr3_tbl = NULL;
 }
 
 /*
@@ -1829,22 +1839,28 @@ static int get_gcr3_levels(int pasids)
 	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
 }
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 	int levels = get_gcr3_levels(pasids);
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
+	if (gcr3_info->gcr3_tbl)
+		return -EBUSY;
+
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(dev_to_node(dev_data->dev),
+						 GFP_ATOMIC);
+	if (gcr3_info->gcr3_tbl == NULL)
 		return -ENOMEM;
 
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
+	gcr3_info->glx = levels;
 
-	amd_iommu_domain_update(domain);
+	set_dte_entry(iommu, dev_data);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
 
 	return 0;
 }
@@ -1960,6 +1976,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u16 domid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (domain_id_is_per_dev(domain))
 		domid = dev_data->domid;
@@ -1989,9 +2006,9 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (dev_data->ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
-		u64 glx  = domain->glx;
+	if (gcr3_info && gcr3_info->gcr3_tbl) {
+		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+		u64 glx  = gcr3_info->glx;
 		u64 tmp;
 
 		pte_root |= DTE_FLAG_GV;
@@ -2019,7 +2036,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		if (gcr3_info->giov)
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -2066,7 +2083,7 @@ static int _init_gcr3_tbl(struct iommu_dev_data *dev_data)
 	 * By default, setup GCR3 table to support MAX PASIDs
 	 * support by the IOMMU HW.
 	 */
-	return setup_gcr3_table(dev_data->domain, -1);
+	return setup_gcr3_table(dev_data, -1);
 }
 
 static inline void _destroy_gcr3_tbl(struct iommu_dev_data *dev_data)
@@ -2074,7 +2091,7 @@ static inline void _destroy_gcr3_tbl(struct iommu_dev_data *dev_data)
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	gcr3_info->giov = false;
-	free_gcr3_table(dev_data->domain);
+	free_gcr3_table(dev_data);
 }
 
 static int do_attach(struct iommu_dev_data *dev_data,
-- 
2.31.1

