Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890919BA1
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kccSg0vH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY3ytYtETBsLMARxji3j4acgm+w/Zn2xoWXsbqQkKJ6rKNsUlH/DGLPv4dNMZVwjxaI4Hz9vwtaus5z2KrslUfOwNvwYHQF/vAGmjTp288qiGdrHCv4074gYwPp6SPVslUqZn0Q9IYU6JSJzOIBMXDmTYs90sAmP2GihLswvPzPdPAgRAUDLJAxvW1ZcXu+/+fXuVZ9tI37oGlNIumRiP0eW8F+aYOYD0tajp9p7+R+bza9iVIsf/C1Dxf3PM/ZDimKyE4Zyx+r17RdI5OeEDpON/BdI48Wru2ewTwnUqjSn5KH/lwooGj9xPOQvcwMClJKbr3KUsPmbcjXhVMX/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5auoBSDs8TbwGDotDrFC4zK/PXiSIqzlxJfD6+XTIY=;
 b=Zw65uC63g7rounzLAp/GtpqXXkFutJk/X7Hh+w7/f7TIyiaq6dSpe+uDi6sWUt5M1x5lB3tDKT6cg9tOafuMx6F+wp6k37qwDaczC1rqQijotu8Lp3pW33M5KkzeP/Zvx8Az12uEkEtTwF8mm6k+KEiL3e4ob5od2j59qaNP3YQjzmsJPQ2smFXJycbbfQLRKIsi7o9xRfHz05yetbTNiKneHfvgE8uu948Ov6Y0aF3mrwS0pk3vF0vdER1cWpSq0BdjtozCovd9vTYK2TdJhQfzVeK/kChBFJr3LKK7BastZxUzu9D+uuV4Z8LuTuoNNZUi8c0X/eC5XdQOL+bcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5auoBSDs8TbwGDotDrFC4zK/PXiSIqzlxJfD6+XTIY=;
 b=kccSg0vHcYW8Sa7+GCtOR9/fVsOhJ5YfUpl5sxfHKK+UxzLC+qOyEZlT+7C1rqYAZd8mek2CMeOY8anPBQnWnS5xgXjOFxWBmSTZoo6wjs8bfYMfql3PO90dV/Gcs5zTIkXbspcE2eHmbaqV0mZVk4gGiIZekrBaMJop7+iNHzFLkfKLBL8Ddk0OiNUmGwfsIvJ5vM5z3KqLK26Pe1fbbWbPIlHOBUJD3ERUn876d7N64KtBdg/b6QH0ObmvBraFiBArrU2U4lHEcODQzsz5F6nNhJkW0NvMxn4wBKj0PfWhayfukjHrSgXEEntfHcJi1tnFo8YBNukdToydt1hzEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 23:36:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 24/27] iommu/arm-smmu-v3: Bring back SVA BTM support
Date: Wed,  1 Nov 2023 20:36:42 -0300
Message-ID: <24-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: e7795015-7ed6-4c8c-3a94-08dbdb336a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sW5Qtqq4WG+ai3xr482xyRJYJ9bgy5DQoKja5zNERKuWgTMQOYDtEJ69si7aQsa/1b+aHhCL+186kplVWysC2Rur/HaT4A+WuAqE8bzC8796vZulIhCgh2Q8bYqtbOSj5iSITC6XMrcu1VwBy3ir8uRShIugFrd3Nor4MTypRhW95B5Oc9kxO7rOS+aoM0TaS1vMf6+z1uRDv9P8Ak7DLUGK4D4jJ7IuWcZrYOonY2JIx+MkqU0T3K3NJ1Tz+XSYn+sCSeo41J/TQxPJ2G/F3DcqfmDd83o8WdtUcoKi9mrlFQemPTMS84Ly5AwCc5ZUixF1IbCTRj8KBoODTeetoM0XJd8vM9+KtyXX8g9PN8uBQrh4ftaLIvvEaxe0rWruMe5YfJ1K4o/hbOUZG5PLFFyrTjfzheq/B2hHsy4Gu3F16riduB5P+U2ffYSGDc2h42qdctAQkjoOUYk0MBunXMh9/JhbjRNZ6I8IrsBR2ao1QfESQuV2nNJNsStVHr++N8apNHKqWbBaYxeogv4DvcVH1BJ6BzGHsQqj6DP/2dJZl+UkECT5LiKDVIxw6yDj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(2906002)(86362001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(36756003)(478600001)(6486002)(6512007)(6506007)(38100700002)(6666004)(54906003)(66556008)(66476007)(107886003)(316002)(2616005)(66946007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JeYUg8gle5fGK16PbZMbLvwobL+tReGqdxIgPCI2axRus+PtHEV1eBUlvnvW?=
 =?us-ascii?Q?dY4Z7xKDLdNFAzh40uOscU/VYxAEFnngyy9wVQWLJ6pZbdhnJJ9Uwt+3FDnR?=
 =?us-ascii?Q?3yUFEy4qrTphPDAcAbyjtzm/AuwtEYFsq7FxHCVWPl2SB3t9vbaN54H9p2PM?=
 =?us-ascii?Q?ecRpqU8B7svha5F7gR70OCeFvaZFzQ5exk7Gvxh6Rx6Lb9obXG2jPhlfgWf4?=
 =?us-ascii?Q?ctURrSmgdNhKhaImJKvowu3Phk6GKzPjKlTfDiGmeTy5tnVHs/iJFTtOVvhw?=
 =?us-ascii?Q?rzDkMUzCSFQpgAc2+l2D2xU8qm121Fi2/zzTMUr2UMwl7ir5ZOs0Zee898JV?=
 =?us-ascii?Q?imF7qlToISGACId2AkJK+RKObo5gMjAJ5jh7W1HGukuFnwPVMETgGNNdF1QE?=
 =?us-ascii?Q?HlOcJlNIOZwHbr09iTCs+I7gz7D4kykUHCr2D0a7uXCUE2GSuDT7TYyAsn2a?=
 =?us-ascii?Q?57opoMt1QzSgQBOo7dFYScRNANgsN9UohoI5wYTNtSAt9A1jXC+BzKUyOk6a?=
 =?us-ascii?Q?SuhCAuMzlROJjJC9h5wp+YwgmL7Idm1JgkZmwXkwcxhS2qi5KcMkcbp6A71t?=
 =?us-ascii?Q?r3I+/TFUeGh0z5WLteJaJgdQK9yptxPJE2IOJyj0P3hFudUbdEYZFebp2ROs?=
 =?us-ascii?Q?C2g/Wb5MOXTl1iHcXTpptaWR5uFK0Vp6gVRG9IiuH7RO0terWIdHuOQFBOKJ?=
 =?us-ascii?Q?PTVNGieFdLmexJze/ikq1Vw6z5csWrpgM9l7IrYiSrzDWmewF0d9kQMtR6AH?=
 =?us-ascii?Q?tmxYrIuWTGG9pIKCe5LZfv4Km3wHDALP3JwGvNdHT83CL6NFWZGe6eU0QsCs?=
 =?us-ascii?Q?tRPW92feXuxTRuc945Dtnx7EPW9R4JZnQOebSiymTtoP0Z5oi4UROf5YzpG9?=
 =?us-ascii?Q?jrT/RcEjdvZnmJMyKnRTnv4/le/DQvcNe+AhVG+hjT30iMV1Q2suIjvSKlWu?=
 =?us-ascii?Q?29wLAAlPQWvwI5+KsVAAphgyP5JdPmrSSyFCUNxBW5PF9cOzYikyT94ost+m?=
 =?us-ascii?Q?GgdFjo5De/M69l39U6oEqLOFBIGNgmhcdcADofHmYydcTIZadxnDQTaQJ7DZ?=
 =?us-ascii?Q?9WQseVP4BeguXOjXRmPvPZmpg1NHz4EzzkMH9bZGhER1J3/GijDWjDUWwn96?=
 =?us-ascii?Q?u8byQmI8N7rNWzjO/M1NmtJixMkCzrvcGKfudOWXJKo5/Q1Kod7VAiPv1cTn?=
 =?us-ascii?Q?9KirMC5Ro8vORUZXGXygPMPV8AVh+QpzZ9pkEA465ZOvRX2vnBFEblSlEDK0?=
 =?us-ascii?Q?MrEkxgCzsAYhtewQI5qoip2YR5PUU38Qov6Irg0C0j0VxAVDtBzJ3wJ9hu5u?=
 =?us-ascii?Q?TUvUao51v3F+5tqvsU3bFHcVSjiuWy5yEbLRSIFIkxJJyCEVTdXXboSqZNpo?=
 =?us-ascii?Q?dm29R+iM5x5I6+Il497PtFIu4vbW3ik85LqqrCHwFZNXi4QuM9nZJaPz78jT?=
 =?us-ascii?Q?BJ0jWdx7Zr0F4/nQdM8GdsUnPBNhm1T8wGwc/z160bJYyw/6KoFSvKQVkzbQ?=
 =?us-ascii?Q?OyN90oKAsk61ig/+KLtLWKrDw2nKhfpcGVBJXl4pul03XHJN1uQfsQALEEDz?=
 =?us-ascii?Q?sXr5JrZCUNMkviqZWDThbZDeLtbvgptxbV4V2BAD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7795015-7ed6-4c8c-3a94-08dbdb336a8a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:48.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI9bMl4jc6RvLrssprjEMIV88bTiR8vBLm1xfYtt3OwJwjpS/8tl6WWbm1tx94xq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

BTM support is a feature where the CPU TLB invalidation can be forwarded
to the IOMMU and also invalidate the IOTLB. For this to work the CPU and
IOMMU ASID must be the same.

Retain the prior SVA design here of keeping the ASID allocator for the
IOMMU private to SMMU and force SVA domains to set an ASID that matches
the CPU ASID.

This requires changing the ASID assigned to a S1 domain if it happens to
be overlapping with the required CPU ASID. We hold on to the CPU ASID so
long as the SVA iommu_domain exists, so SVA domain conflict is not
possible.

With the asid per-smmu we no longer have a problem that two per-smmu
iommu_domain's would need to share a CPU ASID entry in the IOMMU's xarray.

Use the same ASID move algorithm for the S1 domains as before with some
streamlining around how the xarray is being used. Do not synchronize the
ASID's if BTM mode is not supported. Just leave BTM features off
everywhere.

Audit all the places that touch cd->asid and think carefully about how the
locking works with the change to the cd->asid by the move algorithm. Use
xarray internal locking during xa_alloc() instead of double locking. Add a
note that concurrent S1 invalidation doesn't fully work.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 108 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  15 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 3 files changed, 104 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index aa238d463cf808..2e6c3617cdbac5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -15,12 +15,33 @@
 
 static DEFINE_MUTEX(sva_lock);
 
-static void __maybe_unused
-arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_realloc_s1_domain_asid(struct arm_smmu_device *smmu,
+					   struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_master_domain *master_domain;
+	u32 old_asid = smmu_domain->cd.asid;
 	struct arm_smmu_cd target_cd;
 	unsigned long flags;
+	int ret;
+
+	lockdep_assert_held(&smmu->asid_lock);
+
+	/*
+	 * FIXME: The unmap and invalidation path doesn't take any locks but
+	 * this is not fully safe. Since updating the CD tables is not atomic
+	 * there is always a hole where invalidating only one ASID of two active
+	 * ASIDs during unmap will cause the IOTLB to become stale.
+	 *
+	 * This approach is to hopefully shift the racing CPUs to the new ASID
+	 * before we start programming the HW. This increases the chance that
+	 * racing IOPTE changes will pick up an invalidation for the new ASID
+	 * and we achieve eventual consistency. For the brief period where the
+	 * old ASID is still in the CD entries it will become incoherent.
+	 */
+	ret = xa_alloc(&smmu->asid_map, &smmu_domain->cd.asid, smmu_domain,
+		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices, devices_elm) {
@@ -36,6 +57,10 @@ arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 					&target_cd);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	/* Clean the ASID we are about to assign to a new translation */
+	arm_smmu_tlb_inv_asid(smmu, old_asid);
+	return 0;
 }
 
 static u64 page_size_to_cd(void)
@@ -138,12 +163,12 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 	}
 
 	if (smmu_domain->btm_invalidation) {
+		ioasid_t asid = READ_ONCE(smmu_domain->cd.asid);
+
 		if (!size)
-			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
-					      smmu_domain->cd.asid);
+			arm_smmu_tlb_inv_asid(smmu_domain->smmu, asid);
 		else
-			arm_smmu_tlb_inv_range_asid(start, size,
-						    smmu_domain->cd.asid,
+			arm_smmu_tlb_inv_range_asid(start, size, asid,
 						    PAGE_SIZE, false,
 						    smmu_domain);
 	}
@@ -172,6 +197,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
+
+		/* An SVA ASID never changes, no asid_lock required */
 		arm_smmu_make_sva_cd(&target, master, NULL,
 				     smmu_domain->cd.asid,
 				     smmu_domain->btm_invalidation);
@@ -377,6 +404,8 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 	 * unnecessary invalidation.
 	 */
 	arm_smmu_domain_free_id(smmu_domain);
+	if (smmu_domain->btm_invalidation)
+		arm64_mm_context_put(domain->mm);
 
 	/*
 	 * Actual free is defered to the SRCU callback
@@ -390,13 +419,72 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 	.free			= arm_smmu_sva_domain_free
 };
 
+static int arm_smmu_share_asid(struct arm_smmu_device *smmu,
+			       struct arm_smmu_domain *smmu_domain,
+			       struct mm_struct *mm)
+{
+	struct arm_smmu_domain *old_s1_domain;
+	int ret;
+
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
+		return xa_alloc(&smmu->asid_map, &smmu_domain->cd.asid,
+				smmu_domain,
+				XA_LIMIT(1, (1 << smmu->asid_bits) - 1),
+				GFP_KERNEL);
+
+	/* At this point the caller ensures we have a mmget() */
+	smmu_domain->cd.asid = arm64_mm_context_get(mm);
+
+	mutex_lock(&smmu->asid_lock);
+	old_s1_domain = xa_store(&smmu->asid_map, smmu_domain->cd.asid,
+				 smmu_domain, GFP_KERNEL);
+	if (xa_err(old_s1_domain)) {
+		ret = xa_err(old_s1_domain);
+		goto out_put_asid;
+	}
+
+	/*
+	 * In BTM mode the CPU ASID and the IOMMU ASID have to be the same.
+	 * Unfortunately we run separate allocators for this and the IOMMU
+	 * ASID can already have been assigned to a S1 domain. SVA domains
+	 * always align to their CPU ASIDs. In this case we change
+	 * the S1 domain's ASID, update the CD entry and flush the caches.
+	 *
+	 * This is a bit tricky, all the places writing to a S1 CD, reading the
+	 * S1 ASID, or doing xa_erase must hold the asid_lock or xa_lock to
+	 * avoid IOTLB incoherence.
+	 */
+	if (old_s1_domain) {
+		if (WARN_ON(old_s1_domain->domain.type == IOMMU_DOMAIN_SVA)) {
+			ret = -EINVAL;
+			goto out_restore_s1;
+		}
+		ret = arm_smmu_realloc_s1_domain_asid(smmu, old_s1_domain);
+		if (ret)
+			goto out_restore_s1;
+	}
+
+	smmu_domain->btm_invalidation = true;
+
+	ret = 0;
+	goto out_unlock;
+
+out_restore_s1:
+	xa_store(&smmu->asid_map, smmu_domain->cd.asid, old_s1_domain,
+		 GFP_KERNEL);
+out_put_asid:
+	arm64_mm_context_put(mm);
+out_unlock:
+	mutex_unlock(&smmu->asid_lock);
+	return ret;
+}
+
 struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 					       struct mm_struct *mm)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_domain *smmu_domain;
-	u32 asid;
 	int ret;
 
 	smmu_domain = arm_smmu_domain_alloc();
@@ -407,12 +495,10 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
 	smmu_domain->smmu = smmu;
 
-	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	ret = arm_smmu_share_asid(smmu, smmu_domain, mm);
 	if (ret)
 		goto err_free;
 
-	smmu_domain->cd.asid = asid;
 	smmu_domain->mmu_notifier.ops = &arm_smmu_mmu_notifier_ops;
 	ret = mmu_notifier_register(&smmu_domain->mmu_notifier, mm);
 	if (ret)
@@ -422,6 +508,8 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 
 err_asid:
 	arm_smmu_domain_free_id(smmu_domain);
+	if (smmu_domain->btm_invalidation)
+		arm64_mm_context_put(mm);
 err_free:
 	kfree(smmu_domain);
 	return ERR_PTR(ret);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index db5f2b92af17af..457b1fd8a9ab0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1217,6 +1217,8 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
 		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
+	lockdep_assert_held(&master->smmu->asid_lock);
+
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
@@ -2027,7 +2029,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
+		arm_smmu_tlb_inv_asid(smmu, READ_ONCE(smmu_domain->cd.asid));
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2270,17 +2272,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 				       struct arm_smmu_domain *smmu_domain)
 {
-	int ret;
-	u32 asid;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
-	/* Prevent SVA from modifying the ASID until it is written to the CD */
-	mutex_lock(&smmu->asid_lock);
-	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	cd->asid	= (u16)asid;
-	mutex_unlock(&smmu->asid_lock);
-	return ret;
+	return xa_alloc(&smmu->asid_map, &cd->asid, smmu_domain,
+			XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index efc6bc11bbb838..96b01db47b0ea5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -586,7 +586,7 @@ struct arm_smmu_strtab_l1_desc {
 };
 
 struct arm_smmu_ctx_desc {
-	u16				asid;
+	u32				asid;
 };
 
 struct arm_smmu_l1_ctx_desc {
-- 
2.42.0

