Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B851DA4F;
	Tue, 22 Aug 2023 16:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abd1IjIhS3A/dWBtpjHYZOAXjnF7jr2TjKGAgFA7xGOWzOVtcsLyJy3NuS4gfApEkblclnhwew/KReF2xc6Ip//0Bk5cnewXbzssMRr2C68voOoxA3QUHmnAejzZIi3SbeUEjbaSfKIEttMpAxXk8yYxdFyDcwc7vXDMGPQmBauYCAnqn9oEzMUzqUTYF6WfEfj0ZMT6p6l50gi+4PLT+7QENRMzoPFAb6S0s4dJUU65BsXS0qPB6aqJyrjGi5iJXKdReXVg6JIyXhw6kR/od5zpspDcj8Cju51yNPke6recYyR5ka8NCxG8CuVfopVC/3a7C28OuTslmwtbp3YoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77p/W8bYfwoAsp4qOGyBgAVJvbIeahNz5F/HKfJdg/E=;
 b=bJIrVFWVeuAelnrywGTHjHz0ZlJ51SNCsQHTk53mNUWXOzC3tyfJCiF/nfAAA1mTQ29I5rbiZbVQGpSupbyJQZ3n9AG0TR5hTfldARtfM3oRy1MSqpVJr0AJGvHHkana2Nj32/eebtsfjgKHzc6BjYL83WFh9BUhLHYuAua3qRDHIj0mcvW7UDC3lcCvNCyPoowr2wKn9u/873VsRNusmfs8Gu8/z60UDB45t/PpDtxniHHAEb7TEzJ8AQATPc3bUDF5ZgKKoPYNNUIWekXKtw82uv57jPdMy4NvTNcfdFwWdgax1DbcvDcsSyENOk8xSZFLk0DfOzJufzdn+2HQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77p/W8bYfwoAsp4qOGyBgAVJvbIeahNz5F/HKfJdg/E=;
 b=swjEgnDUdUjoqWsOLHyqHfChLS3oNidQCK4QshHtuC2PtUz63d0ZlwSnjrB5NrIQlnlprhVAY7qVEr7NMy+aCCH5JCGPFEFnCsD+0Yma0D2pm5dyhRMRoptXjSyxea/j5bcRyeLidY7OPglVD71muCOd1EP7zXypXJz668gvRnd8fS0T0rkB1ndMmgJfbbsa3Z+zPMADjxWUZjvb2BIPINQT1sWnLce8d36ab0SrfaRexZaIZPZlD1TXArofqZKWm7QWra98KXNakM7IdPf14S+iotWlJPHR0/SGUFBfPM/BXhpIJjVTQZMSHqTdG7rvA/RqmAeEMxeKXrqok7wKnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 16:16:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:06 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 6/7] iommu/ipmmu-vmsa: Convert to generic_single_device_group()
Date: Tue, 22 Aug 2023 13:16:01 -0300
Message-ID: <6-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:610:4d::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fdc0ce-31bd-4d5b-44bb-08dba32b1667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NFHsBcJni5M4XJHRWapxsjGb2bpDZMtO3EQrKgxyR4kd+L9njSwGyytuj9Gkkwvve9h6k4DbjW5gDAiDwACM3l/jQ0NQWRh6GQ9xBI/X6GFZVcoDt+fvTrByCZN3sl/HTkMTZ/C4u4ku2+4ZYXXq5UtJXVu4ov57o3MbFpRtWzesHd9lgwKM461yM7+AX6o6Ia2J9j4XExnYHKAIDJJITwgOC3MCzXQJE4RA/LP29BLxxYdO7U5jc43nrWKFZqlpMovxvxdz11f4PQr0d+NX/pa4sP8LHxeSt9rLWFCszCqWPcXz31YbFzeYSjNDjBy9yD/7BWBJxq3iV/7WbAVHhXr5sxlf/oKUshIVqbPjxDmICqyyMcQ+eAx7JSWKW2mkpBCKeGsM25FtRAPhMrtetZGFYYDfaBEFzRVVduS/pBOuk6fMbgbBec7OPT8hjkaAHv6gO9ndz9lF+DfD+NKQl2IIPXDt8TYetlOXkh+3KYhXPipue4+nbpIV2kkqLny605BICZMC6KY5/gZfVFyrgb697w6WDL+gms1s1ApAEE5VUBHR2ROGBzOIFlLDCL1XCTy/mLa2o3SdEfXV1oWeFerX8m6a5i/6UH/0e3WTDa9Wk+LjIVnhlUa2edFYUis5qmkmVEVlD+qLyaTDsCk4iA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(921005)(26005)(6506007)(6486002)(2616005)(6512007)(6666004)(86362001)(5660300002)(4326008)(2906002)(7416002)(66556008)(38100700002)(110136005)(316002)(54906003)(66476007)(41300700001)(8676002)(8936002)(36756003)(66946007)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgQ3f074og1kwpguZvvvx5AiBw2TIDCNoDxBlBZT9F8GYmsT+9UYtaV2iOBs?=
 =?us-ascii?Q?3DsySrVZbpj8h/CQN96duY+sH1KmaWMEbo930fEZGMv+kx3GQSp6fQnDvjM4?=
 =?us-ascii?Q?ph3SY6HrAVZCKAjmZoeRYIzJ3SZzaFLMkTqn+hpjeKfFrepYLKPXChw1bJCh?=
 =?us-ascii?Q?zRrdISpzeiA+9qHI/+jtKNB9eoZSaX4mMnmc/HqQ8DPlKvTqy8Si9Vijw8CQ?=
 =?us-ascii?Q?1qqGa17Ko/kKcg63YyQn3dYJIAanEzo0Y+xRm1Vei3Vl8DHSUrcF6OWQ0Jto?=
 =?us-ascii?Q?kstdgeuG0xxYLaJi2I43GX9Gf/mqM7pMvDlGy2a2ZsJDt2RagzvhonzjPWCh?=
 =?us-ascii?Q?zATHq7IGloOGwcVqafuNd08EQYTRLvyb9ZXo+1ddwknemPGWdR1V6GjRsetI?=
 =?us-ascii?Q?dC5bPoh4BXk15SWPgFkME1Fw2cBDA0aCGvozwqZYJYU15ORZzEfSR6a1znYi?=
 =?us-ascii?Q?+L7JAVB8328Ov87+esttb1kowoe9IQSVcyRxP8BUYJZVd2Kg2VIbJTqRYmZa?=
 =?us-ascii?Q?LJVnFezsFcQkP8oBO7wf4TNfK96Lf6Y+sBiwz/4oJJNz+vNaKuXpT6UisZh0?=
 =?us-ascii?Q?D5TR/T/pgIfiB9qBHhyj8rWD83/QrLntcXbPdekg6WlEkHDIeRyWyzHvSTa3?=
 =?us-ascii?Q?RIBQ5yw5xKh+YUqEUppVic6hI8b4TD65yMlai5wbbsClsC9tzS2BzygAD5c+?=
 =?us-ascii?Q?f3HkR2Qn3V2iQpkd5CpalYxaGZ7B4xhJaheKPhfmpZ9j5iClq03P/89ROx/i?=
 =?us-ascii?Q?zoMXm81haE7QHHu4pxmoNkfJ0sfQXWx+arai5167QvjzAwQPUFNETSRYJl1q?=
 =?us-ascii?Q?WrdaKiyfNzSAaPqm1TgImWvNQJUS/si3fOru4yLSXC3NUDF5mM2JrfDkotql?=
 =?us-ascii?Q?4vSlMN6GCO3bKCD2K2Reb51xoHGeaEnyCttuocVUnfjYXdwgPP2z2T07QtGZ?=
 =?us-ascii?Q?PcNqRoh5w1xi3DgT/RB9WCXn2h9UN2/gl1o7zbs9ar7XDkXRBr7yDbcQnPWI?=
 =?us-ascii?Q?KbJj8ih25F78vGn8m9Lf2+sGCFZ7g3g98iUKyDk66eHN3fUybQYKLSJp/LNf?=
 =?us-ascii?Q?k6uyuUZyhAQLSM7mOt7taXtfGa0BBi8Ta2j2mxHLNFCsY0yJlJUc+MiUEFAt?=
 =?us-ascii?Q?nEW/R8ov77sUaaLaEDaRrk5WFBDmrfikyl77uUUIuX40LPNVvIkAqce5rDxZ?=
 =?us-ascii?Q?HJf3d8L9vJxoa4yKr1Fenn4M0Z1DhgeLu+SrEW3pApg5+s/gqYg8Qb1rTdNX?=
 =?us-ascii?Q?73gcezvhs4lB15w3EBR/KAATll2CpQ6UtB+votWaLqnOSphBLnL9Z4pCfvPK?=
 =?us-ascii?Q?uHzsbvmCpW/E7chCFNJj1lHbhi5DU4I6T5YFHBI5Jvuhqhe5K+vC6askI0Ih?=
 =?us-ascii?Q?eEcILKcLMXk+xm9VMGpXvD4HN71nFgQ4xpmnOsuuAXihtOQUFvlioZ/on6dr?=
 =?us-ascii?Q?3e8XCrFDl+feDjjSUVvMlwJWtHmWoJOEm6xP2XvaEkppyVE7tCxRetJxCUSJ?=
 =?us-ascii?Q?QM6IlqG86m0BLQmWIo9RvSiktL4BzVVk6F0rrnx7zNMaNNIkM9y8nSXN2izD?=
 =?us-ascii?Q?SLTKw5s2sRfjpbFQI/VpTe4b57wq+AdK+QQtiF2V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fdc0ce-31bd-4d5b-44bb-08dba32b1667
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:05.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKrGtzxjfS4xOzlwYGkdkwgtFz8Z2ydouakVgnVrReppsUOyt3gQya0qLflBP6Gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

This driver is kind of weird since in ARM mode it pretends it has
per-device groups, but ARM64 mode does not.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 65ff69477c43e4..8e198776ccff80 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -64,7 +64,6 @@ struct ipmmu_vmsa_device {
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 	s8 utlb_ctx[IPMMU_UTLB_MAX];
 
-	struct iommu_group *group;
 	struct dma_iommu_mapping *mapping;
 };
 
@@ -833,28 +832,17 @@ static void ipmmu_release_device(struct device *dev)
 	arm_iommu_release_mapping(mmu->mapping);
 }
 
-static struct iommu_group *ipmmu_find_group(struct device *dev)
-{
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	struct iommu_group *group;
-
-	if (mmu->group)
-		return iommu_group_ref_get(mmu->group);
-
-	group = iommu_group_alloc();
-	if (!IS_ERR(group))
-		mmu->group = group;
-
-	return group;
-}
-
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
+	/*
+	 * FIXME: The device grouping is a fixed property of the hardware's
+	 * ability to isolate and control DMA, it should not depend on kconfig.
+	 */
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
-			? generic_device_group : ipmmu_find_group,
+			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.41.0

