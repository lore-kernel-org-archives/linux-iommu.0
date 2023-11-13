Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DA22EE4
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xx3WpqJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vugz7C0DWupwX3zPrMFrNinUuAqWBRsrSbqAKzZnm+p+VGb2lzOdXcNSsXcvEcCcWW3a8xUwMtHNo1B58XA9m0OuOvoyX+xOXT2rYW8LWZVg0eTT+lG8d9yyyT5AoxY9AYcEe6ktuZzrbZw4tubhV0goOrOQKOZEgAnBVr2ANv4AAW8autPy4iAe1R52CZNOUC9fg6X4x8kzlTeSwPd7bK+sGtmLbJLO0AGRMQE0kGK/K5YMFzYTMXTd6E98BlIJdvlsU/fAeB+fqOA2T7InQVCBiINf0yj+i5tUzvfThgDEQCG1yMgTdRjZKHLkm3SQdiJT62RsS4RRjrbnwzAnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT+4fsyq+r3SxiC10JxAaf4gfCLeb13RDm8agkTquH8=;
 b=Xel9JSIAyLLbEuv7P9JR5E3QFlmhhkxB8UWDRy/FBG7jxAkDXdXJgg8Gr/vGdNQpCe5xtUDcAMBgBFHEK3O0zxEinl6ohHQVLJ4oopkIqdQgwWoVJOLEwyY9mNaVRCVwRBDpl8Ica85B9QuvInnm4zuB5eYbaqv8PmP5JB4Qezt/rQorsIpHAuEOH7u+5fnqj64jI2vhdsYWHV/uVTBF4cB3FVC43uoYP9HeTQgZkKXJfB4CFa2mmqUJG2vdziTmggfI+MtW/fnEJlAk4BrBhNlS+dzy15T8XE6pyJMN+jvhPxxHntVc8aOhRgrZQqX+25FmeOaor7nmnFf72DK3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT+4fsyq+r3SxiC10JxAaf4gfCLeb13RDm8agkTquH8=;
 b=Xx3WpqJBBDTZE8iCWaTftssf6nOXWtcswrXFtAB5uXKK1Lm1kOs0S5KGC9ccTN53JYCL7y1OrKbTMGDj+TnSpm/xsOwsuuWksiWtTqaBvK4DB+YeUKtUytmpMJv7DhSoz34tb0MH+bSTd/dU73opt/C3RrFixqSptigTgUgYZ/JdIXNAr7TooYl9flatQAHBk0gQblMK8v31I8jaoGTk5DCO+wN2xu1SM0S+sTjO7CC8/AoDlEn/1pzLVhmlzG2OS8hPeJCt/14UfT2SvBI1RDEVrcEYUrilZ/gtdBzQFIcMcPTokbLJcuJ0xQ6z3h92+GMAeIXvnWGIGPEBqg2uvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 07/19] iommu/arm-smmu-v3: Move the STE generation for S1 and S2 domains into functions
Date: Mon, 13 Nov 2023 13:53:14 -0400
Message-ID: <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc85848-baf9-47fe-3bce-08dbe47170c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2TE/HdGEYg4DTqKajRFFjpOhyphd5V/d/EYXm7f4EWy++dzBjEg/dHeRUZhyANtMf/Qw+087zucNj2bWbsot4rX9cjAr7xcoIxv8mXQbqVjTWa2dotBzsjuLA6UGgRv88AIWMfY287ulgN2I1asD8owlSCngg4yQCSF9BqY/fiQp+MXYtRVcBk0uyPtEKmEUHysZv0XiCRu9aKNYt3nBdsa3FRpk41HXSmKDslu9dw26rwQK24vZ21JOa9sKzoVjwj6ElVtHeFU9qQVD4QBYQnXfsdr4a56fg+oDLh5lsHO+hmoorc+mwdE9b7/8RAU0DYhrhT3H5n4scH+B29njD+k0K1+wrd+X1109iuuIhJrsldk7aZnSIw5qQJAbi6cpRCRQirYZ8oce6Da0bz0fLds2DEama+/xUKAJqoLG3O2RfXrJr6YVNJLXUvzvHu7AVfHt7IhukasGOhLLYWkcmtTqcOBiRVmYGuGkCsuRMKo58DQQV2fGVzv++9IRj8RDip8CsP1ASJF6/a2lUY0e4mltP0CDdmLFVuqJFSPKRuiJfogYfZX7Gj0vYvadIGnBB//YxMf1G4jdofadob+JYo35YGtpKA1e+Wz4NtbxwTTRD7tV6vXJEtAu0xZSJW/KUen7GohIZ8tDwo2xRYmdyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNSxWFQMWj+eHOpckW4TuaqweOMegEpbrhZBBtSzu8meJPj/kYI5JKS9bjI3?=
 =?us-ascii?Q?QXdUKjZoZTSQIrm1eBjupu6faeqzb09qUX4CTp66q9b7HZGRNqwjW4EzDMej?=
 =?us-ascii?Q?w6yPCLwd1z4s+ceqJPK/HGp/3z5+r/7KUwV2cOf5aT82DMhlwlG0VZ4rhQ47?=
 =?us-ascii?Q?lvSdMLdTqibgM4oBYMNPeIHVMSljC18aSgqa4byk8oy0YUDrQbvgxYCsUYze?=
 =?us-ascii?Q?bqqY5J1xGSpQu2aqSKPZ599FGUiOio4X+wwGbtkCf2ZNZkh9mK1WJwNCUnt/?=
 =?us-ascii?Q?dL7x0WmgvpZ6C+r1VC68ZP73qTeOncVwqzF48Zu19ny2ucmIBIyi3o03MRJM?=
 =?us-ascii?Q?S++1qgILey/V+TREuAOXtBqwDkfGpFzPYiqlV3pbsG7/YzxOdQzj+MpPhiTB?=
 =?us-ascii?Q?0bdldgUzAGslmoxlkLF+wfjV+qaPuLlMQ8tBN1M6M7cR9BWg15AO1cOuYUYy?=
 =?us-ascii?Q?uMHoM/kJs3CkxD/f0gDUIhdQM2JQkNA2sU7uGT7GECxpUl0Ogx3Xuc3LjNkg?=
 =?us-ascii?Q?qjFLF+CjgFW9atUuRGDx7SrR1Pgx0bo4X4kkKioYav3X1keEVWOt7QnOQd/L?=
 =?us-ascii?Q?zS6pHNHjPpYzw/ScVUmS7hz2F7NfvuUIndd/LH4tPMTfZ1sMuqvboER4txNV?=
 =?us-ascii?Q?woGy3FGk/zTvgBRCC85ezs4m3q5XdJnRcfuAQuAngPLSMAMfzRCs2G51tbnq?=
 =?us-ascii?Q?DuAmd0oBsnty1I6IQfmp1JK+hYD2ib+HKtAicwJWY1L0Z4o57Kphn4jKdpdc?=
 =?us-ascii?Q?8T8LeKcGP7dJ7RzwvwyTDbNMc82zl77GLeD2nWECwbAZ00+EJOoV7/PZcxoL?=
 =?us-ascii?Q?xTQAlMyAJ5lDpdwCzm703Ep88NsK6Y/7SnmgsBddOCbc1ZUaRLPwuMO2PLxj?=
 =?us-ascii?Q?i5PEQJDH0bEdD41GH29RwGnTexLMEwfERJ3qgd1aWldjt7yJjmN0jfEs1Eyv?=
 =?us-ascii?Q?PmmeRHZ+EiFlfFZBqL3TIi46Y/D8jNyUqggyViXMeY2tvkp+qMnOjLKxgv7d?=
 =?us-ascii?Q?VfvVuXOJCjPO8kr5HDN052NBs0Dg22VqtMVoQRMIOB82D1b0yTm1Iaj7zYiq?=
 =?us-ascii?Q?asPk0H3jk/AoDRfcb9iE/RwWQSmL1UtyoVqnWR0ywzbqaH672DXr2nbo8eCX?=
 =?us-ascii?Q?UOGCRi8CtJRjkBx5mWOa6teSUAaVWFh6/usU6P6SNsqTJ7lP1+Xl3if3556T?=
 =?us-ascii?Q?PdWyWyQtAqzj0lNe8YGmuRvt9DVQr0NxMtsXGzRjwfCeGdbwUvV8VlPLDhf+?=
 =?us-ascii?Q?wXK8QmcdfSM04qOTZ+CQYd7Ax5n0t3ooAt/WTuUgasV8xQxWCKPJr7HwTuNi?=
 =?us-ascii?Q?7lyxBaqSRWUHJD3xLlEsMsWJmLObX8puKm00lU9Wlmh2XCdQNAagYPH+dN4B?=
 =?us-ascii?Q?HxOSJtPyZB10vap+iR6Os0TeQvMCBD//mVmvOYridqv01qun5xa7Xxuq63Ci?=
 =?us-ascii?Q?gDdNwLWRq4fFj9AxbWQPEEY23fQ80LpS0KIQRv1AA58A0lzDnWN5nSWmGmY3?=
 =?us-ascii?Q?Tard8If0qYD+hoIL5YdphA0rKNr3hCsfm+g5JNIiu6a76I1KgO0yJXGWRJZ1?=
 =?us-ascii?Q?XWWXV9UV7lHEy0Ym1Gk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc85848-baf9-47fe-3bce-08dbe47170c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nuw+LE5D7iRtDqrvQOO2gNY92B+bsLFnSLqgCFpKkR+qpn5jm6DKrkwKMArwhdC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

This is preparation to move the STE calculation higher up in to the call
chain and remove arm_smmu_write_strtab_ent(). These new functions will be
called directly from attach_dev.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 115 +++++++++++---------
 1 file changed, 63 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fc8787db2dbc1..1c63fdebbda9d4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1463,13 +1463,70 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
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
 
@@ -1484,61 +1541,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
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

