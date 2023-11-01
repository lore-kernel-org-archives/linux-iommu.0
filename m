Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6471C2A1
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSsmb2r3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+LkRdxjSQJyW3Sn+AHPZy/YSAt2NElNx6Pj2vfdc/sbigcKPL1t5bjm1tEFuOgyC5RRnkSbZyBAd8xpJJCDCIN8Ig3roGj9KLCDBfA4zwM1DRP3VWPyJQ3ukb0Dcydtk/uguutiygOx3jzUSxM/BPOwGSHOyAqtPee/q324qEe3CR9i7IJbdmL+Cnt4rEqA8wpvVrpGuQyAivKrR2QZk7VRrraGlupdnvonlnww7rbeQ6r9pUVoGvC8yL/EesXgnKCme49fo+tQNS7a6/tZB22RVPcQaKG9tjjuarpusvx/Ha5k0Tf81odzgbYYRQnyQdq9L5tLOB+gUM7+s82UGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5MLnzAZpw18jF+ZotGpvk/4g44rq0LyVvJ9d2VpTdE=;
 b=Cr6hbu2i0Rw23hCJlhUbbb+UL5tDqS7FNAwOzdmJDikjJvTJACl/qiHBSPjXwodMaM0b8Hp16EmqrBbb2/gHvsx9gEUfas3mad4UKVpygtTeaS3dEhluDznzf+X0pRqCAcHrMl6l6iYfOuwOPRVyEcjs1fn/Plot28BgN3AgUoxNCwEn3xU8jqh69h3znPfZQu4fet2CDvLF+NmkelJsFTETXVeW1yid0ycBdQiaKw5O1KWrq8C+9Az5iCYUSgt/HZkPW2ApA+1MHlGPvmrhOfSa3l8pW2Qzz06xTf93etcYK5l+Ne/BGPZ+OtEpKvW0jOkZaU9v7NCHxZRTxMchFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5MLnzAZpw18jF+ZotGpvk/4g44rq0LyVvJ9d2VpTdE=;
 b=kSsmb2r3mpIrtnm0osxgmXLG6GOExsfnnE9vNQiind5SrZ/AgkYkJdhob6rLTNf/9eIYdr+KTrd9gbJjyOdSLduBnk/iMxuib18HtoMvAOud0fMDxFVDYyiNcgXrtjBj3qjX6Gke0iFQx8pLkXLXkieUuYtXzoSQr4/+9MbOFEx4/MylnKtlEpg+PH1/AC4Tc9CqhFmrJAfXTauQAYA7z406NGKwQGEKNpe+PQLIORruRPpKyHWmEVtbQpDZH03kJ0WqSSylxuQOVwV/n3sx/0BrR1UlrlyOnGfkib+Ucob8K9W2N2y5aC0sxJNpTL5d1awRU41nA+6lE3HS+KIjgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 12/27] iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()
Date: Wed,  1 Nov 2023 20:36:30 -0300
Message-ID: <12-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 69374bf7-ba4f-44f6-7fac-08dbdb3369ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G3Qd4Om03HNyo/HLOmZYeQ1K0gGUvsYAADvLsCWO9YtGUEKXbKp/DaIGI/+76ZY5ajX8N9wPrd3dHErP1Brf8FoSh1qxJkSJis+TxEYn5hCms60sbRBAjz00/3dfhuwjB4GiXBEQW4x79f1on1paJb+0MYewliFhmK5XSXZia6iSojEr+VgXEuhlmj/MUkHsOLz2o9JgmvsjWoe5xB93Dy3k7rWyFAd0LLt7Shq1DHRr9TC/p7Rvu3A7QvH2Gi4wd6BSvdPbehAjhY4L6CSFsrPgjlIcskHQqOIhXf/vdCDrAw1tLAOLhNz16NnMSdvOYeYeY8Od4dJg6azQqOxb61bzloWrRZrhsSZM4weffaBY8YS0+p/DV8fLz272ZGBoP+v9WXjjyZMzsgo+HHBcyz3GDcvG/3GXg1WUa8lBfGZFkIGSxQDpgdLFpRNlFMcEWa94I9Tgoifxl9pY3GqK4vCfdmlakQuSTlDcXY6BTrtmkIyK6Gioja80+z9aVLdf4BO3r6xz+e3atgxPsP9Us9VlpPdwgLN+GWDRH9/hEFfp1pBZxQ7mUttr7QImUP/9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8QaSo2q93dRvw4tgeiPDuZl/VzSbLlU444aVGYaYDmkCWidAICxgOGE+VUeS?=
 =?us-ascii?Q?L2kwT5IZgVE7r6qiuLTMDHyG4+QOYm995zldsWf/Vg0UunZiG+52+XFKzC33?=
 =?us-ascii?Q?aPxHFHtihqW5QuX1aPDlZthMG5590/1e7qCa5jC0rpV2Pyyxa96O/zXno4Og?=
 =?us-ascii?Q?mOkZuIrqOHaGOjJ1DtdJkPZ39JNPY2q1N8EVBqslseL4GHimT87ngo/hQivD?=
 =?us-ascii?Q?dGYtQDBTaX8f4ovc0/GY60Ra/IoT/xBUol5NL9EfJFKa6Pmj60jTOAIne2XW?=
 =?us-ascii?Q?RwppCDhlLnxDicR+JYoT1EBjPbgKEDZV+7/0bYT5QzZJ5La5JHX0oGaIGZmH?=
 =?us-ascii?Q?aIZeVcCztj0livIJfCLoqnONmFD/SIS4MvFhWY98Vaz9jYPT73Sc6+45C1/z?=
 =?us-ascii?Q?vjzDinO0SL8eJ1G+o24iueGjd8/ZdeAuEZRRe9KQRNupSdkc1F+yOfxGhckQ?=
 =?us-ascii?Q?3JUVZZ3zGr2U+53q7LGBIhHzBN01X6KREf5l5K4ic4aEU3DhjliaL0AP40WI?=
 =?us-ascii?Q?TKlluQDTEJtivABTLYvVtu7u9XlEA/dRi3L1wkvVsFRYM6j1Q+gOJI4PA0Zy?=
 =?us-ascii?Q?mkB+5VJlUPRInfhsXQ4EZ7Rd+24pHak4YDBiWZulgQiAncyuWY13V38nZ51+?=
 =?us-ascii?Q?buGZs9r/g6yk01/MCawFGrinAccfF0WXt5EEvo+CknVsOxRHby6mhzuhE7Fg?=
 =?us-ascii?Q?G/qOMIxtkMWwk5rDAqrv3Mw7+U4lK8fbtKSpIUugj0FrEJ8X6d5KN3VSQgxp?=
 =?us-ascii?Q?mHPEmGIIDSMqHsNaUosQwYoSeWgeE/xllcdeinB7BTM20K0Ev/t+BCs493xD?=
 =?us-ascii?Q?p+kG9NG2jgspavKwTALioukp/A8dn/bvmziMWBY88oynzol3+ZroACNb26Mh?=
 =?us-ascii?Q?fzsOUAeZii2aI43BDzq8ndyCr6T/K41n9+Z3Fa/087XnncJ1I7sgPCeYctsG?=
 =?us-ascii?Q?mUMBV8Ocns9k0Zrv6dN+BZq/3HhdpDroX0coQ6Gm2YEjDbWZoPS7nNQkv9H0?=
 =?us-ascii?Q?73ikhEH+pt1R+ZNMAEXuMevKaXlSyutxrev7ScCTf744STMtuQJuWIIcitzU?=
 =?us-ascii?Q?980ySs8snxUfNFqcVC1L82ROFe7xmWWnAnQY+yWZbpOmkHKRcMsWuNj/gmMP?=
 =?us-ascii?Q?SU5Ep69ljeTaaJsLLFTSPFC2n7BlSz0DkcTVH44fSbx6E3EtLxC6elwKy/yp?=
 =?us-ascii?Q?wFSqQuzfHQsuafxYJr/OjKA5tkRirdI62W3+8C4uGN49Eq66bNcFA2g5CHO1?=
 =?us-ascii?Q?OLuRaVIz3bmEsKF9OwxuwZl4homqXN/byPQT+/611oqoq5yJ65foxYDZ+PnC?=
 =?us-ascii?Q?lv6m6m2e8FOnSzp6AI877GKlxlDnTeLqcRVv4pFn/OSeuJs6m7eeIuv3exsG?=
 =?us-ascii?Q?XbUeE/T+OPufUSYcCgl/NmGoZKWh39iWIinXQEl2BS+ivAAeKNCEzbJpMUR5?=
 =?us-ascii?Q?ASSHtq0bovlFoLaahGLEk3EC7TvsGR/8CxfdH+Rfq/BO8E7GZ9v61iORwprs?=
 =?us-ascii?Q?d1HKHeC3XaadH8PkE+gGdpfmVripwqYrocmhoKOTzfnIfstgoCuEc8azZimJ?=
 =?us-ascii?Q?NWDJjrYmfRB4aSqOh8mA9KFOl5b8tXqit7h6TW8D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69374bf7-ba4f-44f6-7fac-08dbdb3369ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztkUMZkM0xn09BhrtcvaqCOVfkL1afvRO5YvOf7GdtsP35hhI/bElLaMIgtelPqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

Half the code was living in arm_smmu_domain_finalise_s1(), just move it
here and take the values directly from the pgtbl_ops instead of storing
copies.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 ++++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e165859d0d0e51..c62c677dca1d9a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1204,15 +1204,25 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
+	const struct io_pgtable_cfg *pgtbl_cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
+	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
+		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
-		cd->tcr |
+		FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
+		FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
+		CTXDESC_CD_0_TCR_EPD1 |
 #ifdef __BIG_ENDIAN
 		CTXDESC_CD_0_ENDI |
 #endif
 		CTXDESC_CD_0_V |
+		FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
 		CTXDESC_CD_0_AA64 |
 		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
 		CTXDESC_CD_0_R |
@@ -1220,9 +1230,9 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 		CTXDESC_CD_0_ASET |
 		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
 		);
-
-	target->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
-	target->data[3] = cpu_to_le64(cd->mair);
+	target->data[1] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
+				      CTXDESC_CD_1_TTB0_MASK);
+	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.mair);
 }
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
@@ -2241,13 +2251,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
-				       struct arm_smmu_domain *smmu_domain,
-				       struct io_pgtable_cfg *pgtbl_cfg)
+				       struct arm_smmu_domain *smmu_domain)
 {
 	int ret;
 	u32 asid;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
-	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
 	refcount_set(&cd->refs, 1);
 
@@ -2255,31 +2263,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	if (ret)
-		goto out_unlock;
-
 	cd->asid	= (u16)asid;
-	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
-	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
-			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
-			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
-
-	mutex_unlock(&arm_smmu_asid_lock);
-	return 0;
-
-out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
-				       struct arm_smmu_domain *smmu_domain,
-				       struct io_pgtable_cfg *pgtbl_cfg)
+				       struct arm_smmu_domain *smmu_domain)
 {
 	int vmid;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2303,8 +2293,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
-				 struct arm_smmu_domain *smmu_domain,
-				 struct io_pgtable_cfg *pgtbl_cfg);
+				 struct arm_smmu_domain *smmu_domain);
 
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
@@ -2347,7 +2336,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	smmu_domain->domain.geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu, smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu, smmu_domain);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1c756803b7f963..b7a65e37c51e9e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -587,9 +587,6 @@ struct arm_smmu_strtab_l1_desc {
 
 struct arm_smmu_ctx_desc {
 	u16				asid;
-	u64				ttbr;
-	u64				tcr;
-	u64				mair;
 
 	refcount_t			refs;
 	struct mm_struct		*mm;
-- 
2.42.0

