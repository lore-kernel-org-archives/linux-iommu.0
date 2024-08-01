Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047373EA7B
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483301; cv=fail; b=i3Xtpspp3KZPVw1VMA0AMajtS8KKU7IQS2o1R91e0jOIOfX2p6XtBqrymmNiRZ6uiU6ciApbsrfZV67wO+N9UVssFo6hASrcYYdPxeqGdd2Aej7W+4CJeLwvollvckMLjCk+PJe7HAPtVGYNxa1LqizBaw5jbqqFoQr+UJpiK24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483301; c=relaxed/simple;
	bh=HGFLKL20xRPOOHQ9sfEYVvCUWB52rNg5J5OjRVZSkkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FnYRRmpFCLob8rxAzmN3KHsMDHQx6ahV0KtxwnoLbtjEHVzIurhyCKzAA3cwRVRK8t1WbIrS1Awz8HT6oCvD7G7YSGkmgkM5YtTKyWyWfwVsMIowqvPKVApXydmIb+WGmsJKaIheeUY36WBZhqRdPUsUqqr+iwIKB3Z43jDvJtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DAnzzZ1I; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DAnzzZ1I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9DqrOwHommZwbku86hVDiWSmcR0ACildfInQ5j7ZI0yVtwkU8YMaEmfZlBcAQeuMHWTncpSQRTXZBE5h/mnzlvi66e1/eTaXk/kD/yRHWgr5Q6UHE9GpNxs0pVkxLENawXp80XrDXiosXjcjVZJHb3fh7/NTTb4YczFahEf01yI0iDQZeQO3EC3V48j44IQTyam/chsywoWLUvuZzRHQSG1JP6vhX7mEL6tmuAV8d1XMMyd/7euc3Ypldli7YVZDZgCd/htd0I5wqlNKOMPINl1CyDnA9CzjKEZvyQL5HAOUvxx0T0euO9DErjVIoCFIo+V3vmeZs4JfjU8QH5/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lRD+KA6N48RPZUXEFLwVI5yQ0lmlX3wTX8bv1psiTU=;
 b=p7QbrSHzKGUMGA+NkgSybTSb2PAvUal1NjnBfXyZhEBDaAaFQ/p+tXN5fe+LAJ8eWkq0SYzA7aLvfa7gM9I+3uvgyhoZ+hsTFg4WTM9E8+N/Ow7eUqpAdVF/4aaxHPJ+lViouXaQrIYRfXEb6De+ZqMp1xp40B7IquZvoqoTZ0JZcpsyb/2H9KU1Ur84T8LyUoVdJZKxYQ4FNQlmw2jQQS2pJW+4hZ6GthqTxRjDsrO5SulHTSpu7imeYOcUk/wrRYN7YDvx3vlioX3jhsjUtHfrhDFtk9FlyRUJhw/pxmE7r8oFipu5CIkka7ehnHSBSRhnXgrDbwTqRcgT2qLXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lRD+KA6N48RPZUXEFLwVI5yQ0lmlX3wTX8bv1psiTU=;
 b=DAnzzZ1IpBwZCIccAHo2fOBRD89gpfwGGa2IKjdfmCt3l9nfjNAIY58b6shtOtExdnxBMgYEMEQ40hg9alKC36EW4e/rqbO/JlSV0eQpsPaaozS/iIB9fTmJrN9tlsrI76nARnDt9L8noiyzGvRpKXiRe1hJ/Y/pcs/jqs8G0o0MrhuBHf4PNTXyRhjjRV5yOiF8MzOkfFbWzgduoNnxcW5E7HhzsAwX1Holfj0pwNm2RDZL/oCrzWl7SgtBM4JEMxlPCRiB5xH1Y9lr9juqT3hK7h6bm6qVmpX+59q05rSnceXRAnpRyaJf3HFhUKngYlwHF88zNtbRBe5aS+3IQw==
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 03:34:55 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::30) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 03:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 03:34:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 20:34:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 20:34:37 -0700
Received: from build-amhetre-20240731T045122751.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Wed, 31 Jul 2024 20:34:37 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2 1/2] iommu: Optimize IOMMU UnMap
Date: Thu, 1 Aug 2024 03:34:31 +0000
Message-ID: <20240801033432.106837-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4a8e52-7064-4897-8f24-08dcb1dae834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LdnogwXBDhJIaWKS1nupdOhgxtkENnZ3ffdUFNZHmQVcOmnnuzTolEOwjypo?=
 =?us-ascii?Q?KxKYmfWgVTpGu85G7aIPEy/KMGJEplLFL2OGcClxp8w+ELNMAmQVmmOCmXv9?=
 =?us-ascii?Q?5tJLuEaMkihVN2g8gW949yezhKDaB++88dWSkkJRO/kg5W0nd0Rhi2Gtn8rf?=
 =?us-ascii?Q?PELkGsJOUF2Q4ho+kOoRqa25NFZ3NUq9U9c8ZmmkJF1+WqRBic05q+92NZWU?=
 =?us-ascii?Q?vRFYJSiqlIuCw303KGQHHK0aMf5ulbkD0Yp3+QvhviMujjNUzsXYRggTozRa?=
 =?us-ascii?Q?AzTOY6gTTY7pU3UtevjznWIjm0GLaAIFtpGXqwaF8l3RmOHedZY1936cnvrY?=
 =?us-ascii?Q?ZaIFsIzDQuKvaBYK+TnJZlzHMA77XrPbYXQoWT8MFFz+TWwqyMcNfcx6ql7j?=
 =?us-ascii?Q?VXRryUnloMt+k+aXdP2eSKbyYe5nJD8ihlq8E2BYZBGPQ0ru72j6oFrmnjMl?=
 =?us-ascii?Q?bisM7STlGB4l6cBA1vOjHUXRkSQDQkIzou6AxPYmyZj6Cs5ArukWbianNCDX?=
 =?us-ascii?Q?ssxvKqM6yN1IyYZpl35QGsaFrEVszi5RbuJIl9GjY39TDaGoe+htMwkOQuKw?=
 =?us-ascii?Q?Hift5PJtNSxxIpC8WG1rlas14oyV+F7j9cRUFKhmhFIfqRcoR9WGQ+tUGfza?=
 =?us-ascii?Q?pe7dhBqj8wkbDPldNaWmi9sItxsqthwOvD3zpYvGsIJPV3Ol3v/UO6qeHroB?=
 =?us-ascii?Q?BEZ3Iclg/MnpUaTvssefeiqSBl9u151iQeyz2w8n/Y4qLoR2gHUGF9T3OU7M?=
 =?us-ascii?Q?TIiN36QUMLtFtyPs0y3QI30rk+aiGvQp6OLVvZQr2r3qB+NpsxwvggYGhGuk?=
 =?us-ascii?Q?PRWF1bXmX5EJBfhQ8mZ/sfIxcHHYrYLUaf05aPKh8JJ8zNhZugkc/OrRWPHC?=
 =?us-ascii?Q?QpabV+gHuCTPYVNQeCD8i4kmlOkR5uCoSkHffLEqRX1KWSPXmFNY38n4IAm9?=
 =?us-ascii?Q?2Z3A/V42UejSXG2GhKJ7bjLiTWsjrDtCyt1DhGtwVjnK45R0vcvi3J733zAM?=
 =?us-ascii?Q?sCB3SS7VnGCfG/12hnh/F/sXLcldod4psDbdEZRdOW+DxUcYp6vh2MIA1kxX?=
 =?us-ascii?Q?J9eR1cZ1v2j9VFdxpO+tRXTyMmZW5+KHnVFfPAAP/4hpoOQow1GcYJAI70Fy?=
 =?us-ascii?Q?1Nwt/Hinn2RZnGrWsmMaC15BbsmhFx4LMQmwFBQYkiMSD5VZ1FITJKd5C8y+?=
 =?us-ascii?Q?c6OjzHDOl8yLSdc2ioTLzpz5OgATceA5FJFYzv6FLYxWAqpb5lZXXg6SwP8z?=
 =?us-ascii?Q?o379hUljo39XtMjGwhB2zgbjE4gGZYeDTcVVUODHuNs6gOGL6NroppkDmvdb?=
 =?us-ascii?Q?S69sID52AGeW6q51g5PvDyQWVJT7fEOw9B8pwrbVBtPD9tqj949pT/OYqfuN?=
 =?us-ascii?Q?G64/QdJ7NsLS7Y+olPzlkio8B9tZpsrai8ObRG/9mF1hbm4ZTWfRAafZzSP0?=
 =?us-ascii?Q?rHUgXzcFL6JdZW4YZJyGyzopIKz/uAld?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 03:34:53.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4a8e52-7064-4897-8f24-08dcb1dae834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

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
---
 drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf..32401948b980 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -274,13 +274,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
-static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
+static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
 {
+	int i;
 
-	*ptep = 0;
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = 0;
 
 	if (!cfg->coherent_walk)
-		__arm_lpae_sync_pte(ptep, 1, cfg);
+		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -635,9 +637,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, size_t pgcount,
 			       int lvl, arm_lpae_iopte *ptep)
 {
+	bool gather_queued;
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
-	int i = 0, num_entries, max_entries, unmap_idx_start;
+	int i = 0, j = 0, num_entries, max_entries, unmap_idx_start;
 
 	/* Something went horribly wrong and we ran out of page table */
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
@@ -652,28 +655,33 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	/* If the size matches this level, we're in the right place */
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
 		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
+		gather_queued = iommu_iotlb_gather_queued(gather);
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
+		if (i)
+			__arm_lpae_clear_pte(ptep, &iop->cfg, i);
+
+		if (!gather_queued)
+			for (j = 0; j < i; j++)
+				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
+
 		return i * size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		/*
-- 
2.25.1

