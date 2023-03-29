Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9510E4EB;
	Wed, 29 Mar 2023 23:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG6wrgty5it2PgzWFklPAu/yqzE7KOIJJrcZaZOjIJqVzPJlEyOpJqvGOiniQb/4ggnn5sY0BCqoIqe6y6xbq3swRQRIMs0XkIY6WPmybXr6Ux4yQ3V51KQSdTI3nsjeJTH2MMIWFZTeCBGdME9yspZDL4Vl56AOC8M1QzWgae4ggb6nr4ZfxgAnBJvaP1rpShI0uaVMn4ff2ZYbImbty216GVNMLT3JKsvmh2N7bPSJqQ37mbPI5JoexbRK6EvwMlfMa4qHdx/F4CD4N8mdTW+pG0yeEknULE1Ffxy4CPMO11N0pQ6QNgEWC/F0gLndmYitQKhqs/Ltof27JSm8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqKXeKnV7nGg3IhKJ43E34Rhb0w1yJWSRpSTSxGSLiY=;
 b=kbLUZ1lveV6sboZSv1KtuxtrBTdSXZr+aoaiXEmPKv8gRzMnrHTgsLGYY9Zkw8keYNcyG43vwSViMaNlebQgTSv6eom9tFMk9poHiYY7V9vsX8O9unYnPPd2tu9R912bA93UaloxkBx2wEVDmQgye7vKohYoYhGorSVKGw2JHcZRnKg+selSRfRitXXoa6hE+fo+pL2/spJTEl184JqVjN4mYnQngkMSPMcLco7llKH72Mlg6ZZDdVudsOLBbA+5bs9KCdcW8SEx58CtGoyLmrANMSt+OTAG9dDmXjKMcZrXIxjiaRvoPCeM0w6nZCb55d2qTPzAGSw5+JfVCbosFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqKXeKnV7nGg3IhKJ43E34Rhb0w1yJWSRpSTSxGSLiY=;
 b=U1vikQSalv3lnf6YzFefCefqcYa+xvORKSMLCmoP1KygjZmg7TIt8RAQv047V/aiikq8k4xPBwkU94f8UZ+3WYukiJPaxAy/n0O8QQuDrmY2bCI8iDhvVsERwjK/GVsvsoLTq7/gRPDa+Q7at9F1VOxX+Dl69Q8IrXe63uQ9laIsHVUyYMxQ6lV2D/qmaIGhN6eofpZPsU6xu7H9RzcIbZvF+gWybMobditYSbAod7AneLlCpQ7x9Bx9Nj28xBNHZu5bhHrmEpz1xmcZnKVORroQ/VaBx4+G53VPQkgJemKOtPwCP64zJeKEvHu6FuOznD6EYfub/jaaUnVYcbOTgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 06/14] iommu: Replace __iommu_group_dma_first_attach() with set_domain
Date: Wed, 29 Mar 2023 20:40:30 -0300
Message-Id: <6-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c99c22-520c-4623-d9b5-08db30af00bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qwe/J80xMF2yrZ9aAawvJJ1Tdxd0Ndkb4TcLHKjEQNDdofkOo25116ZOJ8Vb9XN9bLI+EuDlBPhGi6KlPwCvzyTjlvuj7zTw8Xvp1ncjjASNr1MBUgFWMcIAu2YrCneRoul/MX+L7vN1gAwHAUmy+VAyXk8NNXzTyTuz6TNLy5kMrZMnweixrTlOJU2WLDCirGD0DvP08Dc58tpvXBPoJidcLfrzGZirRjJfHOf+swU3T2lM5pWN20OfHWdyxQNYxg2rF441Odqh4bdhr72vBO/gcswnK4++jtaxT5B1YEldz5tMpmli8dpbArm6VTHkYUNvrrR110Dpg6BdPExYc0abSv7gdJ9bcWMql4mucXXoyPO+9zffQqGsIZFmSNCEocALotpd6e9dNT8eWiAwXHliei/J2yVpskpw6ILLwMw8Bv7RT8eUCwImNJuCqQmo9/txpatXxFI8TisnAvWBz0IQ1butIkIGEgsBRsSDF1SMU5RnW65X4gQQMsl8aa1Pbt2IpMTiwc+adIh+zh9LwHbQKmb1ILWrEGBLBBFjQcb6japi5yT7tSw6xAlgxQqDe37p7Il4HoOkLIXbbFUr+UQDxikkmq1h9NCjLxKjHJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9riBbi6kYQlAvk+0rNvbwqGx7eYL+IC+ZKDml4Zug2wDdYgzTxg+cfEmCiC3?=
 =?us-ascii?Q?LuLohzyTU2fMX298tW+bSYMMXZfdS2Ven1Jzu2wtncgQE+TPtiqBKY8nBbwk?=
 =?us-ascii?Q?4/pUw6xMbRW2ABLeKiFtVOgve+noMDXacSI+LsP22E+3g2MOjeqxwDnLXI1Q?=
 =?us-ascii?Q?0y8M94z1zEzeRG5kn7NeasSw/BXLprqCLbG+qoLN/Rk8W5l3ljBVKxqiiJMq?=
 =?us-ascii?Q?gRTJw3wQr1M7ktaOY9TYZaZfmFWihUSreKeVcs5CtNc3ncQCdexI1Po1o+qs?=
 =?us-ascii?Q?FKDzfY2EqEf5vXq3NrPBgZzHP3a3qUD6ZbtqjU0vdrWmYzCkye5Nm9WFu/VQ?=
 =?us-ascii?Q?8vgyFyIEsk55SfzcbOZqIAoBjBuyVo8X9IpzcAA1RkL+xwwqgUjnneMBkaSm?=
 =?us-ascii?Q?KyGrHVJlKYYsdQvz3R9vqS+mGFsyTHER1MDJfGWRc+NT9DCRMCYjsXjRD9oj?=
 =?us-ascii?Q?tWqEEr25iRHdjB1CEbtfKYgoxb1GaQ2dMokD6ABgFf8QBom5IC5Ockz2BYSd?=
 =?us-ascii?Q?ciTCbvzQdFLIyNVuU/tAClvYSURDRBwtKYht+aQYV7Mx0DCdg5ld1tzxWofc?=
 =?us-ascii?Q?4zShRHbzht24Sk0DMDYUEz7yrpeyNhit+fGIifiOZ6v6/kUoi5X02UDbSAO8?=
 =?us-ascii?Q?jUY0abzeTJoxGKCd3oolyzw2FtVfzhi8pbCmMXPkJT2VkWSe857dlKG2eo89?=
 =?us-ascii?Q?BheMT+PDPko1cLK+vyUabI4yuqsFSAqXtGmGwXARCXUgSDDnua/rY34avSz5?=
 =?us-ascii?Q?xL3ZXOkmAHQDTl+4KzotJdpvUbS/Kz/IjANYkxYX0t/6yiH3cGA8Jn2948RK?=
 =?us-ascii?Q?QUYGfeR4P0Ww+L5X7V2eWxHIFycRp4c4WmCB6xF9neH6C6USXMWNK1r7YdQ2?=
 =?us-ascii?Q?d64WYIQnqYDJCXs2FX98KblZe2Enb6yPf7IBKZCA8eHrcD8wcEDo+EhIVXBq?=
 =?us-ascii?Q?734EG9h3KMAeUu0ambKlTNaPaLaQhlN+Q2Z1gbrUtjbLh/ySIdq0sWpp8ecq?=
 =?us-ascii?Q?hhvuYb7LpuleFNH+cTd2MiYPgAqidNijHPOrvFjpvIgGf1hFPAYQI7MzAgKs?=
 =?us-ascii?Q?PvviMpp2q3HSKRJJeSS7xg2FIi+Mwd61Th1sesTT+LcN9brdVCKs4r2aO1N1?=
 =?us-ascii?Q?gubpcp5mvVmrQPL+oS50OPhq28T+HUnD4KCe5fUdGT5H8NgtK1TmGeaf1Dnr?=
 =?us-ascii?Q?zXbt7MG7BbHdmbA3W8QHcTg1MfRoAKSysfbo/DrB0RDhsj6wt4wYuatJabA6?=
 =?us-ascii?Q?6RfIdWe5/xpwy7jallJtCFY6IQuAqnremmNmEdYjrFOYf1I2PIEaPUTVawSa?=
 =?us-ascii?Q?vELg6AEoIjqApRwD4ton7u81iVfutBUwFRY/cmILzUWpHWNZQw3gfuhPpxyL?=
 =?us-ascii?Q?3rSjeHzUzKYnCCmH4KtWIglWmSEvCUMYksErwx+eYAMFuj1jIrMBcZw5BlJI?=
 =?us-ascii?Q?rHFOVXMrPItf5s89pelus5pdL5tqJxfmY8Qkif2QR2Xxo90bDjeXpA+kM+j1?=
 =?us-ascii?Q?CbytpGfXL6aUO/0NxkCajCZHXzVpsZ7qTyHps3vVduDFqeIVWuaFbhL/nFiU?=
 =?us-ascii?Q?I8/NZ5bKlbRrair9MNLRE0UViiRfs16wnwc/E9gv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c99c22-520c-4623-d9b5-08db30af00bb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwRqx+UIqki5IRlgDy9ivwER7ZG9enRwVpNT6LRrSmJefqzC4gx0VZsKwZZQ9xth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

Prepare for removing the group->domain set from
iommu_group_alloc_default_domain() by calling
__iommu_group_set_domain_internal() to set the group->domain.

Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the attach_deferred
logic.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd75d7405a3051..af3af752c255e4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -102,6 +102,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
+	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
@@ -1855,12 +1856,6 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 
 }
 
-static int __iommu_group_dma_first_attach(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_first_attach);
-}
-
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -1923,7 +1918,10 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_first_attach(group);
+		group->domain = NULL;
+		ret = __iommu_group_set_domain_internal(
+			group, group->default_domain,
+			IOMMU_SET_DOMAIN_WITH_DEFERRED);
 
 		mutex_unlock(&group->mutex);
 
@@ -2218,6 +2216,12 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
+	if ((flags & IOMMU_SET_DOMAIN_WITH_DEFERRED) &&
+	    iommu_is_attach_deferred(dev)) {
+		dev->iommu->attach_deferred = 1;
+		return 0;
+	}
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
-- 
2.40.0

