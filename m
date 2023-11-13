Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A4224FA
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dRi0QrsZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmLLTaaaqOpxcTia5CY92ql0LRMomOGXPNyJLC6hGsNtRifzNt1n2HF6Gvow5/jIXxyF/vLdLI4Y8+5ff4jnA9z+fRjTxKJVNuAKQZ75bllArpTsCFiL1Afx6Hj4SClTPW/wmgxKPUIC3GKb8TghBGHAfb60R/mQfu8llvDFLcEDBuUqqCls2wdPl0fCuS9SWrApbxRJDSmjD0XlsD4AMaM5nALTb2D5k0CNFdHUOGu5XLoqSABWIsFrptbha8Xcm+dn+5plKP5j5b3U7KFpWtYU3+2AZtDAnJ/2EZbjve+lEriJj97i5unW9N49QpC5P0K2qB9jV5QYM6bkOYaZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWejoKw1p6HQH+Ya/3P/IhbDWW+iGk8Eqo6GvGPDlCo=;
 b=J2ztk/V3ERqqUUVC+g/C5awegrZr+St5wSF2451hVlWj4byv/pU/JJdffBVVOVW1gTtpg3Z+VVQ4N2ja0XwQYc5fdXfpFAvm7bBwKJtmh3aQudbUpCwyQMziySZVzfzzFiB9ogZtyH40H8T4YLUli9ujTDS4N2Dt5FFNOONDrDGSEhtSrK0wLxa4S++hXEycZwxuuasL3ibpK+IoUyjsZ+DugC/b5iO3Aa5qdXxJebdBy/r/2HC/YvrVqPcPhfmDaOssm5E8Zn1vfBw/8HE9hA4JVir2xXCjC7XXHHc/abcN/hnHMfIaOLFsz/bVZEUjbsJ1QvWl2cEbtNnQssG63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWejoKw1p6HQH+Ya/3P/IhbDWW+iGk8Eqo6GvGPDlCo=;
 b=dRi0QrsZzYJtLgC7arkym6pCoDSWZIaYDIX5OohqlKJw42xpw0BBqAZrFS+4tUlRxG/kXA+cCXKNimzobMtq6tu2Fu+b4/Hkvma1ZfEIKoEyl7o4gf5gFVKeANSGGXCIkyEyE5XCgi5P57z9hu2MoZyG9Tu8K5ZJpOlhJlkeMm0x+kxLkpGPZVGAlw32B7YBghyoRJaLczlJK5Tx9/8DwBL6i9GHflPxSkVJAMUifayxouqFLV4wFc66+qiYgNF7viB/wDr9x43RKr1AaR4DyFrIScMWbmoNh2ViNzCPcvsUCPZsLfzWFp4QTi9INcIwKWyxYrygZWpT+uJlBuwGqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 05/19] iommu/arm-smmu-v3: Consolidate the STE generation for abort/bypass
Date: Mon, 13 Nov 2023 13:53:12 -0400
Message-ID: <5-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: e934b737-5682-4d37-060f-08dbe4717051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bg6Z95qT+a3neEfL1uqs3nlWjbiBQF8u9HptHS4vQlmyPqaRjog+jUiFBwUwg5gLb97ZF4k2mVN2FldKRfxGH/UVaQMa3oDUuXDQV5pF70MK6L+qF7Td1pk9Gz1ORh+Sj9iYMGGx9ROFAGY3QAAcwvtLxGnNFwFdBk2wq9lgBGfLXr75UeYEJI9cLXdYPaDtu+FKoJMeoY75pygObLW2ijRJZm4boSNKvR6cQr1G9btnMcqhbxvHwYo8x0ma5vZs7Hrd/cwS+xHHuf8tOLC2kVQgW482ujQ5sNoU1Ii9IpMqPGRM9Y008n+tsio10A+nYlKcxflWQtpbXI8AI61bHwUcWgrM7MmmRg2uNXwL8U/tfZfdMWNcj1ek54fNzcp+GTQRjuYdFNI+FtNSrEducQ7q26AZ/6j+HXMkhBL8V4npnq8OkQDuBdmZmDCh38dsVy/xt10LKOEw3EZYVI3DazflIE/lW4qavu2751Z9eej05GvlqxEArOB1ezGBHC4drfydt8qIU6ZmCVjPWblHsQ9tbAbxNB2B+sMZDBB4Je3DmJh/tnChJApGquGszwelZzBlX5gwLOYauq+bVCvxvLBN6NGS5tGImflxlaYi/GU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yiEOw5K/QeKN8Me6aaT37lIzxFbesK+cje4cVM/0mSoHEbH5scMN5zBvF3QX?=
 =?us-ascii?Q?aA03iKah1V/5+COSO2tl75FQPvD7z3nPFI/gyO0O6M3IsY8xIKUtAR2izCM7?=
 =?us-ascii?Q?GptcGYuPExrE/QJ7EhHmtkoHpL7YL0haZfsakd3BRv39MLf4B8xzP3coYZiU?=
 =?us-ascii?Q?RNTkNYdT+kttXbi9GV/odX9PX81gBDxr4emR+gF2+Mp4P8AKboZS+5AzHlXo?=
 =?us-ascii?Q?hM8fwYRIDAvYsx+US/E0hppDYemBdkaBORBCmrHvQVvJ3rnB2BEmTzSFXYff?=
 =?us-ascii?Q?b3f58Hr6ckqnMTSkOFw9WLKkE3j2lohJ/nJIJvlwYIrfUa1mMPFXUlLoE3af?=
 =?us-ascii?Q?YhoAzsCDyi2vK2MqK4Cab0K1ovNXjAhSPGaWFtcRlNGKO8Lac3YXsM5KiozI?=
 =?us-ascii?Q?yyqc9VaPPhQpgbD76e5siYmykaRW607wTHFKAYT+DL2SGPC7gPLI6xUIW3K+?=
 =?us-ascii?Q?7OEx5bJ0Clq2lvopnol2fQDYMgbZiw1LCBcLMVZ+t4u0yL/WZDGCIunPrSJF?=
 =?us-ascii?Q?93H59AmUW0/B2tgP0An2RU5jpLGgmQLPAJuqgwcD7huEq8IZcYmoh16yk2db?=
 =?us-ascii?Q?+SyObvLBHEbewizoDQhb9Yri0hem1doMGvyTeqp0aXref3AfWmIROvZf0vIX?=
 =?us-ascii?Q?sfStpH35e4iz4uTVTR2gSCVK4P8oJNK50I9qRvtTy7TGC8J9dTQScjwrrH9W?=
 =?us-ascii?Q?qPFNy0ATioiJQHUjjXeGdX5un/2gBNaK16Fb53G3KhAi3z/Sx4twZyAaq8tN?=
 =?us-ascii?Q?UHEx35cySsdHE3btc9+qGvWZv57h4eZu0R+FCKs3SpgFzKR5r42WZbe6l7vV?=
 =?us-ascii?Q?lscc+KzH7CfkrtOZZhFox8b2Ezzlu0k9RnMcnEkdM8fPDrdy91r51niadUSA?=
 =?us-ascii?Q?G6/7r0v7XQyekgod0MmngdbmN8Iivi8TnLMgOQSZBUNdKZ32uJfZZy+m8mlg?=
 =?us-ascii?Q?XkRMeqSQYnd48ydZw8oKFFano7rkhIEvrtJFNPfcVeDdLRbtXuFQJtqYNC49?=
 =?us-ascii?Q?WyCvavgbtqwk4nqCp8W976RpjD2BtQXeg5cYcEvsYAvBBG+3VKt5T4NHmviU?=
 =?us-ascii?Q?pvQYsYZRvXiRyxdwtzxGbeiguQ1i9IVmHP5ciDU+e6X/6w4Z/TkNuuAFbbx3?=
 =?us-ascii?Q?ur1AiQGfJykNuLWDkcq/0Qy8pNZXryNEiXB9Fu/3wrn8DwUq7FElr7Bzt/dx?=
 =?us-ascii?Q?FOhNivg2wGuWtHsjlu4/a4uKM4eT7YGZqMeI33mxpdZs9A542uS5S1nVm4uC?=
 =?us-ascii?Q?vNvPntB5kcMOTOcwGiMlF16AuO0oBfNmWd8g7e8a2+Re3M+7N340y/iTj5Vh?=
 =?us-ascii?Q?MsV2J1qdsKQMeYFuvklBLT7HDja8nEpZwgm7peW8xWLDFT+2Bg0dA08dLGVS?=
 =?us-ascii?Q?ok8PYSZuOv/EqJehV/q1LDBQPuSWepIiu3t8RcfpaWbIcXdtkEkcQm1AdfNs?=
 =?us-ascii?Q?QO8qbqAueT4KbVM6K+N65p+9JSfub1r8pMjfEAqKP+8cftINGrPHPicHqaj0?=
 =?us-ascii?Q?SJn/keslMVby2OktXW/A6XiLI8vOmDckkkXTqqR+QojxW5QpQehokPwbB7Gu?=
 =?us-ascii?Q?cDldyDLiEQ2ta9BvZKM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e934b737-5682-4d37-060f-08dbe4717051
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJt5UltZz7MXx85CNvGLaLjopURSo9bgUqz0JGJUGjAG65lmmYSF80NV10eN9hD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

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
index 6430a8d89cb471..13cdb959ec8f58 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1443,6 +1443,24 @@ static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
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
@@ -1453,37 +1471,31 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
@@ -1529,21 +1541,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
@@ -1571,7 +1577,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT, false);
+	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -3193,7 +3199,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 	cfg->strtab_base_cfg = reg;
 
-	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents, false);
+	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
 	return 0;
 }
 
@@ -3904,7 +3910,6 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
 	list_for_each_entry(e, &rmr_list, list) {
-		struct arm_smmu_ste *step;
 		struct iommu_iort_rmr_data *rmr;
 		int ret, i;
 
@@ -3917,8 +3922,8 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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

