Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1D359F8A
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607381; cv=fail; b=bSC393eQODgaTDTuCiALB4Bo3mBO9BcCL1WLA2ih3rlVYTga/6fnnb7MG0aDhLSoBkzkDeJn24p1rm9i28UZ6iYQidVDedgmfBiSHdEkaGSD7XRPDdq8XevdO1VmJzLzuVHocYFZqmbPnz4fGOSm4p6l5WkUsLmIOwV9e4dWojI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607381; c=relaxed/simple;
	bh=5Dzyiv8B22lyixXvY3eu6P+LEhW3kT02rnDaSJc2bHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pd9CeYbsfSn9Txo5Sv4vwmuzuhY4W/0165Xl5btAZ3CIZYwuPm7DLvHYDVuK1PI+A0Luv4i8dRAS209pryXJD5cA2IyTtdbjFTpzFxJUCTXIkPomvR2K5ujV5yL7Se1dIe+2fJ6g2xMMPBEhYqEmDGEamG3JvScMEPEoQ/X7uuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KE0QQAWy; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KE0QQAWy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9ZVXBOiYHgw420ZbLYVkR1fhOtDC5hw6EwGCx+RufPtehLgHBxL0jhQcBgHnoQteQWPGzUktdintU8fjPzjJAwLMaXuZcqd0bXbFeZb6F35HUFW0CYDEejYeB1qSsmAiIxaeMgmp6rIdUq47dpW21S3JQ9oFT9o2FF0huL87Yv/xYZhlmngp14V9Q4VewSVp99AqNl4AYLmuwq+KLzOQGL+SZKtwSdp1lXTMlTIBjN7OIJcisyGn54cKmtj0hv10/e6ZZLfSFGfBKaLimyvQfcLcvuDch8ENFek1dW8f/eQrscc20DybsabT1LPOsCBFzLUh6+NgkB/6xsa/UyW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVlOXwPFmbm6yKc4UfkbVuMjm5RkG1FffNmZbQSggLs=;
 b=rM0EuZC1m82xd1cQssOcwnQQgeg5zaqyVVqUvZv4m1SbYNHUA686L/mlrZkAAqp0HqwkoY15uL1hnffTN6dpv6RNk0E6FMH6w/87iietJl20ccs1g2RSOvSev6JAayoj5f+YZIcPqfMstJjTDLlN3t1ud7WY17Pa01qgfQ/SNGzVIefXW5coW5ceY9JUC+UWLlpqc7Pn1vD3FoU5REc0GEVCsWnJpQH66qhosPQW/Olr2sGdm78v/gtw+1UCraBlRqqAPtVmVe4goboZq1/r5Lk0mUW8qc/aNE1RKy6jhNkCi/gm2RXErUwXVAatNT3p/LsZ5JX7h6pZzY8Ws6InbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVlOXwPFmbm6yKc4UfkbVuMjm5RkG1FffNmZbQSggLs=;
 b=KE0QQAWyNcfL5jPH9diCm6m4GsJnj3BfVROfQ82IQNCSEfO7ZKVnc6za/ZN2OCj/xaZ/OYzFd430fBesRvQDMQ1btyGnmEpsd9lLq9GseCppa28kBGDDfa4qCZcQav0qtf6MmmdfHa6T7f8o3uuxyvzjT9yVkWnbBOdGQoOQPqI=
Received: from BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45) by
 SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 13:36:13 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::6) by BYAPR01CA0068.outlook.office365.com
 (2603:10b6:a03:94::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 13:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 13:36:12 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 07:36:00 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 07:35:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 07:35:59 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SDZvpe2034485;
	Wed, 28 Jan 2026 07:35:58 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <vigneshr@ti.com>
Subject: [PATCH v3] dma/pool: distinguish between missing and exhausted atomic pools
Date: Wed, 28 Jan 2026 19:05:54 +0530
Message-ID: <20260128133554.3056582-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: f66eca38-7a4e-4c88-6e3d-08de5e7233f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJ6RHBNpcB/E1It53Hb1/tLt14Dh1/7HvmzF1HB0ktj5i9KB/0uTZjtLbXfa?=
 =?us-ascii?Q?8V7trLkgAlVXsGLVbU32GyzRq/KYpxHYkS6uFWtTfSbCgO6nm/79nX4Hxn6v?=
 =?us-ascii?Q?YOnYaV8oiOCucJtXWVO3uv/7qS1qockVH0AhB/79Tag32aVqTDy8GMPKvi1J?=
 =?us-ascii?Q?ZuBAhkHAX77RPXUvPUpiQsSUm33NXh7RKf1RgLZADa/brjPBJeUKTbGxeJW5?=
 =?us-ascii?Q?9hix4I9LOTL85V5TO8sYx6Z0t7kN29lMTM1bDSl+so8auGbPahqKhpwD3qlu?=
 =?us-ascii?Q?nwRWK49AF/tMjktkmeVJ6k0zxgFmb+yBCiytfXq0uSufVMnnW1/OK+aNdKo6?=
 =?us-ascii?Q?Ai7kBCxETfhgELHsOM2i2aBrJdD5sAf5OK1mDPvnlO2mKOKUOMG+LPrmG9Pu?=
 =?us-ascii?Q?J4+RcDxdPyzQf7LosjZlJxaC7tuUlVn9drH50La3pYixIEC8S/KeYVu/O9Zz?=
 =?us-ascii?Q?9pp6swDsK9k6FF5z80lzMPWprkXhGN6UT1c7eRPev7tzp6RObsMQtyWu6hZo?=
 =?us-ascii?Q?uZLQhH7/kOMDQVLirePFFdLFEOg9eDYhZFAiA0yWKJRXvag5492ZZHr44Ebr?=
 =?us-ascii?Q?JkcuKHLz2BWtQ5bvDGtQxydSgSQh/LmLQgDw+9zgamiSRcR1eTRD4tPJt9yU?=
 =?us-ascii?Q?K4L3Ggd1V4MJdMAGSWLex3Gr+5qn5LffH2wdryKYhRpXuB3fFrT9DCl7iCRO?=
 =?us-ascii?Q?bDiYgISAu3oSzcTdOVsfY8lKcMaUEXI+ejmzD4Odj0BdvQYHm3L+ksX4XJhv?=
 =?us-ascii?Q?NCty73wfPvEVFm22oB56bc7a8sJ5AXSO2as6DTANwOYA1n4PCNGVUclBnuOI?=
 =?us-ascii?Q?oBXBt5t6YF8IY1yBo7SeHgwuuLSCfefK31MUaDlfYPRJSe5DojmMshRLUwWr?=
 =?us-ascii?Q?ciFikjrneqbb0POZb5unCV9jK6M2RH8Vgt+uv9+bw5UWC0Zs9eQpaih9QAl8?=
 =?us-ascii?Q?50sHNBSz92smVi1af7maj6I7KCe5JqBFfTtyq1bneyE+anJAar+tm6baREnR?=
 =?us-ascii?Q?oT8SNGp522h5IWZiPxntrDwXehrsrGdzazAEHW8WrUnCPIYe+iO1uwFHtlIt?=
 =?us-ascii?Q?lvJmKh4Iy5+v1e9f3ym94TpEIwuNoU5gMGDiv4fWkJ4ocXcXd4aPgedmOMIK?=
 =?us-ascii?Q?78ry+92i8974PlmTXbNTAnTSL0ZaFuqmoKpsXtwgG1kNIRGAQT5VCtSr7U85?=
 =?us-ascii?Q?NnNlaYej7bFO21Vwe5Ovy0YphLHLNP0Y9UBwL6KKY3MZQug3bNxuiSXLK7fp?=
 =?us-ascii?Q?iH7zScXZ84etWeL5MiQOvYTVyajwkXpTU6CXMNKrNTA8sh+reuoN0Seo8Kzi?=
 =?us-ascii?Q?XxsG0gEwWl8E65pDyX7y9TIRZqF1/GDnvYP99AML4AkjCWEC63Um8cg4uVGd?=
 =?us-ascii?Q?P78Tgr2teJFpjXySQIMrKe5e+JZAp/t9ahERS9LPsPwMxlCK7ZVZEuIYpKHI?=
 =?us-ascii?Q?1KMSHg/3x2YqbBXH4RLqr/5kRAT7ig3EEpZPIHLxGeFbCYBH++3BOWw+ZPkC?=
 =?us-ascii?Q?GdPkCag1mBbBFqQ7rv266h400xJZrHJbWmdSoVth54qL85ngfbD16TYc9Dng?=
 =?us-ascii?Q?kwf+Cd4n/u4b4EarHOlHG7q+m2tVgsYf0L0HsuD4FwzLa8uhIVTlkEmIfLGL?=
 =?us-ascii?Q?zmDZJnHcwnF+007AfAM0A6GX1e5FDFZJMoMjJhXOIgp6EtqoC0mCzEkuEMUK?=
 =?us-ascii?Q?4rLxKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:36:12.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66eca38-7a4e-4c88-6e3d-08de5e7233f4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700

Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
trace when an allocation fails, with the message "Failed to get suitable
pool".

This conflates two distinct failure modes:
1. Configuration error: No atomic pool is available for the requested
   DMA mask (a fundamental system setup issue)
2. Resource Exhaustion: A suitable pool exists but is currently full (a
   recoverable runtime state)

This lack of distinction prevents drivers from using __GFP_NOWARN to
suppress error messages during temporary pressure spikes, such as when
awaiting synchronous reclaim of descriptors.

Refactor the error handling to distinguish these cases:
- If no suitable pool is found, keep the unconditional WARN regarding
  the missing pool.
- If a pool was found but is exhausted, respect __GFP_NOWARN and update
  the warning message to explicitly state "DMA pool exhausted".

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---

Changes from v2 to v3:
- Distinguish between "no suitable pool is found" and "pool is
  exhausted" cases.
Link: https://lore.kernel.org/all/20260112104749.4132641-1-s-adivi@ti.com/

 kernel/dma/pool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index c5da29ad010c4..2b2fbb7092429 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -277,15 +277,20 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 {
 	struct gen_pool *pool = NULL;
 	struct page *page;
+	bool pool_found = false;
 
 	while ((pool = dma_guess_pool(pool, gfp))) {
+		pool_found = true;
 		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
 					     phys_addr_ok);
 		if (page)
 			return page;
 	}
 
-	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+	if (pool_found)
+		WARN(!(gfp & __GFP_NOWARN), "DMA pool exhausted for %s\n", dev_name(dev));
+	else
+		WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
 	return NULL;
 }
 
-- 
2.34.1

