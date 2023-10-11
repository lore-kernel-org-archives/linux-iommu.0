Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EA17C7
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwR1NS+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwiIXMstnKkEXaJanzOGlPafnuVpBRqBGXz+VUiEWpUAS/bK4kz5Q0hQRyri7Lh//s20Cgfcm3fxB2rUwHsNjpEsIMDi17U56b5eoGkyUg0r2RnJOA0oHDNHo8n26txwmBQGwlVQSvbc2PSTVK+SmeevOgKFPXk5NPE//zri4WuZEn6UCLk35htMJKkg2p4lTT99RJUkvDNuyecAFtU/4x93XGB9M7k0wzwV4VEaoYbjpDKd+LBWCMAQ0iTt4Vtp2TetxGgfQzfCEOempJjKYnx9hvKUtjV3qafgg2R7yaRCJtW1IQRfULLINcNNFmRnLvt6hQQxHmNeSS+h85PCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dEqUIHbAzS54hxbxdiuDBUkKGk0WiGQK2I1e0sSWgA=;
 b=XdjNA8BpkqTx80KWWM3SKA9sSAYcLfBwd1EndNOlSdmjvIcXsjBF1R/1fLXLeDen4hF5K/gINwBSJSvuOL8mJgIHt3L+fSM0+cTc/3XVni2AR0cYwH2AAJDblr0PQHVaek2NXDINpcZ9v7VCBSuFQTQbqcfwnY/AIo8cwP3a6UzoJsXXYBxgNdNRRgPlCjrEAPJaJQXZD42Y06uxdbybIE/z5r3y+nsZwcD+mjbkbrTrPcfEkcYZ08/LC4tm274eP5m2gpuS8o/kX2hds1y9bDqa10Nu0ycg/KEHgTX8t+fNQDEj+owZJ/XbdBHgKKB5dYPBdOOqDI10wMDOlgFKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dEqUIHbAzS54hxbxdiuDBUkKGk0WiGQK2I1e0sSWgA=;
 b=JwR1NS+5LGT5mTYgYimmJmg99Bjx7M/zPADnMfakpLhS5tk6fvynWk8GAg5Hr3YfCqauoNg7hBxrSppQ2MoqCxWSRfvA/o3DMgwhdCyIxnyFfm2fA587/OMtw3cJcGvE3Sd0IabVcqxsKK1Z+trnF4hH4p9o6l88z4dsMkmsrPAdjBisWTdiPQl1Rm9d2VTbIN9zyW6FvqSxwIDRPTu5yqrVdaCVwU+xvPqcUd2zu0LqFDBw3r+UyQq0Q0wJEv3l2VRbUPp5+rGP5KNj90L+kTwJAB3wCu0UXKUhvtTaGBJXUmTBrKOQKnOyT4sYShvmKGUXqALV8Ru9g7rkJzTEKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 05/19] iommu/arm-smmu-v3: Consolidate the STE generation for abort/bypass
Date: Tue, 10 Oct 2023 21:33:11 -0300
Message-ID: <5-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbc2dce-0aa1-44ba-155a-08dbc9f1af0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+I3e0yf2FsTfa9LvXpHTeMIJVU7EvKiR7Px/vQXaIFSXpyeCW9GnB7envJD2EzYDJBlE20DUMfDoAv0xyMcCTW05rKJIY+zzQujFD5Nrz7bw7F6jSj6ckiGiJl0RlvDtvx8ehaJHj5sM3f4a7XDHryrLzS9mGnpaZBYkaAU+WDbBi6nvXwrz8S5dvnnqFy1z/1kNqklCr5IieDbO1Teeo00E+OfgRsrI1Gjflele8RT/BW+wOGQSticGaqrNQ+DRKhQo6Q43ydnZzykKXvVslDaTkLsrfvz0b0Qj7zGnGT8CjX8AZt0LRud0CNB2QtZFr328JSwz0NcqqOCzDvqDnsXOzceKomjrbf4jHUh+FXO04DhMye45i8z9WL22hT2ctZ2M0aSfmPmwgEf1JQeAnpx1lz/cJu6iuAIqSjdJz9rDEW7deLLSopMIhQ2YLDHkq0yeWuHqvpZTTJwJ4ry4nJS3zu0FoUMHu3X0ZvRtIXc/yN95vCbaF+pj+DLQArJs8i8Ot1HXzqfnFwO9yl/aT/344cCUoIqYFCwZhyTDjkzNt+wbL/3P1gN2pN57zcLP6cnOE/Ga6rrO+CymYcXzb8heXsBdUyG6t6sYZsnJ1w8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkIyp0iUzdtQT9esp02ZCwfPEzByPO5OwK1Cz/t8wTaTk4UbulO4/vmIfauo?=
 =?us-ascii?Q?5wkGdl6C8fEJYskA9cQAq0FF//xKqPSN/mk123FUAcjDCKAdJVvE1KPsKSzK?=
 =?us-ascii?Q?0eCX+peJyd704NAkTI7tlxJh38RO1KdyTpX6S0I7KXgfh4aVFVzUCqjgfn0u?=
 =?us-ascii?Q?aRFwHbdSwSrNUg0YdmB3UxWNeZ6gP8uYfVSUP9qLLOV4olLFn0pWk2x5l12g?=
 =?us-ascii?Q?aYpuW9APOpUOjSlt7TNJ1+Esc3AC/MPcANgJGD81DEZor0Y2BlDozCHZ5U8y?=
 =?us-ascii?Q?UxXb6BEOpR51sFV2rWbN0ZIX5HTdri/PNgbUjbrIP/8JIp1nbj1tEDPO/5Kl?=
 =?us-ascii?Q?zuvEf58DGnU/yy45CXDwN9HdxD+CPHncK4RpA81H0min225gaGRMovkQzfJq?=
 =?us-ascii?Q?sHb6oNbtBJa/NTLLAA/+yv0tKyJvbPFzdKVUNnWQ8+6vIP/d5e/7BGnYYrtV?=
 =?us-ascii?Q?UnUn2dzzBIe1tGK/U8zvC0Fs2F/6VWgbKwLCJa5K4RO41WwMUGQpqcmFYD7X?=
 =?us-ascii?Q?rEXlHIR4fyKl6zJWkM7PO7oKTnPgWPSdjlC8p2oNnEl5HiSmzNcOlXipelHS?=
 =?us-ascii?Q?KgBcHSP+pAAVFZB08zpJn3SXyJH8dyB2qRCi60c60jKNqyp1mjG3dsrzBGR6?=
 =?us-ascii?Q?vAqgS/OEPxNEaLh4Nq1zn5GXChhSVGbCKMieOkp4v9V0VmqleZdKkkHjWoKw?=
 =?us-ascii?Q?RflPM+1+2G2keaaS2Y9L3W2A51Wu7zfLGVDbcF//6YpCt/0aTiH0UhXhIU3D?=
 =?us-ascii?Q?zjsBvmnxlIT/nue0qimgcxE433Hy8ZAVF4LDP1/yIdqu0ek1OjySodziUOtM?=
 =?us-ascii?Q?k1a6DShlJK6C5PG0EHSH4c+Kmt7FciR4Lj8OxiWBdUvVlTQPzQmSkoibROZm?=
 =?us-ascii?Q?w2XJK2CpEw18lhlp2b+sH3K+ok5w8bER5GRWd2tNnjVpRFd9XnWLbPU2l66Z?=
 =?us-ascii?Q?6REHo3YvBQfCX4H4LZlFeWnv1aIYlLlfmqWg0rjALZbR0FltV7wcpcPGOgl7?=
 =?us-ascii?Q?XqWa8xutXuNewWMROSpWLTJRvtIBfwjlraKL9eJ/fUi80ehIyAVwikW7q27c?=
 =?us-ascii?Q?uoTkSOZ54Rfod5D6/+n3d1No/tiOk8ilezAOWCnHge8hQgzDs5mo1geW32EE?=
 =?us-ascii?Q?8P25S1RQupi5jGLvbkB+L4DqwLdF9q96pTpvRqySGnjVJdJ5nEGBSEnCS48/?=
 =?us-ascii?Q?t5/nl/yUBKQdkyxzFRMnAaeW/oGtB6CwCJrQlPk7lwf3DhlSmdhrB1LceZXq?=
 =?us-ascii?Q?P2r8vEnasyasGOhOzXK3jU13xLDTotM+cm4cqA7Qh3Lv4WquQxzLd5idqnmT?=
 =?us-ascii?Q?sT1/V1cdWzv4Y9i5ce7Tj+ecBv3IMgN34L7UrOLMEJcBTg8utshLgMT7jK0p?=
 =?us-ascii?Q?SSyPOwqfHRfjXHqKCZlHfeVX88/un4nc9ZqlKi5ZCozkXVi5Dc4IsyzmIdIc?=
 =?us-ascii?Q?zDseqDvvyiOJsj4aDN6OO+c5twyNBFNCsbI5tTA4jsmOF07YFj8LWJvCX74h?=
 =?us-ascii?Q?JTr+WM56+JSWIHBTimN8itrCuy0QCo3GGDCxSpDKrmlAnQSvK2sBConjCrSR?=
 =?us-ascii?Q?lm/Y1Dl5+YjHguni+9yW3EsJpddnLJbF/rsRmkDy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbc2dce-0aa1-44ba-155a-08dbc9f1af0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCJ6+tQOtmA+7m2FxPs+M/TFAynDdPNmjCpSkKnIrLUdprVzeXKw566ksLvC3fj9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

This allows writing the flow of arm_smmu_write_strtab_ent() around abort
and bypass domains more naturally.

Note that the core code no longer supplies NULL domains, though there is
still a flow in the driver that end up in arm_smmu_write_strtab_ent() with
NULL. A later patch will remove it.

Remove the duplicate calculation of the STE in arm_smmu_init_bypass_stes()
and remove the force parameter. arm_smmu_rmr_install_bypass_ste() can now
simply invoke arm_smmu_make_bypass_ste() directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++----------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6e6b1ebb5ac0ef..91e2bd1d8ed40b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1418,6 +1418,24 @@ static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
 	}
 }
 
+static void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
+{
+	memset(target, 0, sizeof(*target));
+	target->data[0] = cpu_to_le64(
+		STRTAB_STE_0_V |
+		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT));
+}
+
+static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
+{
+	memset(target, 0, sizeof(*target));
+	target->data[0] = cpu_to_le64(
+		STRTAB_STE_0_V |
+		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS));
+	target->data[1] = cpu_to_le64(
+		FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				      struct arm_smmu_ste *dst)
 {
@@ -1428,37 +1446,31 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	struct arm_smmu_domain *smmu_domain = master->domain;
 	struct arm_smmu_ste target = {};
 
-	if (smmu_domain) {
-		switch (smmu_domain->stage) {
-		case ARM_SMMU_DOMAIN_S1:
-			cd_table = &master->cd_table;
-			break;
-		case ARM_SMMU_DOMAIN_S2:
-			s2_cfg = &smmu_domain->s2_cfg;
-			break;
-		default:
-			break;
-		}
+	if (!smmu_domain) {
+		if (disable_bypass)
+			arm_smmu_make_abort_ste(&target);
+		else
+			arm_smmu_make_bypass_ste(&target);
+		arm_smmu_write_ste(smmu, sid, dst, &target);
+		return;
+	}
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_S1:
+		cd_table = &master->cd_table;
+		break;
+	case ARM_SMMU_DOMAIN_S2:
+		s2_cfg = &smmu_domain->s2_cfg;
+		break;
+	case ARM_SMMU_DOMAIN_BYPASS:
+		arm_smmu_make_bypass_ste(&target);
+		arm_smmu_write_ste(smmu, sid, dst, &target);
+		return;
 	}
 
 	/* Nuke the existing STE_0 value, as we're going to rewrite it */
 	val = STRTAB_STE_0_V;
 
-	/* Bypass/fault */
-	if (!smmu_domain || !(cd_table || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
-			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
-		else
-			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
-
-		target.data[0] = cpu_to_le64(val);
-		target.data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
-						STRTAB_STE_1_SHCFG_INCOMING));
-		target.data[2] = 0; /* Nuke the VMID */
-		arm_smmu_write_ste(smmu, sid, dst, &target);
-		return;
-	}
-
 	if (cd_table) {
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
@@ -1504,21 +1516,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 }
 
 static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
-				      unsigned int nent, bool force)
+				      unsigned int nent)
 {
 	unsigned int i;
-	u64 val = STRTAB_STE_0_V;
-
-	if (disable_bypass && !force)
-		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
-	else
-		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
 
 	for (i = 0; i < nent; ++i) {
-		strtab->data[0] = cpu_to_le64(val);
-		strtab->data[1] = cpu_to_le64(FIELD_PREP(
-			STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
-		strtab->data[2] = 0;
+		if (disable_bypass)
+			arm_smmu_make_abort_ste(strtab);
+		else
+			arm_smmu_make_bypass_ste(strtab);
 		strtab++;
 	}
 }
@@ -1546,7 +1552,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT, false);
+	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -3168,7 +3174,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 	cfg->strtab_base_cfg = reg;
 
-	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents, false);
+	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
 	return 0;
 }
 
@@ -3879,7 +3885,6 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
 	list_for_each_entry(e, &rmr_list, list) {
-		struct arm_smmu_ste *step;
 		struct iommu_iort_rmr_data *rmr;
 		int ret, i;
 
@@ -3892,8 +3897,8 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 				continue;
 			}
 
-			step = arm_smmu_get_step_for_sid(smmu, rmr->sids[i]);
-			arm_smmu_init_bypass_stes(step, 1, true);
+			arm_smmu_make_bypass_ste(
+				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
 	}
 
-- 
2.42.0

