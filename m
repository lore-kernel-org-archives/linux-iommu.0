Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5280D
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YaVQq8mV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhrhNGCwALHuc2562n+Ffk5JJEm4ZqkO/rT8bYu6TC737NTLAKa5igmtJYMY8mvO4v0oTbBrcTQWgdHpZJk17GCJPP37wbmYrNiZ/zz06btXgn0YjOrudUt0AsQ4nFzxto4r5dTbMSDTQ2xaGEpbH0xSLvvlDBkjjnObff7xWgn0lkDNy/X4iVn9Juu6ThlpZJ+nqlw5Ayk7dLbnDb1crvDHvd8hzgNqlJwASlLdeO3yb9FXXLzKwri5BjfEYqfeV4dmmkMpH/bm4J6vlIpi0o4RS+udRKfxBSF+uEm5MJcouOoCKSKk0PEopRSo8IpI9lfm1eNdiHpBGXZzXYkeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqXG+k7WyZkYXBzLYd1S77ABlEvO92CIdnjTsgUweg8=;
 b=Z8k06RaDyUwyzDbcNZQxZqHh+EpJzYP9AlLClNRrDBac83PynOwKyznWsik2+IOU3yMOouO7GxauJtTIdXzbHYnA/pSiouVNjA/dda332XNdgh69z6uEdOYpbxObUS3Ux7/oJ7zd/jLpyFzzyJH+YZRRSP/4fVol5yyLN5YfTyaMV/60he8zAnvCdhx165JkmZ8blgYh/tn9L1cRQF/4/Md6rFfPYCYpq4OB4DvFXdS/nCtE+E01NkIFdo6fVWVU6OjThnPLksFZM9/KQJwzvtSoBoL0gvEknSbkMkHbwGmjItvPZUqHNRoQXiEhvdAG6LW2cOXFRhQdtHHmSg0Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqXG+k7WyZkYXBzLYd1S77ABlEvO92CIdnjTsgUweg8=;
 b=YaVQq8mV8cAJ2sMx67uTnHGYWzaDRdy/mEwUNN056i+reHRN/5IkrYuBdVL0wpgl7jeFrSXL5lxf5as1B/35f/obDlPiuZtj1jQYXvhihvIRm3oPMN4gmVJHzSRaxWvz/9PJVkTcsYqcCZ5Nx7YgCGX0zspj4cVUqgfx+eHpOWlJjCmgKhXTvm91wPVCRRISe6sTc/Cceyt0zEFL/CTd5E6cf9AaAiSfVgA2aE2qmRP0W6Pqhq66cLI92y59DTQWqR9I4gN7cTDEDHDnB7y+c2TbXff6lrWQLfcmRlaLBKA4xVqrKPS5M3lQpKO0ZDjD1KQdBPirg4uBOd95M4hMQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:28 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 18/19] iommu/arm-smmu-v3: Pass arm_smmu_domain and arm_smmu_device to finalize
Date: Tue, 10 Oct 2023 21:33:24 -0300
Message-ID: <18-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8567ba54-60cc-462a-27f5-08dbc9f1af03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OjDQQoyEiYhXBoODiRiNhBmc+O4M+gfnhe+74asP9/TozZTEdTQp0CB4GFMrlxHoTZLumfF+ogRYyov1azAJrnjfOclPZ8h9vxkxl/WGOqs7TsEETwPLx4Z9oaujNLaD6udaZwsBNzMTDZmBipqlC2zRG/zTsdT7ws5HvBb5pNbNATs8HkYU09vzHVfpPwRGu1yZamADluD90tTXuQnn9oqlsq8pK5MtZKSlEE5zUWS75pAF01XmMVueDBX6FNjtsoM4aknn0gCTCfAeRwnVlBA1MKGQZLMzO2ghEwH0rrRU0uiadc/2fLhXPTGSWPo1Rs9V6OhWnUHVab3MS0lQ32OKNZ65ajYUsV8nFOxDXYielAFzmscc2EHFsIZf8dY/OXARLO92xp380tWaBkOC15Jz2q8sTEZE2AtidjyxeI5Hfq++tCOQlnDjfabyj47LawJC+LQ83wC0ibz5mfoZyFhxbVBIx2mqZSfdCjavBekeD8Lm7fWeBP9N8hI8o+YBrP6qwWuY1t/VtQPlbWjHVUEf+V7fK4ct7PdnC32FMPfLreMPQvWsP+YMny5Z39EV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FyheEhuuxuSWbib6xP7Y09Mtag8zcnM46MtpAocEHdU3BwbqsKJZcDQsVe0?=
 =?us-ascii?Q?f9rOR+KS8aDshs7kYChXkjVZp8kGJIEtiQSHJE9c7U+icdEQhBvNaJI7lad7?=
 =?us-ascii?Q?os8m3VnOwg1eis8+GOG2JRXfNwaSYZiMFxVXR4OBx2SOzBD6DreIMeeeVOwz?=
 =?us-ascii?Q?OXqvK+TotsYoU96otNe04UYGGM/QG0gUSr9F9nIBedcOnywoX+az+djObSl2?=
 =?us-ascii?Q?w7U3NrD6uLcGHB/B5i6y/oLtBePv8FYjpQboKPyld+d66asuojmhvFEibo0b?=
 =?us-ascii?Q?MT4tsVbPG/ve6lTS+BSZVGtnzHqQmlwK5m8VEwsukZ86OkahKe/gLA1ksusE?=
 =?us-ascii?Q?Q1S9dP9DVFVS8PzPxpfvjAm1FweH6DiaQwN5Cf2FYWAm7oAtHN6+KOoDg67C?=
 =?us-ascii?Q?OySErJUmfwm7P2Ws+VA3LIR2BU8ODzSIJF6mo+v4hJvruUPbQkICCY8jNLJ/?=
 =?us-ascii?Q?Bm3G6d7HscarpjHu9MjHTLBZP4A17UPLWy8EnSvl4ubRe7vLk8+8zdXl9hyJ?=
 =?us-ascii?Q?zWh4NEYpxyc+Nq7ulDH2laTjo27b+s6HdtVzU741mYSqhZwsoGbaym2UBK+s?=
 =?us-ascii?Q?zpUDTw5nCXB4+yPUW65wBpGjwIQ933YMwvCnpGPhGMfYLBhcXnZDcIJdfdEH?=
 =?us-ascii?Q?6yJpg7M5DWXC/xjp7PmwzztOEmEPa1DXwJ2apIjxiKytT79In6RYp3IcBo+a?=
 =?us-ascii?Q?41/R2E3Nq0OWWJmd2qHIrIPJpae9ob68ewt/gS86ziSiZkdG7JTmjWHqJ+qT?=
 =?us-ascii?Q?q0uIz5o61GHkoeCtyp7Vi9ZtVKzK4zFRUe3ny+C9euui8X29sEycxUMVZXWg?=
 =?us-ascii?Q?QtORROo/toYqRFDqssoJYiztAdN7SycPoqn+8cH2uRiHlPvrLpPsjApZkEBj?=
 =?us-ascii?Q?6Aa94y9i6i9KRlaaWg0lSBES3SkR6PuZEO9HTD2Kb3BsmrYSN/IN98FvRjqn?=
 =?us-ascii?Q?YgYQtzF3qlLIbTnQfuN7ilsqkqm+TQF16hZ0pl/6rz2PPZKkh+SA5z2Z7Y/L?=
 =?us-ascii?Q?bNtTfm/KkOEEtIFMeXeG7l37JhftDLIGfEbmp+hyaYzLxJ8Zl2csWAaY4qKD?=
 =?us-ascii?Q?kOwy38n6PiFqqTZkLtIWPjVS3SCPP4/VivNHJggMzStRVvuyHk2JRaSeTme/?=
 =?us-ascii?Q?aKcEPaGgrAk7TXlT835hNOXIMgGynVm54kXwR9gjWfYUKyFFoRkitXA47xNm?=
 =?us-ascii?Q?t0fiJQEm8Kq9XC9d9JrCTLAc476q/73GVEqjjt/bwJyWrkskVyBGd4ThRlzz?=
 =?us-ascii?Q?IP2kJ5jvF1MrXRDOKjg3tf0RaAhoPJSZmIPto0TgCql8aXVUR5R/M3pnPngm?=
 =?us-ascii?Q?pncISMLhww6OIG7+QhmebGip7R6x/vRB4vwrPUr20OFseVbV16oiBDYoWLLM?=
 =?us-ascii?Q?idGS5qSomXuJLktLaMpszk/nLwWdoGm9truot+DieKOUA1+D9O3dcK7c0wiE?=
 =?us-ascii?Q?1BWa1O3VRHsq9AOe+td0U5CYeZCAk0aNPcL3bHG41pPz0T804iTo1aUFtAQt?=
 =?us-ascii?Q?VJmAhT80QQjFnktm9LBH6BtTxkqe2ghklYEZm3E+/WV6QV0eog6T1fJJxxDN?=
 =?us-ascii?Q?utkNh+Bu7fhHEok2QdzP4InWb9K1NVRcZAxbNJ30?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8567ba54-60cc-462a-27f5-08dbc9f1af03
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UBnSgGkORPufh/iFrpMeerRXY3lpSe3+Xb746rJkRnCrXMrTBstIeNCVnuYHLFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Instead of putting container_of() casts in the internals, use the proper
type in this call chain. This makes it easier to check that the two global
static domains are not leaking into call chains they should not.

Passing the smmu avoids the only caller from having to set it and unset it
in the error path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 ++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 95bb6cbe2fdb08..6a4b6d23590e8f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -87,6 +87,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 };
 
 static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
+static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_device *smmu);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -2191,12 +2193,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
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
 
@@ -2228,11 +2230,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
@@ -2245,17 +2247,17 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
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
+	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
+				 struct arm_smmu_domain *,
 				 struct io_pgtable_cfg *);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
@@ -2294,17 +2296,18 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
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
 
@@ -2495,10 +2498,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

