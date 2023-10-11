Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F423A26E
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1/VNy0g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW8ib8xNEGncRsAms2baC+vpCeQFmHs/+svNk+5RWkoxV2awo4/wSns/FBD94bRmsHuHosgC6/IUvT3HFRGw+TSwCpc4mFZl7Boj9vY00mUm8/zGrZji/aJD/PauQBd3YwjxldYQwLfywHmY6QvxqW5SohpiCjPpHDxol08DYGZbG82drb5hnuylh7B8o/2b0Rn9udV4CoLhpW3MZ1bI6jaFub0oRvwXt1whgA8lyb87nuxWcclYyMTMOm9PCY7ILOMxLW89soxAGn1UH9FAzuga/aXYW9NptWa25d/qhP24eu5qDplmJeahDlIiPIJJJKQG1bNYCmmlzs8VRVlY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBVK+0LEwLCnIooau3BoQzIuFgEzNqUTb75/TTIQGro=;
 b=ayYX+N51tpC73Lvx65LSICh9ZUSqnz3C8DmrqCfnoVTLFn0O82xyuqQWKASR7nLbrUpjf78NJaLiZHI6wEFCrrv4LA6qGivxdFcml88c+ZcOjqWyK2ojLXb0s79qlI0msbY+V6c8I7RQeqZlEBmHPBS0w30mvt/s8UR8Um1lIWq4anCdV522JIKfjU1LtoDSlI2SHxJg+cqcOMP4TQ024nkH0NOv/B9MdQ+9rKIo3EXs3v/Zb9+NeasATQIEWpI0uWm5k5JX709ZxwtZNJw9mopRYEGQ9Pyzpypd2huwXOR/Frsr2ag5a+pSJKNgr2LkcSkbTwRbJ/2qSXsx0C5EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBVK+0LEwLCnIooau3BoQzIuFgEzNqUTb75/TTIQGro=;
 b=q1/VNy0gD4GUV7dj9RzfNcWbvUEjD/W9fkgpaCjcY+/mnF1M4rhJhLsqtrp94ZyhyNYq2RNMVp725VrkIbTU89qnTgG4Mi4UsgLHH3zHIj/Tq9o4qMPL0B6cqFScEb7ng414mfIAU8vkmFIh63QExbFuKT7b9qI7z1IpzAPqwvwM5lJPcK26mHtJOmhOxsdYDQUxEMxzIPF43uBZCOIfMs/E5v76pzMG1KdK2tSTJjEeGOdwIW0Jqk1xiErypv8KYzXThbv+NVkqWUkFFvXsAkPFHAiH/aLsGgggMVAkQ5BSkksQc7dwsnVQ+e62KerQnBXHQyu2aT9fcCi2W/nPzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:07 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 08/27] iommu/arm-smmu-v3: Move allocation of the cdtable into arm_smmu_get_cd_ptr()
Date: Wed, 11 Oct 2023 20:25:44 -0300
Message-ID: <8-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2ddb2a-cca7-4eb3-94b7-08dbcab1703d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fezFY2Cjjt57W2qBj/fQJiYAggXGw61+JxcMMg2ZSrEFVVV/gvks6FSWmiX5UVCBzwjiRpfX3rg0D1OBQykhGfF/3ZTg6S3mKQLIU1xJsD7YZDPtt5N+NGvUXLTvoHxYF/zjxyDdJ/453IK4DqbR3FE5mbWul9XEWgPiKcIOIRKnMl4gfyvydmWGjAIDEjGPgR/dnuCkef9iepLjpnOmnuDxwqKwtqp26EKJnlmNtJtjURFLTU37LD6hqLAVDXXU7uiT8nxyFJkMdLlDmf13HxpJTJcdicG1ptq6bTHkjlNi/XlEDXSpbycqfE3PaLOLHZq87/Uiz8ZW0kgYxD3Mv5Gh25lSrCSISwfcU5GHnUzku8N2+NBxNj5zWxNujdR+4r1Zy7q8tkb5zuyZz7Mf1RuBkWqN8h2fDwQA6SnF6UeZJhOGyS4Mo/qRZurm6BgOj1/RL3iV8D227xhT92abXvedGxGYrCEuNM658cF9zc2Bfk/T9ZtiUkOQg+svOw8BwtHVuXBmwH7dpm0oQFlVWOfQiyv0XtNkHAr9lx938AQWSuOT/ubNgnRQpe65NRKIhc0F4gK7B8jnpOsrA4ED1OYGYjkIz17sz2NClnGpAoHJDLh5kGE7nGES/1Hw2vF+0l/1PoSw7tV76taYXnd8Gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RiGMeSv9xdLUMg6ooC9vwtW08wVYhoOd3w4n9X1wix8uTPW+F3Y5Y8Pwwg8Z?=
 =?us-ascii?Q?6o82Up+Nr8r0W/ipk3f6U2bkyPi7HZjiuu7775HnV4LfWx4bndKP8Z2UZC7t?=
 =?us-ascii?Q?nMW7ANqHRFUxIFA/y400hCXlrDl4XwWKCqC8a1IywunnXd2usmy4n6qY0nV7?=
 =?us-ascii?Q?tFNJSz5ZhrBi9Jp4Lk8afvDpd9q7UpuSBemRroLrixwscogADoaaUtIPStmD?=
 =?us-ascii?Q?IdWLcRCnGFbwMT0P90i0CSJ4A63ZfWid8P6kH0Plvoh02t3t76X87uwihBRc?=
 =?us-ascii?Q?hIjn5xTieRuU0WMq8Ldx31UPe2ttV1AxKnkgL1ak+pDkWYZbW97XCZAtwnM8?=
 =?us-ascii?Q?fWsOGyg3MdbHllavHdPU/PYRR3QqQofhWfF8mkgpmZMM1smTPQXOWlIuP4WO?=
 =?us-ascii?Q?NwThoAK8aw/OlmK6Y2bElrfgHmh7U/NBFoiR8aA/2KpsFjkTH3cg4FBljZI8?=
 =?us-ascii?Q?hH99qFp3rmI2EYYNTibkEWSSR9DEFWBBX/S7DHFTahJpIhnPBzZsZDleT/W8?=
 =?us-ascii?Q?0Zj3dJlYsBzdxakj3Wo/AHzNq6louSf2EKh6gjrpplxX/kMsujKmJMZLGvP3?=
 =?us-ascii?Q?sfAsu2WbsEFk0RVotHryYEFSDZUX0vB7UtSFfyLtcFvZhFyywyH8MtHfrIDC?=
 =?us-ascii?Q?QBmavgzVb5HRLU+ZRMu5BjLmbjYLYx9IsijMWpE9Bk+CJlnFASIwaSmzu3WP?=
 =?us-ascii?Q?iMuebx8uo5l1v99Qc1kK/Bc3cXTrvwVPS+TFDdDy5xtpScQ+ZJlCNhlCbGPw?=
 =?us-ascii?Q?BPl1GqoMlAoV/YUC8QkdAg7cNvGgZzu5rKPOMjOCL8K0K2iuNpcJHC4X/7FA?=
 =?us-ascii?Q?ApgZ5ux3zF9iSuXJk/ZZzY08e7WbTXf4jWCfrTsQYm7xUMhBs/ngmPZTD+Cp?=
 =?us-ascii?Q?8On6peSeAYIuwbAX/3/VThZHKtZZC3solE15CAOA1EUoduSqjHoVz4CiDuDI?=
 =?us-ascii?Q?8QZSDtYNgD8u0dBkRX4NWyhPBcS4Xlj7pN5KItlby9T0HfdqmceIatNSOluL?=
 =?us-ascii?Q?kE6o3ubW2gDCDF7k77mykH7Y8S5FZzSIjaDX21kcgAS30HRw2fQMqhL5jfSZ?=
 =?us-ascii?Q?3XyIo5Km9FghTx2QTHei0saNPs/2B2ffMWHYAy2g6UTfK6NIfMwYiqLfuHh5?=
 =?us-ascii?Q?L/i4N54Fit+shclIzKqDzaoNccROrTP58h48foo2/FxJQfSt9aydkoyK28iI?=
 =?us-ascii?Q?saca8x84ZxlnsrhNrdUoARsUsLn7UNdeUu8NgZSzxa28gfugCr29DrI91+0M?=
 =?us-ascii?Q?tuOqvHgxU302NHeeiGShItedj+tAZwoWqKEQ4nu/QlmUEr5YL0kudJa2Q5nR?=
 =?us-ascii?Q?i3l2iENqwj+ac/uaW2ffDMlrIoarx/T9G9mAo25uYVK3U131MTq3DHuYQYMc?=
 =?us-ascii?Q?MJJrbO1385MIF1uF+54u/J1nvMkIZzmQrYS91vQ2sUMlfp/H/1PHKpvm1Y3I?=
 =?us-ascii?Q?dhNPPMmgS1WFY7SdGrvatNRL3XZdZV7+nQUveOVowJGT37ri4fwh8j0Yudlp?=
 =?us-ascii?Q?v9J17IigTfd72k9J0NR1zl/t2mOAlY7AAeksPGhVeNv/+DlCNkvw2HjaJdSA?=
 =?us-ascii?Q?Ccs9EAy0bz2yO9BP6HnLzK+szyujnXVZdiEFcuKY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2ddb2a-cca7-4eb3-94b7-08dbcab1703d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IslkDG5C0metXZXH9OBm6g9aenwEhwaFg2PE/kfsJFQSCsl2UvxW/Cmpe6p1ZUTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

No reason to force callers to do two steps. Make arm_smmu_get_cd_ptr()
able to return an entry in all cases except OOM.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dfcc392bc57d7d..57ee7be8523363 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -89,6 +89,7 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu);
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -1095,6 +1096,11 @@ struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
+	if (!master->cd_table.cdtab) {
+		if (arm_smmu_alloc_cd_tables(master))
+			return NULL;
+	}
+
 	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return (struct arm_smmu_cd *)(cd_table->cdtab +
 					      ssid * CTXDESC_CD_DWORDS);
@@ -2614,12 +2620,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		struct arm_smmu_cd target_cd;
 		struct arm_smmu_cd *cdptr;
 
-		if (!master->cd_table.cdtab) {
-			ret = arm_smmu_alloc_cd_tables(master);
-			if (ret)
-				goto out_list_del;
-		}
-
 		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
 		if (!cdptr) {
 			ret = -ENOMEM;
-- 
2.42.0

