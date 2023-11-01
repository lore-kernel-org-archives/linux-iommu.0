Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CC1BDDE
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CwVLAovW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpIttk+C4FoCNWBPGsJdJebRDZFh/+lcWylsFhLHGx5YHObRoXPtEYLR58pM8ZRncPZ1dLM3J24VSboQGtucB9SE0tjLSrInN4sriC0Cli2FT8Sh7A2fkII6c6Fm/9zW0O1y0jhoXw7mrbB9FZyvGf7G6mWK6pIYOty8DqPDgicRfu8owRS7+Z+UrOdyIMEWxZSan+gwskz/djRRoRUmchCFPN2XDV2H/UpVRiz44UBVNtOqIyCEZWkOtYgE0wCbwCkABD+XN76oYnm3AJdpA+KoKig1ntQCoo18ntxFWh9ZSNM0McBCIsQF+qvu79feLl5/cPcU01DKzz79sKsyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65NYd3HCXKH0KM4+CqaRxz3OgMK5ow93sI2dKYbHvXE=;
 b=W9u1U7RCfqM499d0GyJyzU8UUmgV9cCkanZhMM+8EkBUQrWAgfFtD8j495nYt7jZUfs08PmipU/5+HjiRywc01SUdss+cWrUahwMKPIQB7nTK+iiyasSfPaN2oSvbQJF4a34uaJxuqOJX7W5m2CSFTlYe0TdJ//z+o6OYevRN1ZgAc7dKs5tWs0AA4pm5GU0yT0jxxIsAT3ppNOudowBl0XeLYHRp+/vvKgemre8I8QPYPXTln3n9XshuWNa+xL4jVUhFwqu4DeELqIYMbw7LLyvnnOumvBaA7Eyn/vKLxJ9oJm4W2eL5Mg6CVmyFULV/4Tqv/qQh1dgvk6GcVjUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65NYd3HCXKH0KM4+CqaRxz3OgMK5ow93sI2dKYbHvXE=;
 b=CwVLAovWndPvLdCOiys4ULt5FNiZavUW1VPZMxLCEwfbX+Y55IsFN3Z1qgp65v6kbpPG+YykLzovtXLsIXzyxBSsW7CJuWJ/zP8MtcXfNCj8Dctql/A2qQSF2MTCnT5lcSDQHcpwa2sMnaMV7BBi+hh8AXbZqU62N+PZ9XKx1q5Z4HzcMzsXCFstTld38gDMqoUEMzDKM7So+jssBItWXUshROIkhGedcjv52PfEANTTeob/0uY1SP8m39fTaiGBlMejpKzGP3PPuVHb28ycSfh3dX0tBGZ2gMQZPRItGCf90h7shj63ttPj/t/k6rAFo9lG/IygAiU42Lyt3gSiMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 08/27] iommu/arm-smmu-v3: Move allocation of the cdtable into arm_smmu_get_cd_ptr()
Date: Wed,  1 Nov 2023 20:36:26 -0300
Message-ID: <8-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0d0f35-84e0-452a-6e11-08dbdb33697a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gGLrm4S25mvmfYPss3dvaP3q7yS5v8k3lFkL20VFBwKQDd/84Jc1RrVDMg5uwbSAjkAP0Cx9FSsx30YatzlJxDXobSeVAPvmO/3NIbhI8Xe8jsRy6UgzvDanwt7V+Y2egtPh7Vj+pKVi++rRM57FHya00NskKnsZqa+ZkusLuJ+8/AExWPspbsv8YtmGofHoloL+WpFQEM7xEQAgI86ZjxikJ2mk8gqKLqC1ver7jBx3V3rDa4GUL50Y1TOSvrrWrIi2EHwY14O5wO3z5/Z66WrQaYsInZm43stZJkPsiah5ElpFTqDs0sM0GbvBgd2SKmcUc4RXODRx2RZL/lxEfyAu/+jWrRwD89OAaRxqC4wZ9ubBhRZXQUvMK6+yl7ZEeu/JNDjZHsyRC8Y4olX1X6vhQ7Mz8JaCmxPKg1XGqyY/L6My9vsxCF5dTMf/y3YUCSuRQzryd9pnHpE/hX6BRsS3YHz8CuCug6caPSbqr1zDwIpIelV1F4Sxo0hzQBNKCZxVHKhlGAzGYahK8SwThE5MAZWdJmjsMZ8HzvYjP0RJrqFKDKJB8YIhwRwiAcfGMYFiPeAdGfTyEu5DkZ/2yvT5J0KYFIjWBG8Rxwcn3SYdN9n0Eca/jrCmgh30rNM8tkOfUYzC4ul9WjBw65leFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8QbF/J/x+b/lkw9kpGQWw15rRqihadfrimVwLBQJ0ixCm3sgc2+jlKQhEuQ?=
 =?us-ascii?Q?MwHagnYMZAFiRaRNg8NkNzDglqDzwkcfAU6SLdOrD4HadM7/g08mkzFYNvc9?=
 =?us-ascii?Q?M/pM/qTsa/h1oRQvNx4/7Z3Su4x2etffoGbKnTaM/B+TznygzmY6wRx4Nd7A?=
 =?us-ascii?Q?Z3gZb6wW8YcqFM4VklP5pmZIwaRvD44x1kzq9woxDT/hiCySjBbVCXZFDKed?=
 =?us-ascii?Q?UPa1cF8+C20+Occqd6kFUBtPOGe859GEWd8Zk/klmix9GHma7YP1XSuqApcH?=
 =?us-ascii?Q?t5CN+Ib9SRo37cFaAdw8c0FWgRR86bXA5a3QGwA+AV6kEko1wDy9NYIV2SiK?=
 =?us-ascii?Q?VT+arTEnEkmYNsv4FRJeCYChfUNaJZCrlGk3EbKfdErTdER03unUQmyOq3vr?=
 =?us-ascii?Q?qLLHeJjE+g6y0VMRtwIVtkxuelmuz05PA5EvzjUfBU8qv7xesIU0X+CCQwrH?=
 =?us-ascii?Q?4vWvVrOwCWu/EjHuFECjzuaqaYMuDkJqnL+mv3h5X7XEdn/DJ3XNE+WScyYM?=
 =?us-ascii?Q?TYk4z5e5K5WbK3asabR7MkSV7NJ8L72PDsp94XqiZ3ASjKBa88cu8prhwJJP?=
 =?us-ascii?Q?c8R9rfJiaopZI/Wy4tULHeIGRu78RDSq2Ek2dMJjr3VLfDQQ7AWG6TLZIXkK?=
 =?us-ascii?Q?PbDaabYC9nQSqNC2Y25E6/+Iz9bnUy1GonE0muza5T41/MgDshceDdi0UJZp?=
 =?us-ascii?Q?tbop0XGTOZPZRYCREPsyeK118WruK6b5pztuttZ6S0oPs0K9n+88dPsrguQH?=
 =?us-ascii?Q?eGhF0tHShGP5vy0dtZqC2e+PQj1/L2SUPNr6cLXxJPoJI3xyuYU2cd20pDRe?=
 =?us-ascii?Q?viJKsdqbqOffyaaImiHoqbuN7AiHF1I3rzKCFaiaqBpQKizFhPTHoVTVMbcV?=
 =?us-ascii?Q?Vyv0u+b19DK7+E8RHTkAyA2i59XLnW307sAqQ3x26wzMVapfvH2sTqYp2n1k?=
 =?us-ascii?Q?d/PpLb3dddwOYmI8ggXSk1qNYRW1o5TwP/0XlCLbty9KkEfMJAgYR0krVQ8+?=
 =?us-ascii?Q?JhDl7/466yhEian2O+xOlGQK+41cBBRI7EQTyBi0o3hQOc/BKCGAPGG4SMyR?=
 =?us-ascii?Q?sPCva0+NGy7rgYxwwUhGV6tzXO3riH1pPMFrAmIRcI9eDZm8qUjhfXYGeM57?=
 =?us-ascii?Q?Xh5JE0OXcgimfG3kGqC1+zLLwgj99s/grK3uMUlkKX2AOaWvlluYV2Vl38CR?=
 =?us-ascii?Q?HOSBuLC1KI+aYjF5zGVon78dDFhJr97ODXmw0TY7ppb/DXhzlcxfO1YLDqy0?=
 =?us-ascii?Q?OOlU0Xwhgtc16Ng1XQtp/qngXYCkFfpY3yH8Dm1Kd6baAlxIdXX1bxqwrZS8?=
 =?us-ascii?Q?NbHzgqrOZPgYU5LqNZmSsIqlHEMJNpTQNKv1fOqpEnU4vrHArFm64/7faQwK?=
 =?us-ascii?Q?OG4HQtkvJVYSIsZQqUKbXWsU2Prmk3o0CJ9fY1U8uy59+A3N1gByl4gUKQn3?=
 =?us-ascii?Q?SN6JBeXCjBqdDrspz0SfYqyRgd+Y8EQbA18yh9F75gggytXw/XXT7UQLZAFh?=
 =?us-ascii?Q?na+OOEj+lo8KKX9Uc/V5h9g/2tvYzq0zvM9ND0AaS2dRqd/+ft3fwLSuKRNz?=
 =?us-ascii?Q?DlU8Yp9Advk1r8xZCqRfu3nvLtLl1boxVXPt69Uv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0d0f35-84e0-452a-6e11-08dbdb33697a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz3a5kjcCGZCrRmcL+40Qxqp3nXjKsLaMIMjkB4SFBlJe9814ApF04pC8h52+MQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

No reason to force callers to do two steps. Make arm_smmu_get_cd_ptr()
able to return an entry in all cases except OOM.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 46d0a45fb0f525..a95e16a83f0196 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -89,6 +89,7 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu);
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -1127,6 +1128,11 @@ struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
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
@@ -2639,12 +2645,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

