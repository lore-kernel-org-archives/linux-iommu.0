Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7431C69F
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgZOONkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY1bWjNXCVyE7Ib9I7WVNYxtlD5YfzhOs6tR0xyE95KW8wyHe5QbQ+SqQZJpv16guKiPXWBDamt+2/TQ7ZmGMMQtbhSJGmXVS2ngGJDXswt3oa7bx9JqOPQiGZgk59o19DPU7dKmDUltO8sV2x66D86Vc/1EzQbGzaqtdPt+n9ZV0yxevwd4WAnZdrnjJMJa71tXtgOmAq1OxXDg6lBrarU8Nj0lJn88OszxVNaGUlo1MCTVeaZ00kGziNqQOggO3llNlMlij//aKYn9nI8uGqIwBovNCaDraAN82+MDoCyQjsebn170H0Trvw4iYfkz/YTGJfsXmB/Xe95WqgJRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MDw4+qykY7l4ZDmYRoCpipvLJbgBuHNhHPr7KCGe58=;
 b=KEgqe9LScQgGLP3h6ls/yVHaWzsMeSZVx+mVVQkdNYvjpWb8u+9fWPjODaJh3I0heW5ofTTQU0ImEWV4oxN32CmlxTRsYBQU0ayUtnEkksqgllCOhW1h976Nmdh3Esm0/S05kTG9DBbDnaLQOxxwjxgaDceH497WUM9JDtEjJ3Xmd5tngcSQlwH/QmkAPMuqPXqyF1uq8nZ467wUwYeguNP3Un3GNozV8WnV6L9E0Bx8uTvaRm/r3ghrR/pPOwuNzOWCTW74ySRGWE4H3I1LESGvYyCg6/ZHVy+FhKcVPZKpMSdufJGHHmPW4H3oM7cCVtJ5JEe5FrO1H6WVvIKP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MDw4+qykY7l4ZDmYRoCpipvLJbgBuHNhHPr7KCGe58=;
 b=sgZOONkNH3vj7KBPpxNkhQ2XMlOSMKAOntpxyLda8z9ftAWRqeKQEWAYnIKgL7F80Y0K8r1EPPby+h4R/FLVqgZT+GUwS9DPIOiqqzU0HiXx82cqxWqmxQfsL2dY8czFQDLjNdIs3V5U0TEgsZMTJET5VcojXbfkAwQDtYYtafiXt9gcgm8xs8CdBM9m7BHOxvdtIlg7vByUnyeG+/Tr1cmUVk5f7KlFzpk4WMR9LEF8D1MsJRAHsBqSquS9k3iImyX+GI67rt35UWrEobz7xK4nbYOfTFGKcFsIEVwhReiTjpht5JrpODpfmsq0iTkoPFT6QVW6u6TEZPMAENo1gQ==
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
 23:36:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 14/27] iommu/arm-smmu-v3: Make changing domains be hitless for ATS
Date: Wed,  1 Nov 2023 20:36:32 -0300
Message-ID: <14-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:208:15e::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 216dc09d-d917-450d-55b5-08dbdb3369e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UZNYOwzcL9RHRZ2iAfDQPKVzeoB1C9ZdG/js3rE2UzBYua8XHeG0RLbuTSVSV4sWv/mQ6P0JaMtN7oYTPHjEoqBsiRcK3MSS/nhIYZis6cO/xyVncvekJz5Z3Dh8+yFMOc1sbqACNXPxE/+lgLmYtgrPxwyiIlnzEWD7oDzCyCiGexvmntUNcTp6USpfIFqT6ElZFQ4FSeLn2MnWz4VKhxLZkCB8944MEWtajIuvp+ljL3AZOExZvnsDcsfyiLdJyNbAIgl+rWbDgOzkkU7xZsjxATeNkg+i+jLDSFrGyYyewbNowD1T3eavevYMlagoiPvZG4oaQ0SEesyLV2MOZligV8W9m04ABlFELrMKDTGLvK218tfh9Wj4p9Fe1HQVe3rd96qgcUxzBm2qmAQ9IrOikYMNqh6YhdHk2P4A5dnV6bDV1N3byswRYGJeN2DL5S9bdtlwOX7l01BdSe/W1vqAGslVMXIFAw55LoUG0t3tDL90jl2odiLPzVdlYkg03hymQdHUMhMWe9fZCMz7YyRYGXjCh+mtN7eC/SQzWnyRrEktKg23ElXKkCp8LIYp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(30864003)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjnfyBeSS1Q0XgR4skAw4vByxfV4qCOUfBYv5RGeWYtvbElxypC/LikO6Pw9?=
 =?us-ascii?Q?eiDWbrKQbCLpWLIGwM4VDme+jcmtxgXPHIEiyby9FCXVrjX07AKWIWmhrvDP?=
 =?us-ascii?Q?/Mi2cji0mmmL5SBFAoJqGBAYCfkUR6B3NhPL1zMQ0kmvbyMIYy9S5FqydoVS?=
 =?us-ascii?Q?Q5gfc0q4VFx3ihVxJzRUheq2KEgHq7q2DzDHHTLySQmGBS4/E1PYTQfdkEYK?=
 =?us-ascii?Q?HLDRy7I6X6g/7azAntz8KNl1ZJofUtxxangdgQTYbP+5YiIVZ9eFKB0NApIB?=
 =?us-ascii?Q?BFouyYmQVXR2ZVUdur5EZi61KPNSvDZTpEItTkHPRdjCAeXQhHGejgbReLPC?=
 =?us-ascii?Q?dfGej4VYjdszER77dci11Nq4D2xpK1t1BR0n9FEfywnPYmAOqzwOHV8T+EZ7?=
 =?us-ascii?Q?NDwhRZPgo8UPUc7PvcwyG9z1RN4pItCEe53IbgP4s/myfjRsih3yBjBxsg7A?=
 =?us-ascii?Q?nkszTeN+SvHxfRjrsaGi6WAQIZCJ4L6eIUWATEMvMcNPqe9CE4ZLp5/VrBLk?=
 =?us-ascii?Q?AGs6qFunYwRtRx8H2mACMwCnFHMxDCZ3vXOym2Xt4Ll6j09nJWapAD57bgZO?=
 =?us-ascii?Q?ng+hZmPVQhx3FVE4Ap2Blw8dWdQuQy+bx9LnON1Niz5L6Ut7LqLQwVVOsFbk?=
 =?us-ascii?Q?Ngm9hVwlHjGS0+pkFeTYmboQ7Nt9OdkaVYQQgsg9ntM7Y4mpxH2VPASDeyrK?=
 =?us-ascii?Q?pqx4UWPXc/POE5tAukj5vZKyVy6X0LsEu85bH43EDmZlLSVsgxX7kAlW5F6u?=
 =?us-ascii?Q?WBStPkYuaJDOGmjmu2eWI95EameWeDI4CrA+UPFlFrew9RDQmnp4t2vphlXe?=
 =?us-ascii?Q?TbxBKNGM5Y/wSnPcZm+xZ12FL57i0jTCQgiGHgptQe/trZ9BTJjW58A07QQ7?=
 =?us-ascii?Q?qOO514jUAhFDgdqbbyVts5KV5Sw7kgRLWd/5I21txkItTa1QCe8Y2kcDNnog?=
 =?us-ascii?Q?sCe8uGr9vc+Gn1a2lNk8nJkL4Drvctbe8zIlFBJonue7v9SfHvOwmx7Ph4EW?=
 =?us-ascii?Q?jKG35vdmMQISsRpCwiNaezBRDztWPW/yPfy24hET9ZNf9i417l2JGGsnh8Wu?=
 =?us-ascii?Q?wQpPZG6+1ulznzFPEG7Pq72mCw5eRBCiuipCjj6YDtm8KsdG6biZFIYMDYyv?=
 =?us-ascii?Q?4Ha68kOKwHnDJmlk16ajYCVkyDiFyWKt9f8KdUDhT59C+WFqp+WK+y9FnLSm?=
 =?us-ascii?Q?oGm21NZdXOvRBi/+qYZeraOznB9jYSe9UQ/WB1TF/zGpV5aKe7h4ljxuNeAm?=
 =?us-ascii?Q?Z57qbVFJHVF7c3Qrj22Ed9aNwqzPKjLWhGxwskKA8u3ieOYvyJtkrul63hrb?=
 =?us-ascii?Q?n0LePR0HPQKRwUEgncgZlP+BUsORArDJPZ+Jn8cHiHOd//z15f3d/GjdX3VS?=
 =?us-ascii?Q?XULzlP4hb89qTNm3PO5O3P3vC1DpQzJEs+2vhdownWBD71uAtFm0v0t3bcrO?=
 =?us-ascii?Q?2ymTqmZi6GOdNa6IrbdXbC/k0pgTtBsyR7rcQuYp1YN9b+vR6XNy5GNYTnT4?=
 =?us-ascii?Q?KQ8DBy8YXYckcTpmFkofKim/x7aNWOXrjBCMRlqhFwpvIlIiviUY2tggVseC?=
 =?us-ascii?Q?Ci9YXe5mEHQOrTXa/2p6MJc8sCQN5Kf0eaRZOQ80?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216dc09d-d917-450d-55b5-08dbdb3369e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivpuzry8A9Y0uG4CXbS3twEKUec2c9XekyWAQfqFkNfNLqi4zPuZAoJaX5a1rQc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

The core code allows the domain to be changed on the fly without a forced
stop in BLOCKED/IDENTITY. In this flow the driver should just continually
maintain the ATS with no change while the STE is updated.

ATS relies on a linked list smmu_domain->devices to keep track of which
masters have the domain programmed, but this list is also used by
arm_smmu_share_asid(), unrelated to ats.

Create two new functions to encapsulate this combined logic:
 arm_smmu_attach_prepare()
 arm_smmu_attach_commit()

Put the ATS disable flow into arm_smmu_attach_dev_ste() - we only disable
ATS when going to IDENTITY or BLOCKED domains.

Installing a S1/S2 domain always enables the ATS if the PCIe device
supports it.

The enable flow is now ordered differently to allow it to be hitless:

  1) Add the master to the new smmu_domain->devices list
  2) Program the STE
  3) Enable ATS at PCIe
  4) Remove the master from the old smmu_domain

This flow ensures that invalidations to either domain will generate an ATC
invalidation to the device while the STE is being switched. Thus we don't
need to turn off the ATS anymore for correctness.

The disable flow is the reverse:
 1) Disable ATS at PCIe
 2) Program the STE
 3) Invalidate the ATC
 4) Remove the master from the old smmu_domain

Move the nr_ats_masters adjustments to be close to the list
manipulations. It is a count of the number of ATS enabled
masters currently in the list. This is stricly before and after the STE/CD
are revised, and done under a spin_lock which more clearly pairs with the
smp_mb() on the read side.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 171 ++++++++++++++------
 1 file changed, 120 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3aec3791ccbe9e..2181eebf0aa369 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1490,7 +1490,8 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 
 static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 				      struct arm_smmu_master *master,
-				      struct arm_smmu_ctx_desc_cfg *cd_table)
+				      struct arm_smmu_ctx_desc_cfg *cd_table,
+				      bool ats_enabled)
 {
 	struct arm_smmu_device *smmu = master->smmu;
 
@@ -1512,7 +1513,7 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 			 STRTAB_STE_1_S1STALLD :
 			 0) |
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
 		FIELD_PREP(STRTAB_STE_1_STRW,
 			   (smmu->features & ARM_SMMU_FEAT_E2H) ?
 				   STRTAB_STE_1_STRW_EL2 :
@@ -1521,7 +1522,8 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 
 static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 					struct arm_smmu_master *master,
-					struct arm_smmu_domain *smmu_domain)
+					struct arm_smmu_domain *smmu_domain,
+					bool ats_enabled)
 {
 	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
 	const struct io_pgtable_cfg *pgtbl_cfg =
@@ -1538,7 +1540,7 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 	target->data[1] |= cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
 
 	vtcr_val = FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
@@ -2405,22 +2407,16 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
-static void arm_smmu_enable_ats(struct arm_smmu_master *master,
-				struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
-	if (!master->ats_enabled)
-		return;
-
 	/* Smallest Translation Unit: log2 of the smallest supported granule */
 	stu = __ffs(smmu->pgsize_bitmap);
 	pdev = to_pci_dev(master->dev);
 
-	atomic_inc(&smmu_domain->nr_ats_masters);
 	/*
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
@@ -2429,22 +2425,6 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master,
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-static void arm_smmu_disable_ats(struct arm_smmu_master *master,
-				 struct arm_smmu_domain *smmu_domain)
-{
-	if (!master->ats_enabled)
-		return;
-
-	pci_disable_ats(to_pci_dev(master->dev));
-	/*
-	 * Ensure ATS is disabled at the endpoint before we issue the
-	 * ATC invalidation via the SMMU.
-	 */
-	wmb();
-	arm_smmu_atc_inv_master(master);
-	atomic_dec(&smmu_domain->nr_ats_masters);
-}
-
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 {
 	int ret;
@@ -2508,40 +2488,116 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	return NULL;
 }
 
-static void arm_smmu_detach_dev(struct arm_smmu_master *master)
+static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
+					  struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain =
-		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
+	/* NULL means the old domain is IDENTITY/BLOCKED which we don't track */
 	if (!smmu_domain)
 		return;
 
-	arm_smmu_disable_ats(master, smmu_domain);
-
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	master_domain = arm_smmu_find_master_domain(smmu_domain, master);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
+		if (master->ats_enabled)
+			atomic_dec(&smmu_domain->nr_ats_masters);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+}
 
-	master->ats_enabled = false;
+struct attach_state {
+	bool want_ats;
+};
+
+/*
+ * Prepare to attach a domain to a master. This always goes in the direction of
+ * enabling the ATS.
+ */
+static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
+				   struct arm_smmu_domain *smmu_domain,
+				   struct attach_state *state)
+{
+	struct arm_smmu_master_domain *master_domain;
+	unsigned long flags;
+
+	/*
+	 * arm_smmu_share_asid() must not see two domains pointing to the same
+	 * arm_smmu_master_domain contents otherwise it could randomly write one
+	 * or the other to the CD.
+	 */
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
+	if (!master_domain)
+		return -ENOMEM;
+	master_domain->master = master;
+
+	state->want_ats = arm_smmu_ats_supported(master);
+
+	/*
+	 * During prepare we want the current smmu_domain and new smmu_domain to
+	 * be in the devices list before we change any HW. This ensures that
+	 * both domains will send ATS invalidations to the master until we are
+	 * done.
+	 *
+	 * It is tempting to make this list only track masters that are using
+	 * ATS, but arm_smmu_share_asid() also uses this to change the ASID of a
+	 * domain, unrelated to ATS.
+	 *
+	 * Notice if we are re-attaching the same domain then the list will have
+	 * two identical entries and commit will remove only one of them.
+	 */
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	if (state->want_ats)
+		atomic_inc(&smmu_domain->nr_ats_masters);
+	list_add(&master_domain->devices_elm, &smmu_domain->devices);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	return 0;
+}
+
+/*
+ * Commit is done after the STE/CD are configured to respond to ATS requests. It
+ * enables and synchronizes the PCI device's ATC and finishes manipulating the
+ * smmu_domain->devices list.
+ */
+static void arm_smmu_attach_commit(struct arm_smmu_master *master,
+				   struct attach_state *state)
+{
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	if (!state->want_ats) {
+		WARN_ON(master->ats_enabled);
+	} else if (!master->ats_enabled) {
+		master->ats_enabled = true;
+		arm_smmu_enable_ats(master);
+	} else {
+		/*
+		 * The translation has changed, flush the ATC. At this point the
+		 * SMMU is translating for the new domain and both the old&new
+		 * domain will issue invalidations.
+		 */
+		arm_smmu_atc_inv_master(master);
+	}
+
+	arm_smmu_remove_master_domain(
+		master,
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)));
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
-	unsigned long flags;
 	struct arm_smmu_ste target;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_master_domain *master_domain;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cd *cdptr;
+	struct attach_state state;
 
 	if (!fwspec)
 		return -ENOENT;
@@ -2576,11 +2632,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			return -ENOMEM;
 	}
 
-	master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
-	if (!master_domain)
-		return -ENOMEM;
-	master_domain->master = master;
-
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
 	 * of either the old or new domain while we are working on it.
@@ -2589,13 +2640,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&arm_smmu_asid_lock);
 
-	arm_smmu_detach_dev(master);
-
-	master->ats_enabled = arm_smmu_ats_supported(master);
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master_domain->devices_elm, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	ret = arm_smmu_attach_prepare(master, smmu_domain, &state);
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return ret;
+	}
 
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1: {
@@ -2604,18 +2653,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
-		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
+		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
+					  state.want_ats);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
 	}
 	case ARM_SMMU_DOMAIN_S2:
-		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
+		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain,
+					    state.want_ats);
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
 	}
 
-	arm_smmu_enable_ats(master, smmu_domain);
+	arm_smmu_attach_commit(master, &state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
@@ -2648,6 +2699,8 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 				   struct arm_smmu_ste *ste)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *old_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 
 	if (arm_smmu_master_sva_enabled(master))
 		return -EBUSY;
@@ -2665,9 +2718,25 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
 	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
 	 */
-	arm_smmu_detach_dev(master);
+	if (master->ats_enabled) {
+		pci_disable_ats(to_pci_dev(master->dev));
+		/*
+		 * Ensure ATS is disabled at the endpoint before we issue the
+		 * ATC invalidation via the SMMU.
+		 */
+		wmb();
+	}
 
 	arm_smmu_install_ste_for_dev(master, ste);
+
+	if (old_domain) {
+		if (master->ats_enabled)
+			arm_smmu_atc_inv_master(master);
+		arm_smmu_remove_master_domain(master, old_domain);
+	}
+
+	master->ats_enabled = false;
+
 	mutex_unlock(&arm_smmu_asid_lock);
 
 	/*
-- 
2.42.0

