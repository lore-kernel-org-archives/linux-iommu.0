Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053E9CA4F
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFaTP8uL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJwTimqwrEvfQReATYBvQVF/LoLNn0ef25py/wwaYPbdGAAxl6D4nP9IoKZXUOc4KFFgS3Uiun90XDvMIXNL4fmTEkF2hsbBTxkGZfhbZWjs9TT4x+qHamn1qwQ66kVLs1dVFHp263Au96SSUN6g7NmX01LG1APvMMFsCacZsa4ciuXFmzaeRJ7tTEbhax8hOFXyaLG30vMhf1T4Udw1nuKhT8BKzvuSoG9uqrzXDCN00rRMPeos2mBJhQ4c3AjDbIdGW7Zgt7eSh3+FAr+BhfTTn04V8WA4Sgomlx+CayKVGloJ5Sf2cnuYiFjXbdi8jNX9xyigr1qQ1NzEBxylpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da3Ahr5nlwmiVXVwyEftq11hL7cX0ltzNwm19Pp5fVM=;
 b=d1qDo4+OL0mBJ3eA/1geCYjag/gkh3ZL9ortG4CwUh4GavrPev2tc+5txG7loY7uMR2Qlp+dUNW6MSLHRaQod3I8PnTspqvlECDKmHa0DqJaebmhJL+gmXWqghj52GRTRUOaDJ4t0Hc1elS7V9fBx7y2wM3ANaOEMgLx4nmxpZKl4UA5G0nGXDRe+HLKw3+J1OQthdhUz4ogVDqGg39ot8ErvUzmwoFv/J9rh3S75SmtRxf0Y8rzv9DoPaUEDLXibokOW24myuOxYlBhwIivO9SCvd8Hav87f3HCgeFoacaxCw38MQQWYo47XD7EMs342tvykomMdDPlzPlEafWyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da3Ahr5nlwmiVXVwyEftq11hL7cX0ltzNwm19Pp5fVM=;
 b=MFaTP8uLARk9fqfd56I+wJQNKTjKad2HuHgyMMBeIcQaxrnR2XCihMmc8GHwWi1D60Lpgz449TitEhFBP+aXj/JHbnruaLBDOHuVPVViBRBVyzZMSibOi5YlJW+s/6EfWYY0GfmjbhRLt/ku9Xb7F7uz8lTIEeShx+1gqJZU/2Kx9Im2odLFUVnfGfALFHzX4s+c7dzjOh3CwpgbcnXToOeXOlLxAhW1dTTHiMS+Xvmr5MZh6qyAwedTEtWr2gks2dA1zrsnuKQI1wwmLIbtr0ogTE6b87s7d1nO5/TxkV4ayS3eXrkwVD/fA1ZhSHP12iHFXOWXJMRK0JxFkJPzAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 22/27] iommu/arm-smmu-v3: Consolidate freeing the ASID/VMID
Date: Wed, 11 Oct 2023 20:25:58 -0300
Message-ID: <22-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: b651e8cb-a49e-4d3e-fd1d-08dbcab170ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8gq+BVEVkZybMmOC90PD4MypC92DX5Z3GtAPQgMqfVG58mA7El+Ne/8WDpzNQzgiUAREB5WZBW5ydlgOl5X9/wNEBnfst7520mSDcILuxgDft1uzy6iHXkCSdulGvOIRfjRrgsy0pNpdzbUptmkZzHyeJp1gkfVp/bXaibUdTFQaNjWGG/VczRyC0cMRCBzQuQC1qhS3tXZFT4O3QfLkrL/x8YvdMlPd6tFdgmTe0ockPN554elX/ZcwCmq2TMABAKoxh6xc8TmBNU+mYJZWU6lK+qhFTaB5PY0Lfq4TFpz4ySHU5vA+07YWbWhaL2n0m2rXMwTGjaYMWDvy8NdckAZayuHpMvYB4SMaViRwjFxS/wVfF3Q1lqDhcM+594gP6KVhUUE0NK50/tvqQGGmO0fFMC/WKynp7SDmibGE7ja7HYPGlEZQOLEefqxibVOPYRPQSsICbcTq0xsj0lWAxdE76b1UI/k/ewILyg7IpU+4Bt6AlI4e4bQbfKTT3GzCH/812hZt0vtM8H00N32tg5+6/YzW9DP0uj3levgM2H3ZXZHqJB2vJmo52HXInXRI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVuWuU0/QWSOb0S1x0OKBzxj9+XPO2sWk3gtqd2ASbtqHGth65LwBRm3OuSs?=
 =?us-ascii?Q?dKR3CoG5gaEXB0PHpdcpE1aUyxZSuECH4b2gWxcs3+I+QkBioupiHi3FpAXO?=
 =?us-ascii?Q?GsfG6R3qMCAUCJMipy7eqoG0UuUE/G2KVAfD58YMxOShDZWUq8HQNZ+fKnV3?=
 =?us-ascii?Q?a/JB7OFrWHhc2uHP7jOjMDT4x16NuuxWqlhvrlNpAXB5/lm4TQSTKWZRKfCh?=
 =?us-ascii?Q?lUq/xcYiLgJI0iaFFbRUQB2Hkn1XmSUtqHaOA6FBaAkaeD8ZqcGbh3zrc//H?=
 =?us-ascii?Q?iEjYEFxg3DGb4wY3D1ds+ghucKk5Rx/JAaMxaZiArl7T6QV7+9vPMGRDgxQR?=
 =?us-ascii?Q?XAt2V+WNGAuyCbgR1zA/OzYyemKwcWa8xz52JyqEAz/lDq/x+q0pHg9IYLFV?=
 =?us-ascii?Q?4zZLFwryToS1giIPyHNsPtWZqG2uBkbchFFakmlaJd4SvWxhhWJ8kO/XYMKU?=
 =?us-ascii?Q?1YzHm/T27idCBiFG9t/l/H9UteIW12OPFGEdyHK2UJp+qabbpleOuNXYNbZ5?=
 =?us-ascii?Q?ptNOMXxv66S+mCRvqNTXW9dT2zSFN9xtKwPJIOeYqjo0GSMMsCBCdwd6h+6/?=
 =?us-ascii?Q?7GlOlHv7OFbCPe4EvzWnD+eFaVbLpBYG4ruYkJ+bbCnSu0jGwPFzjUckM4lw?=
 =?us-ascii?Q?NniB8QNfaQCRqmOS3+pljcqPnYo1vWw8M3io8cvyk+UNZuUPjezsKWYYkIZv?=
 =?us-ascii?Q?hCsuqps8rCEIz/3RcnlNnrO5AsKNvuNGmY5cvSXCyYV2CMF6jlqlGH//ISlG?=
 =?us-ascii?Q?POCXSB0+zt3H+R6DQOaT/ECA+lQ0M5Aq1vSFOyzM3EszKZ5S4IO6Ils/qrb9?=
 =?us-ascii?Q?cXvXF6CHZFV0TRNJPD/L76FVXP9/BxhpBrWn46DmNMZfzm7nL51CYCfYuQA9?=
 =?us-ascii?Q?M3EJ4kEKuYF4Rq8i+l8jPtf4gHvAQ1jKGSkFtsZkmbkxYGSnoojSe94X0MXW?=
 =?us-ascii?Q?+NNH5MKb0ayXfiAECAcn4EbWPnQ5MqXggYT8yF0VT8W0bsS+pWYOblx3tZgL?=
 =?us-ascii?Q?rJy2nfpO5LW6ptuj9CmmSqpym1+5KPQu9oyJ6gp60k0T9VhR1dYVLESvofj+?=
 =?us-ascii?Q?GFpxs43a8PxqPqldfV5r4eS1rfK1QVUvaZfFhivHMxLw9Xqw2BCrPOHDkYAa?=
 =?us-ascii?Q?EApP8OMbAttfXG7IAdGlPPR/Y/LXx24KFy6rKKqurRFpHAHAttXyWpYFFx16?=
 =?us-ascii?Q?F1AFofsC3fY3ulgwgyv7NgkdFDemed9HqkiwMG++5sXwiQWqjgRBr1t6MRca?=
 =?us-ascii?Q?WfgSPRTA1TGGmUiu3i+P+9u/v7HcZX4dyS+l9vYIGk15KwmL7uLIMpV7ISZB?=
 =?us-ascii?Q?htF6Do+/+DRqojPabIDe81f0QjiVZhZmtgeWVe3GCRgCllubgvyiKwVTQRoI?=
 =?us-ascii?Q?JJLzu2vuqigNUgPkIuy7Ca4qVOb7NnG+4WK2sDZcyVQO7JKIL+/DHBJz2fNr?=
 =?us-ascii?Q?hn7rpr80CN52immCopJGJzT0OPS1eklcDjJ+k/K5NyVOexhqnFMYdFVKkKg3?=
 =?us-ascii?Q?N8MflcmZu6mTqJm3/xYmx4AnNYx24e5dVwnCBHBgYWnBgFGuafpU5OdGiQly?=
 =?us-ascii?Q?CrQqcfDHYuaRfdZmTtR3vmooW56ch6R2skyKD31s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b651e8cb-a49e-4d3e-fd1d-08dbcab170ce
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOeIGsUqXXj7XFDVku8RM7B6Ze3uNcy95YGf+mVm36GRSWYcJh3wh37BWcXSZjWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

The SMMUv3 IOTLB is tagged with a VMID/ASID cache tag. Any time the
underlying translation is changed these need to be invalidated. At boot
time the IOTLB starts out empty and all cache tags are available for
allocation.

When a tag is taken out of the allocator the code assumes the IOTLB
doesn't reference it, and immediately programs it into a STE/CD. If the
cache is referencing the tag then it will have stale data and IOMMU will
become incoherent.

Thus, whenever an ASID/VMID is freed back to the allocator we need to know
that the IOTLB doesn't have any references to it. The SVA code correctly
had an invalidation here, but the paging code does not.

Consolidate freeing the VMID/ASID to one place and consistently flush both
ID types before returning to their allocators.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  9 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 36 +++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a3b85aa5e48ce6..66de6cb62f9387 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -370,18 +370,13 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	/*
-	 * Ensure the ASID is empty in the iommu cache before allowing reuse.
-	 */
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
-
 	/*
 	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
 	 * still be called/running at this point. We allow the ASID to be
 	 * reused, and if there is a race then it just suffers harmless
 	 * unnecessary invalidation.
 	 */
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+	arm_smmu_domain_free_id(smmu_domain);
 
 	/*
 	 * Actual free is defered to the SRCU callback
@@ -426,7 +421,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	return &smmu_domain->domain;
 
 err_asid:
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
+	arm_smmu_domain_free_id(smmu_domain);
 err_free:
 	kfree(smmu_domain);
 	return ERR_PTR(ret);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c8042b037673a0..322add56bbdfe7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2207,25 +2207,41 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	return &smmu_domain->domain;
 }
 
-static void arm_smmu_domain_free(struct iommu_domain *domain)
+/*
+ * Return the domain's ASID or VMID back to the allocator. All IDs in the
+ * allocator do not have an IOTLB entries referencing them.
+ */
+void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
+	if ((smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
+	     smmu_domain->domain.type == IOMMU_DOMAIN_SVA) &&
+	    smmu_domain->cd.asid) {
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 
-	/* Free the ASID or VMID */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
 		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
-		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-		if (cfg->vmid)
-			ida_free(&smmu->vmid_map, cfg->vmid);
-	}
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 &&
+		   smmu_domain->s2_cfg.vmid) {
+		struct arm_smmu_cmdq_ent cmd = {
+			.opcode = CMDQ_OP_TLBI_S12_VMALL,
+			.tlbi.vmid = smmu_domain->s2_cfg.vmid
+		};
 
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		ida_free(&smmu->vmid_map, smmu_domain->s2_cfg.vmid);
+	}
+}
+
+static void arm_smmu_domain_free(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
+	arm_smmu_domain_free_id(smmu_domain);
 	kfree(smmu_domain);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5f021d6cee0b14..a24d37e0212eac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -789,6 +789,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 			   struct arm_smmu_domain *smmu_domain, ioasid_t id);
 
+void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.42.0

