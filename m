Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8191CA9B
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UxGwds3m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDyTu0FA/6YWhhgcz2L0PhZdEI6nhtqg9ZSWRmI4TAU6tdwXq46wvlYNJW6PM5xZwcXY0HMBYWCFUdjChCdmg6CawuPGjVORK0oksJwbP8dIp7S8L6hkYDJChcEb+nduUFjv9JXV20cHbOzhS+8jco8tpL1zBnyBhJ1JK/HwDPxBvaX03533YweA/MTNrBuK/+0qhsjKVM7xq+Go7qKMsq/B6rnlBTOvXZMSTMbAcBhD7j54LXMfQz7gNPj7O7nR8v8fITPy9pVm4LAjMafhzNmgaAmL9prP5YsVIvjTg39AAlYVdsM6ogwEt5S7NYRalbqqiMhxgoogZWED/h4SMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/nZPUhNVxOcPpYbLqvm+70v5pj1odoJ3S3tIdNDHI4=;
 b=Vk+cPV++jK47/tSX/tcKmIB6pyUzk+iEcZVv16pLYucm76h2Z/iaqApum216Wf+Blcf07ta7Lw3SigjDLBnUxKsUaUY0Z+vx8d2UtKbL5WY5b8ZbN5o2cLZIgWpnDfyhksJjY4Y/Qt4vnWdzE3ArwjxGEYmzil8o8ljVLMRXxVdieJNkg5T2GWGUvF6dcSNtMZCEOW97CgY7ZneMfuFpC9ZQ91STFg/YpdeLco2M5a6uAz4rRMiJC9eVjyPDd6sf2f/ubp4IRKgfOI+d1NWV//y4iX66nydsC4Ys1vPRsITetBBsVtfDspwdBE7JTFr2UL8VVDatHNTxW2t0zcNhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/nZPUhNVxOcPpYbLqvm+70v5pj1odoJ3S3tIdNDHI4=;
 b=UxGwds3mHmyF564Oobm6UFX/2vzc7S0jQJHjUkAZDFDP561Oe+ijahpgpfE+QhTq/Z7XuIlfvMGFwmbdYbBYCDfM5mLh9gUUiFQPkyFrV1CDtlYAMnqebm0kUK0fcQ0BFJcpcChGIYeNG7vVy4hxfyrFQexI1RKpT91ss2K4+lZOfKjuQm3UJK1RCLz8Mh58GLqUKnBUHnulT0ihqv1eMsZyC94r4Ys8FSAEljFUVejl/DIagy9jjphyJoMjPM64yGIar7ai6WEcrXP6ed7MVWZ9m4MP/wJmUtRIPaG+x/U5TlGF1OU6dRv6dL9V1L9i0HDWyofBMatzmUnikW4nkg==
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
Subject: [PATCH v2 22/27] iommu/arm-smmu-v3: Consolidate freeing the ASID/VMID
Date: Wed,  1 Nov 2023 20:36:40 -0300
Message-ID: <22-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:208:19b::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2022dc1a-c9fe-4cb1-402c-08dbdb336a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ui1N5+7sCkW9kVuNI09AA15N9tL4j2hnDRg+lhnug3EHFf6vyX5TawWcSTMl50vP0UuB4ya5NqAEaaeh/SQrsfP7JLsZgNbOi834uWgmXyxNKXQlwHiMEZkqKEzdOw4H+2B0xBckDBn+jFy2kNq4grJHkZxPv7nLXtLVkgzxaIyx0HNR8fwvfdFXc0CdWeJIM79EVyEayMrU6IYUF814+2iNigjsBB4WCUx+TBQIg32X6uzbNlNHeFzxLKk9Dip3XYgCyhmU0uD7lSRzWf5yh1vQStiWN6c4yD9FN44B3bNq7cq+gTLdH6VSFqfbLrfYpTClYgtf98MilHbe66HT/5Qw3WvTg9z71nYf5+y9XZZtmidBb6dI0AJM39Zjy7nUz5/I+kyMqh/SFUK/VoocqkJ3CWeT8OQWWvSRRzOxQBt/0TgG805VQAQhpTw9lgC1G8ddLAWX3EuZ6/oabB+sHUgQvDqsFDZdu6MUqv/9JlIBDsHwAz7x1+OX5qIIUFQ4pQs2QTn+FOHNUL9JnCOUXBA/98Z6OHyyDMf+L0zfpJOYyiRdYZKxLmHCTLGhaNvz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKW0e0TXwd65lSadLDnbECK2zc1mKO3gMt46uIoeZPKLk4k6WP6fnm7LbI/W?=
 =?us-ascii?Q?c9ghJZa/JHg/Oqux9N/OFsfeXtKEMrF7oOad1usazj7d46LX+6X9YohiNCnK?=
 =?us-ascii?Q?Zh07dmkLutIFalhAa/mWGy2hoe0oG6I8JWQlfxxWuP50hA8xkmPxRUobH6WM?=
 =?us-ascii?Q?6nHcoc5v3MbWhSN39TGT4xSn7+7Y2mbQCk/ccjOW4sGVIcmCi2Kd5EDeaPBz?=
 =?us-ascii?Q?0mNWNlWj23+mBva5ZDpaSgYBgW5yx8NMjd38BzMEJo7jzlM7FweGMzE6htbV?=
 =?us-ascii?Q?phZSaTeGXs7GO/KHIp3Njur4nRFu1qlp1gCM3Z951aOYqJ/tLC+VN8hnvyWi?=
 =?us-ascii?Q?VEhfA92v4T/huciStJbkeSW8ioBecRq0pTGut2lk0C6WXZtmWGvGNgA4aSU8?=
 =?us-ascii?Q?xelzQl98Yxx1wtnp5guPfswRH7yWG1Ev6k4J29yGIiUFGSzdFu30btouHGmg?=
 =?us-ascii?Q?w2kBwKW5lNCr9bC9AH1SqfkAoKU8+U8WNzCKYI01hCwISzlEst/Pa+fhoYq0?=
 =?us-ascii?Q?NMMRbkWKEE1XAoeXeeT1DdjTWqrP9NOlJq4Dyj9rK0SenguaNI2c7fqZ/f87?=
 =?us-ascii?Q?+BsxKd9ZGFSSWMZMCPChP0dQ1UwzSe/ByMwuSSQXDrofC3GDzw7YyrcEvo5a?=
 =?us-ascii?Q?8f3yLtTlvdRWun+SdV0azUZt4tqVzvU7QSfnuGgQX+FsHMwGKNOux6hrCI/y?=
 =?us-ascii?Q?+vhb020cV0bYs5q22yzDTROJ9WqKKP1HqsmKGvojsX7WyDk7WifKDMJDWLyL?=
 =?us-ascii?Q?6fCq9a1xT78Sc6iWV4X9G3JxVC05tnPC0iUGPLfIq/Zsdeo8J9o5MaW6GCch?=
 =?us-ascii?Q?Wc7iR5toypchy7NpjmOZ5gejSlXNRE4L3C+rkbYwNwAEfIrfUCJ+OMBtkv7v?=
 =?us-ascii?Q?t1oCam/4GjZuDcl6YUAnA3GUbvU8vQzrq0lkZFNziiU5+7pfthOLCQZJFd+q?=
 =?us-ascii?Q?gU+eTE/yxKLav3agNan+fj/YDelndyOLLw8nSmP0yuWokeO+vOIZu3rbAV5v?=
 =?us-ascii?Q?nF090UsxJ9BXg8S5Q2nNXvLljtVp/W5ojmxqKd4cZzNyWlu9T1SRe6mQzIKc?=
 =?us-ascii?Q?Kx4BaADhPaMOXDmqDiN3rI6bkgfcX2zkGHRZipkWsSeXinBTapOxHw48cgwh?=
 =?us-ascii?Q?SiSWk2arUzC4po3bVhptxrlJr15CaArgyW3lsd6O3nI+uTnnBB6qw9k1YszF?=
 =?us-ascii?Q?t31tt450abwFWX5TPsrrQWOvHj56Yq63T2ol2j7ZjAA6Wqi0u02FnuZA84Wb?=
 =?us-ascii?Q?Vf9xRR35YF9hOyPUUtzESMNzP4n0qkhztU1WT22OnWj1rEU74euFisu3rvHb?=
 =?us-ascii?Q?QaMtkmb48s37JTAGNM4q0qHnKNeXU4Uiy9n7Dkiay02ECkfsj6B7xQvIn08o?=
 =?us-ascii?Q?+/f/NgobggihPxthEKDchgGU19mmr9scWhvQapWbUXDzujHc2oPMIrH/GdcK?=
 =?us-ascii?Q?KIB7d5VztUjllcw+9nCa+DF5FUNwgLH2oSVFwXkhmnmPcKxcaYPXuf/sCCET?=
 =?us-ascii?Q?Ot8xRhAP17hyzj5dumQz3TotCg6DXkHCYRvM2TYHxOdsPzwBGeZrsnCeg80Y?=
 =?us-ascii?Q?5gN5q1Ndh9RBfVFvEYB6kjdgp3Y5xJuCcrlZ/IMD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2022dc1a-c9fe-4cb1-402c-08dbdb336a0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCMYpz9jOHX2uB5H5SOxxyeyUdoDnFKTIQdf5QrsAhXaSrooQ/Y+ne2m/zsY0vof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

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
index c221ab138ebb87..7fd376a4e1752a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2232,25 +2232,41 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
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
index a229ad0adf6a49..c7c4f4fda31297 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -789,6 +789,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 void arm_smmu_remove_pasid(struct arm_smmu_master *master,
 			   struct arm_smmu_domain *smmu_domain, ioasid_t pasid);
 
+void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.42.0

