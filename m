Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A0266583
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480896; cv=fail; b=oPc3rxsQZsObTiQtUDZMmLzYNE5PnNYDDQ6mV3bItab25TnkFa6ouXL5RUvzaWF+3t8ZXhOYVtKzalOULElBjXUtCPl7hJmv8n20mgGpAIY1j0LPN1g0zuinA5AuaF9AnXQtVOCFSJ14UeHYNOHEesGenoSFYrBWNw6rY7nLu9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480896; c=relaxed/simple;
	bh=RTQ/Hu6vVrrdNFfc1OdwGtQpOSDtFclHMWHSFxoP9bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6iZNw2o0BwX5fpYYTzkcpdroYal9nnDRe/s0+cEFwp8YBH2dFgsTpkcVLbRYZJTv0jgXDnIQ43HKH7Z1pHkIB3lzePHrKfR/dfDJtdEZbiVj8jeSvESZlNAJOAzQ2viUuSD4kv8YcO4gB9kdTN8vW5yIXOyVOQLWnt0rKGEVkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbUn7rgj; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbUn7rgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JByiotQHgvvuRuxW7b4FE80PweiWzK1/y/rqhOLK/b1QFUJStNlzocHdyPzdRVfYzwAWnVI9yAtyyTR8OKGZiBlz5DV9/OjKn/D0Wea7Q9ejnhF8lCnv+DwrkUe5GWGjW3wcRT3jwBpMyvHSA1Yu8aR17vDoj7YkbijT9OdsyEXiKws88vqY7USP8zyVrevsqL+iNybJk6vcJPvWFDQtUC534hI4MtCQ03Zs/K6F7pFFpMrpZXRz21gGZdKquHnerKaHS2U2RGevE/yNzlz4eRPVldkNOqalTHcMF5VOxsbqIDxoIwIydwcxmbjlUCX+mQtTeM0kLaM8YHe0FjbGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epa0s/+x+hZoUrRRK/kC1WlgoMMD1zFDoaJWxww0uQQ=;
 b=HCYYZVEDIyGH78KfVxQPbTWlEkxq24RlAKLFXk6QuXGzbjG+lSLarROZwrOL+QFJgxlt6wPzk9eIrJGMLeMJnAepjpqjW0d4Z5qfmgQSMJIkaVo+LYsjM1NJyDWcaLdn14Us3+JyuN9kcSWZQ1raG0nXuHtb4G6FRTOGtba4KRJAMNuxKCLoC9dZM0xhqNTiANBeyyYWIgFHJtBTb9gxz5ZfCGvVltgqiqXRSngJwzrloQAtmRua3bOOB+6iCC5JyoUnYDe50hCUx+fiiC0cgcbwwUiQATeFG9lF94eIHjB9fNpPtLeGqSGfHLS2CcBAjyh2vkpVLgHVWtRx4oKvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epa0s/+x+hZoUrRRK/kC1WlgoMMD1zFDoaJWxww0uQQ=;
 b=HbUn7rgjFTz7z4KESJZch3det+yn2Svlg0scjz+CfmZCv2QH3GvYQ/mbfykYndC/wzwhWjmHKF7z5CK84rah0asAIHkX7JyyWcpR7y+QzqzlI+u5hIR6Jj4Xs/2J1LJ7ptRPYWiwH4tyW51Kih62aVXlMfKa5HcXZfABlVhozN8=
Received: from PH7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:33d::34)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 10:54:50 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::10) by PH7PR02CA0014.outlook.office365.com
 (2603:10b6:510:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 10:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:54:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:54:47 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/7] iommu/amd/pgtbl_v2: Improve error handling
Date: Tue, 25 Feb 2025 10:53:41 +0000
Message-ID: <20250225105345.52143-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225105345.52143-1-vasant.hegde@amd.com>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 39552d6d-73f6-4ff3-7c6a-08dd558ad37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4zriyWgL13LTY9IspSJGvloBpZDSzZBsxEuB9P9MGtefd7Zr59ViCBMifil?=
 =?us-ascii?Q?G4ndSyYxyAWP3AdtK/sMWovN/u/T2YNvuGtahH+7ct5CKK+dsflpWmDE7mIq?=
 =?us-ascii?Q?UFyjYrGqihiffjChFMv5A5dJ0AFPDIzh99UMbOmf41EHC2k6CUbrdLRDVRLF?=
 =?us-ascii?Q?iTUKmMBiY8M4CIW98nfvzclmpie2kJT+62A/7knvDJrf5RNfavvqjjajp8UZ?=
 =?us-ascii?Q?8DAX3hZjGPTJKBg/o9JI3fni6pnNedEFMOq8tFmsVRdKVd22JhvUefnr/n0E?=
 =?us-ascii?Q?9KwRovMr1PxFlxFCUyJno+5xgZqDewsN2N2WR2kdIg2yF4d2EQeSNDngN3QZ?=
 =?us-ascii?Q?jb534pQ8Pdnsg4dJ1klCubnC9Rhj1e0TyfK7QWST6JwOSpFTefC3qkzG7eCs?=
 =?us-ascii?Q?JqarouHHVL7jI4BglXI8qDyXYHrvRIyfn1onFcYNTG4+D60AJuRtM2woP/id?=
 =?us-ascii?Q?X5c5MHhQEyNTB5fLebTjQMOB/EHKpulxYBDiPpWdEV8u4yW/xW04iSS5MrtB?=
 =?us-ascii?Q?s3MPnH1JztsccghQJYcY+oFwx2JBj0iSN9RYN7BEWzkH9oN1bl1wUKBOYmq7?=
 =?us-ascii?Q?4ld21AkiBLbzkhuiIks/WzxtMQ8oxV6vXWsCKKn0qoPzrQonq31VnbsGtBM1?=
 =?us-ascii?Q?I5x0SArFJy1G7ETaOI8LB4QZGhpIWN+1Bxz+af/FduFkDbWu8bu2qJara4gG?=
 =?us-ascii?Q?h8/a97VhMuWmqpkk7R31KXtrRHYcP9MsWcoh2dnSqsVv5aRTe0DJ/u21+IeL?=
 =?us-ascii?Q?g91YIjeqq3hyfm6F3sod7/2XOvfqtB4szj4WYsvliuaHAOiHAQ7AzrrSzOET?=
 =?us-ascii?Q?W+aRyMJeIBoDIRFVGxjVFJLlk28QeKm7sihU7MqJY0lKLBD0VLuOUwfYTp5N?=
 =?us-ascii?Q?jktc6Y5fLMJRU9uqEhdsAtm9AOFc8goY3aBbYwcoYYNtWSpw3XiXsSRix0jd?=
 =?us-ascii?Q?idK90etcwEgdsb0tHAtAzoheWHHPNotXPQvoVaafq2Z7j/v7MtJoDso014/i?=
 =?us-ascii?Q?85Mr1IUUSCJdgW1LZt++QmEoIt0c2vhXq7YPY3Onpd0VJpaYkHgjlf57ihqM?=
 =?us-ascii?Q?LSD7/IftNfmhw3uTZ6o8+FdMq4EHPLg5qDqC24bs8kXgsNBNRd7zioLxTYiw?=
 =?us-ascii?Q?uSvvGa5L+7v5bupsB0WifF66bclLTePvHNiR0TMh3zHCiCcOxLvsIlJxi+3w?=
 =?us-ascii?Q?PJYY9jaLcSrmIniwkTQ8TuURAAZY66pXha3laNXVczTGR9C5esMxPdJe62FM?=
 =?us-ascii?Q?FvwLLc3HDeBvNUVmGAWKiFUDhQ2MjlirRHRcu9sO+x0M+22uG8in9Sh14+fD?=
 =?us-ascii?Q?V/A9nEebeiKlHKEx8MziKlv9F8xJxwE1+0WHYdbnxRnkNLfJkJ3FtjnD4rjo?=
 =?us-ascii?Q?n8W1QK5bxTl/LyZRIyJCJhJJmpl1iPpsHzxkYvIMdQ/CYBwPWADTB57NVNO7?=
 =?us-ascii?Q?SRo1gm2Rj5KO2axH95t30pX7Obl1/UQ+GQUhhh9vIw/5L58Vi7XXTCo47+BF?=
 =?us-ascii?Q?AhB/s+zubKvS00w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:54:49.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39552d6d-73f6-4ff3-7c6a-08dd558ad37e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442

Return -ENOMEM if v2_alloc_pte() fails to allocate memory.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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

