Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D13D99E
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxbT4hYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNMQFNjyIQkboQp8TBpKB++Ni615pSP0O/5f5GqxgY4gVMwWFMq9pDbSmSdmCcBrv6KB889oiRep0b7uwkeNc67pN+8aRH5g9G1G1hQTvyMDMAD0hOd9XA0ZJ9pqTl5dQ+6ytK3Z0JG99vVikQibjHP3ieoLavU1gtvb9Gc0EUWa44b8kc6cXFDt8TyQ2igHIFQN5XTU0tH0t9uLEBTx0l/dy18bbNaubezAqdRbHru0s7kgZPtwa2iaaGhReUSLU/p2oi1YjAY9+sBKxbo89lElUeTBmd02XOfcc8nKsQiv/CLJb6YkLxJIsTdxSZv1EUH6OnioZQQdbgD/ddMIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62cWserfXHYLumE6D2wSCVZbLM6ihbsNSK/9veQNrpE=;
 b=Enq/McNJUbc97ayZ5SwXnpIxxo/fUGEta4/28Fal2r88Zz+969IzG0Ylvjb+ThRtMCzmfcvSmkcx9EKQoEOP0ffFzKVC8SjslIvdgQqEKZKRzINzjnVZBnCbRZC/Bub3a/XtBO0GVoGVRrbN/G1KiJcXll16YT6G7Z4uMTHSggZV6ihGHUxOg8DY0Hqdr+NfPLbt75Pf9YtATk0EOxPONDqbEXksb2MUxMmCXbljellEFaYnOX3sPqmYDV8F9t33bIliZg4d0Gy8ZArRgikCkSXT4bxBXP08SAfk+WQ95IZL820ihHGyh/TdSIOEKEFQ55x3UCPT6VS7/bmMOsh/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62cWserfXHYLumE6D2wSCVZbLM6ihbsNSK/9veQNrpE=;
 b=rxbT4hYbTtGxPrfytoeqtdZRGWygyd8E0V9htRCDwdqAhzC1riqmpyECFiDGNiMmDlINN5zqI8mHH45GMLqd6mvfmVTEesQMdCOvPqEYRe6AIXo7SHwJN1RRbgDVPrfLbA58itZL2LOWhc4wnH084Cag7KRXRbfDDa62zT5OBlmh8MrkOUWYrwRqLEaAEd+ippeH3zAMAv0I4tb1sWBsIFtK1TOxnsQtF6uheoLgE9FF/UnusVVE2d8sbyWhFNbZjNTEc/DgtkhtQZ3fLhFT0GYyuPvRCakRqpHCa/lpoMauaU/CFrTopcKYCd3O6SXh4cOAhWA8qEbaUljYTuexJQ==
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
Subject: [PATCH 24/27] iommu/arm-smmu-v3: Bring back SVA BTM support
Date: Wed, 11 Oct 2023 20:26:00 -0300
Message-ID: <24-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2b7095-bbf7-40ce-ca60-08dbcab17076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0INtNhfEc3UoWQptchjhIf6kHga3goVSOsa3ugodHdTc8qWRRQkv/qBNlREUT8zzMI38k/DHGs9j/063imUK7DZDVn8z7C7kIQMksy/VwmreJiIweXgOi9h/UuRRiPoa2iafKSmAdN8r21kWN618d52RSG5249yEctrfwEGIamrPZ5q7k6cM6xnKHxjzO2kCJUdedNlWVCkJOlfD2daGW0uQ/ZKf7sm2PoUCI13WobsUS1x+CeouWzfwbUqM9cY5nrNqPYSPfgva/fcxY/eAQBsIyyPBJMoGxoeEc6bPLBLAJtr+ds8HVMCpFiLsxRnQHiWgCJruhfK+V8s8h2CePabRBpylX5BCPBEKMw3jrkqVRPUuvELmtx8uVxSlrALycaCP19/cv1JiVAPmX1ZrzpPHJhkRkQpFbzWeJ5BSxb7W3U7BMS28CZgqJ52nZYCe96Cw28eKaD3v0HhkEIBGrAH1Z1BqiG3cTHg08sWhxxu1rSRb9bmTaXf9dk0I0AaEST8UBFzHNx8eKiAXs/OwVudas5/wZby2KB0rMAGqlhMp5aEjfnzV+jaxuIM0UXre
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UioMNW+auD8qwTyrowFJfxdUgff65A39jZWqlMlHbknLJfylyZ3zsR6Gj6EG?=
 =?us-ascii?Q?nDy+N+DRd+zWr7YGS/Oq1I4v4T08cDTcJgOHj48tKSiigDBdK8Fz8rP9QqKc?=
 =?us-ascii?Q?hagL6Y2Qk5qF+2NFn2cyv/bIP9azcIGI+U0HXQ8FKoSgvdcvagUrnGR7/mm0?=
 =?us-ascii?Q?uTGmrYSPbzjU/jSXAaq6gb5RJSSL7nJ6JQjFaRIiQOFmyRU0hdD4Jbrq5QIE?=
 =?us-ascii?Q?MyOWAEBs8DCN1af+nzmeilrm1swL0sm+mJL5JXcPb5BeW6duakKxyEsWn5eI?=
 =?us-ascii?Q?oX0aFAN199gAM1EQ7QprLFVtSM5iMZavI6Qx6+kHRGj28dWpMOYqoRdjlg6Y?=
 =?us-ascii?Q?yvVYbSM+UZV7hUaOTeMt4fJIuyl0d/+8LrLTm6Y5pAZ/9SsyWlcS9iyBEuCK?=
 =?us-ascii?Q?H+BjA6ostdq1JLHUton3K1NXhQ+qNBy51eUnjGxul/rNbrgJcQW8JgmVwqsu?=
 =?us-ascii?Q?VEer33QFEARPRkOrTmx+bq4NZyIjAy7YXv/06GPGnRXpQzhZpUtfq8UxIRjt?=
 =?us-ascii?Q?i38xJg4QDYpGpbv5XqXmEEMuT/GAfo9qxnnEf8A/5BlE1n/ZsAmG237ZkNov?=
 =?us-ascii?Q?C7Ti3+H/JtK3e4CqubuKpO44waXB6wjYxbkrRpCgxIvKesBdIGtwm8VThOqH?=
 =?us-ascii?Q?/K/8ONERgbFfFmnQavdDK/WIIwwrhLkrhInL4fC/3/ttjZSivCnquxFQPtjn?=
 =?us-ascii?Q?eZJjbqPaoc3yqqoLlDJh4rR8KvMgDKJZ+Z1njknCP1//rRfVLAnZhmcsW0Na?=
 =?us-ascii?Q?OGnvmrM4dJHk4e1JV1LvSCKNNoJyv/3iI2g6JzqHEl5sXcVRkxw24thLDgri?=
 =?us-ascii?Q?Kfx37TPmN8RGL08IAE2UhikuDnRgbV7ziDUtVa1mYPJ8lZ4Zkzf30g+UV5wu?=
 =?us-ascii?Q?2KARiNBFSFyKsUJ4eIkK4M2AGr6Ozo7KQ0HUM6erO648JIKRXMHS2dY8q6jV?=
 =?us-ascii?Q?HvdcwkkbqMHtZPyYzx1Y7m6bUvTuuDwn8VFt9l0PeQtKpR/+zBoHBCZWsDxi?=
 =?us-ascii?Q?/NOVhleRqq23xUyA1avMk9ZipBWBJ7vwxByqQCoYE17C/cgjTcuDfgw/fjtz?=
 =?us-ascii?Q?+jcTbPCh12uMjx8XAmOL9LmElRwpEeLS84iI2DNTkGJs0sJKd/tGp88b5OYA?=
 =?us-ascii?Q?Si3qj+JfyCn/zUUrOpoBX/KB+/3OOdMhTNMmcUyjkBEy5PJzSCA6T9quWONk?=
 =?us-ascii?Q?dClV+n35PTfSTSgtY+Bezf0YbW19KkYPitJJrn61frt2KR4jQf2oTBSM2JEu?=
 =?us-ascii?Q?TBq7zlRZrOecMmC0OU0FbItgZN/vdp3qiBKkvsYguX6O5MW1nJw8Mic+makj?=
 =?us-ascii?Q?3RRmNqLy7LM7jwbhgQpqcs6xwaHdkjzI4Ato+FREou/nCc1mTg/9BeVfvlHW?=
 =?us-ascii?Q?JQ5rsvHM5Au0x1V3zil54V+p2TQBhkPhKRTzPSdp4vtSFn4QonZn+LabE2DJ?=
 =?us-ascii?Q?vGHJ7iGmaGXVpVYGGFD3MWUgJKpgoaIvBgEvtdOuooEGyd7aHtbDzF5Vih4A?=
 =?us-ascii?Q?gPtw1qHg1r5P6KkjUYUv0FqqiqUpXMP1HgD7o0wYU0AfbCh5oJyYIE8IxeYf?=
 =?us-ascii?Q?7w6/4zKqRo63V70d6F5Aw7L3R+2xUpcO7hrjLqHe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2b7095-bbf7-40ce-ca60-08dbcab17076
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tw2b1BXHocQsArKkhrVfGq7sQR7iHIgTFOLPmWet5NOcP9XlcpENDaUM3dnO5NNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

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
index e9265026fe555b..e784bacc58e098 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1185,6 +1185,8 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
 		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
+	lockdep_assert_held(&master->smmu->asid_lock);
+
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
@@ -2002,7 +2004,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
+		arm_smmu_tlb_inv_asid(smmu, READ_ONCE(smmu_domain->cd.asid));
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2245,17 +2247,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 				       struct arm_smmu_domain *smmu_domain)
 {
-	int ret;
-	u32 asid;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
-	/* Prevent SVA from modifying the ASID until it is written to the CD */
-	mutex_lock(&smmu->asid_lock);
-	ret = xa_alloc(&smmu->asid_map, &asid, cd,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	cd->asid	= (u16)asid;
-	mutex_unlock(&smmu->asid_lock);
-	return ret;
+	return xa_alloc(&smmu->asid_map, &cd->asid, cd,
+			XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8e13fe136f1bbe..28a03bb3d6d3de 100644
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

