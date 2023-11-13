Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE3225DB
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pjp4APJl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apq1fZpyYwyxkbhCV/wPCmEEIsqom7/ly3whRiKiuH8wxDyRpo5jGy6n9rZpxZc5pL0httcsz1fPi0qefD3TEOqMYoAjTlCvSY+CpyCmYx3ZmvMe+ddvMGaazWCHlRfxcgaJapQuwEd0RXm10RwAm2Uo5Di+2eWQo8NncX6O9113jbJ8jk6sbr7jdkDmNAQjgSyZQP0oLl47G6ITmWn9aOFI0JQB3Oi5jLkxZvtCnigVPf4w1fOdyxrE66BXZAzXVmM445faCFyZ8H1uJc+RqqtPlblOM/thPzPiKxz9tg/ZKo8TzTibINuu2fgWkS+eyjMVMkKrk3v8Vjn91enXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGQZ9TMf+mGq1oB43wsmPd91JFOBNphecT2cQecvK6o=;
 b=Rm77UM8O0GBx8K09nx/s+PRV4TyJo71L27uHkrqXJQKiDRDcQN3EFDDx20BKX8s/KyzixjCopBSAhoQQagJ6BkBCl6y+p7tP5wTfAGFDQf8WkdRk8t4x6A34GDKJmlfdMT9CI7L3zpkHfe57z0QGG9ONJopJYHjwTYS1O0FWbSiYWdsFlEtlGYp+lTsZAUatYL0U8aZiZk8eJYWs+IVtJ84bL2/mZZEYYsxzZgg9JntkEiNSCdR3JW6+fN3oKJ2vnABtMMUqD8zQjY4U15X2rN2zEgTtq0c94VJTpcFrERb/JB2F1f5A9bmSgDbbWKpCdimBHfl23641w/xRa5JIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGQZ9TMf+mGq1oB43wsmPd91JFOBNphecT2cQecvK6o=;
 b=Pjp4APJl9Gamx8sZso6sIvECku05TIDDzoEw+0rgxCL3xl5qFzzZ2iZ90hoTgjhcnsgi8guObLES76W5VEPtq/7EMfLA2hDSpVLJhXWQuAXzwJk27IMZLJT3wgUTGWYeG3nXKWFaDyCKAg8od61p+bn8B+5mnOMj9niKIdOL54TzQO65g/YqKYOIRZWwRZv+tLI5RNRvu5JE6qJ9XuE8qkAzH8BAVekiYJN4hrd7AKEkBqEo/KqaKsxu1SbWmVh6Abgq+unuqJ1ybD/BH8qoKalbbMPkwtB3nAAd6wER34+gwlSWn+j+U+F4XoX83vQAjUmeQaYD/IyFoPKSJiWhSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:28 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 08/19] iommu/arm-smmu-v3: Build the whole STE in arm_smmu_make_s2_domain_ste()
Date: Mon, 13 Nov 2023 13:53:15 -0400
Message-ID: <8-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:208:a8::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 449c196a-7f44-44f9-b7dc-08dbe4717042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ztbxOcYpbjACcoWQnsMbJ2CiIPrEJT+82fTKVrVkiq6mpy35mJRzVJfyWHf1+y/KUNKnanSRxLe8fO7U/yNQxIFVQY3psTovRSg1WKGUIzUgjoJcuzpB6ylJpZd+P4etlqgD9SG1u5WdOb15BnAKyefCxrWZgUMCNwM9rhsUzry2ER7Qyn7ZXTIdiBSY+45HEYLzQ18tlb84xPVdjQVxNrq4TxoCUV0icS+YRHHDpkeVTQKvSSrASyKyX0dPYIMMLK0nPKwrqblvBle1pUg6L6W78ArsyecXWCDOvsUo+LZraHRSQZ57fgMnJiMDnLCtN3UVwfaYnbM/rUlfDE87E1y9JETo8FD267TbJ6h8iwF1RMAKLQ86NFLux+gf+AFlFlN7mYUQ666Of1wvDoE75IH8YIxjFnL+Kbwzbi31D5KsOYFN0E1roNe/CeViJNGYW6McFw1uj1AhE5ZQZPlQPrB+Q4jqN3E2W64guTKnO9N5JxManhA973K5u+FdQaS2M2FEpIIwZXHUTX71Z53A9VKaybmuq8wkU2CIcLAsZquvlEXoEsKZGvPiY4OI0bGW4oCNmAUn1RMg5rWyOSdoHC/1t0dxYsXDmMpAr3Qg0SI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+rcD/srPhHb+jRTqNLnF342kbZes350hiEfIz6n5TH5T99ic7rlO4BTurmgr?=
 =?us-ascii?Q?tgD/cGgvTm0jiiF6CL8STHYG67ysPGQNRuXpplZY2innOoowIeQSB6+HY/V/?=
 =?us-ascii?Q?Zx+j4D8rmFY/IQ9bMBAbmq3DyEjPnL+jYAtXqu5zNiaZMlo4dh9msILvagzP?=
 =?us-ascii?Q?bK3fh9lJKOkrwzOkzeas07rY1Mv8MxNboV5kO/96ZNSHG9sFoFIDzGnDFgd/?=
 =?us-ascii?Q?iZfS/XetJPTIiMONKyQEPAHD41F8QTc2rsIcHaadwIj1CKpKnwOmsUulp5gW?=
 =?us-ascii?Q?ox2aa3sLV54Wo616WbQU8scjBidEn5F/Y+XTkkhgzhEHW64NIoiViDp2fIN4?=
 =?us-ascii?Q?dGxRazXCIipcy0dCcm4xnWVg2zgMBzXGLnMYh3IBvMUFLo2+V8uhG7mMCnx3?=
 =?us-ascii?Q?odjuMkV3qGjanf9tggJkJXDbZD6p95by6CuXBZHJ/4b3ooa7uLhT31WTdaHy?=
 =?us-ascii?Q?CCHPa42Y3Kg/vJ/HwtV0HEroqE+X82I8qly3+rtGoDZYUkmcrj/+hlcIfWr8?=
 =?us-ascii?Q?TBZnTk2qxPk/A4pBJ76wuNMtCNk9j6E8uFw1fQzDJXQzIF+x6EmeqVyDNVJ4?=
 =?us-ascii?Q?D6Tq2E4O6XM26MLUEslpFs+TNW76Vf391l1PBPU5XhDxS0G3uWSo5gLwjmp/?=
 =?us-ascii?Q?iJfEKsrCZlOaK6Wv/BL3pTbfkdn7i3vnJB+h0MxJs8We5QFLdDyzpF3aiE1Q?=
 =?us-ascii?Q?ExRLNb9uVaaojqsjRglAxIkiyDIjHzMAczOx/YmAwGe6+RBpiwI4Dek175gC?=
 =?us-ascii?Q?+D/k15HHSMOlz4VombO6gVZzpDgMKvLJSxhRSXUtTEGWczGBGlGf6T7RB3yO?=
 =?us-ascii?Q?5GdO+3GceZSmRo4WbgK8artMvulsLHBSV+ADq2dUlY0oYo3E7pZZCkdIb/q+?=
 =?us-ascii?Q?hFLxBdUuShcFdsf32Z6keB9ZcMue96vMGta/OIbpGAopZIV0S41AV3z3Otsy?=
 =?us-ascii?Q?DG9qZfBj4I+2qnxXMLptkZrUTFvkS2qSgxKMBnt7iGwQhnPWP2NtwU7svfQp?=
 =?us-ascii?Q?P7LXsZF8Sqnbqh2kUttIkS+jbdiXeL+sy1plBrwQzBIc4ywGRw23S5AHBKKf?=
 =?us-ascii?Q?G0QUo1axhVoVvdDJlj5k1qIpOumVB45iZYeURDNdY0sr4AtgMDnAbE2qnkrt?=
 =?us-ascii?Q?5msqblEtfG7QcwHFiMRkTgI7DeyDIyJHG/Znhwn5A3Usjr8SvhVI0jCh4pCs?=
 =?us-ascii?Q?7yHP6LKblJK+lYNxNbKrF1GPxDjHZMwtRPwoTqliekcw442mvwrJXMLdzWBh?=
 =?us-ascii?Q?w0jaI1IUSoiC1QlsBXHkxllMEcAZHeJGQPwYGtvi/CtOY9Di8q3ks1gXhpSa?=
 =?us-ascii?Q?R4w2+YikUSwTeVjixuYiPpKqd095jQG/hdWP/MBk57XZVZm7kXz5x/hSpSFV?=
 =?us-ascii?Q?DLxCsq9582Cz7GSDF4T3J+otC8mId7cdPv74TLCvPr7hZgWiXaCzbG7O8OmE?=
 =?us-ascii?Q?aX4PmCLptBsS/GjvR+XP7R2m8cdzanm+FyG4OFR19c86CtthEPw4ZmlBUO7x?=
 =?us-ascii?Q?X3j2BtvL6HBMoP6dtOLVKlJEWLqotY4GyN53zD3OzqFzbPFqzHT0vr9/9XRs?=
 =?us-ascii?Q?W2uetoUXOC7qK9h9mcw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449c196a-7f44-44f9-b7dc-08dbe4717042
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:26.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuoxEcAm3LqyJmWNKwJ2oOAFpKHtxEwNwQpUdw0xGQdJ8mZ7tSxsEGUsPOIosx8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Half the code was living in arm_smmu_domain_finalise_s2(), just move it
here and take the values directly from the pgtbl_ops instead of storing
copies.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 ++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1c63fdebbda9d4..e80373885d8b19 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1499,6 +1499,11 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 					struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
+	const struct io_pgtable_cfg *pgtbl_cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
+	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr =
+		&pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
+	u64 vtcr_val;
 
 	memset(target, 0, sizeof(*target));
 
@@ -1510,9 +1515,16 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
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
@@ -1520,7 +1532,8 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		STRTAB_STE_2_S2PTW |
 		STRTAB_STE_2_S2R);
 
-	target->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
+				      STRTAB_STE_3_S2TTB_MASK);
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
@@ -2277,7 +2290,6 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	int vmid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
 	/* Reserve VMID 0 for stage-2 bypass STEs */
 	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
@@ -2285,16 +2297,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
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

