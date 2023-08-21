Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE6186D
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjNAVI040VN9CwBL6WagZsMUI8VydSc03swxScpDsy925xygN5skLjvXLezHPz159oywvUO3C0oCEO+zBxKrRSVyv3bf9SCLI1CmYie1b5FL8Y1lkTRYVNPLKLDCrHhVoTJmPBU959/LlslBwS0R/ljTT6BtvQKVmGAnh1f4LgmDLJYy/xvZU/bvQTk5LIvwMIHWQgpXQ+BZbkWBTUSsfmNfdm34nT9WiEw9x1L2TaLyEbxalwYraGFBtBIVWILCowkSvOtIBY/u1RJC07c7+AQwITU+3te8+vUYXX2LIzVG2xBXWifygEB0J7/0PMZrK31FiiWiYL4I18la01uTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+wMhEO5eke77lSOo1h00xjnG01pODBLLl7BtsTsgU8=;
 b=ZiJiVgzI8/4Ys/YqpEELAEfbzqAgO0/U3boctXK4YRHBMWTXexm+UYswIdPKSq8G6hP6wNLAumIYA1IkMrwifRimVTGBcmm5WJ8lLVEzL3V0/HCNveABGOZShAp0U6m1Pd01/YZDCapT1x7vY5Ou0HUAoHHYSvAl+H/6Z4IozTsF5sJq5B6XJDgJ/Q2ekS6qpakMMmOCSpCWtxjh1sD1oVlm3fKT5CCfvTNnQ5sAcTfszd6CtibWvOoRx5Xag98z3Zv+SqQ2Lk6bC9W9tccMs/8EriiC6OlDOmGnEFZrDP3D34HJ+jCzC9N1TYDczJtakq2WUA0M/bbB/9G/cafHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+wMhEO5eke77lSOo1h00xjnG01pODBLLl7BtsTsgU8=;
 b=WgVkHUZd3mfLejjd/pbC3Kkjvm/Iq5ndeBf6Z2DaJMLxRUKrIK+omy4rzBKsfuPk3HVqlHdIVI7Vy5eSgOP6z5v106wd9FqjFUKq2F7yII31PUffbtohIG7wGObgIEx9qkhoNZMQg+/Ljda0iutXaE9e9xg8yWYrr0kzoDQ9D50=
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:44:48 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::3) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Mon, 21 Aug 2023 10:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:44:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:44:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 05/14] iommu/amd: Introduce helper functions for managing GCR3 table
Date: Mon, 21 Aug 2023 10:42:18 +0000
Message-ID: <20230821104227.706997-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b06eb5-e77c-4ae0-57db-08dba233a41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8jK5JpYQy1w5aOyKu5JhD+TXX+clGhHnjFdFubpQePoC4YtFio3TWcDd50bplx/ZrhJYF1BqQ1LTn7zNh4l8GccfYps/Jxz3zDKe5K3sWWYf4+djus0asUv/Nw/2RD04A7uPnQu2H2KD7BBOd696euODJ66/8CXlcQp7Kw5gV8Elm5eHIfcmhlpw95lxw3pulk3OTyXu9u67zvlxVqvdGk4leC8xkjanD2MCpiDgrMtoE3x/roTPcG9ieLKPgZae+QbQCsxYTKCqzt9y+gcS8SBG5FbBtalb/Hw0ZOFxCczQAmh1XZBUcLK9831VLmoMU4NAwL/L9J7HhzreszMK+4gStKyf+r5FsqvV2BkZR3hW8wYoi6d/AYdu4p29fDaeGwZuJOxuP+Wgr8gKyb7ZZ5IyC3Gng2d1iAVTxRyY0CwjmhXJT6FiP2KZpprfIaAAA6cN08FGCVRBI/tuWU/gl20IJQqKxD98N1jt5PHtdWF+ug7oLkNag2Lv2EnupLDVQ4l15AVICVuI0DA4jttth84w+W10km0qpurmW/HdE9LubQj8YePg7u4vJJ1+QhPtCLWJX9blVFFypymyncA7ndE7/r4wG0GkuyYOjEf4ZZuRwo4KH+PjaVgEuLx1ZL7djaaY17pfIMyPfsrINRLOngulmy6KcmV65LbCDG2P9PN8W+MIxOOnwzsPv/xHOftRZ+/G/2H+PWxIQWOpsVm6jnF1qcs1VpnkJe8/OmWmpkr2pGX3hkHgNSmQfEy6lGulOxuJ5la9nzwpa0kLMY58dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:44:48.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b06eb5-e77c-4ae0-57db-08dba233a41b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Refactor domain_enable_v2() into helper functions for managing GCR3 table
(i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
subsequent patches. Also re-arrange code and remove forward declaration.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/iommu.c | 65 +++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d5569eec0fe9..bf1640f4287c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,7 +77,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
-static int domain_enable_v2(struct protection_domain *domain, int pasids);
 
 /****************************************************************************
  *
@@ -1575,6 +1574,42 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
+/*
+ * Number of GCR3 table levels required. Level must be 4-Kbyte
+ * page and can contain up to 512 entries.
+ */
+static int get_gcr3_levels(int pasids)
+{
+	int levels;
+
+	if (pasids == -1)
+		return amd_iommu_max_glx_val;
+
+	levels = get_count_order(pasids);
+
+	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
+}
+
+/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
+static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+{
+	int levels = get_gcr3_levels(pasids);
+
+	if (levels > amd_iommu_max_glx_val)
+		return -EINVAL;
+
+	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	if (domain->gcr3_tbl == NULL)
+		return -ENOMEM;
+
+	domain->glx      = levels;
+	domain->flags   |= PD_IOMMUV2_MASK;
+
+	amd_iommu_domain_update(domain);
+
+	return 0;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 			  struct protection_domain *domain, bool ats, bool ppr)
 {
@@ -2065,7 +2100,7 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (domain_enable_v2(domain, 1)) {
+	if (setup_gcr3_table(domain, 1)) {
 		domain_id_free(domain->id);
 		return -ENOMEM;
 	}
@@ -2514,30 +2549,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 }
 EXPORT_SYMBOL(amd_iommu_domain_direct_map);
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int domain_enable_v2(struct protection_domain *domain, int pasids)
-{
-	int levels;
-
-	/* Number of GCR3 table levels required */
-	for (levels = 0; (pasids - 1) & ~0x1ff; pasids >>= 9)
-		levels += 1;
-
-	if (levels > amd_iommu_max_glx_val)
-		return -EINVAL;
-
-	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
-		return -ENOMEM;
-
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
-
-	amd_iommu_domain_update(domain);
-
-	return 0;
-}
-
 int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 {
 	struct protection_domain *pdom = to_pdomain(dom);
@@ -2556,7 +2567,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 		goto out;
 
 	if (!pdom->gcr3_tbl)
-		ret = domain_enable_v2(pdom, pasids);
+		ret = setup_gcr3_table(pdom, pasids);
 
 out:
 	spin_unlock_irqrestore(&pdom->lock, flags);
-- 
2.31.1

