Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F101C6A4
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+aaYUzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5mKG70XyCUjN566DLK1teRCNXRZvIPy9fE9UGK46gQJZakQjmKBsFusfOxWaFlXosybkNl+mJ7M5oq7E9A6a3Nq7qaiHAPtl+rSqCrNcnFhlynKtEmVAp3Jmm4DtQuPS9h0+59OC3qbTRuhkGvApQrIJ0JcSe+o0riPxwLclQ09edGpsbUdEelDDITlCDxvmh9jCleEO7SIE6EscNmGGpoIQxfgqFwecnflVcQyIVO18wXxPvniboG5c6nt7Ls7ecE4GBq8ik7c+//DxQRJwP9U9HRAa5OrChc3VPX4OUXhHHl2vWP5NM2QUT4V95HMiXZLdWYp7rNkpTwHfjDY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWO0pPthpukUxfaplwfL45ByubOQ4LutouKSFnvAvDY=;
 b=bJ6X0YoO3W6hkNC2MszY13AU2CLt+UwsKhXSGOc4hwPd03o953PuGuG7yQICWfbAYmlfcIczNSzXpkszt4Cg2O3R4/qPZFOosfmkg6nSeJ2/Dg7cCuWCTA6m8Cv3G46WU4nrOBNEK+eH8Fil/Be3xEKHuIdFS9v4BXM6+No3EdqTXmfsB0cNCtkPgw6MBXkYjKNYWUjTrg1JNaDmTK4QcpMo81H30Lc9JRAo4uYjg643Xqaa7Fbh8e9lQRV3+LQxBvg8OveeVqg28Ln8l3DUREDYHnargsrr+yNGcswHNR6hlfPxWkgORwYOJ3fRHEJ14uYNEkpJIuaiUSMEJzQ2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWO0pPthpukUxfaplwfL45ByubOQ4LutouKSFnvAvDY=;
 b=D+aaYUzT+Nmn69jwClX0ps8kz7R8V0OWz3CXFW1dMZiqYR+UfrWJOHcJQw5wiJvxbaoeJrdjIZ+og/oWWapBaoRlkklq/09MMgJC++B4THFRGm8tLTG9yLVdy03WGC89Op2MazeOvOivv2IVk4U/Ko2ZnaXThYdXML6GAbTzQQ2k1HmUHYL3nzp85qmEsP11yIyyavXBsPPnLeodXQPzqOSZRVqe4J3xZwzSI7cpYNDj8OM7+jlXkSmK14HDPsN8g/Co9z71zKMbf53swmkRnaXsugBZ+y7sg+piZKjkeWvT7VVxN1NZ8Br/O9GhFmhs+36Re+3+zBPcY/vKKqVeFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 26/27] iommu/arm-smmu-v3: Allow a PASID to be set when RID is IDENTITY/BLOCKED
Date: Wed,  1 Nov 2023 20:36:44 -0300
Message-ID: <26-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddab9bb-6bd3-4a4d-68bc-08dbdb3369f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHzNpPfNjsK/yooiE4nFxvn48pX7eCR22h57TCKW0oJ/UWUu+do6AhrdbIPGfj6YYEFLEA7DhC9kD+htehycFIGavqdsMviCTlZpTMAixKdg/YTklpQf9Jb7x/k73uY98t9tgOQQrNPs1CH5uia5WzQNyh7BtULqkx2k1uQBmDtNzjdlox4xMWyWlGAl0WIeE5nSOo6yrXrdPTxxbF08nCOgA8zuadEw6YSj9yrL1hO4wL6++r46ZbsxdJ7EQV2ReD6VFnXCredb4vjiAERIk2ZCNltIwprEQbqEvAW5TKcdRpJpvNWhBjDHR2SCVUnBA0pYy3p6tHT+yVIhNBdsFDyrCGi5Racf618iiDxMRPh43WOAy/Mrrx4i5aopNAO+7dG4wPUzwrogHG+8LUb0SSdU0nvJ4FBIVJ+wjHbOPaPGLSell05FgGK88Ykt/DfxuKcrqnOUBF2+CVC5Oa0vfwiwLj95zDVbV2b5XbJs0fupIDyUbrSPX1SFoLcYlp2kThOOEbn5wridZWWY9o4sHnC6aCjNUrjyFxcbyACaeC5uI4Qnn/e+0P8QfAFkKJzZU8UFsgJW1YIVQ7mWxa65uD2ok9oRYo6+NMgY6tHeWI6lsta5w9ALrCdkaS9rWIiZ3qTukG/ReQJ3FfHSgq9J/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(15650500001)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paso3IaX0e4sUC3VhqdPMgE5GtkMAE8r0vKkUDpxtLb+8uFO5WnQrza181aU?=
 =?us-ascii?Q?7ZoRVC855ENENuvGdTaWhsNhXddvQFJxsPIamx0zx+oMEF1I0IBWG8UHt1Iy?=
 =?us-ascii?Q?w6B1LBZgdVBNXwDUb0PUh4oq4jV/Jz4Ub8fqqDufgkHMeu82kzMzFdZLClQY?=
 =?us-ascii?Q?k91TdGx4BFELgn3z89X9LS4D8/zRz12iWw/w2d/i1k3ChiDzHcEwsD6GfuiM?=
 =?us-ascii?Q?moDL0CzDMyt33CIWnRX9tF8KkywtqhvCJuvqCM4MmGrSUuq2PJmmWYJKIGaf?=
 =?us-ascii?Q?VROg6TnuiUfjFnRK6y9T2U7edmnHF/8Tnb8ZesE8qLRbcJznhni8m6cw1p3C?=
 =?us-ascii?Q?+ZHk+otI0WX8ud9cRvGPBR3PKT0Qxq3J1BkQ1b178wr1QU/0iXI8+WvzLYVs?=
 =?us-ascii?Q?IVuwZw5lk2+/txgNy6mcqB98cGtNlpRzHbDJZwrIZ68l+z+zn238yezphY0e?=
 =?us-ascii?Q?o21dUNzEF8fvX+BqUJpwDgUS9kAboRW7EazfVGANlYx7Jglt2fmQmc+uv691?=
 =?us-ascii?Q?mCdirXQOlguuhLHs2/xBv3ExniVtQrYSkqD0qhuMD91eYKWzoNuP8F+hL5/q?=
 =?us-ascii?Q?S7oQmqE08ekCREyNBiWWL+XPXRoqmCm+sx/T0NBJ6rD6k8HvnQF6hBkFgr79?=
 =?us-ascii?Q?4EsrOqzEoeT0iHSdi9UXsnX/8AJykatdZ/+TLQYDamryv6ZxMJIHnYPVB+lL?=
 =?us-ascii?Q?Y4TGTjJ9hz/hky+TsmqFPBBfLkV8svpbxDjF2SoyP8mqtA39+2IYcxt3VbVw?=
 =?us-ascii?Q?RzJ111/iZTyrikJwG9Esuw1fnR9QnDg9WM1X3QCIpYw+cPTsQEpNq7FmULOl?=
 =?us-ascii?Q?OMUSstMOE3pYTYKkwsN8Ve0TTre1xELVjxi6Ae5R6TjYEEbxlIOts8/AZVOZ?=
 =?us-ascii?Q?IcQn42W5vqKHoJjvF39kHNrD/HJAPxFAZJsZsipU5eSk6eGN1xw3lqMTX8dr?=
 =?us-ascii?Q?ViuEpLd0BL5bVXIWy1pZhTohmGFG7bZp/4ThXmi68xJZ6UbhOadOYJKWagw0?=
 =?us-ascii?Q?8w+/LdgN5w/rf2fK9SdjUU8DzA0zDxTKCg/8nTWdacrE67SViim+xJZ6Ye+S?=
 =?us-ascii?Q?ZvyweIp4Zeeo2r72FbBOb2iBKA2YdiIkned3V+wCYDKPi5M5PYllQIHTy5g4?=
 =?us-ascii?Q?nNfE/tj1EonKUr8vkO3z1CksEsp2kT6Yvbh2Mzh3exDPeY5l/y4h2PhjcbuS?=
 =?us-ascii?Q?UIGOFg4eZung5By4+quZPjQAo9XC/rf148m/nRWZWg31AFUj9eV8br4P4o5m?=
 =?us-ascii?Q?VQlZ6XfP9Os/uqUA8YPiM3MWi+gJmpwPHyLtFtWzs2aICCD7Ftara9uCZjk3?=
 =?us-ascii?Q?uA9qLSpGphrVg4jInTmjQXv0/mue+Zi2759d9vTPNBlqU7PA01oJj7t9OvU3?=
 =?us-ascii?Q?Z1we74RYgvwGkA2Sewfla5iGgrTpvy/3AOwVWhwwyJzvYtthff99GnYoGV1P?=
 =?us-ascii?Q?iwsNLZPyCn76ROKS6U3MCDmOEAU1z371DZ5gKtQYfCV9avykhnG9BJIqe77m?=
 =?us-ascii?Q?WkQJv/CBTYqO1GxtFx1hFGBkDoFYGLc8pA+p2u4X9RhU1hK8sxVPNSFaaY7J?=
 =?us-ascii?Q?eENzDQhxH4/lLYNVFu/LOB9c2Ri9ahSt9ZJO7DR8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddab9bb-6bd3-4a4d-68bc-08dbdb3369f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlO5MOe+QSHv+iBlJ9LJj6g/oPr1ML/lT1F1HoKtBYQvWc05Jz1Fe/Is4e+S391S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

If the STE doesn't point to the CD table we can upgrade it by
reprogramming the STE with the appropriate S1DSS. We may also need to turn
on ATS at the same time.

Keep track if the installed STE is pointing at the cd_table and the ATS
state to trigger this path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++-
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 364ac78da16b48..0040e5cfbf9d4f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2385,6 +2385,13 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
 
+	master->cd_table.in_ste =
+		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		STRTAB_STE_0_CFG_S1_TRANS;
+	master->ste_ats_enabled =
+		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
+		STRTAB_STE_1_EATS_TRANS;
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
 		struct arm_smmu_ste *step =
@@ -2678,21 +2685,48 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static void arm_smmu_update_ste(struct arm_smmu_master *master,
+				struct iommu_domain *sid_domain,
+				bool want_ats)
+{
+	unsigned int s1dss = STRTAB_STE_1_S1DSS_TERMINATE;
+	struct arm_smmu_ste ste;
+
+	if (master->cd_table.in_ste && master->ste_ats_enabled == want_ats)
+		return;
+
+	if (sid_domain->type == IOMMU_DOMAIN_IDENTITY)
+		s1dss = STRTAB_STE_1_S1DSS_BYPASS;
+	else
+		WARN_ON(sid_domain->type != IOMMU_DOMAIN_BLOCKED);
+
+	/*
+	 * Change the STE into a cdtable one with SID IDENTITY/BLOCKED behavior
+	 * using s1dss if necessary. The cd_table is already installed then
+	 * the S1DSS is correct and this will just update the EATS. Otherwise
+	 * it installs the entire thing. This will be hitless.
+	 */
+	arm_smmu_make_cdtable_ste(&ste, master, &master->cd_table, want_ats,
+				  s1dss);
+	arm_smmu_install_ste_for_dev(master, &ste);
+}
+
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       const struct arm_smmu_cd *cd)
 {
-	struct arm_smmu_domain *sid_smmu_domain =
-		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
+	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_cd *cdptr;
 	struct attach_state state;
 	int ret;
 
-	if (smmu_domain->smmu != master->smmu)
+	if (smmu_domain->smmu != master->smmu || pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
-	if (!sid_smmu_domain || !master->cd_table.used_sid)
-		return -ENODEV;
+	if (!master->cd_table.in_ste &&
+	    sid_domain->type != IOMMU_DOMAIN_IDENTITY &&
+	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
+		return -EINVAL;
 
 	cdptr = arm_smmu_get_cd_ptr(master, pasid);
 	if (!cdptr)
@@ -2704,6 +2738,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		goto out_unlock;
 
 	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
+	arm_smmu_update_ste(master, sid_domain, state.want_ats);
 
 	arm_smmu_attach_commit(master, pasid, &state);
 
@@ -2717,6 +2752,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *smmu_domain;
 	struct iommu_domain *domain;
+	bool last_ssid = master->cd_table.used_ssids == 1;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
 	if (WARN_ON(IS_ERR(domain)) || !domain)
@@ -2730,6 +2766,17 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		arm_smmu_atc_inv_master(master, pasid);
 	arm_smmu_remove_master_domain(master, smmu_domain, pasid);
 	mutex_unlock(&master->smmu->asid_lock);
+
+	/*
+	 * When the last user of the CD table goes away downgrade the STE back
+	 * to a non-cd_table one.
+	 */
+	if (last_ssid && !master->cd_table.used_sid) {
+		struct iommu_domain *sid_domain =
+			iommu_get_domain_for_dev(master->dev);
+
+		sid_domain->ops->attach_dev(sid_domain, master->dev);
+	}
 }
 
 static void arm_smmu_attach_dev_ste(struct device *dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 96b01db47b0ea5..19628340ccd632 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -600,7 +600,8 @@ struct arm_smmu_ctx_desc_cfg {
 	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
 	unsigned int			used_ssids;
-	bool				used_sid;
+	u8				used_sid;
+	u8				in_ste;
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
@@ -708,7 +709,8 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
-	bool				ats_enabled;
+	bool				ats_enabled : 1;
+	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
-- 
2.42.0

