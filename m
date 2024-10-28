Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF01B4C23
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108421; cv=fail; b=Z7cLM5E+zIVW0s1cWBX2wcOwPIqR6mirjb/H2hGH8HfLH3Rd3x4MsgiEnU0EOQ4koT3dR87czd3hLXI9/R/7MKAlp2P6sRtorhNLaz5M97JLnFL2ors6c1NRFcJBSSrMiTKg1z6n5x2mG7ZVVmGEuCislKrRDzdzi/T6p08NHEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108421; c=relaxed/simple;
	bh=9oUlbVQQmhJ5PzYQEiwm6VICgFwNDDl6yZd4Tuten2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyS9OjVMMQhR2Qdc1KFBoudrpIH0vUySCDTdFz7AT0wW5pjlJa8X6bxRPnqBwQq2Qq2yfD8tLAIZk+X/BtWa6hYfbLEOEindjb2AmwFH/vKse2hN2dk+sqxhx5WH5hJ5TWuGTwOANBTto/mD0kZYQZvWWjiml6kyJ73c1HARHeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AMlXLQNf; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AMlXLQNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtzZQaR+H44Q1FfSEmaXol0FgFxhOupwBC3/ByDFb/S06EhaY04BFv9pHAvpgcuVJw4DYRgdDUaRFqMjAEjh1hydB54o9tT1hrwaQh0fZD6kEl3IAp7zYc1ew5vkG0E2Npz5+FF7WxbXfTvjuX4Rpk86/foGr3wJgRO2X6Kw2KAtyM71eYwC0AiGEhltCAiXWsqgsnwKI7T9Dd5cplzNGRR3vuZV1nkOBi3XZFJRu1dylhO1e5ti6qAsDwQv+8VqLJyBH1OOSR1QkXoCfNYXJhI+3oUd0wRhgnwcXImyV7KRSav3YNxDyDeg0rdl6ALCM0N+ZAxNZv9Gz8S8goGSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVbxNsIRJt/lGGhOiieES5HryQJB7aXeZPpN3veGPLA=;
 b=OL+DpMkKD72DuCR72cmgYhrR5K8GyJFUJ7T4UKZE3toTkosrBDr7zpvpgFBY5BFNuhgweIpnou4ob1v9/nYrzMSlw4L+TqBVYp/dx59KUvaDCdAlGLvbuMXx2oZa0LXuWEPy6KSy/JdcBDPlfIs633+KNGfF72EdSkyIYjvlUNhwy00yVk7jc5Du6l1ncjMtaNcW4OcVsPb7lS03aTAseP5dred65olXfy8ClLXWrg+CLJ9QggDHYl3lXnbF/iKUllGukXxzFEwmqa2pBbgQUD2bHLaP23nS5Yo/kMod9bBg0pBi/llNM6UD6S80f1iDRdC9MhRkPlckjxdv9sLyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVbxNsIRJt/lGGhOiieES5HryQJB7aXeZPpN3veGPLA=;
 b=AMlXLQNfuDZTkB1cekuizo0xLfbrF5B3k+OAv9mtJ+RbM7XHyCX2MBFEQnrRtMYKswDzLw8v9730E04um6dNgNE91iz7q0iUBjsCL9yaqL1mwiWXIFDqPPy6NiYbEUox9bbdV4G4qxbNt93CKW//aJ9m+T2s1rds1mwFCefAliQ=
Received: from BYAPR07CA0100.namprd07.prod.outlook.com (2603:10b6:a03:12b::41)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 09:40:17 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::33) by BYAPR07CA0100.outlook.office365.com
 (2603:10b6:a03:12b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 09:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:40:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:40:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 06/12] iommu/amd: Move V2 page table support check to early_amd_iommu_init()
Date: Mon, 28 Oct 2024 09:38:04 +0000
Message-ID: <20241028093810.5901-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: bedbc92d-12c3-4110-8967-08dcf73487f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M76Ye6pNHurpsbkS5NVPO1haThPkLy01nxeeZm6SKIoAa4Ncgk8TCUg+8PGn?=
 =?us-ascii?Q?0dpd/P6QqwlxzWwjhlUw538u8W1r52Iw6iEs0AZQHcWo3eu5TC1GCKXG/S4d?=
 =?us-ascii?Q?HnhIzkt30b/itCOjsE68YBp6b7MAH7vCZ63FQnu34KtCLSWwchBOXa2haU9/?=
 =?us-ascii?Q?hp8BpfvWqP43Dv9wQQWzOgsZx1G0W5axadaKwHMt0EAi1Z0YfATQ2HGUk04L?=
 =?us-ascii?Q?QRWUDm54944P78Ks43NtDWBvSFGcCh0pwFnsfU5Mm0l5iF7p8npwFd5QX9jB?=
 =?us-ascii?Q?00yv1TbPEQS5mWJz4e8DbnUNhwwxaAEhqSejbb7eMhNFsb5m5o/sPmRZIZeY?=
 =?us-ascii?Q?9WOGXoMiIeD3QMFBn+RPERARFvEmP291u/7VoHIefj6E1wLNTWaesqdQ7pRt?=
 =?us-ascii?Q?YIOpsj5HUP3M36LzFQPKDih08muwcwytb9zG9BU944OUXOYzmuEsUSnx7GUf?=
 =?us-ascii?Q?ag8lWVTj5t44trnQGx/PiqInEpuxeTnyzZ9R3mNS2exdD6s5eNtzqxm9XJz9?=
 =?us-ascii?Q?mrlaWgebj7LDfJkr+UqsvRGvRG8Dkc8h+6tzd1kV9gozHqaJQgiyiIwSdoqw?=
 =?us-ascii?Q?VWkvKZivRufJLx5stXwpaQ3zVapkQ78Zat6JZTX16kGCOl96+m9EfAHkWzZu?=
 =?us-ascii?Q?NL1BxIviQAmExWCLzrhjxjXHSjJNe/3hVk7k5vS4rhul55JY8mU7n7VodZpK?=
 =?us-ascii?Q?mMnBNW0YvDq3lei2rd6yNenVhzzWe09Z/2tpufBSLw0igxfUd/Xacld2+IL7?=
 =?us-ascii?Q?91krj86Zvvzp0HeTNr4tgujCRgCYITiY4EGhBW50v2RSVBrq2vkpRGgEUBmt?=
 =?us-ascii?Q?wttF3vq6Nz8kEWMWKU0kQNoQqM6ID1iqT1TNceeWMGHUV2tdi4sC5BivPUuR?=
 =?us-ascii?Q?SKqfViX0TvdkDK7oQjiJYQQoOavJknBzutbJbKg6qmh1EIXpelknfzyEpcB3?=
 =?us-ascii?Q?BGaIoTDdFUT2pUSngAGitCIPt+YA83rRoD5DmCotqSZ3sHE9+RHLM0BfJp4j?=
 =?us-ascii?Q?89oWRzrLJdm9R+Q9JkukwIQkUHanBFEmDaU8IEWOpo/YqMIB8pOmwrz5W+iC?=
 =?us-ascii?Q?IjLW9Y0Y2NSDrC9TFBGTpYLIo2lb3afJp0MRjMqxnV1uCT78NUK2QkmfvpUV?=
 =?us-ascii?Q?puGUfSd7kjy4i0ZWp4lNiLlHhMldaQpg5YivtnwlQBgvzKWQh3RzA+upz1qv?=
 =?us-ascii?Q?a7lMqswjGNcNsVz4HEOdNQlaCuGxgInxRWmKJaj8TNEXDAyDdKVcfOQSuNjq?=
 =?us-ascii?Q?lW+qRnbZk9KMwo+UdkaZzxw2cPPMWizgni+8TYhHvFkUbyQHGu1JA01T6coN?=
 =?us-ascii?Q?EUOQTCDZUuMTByTzOOPKpP+0owGybwMWX/+qA0wf5OzUrsS4sOWwyEDkK6Pg?=
 =?us-ascii?Q?dZxTvOq6Ca8vzwzPdAPM/m/2fGCz5vuR1uWiUQHWWgVPorCIEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:40:16.9515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bedbc92d-12c3-4110-8967-08dcf73487f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

amd_iommu_pgtable validation has to be done before calling
iommu_snp_enable(). It can be done immediately after reading IOMMU
features. Hence move this check to early_amd_iommu_init().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7ae478d95e2b..7c883be22559 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2070,13 +2070,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	init_iommu_perf_ctr(iommu);
 
-	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
-		if (!amd_iommu_v2_pgtbl_supported()) {
-			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
-			amd_iommu_pgtable = AMD_IOMMU_V1;
-		}
-	}
-
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -3090,6 +3083,13 @@ static int __init early_amd_iommu_init(void)
 	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
+	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
+		if (!amd_iommu_v2_pgtbl_supported()) {
+			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		}
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
-- 
2.31.1

