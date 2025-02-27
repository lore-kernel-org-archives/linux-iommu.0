Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4194EB38
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673900; cv=fail; b=kpCBoxnMoox6nuLfmoveStC5/7kA23tRHFelblaoBuJVY4J1xY2WSZk5gY2MPSTrfB5NJynxQkFxyNtr5ND7z9bWQDTRbir+GHS9akZD3YeecpQ42yushDzVa0uES0szj6QakHW32gx3Ep8PaSSBtOlznUxq+dFDDGm0wKQzO3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673900; c=relaxed/simple;
	bh=vPXlNvr0Bv7Q0U78M9DfsxpZyASHl2VsMfUiuy+8SMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVvwGwDfwb9Hur1DFjgZkzeJWEp3cyidjMI99m+S3iPlUMKbQqAE7hwJoeLOcdFeixHEsJqPKaVCUwnvocnnT838bO0fRr7RIwXIdaxQbsdK1CPJBvujcQkZQCYelV+kRo2+EgDOTpCQKv4QNkwWBSbb+7ej7n2bjcQqTQAf338=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XLVVHLLf; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XLVVHLLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDxAtbLy8aUHqri+gtRGJTDWBBm+wCw+c1xSSLeWC9KWEpAFyhHruZHMX0pPtgBuvqxW41wbTVNErkB7YAQ3/vsxnsaaaRyqwIMoGU/RW5M297bQPSeg1HxhIzpLjGtj54ihdg8T6cyEz3YTnynhx/dZUgotqDJW/m86hwhwB9SgdtwGlkvhDxVEWRSOEADf74n54XPdxkzdK5/ELrJY8GTFuA5Zk+25a1YP1IfUHp6T6Y+iPn7sm5eol+YTtm8NBnDxmSi7NKomo5NsK2Vi4A8d5NJdRxTa3x5Z3mMAVTMJQa3M3pld0QAZDiIbfMSCztfiisdaBeTnAITihlSmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhLmFMPJX7ILjbS5tHnTgja1jc70Tgal8iQT8r+CmSQ=;
 b=diHLeAOGCCKmw4rt9AfHtcxrimvOJBXLMiK0R2/TjSRce43zYGpfI1yHL0d31rdK4XMxmFAjeoVUkH24lM+xQaGr5Tc1I3YjVIqcCmhJeAgdWn+oRCb0XqQ+sD2EvsrgCsUlDuKZYxptjx0K3K1E2QOFykSzJpE+4171X+UuV4a5d4pUNxHlXJU4m7GebgXVgparWf1o6rsAY+3C/ADFUJ1MGR1pjTbBFZH7zWnd5CVNHIQxlmte4F39U4QT/5fv+yrozBuNVjsOxFwRAku9QKiPEzUNuL1jY3CKUCmMW8YIihQe2in7kwD1mrPPRfbYBn+QyJAvh0BoJ1tPhSLZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhLmFMPJX7ILjbS5tHnTgja1jc70Tgal8iQT8r+CmSQ=;
 b=XLVVHLLfZ9xR0cdtTjCNCumOf+hIPm2JWaqJ3ClONdScsdIVvmUp5TD8rbrKe1sHcTeZJsVXUpbHuZVsGto66/isSFh2T/Z8JTKChWACXb558xSCdd/YU1VUneX7BsX54FiSm+FKRCCTJH8MMlQXc7S9iRbA2nTECgH5tZW9PQw=
Received: from BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::32)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:31:36 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::46) by BL1P223CA0027.outlook.office365.com
 (2603:10b6:208:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 16:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:31:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:28:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 3/7] iommu/amd/pgtbl_v2: Improve error handling
Date: Thu, 27 Feb 2025 16:23:16 +0000
Message-ID: <20250227162320.5805-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc108d4-0cfb-494b-a3d1-08dd574c342a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mc22ehhCkESWzsAP/TYWpph9vsU/2bCifVupMvC5d5moplg9gv9n4QDg04sj?=
 =?us-ascii?Q?nbean9HfQQ9NbzwodMSIqjn7IyFtaa2/A4dFVRx5VaamUbpl2meCNjreDeoC?=
 =?us-ascii?Q?h+mtD1TaAv6Sz+RPR4386sA3M7dn4tC4e1TYm3rsehFRsTG6DqanzZ+byflZ?=
 =?us-ascii?Q?FdKMYe9ows+IH97VNA+j6f3OLfTWe7uCK/UVp8qUujwZm6pbAd02d7aISxmI?=
 =?us-ascii?Q?ZbHmLkgZDsqiFBg6WWSYv9KKh860wzgSNVYl2/Ei0QVfYBi5oQ1dZ/oyWhmH?=
 =?us-ascii?Q?2xci6neZSTc7nXRU44OoYpZcpV/vTZLrPA7jjifMxARU6zgZnxQUaBPouWK0?=
 =?us-ascii?Q?AnxMCksdo3bZNVnJbYNQvYJdSCqWa4nbUf9ndtEBPN5gP5/wQcS8fANUQtyb?=
 =?us-ascii?Q?8s2Sz6JafrkgthQYvntr1jXVgkcYIyjkIXM4gGHEWskdgGd6mFj2R/oxDb29?=
 =?us-ascii?Q?KvRFvvka4letNJOEIo/7+IhGaRM66J4ZgDjp2MXtc5TOhJog/1wh3eUA/AtQ?=
 =?us-ascii?Q?67t4E+MrolehPciInzCMbaQoAESndwbpRyRsb1lAeTxMzdamDwrVFR7SKbTq?=
 =?us-ascii?Q?dySpXibEUYCJQ1xFi5eqDi2pY92j8Z19dABD9LL33vgnCFwCgNfo8JRR/+zf?=
 =?us-ascii?Q?LvRtX7A+wEQp9Q7Pdzb4vfjPuECEQ6qOOHUY7vvkCWosjx7JIJJcJiY1HVxN?=
 =?us-ascii?Q?+XHlMG1tQeJjjUPSThh4pzPTQWQWck8oAaDUxcGedcX7Ku6Hl6+ES93Ak8t9?=
 =?us-ascii?Q?72wvfT4gd03n8Yu2iWkfXMH2ZiGRCjub4HkMvzMZ729gZ3gEVOyI+WVKtKpq?=
 =?us-ascii?Q?0/O8VRO4GomoWCe9h7p1IfflHznqQPY3OfLDjfXQouBYCtTqAf23G0LoJplq?=
 =?us-ascii?Q?VpgAi/L7jh+MflDrxEeATD3eTH/wGBBWZ43BvfKhrUxnBo2qN5sNjupE4E6T?=
 =?us-ascii?Q?tAR5LC9rGuQOq8MI2ZyTdZ80hgb3bnbgH3xlEuTasSeFmZf+dXfm7VOonlFn?=
 =?us-ascii?Q?NXvHAyS8KT2Gkgkj5zUXkS5F6ych4UcFOJR19FOuNlkU+eWorFvWftd7LehC?=
 =?us-ascii?Q?xpxRNhYdBaVAoKx9HCmrPMhD+Os7cNiw8F21o/bjmD1/cHrlSYbPYcmGJ8Xx?=
 =?us-ascii?Q?fRaO3179GtO3qdPnvnMomJ8E6L9mHsIaWlzksZOJpEYhQpunD2uZVnadyJCu?=
 =?us-ascii?Q?MbzKEdEouhqyc7/5FML7vaJLVyVelYMzlinQOA4jFnDIBeYne8bP4cfGZ/pL?=
 =?us-ascii?Q?4UWVTOcYHkhGDAkGohZ8rR5DCleAfoVf5xf11BzjJj3MYBrG2+egfN056Prh?=
 =?us-ascii?Q?+kJOvmW3A4QJcEXy0xRneBfd9Cg2uG0BjmcpPc2R2hlNQbUV8ilITfKptM1v?=
 =?us-ascii?Q?m3YZLJmfgW2XRrhCfhdfI3/7MX95JcYExUsgOLZhYPgw41Ri+00CcUvaB1S7?=
 =?us-ascii?Q?LwLDkHuxB4cNbSFFq49mjsBNsb4H+6Hc6nvZR9fol6fa2cSSxpPp5VDIizN/?=
 =?us-ascii?Q?PS162FI/K/mniT8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:31:36.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc108d4-0cfb-494b-a3d1-08dd574c342a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

Return -ENOMEM if v2_alloc_pte() fails to allocate memory.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index c616de2c5926..a56a27396305 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -254,7 +254,7 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		pte = v2_alloc_pte(cfg->amd.nid, pgtable->pgd,
 				   iova, map_size, gfp, &updated);
 		if (!pte) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto out;
 		}
 
-- 
2.31.1

