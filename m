Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55C1494D7
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847297; cv=fail; b=Z1Xp+2H/cb9K7laATdv/DRVywWe0D1kZK4nvd8hpR+31dSiVak8xpSqJjpHBAxijJfxx2t7Ivk2zF64uA5nldEX/C5OIYTM5+8ICL/b0jo8y4R9igonjI/6N/Jx5pxXAOcFCVE6z8fPgORLDTWELEXe7AmLKCvd8+fm73mzz/zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847297; c=relaxed/simple;
	bh=a7qc3vWuAYXMVhxWFJbifjBCFXgcSuUbLTUiVW8E0EQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bw7dIIrsBmfXrhWToxrsCHrbLb8h9XDIBVPkjjpD+o4B5SpIB+jea09lnYiVeNkCxJXnm6VO03qAjxy66eA81e4LTqiJyj4/QdcVV6pszHM8hxQ8UC3y12kQtInLtLXI7liETNB79BdtXZ9azG6t3jkHKwr+YxmDlLpMKPjsPbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KwSKUz+2; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KwSKUz+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hc3EbP0b1vV11DQ+wIdg1XsB8rJf68GMeygqbnFyC8OG9K/shCQ5Ag0GCfHfTmE0C0W5ZN/u51uzF4gZq0FgHulMQlnTZAYyNpO6IPD5150lreiUBlO8hWPYS/3MG5uQttcKnmIudhuYYCBedapQW8KfWhJ+umJRlzleTfSxON+06LIxa1Lsutczd2RzNBIsE8Jo19NlkvMBxm1b9g6FHghXk9hcrkr3MwSvmLSZdPeMWgZZytA6mkVkO84FhEt+G/mYlScS/LgpNpoGZhxzcwX14EVx4ueNLA9tvV7Wrtz0QGQkpyF8689rW4L/47VNkp61qrfyPWAVAWO6PO91wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xitUoTGIc82ePwIx8xZjID0iCFB+jLcIBK5/GWqdCAQ=;
 b=nZmZzhqKvIz/jAHzr3EUuQXlMpB7hgZIrWKD8G8q64w2UNGlmygtjZG4wnBB+wljzFV6dEsTRYIQs1wtqL+aLCTo0fNVkawCx+hqvLq4YdPPtvzJ0lMvjlH6kpcuKlgs9y2GvVt/T+DvYsmerlXhTzb2OPMnnzhlHw9BBtaPDHIWerqXePlF6d0EbyunBWWmPNu7fs6wQR9g9EDVtIIoWqo2XAbQQMuFhtwU0pzHfVa1/kEhx1Yr1mIkG09csGCtEC467h6fhli0ruIwjdLEsIIDe+e0GMpC2S3mqGKMtEka+48MxLqHFMRJkrOAlMA86Za8Cf/jF77YkPyB0le+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xitUoTGIc82ePwIx8xZjID0iCFB+jLcIBK5/GWqdCAQ=;
 b=KwSKUz+229dUvs77azJ5HeUG9kO5T1MDdkCvazY9VKUj3dhqWxL8ewUwK7l94UCNmOuoIb2ye8ETM97QNVi7FxUiKvKSZVP+sfNi+iv42x9OrVB1NUUCegnU/4kXGeVlpmVaLNOpQ8o5eo8C3AvUnX967ddfAZWq7jKDK2i0IuiQXYE2sHDh11MBi7Cyz7sYhJPi78F5DmOGhHwZvRSJY/AzGVzdwH9s92rStFY/nQC1RvK9cCbYaaSXRerhWgDkDdDKDgNq2fsE35rJFjoIhl+lyNIRbhubZc1O8dxnzzIORLX9Pd+sY3tI/D/xsJ+8iWsrzuiFZW5awwdBZLVTbg==
Received: from SA9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::14)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 08:41:31 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::54) by SA9P221CA0009.outlook.office365.com
 (2603:10b6:806:25::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Mon, 5 Aug 2024 08:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 5 Aug 2024 08:41:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 01:41:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 01:41:17 -0700
Received: from build-amhetre-20240731T045122751.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Mon, 5 Aug 2024 01:41:17 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V3] iommu: Optimize IOMMU UnMap
Date: Mon, 5 Aug 2024 08:41:06 +0000
Message-ID: <20240805084106.214584-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d31d4af-bf4b-4792-a6b1-08dcb52a67e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AuS+gMk4ZRTGVwJr4TGfctTBky1h+mj/juOpxX9IEhX3wEkLvCw/RpYtFAtx?=
 =?us-ascii?Q?qMpZpRL3EOZXAu9G5SLGuHRqvEIC9akK/zhCTkaE8qamhJQVpD6iR9ji92VT?=
 =?us-ascii?Q?yZzDJaFepNKbHyzXW9DJ8qUfbG0l8zYunrNErmxTpVzEBF0Hx0MY2oT3jBoA?=
 =?us-ascii?Q?omvICcN07n4FXAj893+LLp8+98Db3v2YCXQ6xwjWiZP6qPgcfsyUbkTzDNG1?=
 =?us-ascii?Q?DNU7Vr82LOkB3dDc/9p1o3Du6EOzwtXgfkfmF0huKW2zowueIFT8LR1a6HLC?=
 =?us-ascii?Q?Fs+0DaH/bBaFF43baYtmfssC3mA9ESyJYYfeoG3KG0zZgUrF2Yk9602k3QRG?=
 =?us-ascii?Q?7iQMo48Y5PVrMML0ODUgfsxulauTDbZ8A9HoF1UwJysKDpF9V1N/L2jPh8m3?=
 =?us-ascii?Q?Z04cJreJZdgdOx+vvgmDrwLwETMr6NcUj+3adJyHG7t7wHLOfiBWBAwMQkqe?=
 =?us-ascii?Q?OUvkO30e2ZcTlxWuIcl4gtJKuVqfFYU5GFne9enteRPO0F8y0JGPYJZ3FYZK?=
 =?us-ascii?Q?lPfeUT8UUOhLsKZqwS8eopvFRNebpr0YTyuM65UvEivxocZKQXVc8SPD0A7d?=
 =?us-ascii?Q?+W+aQZEFo9DeikTD+Fj6/If2j2mxQzJAB4ibyr1u9AstFFRhcQnMVKw1gAP6?=
 =?us-ascii?Q?7xZT1AQjEtk19lQYRBFAs6ExzNuEfYsjQqJ6FDCGVlvHpI2omI/a0mWGSRo7?=
 =?us-ascii?Q?0nmYj+p0RdToDv3k/7bam4vRjXcsd/CO3+eS1eogss7dpIrzzlEsneVS6ZJS?=
 =?us-ascii?Q?OCWMb8iTVEBQybd4OPe1HztdsQ6sHXiV9iUHBZzkmyCoQLvUcPObLguokMbk?=
 =?us-ascii?Q?Dksn3YITe74fg7ASCDUHl6g/WVphFOc7RU97sCV+KinehiaC6xHeKR+PjAfj?=
 =?us-ascii?Q?eVcuaWnuFvWzIwoI7+cAzt1G4yQWsYcIcFQv3Eg0Xqy+2oK6E1O9rFYT3CDS?=
 =?us-ascii?Q?eA9n+5ikFgUY1p2YiB21pFeTkep27SooPa4yqNA5nqe+9M+qjo8t1Ykof8lZ?=
 =?us-ascii?Q?f4pGf8qAoHWHJYF4I4mqwiSJFQPxY+jYhlKfCt2byjebMvaYn9u2WPb5erGP?=
 =?us-ascii?Q?I1Jkw2QMORjwkGx3uLy9jDJnGy3jehL3pNUatTpJ71OqiP49LfggfLVljHC1?=
 =?us-ascii?Q?xiLXi1ZoWFfobW1cRxE9alqegovktBU6eDqAJINaBGuy/BaQFwCfuLtn4T9v?=
 =?us-ascii?Q?3p7+IRxZK55nRVO67eu1CDdZ5Rl/RRExTfklXM7Lx8CUZoe2JVlB3QGpKUH5?=
 =?us-ascii?Q?o/pTkytgn8R+mN1GzgdDTyXRI7w9GLZm1A2y0EL8vXGNYwL5vtRoYtHMBxJj?=
 =?us-ascii?Q?ebnCZPmbDyildsMNXj4tpZ+KYVS6zIifybouuZ9Zn6iP92rnltCOzs7XSXcu?=
 =?us-ascii?Q?ZWVo82XIti24cajY3UqGGJVtDW4jFsLJTFfFd/dpnA2AkaZWB+wdamO9gTI5?=
 =?us-ascii?Q?HcPqzl3htAWaJVrO7K+Qn0O00TeeXn38?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 08:41:31.5006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d31d4af-bf4b-4792-a6b1-08dcb52a67e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253

The current __arm_lpae_unmap() function calls dma_sync() on individual
PTEs after clearing them. Overall unmap performance can be improved by
around 25% for large buffer sizes by combining the syncs for adjacent
leaf entries.
Optimize the unmap time by clearing all the leaf entries and issuing a
single dma_sync() for them.
Below is detailed analysis of average unmap latency(in us) with and
without this optimization obtained by running dma_map_benchmark for
different buffer sizes.

		UnMap Latency(us)
Size	Without		With		% gain with
	optimiztion	optimization	optimization

4KB	3		3		0
8KB	4		3.8		5
16KB	6.1		5.4		11.48
32KB	10.2		8.5		16.67
64KB	18.5		14.9		19.46
128KB	35		27.5		21.43
256KB	67.5		52.2		22.67
512KB	127.9		97.2		24.00
1MB	248.6		187.4		24.62
2MB	65.5		65.5		0
4MB	119.2		119		0.17

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in V2:
- Updated the commit message to be imperative.
- Fixed ptep at incorrect index getting cleared for non-leaf entries.

Changes in V3:
- Used loop-local variables and removed redundant function variables.
- Added check for zero-sized dma_sync in __arm_lpae_clear_pte().
- Merged both patches into this single patch by adding check for a
  NULL gather in __arm_lpae_unmap() itself.
---
 drivers/iommu/io-pgtable-arm.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf..6fecf3d9fe67 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
-static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
+static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
 {
+	for (int i = 0; i < num_entries; i++)
+		ptep[i] = 0;
 
-	*ptep = 0;
-
-	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, 1, cfg);
+	if (!cfg->coherent_walk && num_entries)
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -654,26 +654,29 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
 		num_entries = min_t(int, pgcount, max_entries);
 
-		while (i < num_entries) {
-			pte = READ_ONCE(*ptep);
+		/* Find and handle non-leaf entries */
+		for (i = 0; i < num_entries; i++) {
+			pte = READ_ONCE(ptep[i]);
 			if (WARN_ON(!pte))
 				break;
 
-			__arm_lpae_clear_pte(ptep, &iop->cfg);
-
 			if (!iopte_leaf(pte, lvl, iop->fmt)) {
+				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
+
 				/* Also flush any partial walks */
 				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
 							  ARM_LPAE_GRANULE(data));
 				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
-			} else if (!iommu_iotlb_gather_queued(gather)) {
-				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
 			}
-
-			ptep++;
-			i++;
 		}
 
+		/* Clear the remaining entries */
+		__arm_lpae_clear_pte(ptep, &iop->cfg, i);
+
+		if (gather && !iommu_iotlb_gather_queued(gather))
+			for (int j = 0; j < i; j++)
+				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
+
 		return i * size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		/*
-- 
2.25.1

