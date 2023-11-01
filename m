Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005611C6B2
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwv89pA9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh3sERzh7TTljorDFFv8qOlQckvHsvwzVwHxPDlX72mguJqi3qIMT16L/gOJHVaLheIe+vop0IJD4ML9rNEJuHxWTktbKWHDhsHRaW3nyxFnI34Fjn7arvPUPIz0P+KcfNtrY2wrwiltCWbj80MFZPOLZaJERQMUGXgnPawjIn9GJq06vQdeXUis000x7n3ow12xGzfCQ/54YVH0wGLFGs1F1IKEG296/tJfkBe/4S4zAhrGhxr7oRRzGwq23T/wnZ6gf5gIR77sKKtQWtAYjybcFeZtSwt7HltQZV/fzu1BKWmxo2HrcDaFRyPEQjp8R/PG/SZ5FlUmikumC/F/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5R/lXDb/txwwX7B7msB7Jo98lITct0dynjG+6Ae704=;
 b=Epxbyup4IJ6+lXZr5ZYsRNR9i42skUT3CSeX7+F3a9QTeTO2xiAnUKshMaHgjl2LAUaGj0UM3Yl5XFPdF3eptULnQoIZLKM7pgQ7h6KMwurMnOe+M+kBLnf5NOeRgJHzinY+SDyhCapZeWki4CmqPLaMg2rNK1uqKPg6PkI8ioFcyYZKyO9jHbiHKTxmPOFdVKEcX2VG77mfYR/Gm58p0Ayg6Zi5Ik5060qD9JCrCCQOUJmUhN01RVaqlRI3vvnmTpOD5QtpTsL8+RQY6cmTnCFPcDK5y/STqbNuLn9Cw6MQ+MYfwz/fTWIWtnUG6FsKU8E5DEBHHXyP8B9+nAopdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5R/lXDb/txwwX7B7msB7Jo98lITct0dynjG+6Ae704=;
 b=hwv89pA9C5a6SOqWnwhjXad6b5gXgAlDAuu9Q2tjvN/MCsqxzp93f7Qjil0oCLpvhV3UTc2v3j4y/lsJVNKc/Ih4iTEY/cn/bhgUvvLcrGiS8USl9C3PFvAI7xzYJYEt1zhgs3PVMYUbcVoZe5M5uoiSxRYFGkx4oc5LEr1XxscR2uCbvRfzS3ya2vdmYepCUb5Jm1JFA9niIdbS72q1rbBbwLJ7CFFHHoPCcLIkk1ToYMl7yiqyITS6GDyLDday9WtfZfNSNc0cYfEMVZEmMdIm9BrgTuGh0J5i+vr4gU+biUlFz7oOYvanz2FMjsylAhxrTdIDFxma/eZJ9GoGrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 21/27] iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain
Date: Wed,  1 Nov 2023 20:36:39 -0300
Message-ID: <21-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd89712-6381-45a3-52e6-08dbdb336a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vi/8AFvO2hb/uY4E/rhCkrGkRcgtnapnMm6FdBl4mFYPgB836v4BZxfj/bKqbh4xsOZVzroEs2gnOH36LJlvZIDUdIHIJAiMFx5LJRFpvkqxfATXQ6d1XvoHp17UXCfwgWDKcvzmg3NY95s7rw5ayVQfY6Zxi+hJGl3jVYVgjNJ3mRuSqXH/SR8rQQK5XP7v+orRyzcMAZPnGtDc4sswN59AuGZIpkhg3xLhmTIGUBhqhjl8PRR5H2iTxycCetfBEwNw8w1h/vdDZ8x4d2VeMz63ICGaCQTlFTCbCVU9HZPE+LC1m4aVRRoQil4r8LcdBgE/pMviELuLdoA2EQV4OLPH2Xv1te9BUBIKBoKSBkxVGk5glrDkYbnsW6r13JCEHoppoq25uDyOu/tqBAFzDFPb8eQb4/D0upijrLcVYu2T2RH3yBh4eIGwQrr6gGs+gXc/tECYksfz9cgNL/rQJRPZtRpMDOM7TTQCNWEZrcZuNvj/E/mWaiZhBCZxQp0ho6BfRBd2HyRhXwdvYUmGXEhh3q6Z0OYXgEQ1eO2YWy2zbugOiT5sws6jdSJ1VhfY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(30864003)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uaomf23sxU2R73uVucFcInrzpj9oolmUsMkKFlZotEUtt6w1mja0Fg9Rb85K?=
 =?us-ascii?Q?OgYnt1RckOQ8njzFVXwlCFOIU0Vdkmhn3AmDIEu0F1abwpsrMhH97B9NFfSj?=
 =?us-ascii?Q?12OwdE3KX+71MrKQv0kNDIHLX/pqNSKwAgFHlCMRsURFMYQ0/T5q/HFzPtXK?=
 =?us-ascii?Q?JVf46BcPN7AoLRKGnpc7Rt2xlrxay9xXTCNX3fA1nAL/JH/0BwOAG1hxzjeg?=
 =?us-ascii?Q?4HEQmpkctCwHkaJJSHJa2AKdhat8mvRn8yOmY7p1f9bUzhOV0Q5cidvckx72?=
 =?us-ascii?Q?AdFgdth1dtbfHiJlk8WJD57Q7+7RTtH48zXbF36bvHszOT4uf6DSeZsbMCAt?=
 =?us-ascii?Q?NiP4CwH6ANM8WG9lOdqAJ7VQoYH3ZnqaFCyKnD2lcoq3JRfSLJwI7vWqOEh9?=
 =?us-ascii?Q?fUlUehPW22bz58A7O2vSqc4JyghLYJibSomPSKKLRHx9mUQ3DLvGT9Tu/8f9?=
 =?us-ascii?Q?shnMTL1IdHaxZaMxUZqiYuODdgtTRE1Ldm1Vw8btePtw8xH419V4nH4KxbVF?=
 =?us-ascii?Q?57GDFpSnJWAoB2mQLreB4efwZOE/VXNOV6NSLOOWN/ElY676ViY83LitG3oR?=
 =?us-ascii?Q?MCz2zyn90Oiq6NnFEDlMAfhFJfLYr2U77y0/CpTC4EsrBl7k2QYzitbGwipG?=
 =?us-ascii?Q?mxWVR6p7naLkYjLPlJ237nvpzSav/+LYBKsfEH8YDHHBOjxaYvzM9TlJl/JU?=
 =?us-ascii?Q?Q7XcZ1M2M5BeR1DitU0eMjfKzLHI6vIjzwHh2IBFptYuvy8RDB/2qVM1z1Hz?=
 =?us-ascii?Q?6SYOJq4MZ8xBNn7l/pW7EusuvvDA5T3xNAe8izLs22a87/CP6BuprGrCaObU?=
 =?us-ascii?Q?d3DBROXv/aq5KBp4DNbIUVZ1AXlcDR1DyUfI1yFoVq2IDxEsgVEv4OZgJE8f?=
 =?us-ascii?Q?vczdA9kcPjop1cv6y2OQwmvg98BVyWtjkpemToJCab3UPU66ZKOYf+V9n5xN?=
 =?us-ascii?Q?5XTBRlIehGzu+sBgC1DWfHogQPsBpBRheM8GE3jslb41QKlJrIdAr5IMKHnk?=
 =?us-ascii?Q?8uGQuBQGM9LWB6pNRQPY2Ula2NLwaw9Y0JzUmAr6C4peqsG2t/6uBo1NPzjF?=
 =?us-ascii?Q?HmHXGoB7gYXQMG2+8agLfXfjqb4IpgGdK2n2qLhYvT5dDlxpnL2RuT5Qvt0a?=
 =?us-ascii?Q?AR95AMHZXe+VtxA0J3Rrswt8U0eKrSznJXLDFfYs95pLY3Yk/OfZQo7yoy9m?=
 =?us-ascii?Q?LQjPt4VnFjmNbJ/co67f96+ZwJfHgemkMcD/WMnQNsBs4otG9ExzA/QvHpi/?=
 =?us-ascii?Q?CQUL2q9pA8HZe53x9MJp+O9iKex+mzLntW+sreJQNw24FctJqnT7PI1VQou4?=
 =?us-ascii?Q?KT1aQHHYDGKdpr+SVGx0bHITIA+fIQnmQKKg16Ttux71r8wMJbwFuCa+W/WL?=
 =?us-ascii?Q?bTZpm0PwbDRol9S7jY/2pGw2vMWvet+szzdZL2qipKVm5QZTaVKIknPJCtjc?=
 =?us-ascii?Q?HvPzUCkxyltfTI2fH7YKvl8eXOP4USiAqad2331DCe8hxMjmVZiTVJheLdBg?=
 =?us-ascii?Q?4CyUn06iFik43mr5KbBXVqzhPofwYQfnu+f4wKIpP4Mijz3y1Wn5XkOpbck8?=
 =?us-ascii?Q?etsgobrZm4slM8metQfuPvnNcwynlQcgXH599gwe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd89712-6381-45a3-52e6-08dbdb336a21
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rGUbESyuVtVbccrAGkTrphEHNg8TeEjGBJ0B/0eVMg7cTBSQnWgvNQwZOpNs15r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

This removes all the notifier de-duplication logic in the driver and
relies on the core code to de-duplicate and allocate only one SVA domain
per mm per smmu instance. This naturally gives a 1:1 relationship between
SVA domain and mmu notifier.

Remove all of the previous mmu_notifier, bond, shared cd, and cd refcount
logic entirely.

For the purpose of organizing patches lightly remove BTM support. The
next patches will add it back in. BTM is a performance optimization so
this is bisection friendly functionally invisible change.

The bond/shared_cd/btm/asid allocator are tightly wound together and
changing them all at once would make this patch too big. The core issue is
that having a single SVA domain per-smmu instance conflicts with the
design of having a global ASID table that BTM currently needs, as we would
end up having to assign multiple SVA domains to the same ASID.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 384 ++++--------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  80 +---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 +-
 3 files changed, 100 insertions(+), 378 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 991daffbee31aa..a3b85aa5e48ce6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -13,29 +13,9 @@
 #include "../../iommu-sva.h"
 #include "../../io-pgtable-arm.h"
 
-struct arm_smmu_mmu_notifier {
-	struct mmu_notifier		mn;
-	struct arm_smmu_ctx_desc	*cd;
-	bool				cleared;
-	refcount_t			refs;
-	struct list_head		list;
-	struct arm_smmu_domain		*domain;
-};
-
-#define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
-
-struct arm_smmu_bond {
-	struct mm_struct		*mm;
-	struct arm_smmu_mmu_notifier	*smmu_mn;
-	struct list_head		list;
-};
-
-#define sva_to_bond(handle) \
-	container_of(handle, struct arm_smmu_bond, sva)
-
 static DEFINE_MUTEX(sva_lock);
 
-static void
+static void __maybe_unused
 arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_master_domain *master_domain;
@@ -58,58 +38,6 @@ arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
-/*
- * Check if the CPU ASID is available on the SMMU side. If a private context
- * descriptor is using it, try to replace it.
- */
-static struct arm_smmu_ctx_desc *
-arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
-{
-	int ret;
-	u32 new_asid;
-	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_device *smmu;
-	struct arm_smmu_domain *smmu_domain;
-
-	cd = xa_load(&arm_smmu_asid_xa, asid);
-	if (!cd)
-		return NULL;
-
-	if (cd->mm) {
-		if (WARN_ON(cd->mm != mm))
-			return ERR_PTR(-EINVAL);
-		/* All devices bound to this mm use the same cd struct. */
-		refcount_inc(&cd->refs);
-		return cd;
-	}
-
-	smmu_domain = container_of(cd, struct arm_smmu_domain, cd);
-	smmu = smmu_domain->smmu;
-
-	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	if (ret)
-		return ERR_PTR(-ENOSPC);
-	/*
-	 * Race with unmap: TLB invalidations will start targeting the new ASID,
-	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
-	 * later, so it doesn't matter.
-	 */
-	cd->asid = new_asid;
-	/*
-	 * Update ASID and invalidate CD in all associated masters. There will
-	 * be some overlap between use of both ASIDs, until we invalidate the
-	 * TLB.
-	 */
-	arm_smmu_update_s1_domain_cd_entry(smmu_domain);
-
-	/* Invalidate TLB entries previously associated with that context */
-	arm_smmu_tlb_inv_asid(smmu, asid);
-
-	xa_erase(&arm_smmu_asid_xa, asid);
-	return NULL;
-}
-
 static u64 page_size_to_cd(void)
 {
 	static_assert(PAGE_SIZE == SZ_4K || PAGE_SIZE == SZ_16K ||
@@ -123,7 +51,8 @@ static u64 page_size_to_cd(void)
 
 static void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 				 struct arm_smmu_master *master,
-				 struct mm_struct *mm, u16 asid)
+				 struct mm_struct *mm, u16 asid,
+				 bool btm_invalidation)
 {
 	u64 par;
 
@@ -144,7 +73,7 @@ static void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
 		CTXDESC_CD_0_R |
 		CTXDESC_CD_0_A |
-		CTXDESC_CD_0_ASET |
+		(btm_invalidation ? 0 : CTXDESC_CD_0_ASET) |
 		FIELD_PREP(CTXDESC_CD_0_ASID, asid));
 
 	/*
@@ -176,69 +105,6 @@ static void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 	target->data[3] = cpu_to_le64(read_sysreg(mair_el1));
 }
 
-static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
-{
-	u16 asid;
-	int err = 0;
-	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_ctx_desc *ret = NULL;
-
-	/* Don't free the mm until we release the ASID */
-	mmgrab(mm);
-
-	asid = arm64_mm_context_get(mm);
-	if (!asid) {
-		err = -ESRCH;
-		goto out_drop_mm;
-	}
-
-	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
-	if (!cd) {
-		err = -ENOMEM;
-		goto out_put_context;
-	}
-
-	refcount_set(&cd->refs, 1);
-
-	mutex_lock(&arm_smmu_asid_lock);
-	ret = arm_smmu_share_asid(mm, asid);
-	if (ret) {
-		mutex_unlock(&arm_smmu_asid_lock);
-		goto out_free_cd;
-	}
-
-	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
-	mutex_unlock(&arm_smmu_asid_lock);
-
-	if (err)
-		goto out_free_asid;
-
-	cd->asid = asid;
-	cd->mm = mm;
-
-	return cd;
-
-out_free_asid:
-	arm_smmu_free_asid(cd);
-out_free_cd:
-	kfree(cd);
-out_put_context:
-	arm64_mm_context_put(mm);
-out_drop_mm:
-	mmdrop(mm);
-	return err < 0 ? ERR_PTR(err) : ret;
-}
-
-static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
-{
-	if (arm_smmu_free_asid(cd)) {
-		/* Unpin ASID */
-		arm64_mm_context_put(cd->mm);
-		mmdrop(cd->mm);
-		kfree(cd);
-	}
-}
-
 /*
  * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
  * is used as a threshold to replace per-page TLBI commands to issue in the
@@ -253,8 +119,8 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						unsigned long start,
 						unsigned long end)
 {
-	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_domain *smmu_domain =
+		container_of(mn, struct arm_smmu_domain, mmu_notifier);
 	size_t size;
 
 	/*
@@ -271,33 +137,27 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 			size = 0;
 	}
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
+	if (smmu_domain->btm_invalidation) {
 		if (!size)
 			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
-					      smmu_mn->cd->asid);
+					      smmu_domain->cd.asid);
 		else
 			arm_smmu_tlb_inv_range_asid(start, size,
-						    smmu_mn->cd->asid,
+						    smmu_domain->cd.asid,
 						    PAGE_SIZE, false,
 						    smmu_domain);
 	}
 
-	arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_domain *smmu_domain =
+		container_of(mn, struct arm_smmu_domain, mmu_notifier);
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
-	mutex_lock(&sva_lock);
-	if (smmu_mn->cleared) {
-		mutex_unlock(&sva_lock);
-		return;
-	}
-
 	/*
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
@@ -309,24 +169,26 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		struct arm_smmu_cd target;
 		struct arm_smmu_cd *cdptr;
 
-		cdptr = arm_smmu_get_cd_ptr(master, mm->pasid);
+		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
-		arm_smmu_make_sva_cd(&target, master, NULL, smmu_mn->cd->asid);
-		arm_smmu_write_cd_entry(master, mm->pasid, cdptr, &target);
+		arm_smmu_make_sva_cd(&target, master, NULL,
+				     smmu_domain->cd.asid,
+				     smmu_domain->btm_invalidation);
+		arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
+					&target);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
-
-	smmu_mn->cleared = true;
-	mutex_unlock(&sva_lock);
+	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
 }
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 {
-	kfree(mn_to_smmu(mn));
+	struct arm_smmu_domain *smmu_domain =
+		container_of(mn, struct arm_smmu_domain, mmu_notifier);
+
+	kfree(smmu_domain);
 }
 
 static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
@@ -335,109 +197,6 @@ static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 	.free_notifier			= arm_smmu_mmu_notifier_free,
 };
 
-/* Allocate or get existing MMU notifier for this {domain, mm} pair */
-static struct arm_smmu_mmu_notifier *
-arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
-			  struct mm_struct *mm)
-{
-	int ret;
-	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_mmu_notifier *smmu_mn;
-
-	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
-		if (smmu_mn->mn.mm == mm) {
-			refcount_inc(&smmu_mn->refs);
-			return smmu_mn;
-		}
-	}
-
-	cd = arm_smmu_alloc_shared_cd(mm);
-	if (IS_ERR(cd))
-		return ERR_CAST(cd);
-
-	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
-	if (!smmu_mn) {
-		ret = -ENOMEM;
-		goto err_free_cd;
-	}
-
-	refcount_set(&smmu_mn->refs, 1);
-	smmu_mn->cd = cd;
-	smmu_mn->domain = smmu_domain;
-	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
-
-	ret = mmu_notifier_register(&smmu_mn->mn, mm);
-	if (ret) {
-		kfree(smmu_mn);
-		goto err_free_cd;
-	}
-
-	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
-	return smmu_mn;
-
-err_free_cd:
-	arm_smmu_free_shared_cd(cd);
-	return ERR_PTR(ret);
-}
-
-static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
-{
-	struct mm_struct *mm = smmu_mn->mn.mm;
-	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-
-	if (!refcount_dec_and_test(&smmu_mn->refs))
-		return;
-
-	list_del(&smmu_mn->list);
-
-	/*
-	 * If we went through clear(), we've already invalidated, and no
-	 * new TLB entry can have been formed.
-	 */
-	if (!smmu_mn->cleared) {
-		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
-	}
-
-	/* Frees smmu_mn */
-	mmu_notifier_put(&smmu_mn->mn);
-	arm_smmu_free_shared_cd(cd);
-}
-
-static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-			       struct arm_smmu_cd *target)
-{
-	int ret;
-	struct arm_smmu_bond *bond;
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct arm_smmu_domain *smmu_domain =
-		to_smmu_domain_safe(iommu_get_domain_for_dev(dev));
-
-	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
-		return -ENODEV;
-
-	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
-	if (!bond)
-		return -ENOMEM;
-
-	bond->mm = mm;
-
-	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
-	if (IS_ERR(bond->smmu_mn)) {
-		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_bond;
-	}
-
-	list_add(&bond->list, &master->bonds);
-	arm_smmu_make_sva_cd(target, master, mm, bond->smmu_mn->cd->asid);
-	return 0;
-
-err_free_bond:
-	kfree(bond);
-	return ret;
-}
-
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
 	unsigned long reg, fld;
@@ -565,11 +324,6 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 {
 	mutex_lock(&sva_lock);
-	if (!list_empty(&master->bonds)) {
-		dev_err(master->dev, "cannot disable SVA, device is bound\n");
-		mutex_unlock(&sva_lock);
-		return -EBUSY;
-	}
 	arm_smmu_master_sva_disable_iopf(master);
 	master->sva_enabled = false;
 	mutex_unlock(&sva_lock);
@@ -586,59 +340,54 @@ void arm_smmu_sva_notifier_synchronize(void)
 	mmu_notifier_synchronize();
 }
 
-void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t id)
-{
-	struct mm_struct *mm = domain->mm;
-	struct arm_smmu_bond *bond = NULL, *t;
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-
-	arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
-
-	mutex_lock(&sva_lock);
-	list_for_each_entry(t, &master->bonds, list) {
-		if (t->mm == mm) {
-			bond = t;
-			break;
-		}
-	}
-
-	if (!WARN_ON(!bond)) {
-		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		kfree(bond);
-	}
-	mutex_unlock(&sva_lock);
-}
-
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t id)
 {
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	int ret = 0;
-	struct mm_struct *mm = domain->mm;
 	struct arm_smmu_cd target;
+	int ret;
 
-	if (mm->pasid != id || !master->cd_table.used_sid)
+	/* Prevent arm_smmu_mm_release from being called while we are attaching */
+	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
 
-	if (!arm_smmu_get_cd_ptr(master, id))
-		return -ENOMEM;
+	/*
+	 * This does not need the arm_smmu_asid_lock because SVA domains never
+	 * get reassigned
+	 */
+	arm_smmu_make_sva_cd(&target, master, smmu_domain->domain.mm,
+			     smmu_domain->cd.asid,
+			     smmu_domain->btm_invalidation);
 
-	mutex_lock(&sva_lock);
-	ret = __arm_smmu_sva_bind(dev, mm, &target);
-	mutex_unlock(&sva_lock);
-	if (ret)
-		return ret;
+	ret = arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &target);
 
-	/* This cannot fail since we preallocated the cdptr */
-	arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &target);
-	return 0;
+	mmput(domain->mm);
+	return ret;
 }
 
 static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 {
-	kfree(to_smmu_domain(domain));
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	/*
+	 * Ensure the ASID is empty in the iommu cache before allowing reuse.
+	 */
+	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
+
+	/*
+	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
+	 * still be called/running at this point. We allow the ASID to be
+	 * reused, and if there is a race then it just suffers harmless
+	 * unnecessary invalidation.
+	 */
+	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+
+	/*
+	 * Actual free is defered to the SRCU callback
+	 * arm_smmu_mmu_notifier_free()
+	 */
+	mmu_notifier_put(&smmu_domain->mmu_notifier);
 }
 
 static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
@@ -652,6 +401,8 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_domain *smmu_domain;
+	u32 asid;
+	int ret;
 
 	smmu_domain = arm_smmu_domain_alloc();
 	if (!smmu_domain)
@@ -661,5 +412,22 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
 	smmu_domain->smmu = smmu;
 
+	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
+		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	if (ret)
+		goto err_free;
+
+	smmu_domain->cd.asid = asid;
+	smmu_domain->mmu_notifier.ops = &arm_smmu_mmu_notifier_ops;
+	ret = mmu_notifier_register(&smmu_domain->mmu_notifier, mm);
+	if (ret)
+		goto err_asid;
+
 	return &smmu_domain->domain;
+
+err_asid:
+	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+err_free:
+	kfree(smmu_domain);
+	return ERR_PTR(ret);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 85fc3064675931..c221ab138ebb87 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1339,22 +1339,6 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 	cd_table->cdtab = NULL;
 }
 
-bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
-{
-	bool free;
-	struct arm_smmu_ctx_desc *old_cd;
-
-	if (!cd->asid)
-		return false;
-
-	free = refcount_dec_and_test(&cd->refs);
-	if (free) {
-		old_cd = xa_erase(&arm_smmu_asid_xa, cd->asid);
-		WARN_ON(old_cd != cd);
-	}
-	return free;
-}
-
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -1980,8 +1964,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-static int __arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-				     ioasid_t ssid, unsigned long iova, size_t size)
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size)
 {
 	struct arm_smmu_master_domain *master_domain;
 	int i;
@@ -2019,15 +2003,7 @@ static int __arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 		if (!master->ats_enabled)
 			continue;
 
-		/*
-		 * Non-zero ssid means SVA is co-opting the S1 domain to issue
-		 * invalidations for SVA PASIDs.
-		 */
-		if (ssid != IOMMU_NO_PASID)
-			arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
-		else
-			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
-						&cmd);
+		arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size, &cmd);
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
@@ -2039,19 +2015,6 @@ static int __arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
-static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-				   unsigned long iova, size_t size)
-{
-	return __arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iova,
-					 size);
-}
-
-int arm_smmu_atc_inv_domain_sva(struct arm_smmu_domain *smmu_domain,
-				ioasid_t ssid, unsigned long iova, size_t size)
-{
-	return __arm_smmu_atc_inv_domain(smmu_domain, ssid, iova, size);
-}
-
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
@@ -2240,7 +2203,6 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
-	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return smmu_domain;
 }
@@ -2281,7 +2243,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		arm_smmu_free_asid(&smmu_domain->cd);
+		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2299,11 +2261,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 	u32 asid;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
-	refcount_set(&cd->refs, 1);
-
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
 	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
+	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	cd->asid	= (u16)asid;
 	mutex_unlock(&arm_smmu_asid_lock);
@@ -2715,7 +2675,10 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	struct attach_state state;
 	int ret;
 
-	if (!sid_smmu_domain || sid_smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+	if (smmu_domain->smmu != master->smmu)
+		return -EINVAL;
+
+	if (!sid_smmu_domain || !master->cd_table.used_sid)
 		return -ENODEV;
 
 	cdptr = arm_smmu_get_cd_ptr(master, pasid);
@@ -2736,9 +2699,18 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	return 0;
 }
 
-void arm_smmu_remove_pasid(struct arm_smmu_master *master,
-			   struct arm_smmu_domain *smmu_domain, ioasid_t pasid)
+static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (WARN_ON(IS_ERR(domain)) || !domain)
+		return;
+
+	smmu_domain = to_smmu_domain(domain);
+
 	mutex_lock(&arm_smmu_asid_lock);
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
@@ -3032,7 +3004,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
@@ -3214,17 +3185,6 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
-{
-	struct iommu_domain *domain;
-
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
-	if (WARN_ON(IS_ERR(domain)) || !domain)
-		return;
-
-	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
-}
-
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 48871c8ee8c88c..a229ad0adf6a49 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -587,9 +587,6 @@ struct arm_smmu_strtab_l1_desc {
 
 struct arm_smmu_ctx_desc {
 	u16				asid;
-
-	refcount_t			refs;
-	struct mm_struct		*mm;
 };
 
 struct arm_smmu_l1_ctx_desc {
@@ -713,7 +710,6 @@ struct arm_smmu_master {
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
-	struct list_head		bonds;
 	unsigned int			ssid_bits;
 };
 
@@ -742,7 +738,8 @@ struct arm_smmu_domain {
 	struct list_head		devices;
 	spinlock_t			devices_lock;
 
-	struct list_head		mmu_notifiers;
+	struct mmu_notifier		mmu_notifier;
+	bool				btm_invalidation;
 };
 
 struct arm_smmu_master_domain {
@@ -796,9 +793,8 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
-bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
-int arm_smmu_atc_inv_domain_sva(struct arm_smmu_domain *smmu_domain,
-				ioasid_t ssid, unsigned long iova, size_t size);
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
@@ -810,8 +806,6 @@ bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
 struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 					       struct mm_struct *mm);
-void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
-- 
2.42.0

