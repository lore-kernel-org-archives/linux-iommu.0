Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF913B2BB
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434402; cv=fail; b=AU7o/8i8rvSjqtTU9OCz77gbdIBOBMVm8gioHTzGeFNfhyKQHVatfikXelixNiiOyj0sY3v7kHlQc4IyRtqdD6KoN2s88KbK4/d/x0f1dHmR9mhVUtkXRFreqTyeuENV4cIKojBXXiSa49DaqISkmYyBXczm/2sldkfiCa7R2WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434402; c=relaxed/simple;
	bh=6QlmdXW5kyFM/T7oIL5yu4drlXwrl4R7bVg4kL5bnHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CtVL7jKV3UH3mjGUBaTHUaOnaKqBYPr5TWUlczcEzmWBk3ABFjHhpmJVgk76V6O+SrQukkcl+BAFzT1vOSiseKFmXPPVuSH3ma4s91YGmU1mGeTY+B6ke22kTHRj1Ql48BMZcZO9hw+w4GVh3sc0cm+GNnBAHk5vSyyKGzCkzV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rUF/lxnS; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rUF/lxnS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfwfmMxxuUwtAIX5EAg3973uJ8bTxY4HyBxvYFEN9OLAHo6fcYUM2WlfO6n49TzuNRzrhzskSDWhh326RWz0gEoG2CMzvC00hru/IUfCvHnskcTSXgIsiIUjcSiC7T37VZH2NTqW0q6PENxEXHUNEqBBgCyrsS4nCM6la04KhxkKbUlfZ1iKCaUk0PiqxY4miNo59IEnMVCIxVmakt6q3WoqWYAwc5C/YkZpX0fPHuYookLvMj2IH5XISKTTDJHzjVg2mTdSnlHCUiI/EU8PUk/sBZtZnMOCPjmfS8xy/P0eALiX18mJFMp7YKmst7PnuY6kPzLqA10YKpOhR4qr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9STHWwWg51TeZjiq97CvnN3cIPG+FqJJ8OijIJ8J6L4=;
 b=itJWiiXGGIN8NcLoj58M8P6pNBG8Oof5scjLpimNelDywsuTpsXb3P++CBCp82yjZlebbr+lxA6ZwrrY0REFj+INEwnOfsGFl2vrMe8L5Lg5HxhTLMz2fO9EeR2c5fUZvX96fdNFBYVW8wAL4fVVuJ35QacQhtl26ZLi/XTiVHALVspxZJNueIrouxThVj2BrCm7TJQe6IMeFvTOmYdsxZcmlD00Du+Gx6pC43TCbQlPdgJvyCseJGMMQXYdztWzhUfLFjXMFTcHGJ+12r+F+VsVKAvW/v+CowW5erNpyQwAezgSJEepL1bXaBt27FMUVI1uzYF4a5OPpHZjpjqi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9STHWwWg51TeZjiq97CvnN3cIPG+FqJJ8OijIJ8J6L4=;
 b=rUF/lxnS4ANPI6EO5Eob9MwQjPjHj+alsUyRVGno+o5Y6Xwrx1VTM95/S6qpCh2n92BPOek/57YcXNAVWDFx7vEgu4QRcQaSeDtLNISq2fpiaip70ORuAAo1+JsuYmgxXhE06q4SMvaA73SbAWDYcLCpeVA0d1CEH45F4BRDfmt+3WtO0ar4w5rTNz4ly4HGYvQx9lrIZ2g8NZuY+76gPF9cQ/9fc3rtlhvTEi21aEzh4r6sBsMQm6/uzQZju2hgCWxYCIZ8AxgmdSM4iyb4RlGF69k6AhzXW9eEFAc5HGhhsGKlxzQ0PPrJTMjcwUMrpsFyhQL7UV9GmU9mpfg0Tg==
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 03:19:55 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::be) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18 via Frontend
 Transport; Thu, 23 May 2024 03:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 03:19:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 20:19:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 May 2024 20:19:52 -0700
Received: from build-amhetre-20240519T173508142.nvidia.com (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Wed, 22 May 2024 20:19:52 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <vdumpa@nvidia.com>, <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [RFC PATCH] iommu: Optimize IOMMU UnMap
Date: Thu, 23 May 2024 03:19:35 +0000
Message-ID: <20240523031935.90856-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: de019a6c-e93f-47a4-c6f2-08dc7ad737f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JutOxr3a2/MVnHBBHnA3+xmyhjBjCWpnNWTxYh2iNFe8PaTUuikS/hBDmMe8?=
 =?us-ascii?Q?7ZueDKxcjWWgAzTHsAHvKdwR6pGFHTGeQH3diTJ9N72WNPlVdqGFVdS0dup5?=
 =?us-ascii?Q?TROH4jrHcqdog2hzxP6zV7iUY+Z1FbAXUGIxgPJGw8MTVtxgeK7QQDRq251L?=
 =?us-ascii?Q?F7Me6k7nShnfwnkhVhYZuZo4jPFnxCfcmUypzy9+3uiBe0yVk/eaKPnqeK2o?=
 =?us-ascii?Q?cViWPkOCwvjTeQpvhKq4MKernNdoV5kqftILfKypdXRpaB+yVCtxf1AFfWAw?=
 =?us-ascii?Q?BooGDpUMJOYW1vwb2i+H+iYQz42tAa+oD8DtYREWiLZ2YmRPykRhQSUm1Lt8?=
 =?us-ascii?Q?6xChe2e+Swy+B503uE2NkiyUxDWg7o3TUAkaHz2DEWytpsY0K/3SrScOpQNr?=
 =?us-ascii?Q?J+ItvLFhiV/qaZXrHJ1iVq2AsARJ4p3NCh9CoxaHbr6AEXO9sIkVMyw54vUk?=
 =?us-ascii?Q?hXWYd3g+iHM8x8se7Mv2Jb8Vhe1n6/mzjeKOPVQYUPxfzOzCXuXOycJmo2/E?=
 =?us-ascii?Q?KjByJmGlTGOaSzcGuGpKcdsewjeJy/IEiZbniuBeG8ldzuvoLKkXG8YqKls+?=
 =?us-ascii?Q?ygm7Z9DmEvPPo2oKLmu593GbHeDnsZmxmyZ15shMNJgjqYdXJIPX6KOEyqGv?=
 =?us-ascii?Q?06r3GcoAVgGpQQUmq+ZRPmpFvCwzTPQFqmWcaT4LpwDc2h473F7hww/uiJcm?=
 =?us-ascii?Q?GM7rO9GZ9fsUt1uhkwbUYxUtTayah+N4yz6cKdw3CQ6ri/SVYvbxKx3wNE/K?=
 =?us-ascii?Q?whusmu/lKozW2wOuNc4vslFrLvQE/XQqN51VSSNh6DRjieLEsnOFzUvxHHWw?=
 =?us-ascii?Q?vMSQfNxtbFEwRM8UuoTFqd8FgjlrizAyQ0NHOg0qMTyQ/OlwVvBI/fJwfZQ6?=
 =?us-ascii?Q?UH7WyTaePNWCzcdW9NRoE9H/eI01hATDkg9A9BUQ6ZNG+gD+kSAhmJPDX1h7?=
 =?us-ascii?Q?triKy/q67YA/OuMg12Dw/C28ZZdX7YgQGiYletu187ZdTZcrAThz72NuGAqR?=
 =?us-ascii?Q?TpoGhoqCBWT8Q4omN4jKrOJuQwB6jL+HirVPxsW8EMUYHAIxNohZcZdOpl/h?=
 =?us-ascii?Q?CDIny19I3nIlMxMMA6hZ6zagEZ6RZkAUGR2N3zAdduGbBTc+S9Nu3oau19gm?=
 =?us-ascii?Q?Du298UND6mvx7eQIHtKHSXNeF6WugitqWO1Xxd2kRQ2p6zoHVWcY3Hq3vzOg?=
 =?us-ascii?Q?rk/IXziul73CbdBbuSNyPWm3Kfog0dNcdRuKtJtQ1odgdYwplGHQgOOzksAJ?=
 =?us-ascii?Q?JvI67E1SF746b5LtjOXGd5XNzHamTmqjP/3P5QIGBIlHisTFwcSzqQfpfOSh?=
 =?us-ascii?Q?ir5Sj2Wq47Gsyy4C4GQyPqJHQZwsxOblD9blYb7eq7y1KsbNj4N/WOSQlr1g?=
 =?us-ascii?Q?2zmjajw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 03:19:55.4438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de019a6c-e93f-47a4-c6f2-08dc7ad737f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

The current __arm_lpae_unmap() function calls dma_sync() on individual
PTEs after clearing them. By updating the __arm_lpae_unmap() to call
dma_sync() once for all cleared PTEs, the overall performance can be
improved 25% for large buffer sizes.
Below is detailed analysis of average unmap latency(in us) with and
without this optimization obtained by running dma_map_benchmark for
different buffer sizes.

Size	Time W/O	Time With	% Improvement
	Optimization	Optimization
	(us)		(us)

4KB	3.0		3.1		-3.33
1MB	250.3		187.9		24.93
2MB	493.7		368.7		25.32
4MB	974.7		723.4		25.78

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 3d23b924cec1..94094b711cba 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -256,13 +256,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
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
@@ -633,13 +635,25 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
 		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
 		num_entries = min_t(int, pgcount, max_entries);
-
-		while (i < num_entries) {
-			pte = READ_ONCE(*ptep);
+		arm_lpae_iopte *pte_flush;
+		int j = 0;
+
+		pte_flush = kvcalloc(num_entries, sizeof(*pte_flush), GFP_ATOMIC);
+		if (pte_flush) {
+			for (j = 0; j < num_entries; j++) {
+				pte_flush[j] = READ_ONCE(ptep[j]);
+				if (WARN_ON(!pte_flush[j]))
+					break;
+			}
+			__arm_lpae_clear_pte(ptep, &iop->cfg, j);
+		}
+		while (i < (pte_flush ? j : num_entries)) {
+			pte = pte_flush ? pte_flush[i] : READ_ONCE(*ptep);
 			if (WARN_ON(!pte))
 				break;
 
-			__arm_lpae_clear_pte(ptep, &iop->cfg);
+			if (!pte_flush)
+				__arm_lpae_clear_pte(ptep, &iop->cfg, 1);
 
 			if (!iopte_leaf(pte, lvl, iop->fmt)) {
 				/* Also flush any partial walks */
@@ -649,10 +663,12 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			} else if (!iommu_iotlb_gather_queued(gather)) {
 				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
 			}
-
-			ptep++;
+			if (!pte_flush)
+				ptep++;
 			i++;
 		}
+		if (pte_flush)
+			kvfree(pte_flush);
 
 		return i * size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
-- 
2.17.1

