Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C701BF33A
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941525; cv=fail; b=TE57Q3xKpkZfUhH+LOG6qs+0EEHJHnA+cbD5zGQW6stkRp8G/WFTxMf1KEwOOyc8TKHN/CGqYkS+/XlOuFj2PYtLrieIj4qMbEs7kkuK2s1oo4QqRj21CekHltnU7a/guwFqIG2jT+/9RJh0XKUhMOR4YzOIapJTGzYWJ03X6a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941525; c=relaxed/simple;
	bh=+mQAGvfPCIAB5wAIwT5kxcIpDUD/FVFdDWEPrvSDEuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C1+5GYFs7erVHNOkEtgq/AYrU8ClkRCeYMkydXtS3MKGUZycWhZqLDxQ8zcSk7YUQshJ1OVTgueaER9t7aCj16/JD+PiKAUgixbxWj3FXR9bDQN7w5vE98NlW0pBCZD7fYrVEXKWwMK4Ry64q9KHvWncqxXRMXqAJmf7YIuv4XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVGv16ei; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVGv16ei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3hNv2MCURmBuuzbjIfThfCFbBRT/SaPz14bSP+JYYbNBZmfB+uDLfXH4El2fMzcbfJEdVeZ6RGyoadtknEGRXg6yjMR0ynOzDtjXAFLQSeF7/6ZCbBp8dVDvicWXEtt643yV7y903vbnj3pOEiixyKkFxua7dhIhuqWQxs8iFgUuZmSLKSEZ3UnbKLXJRNtK4Fiwlh2Ibj8f+kj1uLoXEEWlk1F3CgVfF2aKE+NQruoXdSNbIq5zHFOVsf0mIiodORMfCkjCuLxnN0CUQ4K+0SrasDpx2VkkRdI9/DYlBs90Uw8qAqYOZ74cNS1uNZdSVE/oR2QftdDE7KsxowErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8BCV6Ioh7qJW4s1LhWDGNq8U+9yH5YiDLj8PBBh9RY=;
 b=kuIqzg3pkJcQhbG8zB4TlHwRLbT84p2uPr42M2M0FqcuYv5xzPEalqCbmrsrTgYRXe53L1U/PVc24ZuKtbOh9MV2yCfmeXoQQFtpXX2QTpVhfHoLr6sR/06MuX/MbLbXdQgpLhA/7U/ScTc0f3nlP1Q2J8VoIqenQ6L7M+RiFBjRG2m3Cmgzz1gfZFvRc7HaKn7BsoyaYClvJldgowT5PI2cXGXwagQjqKWzVZmfUOUCn+S5KPZbadKqDe8FKzCeShDud0II5iRv9D9M3qV9l+aACUb/tY1evBMyOu9Ns0VZNc8zgMokkviAujwb+5juZchUCccSzmYbeqddibAOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8BCV6Ioh7qJW4s1LhWDGNq8U+9yH5YiDLj8PBBh9RY=;
 b=PVGv16eiq4xRjv2kUomtHkVO3/ybvw2VKHxxFM4771RLH7S8mfASZenzX29i7nk6kmihWDYvoKH4e4nmuDW/jyyd63hcBHWpsY7lEhkftOvzgC5/bbJCupb9h0u+0W/MfPLNQ5yemx/oGNec+ytqUYJUtDAJeykrN7U9vsuOQyAssJjiHclfN5dnDVnwapJz0Lh4CthkPbK420/VUxB9QtKLZp8ltNr/ZpgEcdfizqCpgTVKXJktL7Z9frxRpe8qUQAG1VV/Bs+jyTCohfq6P6T/6qQyUeuwonlm3EqH4NK4gj87JYfFwYebMrjRoyXwPgvXPu0XkdyZrm8y4hi4lA==
Received: from BLAP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::18)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 10:51:56 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::de) by BLAP220CA0013.outlook.office365.com
 (2603:10b6:208:32c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 10:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Tue, 6 Aug 2024 10:51:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 03:51:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 03:51:42 -0700
Received: from build-amhetre-20240731T045122751.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 6 Aug 2024 03:51:41 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V4] iommu/io-pgtable-arm: Optimise non-coherent unmap
Date: Tue, 6 Aug 2024 10:51:35 +0000
Message-ID: <20240806105135.218089-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6452eb-8bb5-49a2-5595-08dcb605ca23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JU+q20ApQjdGb9JffN+QkuO/KQG7eo21WtHjYUdjVrMBHkPerdPkm4QVqOIH?=
 =?us-ascii?Q?ayHi27zqCH+RMrtHwgH1xi56W5f2a748fCY9EaiTne0gxefmhE+uMH4zFByb?=
 =?us-ascii?Q?6UVzapWxuq5CfnT28IMkfxO81o+aU3jsDNCtW9PTEjkaYfVcNLigEqYgV2/m?=
 =?us-ascii?Q?FgOpCYyD6gE4PRRgajQT+jMgh6rKPHxKSrjj5EGOTZkiqu3HKn3kRZUW3Ieg?=
 =?us-ascii?Q?Hm16aVM2kP2/uuXbmJsZ1h7MmYxitgQTI1y8yPjChM6bXsxssHkm3fxCTeo+?=
 =?us-ascii?Q?y3T2S5NLd5xebVwZ7lwRj3be0UcXZH6tYRwR0IoytBUcYZQ/IgcwsTsScWTQ?=
 =?us-ascii?Q?8wXVuyqCFZ/L7Hy7DgPeNG3NvdtvtOVdR7bFU3cM1CIaLj4bEhPQ0BifVPy5?=
 =?us-ascii?Q?Zr21KuM4Uap1cy33FPtFLAK6ENNtjaQsvV08vvDx+QkEHB76dE57ozoRkZkU?=
 =?us-ascii?Q?r+RJTT4f85RPHiTnaq8EX5i0KIvOZSrABqrxJafXheWF7ZivM/6afwrrkYJv?=
 =?us-ascii?Q?jaVtXGzEHXq9BZfhLJO1poYPCtBPIbgtEeVq7eiTVNY0qg3w+vFEo2PbOeQ/?=
 =?us-ascii?Q?dNLW8IeshFUHV4H/+XDwtDVGrbkiXUI0PMx3w6gGUN7QqJ6fY19uYPISo4Ol?=
 =?us-ascii?Q?NywGpUMkP3HedO/1fPKqwLrSPglgftt+XW9aDCWmZnhR93WhfIbJCq2Fkz98?=
 =?us-ascii?Q?F6FpZySjutf7CdRgylvEqJeXZCKaECm9g4WM1dqGEXxnbjbXpAKYaFg9ABEJ?=
 =?us-ascii?Q?yv0CXME1YkfugxFq5zMSX3hdPqZEZIZovpAfuL1sNmhSj6p4YdE4MWcOBDXU?=
 =?us-ascii?Q?ddTLuR7jmjR/UpW/ogPOrDkZuDrwYcxeh87DT5QkPrboC1+w5u7IVDN8OZEL?=
 =?us-ascii?Q?2/8s7or/f8VAdd8TlFlByNf3iNu1wCCdAW1qrK+HckzTBa7Aqunqpb60pQn2?=
 =?us-ascii?Q?cqbUT/OJq87s/H6ClZurCiI8vtBUW6YsqgmV/kJmxhq5BnoCrRaH4oN8CtU4?=
 =?us-ascii?Q?FYI/Yz/x+oKVuacayHKXjlqC4ipmFCdLONKBZ4czHYBgtwzcIfsDT9ekI7cE?=
 =?us-ascii?Q?Ji9AZU1SSb2GpFoZV1tw1Bccq9K6bmpqzed37ms/Qudsy7f2NfydnesOBfZp?=
 =?us-ascii?Q?e975USZafotQWjanRkXlwuMRotEkyHQnANEGogjJvcaTv064pFG9PIOmJ2BH?=
 =?us-ascii?Q?X/NAUfa5OyUCbTM5Wi2GdXMNY9HjZ83OTCBOh/e+xFAZc9Nx7TYYrz31tMbC?=
 =?us-ascii?Q?MKrl4icraJ8GWlcmUcL5M4Xx5gP6SASwUQZvKz7IrMeJWZNd7uBKwvSSOdoX?=
 =?us-ascii?Q?vwOhQQHAwYgqSgxzMDTH+4tnmevJvZTieV4jH1RiG4mDf+GxD3KPGRWfYLYt?=
 =?us-ascii?Q?VTGO7+TE1iNu6vX3tJCZSMtZIRXzc/v1BP4jzV+8uvECVtPutWUbckKf6/Xv?=
 =?us-ascii?Q?beufdAz6dG86vAUUlO+KgjOVV5/XlXAs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:51:55.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6452eb-8bb5-49a2-5595-08dcb605ca23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

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

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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

Changes in V4:
- Updated the subject in commit message to correctly reflect the changes
  made in this patch.
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

