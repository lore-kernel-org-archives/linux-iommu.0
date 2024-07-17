Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB703433B9
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210811; cv=fail; b=VoFHYAN2OI4TuGkZodbj+xSdYEuPu5bgtA/JPdU/049I2y9MYrWhukKHJon4mLMMGR7YfExpu2nmfHS6Ukis6YLna1RAqMRCaX2HILFf6q85i0mVBgSWvzJ0XA4KHdGF/ISW2a5weN3gmFPnO0SOXLOBKAaebx+2HhLPMbVLqrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210811; c=relaxed/simple;
	bh=/EtIBweb8KgKn0AaX7UnCmcQYkf0sIs52CQZZ5WA3lA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XeqSlCaGlzQjzqt/8raIRB6rA8XGv8f0g/HyH8NbEzMQKIA/OrJrS6gCrWiq2k1vID+EV1b1QXBYhNy7PcgpY3ywqCdC2YB4Nu0L0WMyKwvCa65rwMADowNmC63OM136NnZ31i0I6i63qVZAkbBY2xXQvzNtzX2Urr00o2v6iZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uS4/E/b9; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uS4/E/b9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKUU5xB5XPfq19hiwD/YTNDscU96SpnWcYsE5++n2TLEdEtETOkxzPnOngIFc2Eshvm6w8hJ+c3/H//WyDwLbxo2DjxvMzYJVXwYTNuK89/YxR8bPKL44z2d2fyvxAF9erCpU+feeY6qXd9VJ2unwJVl5q+1wzmj8bqG/IU7WjN7SRfKixfpl2218Ku0wQTsKAGjACGipJqRDrylABPIm46IXJAVlxVYTwTJDsvWsGFJ574NfuSRX91s9Os0KyGR4wyPhwqzdDckPFZwaScWW5+nRVSmAgOSc2U0IfVekEfbjTaBXgl6wf4hS2B0C21Qc/wgxTjxi3B9hvHyk7Mp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDjPZCWRIbSgtP5xppt2KGALTvzFItgIlDVqzqfEXgo=;
 b=SkjFJOljUmmx4ffU1sgRyGbw1VeKgIMZfW74s93vAqMPg0MXfok83fAj2OCF/N6subWrqAeAPo9gSTJJhf0u9iwO/gqLYk7smyyjQOkhlrHcb4a9UIoQ+6rZdA2r4hEPLMhO8HtuPjUkBdKb0flw1wSkJLMouctVOVi2R8BxT5M1wArlVOGUAhMG73NmDo9mW19Swfe0rz3aekITYM9o05QvRv/0evhmQN7treNIOt6tegzXrZgfywE1TbYRAqJr6hcM6s/bjw9bGyFWzdASasY7dLVm8fjdoAhad+GrA5utAaf+u3o9LnXe+k/B0jXa5IgJgHhU7s7v+VS/UEnrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDjPZCWRIbSgtP5xppt2KGALTvzFItgIlDVqzqfEXgo=;
 b=uS4/E/b9AiO80l8gEZfbjTF39s9InZFpKyFxlYSt+WjQIDF3BCLxjcuPk5qcV5RtDts4IzLTPwRPEblAowA8X0iYzsxWQsu5slf5WycmyT6/GEP4jB1tQPqa/eO0m6SIKGdlrS7hVv0i9Q0jZXPOgNF71GDiG3GafhqCpSaRYd+lJFv4k1dpf9WcmSzNspq7EUnTaAO5cu5VFXRewQbm7bmSXysZId07bzYUO+yiPId2vIiAksyxmzNMtpOei81xI6MvFyh+kTelYpMn8Ik3fyA6RcQWPGMhI/1sHBScJEbmQ7MCJL308Up5zmW4Qjj+fw7NDXMSDahkpGXXIdTosA==
Received: from CH0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:610:11a::29)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 10:06:46 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::aa) by CH0PR03CA0345.outlook.office365.com
 (2603:10b6:610:11a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 10:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 10:06:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 03:06:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 03:06:32 -0700
Received: from build-amhetre-20240716T042216611.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Wed, 17 Jul 2024 03:06:32 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 1/2] iommu: Optimize IOMMU UnMap
Date: Wed, 17 Jul 2024 10:06:18 +0000
Message-ID: <20240717100619.108250-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a91b58-b092-4075-e9bf-08dca6482a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4xWgCqYatPEJlQfIMlCK4VM4MldUUECwhXeDK1yPaxeARtslXGqYtovG62va?=
 =?us-ascii?Q?nu/kLcL/tI5MRv4l1r1MwEZnwTC9hueZFkoXpjkmNf3SmUCHhi8tXvL7ojkR?=
 =?us-ascii?Q?QHue3gCnWcu36pguLeCjtPyV6zUA0gfjpzkpa0cTzFNSkH48cYk/ER3EPFA3?=
 =?us-ascii?Q?/FY4Om1Yk8GqDCE0VzOke1BOYs5FlmsXyNSWeb9woS0KSpM8+OIlxl7ckZzP?=
 =?us-ascii?Q?YRP0rJ41+VGXNCQp5M+G+h0bdiyTZGAFPhtI9wbzwaqOAnZAY5AAI4p0xOQv?=
 =?us-ascii?Q?G2xog3kjhTrCqvY/di+RbJlJokZaiZi+4rESfTYxijohH6h7hVi9keYwPsjY?=
 =?us-ascii?Q?nvNMz90dOOqme22pdPAZVhlNIT6lhhaSjUlW4ijRUMJ5Pt8tRicaCtkuoABb?=
 =?us-ascii?Q?SKETUYEoQ/+QEVnQ9HfQEHUlHQxu7Bl7a6BzFij9jIiwGLsFugXjT0G3nAbF?=
 =?us-ascii?Q?I9xVZUQ+cyiHnFTquSb0JT86cZsDSmZSJhCAUWbsGPaFaaLoMIu9kZUrDsW4?=
 =?us-ascii?Q?TGUDmwUwSAnCbH/WvFZm2sRpXE5RbWX4s9W/IJkz0hrJ6O1VpAStYoXSlHiI?=
 =?us-ascii?Q?ShiKliwvx2kO9LweoYjMwP9e9ISm0DUdk3q/w1pXRgO7QBWDSdiDxQAfKYjt?=
 =?us-ascii?Q?Td7hp2dKsdKlzjPEmE/+QiTDZXBYGrvX9ln4HJvACXt5YMGkxKcVIIDqpykd?=
 =?us-ascii?Q?PD8hSg8uMIp2QjV1UvG207K2k4+6UEbggTveeN2CIzER4BX/Yx92RR3tLwrf?=
 =?us-ascii?Q?RsUrBQ27AvxCwDLVRTHlOTxC1atzBbQm2mfpVA0fAqPK0BNOKkL3rmoLQlv9?=
 =?us-ascii?Q?VKAdl1iWzIsBwMGAosgWgug1RJKgOBMiZIxRTOFL7MQe32BGCxH1AtC/Ng5D?=
 =?us-ascii?Q?qyAExKvA9h+y1fnzqmUZDUMjJ+AKcS+I7KOZHXAiU+Fo0fx4TZbZdoPA+EiV?=
 =?us-ascii?Q?QK9aNScqjWIq+HAPMqIk8tQ19gZpkrsypDwpCJstYGvtifNE/JJ0LTniTG4D?=
 =?us-ascii?Q?/+53IPSfKVQVzN0sJW6ptb5sVac4H7FWsT39Cm7kNwVAvSSd7FNNvnhEbJSp?=
 =?us-ascii?Q?6aQimFNuG8YXxTs7GCGYH6yJygWMJ+ExnppVZwlEEg+5Nrl1TFDcYzJh762V?=
 =?us-ascii?Q?JTCUIygjJozYEm2EKSOkjFbblik4cr5MFscqXrDWpqUb/SgJh0uAQcu6IbrZ?=
 =?us-ascii?Q?x85xbDXt6KE0Kh9lYJiNCEoM5tVrx0kijTyO+FFJ55BltbvmIhK8ES6g8z33?=
 =?us-ascii?Q?w6Pjfef8KGD9a6xw1ayRdyAAP8oFQnGMz/m5ETOBiGJVaB9w0pgh84eiecUh?=
 =?us-ascii?Q?fdqKjTPYKrba8/RiUO2Syg+3xb2uJi9HVCr+Oz7MN4ZdhnP+zpqKP9RibnqH?=
 =?us-ascii?Q?N3jVwEp7C2NA1ymHjujT28TZBRrQGPT50XSHHaatejsCY/YPq66OszPiAN7U?=
 =?us-ascii?Q?cNAnu7gwwWRtVQaaf4ppbKXtIxlsyu/G?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:06:46.0725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a91b58-b092-4075-e9bf-08dca6482a98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

The current __arm_lpae_unmap() function calls dma_sync() on individual
PTEs after clearing them. Overall unmap performance can be improved by
around 25% for large buffer sizes by combining the syncs for adjacent
leaf entries.
This patch optimizes the unmap time by clearing all the leaf entries and
issuing a single dma_sync() for them.
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
 drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf..1787615eec24 100644
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
+				__arm_lpae_clear_pte(ptep, &iop->cfg, 1);
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

