Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26686277
	for <iommu@lists.linux.dev>; Sun, 11 Jan 2026 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768095727; cv=fail; b=E1wUBPIfACCjIaIxoQaL8IMg1gqtXbT9zBcRjyytgktSNa3KQLJwq2RxgKHvLXEKMIwOKlhG3WN4GBdHn6wA1tQXGu3I/0lVzsjSVX0FdPMhVSE+sIhYpqmgd2373FE0vWf1bmSdfzsZqVu0Jhcd9SEe/tW1XAMzoldDN73GA+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768095727; c=relaxed/simple;
	bh=Byu8Ucj9srjKc/plZo+8+IYa12rFX/s5d5/KsC6FMMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q1rA+gJOURvhQ6vvB9D5X6J+zfJYKvMYOMSn1ZW9yUSVCMTDcI9W+7r4ioMWgCgNRnA7I8JliVqFFxl5QZrCm+CgxJOXeyB/XImwTJl+uCHkslh4cEnkLs1arLkmP+yxuJTy2lABOGuTOQrjwzikc1dvScZwNJ8dOPLrZUr8kQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qXoyqGMy; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qXoyqGMy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUVz9q6Im5viFjwgt24YRsP7SPXIORz22SKK6/yugAnLDbfJDIMrL7WcNnobhUsSRuA+afQanRtcwdmqAXagrJuJZnNptbeb4FuMAdrKp3UdjRnheDGj1ZiI2wvELqqF9RVSI0OH/qmhWsXIgIeT5Lv0VSgKHLmPjBG28f70voIxCkpRWetJfcFJ/O9dc3k+qgOc2IT9cQXjDh0l1vV0w7xDLwqKG5/lSZTA48SYN9bYF70BiL62kbm+sYtWZ+hIt9KcEFxSR1JLaqvdoATlYyyNOEegyAyP3/FGt5ZnYTUNLB2vBnWSb9aBPL0aaNaHOmBY2Sehnd0g7JbLmQz6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZRzHFJ/bg8l6aDCnU8n/IQKOEn7zLAti2YQWf3Rwnc=;
 b=Duljk041lNle4fxa0+fP3+qb1LK1cHS1RdeRbe/R9vQrVegAbeFprW8yjOyNzDXTbSt6Q+a9mEkWSkSPxuK9fBjO7WC9ImjdaYmX+SZucp8We9/UisE+QEGsUaxvi8aVXh/oV+AfpQXDzEY/ctnOsds/ZnckHGK5LEHGUz4I3mTo4GdqE3f++0XqxfnYWWq/NDrot/3Gb6KxnhLIkXeo3xTVt3kjoukr1YNuHbMsunP83J/otKeHl7k48GTQ4M9CQ/yF0Ye1kG8ftTZnPiPkdgmh3duVY+ZwvbKK1b74DktOKstFGr7nQ1bH79lD1Iveb3yrNbPArVwZP7HxgmBIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZRzHFJ/bg8l6aDCnU8n/IQKOEn7zLAti2YQWf3Rwnc=;
 b=qXoyqGMyDA4Mvpp74ZKf2ViNL5U3Bwq6EyBhDck31KWe9n+oVNR089+ByGFZZPXO1LBV6TW9f9311RIIPYh5cIbrIsbXqI7+sRII4pKy7QDdLzMTRwVz77jCbXZXJAIopyw3ovK6yo+beCdUQu6o7GoCv6W1GOHmJBQn7kLFxbM=
Received: from BYAPR11CA0086.namprd11.prod.outlook.com (2603:10b6:a03:f4::27)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 01:42:02 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::9) by BYAPR11CA0086.outlook.office365.com
 (2603:10b6:a03:f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 01:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 01:42:01 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 10 Jan
 2026 19:42:00 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 10 Jan
 2026 19:41:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 10 Jan 2026 19:41:59 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60B1fvfa2293287;
	Sat, 10 Jan 2026 19:41:58 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <vigneshr@ti.com>
Subject: [PATCH] dma/pool: respect __GFP_NOWARN in dma_alloc_from_pool()
Date: Sun, 11 Jan 2026 07:11:50 +0530
Message-ID: <20260111014150.2411570-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: f726babb-48af-4ce7-282c-08de50b29dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|34020700016|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJqQNBZ0I79Rt6M+Ygz5Z7vSMwC3rRLBiyK6iO/3ctXJm5jHoe5XMA2VCUQv?=
 =?us-ascii?Q?zGXZgrNcu+BNW39WndXIZx1ITkl+ju8UrYaDAc/W92wF7hy3k386bKiahGb9?=
 =?us-ascii?Q?iY9+bNu4aLbkIVIphkJYdRzu9EsKUCZiodZVtr+MvPUIR0aG4kepFNG58tkg?=
 =?us-ascii?Q?HqrD4qKRtNrKhRZ85yrsre+/+nE/2NIZ8m7sPCZ+HRPxvxMbD/Zoro4CaFxq?=
 =?us-ascii?Q?HOsaQHbxIZZNyE8HeAw/nFEsj4ia8dYmmg1o3RNzN371YKcz7h8uh56Sl1eK?=
 =?us-ascii?Q?pmITyykpTL9Dxw2jNyepCsnOWoFw/oy0jtTxruEF+pQkY30n8SqUsaRdgbtk?=
 =?us-ascii?Q?LLTMsfAhS7i1clziaCmRuVk+5BHE0BS1ukXWUWiHoroCZs9i7FWWd3XQBv3T?=
 =?us-ascii?Q?zC1wg94KDWgbjwz24VKErusEzAzO9VBnmO3nOYXjaNNP8d+zGjOlUjFqiZ7k?=
 =?us-ascii?Q?3cwwII5YGY7myRCSJaq9ouuyhxx7fpzR/ALY9z0FBmrjTl+YH7iK4rnVcE5T?=
 =?us-ascii?Q?RvOlgOQ3ormisdbEieCBVf975efUFWv59COEPkGeJpnrCbId0uh7bHSy1rjI?=
 =?us-ascii?Q?NLsUKTzOVL6+Id9vnN9h7nH3L9O4A7WRjJxVtKR+oS0UPWQ0fw0Cy3tNcgLR?=
 =?us-ascii?Q?KehuXjp25kz/psLuJfyqMWoB+IfewCVdvxt9Abq4x7TzdMcplBMeTQeUpi+c?=
 =?us-ascii?Q?0ylKTStsMcC9fbin0BPrujXBilyALxMophUf2pZp3bj9vIETM9+O8Lp39Mhx?=
 =?us-ascii?Q?Yrd4GaFicJKZh2LvOOeWDyiDHU1GdG5YKl37m+xxRzFrBgm3OTS4w4nGm+XR?=
 =?us-ascii?Q?S0bXKgOpFZPeT7oQQPQ1TBvjtHuE+0+QzpfvD+UgGsQ4d1v6G62P2giIhZJi?=
 =?us-ascii?Q?vHmFgmkKze3pHEhuIPlhI0k5gNg+3KI6mrNRjFYM2YJ9fY8LSmcs7NE6bWfj?=
 =?us-ascii?Q?VArg7inaAod78tLdBXnFYLBE02ISBukpEcNaq8f51OLVS9lxknQR74xFZ2T1?=
 =?us-ascii?Q?tfcCiNSJWIHLdtcT0OtQ1i07NRACWeHBueUvD9ga/2K4/ymTHznHYA1ntWZV?=
 =?us-ascii?Q?7xd30d/gH2ojMMRLo0GjuCeDxGK2ODWciNfBxVPJOILPZAFAfDonmlVVmemY?=
 =?us-ascii?Q?yN+VBT4D1P2woeWKxwH3BEVTBTm2k8Y57lzSmvlRl6rBudkFeR8DEMf7A/C+?=
 =?us-ascii?Q?fawGlsMpnQyfkT3uMV2J87Tj9ICQ0ZdMuWmHo6SA4DMtaEKMJSHjphQ4h0zP?=
 =?us-ascii?Q?pdDYYpPU1cBbH09KBDN2/HxNw7AKmXRORJ328nZNvoQTPx5jrE67l6FCeLRt?=
 =?us-ascii?Q?jOnbtxKoukzpLrCjkFSxW3NEpJR2uRD4kyCRH89PA7stfGUD8JSoH+Fy5rnU?=
 =?us-ascii?Q?f88BugaQ6Z4ZFEjBl8H43hR7o3AuaEWx2FJTzZIc2bL7lPacRtOezjyDBny1?=
 =?us-ascii?Q?ADyWXd6ORoT/F0TfyDJ8buNOrIc88gK/bcsuTOdryMxei6Hlp60P4X754qU5?=
 =?us-ascii?Q?N31N5nt2ohRdVjorcAE8wheORtuFGn9ZKMIGv6U7d5PoUG2a+oI+1zngyXFi?=
 =?us-ascii?Q?+rztnBEfeUHVr8ZCEvU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(34020700016)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 01:42:01.5722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f726babb-48af-4ce7-282c-08de50b29dec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419

Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
trace when an allocation fails.

This prevents callers from using the __GFP_NOWARN flag to suppress error
messages, breaking the expectation that this flag will silence
allocation failure logs.

Align dma_pool behaviour with other core allocators by checking for
__GFP_NOWARN before issuing the warning.

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 kernel/dma/pool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 26392badc36b..40dc2ab9915f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -276,7 +276,8 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 			return page;
 	}
 
-	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+	if (!(gfp & __GFP_NOWARN))
+		WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
 	return NULL;
 }
 
-- 
2.34.1

