Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C072B747
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQuAY/oo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXhE09XCLbNMS1hIoVNs6j46U6za5SU6lWI/1CzD+1QLHCm4aa6Lm9QXgyHDMa6nX7syLA4he4PuQMDLIWHCGBO4a+tH0rbfn2i2C4Wo56vDaAaD8gz5bFj2yygmtNoJGhSpZPJs8QFTE/eOpB98hrAz1xZsaaaJTWIEq5yenLJomKufECI7HSGL91WUG3R4ClVOnaOMC7pik/nmasPzxt2nW4SuZe65LpJBdiRynImryfiRe4CNB+xddcBjOSf8lUIN5e1npaMrZvbBS3T65WI6Ll6QcFufmPM0zsgZepnmeXv6VmZKhiYdKdImQBAlbDu7syi8BTtOH/ID57r55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKUPr0oRH2p16ds94vBM6a9/cn5EBb2oHFMM2y7J/7U=;
 b=OPGhnGYu0IUipNNDXpZ8Tng8owPXa5SDrklATg0tQeO1EGc1zELYn8+0QZKeMgJB8BAMxE5RQeB/KheqTdiLd7fIat/W3YFh3+lXsvtNcVT5VTDcFnFpArtvlErNBaZFezYeicdvbQhVsJ4fb0qsJBQBoaF871LAiFK/JlFLIrpeLwkEs7gOY+9wHNcrAvftWraF2Erhw9rgczgal00shNQIT5qDeAvEpVetFc49wAO+EZUpB2P0yl3HHZhaNGGvC8RJRNHNMDImoXtD+8Sxzs/d7d/Oyd7H7zKo8M21tUlSKnuiIb7WHOd7YME6S/04A7brhisbhkxl8hnwb6tfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKUPr0oRH2p16ds94vBM6a9/cn5EBb2oHFMM2y7J/7U=;
 b=sQuAY/oo93lFCdmxvSq1psXjrGf2w3JYVRlCZW8Mz0PIz5wkEyqFS0J88pmPPBeMijn7h2WtuncR68gxD+FRXkRq4JAzQQ+Q1SYO42rxTlTsUqd5qXEE8Tli2NX8ncQjE7hiwEDlgAuiAqKP7eLEXFi/1ZyElk2iAoYuUhnvRvjyAgtkXSA9AEBDbfv4GFYQmPBEd4PMTg5Od61rq5/kDRmM9EdRmImyEXes1K/aF2SZEd4Zmiae1FxCG3PNMFadGpSne6Jw+bfSUfAGL+7OeoNnP2WJmEq2p+CTUMpD6g/+4iwKFkB9fOCl9fDbcZO90Zc3LXJtEtey+tDPBvySUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 05/27] iommu/arm-smmu-v3: Make CD programming use arm_smmu_write_entry_step()
Date: Wed, 11 Oct 2023 20:25:41 -0300
Message-ID: <5-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:23a::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e6fbfb-e19f-4127-417a-08dbcab17178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	royBjEw7gP0lOvGgFlJdFuOQs+M7tUzzuaSodDhP2HGyIZzGb+MyNtrGd1QtdHtTvC1CGNnvykI9j10fBbw/vHk5sXW46WmqD+8TT4/SOZkiNEjn3bjDHDCTfiI1mmoq7mSXNlZjcSs3AgIdknu36lZ1oOz7dqTZFywywvJORjrxWZ8RhVR7PjuLR32Ay/4gsCFkfQrmw9qFTZJGz7uvePUnpra/yiYMuKSNUdMPytuZVFt17G0KGZZZYjywokow9/2GdEFdxlUr8dn8fEmn2w2zTw5knxCX51TL0qjbC8wlGNRbUCVxcalainoe/GrDbwWZlTe9xrT0vHC8O/vGZbffqLxaTr8XGoWQBG5IjYcPaTY7MLATSJdd7/LFPcgJECVBT6B1+2cvukzp2Q4CutXXP8qUfr/BDnH7UBdo5ozcBMO0fqwJ2LNVP7aZhMzAIi19BS0HXDfgePomBELPSL1Q9kZR50U3zW8in3+V46RoaclXKcwUk36U6eEoFeWYcm/c3Pezbi9CnKOzfyOjzbqhWh/J65PF32kmEV8jGZNlphMTCaWgZOSFX0lYHc8YCCcOLApd0gy1y99ENiq58OuPm4G1pmdFsT/HZ7KPZK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmdn4RWVVO4I3yScwLSH2yol9arWmysWURZPiMupRhLTt3gCxDGtvesNs6dt?=
 =?us-ascii?Q?R9lLustyQZEbzod9ErJeedRP3iS+WdQjFFb5WhlTU3uu6wJj2JA8Xp8lY28+?=
 =?us-ascii?Q?S4puT5PBUwiwZZuQEsghD1qOMXuK/1/Z8AVnXcjFRF7M1IzOSwjdE6WGsLIG?=
 =?us-ascii?Q?a6BDJrBJWoqMcFh085sqirWGLDoYQf//SQXoJjMdfmanVPyW931D2vlwXuSF?=
 =?us-ascii?Q?HMfL+WYHOYd9O+gTomia9ozmpWxTLVCJ9XEEzqssJB9PYYlF+T05aSI5UIOC?=
 =?us-ascii?Q?Vfb5M/V4cW+RgEad8FhBx0kxQfPxCTLCJIwPEEJaXLxm4u+Li002UYJ8NWpf?=
 =?us-ascii?Q?+vBZfrMCRbmefRqkAzFhKrPMfWGmMvixvuG/d2duIqWByE83KNSCCGEpqTSP?=
 =?us-ascii?Q?wfnXMjaunU+x7YcUYYTHs0IlZ73ECdvrRvzktTXtnPCO1eKGHOXHW6m+EruD?=
 =?us-ascii?Q?azigkBw+PtCc++qguyeRhOYXSQ4TaJePDCEbqMLWKdJKYGbW6Ubxafv1vvsH?=
 =?us-ascii?Q?t+4bdLMuBGatB/iUbvy8Uj62lR/tWUn25GEH5kswhBVqnANNBBoPkBNAY9zB?=
 =?us-ascii?Q?H0rTDdoLhpb7PDxtu0vAAYahRoYoSRwaxbKcF5DKgDeLdPvtTeWYHLircFZo?=
 =?us-ascii?Q?/+9XevFuTliXFnUlrNDJxQ3r7FUv8g5Ic0sBpqoVLzCiXNc2tcre9vuRhgLi?=
 =?us-ascii?Q?MFgO8vlybU3SGhXYoL1RR/9DLIj0oWqT7V8qnPLP/OfTqh6k4GPIRIh1bwu6?=
 =?us-ascii?Q?S9DBmBHSlFxN2ZwMrE076iDnKUJUrzINUai3Y5j0OSjurJmFry6P6OgFFjF+?=
 =?us-ascii?Q?npBulgIM7D+hjiYZRUJ65JjvzB42wqXyz4+6Oyi81+BeuN67dqpFLzNGDc32?=
 =?us-ascii?Q?cbzTuWZd0RhUNg/K/fSWP8gbAeGYYVAjB0DyW0XSWswHWzmS0yT4t/ZlW8vI?=
 =?us-ascii?Q?0I75mJtpmHTFEK6+ZBi4kCZwcaNk7o69ZwU+zuxiWmK46dKWWISdNAe0IITg?=
 =?us-ascii?Q?TG79cqfXDd95nBj/+rjDpL0zQiVnyV4g7JrYR8qV8f/hZzFbyl+gpoyzda48?=
 =?us-ascii?Q?n8TxAQeVpVbP6SrI6vez5tdlJ0/oVEcuLR26epJtYKSSkuhKrbt9pwEtI27U?=
 =?us-ascii?Q?+UOMWw0kKC/eLgPQ5xun3UzItD1TttHTt1H2tZYbBto1/1rq/55QJCRD1wyw?=
 =?us-ascii?Q?Ogm+cKM9advZCoo1+eovroErP7+mVDR+Rl3OOQHM5DJorZD6BKYXZKqOIx/C?=
 =?us-ascii?Q?iYwpcYLriRc5VkPjAM99a5G3tY1Z+htjvgCbK72/Ld8Qt9KltkMPZ4IBwkPt?=
 =?us-ascii?Q?gXIM6XT/EpmzEatPgWs16FzF4W7c77NG779AlLiUb2Gw7Iqy7QU3Gxrncas/?=
 =?us-ascii?Q?RsgKRbo4KXQfQWYu9KTnYARRHSAOrPfZrVtkAx91C5EEaw4kraGJEsxnOjhe?=
 =?us-ascii?Q?d0XjUE7oQ5BvgjJofc5E8S1lhEoqubYNIX0crKlFg71m34GvqHdj/7USNxHd?=
 =?us-ascii?Q?kr+vCfW7VN/b77ot3RJ3PHxRQm2wxpJIYo4pcFVnWny3aqtHK52xdgafgdyJ?=
 =?us-ascii?Q?psG4cesojKYzyH7/Ox0s29ncYkKP1FR6vQVbKw47?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e6fbfb-e19f-4127-417a-08dbcab17178
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:06.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADpT2Z+Jl5mxQqN+J42pfAK/ovWdJkMwJo+F8sCpBM5J100MDYeSA3mzFohsKKf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

CD table entries and STE's have the same essential programming sequence,
just with different types and sizes.

Have arm_smmu_write_ctx_desc() generate a target CD and call
arm_smmu_write_entry_step() to do the programming. Due to the way the
target CD is generated by modifying the existing CD this alone is not
enough for the CD callers to be freed of the ordering requirements.

The following patches will make the rest of the CD flow mirror the STE
flow with precise CD contents generated in all cases.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 79 +++++++++++++++------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2712d4cc007421..64e11c56a58397 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1114,6 +1114,55 @@ static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 	return &l1_desc->l2ptr[idx];
 }
 
+static void arm_smmu_get_cd_used(const struct arm_smmu_cd *ent,
+				 struct arm_smmu_cd *used_bits)
+{
+	memset(used_bits, 0, sizeof(*used_bits));
+
+	used_bits->data[0] = cpu_to_le64(CTXDESC_CD_0_V);
+	if (!(ent->data[0] & cpu_to_le64(CTXDESC_CD_0_V)))
+		return;
+	memset(used_bits, 0xFF, sizeof(*used_bits));
+
+	/* EPD0 means T0SZ/TG0/IR0/OR0/SH0/TTB0 are IGNORED */
+	if (ent->data[0] & cpu_to_le64(CTXDESC_CD_0_TCR_EPD0)) {
+		used_bits->data[0] &= ~cpu_to_le64(
+			CTXDESC_CD_0_TCR_T0SZ | CTXDESC_CD_0_TCR_TG0 |
+			CTXDESC_CD_0_TCR_IRGN0 | CTXDESC_CD_0_TCR_ORGN0 |
+			CTXDESC_CD_0_TCR_SH0);
+		used_bits->data[1] &= ~cpu_to_le64(CTXDESC_CD_1_TTB0_MASK);
+	}
+}
+
+static bool arm_smmu_write_cd_step(struct arm_smmu_cd *cur,
+				   const struct arm_smmu_cd *target,
+				   const struct arm_smmu_cd *target_used)
+{
+	struct arm_smmu_cd cur_used;
+	struct arm_smmu_cd step;
+
+	arm_smmu_get_cd_used(cur, &cur_used);
+	return arm_smmu_write_entry_step(cur->data, cur_used.data, target->data,
+					 target_used->data, step.data,
+					 cpu_to_le64(CTXDESC_CD_0_V),
+					 ARRAY_SIZE(cur->data));
+
+}
+
+static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
+				    struct arm_smmu_cd *cdptr,
+				    const struct arm_smmu_cd *target)
+{
+	struct arm_smmu_cd target_used;
+
+	arm_smmu_get_cd_used(target, &target_used);
+	while (true) {
+		if (arm_smmu_write_cd_step(cdptr, target, &target_used))
+			break;
+		arm_smmu_sync_cd(master, ssid, true);
+	}
+}
+
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
@@ -1130,16 +1179,19 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	 */
 	u64 val;
 	bool cd_live;
-	struct arm_smmu_cd *cdptr;
+	struct arm_smmu_cd target;
+	struct arm_smmu_cd *cdptr = &target;
+	struct arm_smmu_cd *cd_table_entry;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
 		return -E2BIG;
 
-	cdptr = arm_smmu_get_cd_ptr(master, ssid);
-	if (!cdptr)
+	cd_table_entry = arm_smmu_get_cd_ptr(master, ssid);
+	if (!cd_table_entry)
 		return -ENOMEM;
 
+	target = *cd_table_entry;
 	val = le64_to_cpu(cdptr->data[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
@@ -1159,13 +1211,6 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr->data[2] = 0;
 		cdptr->data[3] = cpu_to_le64(cd->mair);
 
-		/*
-		 * STE may be live, and the SMMU might read dwords of this CD in any
-		 * order. Ensure that it observes valid values before reading
-		 * V=1.
-		 */
-		arm_smmu_sync_cd(master, ssid, true);
-
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
@@ -1179,18 +1224,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		if (cd_table->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
-
-	/*
-	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
-	 * "Configuration structures and configuration invalidation completion"
-	 *
-	 *   The size of single-copy atomic reads made by the SMMU is
-	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
-	 *   field within an aligned 64-bit span of a structure can be altered
-	 *   without first making the structure invalid.
-	 */
-	WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(master, ssid, true);
+	cdptr->data[0] = cpu_to_le64(val);
+	arm_smmu_write_cd_entry(master, ssid, cd_table_entry, &target);
 	return 0;
 }
 
-- 
2.42.0

