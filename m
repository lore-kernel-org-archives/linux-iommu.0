Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FAE186E
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DzFJ18r7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRVG7IGboRQ1ePbMRhuD6c3kP7VJ9nsUwh/h78oTRZXckY7RWxRCbYO4LinfChC1S/QfTVynVjkYm1RhCNG+qFsPWlBiQ8ucWhPj3Ecn82cHpCNqgK1IYBWHeZz32ARV3EOJ3+EfkK2PlEejPAoWW7fdtZD5PFH4da2osChqb/vh3Y+2I/IeimE4xevK7J8EvBFKCH3K1cxq0MgorDvA5e1cca+baew7y6Iw23JgUwAX3iZ15CWZbWtrJFXLkf8uZaiIws0DhGU210WHvsGcEfhjDx3t8jro+8CmxWmK6pZj38usXtv8LIZ9FjFYGjE+pXCLXY+uQZIRwaTpEyq0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIcDGSlI4UTjJMnl6oNbEniLy3SV8fMl6Ixj6SIksq8=;
 b=jJrFHqZlCAQMrzB/A9JyFh2X14l1JsU/a2UP4ktNAGAdKTUxWw6uvWpByiHksKIZzg7AoxzcD/SPT2zBF01c6y5CaR3nDNl7/MVElDp7+QzXPrAqSLLXZhceJXwh7yaYNEEjuLJoLL5UrDCPe/SI6ygZqdj+uk4YOprxrf7rludk63oPAfQC5m3VBma1Q5XcvPN0S61PXsXlztiY6RFcWweXNeZLGbD74TA8zD/98WoE6mDSPrl4ACsojX5I+AOHoBUfHT81jgS8i2rRlEGe3gdq2U4QyqEHLn7nnPDMZR3dBy8x1FYBPECaHP2ANsBE/mfcFZ+s+FC0HUzgUtU1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIcDGSlI4UTjJMnl6oNbEniLy3SV8fMl6Ixj6SIksq8=;
 b=DzFJ18r7Zljx/RrWesRkB0zxiS6RzUYho61rVXai872rUj7ozxbOcBO9HsSAU8+nezEtnJVcA3iHGLkFy3b0pVJY6CJ9pZ2AHMFtIkzX7w6dV2ZtO8nRV3pJjWQvEqsiuusvxeXxaZZ3rPY4NpzXob5i4F4BYtMkRi6j4BpR34E/SrkwXW/1ak9K1jYBeLPM/hjG+m86OuquNO7W+hqH2JHLEcFfKD1dHbDsRohhSX+5HdKP5kUBpR4sQmF9xm7PjHvuem6v2rkV3fW+/vRG20qkbILYxuwC/pK5VroWElq3KWK7BFaG52hiPUm9JwDL9TcUI7fomUmHD/XOe8shJg==
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
Subject: [PATCH 07/19] iommu/arm-smmu-v3: Move the STE generation for S1 and S2 domains into functions
Date: Tue, 10 Oct 2023 21:33:13 -0300
Message-ID: <7-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f482254-771f-4177-1351-08dbc9f1afdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N8bVZWXs+Rd5+5c9uRHlJ0zUsXjjz2qpsJoenstzjXk+xOeFtfp3LxAY1IzhhXv6EfpTjzWR2cURPUE1oS1RMDGvH1Rw5+3YpNTTzQR/IZ9nu1WAx5ZHKvSIrC1hlJPeHmPkwSgsOhaPcyoM4OxB0KyDq6t7uosUtrWzumPcrmpWI1ynE+Xl2Uchyi45WtpSV9M/uEBaz5UC0rdFBOdsha9RyYmeeHiELn7jYGyZ84yPsSkzorWJk79icZkE5MoyLTY/aC7Jw+Bd2exvTC/EQX6QpbJtuopyylakZC9z83iY1heHYbINHz0Dlz1exMYb/JEzNU6WnM8LrPckrevLo8kiEx/z4MnbKUM18DZnkjT0H6dyJb4g3/n/f66Ao8iycfpfRppdHX9a8vDzqJUMyeNWrEyTLSQYCbSqmYe3eBUrSb4Qtpqc1X3HFDc0MsfvdSWyMU1XrPrTX9ZVTdYTQ2Go/fuNVlXL5jNENVWRwcWXOMGTpq2w93u5pTwPUUA7QRMDKkKnth+iXdCsGsRO9LAR7DQuEOvHxk80UBSqeaXGl8/0kYU06kLn0ViwOquvYvdhYmHmn8ilH1P2ca9F/fAdG2n4xza4HDKH88wtJLU8zvehx1WY0kxgvmyruAMjfG0fqwm2fqVIFJgZ9NkONA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8kl6eqyVLmy43F/QPZNSQ/ZLJYoYqnA7W5qhELiHw8thEDL8ziEobpR2ZQVt?=
 =?us-ascii?Q?sPm5VlwmN4oOz9o9f9tX+0bPy2HQGua/+FdPzeDWcaiUNyxJ0C0yIx4wLVHk?=
 =?us-ascii?Q?ObxEJkjKRMQiPcWSLF1vUNfGxLK1Tcm2m60VZSH8580qWd3wbyNyIueA+2zD?=
 =?us-ascii?Q?+uhDgfmI/CHW+IMY5xU76h/kiQWKg6AoWHtnL3495vymnl6OGqU0KjYqRb9l?=
 =?us-ascii?Q?jQex8hnqWP2hlN74aESPgIv2ICK0+3xSuFI50GPrR+/eWZoY7V+rENDlNS5O?=
 =?us-ascii?Q?KW45pCKKC/JwG1WcaSHms1pj01WcE2QRdTOi6pBx8C5kCehqiv178isDC/XF?=
 =?us-ascii?Q?W2eQqi8GGfp5mdi5mvZH3MH/vs55/THlsmrjNoVltazKpaKop3hxMSFqWZFr?=
 =?us-ascii?Q?1kPWWMOGZ+sVPBIDIL2SoftIWwRTmBSutove3kDmKB0E0T5r9sHra9fzk1DP?=
 =?us-ascii?Q?Wk2K9z4VmYL7dCYBRhL8FDEIBknZPY0WCGMd+ZsHitRE2h4bozGrQUr8aVRx?=
 =?us-ascii?Q?VgRcQclCVjWVFxMs9AHSiZ3lxocGaXDpAYfxN/i7SYLqEm0mD2hEtXYN+Mly?=
 =?us-ascii?Q?hA+hUyrSmcASKB/E7o1ict9BWFhVQ+n4KUcHyGlWIHUeyVTY9UJQZRcYN6FJ?=
 =?us-ascii?Q?rkw0+bBG643ncP6PvPDghxnJ73wGsKdqloNi7fk9Rva26J4+qOxXm719o/zU?=
 =?us-ascii?Q?zzASuNz1ZTFMcWEAajDdT2Ejg5m6Egf2ZnTxVhB30wJ3FQ80vrUkCDGcvbGF?=
 =?us-ascii?Q?m+iXm1eEG+a6CpME+bbe/ZztZrz3vOOtZMwLnv4TTsnr0R5kCu9n11RPOv58?=
 =?us-ascii?Q?MAkntpyCZmPQ2O44c2qvY3NJoDIkt+r/ZTWnxUjWVBoII1Ul6v0MR4Hv7T+r?=
 =?us-ascii?Q?tOocduKxbsjleTqIfqMbdF+37Iab9LDOIOoWwAG12w8O6xW7GK81RdOI1k34?=
 =?us-ascii?Q?yYfTG4eeT4LGB5c6w2tfCEsnS2UPaue4idTkLRRnVkAhGFItlhAUIwe8+kEW?=
 =?us-ascii?Q?JsZ+otvrASmQc3jFkhLuLj0sjdaveizmNSy59W82G6bJM7npMfUKkUiN/Uui?=
 =?us-ascii?Q?a5izp9iZGn1jinKXBC+V5vBxactBemeKGTwWn7JBsr7ScgT2oTMEB15V5RKl?=
 =?us-ascii?Q?z+9nUEpaZByasWf+TmbxGo4A57s7ur8NJJpR9Lp7OHNq+EprQRcLw3rBtAc1?=
 =?us-ascii?Q?kapkF1v3OHdh9p/CQ2C1mj7Rn8kAR4JATyEIxzRGbv2k+vjkYJF+BTRUYDjP?=
 =?us-ascii?Q?p9yuzrbWC0Wsom4+GPxDaMjlnXP94q3711drbno/iWE9P6xbpgyJLbrY9DFx?=
 =?us-ascii?Q?7/0MTjHgzOjRosmHa3xYAkJ+ee5pi2dwqPr8qMOJ6Mm5l0MJgDLogxMw1HUa?=
 =?us-ascii?Q?JGtjfPHtIm0LO8cTTqbnhANY+eJ7pHMw4PO3hoiA+kUs5rYb0Mc4V+YmVSOo?=
 =?us-ascii?Q?TJY9xwe+NiereOY06M3A8qijOtmO+T2vu/qA2DrGycKmWKrY8cq4giwCHigJ?=
 =?us-ascii?Q?BF4NlxkEeiSUYnCv3wGjUu8lqvR2iW7HalwDtALdm+jx2EO1G7JoYnPm39oV?=
 =?us-ascii?Q?VDZemVY1zhn7N3ac0yKpeUmNi3tots7IzcdCqTI5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f482254-771f-4177-1351-08dbc9f1afdc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYMzRQKWsXY+Hrx5gx4P/mUDrdS1gQjFokvVo5WOkPkx5tkpbIWE23ikPP1CmP+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

This is preperation to move the STE calculation higher up in to the call
chain and remove arm_smmu_write_strtab_ent(). These new functions will be
called directly from attach_dev.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 115 +++++++++++---------
 1 file changed, 63 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 27eac8d4d86f03..00d960756823e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1438,13 +1438,70 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 		FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
 }
 
+static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
+				      struct arm_smmu_master *master,
+				      struct arm_smmu_ctx_desc_cfg *cd_table)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+
+	memset(target, 0, sizeof(*target));
+	target->data[0] = cpu_to_le64(
+		STRTAB_STE_0_V |
+		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
+		FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt) |
+		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
+
+	target->data[1] = cpu_to_le64(
+		FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
+		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
+		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
+		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
+		((smmu->features & ARM_SMMU_FEAT_STALLS &&
+		  !master->stall_enabled) ?
+			 STRTAB_STE_1_S1STALLD :
+			 0) |
+		FIELD_PREP(STRTAB_STE_1_EATS,
+			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
+		FIELD_PREP(STRTAB_STE_1_STRW,
+			   (smmu->features & ARM_SMMU_FEAT_E2H) ?
+				   STRTAB_STE_1_STRW_EL2 :
+				   STRTAB_STE_1_STRW_NSEL1));
+}
+
+static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
+					struct arm_smmu_master *master,
+					struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
+
+	memset(target, 0, sizeof(*target));
+
+	target->data[0] = cpu_to_le64(
+		STRTAB_STE_0_V |
+		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS));
+
+	target->data[1] |= cpu_to_le64(
+		FIELD_PREP(STRTAB_STE_1_EATS,
+			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+
+	target->data[2] = cpu_to_le64(
+		FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
+		FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
+		STRTAB_STE_2_S2AA64 |
+#ifdef __BIG_ENDIAN
+		STRTAB_STE_2_S2ENDI |
+#endif
+		STRTAB_STE_2_S2PTW |
+		STRTAB_STE_2_S2R);
+
+	target->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				      struct arm_smmu_ste *dst)
 {
-	u64 val;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
-	struct arm_smmu_s2_cfg *s2_cfg = NULL;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 	struct arm_smmu_ste target = {};
 
@@ -1459,61 +1516,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1:
-		cd_table = &master->cd_table;
+		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
 		break;
 	case ARM_SMMU_DOMAIN_S2:
-		s2_cfg = &smmu_domain->s2_cfg;
+		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
 		break;
 	case ARM_SMMU_DOMAIN_BYPASS:
 		arm_smmu_make_bypass_ste(&target);
-		arm_smmu_write_ste(smmu, sid, dst, &target);
-		return;
+		break;
 	}
-
-	/* Nuke the existing STE_0 value, as we're going to rewrite it */
-	val = STRTAB_STE_0_V;
-
-	if (cd_table) {
-		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
-			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
-
-		target.data[1] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
-			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
-			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
-
-		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
-		    !master->stall_enabled)
-			target.data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
-
-		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
-			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
-			FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
-			FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
-	}
-
-	if (s2_cfg) {
-		target.data[2] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
-			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
-#ifdef __BIG_ENDIAN
-			 STRTAB_STE_2_S2ENDI |
-#endif
-			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
-			 STRTAB_STE_2_S2R);
-
-		target.data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
-
-		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
-	}
-
-	if (master->ats_enabled)
-		target.data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
-						 STRTAB_STE_1_EATS_TRANS));
-
-	target.data[0] = cpu_to_le64(val);
 	arm_smmu_write_ste(smmu, sid, dst, &target);
 }
 
-- 
2.42.0

