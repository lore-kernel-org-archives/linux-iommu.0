Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649042C3256
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710448; cv=fail; b=OT+x972m1zAyERwCAxlAHrENdWGrfvB8FBFqDU9netW206lRzrsIp19GNua3h/tPxJCGZ2ubO7WX37vJMhEAvXSAWH1WVoabD//PSkhIzR92FgJf2KuQ1i6Ot5Xa3Cwbuf7gDfJkvuFLh0ZmF2laX32Zb1IUvmoCSc0DK657g5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710448; c=relaxed/simple;
	bh=BG3UgJENtsFxkPAi68d5hBKf2ICRLdsF/Rltr+20C8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwrRg6X+1wCEsTJOQD9K5aFvAZYdJo5Q8AprlmJ3X7y8Yu7BeBn0ctC12ka2+7WYkeNOnQ6Cz1JTHbOCW93/ypDgBfUaYu382GsmMbceaKlK0QRXTnUYp1NF8xvJSYVN9k5Vu501/EeyP+7J/azekv+31vGlhPz5gUzENqFS+Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gT2x4DAM; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gT2x4DAM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd8d2kSKwaac4l06zPDUZOOCdtDPDSteZX9foPoiVaCsydEMGYdxSahumuJFiRzRL6GS/5sKg0nBwUS1QFHYyDgqg/O/4gIkassurCkKtfjWyiKoy39TEr4jtZk96WBYj5cZYUSzW31612rBjIQt7Qw4jQ4zgFYvNYERV+d3CRECEwQl4xzXhNgBaHwVFkNaMifYnLoO5hc5KMbHizPBXOW7xV60HUXbT60cKyka7W8BCfWoixuOBHGElqIwBmDCuryajYiggcwSQKVZdHNRrfA4ZNlrrt6V+yCDToYrmQ42LHZ9+mkMMvRBVi6qqgdqXDMHjPAf4wTT0pZ9fvvxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnZHNbri/Km7GP490rzcWk+67nfrS07as1+afLbwhQ8=;
 b=uu3ZnXh6qNx6CDATjieuEXr/LvH19xNKV8HCETKSZLrN4YhqP/UyVab6VWgCPFjGYX7CLkpxtcQuSqNYVmDoKWq7C5umcMFb0IKCcI7i7+vod7rxDRhqWfueFp5I9NFx5M1UMRi5wLRWbtFpg6Hf7J6Ly8RL6J1TmYvi4zzRM3W2atMpfINVSJcK1NBRcQ5T+tk7j2zVnJkNCIJj3Ox89fllicKttIxXUauhjjm2ia7T6zYKP7BqYtALFCOYmQtL0k4gHfhqTW8sWoRTpjGZ0Hji7kVjLK7licSBlor77T108o4aRxFanTQBOoOvKSqFISPA22gVoIy44nYHGP9eRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnZHNbri/Km7GP490rzcWk+67nfrS07as1+afLbwhQ8=;
 b=gT2x4DAM4Jg0Zu7sLrcM5ldAvbCBeG4H/iuTgWzrVAccJlkULyvAgm5MqrafVc3H5QfPUWyOHFb27RjCdXFrZxMdav1Tv9PFojQmXjRakBy85E77bveZg7S3Cge888RzunLQxVOEo9r8LI6XdSARWdINRBLQ/iVOWAxl4Mhhcju4DVy7U+MJ/Ooqwa9pZ6mnVaL69rC60NOCwVw7H7blzHs2iU7S+noiOYa5EVxcQCpyfXs02CmPjKacDHNLghJv6uVS65HkaK3DA3BPqRG1DdF/aSSXbaFVSCCr4qwJWeoRSwOBfEf7ehni/AhKeJgET9BGC1YtaHPR62YfXR/WSQ==
Received: from SJ0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:a03:39f::6)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 18:14:03 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d5) by SJ0PR03CA0211.outlook.office365.com
 (2603:10b6:a03:39f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 18:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 18:14:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 10:13:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 10:13:42 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 10:13:42 -0800
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Maxime Ripard
	<mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Sumit Semwal <sumit.semwal@linaro.org>, "T . J . Mercier"
	<tjmercier@google.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma: contiguous: Check return value of dma_contiguous_reserve_area()
Date: Thu, 29 Jan 2026 12:13:17 -0600
Message-ID: <20260129181317.2429196-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: 38547a38-d0dd-41a2-dc8a-08de5f622e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUvj8bl+ASsFwBymVSi82PdwclOy12ssUDO2/eQW4BKU4U4qxlGmk55ecILA?=
 =?us-ascii?Q?ubc4SkifkmgQSNM0g7uZ1NUawTrajhWD4eM9T+IEcwYzmDckiwVhQZ7LZ93c?=
 =?us-ascii?Q?3hLG+etZjWymU1RMfv2VQmJ77Ak2H6yHqWhQsCaxLClUrCG5EBlnZr0KNq09?=
 =?us-ascii?Q?qnDyXvJgN12krYCnUoxsIH77RUISOtfQCm+BVUz0GMbQ3TlxtQMIXBQU+Dem?=
 =?us-ascii?Q?msKQZ8yVsmezHMnSNvYC7IzjllRq4lm+AATK6G/xYN6S+JJb/OY3G5C/Se5i?=
 =?us-ascii?Q?holhZ2DHaU4jgBaHiNoVOWts6w4MInVKSccZi89SEGcDOQY1Pm5vc5Nwelrk?=
 =?us-ascii?Q?d6Er/MczxVQsdGyABbVMBtVU9k13GPJkA52RspVaLsozPTRo8NKklNpWMI/+?=
 =?us-ascii?Q?4MqPLQ+mLTOJoEKEHedT0qhVn0/d1siHYqDtOtsPTqARStViJvQhaq+oNUJn?=
 =?us-ascii?Q?im2hRp4Iy9cn2YBZR0isYZjMkhBN+7C9lfYHoSAVOoZeJI3ovrIXv+2VH7ZR?=
 =?us-ascii?Q?LByEvyy/dL7DXGNGjDikOEYQ7J2LteZnluGJ5QzZhY1XzRxjN/XTXvNwT02x?=
 =?us-ascii?Q?K+5BES/T+qOispuKhVrCcY5s3ODxjSIa/DMKTWmMmSaGroM/l2Dl5+9pn4kH?=
 =?us-ascii?Q?AeeHUDswf7qBP6BujF8qmXfuiNjwlDyCaiPoyVu1NDtPGDuf45aIxHFp5pDr?=
 =?us-ascii?Q?BQQ26lwA7Y8aapBmmsZfRm3QIF3uQHYPf869CEPb3TXqIFBpzdFFUd28PqnL?=
 =?us-ascii?Q?2sflaOosVN6ki0QYJ26BAAgcc+0UAsbwct2K5ikw0pKNlnKC46HP9DBAuFpR?=
 =?us-ascii?Q?1gXZduGdUIlSgfN08Wzs1pQJvAcsGa1jf6YM27JuAUUG6WFQrIVcXtdRX8eL?=
 =?us-ascii?Q?TbUp1KG3Xw2auecL3rCYPJdnvesk/7Z6HrqlE4JZF04Z9wO936cCCvPuGFVW?=
 =?us-ascii?Q?Z9HxodHHFhprgZCMXUuIhfrI6x1IY0QKpl+jYN50GalOAuIUJmEbsZSm2KRF?=
 =?us-ascii?Q?Qocl62drZJgArQjpYhH9Mmr70Xh1BUdLKYOHfVgZq5SoxUhXsb2esNLyWlov?=
 =?us-ascii?Q?FMabYjb8BsKohh52x8UVpdNW50TumNCOXS4ndg8WdBx6snJEKLtoow02U8sO?=
 =?us-ascii?Q?6z3s3GfBA6spCYbCQP6HitfY6jYrc0eOAzb3ouG96wQJtht8/FZBPep1aKkg?=
 =?us-ascii?Q?m+tTRdymwXnAWKUxhAyFSPafNKDbLZI3vb+D7hul41SOidKu8oc/AfezCJE6?=
 =?us-ascii?Q?sxR+cOwm3K195WdXZJOWSaelbHYOUJmEVAzBGL7mPveEOFeKkmxSxInh2TRL?=
 =?us-ascii?Q?Tw3RV94JaUiiigsS/LsdaJ8Ae6FEObKQOkOWKHjhsebE9x5Vs5GNdPzjUYg1?=
 =?us-ascii?Q?RpjMvZV7Pef2tui/HPJHVgde9+l7w0JR4uUOOGRhwoebWyqui3nKR7WyMBTq?=
 =?us-ascii?Q?0U6W4XmhKcwfu3OsWFTe7H9AOmyUdinaKdH0OveIXaWTvz65mATAcWXFUiUW?=
 =?us-ascii?Q?l4GbI8KIGY0sec3/D72CtShgmhEjb5URaYvuQcdCivwkdK1g7XPYNdbu3YaJ?=
 =?us-ascii?Q?lXsZzdWWrZiWaOPPaJp2oH3w0iAj6vriUtH9VgPGYB/9i/1RQKe+Z9uH9AUg?=
 =?us-ascii?Q?hkuf58bjQ407ez7lFY1GJs4tCcuhkz4lPpyVkmWbQEwJ8VFmfoNZ2Ju/RVmZ?=
 =?us-ascii?Q?XT2Log=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9tOL6O1UvEiY6Vl0FzK0ALUHAUo8v4tnXa6QPDLoevL4QQG5J7TTZXNuK7g4D5wNXBA9ewnV2nNSloW0ktzE4iVvDGIlpA+hXbpYDX9YI0zCsuT4PBlVEzOSijpXn0hJVoO5MKYBRpae99QHDCRKX9r+8inU6N55azlZ7UcppsnVZbdWLYU+peN5Ya0d1dB6uU+Yk1Icyow+omIeUBW6hQv+U5CD2Qj4pAvM3DsyhNAuOtZrTOc87qMZoxap+Kgipq/a8hjEXFNp9ewIb1t2+6llShLshj3nJfLeBIgMmUXRoxXA22M6i6mFYXY3oEDJJ6+FFS+Fh5Zlsa+1k8Wan8UNLahZSiYOKYPrimrxHsPTd2k215YxcByhY5Phmcq1rQfC/8N3IgDvl6JuRxUpVAF1Y8u69GLNCzUOzTKmAuQz45lWjcuTdTJcmatsb6jE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 18:14:02.1385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38547a38-d0dd-41a2-dc8a-08de5f622e51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079

Commit 8f1fc1bf1a3d ("dma: contiguous: Reserve default CMA heap")
introduced a bug where dma_heap_cma_register_heap() is called with
a NULL pointer when dma_contiguous_reserve_area() fails to reserve
the CMA area.

When dma_contiguous_reserve_area() fails, dma_contiguous_default_area
remains NULL (initialized as a global variable), but the code doesn't
check the return value and proceeds to call dma_heap_cma_register_heap()
with this NULL pointer.

Later during boot, add_cma_heaps() iterates through the dma_areas[]
array and attempts to register heaps. When it encounters the NULL
pointer stored by the earlier call, it crashes in __add_cma_heap()
-> dma_heap_add() when trying to dereference the NULL CMA pointer.

The crash manifests as:
  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000038
  ...
  Call trace:
   dma_heap_add+0x40/0x2b0
   __add_cma_heap+0x80/0xe0
   add_cma_heaps+0x64/0xb0
   do_one_initcall+0x60/0x318
   kernel_init_freeable+0x260/0x2f0
   kernel_init+0x2c/0x168
   ret_from_fork+0x10/0x20

Fix this by checking the return value of dma_contiguous_reserve_area()
and only calling dma_heap_cma_register_heap() when the reservation
succeeds.

Fixes: 8f1fc1bf1a3d ("dma: contiguous: Reserve default CMA heap")
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/dma/contiguous.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d8fd6f779f797..92c539d76412b 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -247,10 +247,12 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
 			 (unsigned long)selected_size / SZ_1M);
 
-		dma_contiguous_reserve_area(selected_size, selected_base,
-					    selected_limit,
-					    &dma_contiguous_default_area,
-					    fixed);
+		ret = dma_contiguous_reserve_area(selected_size, selected_base,
+						  selected_limit,
+						  &dma_contiguous_default_area,
+						  fixed);
+		if (ret)
+			return;
 
 		ret = dma_heap_cma_register_heap(dma_contiguous_default_area);
 		if (ret)
-- 
2.43.0

