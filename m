Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680A80D
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zc5FiWes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=islR07DKAc8dfe7nG/WwDm6H6EGPMgJUGzrOdDM3WeFV8ME0KuIc4iyzFWeUE4u6+h0EnFZOa8ZKKBE1xCcsm8b84KwicA+UN157LGjwFhylN2qUdEB8Joz3y/49571gN/uG8qzopGVcbb5wptABtf49qKLtCMyQtLnpDcwOWiaxw+15UWPUK7v2K9szln0bxWZRGGOFzLfr9w+0bflUWoHcPYRerTwwijEt1EHe+OmX94zTl499/XqgJhG21PUoUAh8JbZ5H2hd8pflGvNm3vYZAbLSwEAWjsvtGf/Fgy6dIUbIIRIHFIzHANRklNnTVJOih1ML5pfq6Kl8e6uvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jfjLgiQddbkGMxPnFEHgFgTjad/UVbGA26QDxIp3W8=;
 b=eMg8JC/Fs19RdcU7Z0sagrcY+gyw4F38kduzejc7hOQ1HKTOFfr+ubW1HEgDHamFa1YbqIUmDoG+3QQHjyDszNoOkk68iEnVrjMI0UFvDzIKZog+mcA0obRY/QkvFzPJFs9TAoz/6/oBIuZoik76U5arZ/JHneX98579LxLFO/5B/1o2nEgsMHffxfnjF9Rg4JQZx6H39NcSV1gUP5bLbsK06NLVduaEfywRbu1FkviKGBTDlDJ/S1S2dP1AUz8J0KXlcsjkXc46SZ0w/XLl1los+UY3/TdhEpJFtBt2ODoFs1qeSTXmiaPkYcaLK4o3sKR0pKXsEwHp2H0wLOT4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jfjLgiQddbkGMxPnFEHgFgTjad/UVbGA26QDxIp3W8=;
 b=Zc5FiWesiejL9kLhvFESDarX2gGee+wSN7UWISSQQ8SzPqANkajWWqxWgY4R1Ge6R1UZ3bwzstZBhXPqx/0pgquK/LN6s1ddsAILhX8FVglhyXwcjqRSEJ3SbLEAhgWNGe6Ny/Z2m/XE91iOzOSHgqHPIGUyYxXtONnB2bZPpAGoRaFOBdfaUe24i3yBXJYr7zsZCds8JY3Ia15fx9XNn9rUwcaWXpOLyZ5aa+6OKAxYOVvGahRLYi4RC97vfiCrMJBeQXKUCfzJxMABhUYa9h4Zc1dJRnQMOWOrZzplvTkDV2usWcDq/0ULqRFqUILsysSDy/L6ExICZehg70i8xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:32 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 03/19] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Date: Tue, 10 Oct 2023 21:33:09 -0300
Message-ID: <3-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0413.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: e1226df5-241c-4010-d1f4-08dbc9f1b01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L/rxMpah8KWY8ME6+G66r3TZxtJlyGxGVJLmsA1x/akuhqOe/MA76VwR8bhv8TXyT8MDV9I/D9EeNeKiu1hvNVMU/xQG3O9v3kwCCu3CMMaRqkJVVRGJuHoPBhuY01/2PP8p6BuzkDc6BV+MpFucIBWkz20XZtu4zwj+pBLp8bqAUFn4oJ2uUG6HDqrzzu56f8lrcOvgPZscWrBr3b0r9KJJMCNKqGxSeTwtN1CmmxWfME0pVhLyPTnRXfpNaLa+KJ5FTqi06Jv8sR9AUNlvfZ3MOvGWljNQyTvu+2H0SkBplrOmYg9N4rWV+HU4LnbDPP5+Wk2WyXpX/pKVRNdmhtKBV/TI06PAnjUZxtafGkeu8dkqG1ojijKfwep++o6DTSVEX3jYs8cKDK2+AEQhKdO46Dubik2oxsE+f3HbQqrMeXl63uOcdT4hxK01SVk985NfA8AVjL74Q+2VRY3yohuCUCjBjwKps86S1/G1vejmvv8UX0hjXGEJZAm8AVeKroOd4jgyas2lPvh+UPi0HNp4VusbBOKwuVC18jGuxgmk8lLD5Sf8RMfpkGdKJLVV8yXeDEoao/CgyqpN5WtL+zHjrzrAybFx4lUE8va0v8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYkowyP/KLGQJxLM3i78dxk4VMe2lQWVAUvnIp6PyjaYU6jPj7g0Cwz/BDUl?=
 =?us-ascii?Q?0wqWfuRBUr3aXLnu+ryVD0YnP7jQ8z1bV0t5jhm6FC+3JszoXx5csTCe81rv?=
 =?us-ascii?Q?JGVK84u7j+HxOmtclDmd8DGi15jJudBNu17UNM7vCML2mFCYLiOoRpJnvmrB?=
 =?us-ascii?Q?c8/4lPdNVA5Qa3qobXoXPJEs7xJdzeVP7fehKpQ4jYqHK3rEUfE3qVvhsy5J?=
 =?us-ascii?Q?SbOnpBoGrOo6ICpVvQoByNWhQjeYFEJPdpyGGteC81aPyrJguxe57Xu4brbx?=
 =?us-ascii?Q?QYhro3FTkx8cRiBjGP0Bxp+Iwle3iIW1SoS1s4weKxtTLmFE25Nvql/j0ixk?=
 =?us-ascii?Q?SnqaBzkXvZsG6rE/OIkiSSVOW4q0Sf0A3hwchkPhtZgVJQcjsIcnsH18ZVMk?=
 =?us-ascii?Q?yE92G9EYQnHJWAij4PxMkZ/7YwqLVZ45nAlkXnehRr2t3voEC4qKTyd3BZrW?=
 =?us-ascii?Q?sQ16tmBc+AhFlx4ripK78Dtd9gaobXNRtKAMTqCcBtAW8yujFBmM/2jnOx/Q?=
 =?us-ascii?Q?FLYGUc25bUh+gKdexKulV1bxyWH8k7wVUhduOVC4WrT3dfrK97UbKwJuPapw?=
 =?us-ascii?Q?gXPWTQqpU9+Cc/gwjhZ8T5pDqwH/PQF13dqV+QefIEMKh6QvFiCKltIz9jxw?=
 =?us-ascii?Q?f9EloeIKAAa8HFTGkdHHEvR2a7rlQJs1iddTcDFYg67wEznuF8byD68yrxIE?=
 =?us-ascii?Q?H3xJNXnv19G4i3je7M/s4+Pg/V+2UKg53cmyYLLGu4KXYgLqGmNIt7wgPHFB?=
 =?us-ascii?Q?SYRpoBJInDCeoVYZ4WzQS3xXCma/2YZSTpixft3YiT1qeldPrCg2SdbL1cch?=
 =?us-ascii?Q?S9ju7pJHE5f5nVIhKVY1oj8HrX5FNDIBPE5fVI9BNs8fR9wwtXuBx9alDZCu?=
 =?us-ascii?Q?QBN84RkNCF6Q4e8+U0ceFBj6CooCJwG7d6UzbRTSV3ahyh5qSdA+rVT4vxAr?=
 =?us-ascii?Q?OE66N+1GrKFY5VZ1hOAs2zBiSUWE92Yu0MQJr8o9WGcrtUtVWJ2rmW2KchYs?=
 =?us-ascii?Q?L2nzEMVSGKesTQ7IDHH9oqGHs8HFDOhRyKEmTFF7isnzLLh8CUPNJefHOxVt?=
 =?us-ascii?Q?CCNVQhbC+noW6ZviBCngG7mWEcrpA+zX8sbECbVhnbWpjWZFPpvamMrXa12g?=
 =?us-ascii?Q?5cqkkkYoMap+51UzjHKKbSXITuZic9M+cOCVrMOiiWrUt33GIuhC3KIfOmQY?=
 =?us-ascii?Q?oIh+ZoRWuWXERZO9PH1icPY1S5q2KT+xk0fDT/IuC9eoF9QS+kvD0US4QiIB?=
 =?us-ascii?Q?SWnCkcxOJ8tGd8OWAPlQulewYj0z45/Uk+ECOzHEZz39vUts2qggb54fa5Mw?=
 =?us-ascii?Q?jVVSanaydmrn/WIWxbcQvNKaUjcQ73Z4sA8LHDrrVg9kvecgnvceWsqTNvck?=
 =?us-ascii?Q?xYP7SGTLNIaDJ9dlWgLskMCZ8Opy8EkpCxomkU9TlurqowzBwMZifkx67tQr?=
 =?us-ascii?Q?aySDCi0sXwyEjLM74DkAtFWWmfK9qxCPMPxx39vQFyKzQVwaoBR+0Y0azOXd?=
 =?us-ascii?Q?ElJZinjf/owEMuUvEHiUlMl/lksoV9hK6Vl0tg18zVKolJvXgSgwJ0rEPvuZ?=
 =?us-ascii?Q?XKDtGmr8MkiNXWH64VQImnNRIZBy++52b9+pP4Xr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1226df5-241c-4010-d1f4-08dbc9f1b01e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:28.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2VF3seq/G7td0PT2sYN5NkD0rmNisY8TLFD/rXPwbtHGZcBDl4g+0yxxc8Dmt2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Currently this is exactly the same as ARM_SMMU_DOMAIN_S2, so just remove
it. The ongoing work to add nesting support through iommufd will do
something a little different.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9117e769a965e1..bf7218adbc2822 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1286,7 +1286,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			cd_table = &master->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
 			s2_cfg = &smmu_domain->s2_cfg;
 			break;
 		default:
@@ -2167,7 +2166,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
-	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
 		ias = smmu->ias;
 		oas = smmu->oas;
@@ -2735,7 +2733,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	if (smmu_domain->smmu)
 		ret = -EPERM;
 	else
-		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
+		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
 	mutex_unlock(&smmu_domain->init_mutex);
 
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 03f9e526cbd92f..27ddf1acd12cea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -715,7 +715,6 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
-	ARM_SMMU_DOMAIN_NESTED,
 	ARM_SMMU_DOMAIN_BYPASS,
 };
 
-- 
2.42.0

