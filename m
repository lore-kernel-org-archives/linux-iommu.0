Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95322EEA
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biVtUFFm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC3nf9m4u9hvUFNSNmBo5SC+stZS3r8WOM+ljF4/svjkMHiE5WlwTxr4lC6E+KJP8YMdaq63UykwXQlE3z/k83f8YZF6xXWZAOkFKVdDEgvDdgNSEaXNdsnsJaL9Ry8os2OM8YneTeEYFTSOUGsFaLC5L6JCpXIk9IafrcahUL78W06P8nfzmDdAgDJokUkiqtx0MutwGGF77aNOBYfhF8iXhT2J9+JsooTaX+M6CL7B7hPWHVW6T28poHHZ2LLA5cksc+SGtPR3TsNyMzeRhYjfHmDzkCAvEcbgBqdPdMGmPbfDAWIH+TAveZ2IogRCjbZNehCJ7hOVi7FDf4oatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXEVyEMnVfxM+DkCSA6TyysfgPKOnBkWVf3smOTXNAE=;
 b=Yb3PkH35JIWVySGpHfsuh6lji+zmjovj/T5D58ZT/foJpbkef/bmnFeobWBcetSmryGErTg9Lyjr9zQsVfoKETf4EGXy098sW8aAsiBZ6vLNNriwvIi4VB9kM6HPmlCuajce9WMxWBRvzoKueK7eAmTj+6OIuN9B/Rcd/tt98fvUTVb+y1y9vFFsQRUl4GWCMTqNBsf/EbNqN3k2WmG9h94qG86DAUdfJHfSxtDAcNJrbufj0V5guJUXhq/7JNUdvh+K4iDG/IUUv8/kGS8VyrrctrytpNAbNrqrRnoNTdVmuBpp03e0MHj0FLQJ5MPP0UXumB5QjJbmDDLy3oOpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXEVyEMnVfxM+DkCSA6TyysfgPKOnBkWVf3smOTXNAE=;
 b=biVtUFFmkASj52XHJ8yBKk0gtbsng1HqnJsUmwv3Snvo+Ffp1k1bSKLyaeZ2lNNSlAwEUtp3q3c/6ajm06Vmn8DU2ch/bqtuvzm3DAmgU9J/d6d7jOLerRHpWH1V42YanVzWZiUXGimKu8BJNiOvurDmRPfYbjNsUyJpmlnPzKMUFQvGjqlvSIl0PxFe3f0bl709ahvRDcGn9eenX56NqUiZfUj09OXDVxqKn9cmELt4Er2CL5kdK+sXmpBbMJKucvgxatanHf+x6dp9cYaWhvXKb5/lQdUaFC6o3ugyouUacDrYKcMhJKfNUjLodnd6o4NJvL6htfAK1yYYWLqs2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 10/19] iommu/arm-smmu-v3: Compute the STE only once for each master
Date: Mon, 13 Nov 2023 13:53:17 -0400
Message-ID: <10-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7effd7-752d-48c3-5cb5-08dbe471716a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mc29dv/mi7lgIiUGxBNwhXSad4bpOhEH9b5ASdy+mv2b+36D4P8QnM4GCkwSFe5pdNeFOPQ+GBYPTDyaeWxWt0GIkNjDU/IBhUhZxE9o53nHyHouJfU1ZEkmwsoz3QKZW4pKSWunsBc6pTyFPRDmCfkBADdJTWcjtzqdkWjApCnocBMreu5jcEQlx9RhzMGpKx1UyWspGeL0jX7atO8vWzEYpd01woO+A7mUNQ0Ckezya2uYpzX7CPs7dYcl80Sz1uDpc6th9AIGshhDVx+Y7yLUD5fpFx229idko8BbkbKSezyHqxiSXZUnLmk2o7NoiIJt37PQ07f/1P9aTd4mBjpHBI8Hf1bFzxwGz9Z3i7hdo1zYFJWA2prDYVb06ZGlCNKHRsmTXb8u9wD/yRzuzeTXItl3nQiHeL0l1NcawgIy3AsbtNzeHJb1JfMYTlb19/1dmhAHXeYrIuySCtM7AWTCcHVm5oELEaDWMNl6PPLVIqTyCb1vKnfYr8L1L9Oi2tb9bvPr6sikfUUOu9tsErvFaMbABj9Khx/Yg/e+6n3R1oJMeCYfRun8/bl5U3K4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nnp0hhaTCRn4oWlGkxUzX9FxDGT+thhZABLQ53VR5aI/w0e+sta8uC5sW9Du?=
 =?us-ascii?Q?g0w+4u1p37UYNJMi7E4TUJndHhGqCc1/QD6U3YJN8UySyJK/73QMzmfP8y6D?=
 =?us-ascii?Q?txDK5XFu6P4ADAVhbyepFeExihAzY14ygjrKWaa/wS2nLRxbO+65uB4erpP0?=
 =?us-ascii?Q?T4yIk+hOcagmzRYqUrdvMYxE7J3fYQLvr6inWUcblqBxwwAvKeIWNIOeki1N?=
 =?us-ascii?Q?oNhh+Hyc7dfEGR32XsHF+uuLd7AKVe2RxOIu/CPypN156DmyHPznnnN/B+nk?=
 =?us-ascii?Q?4k8VYVj1rz9a8IPPoB2PP8ci2B8sU8duumCkD7Ci1O/WqFA29puy9ZHOIDW+?=
 =?us-ascii?Q?a662oaflcv1mWU1MvUJoUBVTgZaVrhnyLhtRaESnb0mOC/noMCv/iSdFHTQO?=
 =?us-ascii?Q?vl7YUJ5unYnrd0BsW3dJyAXqSfYESTMLt0719qpGu70eKBq6aH42iEwjNgRU?=
 =?us-ascii?Q?fXIlpNOPOeFW82HGfYk6rkYsaZySXPbYcKC3OHoyKVFo13P8zSISxxaeotvz?=
 =?us-ascii?Q?UTr9pNMCfhv1RY5CGqDL/jQ0sxHC0JnSB3ojqE1jMPjBRrYcIMWXOGclltYb?=
 =?us-ascii?Q?LBuh2hxUaU30AipMtLm280f6K+bAoMVLjFz7SZ0hznFsbZ0BS+frv/XXe7nh?=
 =?us-ascii?Q?pTrvNvyI+vcqzc46WCM8f3eWOKzXtOKzDRpvij2pBYCxZ/AGt5HC/ZuwGHRl?=
 =?us-ascii?Q?hFsPHDu8dZmM+vq6PvGgz3rrDsK42MxS1/6tbmkOdxTQRtnK05uEYbBRwG0o?=
 =?us-ascii?Q?3rKe//VLH6xTCuAc2QG+XlVp6hGkvHTTcp459rQcZNA5e3wBzrN5HASEUUbQ?=
 =?us-ascii?Q?Y6C3/B7mgAtsKt8Z7SVXmTyRe0HJv00GzPT4Xhykf3EQ5zFvENOOKX+Dzj4X?=
 =?us-ascii?Q?ZpPpd/Rlsu4dcoWEUQVgnRCEfVqU6kN9D56nonL9h4LcsQABNKVFdqorh5L+?=
 =?us-ascii?Q?xCxXQA0hB8zsLhIjRrEK1y4BYgOKJ7QZWyIRlHKcffqWc/TMXwxFvoxPeWPM?=
 =?us-ascii?Q?gBtvxYtBH5n7JOcvBB5gh4rABc5GFl2uKSkjMz486TvPB9wpeipBtKKc2+hL?=
 =?us-ascii?Q?crrUiMvjZzj4vd9JOhyCspIRgJBHpHxiMgDnJMCmIizGTIcBhVh5RsDDwOiq?=
 =?us-ascii?Q?S3H8SZGU502ef59q8vereumWGbIdV+F+zxpRTg3EBf+bbe/amCfcqr3a3J7z?=
 =?us-ascii?Q?gYZg7BwyheY77D1UfnilhQB77KRwoT5tCGk4kRNCJY6OPgMJBlGcSw+ZVw0v?=
 =?us-ascii?Q?DVjIZ3CKmH67vRi2ogDS0F7U9fHwQk8+W3xOl+zZFvYLCQ5fjW2RzZtcwz3v?=
 =?us-ascii?Q?4ir5i/+glpHTv+fEayfSyybPr321n67ZK9wtw0sqXXz1Sazpb3qqP5lCdiNm?=
 =?us-ascii?Q?fter7qn5igme1BPikWktyb9lEeJmbg/PA48rrHbG9S7WFgYxcDOykv5XgHGO?=
 =?us-ascii?Q?ESJ/sbpxgrwfvA3Pg876RJz+0fKIsKOjlPLp1eJVJp47/yWbzEMgizqQIFQ3?=
 =?us-ascii?Q?go2F6dTmigMQInjf/UDPH8WEul0VUWthWGMYcWR/JOpYZeK4LtlqXyYuVjR5?=
 =?us-ascii?Q?SENq9wXft+2OKZsQVIE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7effd7-752d-48c3-5cb5-08dbe471716a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:28.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1blB0JoHkFRaW5M9DdZ82N5jr7sTlvjMEcnsc6Q4wzkjW2w891lU+g+5+1OXQqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Currently arm_smmu_install_ste_for_dev() iterates over every SID and
computes from scratch an identical STE. Every SID should have the same STE
contents. Turn this inside out so that the STE is supplied by the caller
and arm_smmu_install_ste_for_dev() simply installs it to every SID.

This is possible now that the STE generation does not inform what sequence
should be used to program it.

This allows splitting the STE calculation up according to the call site,
which following patches will make use of, and removes the confusing NULL
domain special case that only supported arm_smmu_detach_dev().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 ++++++++-------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b11dc03ee16880..4b157c2ddf9a80 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1536,36 +1536,6 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 				      STRTAB_STE_3_S2TTB_MASK);
 }
 
-static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
-				      struct arm_smmu_ste *dst)
-{
-	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_domain *smmu_domain = master->domain;
-	struct arm_smmu_ste target = {};
-
-	if (!smmu_domain) {
-		if (disable_bypass)
-			arm_smmu_make_abort_ste(&target);
-		else
-			arm_smmu_make_bypass_ste(&target);
-		arm_smmu_write_ste(smmu, sid, dst, &target);
-		return;
-	}
-
-	switch (smmu_domain->stage) {
-	case ARM_SMMU_DOMAIN_S1:
-		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
-		break;
-	case ARM_SMMU_DOMAIN_S2:
-		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
-		break;
-	case ARM_SMMU_DOMAIN_BYPASS:
-		arm_smmu_make_bypass_ste(&target);
-		break;
-	}
-	arm_smmu_write_ste(smmu, sid, dst, &target);
-}
-
 static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
 				      unsigned int nent)
 {
@@ -2387,7 +2357,8 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
-static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
+static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
+					 const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
@@ -2404,7 +2375,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 		if (j < i)
 			continue;
 
-		arm_smmu_write_strtab_ent(master, sid, step);
+		arm_smmu_write_ste(smmu, sid, step, target);
 	}
 }
 
@@ -2511,6 +2482,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
+	struct arm_smmu_ste target;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!smmu_domain)
@@ -2524,7 +2496,11 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
-	arm_smmu_install_ste_for_dev(master);
+	if (disable_bypass)
+		arm_smmu_make_abort_ste(&target);
+	else
+		arm_smmu_make_bypass_ste(&target);
+	arm_smmu_install_ste_for_dev(master, &target);
 	/*
 	 * Clearing the CD entry isn't strictly required to detach the domain
 	 * since the table is uninstalled anyway, but it helps avoid confusion
@@ -2539,6 +2515,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
+	struct arm_smmu_ste target;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -2600,7 +2577,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_S1:
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
 			if (ret) {
@@ -2614,9 +2592,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			master->domain = NULL;
 			goto out_list_del;
 		}
-	}
 
-	arm_smmu_install_ste_for_dev(master);
+		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
+		break;
+	case ARM_SMMU_DOMAIN_S2:
+		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
+		break;
+	case ARM_SMMU_DOMAIN_BYPASS:
+		arm_smmu_make_bypass_ste(&target);
+		break;
+	}
+	arm_smmu_install_ste_for_dev(master, &target);
 
 	arm_smmu_enable_ats(master);
 	goto out_unlock;
-- 
2.42.0

