Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC64803
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tSUS0wqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuF4GSGiDtwthcnW611/18laojpQRcAOVP/ALizYnroJToQA5fjJJQusRB7HO819+p4d6PZqI1d3zyH+u1iqUIfXNlkRM3aTK3hg8Asv9rwexXZoNcji2eNVjbEIhRLj8/xLvbAvnSytyY1VB9VkXoqOlGSqVzXukOineLcF7D4jsIef2qyWuFi2yyjIvIfI2h2eqE4tepNpJmQMdSdPsZjaDYJsb8z8UVktAY0V6xqjsoFdj0/Y6qdUD/Dnec5nm7fiPNruwdMuL653i1W8nLVHq+YlfVSJZ/c5ZlgjLMT4Xk88oyHJf/UvM1qctz2hSbLY9ggTP7bXHlTNoyjbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFDzciuVVSdzDW6j9Dub0CZ4WR/DCHJnuYqzfd5iYjI=;
 b=fwVkPUvTmoRNqJHmfP+UpkviDjMbBo8urdVEx3A5F/zxqtVpvtmsWqqHBou6nrahexuly1uYRL5bvu8wRCsFIQbjdCKvTRlhq/voM1AgSpGq3LnWSl13DVpEv+huoQ6OmRCSfdGYpqMvQ6VhnFUXl1DrXQwjfdNaYQ2SM8fPI8aLH7xkJkh/gb5JILYFmNfoJBPgI+ZR46W1zul8ZHWyGWcHQiAQ7Uvt9e/uHbTVBJvTPMYYxm4CYJTsrVgyFiSjMgrmUfxsTV7/1CvnmTODNg5tESgIDjRBhlhF4oBwCoUe8PvFYmn8IGBuD1pgAgTYtBQCARewoJd2lIZuOga56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFDzciuVVSdzDW6j9Dub0CZ4WR/DCHJnuYqzfd5iYjI=;
 b=tSUS0wqJRiup18jQ3N2mtqx44lbo0nKdgo4VJC5CL3hhZhEBcU0S7PH3VOlWoAkJE54ZklKBzBu+KkN1pGLJwNp4OGDzjOv2b/NI8A29OSxokKJGTn4Yv/LDUz7/mIcW9iqsTfpI6dFmwHi4ywl9m8x7jilOMjzvv5jxEXUtiG4b2bytJpAhs4hBo259xErp3AXUNvVVP0bdxefStFHQIEx37i6/+E0xAxzlfMZN1sy39EMO1ho2EeU3P0qcS5ao8H68RvgFmUPPfLi1Qw74Z8lZBJ8PrKr+AqZpwUCh9/8YXNqSoNQ5MMY5VinP3ohkFHNIDC3k33gVKt9zuw6kKQ==
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
Subject: [PATCH 10/19] iommu/arm-smmu-v3: Compute the STE only once for each master
Date: Tue, 10 Oct 2023 21:33:16 -0300
Message-ID: <10-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f55f0f2-fcab-4c94-fb8e-08dbc9f1b006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Blm9hxWmYLI9Ne2qEaJmY8maJLMsYL8WgQvGPzp+veLf4ZKAaR5ooOAPvXxvcn1ltypkWQ+xxd+CrfaP/zG6EGMV7pLlVhhGjLXM4QYp2xk8AsRTKZ22GJTmtoGzJhJmU2r+yG/RVECyovgPvqEyLSpQWfta4dmODsOAt2+0FcExQTKRfm83WR4hL6LcRtnmbnPfLvet/cCh9iiBxSSO1nkxEtPC8iLUJqkbUryTTTd5f8Ai7+4LYmM5GHqdMJIb6e8FzEXyxovDG9URqa1XvfopzecGQ19T3XTLbF52gs8t0ix08IDrfEGDnreXEIB2bHNaJUODjxToYjsdTd9/4EwmiwMimou9LVHz3XWmmtLPsdnwdA8IdEljqKAp5ow3FBnqhfOg2nFph/Ofg6JZQNmuSop5MDGRQVmhzyytU3to2FN2DoVLoaDocDo36/+qszrRomybFrouRQNoPOs/7eWSBesyXJJkV4hzAa35XBNSTnl/aFsyMHNFkyvxz1SNq9qP5y8l9yV3Fs06vt5XhDReiR/2LdRrzYKieucS4ulK/CJCIU8t9AC4+o97WUU/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDoYbj4iZXtGQTp03CSZfP9u0zx8ds+p6lFyBzrxdhTrK9wirmb2X4jA8kL6?=
 =?us-ascii?Q?VWWmDiSWKBHOVgeX6VfcNnyZiBc4r5ZQ5J2+TDYYXvX/SLJZdQvcuwmEI4XE?=
 =?us-ascii?Q?OkBiJVGIjxTA+wTBS6nZviFZpb4wh2wgU/JnzHo9BSrixbyli5FHWj5qHwgN?=
 =?us-ascii?Q?/8npyj503XgnlrYKc1iO5LdXbr3oqnO7DON3Q4JJ3jcWkBp7QPXYv7Y2vs5X?=
 =?us-ascii?Q?s3SVkV93OLmiof2vwng6qaTQxOMhmUUd/AhSZMgph7EyoXesTcZuSzh7SnNq?=
 =?us-ascii?Q?HpvJAwd2+yPIgL+Vpy/QRksYQKM2Rss4FzIjj2c9NUYnn42baLjofBgkZ2nq?=
 =?us-ascii?Q?EPO+t1+7vLeUwSr7HAQ9hcen7JHyxXjxY7wgCNYNhNE6GkrR0jW+E8NWgN5a?=
 =?us-ascii?Q?IznLmQ2jJzeVdkJiOFsrNpy7nSruL1svY30B+EBW9XnGWP/5f8rW7qK0soaI?=
 =?us-ascii?Q?cZ0xGKRMutzre6sKBG+uzfFOAmj3GqCno839vpcYktGQJ4OXi6ikkmAsTG/L?=
 =?us-ascii?Q?lOKAuX/bCC7sglP+O50hnED8wsRIB1zGklMUDWwkXEqruF6BvGZ3z6VWUzPg?=
 =?us-ascii?Q?8aNJQs7eLB8BlPhKzALS8Uw0EcxvpvDsINkDS9dImKqfYNyHMs15/7WBBZTh?=
 =?us-ascii?Q?xdxlU+qLM/yZLeHRJF3jqSusWLAbazPsAvdtZYxHPfgzJ0UxvxkkSzXcUYa+?=
 =?us-ascii?Q?s4sjgowD22jfoWv9OSHR2Sep2qUlDg+i3LGYCPTKUD439ujNTkKuG1ZXJRt5?=
 =?us-ascii?Q?3cMhqQiVq6DRY5RjrOkh4RqCxpidIMVd++2jlQBKgaBlZgErSHN5/MLAdBH7?=
 =?us-ascii?Q?IfcT56cTZCV8fjK5Lxv4Dtqf5iyMEA+mm9J6oO17Stu6lfbsCdhR+jwWcX9G?=
 =?us-ascii?Q?KPdivA5JB+lJVZJ3TvsWE1JfYDXKEZf/FyySZZ7UAd+/ED7q9Py3Rxs6o7E6?=
 =?us-ascii?Q?ZdeIGagk0r61M/lGIolN8v8hQVqIK2FSX3ZR2PhtitjbWRrHc9QBDJ+Eb+j/?=
 =?us-ascii?Q?o52HSsKRvdb9SGxKX/NDHOfoDOB+jSJnsH1fUUWUQp/5rPgZaKQfqZECbCNv?=
 =?us-ascii?Q?qyNy8zXX16ZIwDqc+2fQng6OqjiaooeSBl1Ij/+X2kAEnDWVycI5cYu/Bo7B?=
 =?us-ascii?Q?Rxmf1s1WLQyC6GQKX4AyPk5gNmG5aN45BVddTnz5e4SsGBfkFjWo3RADaX9z?=
 =?us-ascii?Q?CFlSUE1hqTT+3LqKVoIEv7rm4AyCBbMEkcWmK4QGfjydDJPWa+XYhVrx76c8?=
 =?us-ascii?Q?IM6aTBI3pFV+ZLWnB+MwOnuel6ezv1Zp6R5M6LRZ9WJXo8mRhgjWQNQSOVMw?=
 =?us-ascii?Q?6P79rRjLix7t0VbY3rQkiQddVMRt5uAtGhi0VWdBKtdMr6vG0A8aTnlKRI53?=
 =?us-ascii?Q?gdKN8cnKLyNxr4X/R6cbCpivOPzj1FGr0zzZkp5o7NLNfaBI6Dtp/+u19ql3?=
 =?us-ascii?Q?RcFr3gowQtAPAm9RB3ZC1j4dadGjC9St/KmF296v9Zo1VrGVptRmeGLy7p3g?=
 =?us-ascii?Q?v/qPlm6WxyJpKe5KNITwMs+ZRC57NO7usc4j4ng0JFn0e3/iSW3SVIsHeAOS?=
 =?us-ascii?Q?xbXOlVD7hKSg5sSMwpoekQYw5SDFqASaGCdmRBjz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f55f0f2-fcab-4c94-fb8e-08dbc9f1b006
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:28.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eK638ieLxIJWG5eOlTOmFReVS18/sOEoVYfTlRnHarsCC5I02qZi7ZDYtdHw7pQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

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
index a29421f133a3c0..ce1bbdba66c48a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1511,36 +1511,6 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
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
@@ -2362,7 +2332,8 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
-static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
+static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
+					 const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
@@ -2379,7 +2350,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 		if (j < i)
 			continue;
 
-		arm_smmu_write_strtab_ent(master, sid, step);
+		arm_smmu_write_ste(smmu,sid, step, target);
 	}
 }
 
@@ -2486,6 +2457,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
+	struct arm_smmu_ste target;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!smmu_domain)
@@ -2499,7 +2471,11 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
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
@@ -2514,6 +2490,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
+	struct arm_smmu_ste target;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -2575,7 +2552,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_S1:
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
 			if (ret) {
@@ -2589,9 +2567,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

