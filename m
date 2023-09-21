Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1E8F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvOePhuy73YxV2fMthVLjNabE8plvD2N5w/6OeEtTko8voW24gTkcapgsR7ZG9NNSeYU0BdknMqNJ4U0D2aYCWs5GJjG1J7CnmCj6VcYPipTwQHvdiRmVf2m+g9pZf6SgdlE0++Dr5T8P0wLUCs8gsEBUD9tV1YKJccwizbLwxOZM3R8JZsUctlgcjsXdQNz2H5EyPsiX0bu41j54GFmMyEeBhG0nxa7OqTUcnQ/RmxV767yFJ3FNVQbmjjQvWVhokHJBNMy4gX6Buz4GiSNLmj1Sh+nHgyrdEU5TmMT13YAl3t5DLEOfjNvul4aTrmkNnLiSKejuVFJX+YeUCkbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9XFfOct1VJj0WglNbMH5n92VznmlH/+eSN7p7qArlQ=;
 b=V9keWJ3YZ4iA/fCGrfPUz+6EbOmtBvlb/wnYgH3ijQOfCDOfar0PVVjZmX2WfR1oN4sjWgfOTl+QwvWOVjwCPNoaecCik5h0MetL80CvNol2EPKdXFYf77YJYnLOaZMwYW9ccgFafTXKUy/mQBi3j5mZnnOUAKMd/DtTMqpS6wUyINigbXy2dcj2QKdrIcC2HhT087lvK5ViTP3bMQTA37A0Vq14hu2CPIxxdv+fCP3tyW9hEughmB09y1fvveqcHv0n/9PbnEvUIILEP/fg8um1923BA/Mx0Lx9ODgzssu9QTnjABRrcV3kjN2VHHgYsy34AWG5DdThNkySE615Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9XFfOct1VJj0WglNbMH5n92VznmlH/+eSN7p7qArlQ=;
 b=If+jO9b6RVNugEFibj4Qhmxaw0pp7pqBTdZ/+SngaD2KKutm2TT5aWoF8C0gGlBCQGy8u7WblUUZoMVLOnOzUTob/ir1gYlhnJUb7mnZw2FNwO2rTXsvYfVsrPZquZD3VNlhpieq8qpa14CKBrIM+S2jd2tD3PuypbnEJ6NvrZY=
Received: from DM6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:5:177::23)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 09:24:08 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::ec) by DM6PR02CA0046.outlook.office365.com
 (2603:10b6:5:177::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 09:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:24:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:24:05 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 05/14] iommu/amd: Introduce helper functions for managing GCR3 table
Date: Thu, 21 Sep 2023 09:21:38 +0000
Message-ID: <20230921092147.5930-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1e4df7-d504-4697-9d18-08dbba84823e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QzlB24r3tA7uPs5EJqRUUTsxyCEen9+YS9Y0Y7MvRu7MUTt+t6gifMcWpZklifL1PbybVgbaGHW/DZq7ZIc8o1jIbcuQVsGdJAUvEbEmpwY2SG+MxAAro9sd2eiwYrmY8UlQwQ/jPNyK3Uc5hOJU7nFCuGgOl10BH6BU7hNsyIk/GXP8FjI8OCySZQ1h5qTYxmcFz9CV/+ldls0CmMtVKezhK4FvtGcFP3vZEKY4aecIUyD7/GT33+ffwogLk8fX3umvhfzJpORbzh5nABNhwFcWrEtKNbHHNPIXE5PIfcMd6P+V2LRRhlaWgS9dnx2jzt93fHuhUfEfUyF7Lgcfj3g0FGV9ZDrBY2F050jw7oCbdbvzW4hWKVaqsPW9q8udRO5C5Pgvom1D3Xu3T3V5hQnnamvmHx7bmrgz9vD+xCMH9czQmPMuXM3dYSyjiHjDovivwsz65cKNcKFuFdPcUIJ4xDzGvP+T0l62UDHEXjFyq83EBOM+8fa6+gU2F9JTmvDYsT0EB9UWOsvqY5LfTAHgmHZY/8vuCMXwnkfiTq23dN3/vPxxuDYQUOk+5eGMBKXjDCOcT7/YB2Kw4yVBsuxflqkSoeppGpZruxGSfueEF0YKW0ZoZ0xCOUYU+tn8XCsWnhi290r2NChhOb3RcDP2Jbec5w2brEvBhsBvayGkl+ll/nuir5i+o7LuoEgdO4zgQX2ohL/Iz2JGlgdc9uS1j+26MaL6eTVi+5cs8sITAyMIebgFM68ulN3rW1MiO0aqGBXylw1RIwpkgXFO0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(356005)(82740400003)(7696005)(40480700001)(81166007)(2616005)(86362001)(70586007)(70206006)(110136005)(6666004)(36860700001)(478600001)(47076005)(426003)(336012)(1076003)(26005)(16526019)(40460700003)(5660300002)(4326008)(44832011)(8676002)(316002)(41300700001)(8936002)(54906003)(2906002)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:24:08.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1e4df7-d504-4697-9d18-08dbba84823e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920

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
index bc1fa6e43794..46a10b489cf5 100644
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

