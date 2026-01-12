Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8734B412
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214895; cv=fail; b=hrpkeHwLxGyS3h/n4lcZAOBRmujgiS5ftVBHzH6DKDLMzHJanbwuDBizs13Wl5CV8bq+58Iom05RLT58wSm7bIeRcbn9Kx7+iF/Gix48d3ufFnHa29Q/6jS03a0x6Iu1X+sllg1FA8D3Odie0KGS0PQ5jo+Cmpui7VySpH4dkho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214895; c=relaxed/simple;
	bh=ORc5tl43JrKB0u+YcEZUPc7Kr8p+Kp2zvVW841ojBmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtDJThFc6a4S1p1d5PiVaDtD4qKZHU7s1Ek1tMEAp9lCTQkcUNcoL6knoTOhOHTD7ynEeIeBmK8+jqt7QZfG1L1U9GAMGXom/CM8e3uuq1+H5csu7OWR49F5o2Z1HScNNtJRifeMi4eKwrYF+6xWdpabQu7ChuSBz3eQOVpkbsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IzVOFTzG; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IzVOFTzG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du25i5d931SCjY0IyhQqsbMkp5NnOqFVh1YUX5u7E2NjAsiX5b9WwhkcXD2H/UemLokzv7YVO371GyCIL3+Lll0W+wAzhcCgoC6veEezbXORB7q8o2925qon4YZvja1PECz8V74nxT+raaaSe/FBPlAytnrVh2PxFou+C9TzVG2/+41qU5SsLjIJ9hrb7p9YIwpBtxqNVMP6v6smHwdLgIyD0FUOesgSwXF8qDtUgOkkegF6L5JF8MSBnVmwnctxTmuCcxOVvcERalfdFpT+IoWRGWojLqmxrv9c2DD0pBzs7vSbr9fwM8W8Fn/8Y6WX/3arQbMam1Rsv9NYFNibnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jvLeQzHt/L3iYlJ5sYFAmET/kIIOhZS92NLjqNQqyM=;
 b=NTbw+++xM98a+7Di6wEVG19yNcoh96BF7lbnIE5HzOJXea5nM9W/s4vSuUglQevVDDP5ntq6Gp89+/MttOyNT3Gi+umAeR1Bskq9Qh7ya+arghdcV4FnuhRLw+whyKJG0Tzz49mv5vkdgGCZVmNmtoveZvW50ZWz1HFj82JYMwjMv2T8afXGnzlNyhwwcGFB6VRNllS0fdqjuei/B7Qv9eMT7vp+gyseT3m8DvQousvBvhlpg3yk5+gn5bRfh4egjAMXjI9NFxg9eg129+qsS7hHc4+cMvz8YPS3AOHxXKmWOdJgdQl6lBS+dXX30yxeM0sF5CGVpSsTJDxqh0Cy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jvLeQzHt/L3iYlJ5sYFAmET/kIIOhZS92NLjqNQqyM=;
 b=IzVOFTzG7TQmoQyHeED/hEZS4liWmdMVXJhpo1npPJoNOKP0iJOVm4hLnuGZH5ThxJZwNSJ/ml6xwjp5IA86hwXDn+64cXBblNe8OiK9VwUipiqqx8a0LNOuYg3Du+ZIhwoOwhceBCEoSGfVUnZ74Q3hsbRvyPfnobbYrRlLcUI=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by IA4PR10MB8447.namprd10.prod.outlook.com (2603:10b6:208:562::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:48:04 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::7f) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:48:01 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:47:59 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:47:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 04:47:59 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CAluhu366624;
	Mon, 12 Jan 2026 04:47:57 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <vigneshr@ti.com>
Subject: [PATCH v2] dma/pool: respect __GFP_NOWARN in dma_alloc_from_pool()
Date: Mon, 12 Jan 2026 16:17:49 +0530
Message-ID: <20260112104749.4132641-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|IA4PR10MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e00d12-3444-4b3d-d00e-08de51c80ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|34020700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5B75yaaNpqMO1KtG0gVwju4PreiVvGw37fS47ZsiZBcX5H2HJ8jnWoxLyp4?=
 =?us-ascii?Q?wKvuUiFUC3R7rvcldzAREgL/vAmeG4RWXB/4ImB6f1hD2VR9Oq+hVOxy5EqM?=
 =?us-ascii?Q?D+IYxSRmArXp5vr6dXwUteCqN235EOdxIF2c5gvakL1OCJ8vx24OzV4wQFKy?=
 =?us-ascii?Q?63YMkZ4rx+fvyDbnZk54JcUewj4/07yEgZle4UWup22NbIDQ1K48FqWFakdZ?=
 =?us-ascii?Q?QBdJkWv5Kr3POQPiWNJsn96O4/tifJ3D2hMworTB90x2w0PLKMhPNlrk2GZe?=
 =?us-ascii?Q?KHx3jNmp+mXLjYfwakk3WDymGqa+e6Di5FFKS0e947UhiqBzxX7pfjre7Dm5?=
 =?us-ascii?Q?Wsgbr6yGlNKGo96B26iLq3qpg9gakbwC2zIiMSD28k4Kac6tp/WGP3SP6t6l?=
 =?us-ascii?Q?ILKSGESiQKOrkUHvCKKMqusgQcmt0jbjPrpZxvCPZi019mliBjeU2pisOqu1?=
 =?us-ascii?Q?FqMKvmUfQMlqj7C1l2kh5k9kUastZ99i6TyEmBrerVsdmd+agoRfX8wpBLdA?=
 =?us-ascii?Q?2bKFAJWaKzwwgRSGbL63OTpEY3EyVA/OU6GDLAv1kQXxiUYoogMgwkhodYwk?=
 =?us-ascii?Q?Zt8RowkIvTq2dCMWsIuzyuqlzpdSu1h7FFjJtsyKh4BgaxmfKAo/hJOBWXRO?=
 =?us-ascii?Q?k2vbzqc+5J5ADgoNqnLgp/+B+xKpbZsYchCKENjbL4BmkxEW8BDVwqplWm70?=
 =?us-ascii?Q?a6zycoEYevx8FmVTZ/eEagyp9RXTCu0bys+h15/n1VNdpH2uMKDBu2VHofEH?=
 =?us-ascii?Q?dj+EP+BkMFakTsWREnBVLgHPiEz90AeYv3LS/LjQhtOkZsNnd+0V1JSQvSHd?=
 =?us-ascii?Q?hLQKrOephA2AGOIcHUkiaVL5/ec+TjXxP5ZjeOTAdQpBRoAYbOrCOlL/PPBk?=
 =?us-ascii?Q?7w6hMmxdoB+Tn/3RjRLXnLtJqEEPUU/NpS+71fAusOMzcHr+IJxtQVXjluuE?=
 =?us-ascii?Q?fiPA6K1ETwM17orTDk1vNcu7t/Q/2N+FRBnpB6ZkuyzjKdSqPJIn4Y5S6N18?=
 =?us-ascii?Q?t6zisjRGhpgMGYtwycyQ4fgRoZEYefuDIuKWi8C0tbAjTls+Svya1Sd9krYg?=
 =?us-ascii?Q?lGggOIRQ7EZJHOV8V4wQR2NrO8Y+L+wkPdIqMdfNwNQRE0XgG4ZIxymusUeR?=
 =?us-ascii?Q?igOVPkS66C74NWspA0HPSHO6poMnsD/zalGOs3Dl2+Wdt5eDjPYjyXPbcJd1?=
 =?us-ascii?Q?SiZJk13HASjqyikBX7WL7zobqt17TLGq39RQS8fPVsJoxvRlEYM77D0PDWpe?=
 =?us-ascii?Q?mrMRE+999Z5dKUnLrPyiRpnKoHGpezMh69ydToXCidM7Pg3NTLbH62jInP7B?=
 =?us-ascii?Q?Wy+xkkGZNzapE03ni+FshcqxQI4lQYGPP0myXaEeT5GDJi1VROl8GuDOP6dA?=
 =?us-ascii?Q?Rqai5FTMkAhXZ1G4B775SadDNfmVkI8WqcA0dA8HWm7C4GioE8vc7aLFZcIj?=
 =?us-ascii?Q?BrOaHhameWBgu4AZ12p7G+XvwWyflzSOowIU/PAEe+o1Sv2nHFzsfyxvhNCU?=
 =?us-ascii?Q?bpJyh12XO7nlYBZOmhHaTUMIKqrO1uma7IjML9hebwdaT8tOjQeaDoHO6jIl?=
 =?us-ascii?Q?hI+zJ3s5uXYPg48jitk=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(34020700016)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:48:01.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e00d12-3444-4b3d-d00e-08de51c80ec0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8447

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
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 26392badc36b..f63e027b8a27 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -276,7 +276,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 			return page;
 	}
 
-	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+	WARN(!(gfp & __GFP_NOWARN), "Failed to get suitable pool for %s\n", dev_name(dev));
 	return NULL;
 }
 
-- 
2.34.1

