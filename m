Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355753F4C3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1jSlhov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGlKbicNEaVb7kg4pyVyS5tD4T0iMsEWtad2i6MbqvH3drXlBkSZx9Er/1BzG2MShzmZPZJ+S+wdmdlnooOAjznuiMHWsl4HvcCJ4ZJz5v0N1I2Z6XuJHKcxUsGb7CYeVJI0oWrWiB5ZklkWC/Ej0FSRhhvJZWIjSWOgOZRXCZQPLjm3jg80itKcD2HZt5yMYMOsAEnq8E+aGNpg6xpkiEPLDp8jKOKSKZCCFpTwrsWzrEqSrRz/lylEys3o5DOamDJSlx78isGUtC5QDNoulCoVkwY7Fiba0NsCEZhiKAYGd+g+YaO1rHglDUywHcxBZmJJ4Ub9y/dDE2LKfxzsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JntWiZKH6/dfNpdcMV+K1QVQcHia3rlIoXaLKXGU9mg=;
 b=QDHDtjC56KF9LL8SPTgG5ESlzfPXS3oTHtmN+cbn+/oxfX52fKB/mtgsgvBtDsDvdVLWyWARlg5EmsLdXjTw9dH0E3lyyVOWK3+6TR/U1XK8r6PHP1qvPy0tTjxHmqq9xaudroBRTNK5IEhRm1gdEq4rG1qF+N8U/C4COi9blP4uYwscJsvv5157o1C/h8JbB114/r0yyDwLfX71J4+AYgLIDa4BS4y6fN0ldoxM1dyBVJdkGyFO0J8+C3hqrXn0GexBrxlArj/uB/d7wq6wcCMHU8+zGelNjOoAj8Fq/s7wJvyE8+U8YyAyRVSePdMUMvBOdGcsJJy/Mi9QZzPCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JntWiZKH6/dfNpdcMV+K1QVQcHia3rlIoXaLKXGU9mg=;
 b=X1jSlhovH4avvaekQfgIYq0q3/0bZxEaqko6/N05+YIOMxs3ANJmFc80jSQdXQN7LNZj4TTNZft7EO9Y+MvhSNeOrrWJSHYldNJt8/whKyYdk+kYeei6bWRlQl0ZXEfys1hD2OI2QloZtxxCGw6zmGv9vCisGcG3q0IpiR3K36dU5rETJWdJx+uzoP+mOgr3GJRyKY0PvLWEh8B1hpTVPO//scKAYpmaF9o7VIRaPZCkpBiVBVu95axmO13rOwJUzb4V7n1feN+5EItgCtvVm/ievxrvzw3enavk3+VMCAPsl475bG/7ZTnZ4xFWyhkLmtFFQkP9c1V/hSkm8Ki7YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 2/7] iommu/arm-smmu: Convert to a global static identity domain
Date: Thu,  5 Oct 2023 15:28:13 -0300
Message-ID: <2-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b50914d-3f9b-4682-5ba3-08dbc5d0d9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6gb1QIHPPim4/9fucyF3VwqGlFSv+clmJJWWRE9pWa1E0ZO0zLHpqjn64xDFon6rhlcnkDwFHhzZUznoMS78gu02hYzzoYW5BHJUzUsqFkAWHE+YGA1jAgjQWgBTi7tUnj/8dFARDqcKr+bsR8RTcIBQC5m8mHIkPevHgTXg7yOSQ/s9iud7S4WWfy6TKdQMVd3CO7zOoZyzO0/RPOINPhKMtpGyzyKeyLjUPLJyIqxHm2H2Fn6wXAfaSBsujIoDjCh7es8W7ySMN61pEfoaidbNl0eplVyMdPiIFcgQEfdOQzDsiJa6ngbXFWEGXZOc0X+HFX78Q6dLL1JDgujYZCpfnT0wlAQI/bH4JUnohMliSqlhWV3AGa02R/BbMROvpMRKx8mdP0wuteBLHtOXmo28W4rBvd09Hujrk5T3IEnY7miNZtep36TQanY4VaiRJIWRxK5Kh51a0gSwq0ls1tX3BN2vM7/4XNDhY4es6nKodp1zrcVcxSSNIo2DPaXIicVOBw4Q/MR216V7lAhe28gJr+dIjWhFOSYu/8bAOYSQVbkdWjkWm7fkK+bWTwtrENqB3lQWxNYzcPAsfILKtvHOABybX8Jwzj87RuTYsY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MDo9rda/TGwP5wMdyP4kqREkb3w3HGDBejlW4mM3bG016R3JIB8eFubYoar0?=
 =?us-ascii?Q?EgfeuzbC1sSaKta0x7rUUrbxeGBitIfWacM7cZucplk7jIBXJkWKHiBty0QD?=
 =?us-ascii?Q?/0AzEBV1y49xb1ElA2D99jnFV//Q2x93gj+f2+85OzbQ2oRNbPrG99wIEhEY?=
 =?us-ascii?Q?TwBtrw7F2C2RT9fTDd1YLEY+ZtEbXkpgXN86Oe1h7l0o/ISAu1Db45KlytRk?=
 =?us-ascii?Q?xMXgeGtGMlHst/s90c5bTND5y1xKJQY3OIamsUd3D3YD/PUAJC6751ZI7y4g?=
 =?us-ascii?Q?BpRYv7L/m9rKEqgL6HFz9nhg14/XMDwvHZQx+mvj5mZ4jXGFdFm8phs9/0ly?=
 =?us-ascii?Q?2GuStooAUK3JASXuof+QasEJ8teEDn1kzkczoB/mkDvqCkA0TPb30365fa/M?=
 =?us-ascii?Q?bArl/mdYFFQikJiDvfVxxKOU2E+I1w9DzFZfG7QvUnlDV0AjGberJb+6/UxH?=
 =?us-ascii?Q?8xoDxyD7kXdWmsQfMXUN2tGV5QEtVeFZHuziWnry1oqvsRPWZ7XcG2XYtMwv?=
 =?us-ascii?Q?SboSxb2hmA9J2uhenuF657dp9242JQp2+ur5+XIZwz3RVh0F2BaTRbBxNcPc?=
 =?us-ascii?Q?hhrFVZbIwpgoVYTvSotKDslhZ4wf5qDRgtIUUxQrCYnGu14IaHHeblz2hEsH?=
 =?us-ascii?Q?POvNu9Ihx/iXjnS80dPf0VQ/ooS7eyh2m6wwBSPWS57Udv4UaB3186lHVNQV?=
 =?us-ascii?Q?X8TkmllBUdEtbddaImEpih/VHUb5MNwbKNzeD5M3WPopv+w41QT0P008aLXy?=
 =?us-ascii?Q?Iv/TERJ6+CBxx8R5p6v5Vevpm4EacsGS+Z+P+eYtrzQnmr0gPylPbIK/cWqm?=
 =?us-ascii?Q?Xb7vCko3A97lq/JaANQsZSnRzE+ZmwIOhS5FXF2fK5vBVkY2e21T5+OvHwO0?=
 =?us-ascii?Q?9UjtLLzQs+AlN4UOtutX+XTdYzpeY93czoLz8HAEw1AOp3TBcMuWg1/AMxkp?=
 =?us-ascii?Q?RqbOCy3eH3q9BUYhMEnZvyOWgeZnnww2HveP2wmXf89jK7x59CZkcgV6YG90?=
 =?us-ascii?Q?Ti2AhJWSmeBp/Dk20zNO48nqAvOlb/CgEsIhqP4eT5QPIll2LDe8et9J/+97?=
 =?us-ascii?Q?a8IYH8PaI9+0wjrcXw56QLYQvpkQ2fNCTIf0u5QdJ4mKMYdRNqP7NZXRDBrV?=
 =?us-ascii?Q?H75HuQ/ykCPT8ZTmQokIcaMFAOylhh+I6Ln7AEJw+wA+JFBP843vE2ks4Uk3?=
 =?us-ascii?Q?sVPiGlCmzMlX++7i+vGKg6EgVmh0+WxAa/+XvJ+2K9OxhKNbeLf27N3kwyyr?=
 =?us-ascii?Q?XZR1P62SBarjS7Ipxa8rMfmNUWqNontgXIhorCEkcdfU0341VSKnViQVZFwA?=
 =?us-ascii?Q?RIU0N/s74Md7XlDM3xB6J7OM67EapO1YAa1N5zOCgNJkdof5qlw78DiY3xX8?=
 =?us-ascii?Q?aDdfGbrvsRb9OG8i+tthZ7tz79Lg3Qkh2mfCyKBXCVKyWCHSPImNCfbLzz0M?=
 =?us-ascii?Q?ncPejBbMzTKqGqzu5Vlom2EmaUN7pwWWWTT4SJvn7LnD843Pxl/lJpZ7mcbG?=
 =?us-ascii?Q?k0LzdNGdcDQMbjx9lLB1tQYPDPwdPTwHX7JevubbNwR8u5oQeGYOnqTYN3pZ?=
 =?us-ascii?Q?M2d6qqAChzBf8LdZ5+fsmSTTaOP5R8P14pOid2GO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b50914d-3f9b-4682-5ba3-08dbc5d0d9f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:20.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N674z03NN9/LFTCObipEg7QFkV7pajOYDpunufBbT4j9cnFi3neRiG7mGfzw3dWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Create a global static identity domain with it's own
arm_smmu_attach_dev_identity() that simply calls
arm_smmu_domain_add_master() with the identity parameters.

This is done by giving the attach path for identity its own unique
implementation that simply calls arm_smmu_domain_add_master().

Remove ARM_SMMU_DOMAIN_BYPASS and all checks of IOMMU_DOMAIN_IDENTITY.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 50 ++++++++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 -
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 7f33363719f4ac..141b8d1266d808 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -624,12 +624,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
-		smmu_domain->smmu = smmu;
-		goto out_unlock;
-	}
-
 	/*
 	 * Mapping the requested stage onto what we support is surprisingly
 	 * complicated, mainly because the spec allows S1+S2 SMMUs without
@@ -825,7 +819,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	int ret, irq;
 
-	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (!smmu)
 		return;
 
 	ret = arm_smmu_rpm_get(smmu);
@@ -854,7 +848,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_IDENTITY) {
+	if (type != IOMMU_DOMAIN_UNMANAGED) {
 		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
 			return NULL;
 	}
@@ -1145,11 +1139,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/* Looks ok, so add the device to the domain */
-	arm_smmu_domain_add_master(smmu, cfg,
-				   smmu_domain->stage ==
-						   ARM_SMMU_DOMAIN_BYPASS ?
-					   S2CR_TYPE_BYPASS :
-					   S2CR_TYPE_TRANS,
+	arm_smmu_domain_add_master(smmu, cfg, S2CR_TYPE_TRANS,
 				   smmu_domain->cfg.cbndx, fwspec);
 
 	/*
@@ -1171,6 +1161,39 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
+static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu;
+	int ret;
+
+	if (!cfg)
+		return -ENODEV;
+	smmu = cfg->smmu;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return ret;
+
+	arm_smmu_domain_add_master(smmu, cfg, S2CR_TYPE_BYPASS, 0, fwspec);
+
+	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
+	pm_runtime_use_autosuspend(smmu->dev);
+	arm_smmu_rpm_put(smmu);
+	return 0;
+}
+
+static const struct iommu_domain_ops arm_smmu_identity_ops = {
+	.attach_dev = arm_smmu_attach_dev_identity,
+};
+
+static struct iommu_domain arm_smmu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &arm_smmu_identity_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -1557,6 +1580,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 }
 
 static struct iommu_ops arm_smmu_ops = {
+	.identity_domain	= &arm_smmu_identity_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec11f..836ed6799a801f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -361,7 +361,6 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
 	ARM_SMMU_DOMAIN_NESTED,
-	ARM_SMMU_DOMAIN_BYPASS,
 };
 
 struct arm_smmu_domain {
-- 
2.42.0

