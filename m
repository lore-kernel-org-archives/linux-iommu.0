Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FAB225A6
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U1UvmgX6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/bHiIOXseuJfDAQ7M0sJxFhuD7Z1UN5PSGJNGRuwwTbU7kW8f/R6Qm+tzLwomVP6sJA428BHXPwJhMS2WYJ5hWk3ZWapcT1kbyGVt9uxcPT874zGKcPeuzG+BkoQdPMnESt9Uo6DDOTGuxAMcr1CdCoBvk0CgHyNyLiRczOxMU2a4PGI512563jcyZbfFgQ2f5XZUWOBEK2WudwICdepiEmDnGOxNL4jK0OxQyxQtesRhwI/xO7m+L+DDwymOuLLVml1OrbOpNNirdwFqLMv6/OM4zLhTCDxcpRWzLwSlhaz9l2IKBGDccd2RIH6YzzKvFc+c0H8ETMErb7okU4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK13GwktKs9VvNVuxxg5EuWjteVKUXDw5vsexCCe5UQ=;
 b=PAkbZ7RjSIAg5mBUyVq9+c8ghv3YYnq6RoDhHsE2Bl2MxpbIShf1w0st5s/RRtsOPLm0RCdNaf8knPplBKwtsjJKtPMLYOiYC91e2tFGP4Z0zjotQBRub5a6EdiGZJwv2AF55XtuMERzNcdWrqwhbx5SF+9CZGi2nV6GMSSo4o56lYEe2smtb4jZiJndD69OTLHSrwH0/JILl4wOjQexg+HfWxa7KDEVnFUqlB7IaMuGIique9EA/4mJ9fVUtQZLL1n8eXAXA5vZUsHbz5WtCV8ICPWBj2qvp3DXTb28h5U23Pr0dG1/gdTugH6Mmv+/Cf6dG1yWt2mnvdEhtHhByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK13GwktKs9VvNVuxxg5EuWjteVKUXDw5vsexCCe5UQ=;
 b=U1UvmgX6/vMPe3vYpjNenmnB8hAES3+73wvx8YUgzLqPKr2cg26r5PMxlbOL3uariDWBT6jC780UVjqPvIyZ54nHNTxMEfYf8LUBNEfx1Gok18W5e2bOCEpaGMb5B6jsBqXxPamhWjYayHjiAAivU9zYvUWRgB4ycaOWfrQvy16vNfsmu42Lt4jugl4plzXFE2a2pBoHSaqlVln6AQXH4nob6cAy49cGduMsyfrHX1VdcUBPygqrC72iLq5DM5rh4+N+FIC70Ah5T7qBeLs3BtYXyEMep8eU64yahRtIXFUiCXjFKBpdlyfyK/Mrov/m6N2DuwGo3uUbSMVONJpOWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:32 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 18/19] iommu/arm-smmu-v3: Pass arm_smmu_domain and arm_smmu_device to finalize
Date: Mon, 13 Nov 2023 13:53:25 -0400
Message-ID: <18-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0050.prod.exchangelabs.com
 (2603:10b6:208:25::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: e1db7a4d-739f-47e5-a265-08dbe471706d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JYvoQiJTDhLyQOtNmnIMP1fpvY24A1aX19V7pYZ/MjWfNENfnRL2o++Q5TtPWSLi3HueQdzFpGPQ0bDBgYwsd69jPo4jGRq7+8FpSYUjKlbiELgoRt2GxmiXrlatA+92oPbUrU3ucCkP/WYk1r0BfQUPtP/wV3EKzTyoKxtgjz9Ywd/+nz4Gy/7f+NmvHY27VjyZzykeck4dsq1fxwzNSbxQaA6L7sw/xYoI+iXsPcj50icEsbNUlV8xgkI1+Gp9mRN6pbNx0e7eSXlPEOBCjHP3zTy3LG4FpIPEy2VDivSmnQqKWyalWzN2q63f9qsdZf4e4G3aJsd8xFB54iuMR8yB6qJg4TKe4YQogTy85PAsn+qKavCFFrudcPqNT2hyYOOaO8Giy8cAotNz8+YAca5Wu4hiueRZU4rCvrDm6F+Ra7j2ejgdhcmBi/YiI5NTQVhSLXhQz6TQ29zbSdidpI9juap2fFUqTsz45umbHPNBKz7jEtY18Zc0MKJl1ZRsngrJ5sLgw9hbdDU7Thk/1fbG5/XXGpauTu9P+QyEWr5BpHsz95juw/BxWsimuGp+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+rF2XEv6MjcnK/bvgtKeGuZjiVjE0ZDPd4h3SWYQca8I2OV/l0XmOql2G/oS?=
 =?us-ascii?Q?Et0CXVIf1aPTY7q9Iyaixb3iLcrPWIYBAPiP7PQehDR7E7GLOs0cc6UYYdef?=
 =?us-ascii?Q?fWWq6XPQ6R9qk29M+GykhrgHhKovmy3gn0yOC6teLpJNpjM4IRzS63zHOfxf?=
 =?us-ascii?Q?xNWuiVtS1SjDuT6GN0caFZBynrlHITQ8f0gOTtjsaw06rc4SrekjzwKsD7dI?=
 =?us-ascii?Q?vWJ2H6yVa3lIm40t7YfOPt6KjRCqjdHfjpNqeZVe17YWVIw4QX0S5otA9vR7?=
 =?us-ascii?Q?/Ma1I9+J9dSgLy/ceER3By0iptIfRC48oebnsVmTm60aw1ueAehcmqgAOpcd?=
 =?us-ascii?Q?EP9mMqOrrtflKeBZQbwDiOWXRkRW8GTByH5dy/hbe6Vy+1C3NNM/ykdfgPtu?=
 =?us-ascii?Q?BhJXVapqGeZrPm5dB82fKHX0bqCdoFkYOc2UTE8/CEqKQTMX1IMcJVmz3VCr?=
 =?us-ascii?Q?3SHmIIRktV3AedFFXJLv/Ahc7ox2oWCyztmca9Z/9h6r1iTclEmC31dXXuIQ?=
 =?us-ascii?Q?7gqceyeuE9VkQxVA2gmlo4WQG/3/cPTuHCE8efCe7w+aGzr88yrwqJyJhNn8?=
 =?us-ascii?Q?2ThIMJi0pojtWhPOxQxgfHgXswt0YRc6Rep/HIOH8QC14sLDI+ChGLrzFB1b?=
 =?us-ascii?Q?pB26kiiBitv+xB1GCarnUfxzlyrVWlvh2tlcj5LHtf5ZLTxmXDoE1KPzpxEq?=
 =?us-ascii?Q?xz8gi9l8SIzGUZXfrkJLjpgw17twHOhQEn7i/FpO9LqnW4i7JS/3mbZtEkdA?=
 =?us-ascii?Q?oDs0SYkUUf1/clVYqwdmCbhEK/tqAHJhFnPh8heh80JKixcoMX3z6KnNZE7T?=
 =?us-ascii?Q?EpSh6yjvsqPdD9+IhCX1/WZpVKov8mcBIbSnl6vREHPU5pTamstHL5fA7Fgr?=
 =?us-ascii?Q?pD9YR7pIaz/I2ZMu7qtQhrdURj2x8ulDo1XU5xOJOeZKTIWiDi0U3gg4tobj?=
 =?us-ascii?Q?gf3mpAp6hq8zOezEKkDkcpmj9h+AM5sqpQxzdtJjKOLzwgLPTuyrF3+ssTeF?=
 =?us-ascii?Q?jsI9aF/I45wWCXq28zuc2ZcLyapOiYrNKTuo2YaqSee+xkxcfZSvS2+QMPJF?=
 =?us-ascii?Q?PjjE6Lq/16lkeX+attPElYlK/YFVZ2dJFFsDguXRzgm6lULnF5Gwf3yUCKfi?=
 =?us-ascii?Q?2aHzKlVONVkZZlJgH1CSLY43r/gFlRzFgMVSSRY3Vta2/mAcS8GFzds0wJVm?=
 =?us-ascii?Q?T54vsVzrsAZGPQM9SP0tPeSh4b0DbjKK3Iesk+NHOTFtqA9nIm+IYi6kiy+z?=
 =?us-ascii?Q?+ox/rA9uP0fNUubDmM6234g7JxCuuwpHVaUwXWMuCnLUPJty3Lp89bJQ5Xsp?=
 =?us-ascii?Q?gDvMdp9ZiHtP8p0mLZwmbsyYn/K258NpQ4AdLgZzJXWXdBDMeaT+ZKEf7x1w?=
 =?us-ascii?Q?mt3oY27YJBvjfwWHOr/cCmFCFeObJp0YFHHcWf0rN6ZiRTH+mBNPQABcN8qR?=
 =?us-ascii?Q?iIet+LyCBjZteBW2zRBxDDYjFUusUNWY5XtDjYq3afQMLF0xYSO3YqAFtoUo?=
 =?us-ascii?Q?8fCWG3HhbulGDN75hVphZHDkVTLRpZV2Z07shSd0U476zryP2wSryzsJkBJE?=
 =?us-ascii?Q?ngMLHhc1OaLszKQOFjQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1db7a4d-739f-47e5-a265-08dbe471706d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOB2DYIE+XzNXADd7RMLTBHSmhnL9hDmQyRGdVyIghlBFy7CdoS21cwMuGfisaXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Instead of putting container_of() casts in the internals, use the proper
type in this call chain. This makes it easier to check that the two global
static domains are not leaking into call chains they should not.

Passing the smmu avoids the only caller from having to set it and unset it
in the error path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 331568e086c70a..50c26792391b56 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -87,6 +87,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 };
 
 static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
+static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_device *smmu);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -2216,12 +2218,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
+				       struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2253,11 +2255,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
-static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
+				       struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 
 	/* Reserve VMID 0 for stage-2 bypass STEs */
@@ -2270,17 +2272,17 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_device *smmu)
 {
 	int ret;
 	unsigned long ias, oas;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
-	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct io_pgtable_cfg *);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
+				 struct arm_smmu_domain *smmu_domain,
+				 struct io_pgtable_cfg *pgtbl_cfg);
 
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
@@ -2319,17 +2321,18 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (!pgtbl_ops)
 		return -ENOMEM;
 
-	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
-	domain->geometry.force_aperture = true;
+	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
+	smmu_domain->domain.geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu, smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
 	}
 
 	smmu_domain->pgtbl_ops = pgtbl_ops;
+	smmu_domain->smmu = smmu;
 	return 0;
 }
 
@@ -2520,10 +2523,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
-		if (ret)
-			smmu_domain->smmu = NULL;
+		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
 	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
 
-- 
2.42.0

