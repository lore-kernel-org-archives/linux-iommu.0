Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C42814
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HDYCoJvH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geSvKlWoOC/boGhXoXJl5OxESpNz77ArStQVuRrDp4Bc3mlFBBugoOduX+0wM396DlEq9QXFvb+DcFcHkoiwFyB2uGqeIyf6eK/0k7lFQSRhR9sWH9PCjJi4ZDPAtVDArNTTxKeJn++GH9rYqOJink6ndSGWn9XD5f8GzhBNwZSQ6LTmUB/7ODCT0uhbDXlyfWu7iekdLQ1um+lbijXRHHp3vo3kACz9RNtBbysU4Ymp9tQXTSd/xyS82h2a5XGY5ESBzAdYDok90hdZM7RyO7GZu1tKSIK0qZp3/9lNgpPmYhSZB44WS4VNRxpWj3MZEX6ddgHVmUrKmxz+UZzpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN5pXfHl1wjjBYDfP8PKaLCqsrVUbnIEedeq1lfBfMc=;
 b=Vm3N9C2+2K9I1/oQvW7tqKH4omNmwomyJ2c6lc9PSM30KLt8nTVo1tLOVXJ4Gxujr6Se28VcRpt6ANtbht4ocO77fVkwGzgjGtBu6JEMf5+MBADrZ1h0SKGThk0hv3vtvfkiZ8qchBu5qd+u0cYmE+ciVgo2F9u/S+uYO4y3SwcQyXDvCaTxp+Qo0XWR3d2TeITZLRusZ97adQmatFmFxMxsKjVLWL1oCOeXNS2rRPTOV0zoEy8nJyu4x7r4j+aLnnPky8uGFT+s6EJ9KPScPhwI1mD1eihOS9FeR6OsHFx7g72PnKRp06mS53NoqRIENQ3HUq2yqcB9KjSrHxJA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN5pXfHl1wjjBYDfP8PKaLCqsrVUbnIEedeq1lfBfMc=;
 b=HDYCoJvHGoJA9+qQXtmCWlom9L/Bnh0XHX+0v07HN9efs9kIxU1/UmuJ5UndAbfda2CkR6eCHMfdpowqBKpiTPX9YKCjo8NbX2p8tfTiutOH4+ha9EijD76VTRjup18aJjPjHzCMQuiongUNQ9NeUGmqN/MI6p6664wru2hdLJ7cNYh3hoanBFk3rxp5zMWDsd58zCfKCDZ5+PIwE2LV9M/QzPy5Yamrddmzh3o2gc2j1EpWo5eATfdvR+xH0HX5sf5h/3mqpXxOwUEvVzyGtKjJIsOS/al8JK8wkq5mP1hvwujOIyXJd6pNt2VHVtUjBb66IEk5FhzdUxd2Mv8bmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 19/19] iommu/arm-smmu-v3: Convert to domain_alloc_paging()
Date: Tue, 10 Oct 2023 21:33:25 -0300
Message-ID: <19-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:208:234::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5cf119-9772-4706-e0aa-08dbc9f1af83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v+7vxvO/cvRXlVxHp7oS6ZijXymKCVcuvrj7o4QLl0Og/i0SExjnZIB/lcZam8eIVsixDEC7gz7YAP4ONQ3HimG13TGhTzWHp0ZwCp3PQFpe5w7UHonEO0j7QsyX+NHB7d1ux/tRABBDYQ1Cp4AhLgSxFek8NI7lWuTwSlDWVBeE0rMOrpoS4+ELcR15NUnGjNCjx64yqFRMi4RPgaxmBSdQWzhh3+AORIPewHDkPzN7dv7zKLc2VfSU/YfvMKp1dEZM3EtvqATnn/CDt3ZBVmxSBqSlo9ruCOnrrm7UGsV89wxwJyxQavDpmXy2PbUxg14kvIexzRtodze3eEUtL3mJvtDHe1Ik/mCQ+xv3XSG28Y4NJHm7WjXBPtMnRfqJ0vHdiRj6Sx34U/lpgaToBzoRUqTbB+rI3Dqd+ehYK3z8uR3Q4n6+qOo25DaUzliJLKV2f9BWMKyRP98L/4tRoy4lUsRP3IYEDB2qYYzapIEUDQjwB6bfH2HiKt4H25KjRvKufgkJxTn/3LZCx3tMn1NC5Hnh7IbsOJXLTjKOlZzlyYHXKKg0CA0cNJ2RHRaB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/1shM3gQiwgovdILfixt5wEA9QhRS4Vz3YVYdYVmB16A/BZLq5DF/8P4SGY?=
 =?us-ascii?Q?R9oqH8w3noKCFuKv571PuB7YGfuPIFWgspZyS0kvZfPVysxJurL6DY3mIh+x?=
 =?us-ascii?Q?IL9bf/vJzC/2H6IX3j2uwqJukjV+it2EbIqJibDmX0auwr+t+dxLq/OYc3gb?=
 =?us-ascii?Q?H6rqug5Ao2VgS0xYejr9gXxkfEhT8eRqYqAvZlZM/QAspLH/zPZ5IEsMWKwH?=
 =?us-ascii?Q?EIxl69qUazOgVKasjSGVlOkunURJQGfNcCYwJSQKH9APHzoiWdkr4yIQz0WM?=
 =?us-ascii?Q?HkhUA6avFROxAagnnR5/U/rX03ww/XwecoRuTdpohV1mlm3Q0OKlzyH9ZnI+?=
 =?us-ascii?Q?xPO8vAfEgkFSujPQickI3KrJeso63n7pCtaun/vTfkqBFHHdfSJZ1aNluiaI?=
 =?us-ascii?Q?ELnf+HMh+GkBWs5vU/IthlLCbz9PrZdbBtj3kdkMEsFLgg7sihcKJs/NQ+OM?=
 =?us-ascii?Q?+Hf0lOreaeXoGoBPST/eM7WGWq8Cg1HrVYbeTfvCT1iR86EO/EF5eebAjDz4?=
 =?us-ascii?Q?g0OvPyXtslSDFaqc4rLFt6o5AoctLMpwJuhr2jvPptoT9kLna6GK0ARYrBuh?=
 =?us-ascii?Q?ShhDPLXU7G943Dwo4AfN14K//5tcAw99gi/9gxLfFAwEsXOo/wfhQUxilirH?=
 =?us-ascii?Q?xdQgF7NKmd6UDEVVGCQW/SgQudW0Pz6UUD712IFRJYxO9atWANMTrLKDbCKl?=
 =?us-ascii?Q?G36erPzYu0yzeRgWw7AYB4jEEpiyOI63HZ+PNRJCynj7HB4m488Q9Obb0uMq?=
 =?us-ascii?Q?H2mvUJA0FwzJufMX2lzH2uPJaZ0QCKLp9kTbc9x95bLSIFrsN4WEf4+JKjT6?=
 =?us-ascii?Q?3FqdTg4j4kMAKX2rbixrSVSGsfNdPf/es0SyY8FQZZKjB0AGkyoEiopraJ49?=
 =?us-ascii?Q?PtEtajUUveoFUktWEnhqvlqvt7Z8q2aKM6Z1S+zlrR4GDq4O7BgT9kHh/8JN?=
 =?us-ascii?Q?BVPdwHy/EeRxuhn5fdXMqQYdkBc8jkBEjMW31z1gl9aFDpF5DPpSW+2rCIGC?=
 =?us-ascii?Q?J2SBCvIc2BqQbZkGAPhKQ2V9t2BfKcc/beAhjbp5NFiQdTmk6kf40eVXyRWk?=
 =?us-ascii?Q?z42RkHNkMCn9O5PGNkMqZYxVS2WaeK93rq40lGPbe55SVXeXQzKg9zAz5L4Z?=
 =?us-ascii?Q?kWJq3XY+W6iiCGlMAcHPENAqIe8JiOGXC+kgHHXC/IxiIjhJxJ/4hpkbu2WY?=
 =?us-ascii?Q?hrAeY6AihxTkhk4Bhx+4uEadny121iXuYUjJH80BH3VpXXUBwLgfAYba+2B7?=
 =?us-ascii?Q?R6NCes17yTNkBKmNGbT0UfJtlLgMS5Ke4KMzs14loKxfBnhKQPJZygWFkpYr?=
 =?us-ascii?Q?DfM2mveLyJleC/6pDYS6PXtNre28NWMQpAIGKsoGJx8+u/CAt0XOLbZJGtXW?=
 =?us-ascii?Q?f82BGlOtZGvA97olkYrypVKmBzAcHrB3OEoU9NVkwhKPNFvzaeiVgisE4dIk?=
 =?us-ascii?Q?ksRTLThxwIeFxRP0i570ug4R5p9jCyPZOU2NvP4OzzmcegwAa0a8FUL9GP/p?=
 =?us-ascii?Q?2h86diYCTkKpx9tjfLbZ5Ap4bEYiSZLHCPPh5BZWcAPkB8rwI+8/oyXaRpzK?=
 =?us-ascii?Q?Sr20II90woCDTX66kvCfdAuJQT9FrxzU77X5gGfV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5cf119-9772-4706-e0aa-08dbc9f1af83
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0E2aBYQrweHkf0YiMBmmAKowCnN53Q235WY4xguc+tKe+7KZlDOyG6UlKqIx7ny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Now that the BLOCKED and IDENTITY behaviors are managed with their own
domains change to the domain_alloc_paging() op.

For now SVA remains using the old interface, eventually it will get its
own op that can pass in the device and mm_struct which will let us have a
sane lifetime for the mmu_notifier.

Call arm_smmu_domain_finalise() early if dev is available.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a4b6d23590e8f..7c1dc96aa75d92 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2145,14 +2145,15 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
-	struct arm_smmu_domain *smmu_domain;
 
 	if (type == IOMMU_DOMAIN_SVA)
 		return arm_smmu_sva_domain_alloc();
+	return NULL;
+}
 
-	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA)
-		return NULL;
+static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain;
 
 	/*
 	 * Allocate the domain and initialise some of its data structures.
@@ -2168,6 +2169,14 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	spin_lock_init(&smmu_domain->devices_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
+	if (dev) {
+		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+		if (arm_smmu_domain_finalise(smmu_domain, master->smmu)) {
+			kfree(smmu_domain);
+			return NULL;
+		}
+	}
 	return &smmu_domain->domain;
 }
 
@@ -3033,6 +3042,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.42.0

