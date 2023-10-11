Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795B2510B
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNRcL1u3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzzxQDimqn3l7fDGN2+ozjWfX7VWt0yhKe4Qm38/+yrzoc01DIQPlfoKnWNP68SVdtvW8c5Qxa0BILlJpxYzPqz9/8EtP1OYDGx21zf67Eb4rrDBl7j7ihmR6JOMO/Ejc1smPgtdAlvG4rgVIqMLuiHRPg0JqbEE/yIqdSxIov3lBDIdNq/jyZZkVNpXWXGJJuaoHdLyrAMOtfdUMVliId4wnmKFGwfyvkQBxNb3gf4XGvPhw/YvoVc7AokTMX4CbSPrgMdDbnHT1wya/iYqm9Khtw96fCL9VDJ+5V8bco8bs73uWoviOHQTJ9sVte5Qe2/CrG7KlF8CyS6uA3hJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D94EJc8SXZr62gwrj9y9QIf4vGI3CS3pKi8rqZ3KjR4=;
 b=SSHEYWUtEg95GR6+GNghj84r3Z5y+Y+aOmvXiY+E61JuEjA9UzmIK8GMO18p3wlEvkA/UcsvGifHMxHtvZDol1Zeg/0aSlNRwvqUrsP0OzbkbKQC9c7zbCLfRtW6DnPcL1o+q9WBM3k77nnogdrQnjHMVnJzbIwZmVcC8+Rvtg16La2hAfZFVC7zPx4ps4E41ynMfhWbxjHu0f1zs7Mg/BO3v1XUo3K9l7Kd1p7u9RxsILea0/n7/Kvxo+fZJQlSseidkZzUX/rmX9LuImZRHEXkj3TGO6wjG4GCK/68NN5tX1FI5kCDIkqkI0Km4CjmIkF/4qBDMhQ+nl2UFPvYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D94EJc8SXZr62gwrj9y9QIf4vGI3CS3pKi8rqZ3KjR4=;
 b=PNRcL1u3dTnROQe6WDWEqxiExWjt4Bzb5m+P7D/j0QnbcGYP9Fbn7tgExisWDfXugXcwLKNBCWvtPY9fK1T2jJyQVXJ16/v5FOmhojqO+P9EiM2CrpA/7/Fmk7WmQYDhxDMcASX88CDk/PiWRgvo3jxTQIAGKlyYNOE6bmgAc9/iZbvkKT56/HSdFjh3gkkDKRSs5T8rmZKLowlFLpSydAWo8TR9bzOe00vvDFibcP3qGLQoOywvibw8dBUFqEB41ob8i+OoztRTkPhvETDQNgomr7Lj6nbul5lKGK8NVY2KPXDi3oto+XPiToehhLey2YIYbZPc9oWVXydNsJZDQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 11/27] iommu/arm-smmu-v3: Lift CD programming out of the SVA notifier code
Date: Wed, 11 Oct 2023 20:25:47 -0300
Message-ID: <11-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5978999a-eded-4b9b-1ac5-08dbcab17066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6p1fw1AeZOlWRCqOIQTSCkynuYZr5Pjg7zsEEU+UXyw/PbFf0C9fkYmM+hwT5WT5CnpkkNgtrRAMy4ULrkzxCqsEsDceFq1VAa6+JG2ns1VHbYzPHcvcSLJJS40uEaIBs2KPHnDPtBoZOcgssH7/HfUr19a5qVUz/rcA+k4ZvnHaKM7VNU8yzKcUFkV/MitOK5mUHNbcETskHhu5QSk5cDyFmc6p8ZSwdX+banjZysmPbYUsAwsKCetc0kb80/qk33PKMV3G2GsIgLR4tcaCPX2dwT1Q18lwsLpPP33lwg4QqtoIQVj6p6O/5+wSlio3v4ReTHJTmYw10h6LdVGB6Wl1tYYX1mfaFeKv1W5xFmaqJT384sqxhUm1Uh94hhqdQ3eWa0oAEnM6AZ8n85qU6R8ZAb1Zx3V3PuVYzVcYOJ39gdLG1i4CehKsi3JNSjqS1cnXDj7/B4onWsts7ZhUAKNdHFOnKV41CCfX8paz6TK2vUFhaD4csaRuUxdtcFBOBOHpyE1ee7bRRpNeKunuvZP6F9zKPFSpRlrB1ijHEEgtf6iAjF1Ww1chWihKWUGU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cFjKqesYSTr2wzkoFf5Yq5s7VcCd29wgOzJpLZPrU6z0S25VvZqt3WpXuB9O?=
 =?us-ascii?Q?tpwctw6pVfM1REBxb/J+1KJ278FPK3/ky8FMIbwTD1feHWVDec0kKg8/elTt?=
 =?us-ascii?Q?UC2Dg/jymit7XvSFK1/gkW/+f1A2y6E9ZJSJrnJAevt4pA7czQGUpCFuWou8?=
 =?us-ascii?Q?HBMhsdeJJxqgNyI89IhDMrPUDxZgXaykypKY/Pd/LYd8Y4f02XAoJeQWdz3l?=
 =?us-ascii?Q?5HsaBojxjNc25k8eg1qfkBL3XdLAHcIv90m3mXWTzKWlpsyG9idE1IUvQgwI?=
 =?us-ascii?Q?rysUpl/7Mibby86/FY7xdwUOtf4k7u8qglhg7jXM+AVoTeSY28hyLnfwLfyu?=
 =?us-ascii?Q?SvoGgQ7OA+HD0RlFKBmbP0f1L0P+UtU66USjWekidpNtiF/F2Yr3p8NlCu8e?=
 =?us-ascii?Q?gcjyfwhujKhmiVveWnYWWviWcauJ/SXz6sjqUe7ENIl/NKqZor3ywDdrbJgu?=
 =?us-ascii?Q?Eot+ZdSfFgqpVKmVEEUdkCO3CbpxA4cNSYezbBB6FZxEUieCHAKDM3B4Nx0V?=
 =?us-ascii?Q?ud9W2GBqEa7yw6t/L+KfiNiqm8P90PSKDraaKU+lewC01kRxfG40Ptjharc4?=
 =?us-ascii?Q?wBiT7hpM0gFjgsk7rxTewayg3MZL8QbLzeXr+e/SDY2BGkOBg3pzSWktLwR0?=
 =?us-ascii?Q?sYu1zmkwxhDFDkjSuStAz5u424kqRZS/2LNXu3wSvjgUs9EbRWXgaxSu/2b7?=
 =?us-ascii?Q?xy1l+djLl0OV0pAT12An+A/q+rGBE/Gw3Lm329tJa69WVhfoJ7OnS04o56a/?=
 =?us-ascii?Q?xkcyV6KxbPUJbW8mBaIV4v8vbSkkM62jenKuH4k7x0SfcXcaTxV8H0H1+YSk?=
 =?us-ascii?Q?cEZcZYYLSrOTUlnrLYmXn6Wd7aloaIUIrkMufDzMM2oRkQYG/GQEEzdTIu2t?=
 =?us-ascii?Q?OxxelfIZKkV7ZF7pUjBNKKguS37M1FLk00lH89fCsVk77Hpsso99soTb17Tc?=
 =?us-ascii?Q?dYX2/OnEFjtBJFz7uX325J8Iwl/VyXw228sgju3l7wLk+F/ym0KP2d+wtDqp?=
 =?us-ascii?Q?I2qa/HJTZFyCYGCHNtJe+9cZirk8gebuDeJS8Kz9n6zOwCmJm+D/fKtWWRjY?=
 =?us-ascii?Q?qqYSjcDXedneXqyaI3MTu//Mmv4O6SHfrMleq3xKen/9s4n3dcRq+HHF86ZO?=
 =?us-ascii?Q?Ld76ZGAsfh3DtlOy7AmIRVIFiNlU9BNQRyTCG73QA/Ddwdxo4lrpHqi6G/Cj?=
 =?us-ascii?Q?QJcXUKxtY52ky2K8AXE4FbM91zBX0Hxn70IuFLxFRoINKkDOqUN+DGgi+Ut+?=
 =?us-ascii?Q?INtz0ZI959QM1zHEid5xVZ0yQUP8UMLwkXGVJXVMa1+nETOrVDdbzlsYwKSK?=
 =?us-ascii?Q?sNy1ilVeEpDGDKemIURiCIQb5BHizkCqLBNz+hboWqM+3WZ/fgZPkNWconDN?=
 =?us-ascii?Q?BVyq3kY/3kwwLrtIVYDfmtO2MDqqj504yfuJ5C8SREFaHCSU9g6K1SCy1N9z?=
 =?us-ascii?Q?hUTht/aOREqa8qs36hH5UeSI94n9N41r5JwErBFW+QgcDjTjlbQYE/7uA8rI?=
 =?us-ascii?Q?4FPcZZen0gjx1oRBs0jw5AVjNkQDxhVTIm1VZnS6cWeVG+uRKezMe2VjsEMc?=
 =?us-ascii?Q?sI96k6VLaRww+kGbRsGmebQtP2oTVqHm3WSFeiep?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5978999a-eded-4b9b-1ac5-08dbcab17066
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPQBohYCRMgZec/4uIUnQ+ZS2AEyEXTydnlwB3vqQKG26327vD0VgrBUmJ5eazjC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

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
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 68 ++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 24 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
 3 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 73fe2919cc5f69..aeacf2fb317a72 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -341,10 +341,8 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
-	unsigned long flags;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
-	struct arm_smmu_master *master;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -374,55 +372,26 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
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
 }
 
-static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
+static struct arm_smmu_ctx_desc *
+arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-	struct arm_smmu_master *master;
-	unsigned long flags;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
-		return;
+		return cd;
 
 	list_del(&smmu_mn->list);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head)
-		arm_smmu_clear_cd(master, mm->pasid);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
 	/*
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
@@ -434,11 +403,12 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
-	arm_smmu_free_shared_cd(cd);
+	return cd;
 }
 
-static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static struct iommu_sva *__arm_smmu_sva_bind(struct device *dev,
+					     struct mm_struct *mm,
+					     struct arm_smmu_cd *target)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -456,6 +426,8 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	list_for_each_entry(bond, &master->bonds, list) {
 		if (bond->mm == mm) {
 			refcount_inc(&bond->refs);
+			arm_smmu_make_sva_cd(target, master, mm,
+					     bond->smmu_mn->cd->asid);
 			return &bond->sva;
 		}
 	}
@@ -475,6 +447,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	}
 
 	list_add(&bond->list, &master->bonds);
+	arm_smmu_make_sva_cd(target, master, mm, bond->smmu_mn->cd->asid);
 	return &bond->sva;
 
 err_free_bond:
@@ -646,9 +619,15 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 	}
 
 	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+		struct arm_smmu_ctx_desc *cd;
+
 		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		cd = arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
+		arm_smmu_free_shared_cd(cd);
 		kfree(bond);
+	} else {
+		arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
 	}
 	mutex_unlock(&sva_lock);
 }
@@ -656,20 +635,29 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t id)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	int ret = 0;
 	struct iommu_sva *handle;
 	struct mm_struct *mm = domain->mm;
+	struct arm_smmu_cd target;
 
 	if (mm->pasid != id)
 		return -EINVAL;
 
+	if (!arm_smmu_get_cd_ptr(master, id))
+		return -ENOMEM;
+
 	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
+	handle = __arm_smmu_sva_bind(dev, mm, &target);
 	if (IS_ERR(handle))
 		ret = PTR_ERR(handle);
 	mutex_unlock(&sva_lock);
+	if (ret)
+		return ret;
 
-	return ret;
+	/* This cannot fail since we preallocated the cdptr */
+	arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &target);
+	return 0;
 }
 
 static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 822df7f9309b25..88aa40e7517cd6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2576,6 +2576,30 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+int arm_smmu_set_pasid(struct arm_smmu_master *master,
+		       struct arm_smmu_domain *smmu_domain, ioasid_t id,
+		       const struct arm_smmu_cd *cd)
+{
+	struct arm_smmu_domain *old_smmu_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
+	struct arm_smmu_cd *cdptr;
+
+	if (!old_smmu_domain || old_smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -ENODEV;
+
+	cdptr = arm_smmu_get_cd_ptr(master, id);
+	if (!cdptr)
+		return -ENOMEM;
+	arm_smmu_write_cd_entry(master, id, cdptr, cd);
+	return 0;
+}
+
+void arm_smmu_remove_pasid(struct arm_smmu_master *master,
+			   struct arm_smmu_domain *smmu_domain, ioasid_t id)
+{
+	arm_smmu_clear_cd(master, id);
+}
+
 static int arm_smmu_attach_dev_ste(struct device *dev,
 				   struct arm_smmu_ste *ste)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6ed7645938a686..e41c83623ff2f2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -770,6 +770,12 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     struct arm_smmu_cd *cdptr,
 			     const struct arm_smmu_cd *target);
 
+int arm_smmu_set_pasid(struct arm_smmu_master *master,
+		       struct arm_smmu_domain *smmu_domain, ioasid_t id,
+		       const struct arm_smmu_cd *cd);
+void arm_smmu_remove_pasid(struct arm_smmu_master *master,
+			   struct arm_smmu_domain *smmu_domain, ioasid_t id);
+
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.42.0

