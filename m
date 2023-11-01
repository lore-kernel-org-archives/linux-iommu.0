Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140B1C2A1
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="goLPQYJb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuEZ5rGWHYyoVjDZk52nJ8s32oB5XeWDbaTfQiVg8gc8TGDElceaL+353XEjgnfAgU1OaUtrkEb5wWOYCqIq6lucQPqTVE0MVD0Uy7VJDCgge/JetvR+VqBftN4JCT4QHM6nswl+oKj0UfJbDEUguBXztaQE0JpHPu6+slPVVpxFCmGzVXxDJVbRE5+5tSEjh7aZMQk7b1pm1hNhKuoHvXObLg03Hr5ueR8H7Fj8dECNwXdArL/4yz8KgLCRoY1Q9B1MosFrU7b9UPfoQyEnNjuyR+kRmvMiL4DdyuV8ny4hf49/uzfv/NQ/Vki7DJiF/AAoI+DMOOjaS80IbseH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15Wnk3XLtzYXlaVtr5loPK8SXjDI7/lQEnXmVNRb2mw=;
 b=M9NpWx1lIRBtBsCCTb1ML6pxVrcgv1A9+dM6ze4nOMMQyGQXlJLDon3kLHo0xECb2x0rBj5UbLDW3i+fZIhcrq88wx/WDICNMWTtyKagsIGBUyfIVwxVkOYvoZuSpfbR6/mPD9nNb0eA4gM0eGSnztqttiV6PW9hN42EyeP9EXyUUxMuagoaE8AGCmqC/u0ju/s5tKazevmC+Kqn9faASbwBbiRZPByr56M20r/6v86+ExI+Pk3B+KLhgHTf8bKA6TnN/WXe3bnoflAeQJgGw+CClNta0M55d+BQaWLTP1yhqLENWWkLX7Levm8XR8tSHNZQcQm6ZhvEuRLNIlr7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15Wnk3XLtzYXlaVtr5loPK8SXjDI7/lQEnXmVNRb2mw=;
 b=goLPQYJbWyY+uMND1nxgJo5jCti0jjznWGHfCFTgN26p5dMy9d6z/p4BcilL4K/X38zBjLAbnVzn5GveFHTGDdQyt4aAjm0BsjN//oky06tSLnQX14EiREjty66Ta39jjUNaJ7joy9vsaQPtzSX4eUqNfkTDb0GYwUvq4so9UeNyC/Iy5e2nAGfc5CRMDpnnSz9AyfDKTPLPmCqk756fGm/nBesxPVlQdveVjxob7d5Fgw9mYtcRAXs/2ul9Ug26M4nD9yv70Vkoh0UaSGu7n7xrkrFyz8aZfhOr5BR6cqkKPfilDI6/piwBa8cUvpnlPYJyrVXj6viqC37uoQekag==
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
 23:36:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 11/27] iommu/arm-smmu-v3: Lift CD programming out of the SVA notifier code
Date: Wed,  1 Nov 2023 20:36:29 -0300
Message-ID: <11-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:160::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b27628-9f81-4b14-b96c-08dbdb3369c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGEdnDSDqMcP/Vowsmy9AcjrtWCZ0RwouuNIrq8CXV9pkFS6a1lYPrvepbIZ0FzZJgA+jC9abQqomeLcBG6vLOGT0IgKIsmFWGBBaaBq3Czi1+kWjfwnZ7GHyOkRrVU9zmMiAmYP8k1NaQo2bGOb6kFn28msi6660+vuqVG0jkyoKhcHaYx60MUD8xGPp/A50pi6rj7masVaFOG3jEhHGVVodeCD0SctP+X47r34Tzt9X9h51MB9sy8+tJDIHlMb0h6FZ7Jb2u40Ac+zlB4ZDbd56rbpinbtxvqn89QYXX1VAnCXg6+b8/qNmprShzPfS32z6fo2zDnqgqD3XvhP1pLIpYxw6Aji0ljV4DKwtsFPJaO9TpLtG08JbO4DBrEFvyETfwzF8rMEefClqEGF5OzMmAQ4QC7GHWw4ESrUklWmIHphbta+VmG3TZLI0ixxTjHlQMr+gD8j8tavnw+iY7/KqYzqz0p1h/eA+9cC3wBLMS0tHFj6srPKwuhR7lOOypSJzIgyq9usiikrvI7PIqiMgq28JEAeV62hJ/Eb3ClJXFl8r574VANFlHgDWuTU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7l97IWaq8X/3KaRgHYheJkhXhnfcwPkKUzpMP6Crkejqo5/a3jHiOtT9Tk7Y?=
 =?us-ascii?Q?XEvYEdrruEqCrzx5Cb0Hv25O+KLXUU32qZiDccE9G8d59+7W6qg0ML3/46TN?=
 =?us-ascii?Q?XWPBXKwEPgo/CKfZJu6rrAoSE8JqIXRyFRYa6CdAbNIacAptR0R1XUsq9Izm?=
 =?us-ascii?Q?FLI1JerXjayvJO3vRJrD27aMtCUe/KPIaNlOG2kjL2guJwe+HOIE+UIBKMgy?=
 =?us-ascii?Q?KBFS/ib+6GDlZSc8onqomD1xU+CV70VIKJgclDyZnTM/V2rCZ8UkSDIH3p9g?=
 =?us-ascii?Q?7FZ60kQc8qEP6dznygiX73ZjonXOtlbUUoWnyQ/38HDv12sC1PmuzjFV+ePT?=
 =?us-ascii?Q?2uZ0pXszsrFaMMWlKTw4NJjuFuOcfTlUeLpWcgDQxX1gOzybljKzo3kieUh1?=
 =?us-ascii?Q?G5H1WDpTHve3TrOEbf7XJDrZXqJXBcZW+T/ijZfuvjvivlG2UOqfC+He7hIJ?=
 =?us-ascii?Q?H2+XbtayZl4Eo2I4MSdrvN3hYvBWK8qo5tQCM8+sO8XAuxoZtsm9W/U6xxvs?=
 =?us-ascii?Q?US3+dxsapKWnw6JEQp03TKrKPl6VquKzLzOcH7y0sVC/giRvHlEIzGsEVJHZ?=
 =?us-ascii?Q?TqbnZmMgOkDFF5aYXe+v4mpGtyEwQlj2Vb482SuVed3Uyk7Q4HV3ncg2Hgc/?=
 =?us-ascii?Q?tWyMMNiIxvBDjopyuh14TRNENsnkMzlJvfEd3jH6+IraJF6igO62/JLskjuk?=
 =?us-ascii?Q?FYo+veqOH6eHZBv2HXjtVu6/6wZHGO2EEUwKAg9rb9sro0YMFN0CGbOPg3Je?=
 =?us-ascii?Q?7H21MELXeC1hqM3ojU7yJ48EIXJf5r3NqNz9jvNZe6La6ePmWT7Ql3xQ9Oq4?=
 =?us-ascii?Q?Z550OYJSAzCiODQnkrRYlAjYkCHc2SAwdrKJCmrKnd/ifZKcWS+9B5mkTQjN?=
 =?us-ascii?Q?uiNfT+iIGQk9YhEt9vxTmLJ5romEXIBBGe5gZFa2bwpdcKy9gz9yHwxVcb5m?=
 =?us-ascii?Q?l8IFnTzxsQAGK1y9GHoaYdm0eTawGaX5bRfkYtQfVOcG4qzhBmdb06QJSUwl?=
 =?us-ascii?Q?PZYRT7Yn/e+KWEDd4qCcoekjFxSEXtbTtrK0bpeWYdvz3PUEiwvAx088WJ8H?=
 =?us-ascii?Q?orduPvkYa7IiXUi+GNiZvDxxvG20e8OQXCAtetvq/QGWKBHJKpdPP/c9ojhD?=
 =?us-ascii?Q?WTRa5CqEn0I2bVNfFgmqSg8xb+0oQegYTRwG2flCCm0TnlU85qaooLyQ60I0?=
 =?us-ascii?Q?Goi24ieFx/1XIgjNIs4bEworIa6MPuL35qNwoGe88+UQnK0gG6Ymm/0VU0Bc?=
 =?us-ascii?Q?1SZjAHhHvCMMRloU2SVyMJBPAhuzl6ZdUGIyPk1rYdubKt0NkCJtz++PsHas?=
 =?us-ascii?Q?HqNhULd4CE1ZVtPxq2bUg6lrw5nSZmZOTzkWiRrvqK5820pIW5E4+olo6qi3?=
 =?us-ascii?Q?YTnm7PRNh8zDSLaAeD+jquEF9g+PloVRQoAGk2ItKe2Fx+LviwS/AqWeuMYP?=
 =?us-ascii?Q?IU0URzHmh6ZRWEDk4P1mArr7xiWonohmUobde6VitiU29j6Q9D0vE/BSAPN/?=
 =?us-ascii?Q?lRgqZ3KEMoIQH9zflmQ7BGhg7QFKevN4A5ISGWtTHheo8ORRn1J6H5K+N4OU?=
 =?us-ascii?Q?VP3NBkS7AXJjOlsAA7xbdHCv4ErC7r4iU90ez+iF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b27628-9f81-4b14-b96c-08dbdb3369c6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izDaKHZb/cmrrs70G2vYur/7q8f2yJWIqlu3Mc1Bzmg0rIeqgYtelcIMYy4wqfs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

ops->set_dev_pasid()/ops->remove_dev_pasid() should work on a single CD
table entry, the one that was actually passed in to the function. The
current iterating over the master's list is a hold over from the prior
design where the CD table was part of the S1 domain.

Lift this code up and out so that we setup the CD only once for the
correct thing.

The SVA code "works" under a single configuration:
 - The RID domain is a S1 domain
 - The programmed PASID is the mm->pasid
 - Nothing changes while SVA is running (sva_enable)

Invalidation will still iterate over the S1 domain's master list. That
remains OK after this change, we may do harmless extra ATS invalidations
for PASIDs that don't need it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 55 ++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 24 ++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
 3 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 1f0940b497f3c6..29469073fc53fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -339,10 +339,8 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
-	unsigned long flags;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
-	struct arm_smmu_master *master;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -372,32 +370,9 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		struct arm_smmu_cd target;
-		struct arm_smmu_cd *cdptr;
-
-		cdptr = arm_smmu_get_cd_ptr(master, mm->pasid);
-		if (!cdptr) {
-			ret = -ENOMEM;
-			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
-				arm_smmu_clear_cd(master, mm->pasid);
-			break;
-		}
-
-		arm_smmu_make_sva_cd(&target, master, mm, cd->asid);
-		arm_smmu_write_cd_entry(master, mm->pasid, cdptr, &target);
-	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-	if (ret)
-		goto err_put_notifier;
-
 	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
 	return smmu_mn;
 
-err_put_notifier:
-	/* Frees smmu_mn */
-	mmu_notifier_put(&smmu_mn->mn);
 err_free_cd:
 	arm_smmu_free_shared_cd(cd);
 	return ERR_PTR(ret);
@@ -408,19 +383,12 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-	struct arm_smmu_master *master;
-	unsigned long flags;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head)
-		arm_smmu_clear_cd(master, mm->pasid);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
 	/*
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
@@ -435,7 +403,8 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
+			       struct arm_smmu_cd *target)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -462,6 +431,7 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	}
 
 	list_add(&bond->list, &master->bonds);
+	arm_smmu_make_sva_cd(target, master, mm, bond->smmu_mn->cd->asid);
 	return 0;
 
 err_free_bond:
@@ -624,6 +594,8 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 	struct arm_smmu_bond *bond = NULL, *t;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
+
 	mutex_lock(&sva_lock);
 	list_for_each_entry(t, &master->bonds, list) {
 		if (t->mm == mm) {
@@ -643,17 +615,26 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t id)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	int ret = 0;
 	struct mm_struct *mm = domain->mm;
+	struct arm_smmu_cd target;
 
 	if (mm->pasid != id)
 		return -EINVAL;
 
-	mutex_lock(&sva_lock);
-	ret = __arm_smmu_sva_bind(dev, mm);
-	mutex_unlock(&sva_lock);
+	if (!arm_smmu_get_cd_ptr(master, id))
+		return -ENOMEM;
 
-	return ret;
+	mutex_lock(&sva_lock);
+	ret = __arm_smmu_sva_bind(dev, mm, &target);
+	mutex_unlock(&sva_lock);
+	if (ret)
+		return ret;
+
+	/* This cannot fail since we preallocated the cdptr */
+	arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &target);
+	return 0;
 }
 
 static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4ac32bb91ebf27..e165859d0d0e51 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2601,6 +2601,30 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+int arm_smmu_set_pasid(struct arm_smmu_master *master,
+		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
+		       const struct arm_smmu_cd *cd)
+{
+	struct arm_smmu_domain *sid_smmu_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
+	struct arm_smmu_cd *cdptr;
+
+	if (!sid_smmu_domain || sid_smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -ENODEV;
+
+	cdptr = arm_smmu_get_cd_ptr(master, pasid);
+	if (!cdptr)
+		return -ENOMEM;
+	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
+	return 0;
+}
+
+void arm_smmu_remove_pasid(struct arm_smmu_master *master,
+			   struct arm_smmu_domain *smmu_domain, ioasid_t pasid)
+{
+	arm_smmu_clear_cd(master, pasid);
+}
+
 static int arm_smmu_attach_dev_ste(struct device *dev,
 				   struct arm_smmu_ste *ste)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6ed7645938a686..1c756803b7f963 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -770,6 +770,12 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     struct arm_smmu_cd *cdptr,
 			     const struct arm_smmu_cd *target);
 
+int arm_smmu_set_pasid(struct arm_smmu_master *master,
+		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
+		       const struct arm_smmu_cd *cd);
+void arm_smmu_remove_pasid(struct arm_smmu_master *master,
+			   struct arm_smmu_domain *smmu_domain, ioasid_t pasid);
+
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.42.0

