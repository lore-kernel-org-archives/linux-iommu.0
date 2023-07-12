Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09425100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWwtQIMqgRy45dSFMb6hU4fl6aBwgBBlkwiNd3rqkZKgoZiC/4fE2/cLKSL23HXpyACCGRxEmwBF1KNBEflRl8d2v2C7Cy/7um7xInCs/RmOHi9ZKZPy4AV87gHAB3/5y244OQJObw6B+7xDEvcz7LhBRkUiVf87JqusXeZLXtNuVEOJ/qVmtJTfr4lFh2+KVFXM5CCyHnG6qZbQ06hydxnlpWuBlhl/MMPnMyjaBZJ2ozXwtbBAbSSJHkLDaDZt+1f/IS2q52fVeUJCQwXVxgpYDITpZTwDYQzTdewK4eWRwFE1b8p0J4kAPwrThArjdYBdRsvyP+Cgqip/Tmck0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJZ6kKO8eNT3NsYlpr5ZGtBimhMU8V+EkLCpYP2m2Fo=;
 b=kUYNFcE2TO1S5/5U7VwLWV2Hu1UTsi+zdtIqyN5I41rXUr/WwYy0GlnKSiYLZjiTzq7Qq172quFj73M4fhyG0WBK9ipvbs6NLiYeW46nXqg5ThiPsKXk/ehGGMM6x4/uLKJpZamIVFTTghrhGIFdhBIqJldivZ+K4M6gj9+IS1+ki262M4EOZRqyyAErPMXqHHHvdRd0bpUBz3BbVM+ROJci048lWqDvG4pQFdWFEYwKoHTk0wgRfJL6uqIbxwEfpnQdEbRmKGrvyzq2gx4d0bzCSmIQPlNB/J9ljfztUzmyDpXoPogNvroSsRT626+q2A3jjpT3CJk4lHrtH3DnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJZ6kKO8eNT3NsYlpr5ZGtBimhMU8V+EkLCpYP2m2Fo=;
 b=1IofhtLSnsumFyIuN4gDq+zXTUPKRcrUU94O1HydqY1vEH2ZBAs2eahEkP7m06ihEWn2bBkW4AE0D8dCBnY2v733GuRt3ks6ECxN1waNf0KGbR7yyEZoqYzPJ+YjYWJvm2CrlPthwtRFhBBi9n1yPPfeOM1OfBPedrmO/pozILo=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:16:54 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::31) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:16:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:16:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 04/21] iommu/amd: Refactor protection domain allocation code
Date: Wed, 12 Jul 2023 14:14:59 +0000
Message-ID: <20230712141516.154144-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: aa50cb47-e055-42fc-19c1-08db82e2a45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+8xBs9vtHIA+BRchsL1VxE4oa1qJNvOqBRWAhxuJTiXSwC+gDZstVRPb9u8LYN5ARB1guDC0Ny06Q97Iptf4a3dEJjiYhALBe8xLe9h9Tr27Rms+ngy/WsQPXQoiXVDfV8MhqU++201IYCJ6saYB8rt8S/kGWtwt2oovVUut4nkRyJvGOfR2KLGBe7TLpRb06e/4mItOdYS0PQEbictoBtyETDZdM32j+1PU9vY0Il7qAZqdSJ0ov22V0oXtTUZ9OeithZp31Wwihp4KPHy0U0GXslydzdoG3zGE1YhT0pnbSvqz7jMpbY10Ma4zOjIBzqSO6oSF7HPvXZ/cHOMN+8/VfD0Ve15Spr8EOJ8YptPIXzlCdkPQFDbKCemCSvuGBDhokPEybOfGm95MuBWbJ0s+Zacj/NGu9uvB5jU70mQxqXdCT8rfwbb1DJ19B1hP42BeFm+2ulWGaKI2u5y/2DGWEzHIEhFn8ZAWbNiBPNMpUQad36EV+8alStUEhFJKq3Z3SIYkucHdUk3QEHW7GksASsyhFBFpD6NUOi1MN3ql4fnUaO+fC3HOdeQMSBhXZgns8jaYtNgNpLaL6DaUs5lGQ19gxHdyuH/svD1cjx9gBu5exFx9x6zURURBIkHeVzZJ6brgPsH5sGEKVz5wFRNZnhHvO6nZunLFC4/Ww5riMCq1FkAaJ1bSFo15OPnYa8oPirEA9DAFNVhh6Wu2EpnF+2pnl9X9cc34sXv1RRp5okHaNqI0AO6OMlTk+eTA4NMvQXlbrzMQyt8kN91Oew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(356005)(81166007)(82740400003)(4326008)(7696005)(86362001)(54906003)(110136005)(70586007)(70206006)(316002)(36860700001)(41300700001)(186003)(47076005)(83380400001)(426003)(336012)(2616005)(2906002)(36756003)(40460700003)(8936002)(16526019)(8676002)(44832011)(40480700001)(5660300002)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:16:53.3995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa50cb47-e055-42fc-19c1-08db82e2a45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

To replace if-else with switch-case statment due to increasing number of
domain types.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c2cb541b0553..287c979239c3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,24 +2078,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
 	int pgtable;
-	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
-	/*
-	 * Force IOMMU v1 page table when iommu=pt and
-	 * when allocating domain for pass-through devices.
-	 */
-	if (type == IOMMU_DOMAIN_IDENTITY) {
-		pgtable = AMD_IOMMU_V1;
-		mode = PAGE_MODE_NONE;
-	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
-		pgtable = AMD_IOMMU_V1;
-	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
-		pgtable = amd_iommu_pgtable;
-	} else {
-		return NULL;
-	}
-
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
@@ -2106,10 +2090,31 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	domain->nid = NUMA_NO_NODE;
+
+	switch (type) {
+	/* No need to allocate io pgtable ops in passthrough mode */
+	case IOMMU_DOMAIN_IDENTITY:
+		return domain;
+	case IOMMU_DOMAIN_DMA:
+		fallthrough;
+	case IOMMU_DOMAIN_DMA_FQ:
+		pgtable = amd_iommu_pgtable;
+		break;
+	/*
+	 * Force IOMMU v1 page table when allocating
+	 * domain for pass-through devices.
+	 */
+	case IOMMU_DOMAIN_UNMANAGED:
+		pgtable = AMD_IOMMU_V1;
+		break;
+	default:
+		goto out_err;
+	}
 
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
-		ret = protection_domain_init_v1(domain, mode);
+		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
 		break;
 	case AMD_IOMMU_V2:
 		ret = protection_domain_init_v2(domain);
@@ -2121,12 +2126,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (ret)
 		goto out_err;
 
-	/* No need to allocate io pgtable ops in passthrough mode */
-	if (type == IOMMU_DOMAIN_IDENTITY)
-		return domain;
-
-	domain->nid = NUMA_NO_NODE;
-
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops) {
 		domain_id_free(domain->id);
-- 
2.31.1

