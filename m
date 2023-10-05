Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD03F4AB
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhBGPupS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkR381yu4EuWsfwm+jZOmzxSb76tthjyNqLAOM6Cl1kVYjP61kA671T6yDMlfkkNozIQv9PRzZZkcaYl0j72BWc09hS/8cURTNaHGm3ZZhZXc0PpEFCZrW5bDTxldpEKVOYo7HksmGI8FS/SmpB5oEuPImH8zurYuET5EDhyr2Auv/8TWoK2u1ezElAnprsYMFKfX2sg1u0YhQXELZDh8qGM1xTtdGQ4079Mv7i68Gj8w/O1pYa1QoECatnnGwL4/2vYzWe5ziJz4jLS6bnkaA+8eN6bAQ6CSGhjJ/AVMe1D2oO/XNmMNchCWIOOmpza00UVxrSKEl9G30yAmnpWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQat2d+3+TMztPZUCIGa4blwyHxlXHKQdS/twT8WFvA=;
 b=EnjISXgkpYM8+plkD46TDL9+1oxNcmHWmOpFCfsblF0zkQ7+3N6dL30WK3umW1/D/TvRGGs54NVrvGAZwHV2vf4fYRXySiVC/cESJXsUd1LHED2cIdXSZNBaTIcNX40Kojp3ckTUo546JDpCIRMRJbzDOW6NHtVMSdE80YklR28SpTkiNqDrjKYleNBR4+LuDJ+JGlIsGXwJ3Sm6CwOVP/pk8Dg94Rb+n4rl590O/2kB5A2LMRSwRNzkRU6se5V3IMEiVVc8LLZKBoujUfRSsME1ggbkbcfldlNkQvXqFRrJq+DSU8jp0Xlm/fop7BkBR4xYu5Au1loafZsKNHL/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQat2d+3+TMztPZUCIGa4blwyHxlXHKQdS/twT8WFvA=;
 b=uhBGPupSe6mnPL5vFB5YEzQR+ymQvXp1MirJ0PLJU9Gdvq/mWiYIfRnNKqXGsUagAr3jtalLuQaeWklSe35z6cW4ZmF8KZnJE2KwEnX3DkqLfwOK8yfDlQvMclWv4UcnhMheSFcr2Do+a2eMGg2v5qeAH461btXp9smh6WmoiS5nqbACPBqEjPOVgBoegy6R+YgQvpQ8NSyeYYiwRTU5gQvR+MZFpZiLoRQdWChkwxvfd30xaHqv/mXK/tyayam74q4amMOGN8e0SFe+pupQBzdSt29kIn7pHx6DNEteLv9T/XLDn5dosvwMWnlb8eyJ2zaHa/+2CfXoqd3Tw5V2YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 1/7] iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
Date: Thu,  5 Oct 2023 15:28:12 -0300
Message-ID: <1-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2826fa-80d2-4aab-c665-08dbc5d0d998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2coUmmCrV79Ws9WnscVDaj5ZDCi1ctTuze2OFpDx1dzNEf7Kz5Oe8B8z4cQeeuxN0kEl4GWSrGJY8vlN7OSKpQA7UVKt2ubLejjxZGqG5zaxBTSTZDtO6p7Me1r0FdkdC1bUcNoFO95UwldNFPS240ZJrBQmie0jmnn49nxHsSoPGKmlHovj4ImMyVp3zeHO4Lzabhvd5+pcU26OGe1U8mbxJFzkRpu47dMxaIoZseBLCKLEAnX2370l7IiN3wr+C8ZP2C8golLJgJ3ayagdWZfh52RZojC0s/Eh6hFOhg2u1c2j8tpCFw+tcir0d6AbVgQ6IXJ1G521oo7upVoy8Dhh8flt+XDJW4uEa+PRaaZ392bym1yL3rNxP0yT0s/LW5fu4tSGiGU3cEeQf65pOGq2IS21xjgH5Az64TOMD5szWVMuZIUTR4T8Rt8U+dKhqnOlp5KW446xqwA2S4va6lFvmWLWiYqnpooYCfTjzxzu3Fg4lEZaiIXKbPdZmWruxqonptNI0F47lfQdpgfBVFJVXjqrzvsM9Jbm2QdaHT4FEQxd6GNmT9/2q6iYPcUF9QzmsmBpZ5Rd78ldrEV50Y0qXa4Vm2A8JPuZpDmdxjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Sk40YwRPk+HQ7S8w+LG28XrgKnM4oY0fXqHgj1xJfBVV+z60qSpOKqn8C2/?=
 =?us-ascii?Q?7n+Golw8IxALkjEhj04A6Zc7+P9Y8MeAo0qsBnzAnaIe7trk+EpCafJi7Myv?=
 =?us-ascii?Q?RM920D211iLhH48WZDBZb0z/tFMjGV+VjGlRP+qdkRPRk+vw5NL9vRSg9b7K?=
 =?us-ascii?Q?3TadrKZaC7nYPmhHVpgk/6QGokCPG/j7rCPfPWnctd1gOheyVLqRRT1yw3DV?=
 =?us-ascii?Q?M33iqW/ZDYasS14xlXONeNcHPcSzA/mu/VsJ8/Rfp7lHw7+K9Yl2F2fsEgeX?=
 =?us-ascii?Q?bVrEVrb2EWYM8FELOEncDIPedskFVzFOM0WsuKeZSKcW+BCPx/pBzPHgZ9em?=
 =?us-ascii?Q?KvtBAB6rsG1okotzPXfeZ8l5w2M6Hp6pxQtGh4/lq5ITl6vtOh2oqtUkqvql?=
 =?us-ascii?Q?YoP6GqK2N4WCkA4MbgPrGmkh5OhDKDP/cXRU4pwmpYKDnFoaelP8iptw0S/T?=
 =?us-ascii?Q?lu/k9JGeX0Ek5Kr8Oec99h8dheslzpft7eOd+py5ZtFY6kKcmRe3fn0oiwCL?=
 =?us-ascii?Q?PzX6Igraa0uRbTFND3E2O9INT4an6z9kg2Ym20hP5X4nhGCIr8T7THbb74/K?=
 =?us-ascii?Q?oL+YFjYWwz9jDtpmEDAKn4iSqO5uVOiEt2342TP1LHit0GLB/bATYsHWctAO?=
 =?us-ascii?Q?aIPVz4tnhoJKoI3xids1pYFRMk600Uz+WXfRTdn8bn8yualoSObBo6C50FiI?=
 =?us-ascii?Q?jHDPlsL3gvnbrz2bTYoQGg+RnNZ10Wu0R7rJsOfq7Gv5zaNImhAkD3ZpAQQS?=
 =?us-ascii?Q?c/+ikPyKkoxGhZ7rd8wzfUG1teq9Tmxs7gVJTeDCjfRgu9/LjcEtx6T5n8gz?=
 =?us-ascii?Q?A7SwxqG0OVPTUMruHxYOojvT+7ouP2BcVoXsrGN03UKiZ2lINibTJQou7qoL?=
 =?us-ascii?Q?Rp3qjWhwLrzHxWxg0SnNrL+Gfkl9wBV2QwHqTtrdvV0FXgOj3bh9sATkCGFp?=
 =?us-ascii?Q?f+YUEAhNAKhf89+DDgbwP+s+lvdoirejSJPL8LTpyhbrs+bjmyTmo2eKuxi/?=
 =?us-ascii?Q?tDTbV+UiJDT6rRQ/Qhf9K7n+GN0mFc/K4S3V2JYYDZ0g2vc8MBLDCqJIKLMw?=
 =?us-ascii?Q?Wsf9q/EbczCdb40wA809g1NyTGWbTY2VFezSsBeWpmYi9wLpiG2mqyFIFkIy?=
 =?us-ascii?Q?2L0Qp5gfxnb5XP9QiNn+xhssD739ZuqP7uxGYww0qoira2QC7lqkCIzYnCBn?=
 =?us-ascii?Q?i2H3OGJ+1w2dtu+KmlHA0FqjRpwudBwfGySTvpvU8UOaT6/b8SRWHLNT2Vb3?=
 =?us-ascii?Q?a1314cBegMQEoZdEYH9fGpwBiAIeixX35VT0rq/6QvxbS6ebwq6AK109Z9qW?=
 =?us-ascii?Q?eIL3M+Yxh/oAmJ9+ugjL68OXHGUA4qO9PZQFnbUA7CjkoG3zstIdE/iAFMtc?=
 =?us-ascii?Q?tBGK+5alYTid/oUhM0JyGIVbg9yr7c3fZoxhL/VDWoUUH3x22/hU43ma4yU8?=
 =?us-ascii?Q?EAM7AIxEcvlsSRTCl3zaW05AZpSZu7U8i5NKJJrPvrjXllATkyeks07MY7KG?=
 =?us-ascii?Q?/TUjMSlc10fzmi4jJyQbE6IOc+ovc3g8aoNUiqlMF9JHVMIm68m3huxRGzXU?=
 =?us-ascii?Q?qXUi3Artm+a1u6bDJirCJaJb9B9Jissl1CGDdQA+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2826fa-80d2-4aab-c665-08dbc5d0d998
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:19.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmle29ZS+cZma3SCjzUjtISziZ+RX4XkQfUfm4r55QA19j2JYMF3SIIXLg2/oAau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Make arm_smmu_domain_add_master() not use the smmu_domain to detect the
s2cr configuration, instead pass it in as a parameter. It always returns
zero so make it return void.

This is done to make the next two patches able to re-use this code without
forcing the creation of a struct arm_smmu_domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc069..7f33363719f4ac 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1081,21 +1081,14 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
 	mutex_unlock(&smmu->stream_map_mutex);
 }
 
-static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master_cfg *cfg,
-				      struct iommu_fwspec *fwspec)
+static void arm_smmu_domain_add_master(struct arm_smmu_device *smmu,
+				       struct arm_smmu_master_cfg *cfg,
+				       enum arm_smmu_s2cr_type type, u8 cbndx,
+				       struct iommu_fwspec *fwspec)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
-	u8 cbndx = smmu_domain->cfg.cbndx;
-	enum arm_smmu_s2cr_type type;
 	int i, idx;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS)
-		type = S2CR_TYPE_BYPASS;
-	else
-		type = S2CR_TYPE_TRANS;
-
 	for_each_cfg_sme(cfg, fwspec, i, idx) {
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
@@ -1105,7 +1098,6 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 		s2cr[idx].cbndx = cbndx;
 		arm_smmu_write_s2cr(smmu, idx);
 	}
-	return 0;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1153,7 +1145,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
+	arm_smmu_domain_add_master(smmu, cfg,
+				   smmu_domain->stage ==
+						   ARM_SMMU_DOMAIN_BYPASS ?
+					   S2CR_TYPE_BYPASS :
+					   S2CR_TYPE_TRANS,
+				   smmu_domain->cfg.cbndx, fwspec);
 
 	/*
 	 * Setup an autosuspend delay to avoid bouncing runpm state.
-- 
2.42.0

