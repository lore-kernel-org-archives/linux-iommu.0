Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2210.outbound.protection.outlook.com [52.100.165.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CD18E02
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BflAmznn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8WQ1jJLyQOJRelu3m87k8WQU/fg7RG7ot7q6cGOHSE6yZ6DFZNnnfx3eum5VIf2p3tn+qLZvf9Agmu83dxrnfRv7SiIZPqmSoPpcBB+424Fs+4pqGYhbBVn5gLs8ZJpxNuO66GSpYMFmqf/+pb99ce0fIjuwrB1Y+n/6HllydvPctjJUyJATXIEL/KORqdZyneA82wXfOXGyyq5vRTuiqkgNQgr/tVyPIPMxy2RavetbhV8XY96HETHiG69P0P9F5YVqyhlZ0k+JimGRuVg6bqw6GTa4aM31JaBUplZgZGtU7FBADHeR1bDz/1rou5NTjAA3zWKj37fibh4QXoO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lNk4iqOv2mARitj3FXvG8UHwvMptqK28sqM1/D/Hg4=;
 b=eRQWZ3DjaL8/mrXRLMu/pJyGzpfmdMtoPzVpMIRgW9SHUh4+W5M3ETivQqGgEk6BpeP1fGdeNL9RkUqpMTSVmhfLFbZ5CgvvSv366lh6FDLILsm7vfbN2rcqf3MoGCT1iAyft5pDPZ0nDIyUS74cg7QgayweNm/jE1OlPwzS0aWlD4ldFknTn4zunOrOvpBtWYqAtCgFIuopIaq+yCTP+PWHHgXmcwoBgDicj0gIItuyVMlwB05NP95PeHoEnAasI7LSzsRX5GQbTlolw+AUhfTWIVAGYgvubKKlWyb57DEIy6dMjGBThzmwu3G7P5e8cDXTiq9RQlmlfxRtClll3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lNk4iqOv2mARitj3FXvG8UHwvMptqK28sqM1/D/Hg4=;
 b=BflAmznnNyzD8xyKOTAu89CRp6v/WzmI/1kEoYw3k1yWgGC4e6OBEvuz7eHJXVRYqUNgTPj+7TWdTidK784yQ/v4CqcMkVS6vz+fZZV8ZJz9dFvpKbXf5wcMM7LnodSIGcwLaPBKM8Q+QqYT1O6sjO+Q1ynj98Wv2cMJLa+/ZCUBXu9M/hUNjHk1sVjt+T8w9oI1vB3ZVwhr/JurC3MUNHRELefsQoVXILK31JkAseccOENFAhHle04xRBKGNaSiPTTiUc+g8Pwqx8KzLHLUoc7pkBVH6Q2E40uWmIhswjQ2KpwqrTpLEc3m6sfZV2mlNdWvjYMli3ZExDZaB1E1pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 14:00:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 14:00:30 +0000
Date: Fri, 13 Oct 2023 11:00:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <20231013140028.GA352534@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <1-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <20231013103734.GA13594@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013103734.GA13594@willie-the-truck>
X-ClientProxiedBy: MN2PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:208:237::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea2dfef-53a4-4332-d258-08dbcbf4c27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJdKWNLyw+7WbnQuSIPtnTg2gcHEcK1frZ1uUT269U/dm1Ts1hIZqO9bB99m?=
 =?us-ascii?Q?Ba783YXbOpYRgwyAWk0yhWefdhsPtOI1dpMZUVY6KIJNbT/A49scr2O0Zd2x?=
 =?us-ascii?Q?EFHsMA/RoKa/hFAURm4my7WYLr4LaKjwRG8NByJIfCFmt21fKcNgFXifjuJA?=
 =?us-ascii?Q?jRS0vwXftX9jPPKyYQZX5VMO08RG9YSGcpa69kX5DYsDBJCYfv4Zr/LAR9Tg?=
 =?us-ascii?Q?uqjR1K6VNUMDlfBB08VSU1HQA6bomXw/S94AQjtTEqtiL72+nXbKX8ddhTlz?=
 =?us-ascii?Q?s2N/UwSeBq3a9Kbh+Gk3sWcTKISznZ8OYGnpsv0P3bTgjPDdY7SdlwqtmfT4?=
 =?us-ascii?Q?Jn4FAvdpcg0KtEfkjx1JCd0Qwov/LjvgDbCq8kbkEEMJl00Nas0KuByGDYak?=
 =?us-ascii?Q?nTjWqT/fm00q2aFWrU07Sp2hAqowj5adFgjz3gNeGJFw7WSXl3VO7vpJ6l5P?=
 =?us-ascii?Q?4e8stlpgRdS9VQaHkDI5Xt8/CHH5v9k//enWiMtB7mGo5cEe+7N6KAzTyPKz?=
 =?us-ascii?Q?+pVhfYfj8/lTs59fE8kvnu5rxVWxAO8K2JuNVylyUgjcTgOvCqUkaShnucLB?=
 =?us-ascii?Q?55u/Xf0FeUYQWjWqGtkAzM1SkotnGgH9KNhKceTagFyikZw2N0EjQ9S/qK/q?=
 =?us-ascii?Q?LAB8/5Yg0TROgJOpH5SOefdzeKJCvsXwVsMu7UT/D6pW36LVGdAM5FnDLTJz?=
 =?us-ascii?Q?rediVuoPC3Fdr2kxMxFnzdL1UQNS3znpMUSXPrVIm5i9gn0k4B49/RC2PjZl?=
 =?us-ascii?Q?vRGhtI65TKUwut/ookTdsIb+mtghNM1JTXeE0Ko66WJ6h2yJWW66sVAbvr6E?=
 =?us-ascii?Q?IBF7amdoDwjnHLk61spItbBUCiG4sk/+0nQ7U6xW1YwahU1k0Y+Hl11KqHkn?=
 =?us-ascii?Q?QgVupcGuFRScTgNJZExSsRylMlFAqr7mzIBAReQEkhdhWKM2IF5AROMqVxMZ?=
 =?us-ascii?Q?l3BGs3Gd9v+HfB8XD1DWko9dRzIclsw5G2cSmnE8Ra67NWabpdt+IulQ+HMs?=
 =?us-ascii?Q?bCzdlMIbyj8RWj2ry5XpkcCUGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(33656002)(478600001)(5660300002)(38100700002)(6486002)(66556008)(54906003)(66946007)(66476007)(36756003)(41300700001)(8936002)(4326008)(8676002)(6916009)(316002)(6512007)(26005)(2616005)(2906002)(107886003)(1076003)(83380400001)(6506007)(86362001)(27376004)(473944003);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrbU3VsCmVjYWRdvcMBRl8/aYPlhiJJVzUe9EduJSsivuKz8+oGlB/2ML+Md?=
 =?us-ascii?Q?SZF/25whCD7CdSdfY4azfmxJYsJ/oVK5hXr5svPrK70ExbqEfK8ObCkR6Tr6?=
 =?us-ascii?Q?ILPXOfk8va1EfSx6wqG2p0051XmR2RAj5ZfSXXOT1Cm9ZhCpCWE6p4x1Fr83?=
 =?us-ascii?Q?nGYgQRWdJr6+na7pEvLu2SNaM4h833Ry56iKgGZE6IAOPlZSAlXoaDKpuCC5?=
 =?us-ascii?Q?8lvShpQLWNSFnXUmoCBtbq4KOqGx+f66eYHbVuc6xUCrOsTelJ4QzeO8BaXu?=
 =?us-ascii?Q?B1lQkIzqEDogml/IKM2F6sJTXgp9kKgMJscKTSQTIPiO2gIyz5kienUoTO7M?=
 =?us-ascii?Q?q4ZsQHnNzdsJpjtAQF+HNRCOOD8Tmbolsm+XmdD/Q/jqUoP/CxuYSxK2TWm/?=
 =?us-ascii?Q?0i41FRVdjUj1N23Z0slfbH+OWtYECqcbUurEO0vYy8QDBPJ4eIlTfd8co8+O?=
 =?us-ascii?Q?fdyZcm75o4bSHfOX8+MhPqMLvPpcx0Mn3jsUW5xjP8ic8HlFYrd3L629aNyI?=
 =?us-ascii?Q?NS1AqTXW7bu4rZo7AoYYBswHtoanUtYafYDHoLZAC4XK+TQtIrGcMRwb5KPe?=
 =?us-ascii?Q?vCVp7UcIpvE4Iax7hHNTF+J/qKJSlXWi3bPGRdOzf/0ik3wdISFyWk6+A+zq?=
 =?us-ascii?Q?o4Kticnby6iDsb+x4fgdIeD2htZfYX9zaJPTvJ6CLEEGxeFydI57BvGEmodx?=
 =?us-ascii?Q?gZRslGpb4UJCsISwUJvSRD+nATLeyUcL4Qe1bzjxyF3wtAhmLIGBp2gMggLv?=
 =?us-ascii?Q?SdF4b/cKimcLr0I4Y7s//rj+CZO9TOhuHcJp8X2/MDvorX2qCiRXbkiTk5bq?=
 =?us-ascii?Q?lcjwA+4cIqU2Ocey4lVTyyBzcck87ZASAVxGYLnBuPSLRcdU3lgabn1d8Jmh?=
 =?us-ascii?Q?T9WAAJimeNUOXAWeplgKXjlMP0cg5Zynk7mWaLdixzY6XwQYe7YMI378UQjV?=
 =?us-ascii?Q?5wnFsiUrBCy55T1fFMQvdIZUhfzN0uzY6JiMR0BGJ7oq6uDiGyAlvTh3vmsl?=
 =?us-ascii?Q?SOMtumQXKazva3RNZvZtMFGl5aM7KMEiqDyaTkIMAQuQmxkAqeqlfJrYLgiH?=
 =?us-ascii?Q?Bxckmi/5yl9jkEtJKA7hlFtaHHelN4M4FiMa9//hiEkMIEjnGdyfycCbIaLy?=
 =?us-ascii?Q?oqpPOM44pLwtc5BodqY9XrR6pHcWEfsBqXzWhFe+jnNaSCtVY6clrbdnO1qu?=
 =?us-ascii?Q?99SW6CGX34fFfDOa0vmkIwokFdt67rqxqgAuOtJ+CrcvREmMZfX8TzB7PfIm?=
 =?us-ascii?Q?NdvtgPuGVy3vmVGwR9ZXq2N4S4vkGhPJf/lRmp4ZwindlWchT8K4TesHmOtC?=
 =?us-ascii?Q?snkRhW0myeBsnGH1T0HOaSmcIMC3SEJDkddqcnt64mIumMorIhkc3H8+mSEb?=
 =?us-ascii?Q?T+7bF+jAzLZTld1cW4SlUuM9MWEkHu1nBpB3lUqAbQj8CuUA2LBf5m+dPz+G?=
 =?us-ascii?Q?RUt7xKQWVcD45nlLO5r9CCxbFh/EMZrYQfxG0CGBSpmQH/D1z9eRPfFVBRL6?=
 =?us-ascii?Q?Jv+kCtDcJAH4gzXr+5aBvYVS4WGt0f9+Arl78xzsRNsvqXUVY7XfyJ8Qe+Wl?=
 =?us-ascii?Q?+S1ZyfY3L6C1o5Mcc1I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea2dfef-53a4-4332-d258-08dbcbf4c27d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:00:30.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyv1nFhdqeVqlpNul7YmYWGU2ubfd3ghSSwwuCbbiXgWcD881xpLL6R7ghyH7epb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

On Fri, Oct 13, 2023 at 11:37:35AM +0100, Will Deacon wrote:

> > -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> > +static struct arm_smmu_ste *
> > +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> >  {
> > -	__le64 *step;
> >  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> >  
> >  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> > -		struct arm_smmu_strtab_l1_desc *l1_desc;
> >  		int idx;
> >  
> >  		/* Two-level walk */
> >  		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> > -		l1_desc = &cfg->l1_desc[idx];
> > -		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
> > -		step = &l1_desc->l2ptr[idx];
> > +		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
> >  	} else {
> >  		/* Simple linear lookup */
> > -		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
> > +		return (struct arm_smmu_ste *)&cfg
> > +			       ->strtab[sid * STRTAB_STE_DWORDS];
> 
> Why not change the type of 'struct arm_smmu_strtab_cfg::strtab' at the same
> time?

It doesn't always point at a STE.

arm_smmu_init_strtab_2lvl() sets strtab to:

	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
				     GFP_KERNEL);
	cfg->strtab = strtab;

And arm_smmu_init_strtab_linear() sets strtab to:

	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
				     GFP_KERNEL);
	cfg->strtab = strtab;

I can add this patch if you like immediately after:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d5ba85034c1386..bdb559878615b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1559,7 +1559,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return 0;
 
 	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
-	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];
+	strtab = &cfg->strtab.l1_desc[sid >> STRTAB_SPLIT];
 
 	desc->span = STRTAB_SPLIT + 1;
 	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
@@ -2347,8 +2347,7 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
 	} else {
 		/* Simple linear lookup */
-		return (struct arm_smmu_ste *)&cfg
-			       ->strtab[sid * STRTAB_STE_DWORDS];
+		return &cfg->strtab.linear[sid * STRTAB_STE_DWORDS];
 	}
 }
 
@@ -3421,17 +3420,15 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 {
 	unsigned int i;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	void *strtab = smmu->strtab_cfg.strtab;
 
 	cfg->l1_desc = devm_kcalloc(smmu->dev, cfg->num_l1_ents,
 				    sizeof(*cfg->l1_desc), GFP_KERNEL);
 	if (!cfg->l1_desc)
 		return -ENOMEM;
 
-	for (i = 0; i < cfg->num_l1_ents; ++i) {
-		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-		strtab += STRTAB_L1_DESC_DWORDS << 3;
-	}
+	for (i = 0; i < cfg->num_l1_ents; ++i)
+		arm_smmu_write_strtab_l1_desc(
+			&smmu->strtab_cfg.strtab.l1_desc[i], &cfg->l1_desc[i]);
 
 	return 0;
 }
@@ -3463,7 +3460,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 			l1size);
 		return -ENOMEM;
 	}
-	cfg->strtab = strtab;
+	cfg->strtab.l1_desc = strtab;
 
 	/* Configure strtab_base_cfg for 2 levels */
 	reg  = FIELD_PREP(STRTAB_BASE_CFG_FMT, STRTAB_BASE_CFG_FMT_2LVL);
@@ -3490,7 +3487,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 			size);
 		return -ENOMEM;
 	}
-	cfg->strtab = strtab;
+	cfg->strtab.linear = strtab;
 	cfg->num_l1_ents = 1 << smmu->sid_bits;
 
 	/* Configure strtab_base_cfg for a linear table covering all SIDs */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 74f6f9e28c6e84..6d75adb1a72b4f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -620,7 +620,10 @@ struct arm_smmu_s2_cfg {
 };
 
 struct arm_smmu_strtab_cfg {
-	__le64				*strtab;
+	union {
+		struct arm_smmu_ste *linear;
+		__le64 *l1_desc;
+	} strtab;
 	dma_addr_t			strtab_dma;
 	struct arm_smmu_strtab_l1_desc	*l1_desc;
 	unsigned int			num_l1_ents;
