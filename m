Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CA225AD
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crK/1hkj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRh6sUKDiYsx0RMvMkC8egva//HSgnfmK/iMbljasXuqqoE5P2KDD5rLCVlP7ly+U1wWXlcQoDMRlkAB5x5fUD8dXKTbxgtNixjql1uf3xjWFyoVXjlTFYF/CRSE0l1N9gflzCRiUFp4oTOhrDFb+f1dT5hoGM1fTBJlVlscXTh6Mfy5nwEokwgYeFGPnMYnqHGKJSVkabnHeZYm/KF9Io9KXOY3cVpRPiFDvZ7yoNAeuL/l65Hwf7EOFwEpPlPiECFa46EQj7oGqlaxkdu27HSJOJ2y8B3C3m4JxC+ILGs4zZUFvJlvV3c8mJNZkMZ2/bimKjyrynZjqoYkHOxoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prwwyrtPCiGbh1YrTs6eCpDe+5Nx0UTpVHTy4GQOPS4=;
 b=AoqX1KK/eY0rFOo4oCar8AKzGp3ksfh1Mm9zrnwUnPY9EWIhUyn6ghBcH/ON8311H21mN16sCDxqbhR0ecz/5plMzT4u7vq+O2DdUu/9vIevdir60E0V4UTOhYSgB1BjA+GzhZIgRaHzIH+nmUZ6VCDPEMWjBAmE1WSHduGsiH1IK/FsFXSNKwU8PIiMhUYZZTGgQpehHIHKxr5lNrBHH+oqgaEpZtpcbLNH1lDDRUWUsZAE6osV1YHv/5PHymXH5itvPdR/3zXVD0UjzEf30wD6hyqbRHS9qVRRnSvQaPxl5/Y41kgzfQzrjWIhsS9P2mb6S2GDXPzlTFGRWaTpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prwwyrtPCiGbh1YrTs6eCpDe+5Nx0UTpVHTy4GQOPS4=;
 b=crK/1hkjsHqgxCneDiFv7sbT5ZEdnnnc9Qa5zy4aZtQ1CCl1jUeUo0G5CZj+EyIvKeP9w/RcvvxEE5fSjVoL4FBw8aYeUulehnZAYbaZGaRyANzwQeSQ1wnSjz5z+yYIEjm7o2SBmc21WX/4PVe2DUoGCt+yh1QKksprMlR2lhNX0snjbKyrui0quubKgsSJhK4oGPt2yVbP5IhKqVOLs5qkFERaLnhRur4j3nYZzohSW7zTKO8XLRZbQ/hHAeIjEIdiKNDsZGI3+QuAlBsR/QvkjTRUC6ZDr5wQ26T4ou056rmoCxEMQD56WlXrtPKa+2L2uedREe7RUt5BGrv2/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:34 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 06/19] iommu/arm-smmu-v3: Move arm_smmu_rmr_install_bypass_ste()
Date: Mon, 13 Nov 2023 13:53:13 -0400
Message-ID: <6-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:208:a8::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a83163-aec5-490c-a10f-08dbe471708c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XmPorNmPRKrsKGcsWyYtKqBSUmUvGASP9WcyEk7cRYrZfSVt2hFqCDBfxAMGaYnP49aVmxu1b6Y5fuQWNCE+IAW3C0nY4/3D8fidYKBH7/kgHzuDjqn/aBCllc+io6TayztF3k8BFlSSX4ImCYV4Vrb9lSjOkGOvJpbWs1qCMS+Gg8DzVka9BZyzQusMmMdsG/8wVCCy45ZPg2SnbwBN4ZUwGbN0rcL15tiY8DkwVZ9inITrtGbsjtXxYWGY259wnHF6Wg26n/FRcLwTbsjfzQbUf7bFRRPEXckp941BaNQjLOfkV81ikPtUOZ/yGAi/h4Y+FPxHblRphjiqQkOYEOOsK1BnGTVJLRfQ8NgDH1wjWilVlRUn9Xy6RVAXJpx/UAo26NPLg8UGJLzsKHmhKsLit1C5INRiNb/iHJDeSh4nmzKrN7+RvUCIMHQ0VUw1iVtLF0mbXqLHkC+fBn0AkvZoFMKQcVRsnOv5EqrOGjqNlOdX5kiNk8SZpKUukWMCBnOHB8xFdm+nNqM/ykObRBeiFZL57BOxdVb7NpFtzyBk7n488qdojdJE4cufUAAP6hKw7JiCExQnLO69jSDuS8VLzbyb31+S7jYzOGizMTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WaAyYin1Wj6yIT4Vhqfza+siJvUNG8VN3aCsQV992qAisNBlRTyRX6EJjatK?=
 =?us-ascii?Q?vMv2lap4z0vna6iNY+nmm/euYDIASqtgCBTEz8YGH6w//dkmLbIs/gDRUJC3?=
 =?us-ascii?Q?OI5573Xr8Q/+CHsx8dz8IMCEDEOrRwolpoyLijCMjiJKZgCX3KPsYY7R/4wK?=
 =?us-ascii?Q?Nqk9TnEkvwdjJE3ibdP+DEAr1710J36+w6jcu0oR1zN4mLXS9Njb09Yu/6kO?=
 =?us-ascii?Q?5EPAfOhQegkohX1Z0dr2KTGYdONT4SwfIT4nTh9z+zjeocLZcF42MGOolVDX?=
 =?us-ascii?Q?0ICDlYUyRk9cIZkY4Djlndnxg8hH2B86k1MHLM1KnJht1ljCNjbFtKwOCOQq?=
 =?us-ascii?Q?lUvW4XHXqEkNHVO03lnihMiPDajE7hUgAo2aaiG3m4Z8ZGcSsqvRn/351EQd?=
 =?us-ascii?Q?HOQJGxcOHYIYlkYQ5z/F6yHdRRl0J5/DjyBz9rSGqbghBRZzznjMxgwau7Gk?=
 =?us-ascii?Q?Hz07veyQA0lKcsUBu6V/EwWJGY0GgbP3shS47rJSc7q6Qum8qEONIBt+uW6E?=
 =?us-ascii?Q?TyDf6KxB6T/NyfFDVLj8PrZbccn7dtlkJ0ouxEnNBr3MunKb7HOy9z+nmz3R?=
 =?us-ascii?Q?mqu5u+tedWPGdkhK75ICd/MB5Ofo850B6inErdMK7qPWw9bAzoZoaoG9dZYj?=
 =?us-ascii?Q?YOKXbE6uRfTQeNHBFTQyRt2oZanYAyxW7rY9ipGxGqAn9Ag/ema+5xKYiRq4?=
 =?us-ascii?Q?b18hQSD2KGW0Y5jWSYTM+c+l/kiT5mCAmPyP8slT1lA56NZhr0dDF2nytRD+?=
 =?us-ascii?Q?nw7Ztw0AoKmA3sC0o8ggZiIbuVpe0VmR+xE01oo7Ges/RTzQHMDF+msho1nq?=
 =?us-ascii?Q?Y+20Ni2WjPAXHWO2uh+AVKxXY+/NBId1/rQ84GYmQ3JN0qvurwf3Yy14v6PY?=
 =?us-ascii?Q?QCwfyV7FRm7REGw9XSlY9zyM/9umrwi7dpEUbxcLwbdkXyw6GFFIigMZE43H?=
 =?us-ascii?Q?1ElQzXEJeC0tc2P7n730tGjKw//txIsnyO6L9xMOXSDxnXq7PO4l2JIbP8sX?=
 =?us-ascii?Q?Ck8w1lRWEpgCOyXw8T9VfRBvf6ZSjz+ZRNzHcAhNWMsdeKQbV9v532RNMJpx?=
 =?us-ascii?Q?3ZPi+SHpuTRVFaRxNsiol4qA0CMlUIvl8AXqX8PqlSSUOME7BHKIDEJT6g9D?=
 =?us-ascii?Q?s+a53trTTY7jSSWvhv4YCBZe5FAGmyz+ccdOfaA9/W6gx+Q/1E/SJKUoVs+Y?=
 =?us-ascii?Q?bItVtKXTEA6wCb+ceaysEa6Q3oN4tExDTQiNaG3HsLykV1qHWaP2AJ0CtJeG?=
 =?us-ascii?Q?QvyzCCcyvpk9q8/uTNGI+4YzwLMaBjtETsMS1btrZmLkqkWnQ/rVbMb7u9vu?=
 =?us-ascii?Q?odJCc2qWVYqWGDwZZWOoOa2dKYvb5fwiFojw/ySzN1U+aJvPL6nCjYRKkjHf?=
 =?us-ascii?Q?9frUos9hknvoKk6x8WwrFS0s162ktgDYRtpudgTTGvNYPXzaoJz4ewFodtNV?=
 =?us-ascii?Q?WIKgmDiOQ4011qaD9tN0A+YxkmiHLO56ka+dOIqHTMEFZY3yXgazDSyx/Rfy?=
 =?us-ascii?Q?v4EKjdmvSi950drT35MkLAzibZduyVWnI22PtdF2vxaBsplu1uirGOFL7A61?=
 =?us-ascii?Q?Hle6A5M6tdLoIVC6FFs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a83163-aec5-490c-a10f-08dbe471708c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3K/GOk46r1dVioBIjST9TJVM3i4Hac6rDBBLi4SpbuZ+ivPEcsZW8m2CGbzfwLr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Logically arm_smmu_init_strtab_linear() is the function that allocates and
populates the stream table with the initial value of the STEs. After this
function returns the stream table should be fully ready.

arm_smmu_rmr_install_bypass_ste() adjusts the initial stream table to force
any SIDs that the FW says have IOMMU_RESV_DIRECT to use bypass. This
ensures there is no disruption to the identity mapping during boot.

Put arm_smmu_rmr_install_bypass_ste() into arm_smmu_init_strtab_linear(),
it already executes immediately after arm_smmu_init_strtab_linear().

No functional change intended.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 13cdb959ec8f58..3fc8787db2dbc1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -86,6 +86,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -3200,6 +3202,9 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	cfg->strtab_base_cfg = reg;
 
 	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
+
+	/* Check for RMRs and install bypass STEs if any */
+	arm_smmu_rmr_install_bypass_ste(smmu);
 	return 0;
 }
 
@@ -4013,9 +4018,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 
-	/* Check for RMRs and install bypass STEs if any */
-	arm_smmu_rmr_install_bypass_ste(smmu);
-
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu, bypass);
 	if (ret)
-- 
2.42.0

