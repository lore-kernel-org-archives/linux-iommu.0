Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E26803
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAXNDQ1U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6M0ZCm4hmAN7PSvX4MBWOoU4cbKNBykhZ4sE70jdBZQyRmOwK60ItRxT6Y2enYzniy6hl3ZADckH4gaiPcFOiTPnjeoO4aUpleYLmtuZo4c7bHnfT6uLowvgfrx27FAgdpt0aRWWARInVRIdtk0rAI+5BGcYmpsQnjVCsL/9YqXGgF4bl62/DioSexQhxM4Foh22TJjdcWmfCcEh8Ue1/F9HUDNzwuuPjNlhJh5bmJRxvHVRcX/ENj56flniIUprMNTmREvIbeTqui/gmb07iSzALI+JDpCggn9NWB90xQ/AuxLqF4m/V54UHaykWGFnIPWtoU1G4221XiZgt9QaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaknFvtt8XwLhwGa7F01IzPrR2SMierLH8q9M1ejBkQ=;
 b=VG2hXsCDZLoZqlZ8lOU187CdcZ0lRonWKAMndlbgYGvi+XNZZDgKwdnfkWLFHCxh3nnlJ4VckdAgnMkYMBlQo/jb5+No3Ul7MCGgPXhYGMq9fgwEhpxW9qZFwvvIRHKpNps8VkJ+w6Fg5XpkuVSl51tWfPFbNqq9d1Saz8LOD246BfhM0iifafGoTtpbyfJEugWmWRDK/qkiyvV9/O4t/+6V4psV8c4yDpoRJMqNgvIWgJ+YW2G9J1IqhCHJ/Oa6JaqTY+1IZq6COYFTHmhbzPMNEsiaHMNuH5Z3PEly8XUqr2EgiC9yr7y8liJQRqYxS11ix37mesKRp5EsVl9Gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaknFvtt8XwLhwGa7F01IzPrR2SMierLH8q9M1ejBkQ=;
 b=TAXNDQ1U1bCa4tbvlu0GfhARss48j448CfBLWra+W+/ny0q37s4jsK15SC0ZEoGCA/3DRHLd+YO4s6Txjcw6i2Xe/6cl8OKvbVJCxt+qNM4I7K5D+bBzcUYR1h7q7EW00VGcfKEexgpGSvh0SXrkXJ6ZeCyTpA+t+LMT0TMtavbwJ20YIsLTH7fynQnh596PIYMn7hv9wb5KiXwoWHoIc9IWvZ8GSoKOmKeSkHVXrhEQ3svO8ruK2JHt9diRk6ivp+zrS1qny8O/ud0yRj13g3BppYnD9zv+X3TAmIqETif0KJLvtQ1W9c0E7sQNYKThIpxk3qG4i/mmk8vv1T29aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 08/19] iommu/arm-smmu-v3: Build the whole STE in arm_smmu_make_s2_domain_ste()
Date: Tue, 10 Oct 2023 21:33:14 -0300
Message-ID: <8-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:208:23c::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa64959-131f-4dab-784a-08dbc9f1aef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cww+ax7lnu1ms9XMbXXgAXtAWo4vSv0/Bu8D4dUVRjCabxqz1rthZ2q3Vm/OYrYTbWeXQBoG1DP93kWEcH19dz4m0FH+vvDJDxr8jxF0Ev1zOnmOtravdMgUfA63V+X6WzqQy6j+1SAPfPyWUcjroctjoS9eLQf7F1B8Z4X87UOtvYZebBEd8dB0rnufDlsQfPYBQk06xT5SHoG3oVEc+hoLPQM0Cw1hUz3Xz67V84EMTCin3CSFeW2/XO+RWr8EZGLgMFCKDbfXCH5eEld0uqZvJT8HzFMxDdAXjrfLJ8/cYhpCk3eKfgNTAgWoBs1jb0Z+oe/2CecIOdBRpopBPArEqfke7ZVdP1e8jhKH/XMC/SHa+hUiiDHEiJmI2SCs4GbFVWwsoAowoqdB4+fzmuMhmKdaMkKm+T8cCibncet4xjcmJWmOdcPn1QB+50hsGWDUnKebpQ9T6hrh2rBAuGLBg3oPICtjsE+1MGgrmUnphwCno4kuv4YgmWQntxk1JMV8S7aBaUkUt/43S4YfvctiM6Bt/REf9McZJFcjjnpticQGul//GKXRuB2VRSpd2WnUnipcll6vXt9KDEHysZkPRumBP/bLaP7AqKPR3PE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HAxnO/wBCESij3u70euWK/lb3V2kPH0yw+4KPEyvzLSIIP/ZNMZtY+rvj/oM?=
 =?us-ascii?Q?JoAzbZWA5CLyLADW4SySpbXPhHp36IwNad1Y41JNqu7tsXiHGOpgIwFgIUnz?=
 =?us-ascii?Q?99r6u+ekjK2/qMHvwS2IHVyNBphrd4Ev65X13w84FfGmn4F3jhOYgRZaXnkP?=
 =?us-ascii?Q?SI/80Gj5shDzthycBqZbz9oZpIn+O9oNqo1Wj/NMdsfRpgtjgJMIzdTihUrN?=
 =?us-ascii?Q?6uChMNXW+y4xUYeCIOvQVTndsRBDKqUPg1sipiPc6ELdqhxql+nn3x0V6v5o?=
 =?us-ascii?Q?Sm4btvBYVgip0pY+qXgJkMF0684bOB616ckX9dnnpUqXg9vl/c4TmIFTGZE/?=
 =?us-ascii?Q?2IIqclwAou9kIZwVas+f8SDNAdUJIsu43/xGyKri2HhyTwF1FFz0PvBK/eqS?=
 =?us-ascii?Q?1VQpBtduh1OMaf0EJy2qIZj/c644dPAcvlCpOk4gHQxwdG93JsClKtZtamfj?=
 =?us-ascii?Q?2tfKFYRuo6LlANBeZ1WbP218c9I9RyxZFea2xW5Vvz0sBNt9KiQA77Z04isG?=
 =?us-ascii?Q?GOhCR+lMAjnUWHNrES/oBit/ox/Uo7Vbh8CfsfwW//n4+sln7M0aBUePdt4L?=
 =?us-ascii?Q?Dio5pcK+FbVGhBa/VqAAXnv8ybV2lZOJIrZjinxNlPa0cSxXDDnlH0oNduKf?=
 =?us-ascii?Q?v2quzhtZeKR6Wowr80iqwkPqvjqBFRZHqLFkH9smJEJhpe5chF1Ps6q3ZyrU?=
 =?us-ascii?Q?mwycU/bLqL5hsv6JEAxwpeB5VNtsXYrrThcCAlORvL3bsmsVcrMdYrMT7fcG?=
 =?us-ascii?Q?pFjdEkAezvCvbP/86/ugnoUInIv7BC55R1C0ek1+6p1wamrMCsfUe/5MX7J5?=
 =?us-ascii?Q?bu/03qCfn3VGhuOeLs5k9H5BridCtlUDBt/gKOrYW4WlZEAK7gDFhUyYhFY4?=
 =?us-ascii?Q?WRcXNKpo/xUQWhIiGYzujSr/BW36WNnxX84pWg5A/uTJp7X7MSziHqxVhmVE?=
 =?us-ascii?Q?5T+DMKT+DmGGxEclHzU5o8K8cZcMaiFyb5WM3+BSXACK/T53uBrzArlQTWja?=
 =?us-ascii?Q?GQvqola6o6PSVvhP1SqWZOd5mVlT5MZ8fF4MHw119RLu51RsKmqaBrPWJgAA?=
 =?us-ascii?Q?/OATnHEbpWnoB27J3OLzWIdgQDGxV15lXor/t/yzGj7ULjX2NDImeQv2Ipo+?=
 =?us-ascii?Q?4R5riaaf1DBcMI43p6vXSvnt4avdXlj1XK/KU9IdeIOEOprh4/OhbKHNlaeV?=
 =?us-ascii?Q?SWAfFKcvPZhVUyxBMBtAIlE3ZEULai2y/PlsU+jF+IXMsIfLxwmdvXL6Z8ZC?=
 =?us-ascii?Q?5Ips4INNy9AaUJ8v8wDQqPq0fOiqAjHkqJfbuZUhe86OXPVYRYlaXxV3HAYz?=
 =?us-ascii?Q?Aobpbm1As+lL+G+UX1MmMCO0ygMCaP25MlKmqRs9LQVqOZg+YSDCd6atJF5Y?=
 =?us-ascii?Q?105fNuc6eILNQxYIswtnuL+WcalVR/5rrvASvb+R+DIOMLJGTxsoBGkI2dke?=
 =?us-ascii?Q?fjEFvHw1UbPvut5YjMWrkBJhAZc7hWEmtnalWcROAO02ECsKOKXrrttgHESp?=
 =?us-ascii?Q?9rtHghVC/12M5oZ9VfGAt9vprcgKrrTSEbag8NZPKwvynvoVTB+o2pX24KbP?=
 =?us-ascii?Q?KSZvNtVQmct9rq1fxZrAfEgGj5AI9iT8iPMkH+fe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa64959-131f-4dab-784a-08dbc9f1aef2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pt9QuI6Iu1cD3CnlKnZMnNaroUy/Ju0JVrJc0qcYUyQZhV/AdXAjFkuRvC7EkvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Half the code was living in arm_smmu_domain_finalise_s2(), just move it
here and take the values directly from the pgtbl_ops instead of storing
copies.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 ++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 00d960756823e3..2c06d3e3abe2b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1474,6 +1474,11 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 					struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
+	const struct io_pgtable_cfg *pgtbl_cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
+	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr =
+		&pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
+	u64 vtcr_val;
 
 	memset(target, 0, sizeof(*target));
 
@@ -1485,9 +1490,16 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		FIELD_PREP(STRTAB_STE_1_EATS,
 			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
 
+	vtcr_val = FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
+		   FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
+		   FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, vtcr->irgn) |
+		   FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, vtcr->orgn) |
+		   FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
+		   FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
+		   FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
 	target->data[2] = cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
-		FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
+		FIELD_PREP(STRTAB_STE_2_VTCR, vtcr_val) |
 		STRTAB_STE_2_S2AA64 |
 #ifdef __BIG_ENDIAN
 		STRTAB_STE_2_S2ENDI |
@@ -1495,7 +1507,8 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		STRTAB_STE_2_S2PTW |
 		STRTAB_STE_2_S2R);
 
-	target->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
+				      STRTAB_STE_3_S2TTB_MASK);
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
@@ -2252,7 +2265,6 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	int vmid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
 	/* Reserve VMID 0 for stage-2 bypass STEs */
 	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
@@ -2260,16 +2272,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	if (vmid < 0)
 		return vmid;
 
-	vtcr = &pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
 	cfg->vmid	= (u16)vmid;
-	cfg->vttbr	= pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
-	cfg->vtcr	= FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
-			  FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
-			  FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, vtcr->irgn) |
-			  FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, vtcr->orgn) |
-			  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
-			  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
-			  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 27ddf1acd12cea..1be0c1151c50c3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -609,8 +609,6 @@ struct arm_smmu_ctx_desc_cfg {
 
 struct arm_smmu_s2_cfg {
 	u16				vmid;
-	u64				vttbr;
-	u64				vtcr;
 };
 
 struct arm_smmu_strtab_cfg {
-- 
2.42.0

