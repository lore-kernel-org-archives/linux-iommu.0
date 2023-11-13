Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E22110E
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZatcrcA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KudphkosTdywq42qwvQa1ms6iPt9722wt5cC+z+12boVG40idn9Xt3AjGU6mh03KJfkPe5c3NMCJvZH+VXj51F5UVm/Ix0O/lAlwWGosrKPe14J8advwT1f2JVkMqlKRIm9fOEHqQb7pH2HDRYx6i2gYSqP9If8SoZsxpIyOYyP2E6waJFr17cBUNoU4iGtIEkzLRb31tcRHWsdASrJTawnbNo7WP1NPIvL/aueLOhPtHzaUWUGQ3fECwWTw8YsqwnDwTX0Me3E9buqPnw/U/u9DGAL9s6/djsTL3lQbPiqIq05I7JfyJ91aoSZQep25xIB+3d5gFT3u/dssOKHFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk/fdQ9QCHCZ0pmWGlv+J0aGKg3vEDZnOZ6jDXsnwZo=;
 b=P8WvYGSjatSWnKAI64BP+Ck8/E6+ZD/9jrxAFcAH+QS9SuHaY6TDAZG5N4cUOLUoVwYGuyHs2jUvnh4vL8vER1H04lVpZTUo1aZZVRWLLngdaq5uvz33AYlQ8T3ftFZwkOcQqpuDRiGUGJc4dle9MNCMzCq6ju5b2TziMVvBWgZswP0xOj0YLaA5lyjEHOnz1/IK2PDavD7s5zmuQWDAZua5mX8GFnIjsg0mhM46ZyU0GCOYwOprxBC5jfV2mxvTIze7b3ZM6Va7PYgiw9hrFCRQ0D/iYfL6czk9qdli396apH6PqFBQ1CuJaCs8jEFZGTCxmjh7T3CWYbd2zfyvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk/fdQ9QCHCZ0pmWGlv+J0aGKg3vEDZnOZ6jDXsnwZo=;
 b=VZatcrcAvvXGgn9AGMvpadnwVXVSoE686NxqsQY3ehShJIXqOSF6FbKKSdOh0vkxvhEAIlgF6NzaQe+zJqKjYgrEqrx+ACbw9o6Pqs0ff2bGKMVgRWfVexSL6E36Izx1eymrqp5Li6p7c8tYp9/LZ/NlBcUSOtY3ztBRzFH33oDs1uDX1y3zvRyHhXZBDNgRKI4JBFYQtV7+ZJOegWtw0NiSlSIIReapzGH6OK6Md0HIziFiPlgTA38Vk6/vnmai/r8a712YhZ2SXEH3n8SKeVcE0Qiq4u1csUBMmW2AVTl6+bGDTkKZFCo/9tBohmVMj1z4VWtM40HsZH4wr1R8zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:33 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 19/19] iommu/arm-smmu-v3: Convert to domain_alloc_paging()
Date: Mon, 13 Nov 2023 13:53:26 -0400
Message-ID: <19-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 152850a8-6479-4ca3-17a1-08dbe4717083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4rCpi6ZeXL89c0akgyw21vAAyxpoBt4bXHf1owqzmpQfEc8b9iACpwz5xT/pF1J4k3F57xflAJSIhki6cBHM5iYW2IWPFYB5HANG30em4JHKD3SZj4kLGYXi983KUV34YgY54UylaSGLsngAQ3k5lK1HuVcBeOKxlyseMA9h5+pzgxprtuw+y2EY3LsWhchKV4+xVd0au5JCF7JkeEZHZbi/jYBAVzJB07RaiQm/b3nlObJUoQz48mMzrqPK25CwYm8zzbFliu06kA0+lraxsGfh4xuGeJLSr5644QBQVH1qp8u4l4/pshg2DIK8UwvO82KB70c/6natwEUdThgKNOw9qG4n8WB1mspjGqoMA8RTstUqTmHAmF2jyapmNFWl4ebOXNxLWBnRMDSQG9Lwsvlg6Ed9goxPiR86X11v5wh3z/6JAIgdfh2q78zTOVvRB1iZJfBb0QtAXt1hBD0Wexl6OrNM1SMcWGsdJYjtO0w4bc5sCIco1CNAF0gRue5iOALNOClcsgfkSmbkUjQBtj2cPH9Y7N3JRxsACxSxHEEUZ/WF15Z558bJZiC6iyUh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KKLcuY2og1UrDp/q7nad3jMG2DWa8n7c8iEKccMnnzDnHXVsnv+A3rG9oPdu?=
 =?us-ascii?Q?vq065Ml7BsjU4f3UzSxPJct3BXrRy0n/apTBSz1yPMFk1krT8nsuSOALIOOT?=
 =?us-ascii?Q?kF/o/r9GX64pC9n6WOOWXPRc3xQqhtMMPKWcldMNNY3YIEp3MjHVycPqys/3?=
 =?us-ascii?Q?yWCctQA4hlg4QiGtuFbcWG9PK3hEJYHQUZl/k1DjnmZ+dGBKPTvwZ3sn5qoL?=
 =?us-ascii?Q?AszUY4GHaiWOsuheeUlaTx5PbE6H/WEBeFk3lw1eMRatd77GXnEsGmbCrqNd?=
 =?us-ascii?Q?FDyL2ixMXQnytSxIh9Tbsrf/+rrEz5Z+BEEjJxu6SLqaXZ55Myb1wDjmjcxx?=
 =?us-ascii?Q?gNSlRaAN5UkrKGMMJGz+cEE6cpu7o2GfKcHdq9Y7J7qka+0cj2iystWhfFGq?=
 =?us-ascii?Q?LQLn7INQuef1yrHzvyE1HeyB9BkAszEipFuUWC05haJ8+aVSdUts+MS4WG6E?=
 =?us-ascii?Q?OTKP6OFmPXyeaeIexV8mW6op1TDVGOBHSmAfma4W4EMVU+I9qCRkVcjZIrlZ?=
 =?us-ascii?Q?Jkdr+uWAhjxUiXsEqbMYMzwYXr2DckJWYJslLFXY0Mq4tTT6tTj+70XIsfSz?=
 =?us-ascii?Q?zJ3Sv2YgqNFEK4mDu3bICo+9CDvIQakQ3dGyzkXdAM0b2zuGINxZSLIIZgRA?=
 =?us-ascii?Q?jaPwYida56V7CLHrQ5HB4/AJx24FviAYOw52Yg7r7imNQm4BRapaPvaanopT?=
 =?us-ascii?Q?k6wxi/q9n1eyU7q0BG7+whbFJEIGkFG3P5Wt0lqQPyqVIv6ynbwsem3Ozj/0?=
 =?us-ascii?Q?X+pPXKJT7dkHqTgnorW2n1L5R1XEZbfvhl+bOxd1Wxrd86MYDRbONrOVs7ra?=
 =?us-ascii?Q?mc0v2rEU50/MzrOqPtjUoecGJ78zOhSkoxEra+BV5lFwREYdSM4KpoHEA24q?=
 =?us-ascii?Q?gD7NNmOzH45a35lav2Dsz9rHG9DdHx4R7Mm/7blkNnWW4b9iM14JdyWUaXxh?=
 =?us-ascii?Q?sewH9uvZ94yU9BgAcw+bd4P8Bza7iKJcy/6W5kRYNrAedBOfMv68s/ElQUoW?=
 =?us-ascii?Q?qxiYJCdJOWJKaFLASMNJnM/gxwngLTCdC1CCEwx9AC/MtwIJc3YZP8/e+loI?=
 =?us-ascii?Q?D/GpV1D3mCKSW9vJAszHGoHHw+V7hIhFF2+W4omK4EcdP4IqWAEo8Quhues4?=
 =?us-ascii?Q?D/D4rFR8CS4UGbuetu1Bqi2FbFBn3lJj9RcuYxVHOpeMDSjlPsa5toTVjav0?=
 =?us-ascii?Q?t96j60DOHKT7EGnkjATI0Z1xXT3zkCQ5EaWpGdGAdJMt0iwNzlXy7yxXTnH2?=
 =?us-ascii?Q?TLS8z0lRU7VnJ3EXqtKkA6j6rc9wV/tk3WdPoXiOC5OO24lqvPtthcL5pHs5?=
 =?us-ascii?Q?tuBBJIbMkvQgLUlkPduaSqEm/jdIVD9HsVlQBeQNjiXkul3NM3dQXH3BHtwV?=
 =?us-ascii?Q?O/r1N0riuGo3lEKQp/bpAWPq3rsEsZh78dG/PtemLtc+LiK6x7jTBU7hbIXi?=
 =?us-ascii?Q?xQwCkBwfVMq5mJhZdom2Lqeujh/LIymn13wd4vQx62bk9NeaGJyQea+chSP5?=
 =?us-ascii?Q?JtyYgoBGUXWwTl6t8R+ZIqe2Un71DtEgReYxAWAva01pvGBXuAmKtQzEjxDr?=
 =?us-ascii?Q?/b+5MU/OapzlW9BQpak=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152850a8-6479-4ca3-17a1-08dbe4717083
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgAq64VlO2UaIP8upFsTGsVbqcsmopno6F7PBSBbXWkAG9XkqXL6MkvF9EOVCM7q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

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
index 50c26792391b56..5667521bd18091 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2170,14 +2170,15 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 
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
@@ -2193,6 +2194,14 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
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
 
@@ -3058,6 +3067,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc_paging    = arm_smmu_domain_alloc_paging,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.42.0

