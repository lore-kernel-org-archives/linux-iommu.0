Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C118BFF
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 14:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRL+C7NeVRG8LukteYexX9AJqjqUi3Z5FIlvICBxUorvBwwll3/KcP9uU0vhun6QVOey+mF0n+pNIcBmjPrqoBxBKZPF8rqHObknHNA87M/6in8xXNIOdNy96S/E0944uJXIpZKEjvHtvwoW/zGpvzuUWdasi77TXvMEmQQWaNtpJDs95dX5M8WKH3u8xPzpsXHWyYrYP8ye/bnzpK4XCXpFhjxTOMsbiZR525sJSUbeaAhsKSL5izh7IvMbizPmfo0PvsaA9UJvDLDcfKYzStXshJz8c+yjo9TrnyCZ00TraaoC0kc+W8LQlOHV71fdPN2q2rsWt8orSW48zYZTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY7u6GXhdvSPG2+bMR5XMRkRtpnYuv5+2ctOuH6tbmQ=;
 b=kcKELgpjlVLYhQOHSZ4baY1BguZqIXWyQ8xlGH/VNvxhtHtgYjYdYFL++wp7EHE4QpazXbBTB95vWYTqYARHyJv/J8ysBi9+tcjCVduMqAxherGkGJgz/749fw7VCpu37xn1KlwhmSRW7+0La7Ge5XToW+k2xNHaFZNYPf7znI6bLo7GT3yk8RySvH2srqk3KJoAP2BgIx5BbXgJhLMr8D3rzlLyms/xQIPXGJcmmEtTA3ADo+BdQatnMaNlDso0NYXOKf4wNqv4IA6ngpXCumn/NhQ5FD/lFC2iwXwWLkpiw7JPzpLrfeU0DLzztQsJ7IbAUHcxhU37GXLNG9FDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY7u6GXhdvSPG2+bMR5XMRkRtpnYuv5+2ctOuH6tbmQ=;
 b=gNaccnH8upeGgYBntNyZ6MQ1ufLUQhu0mckX/qAHyPTQHHxdeBT8ByXmdQivwap2HKAsbFLKSu9I/o2DMHYny4EX+BN00DKjWaJRFJv1mtbySuMCvCtI3hxagnXmxkanxaAvJe8KH3pAeIPoWu+rYFon86leumpkQ/xMo9mkUTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 14:01:09 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 14:01:09 +0000
From: laurentiu.tudor@nxp.com
To: thierry.reding@gmail.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH] iommu: map reserved memory as cacheable if device is coherent
Date: Tue, 25 Jul 2023 17:00:55 +0300
Message-Id: <20230725140055.12823-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::14) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAXPR04MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b11f60-ad70-4c97-3769-08db8d179928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KcgBVUqKics3I3ptSKN/RnDteaYnS7qBTWe9wl3m1PhURHEhoR3N+SLlAMNzzSEgYbXXc/Gcar2R3r2XrTfsj4YauRlfqQ2iYknN5f2v0uDtVtLQlb1Mf/wXpGnYXyPEXEHhG90FnmlLDK1zoNSwOeer2T9wq81Wsz1FxY8sy/BpnqnkzYBjNGyDH5bjYjXaGURr3m/y0CcvSVq4gjIwIGhB7841eL/VhjsAl+f5QVjKyRx1gVPoU6PaLAeTXKhZlBMiCGvymCdG/mO6jaNRxG0wQf5906UhOBKAaGEXb70ptjcR+CAb54YzJib/oL0LWkj5olbzKBml8DgrronwV5odQa/xm5e5PAhh2GMw45QHs+fSuCDLdg4tdHPuQvccs+6W+/ZVuB27EjvYkLsYnIQQDkqAlaY9l0zSLissmqPL8QHg4jXUubztqzsWX7ZTlFXRYBXG98OJU0C9PZKOakaACeQoLH+GfdEfKtUR4H0TSMVtP2mpWjCQxCDZ0glUl9nDnqvgjV1FXCPucuPncUopAp/1CloE9VmNpwE4ZB0l8njAIlAbeURZh9yRDBHKWhvFcJR8frG1KguEaFZ+A6Bb3ueb3myJOb1tvxLuV3qvmqgyq6JzFEeeGRPaWa5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(5660300002)(8676002)(8936002)(316002)(52116002)(41300700001)(2906002)(4744005)(478600001)(6666004)(6486002)(6512007)(9686003)(26005)(6506007)(1076003)(186003)(2616005)(66556008)(4326008)(66476007)(66946007)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jipUrKxoAvIret5IOQ8pYBHXu1iP0uO0kjmVq1lGvoW5D+kE5QaaRFfiPPJU?=
 =?us-ascii?Q?igdM+uXgll4SwgIxkyKb2LWj8aWieEjyouyJBHrMS1wIeNoTgKFgC6RHFel/?=
 =?us-ascii?Q?pnm+nQ+4F5SvavzpylO6lGm4z9BFbBnZsOBZ8B+eavXSxyUM5fKVG6LAYAcS?=
 =?us-ascii?Q?X8MGvy8vzY9Eyw5Iscm82a2shKnuXgg0lbAhf1E2yx/77klBH0pj6QKsUju1?=
 =?us-ascii?Q?5bdIr/Y+YpYqpMjjYkheZf42qK8q07gzYX1r5Sxy1ZYY6yOeW3774g6woXUi?=
 =?us-ascii?Q?mdDnB+4V2D+7VghaSh76JBHgK8dOziDC+oHf2KiLA/Eq5fahZ+Yj0+r4O5rA?=
 =?us-ascii?Q?I2nWA+LcwlbqhQATsXue5zwrPxHxpGNGCGBDqATt3hTU2oyhtNNWWDSmEyHC?=
 =?us-ascii?Q?qX4CE2ZoeTHslwF+fWY3dCM1BTx7DBMuxyo5Rq5kWDKWbSEvBVhy9kksh0W9?=
 =?us-ascii?Q?IUEKzVz2P7nWkFvnp9MDLhXDm79qvP06l+MjwCh8OeRL7I0lN5gvy+9BfdDP?=
 =?us-ascii?Q?VUPpuVoZiVb+FXvQYRHBUCNfpXklXg+/hN4FKxAkaHVxq0SfPZV1qw9sNlFd?=
 =?us-ascii?Q?c+wR4bZEk+DKCOD4t2LU0LV/RRbjKxq3kCdEIwccpmqEQoUZky54Yo2uOzU6?=
 =?us-ascii?Q?xHOAv5Qu9F261X0KMQC84yHpXjxIrmexj2FwSfr6pwawxOGPgtZW0mw7cCXU?=
 =?us-ascii?Q?88X5C4lBFVxBX9zd1UBWRmXDQ6nGA6GKkiFbHBf1CvvHegy6GQp4jM/lzzlQ?=
 =?us-ascii?Q?CCOPHZTOLPwl8SDbBdJ/IWJDaifQREfTzEfN9pU3GZ0//ZxTzy8F+0ZWDU4l?=
 =?us-ascii?Q?IHra6zN3qV3a6MMna60YMgZI02g2GAfBKChbkuiPrr7vkNGDiDrN5+LE5VVw?=
 =?us-ascii?Q?7j1rK70pgUU9rJn2n9UIQXK8Xgqox7kCksJR4MEde3pTuljm+VC7XrDC6ILw?=
 =?us-ascii?Q?Pnc2adZvckJZfiwGGdwT9G5kDLxpjRLN/OUlv2D75LUkLo1awToSqe2H8uCD?=
 =?us-ascii?Q?rn5z5zRL25DHR9lN9//lRYg/u7j1DYpYH/lCh4NvCdzXVfQJbMFgRpglFLs+?=
 =?us-ascii?Q?uTL+U2W5JNS9UHWWnNCghxqqGR3Ibp4rrt9n0H2i+sQ1FhWq/wVIPM8MWH4L?=
 =?us-ascii?Q?yIprxDF7Mik9xXY1Uuy+wfBZ9NQ4xm1EIjDb0QRifEDT+XzbVc6MbyzngCwE?=
 =?us-ascii?Q?ZLHX4q5VYXYNpxMn758t7EaBTrsyXpJ6i//Ugu+jpq83X8xhRtsXsTrJsdHa?=
 =?us-ascii?Q?2+XsbzJ0E82Na/3Hrju40kmPMLV/ypljqtRqkx9EwYwvyq2tVcSTY7OS7z3v?=
 =?us-ascii?Q?5TkSZfSfyynsL4t6R1eS4jJleCPfuqBqyu3WiNc5fwhv6n4jR1MAUBFaVqnl?=
 =?us-ascii?Q?GmrXGfVcfMNS4pnKTxaiZiw9vp1Gra23bJvMu7kpOGhyHIqJshZxYsO/MLX6?=
 =?us-ascii?Q?BPHvysyxLMEV4abCZi+GZtSWDAdwuT4vaM4Km/ZfbvS4HuTOEGI1IlRUEHzm?=
 =?us-ascii?Q?QxJy2Zh+udzOrbnwdUJZ9tdgEdr9INsA4+OTE5Cfybmip2UMQpqcMApMcXpn?=
 =?us-ascii?Q?dB3fRY3TL8ZDV/vhVkXXacNd6kku34UiDSkmTjsf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b11f60-ad70-4c97-3769-08db8d179928
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 14:01:09.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9PY2kRs+xFVHURwoqChHbocgpPOX2Ze+kkKRb3T0CD8Yf38BQhwXeof1LZDV6jmDagCItnfq2/vsB9hbCLV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Check if the device is marked as DMA coherent in the DT and if so,
map its reserved memory as cacheable in the IOMMU.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/iommu/of_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 40f57d293a79..ccb912049b88 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -254,6 +254,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				phys_addr_t iova;
 				size_t length;
 
+				if (of_dma_is_coherent(dev->of_node))
+					prot |= IOMMU_CACHE;
+
 				maps = of_translate_dma_region(np, maps, &iova, &length);
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
-- 
2.17.1

