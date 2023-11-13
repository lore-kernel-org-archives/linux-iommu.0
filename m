Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B5225DA
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3i/u5j7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7w4K4SkZwxSbIhfUxpoe9oXu8isVggre5hmmTV9FWVtANiVDIh/5Qoz+mGSzrYmkoUSbdghn0auFQFl+K8TKGzXkj9h8dpuS8DCG2cjj+2ZS5DT/5jrTjxEF4+qsJnub+jef/ORvQhfVzimxxIUujVxhHpewkqHnx/Qtns/eVLLWWwMIWYKjOy6lD2N+QhPOTlr3HBO51bWd4mSdoDcs1e0hFSMuysG3XH2GB7Fd6Gj3/tuv2IDLJpb5f1hChJBLbXo0Ha+mm4kIVKuo2yoIwfpH0M0+/Rln2W8qB+EPEsV1Fh0lZQvRyJD+9Y8/Klb000lYAxJB3ffk+/sOYFPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jfjLgiQddbkGMxPnFEHgFgTjad/UVbGA26QDxIp3W8=;
 b=cagf9zJeboirD5IXT8Oxi5nXcheIlAClQs7qDhyam2foP7kse88MGGhYkihKsadaDToJsmW+bEWfkaCJ7DFTcCzSYIpur+1I1GuE0EQcn4i6/2Me59jbfYAEFyT8pFn86ZdPXUfxgaVOEV19u3el/ef8UUb7uCkvenbs+BBD+4jw/w2jc1FqL46F+6a3AjLFRB6i8zecXpiJSBk0Xx8P5+CIsbkNLR/WTxDNu2ks/0dXERWYqsHqw6X65w0/iX/W/0ytDTDfRGqncSCJgv8wx3bZb9hlYoydi79QyqPHx2W5UnWRrRotvHSSIIpYoru0FIfa4amnP79lSQZXHHU71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jfjLgiQddbkGMxPnFEHgFgTjad/UVbGA26QDxIp3W8=;
 b=i3i/u5j73p+JWOUbMijylVqDbR8hQ4OSf+bI7d5O1PLAml6suLZfsIWGX5OmNs98jcWOV6YunybhpDlJVf9RgdxH/wxnMrHqhetOJCKiE9d/uW7Bc1CH6gCFpz6iYfCm78i84Pw5OAlVVusWKibHxwPCo8NTBce3W1xtDBZyS7dS1Zo+k3mq81wHA6ppPj2cPrDLWj7HwUd3I6UkJqxEvQjn8wd2xWqv7jeZW5egOGEAmyYyEGDE0vn2Q58Wa5Y+MCkSHS4Az5PtSEAamt+68M8aCTopE0JaiO6B67OIwF8PeTl7n49atgNIuV8MxYG2nfkYwZbLGaw6FxBKgQRS2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 03/19] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Date: Mon, 13 Nov 2023 13:53:10 -0400
Message-ID: <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce20460-1857-42f0-24e9-08dbe4717112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eG7FxzM5HyF1Ao8AKfJkycvjF463DZwjl4NE3W/DKxhBHQJt+w33SuX5YZ9lcF4NaK0p/H96b2ykV26KxVhCV7GSsnNp/kcJMjq+ZPcmGX6tmYzC+cbTRJ/8b3c52VB4VAd1JbUAMBFyVtKpHXmOUqVm9Dl/2c1yl1A1VIfUDwCnvsxrHctx0o0xFS32M1vtNu3yxJDeT+HqUXhG3XAx7suz2G4RV0wsY3/+BLDSniUGRaWdSkPRsQNDM2MER1QJkILCW3BQWfl+8AL7dWnpfbqL571G3/MKrzT0d8sJpPtZfkwF3e8xAK7lKNbwoc7+dZe7B3714d61kEuAfI6ogra2091mV5wf++N5GR5wVtYTMgPek0T8QOs6qpIsUIA8ladJSjPCUqMYUhEcqLA2C1iHlzvf3cINsb+TMyyg56Jvfwz436/jBd7bPfdLTETL6lQvgEPWssnsndLhacxx6AHlm6hHKLPTiru0W12jyiFGA2qmdIRMSAZYPW03pf/kTg2HQ3/g0QweOEibpn+UukMjnwMlc4/1FoBtV00LQsgoHNbPxT01tQJ3pexOHJIsPypmlfSHaaPjaNqaJqFtMWMal4hFnr2gH7gFmnUDgEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8vawTEXTnPADDqVf2GaL++csuEjHYL5MV2adsCthAHr6s7HzEcdN4BeN4OVE?=
 =?us-ascii?Q?Fsc3/oUyy6jglOYAiHnIr9WcN6C5FnzbWzFsIb0CkgGL3jSmDxAh3G+lj3qx?=
 =?us-ascii?Q?MuOmzbykRh8VFNP49Vrg0YL/SMuJW/LRGlw1EfQqjqdHmkXbSEN25rVMAugk?=
 =?us-ascii?Q?HV2CICvJ/VTedGCZp6m0tynOUSMCwpO/1v5ngFI1Vv+NgTNFkDioyob7H1Qy?=
 =?us-ascii?Q?BMUjLyazc/itW6iLJ9a6yY70G78JavQzmjYNHsFemBFfu44Pgp8kgP4Sbcr7?=
 =?us-ascii?Q?iX/Vmo6UU3avNQ7B7l6oA18JlVqxW9bLaChKoBo++TmqCEUEXgN6f9ecONce?=
 =?us-ascii?Q?X8uri6w0Pr/UmFKSbpYpoHKmhbPu1pYSBjr/xIAFHHdpE/3LoKV5OSWFjCbr?=
 =?us-ascii?Q?6s3TUkKCIBttWMLbvVpmQ4K05qxVIzbCpfC4VBP1oeihmsR0pZzt7WUYjL1F?=
 =?us-ascii?Q?y/vD3MKunsGbjqHRhgidvDSwsMLIpEHit7lqjHqWdn2aaChdgarIDvyjRjNA?=
 =?us-ascii?Q?uF/2TeKRTg0QCLn7td3492WxTanVrb2phIOKUmTsge3lsSnVykehv/tZXwAQ?=
 =?us-ascii?Q?7ixwYf0MplZnVaKFkB5YFuxGIqEnrClgWNtpxuJFt+48hBwK5nw7Hg8JcLxA?=
 =?us-ascii?Q?WsSG9FbI3dguU3QEI6ZmZFet2y1ldL5E1tIPYTUF6lGPnlXOYfNAvPGxvCFz?=
 =?us-ascii?Q?RWV2/0cTI9hiCShUtjpBHgYRt7isS5Sxugd6Ta4TMC1U695kS3MvMzNgPyTv?=
 =?us-ascii?Q?yVV0l8Uexx+SSjxDG7ifAtr9DjkiTn0d/JzJzI0SGmcnxO9JbIZKqdHJG4Wh?=
 =?us-ascii?Q?tBbVBCpFjGmhEBmcmLJ7DXn7eqDVUJRvejj4mLfKPxjJR9TZaJbdjJWlmBjd?=
 =?us-ascii?Q?GnmgVuWfamXvqtrYHpHCYUkxTmVWtU1xwRqN8htOFCjgSzcfnBJbieKGPq7f?=
 =?us-ascii?Q?88WOtbVEyr4o+3duhGTQ45hjnuUfeRCoNpDoGnozCcvhKIVCZAwfMas4J71j?=
 =?us-ascii?Q?V26Z9ICfK/XAMPNQuPp8IA95XSJ+WGWdGef/6ixz/YxIH+IYExkY+U2c4dlF?=
 =?us-ascii?Q?A0Umc9rx0+2VsvXWySx8EdAqaBYQ1M9K6vrDM8jKDvcwG6gPbbXIciVnmA9O?=
 =?us-ascii?Q?hZO7QCsK1XNQGd7+/Sxoe/KOouLveAQuOLDDfiIk3Yrma7LURSbGgpKR3/4w?=
 =?us-ascii?Q?tHNi1W2cfS9Qv9d2F40IxJy7mR1bkPgp54PTt782JUzqfSLmqdurPedOKOPx?=
 =?us-ascii?Q?gQYcjGnjgp4DIFz/2Ud8PdfHrPSMNKdsT0L49NkWtOnZDTtmpDY8cj9WFyn9?=
 =?us-ascii?Q?YV2Fe1Lc/OE1ayeDZ37GHJrMiof+VwSPBC7hu0pTB3689fY5aIk2YEnTQc/r?=
 =?us-ascii?Q?n0BbIgBLp+NB7GLHp5MIXbXv5pKfEwuHU+ih9xGPIj+JyATili/gLWiiWuzY?=
 =?us-ascii?Q?J+IVwVKLyLPFbAwO91FtR8aWdlmTclc2c4RVkNFAz/jv5Lq8zhDjpPypscJ6?=
 =?us-ascii?Q?iJlUF3Cpy4SdI8s+2lBkoKRLmvcWxkCX1JSvpaCUVxu5awCD0y++ku0NaRzm?=
 =?us-ascii?Q?n+SLenvFnv3Q6qs59x4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce20460-1857-42f0-24e9-08dbe4717112
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:28.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnXXt4yKP2eo1P30Mlh8IGMpQhzGbMjkZ5Pd/EXEpaem/Mmjo237uAopdB+3TDtD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

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

