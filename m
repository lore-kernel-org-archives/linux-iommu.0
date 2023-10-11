Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67C2510B
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omIBld6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd+KSIdTGHf1MeE/w//rM7GgxW7KsJzISHlBmphCxaSKAJlBT0lgkFf2y7c3YMv+YqyJQlKYugRL9tmmPWd6iH/ovU6lFbAd9IEexkoVBQTikAv/A/V3gSQw2IjMahJm0MLLUHldqGPad9uHcK7jKFWsP6+0BlMksPWeU3SHrS2AxDOyXxnTBx0VMvJ8Phr04zeq9BdOUJG3IKwkDIWRfI5zAMaDK+qjWiQD+oIFP2ZcUFrgjIgaGK4diIsr1218cUI7NGDcka01SaozEROSm3+TVoU1dBiiIoSseurGawrS2qTPRkkbZoDMWjwTuU3PuQP9oYi5F60HxxBgn6500w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNiINOEX57ntFM8sAYoEA+J+zx+6VjJCBmViGv7vaLg=;
 b=bRs5gk7MBMcgZDxNvavcjV4FQRN/XJJ76hzmRKkLQnZZuAHLShGQAjNCWI67YI1ayoNZ7McF4ht5eI9l99uuzMRPdwdq0CLxUP81zJ/MISNMFb1L8YMwK5puphOItv+K++CuXMDqFajfEVlUbhyq0qGduVWWZTfR0JOHH7pQ5mvxPVLvkhAl3iiVyCWsXs+CnCknvvsBuvgHffZq6sdP2M5CBFd/HZYGKNcxgCDYTU8ExmRDlBiHNDlsMMIwW4Tkk2oGy2Y+9QIo11QpPYIlErn5w7GLNRMBWUoJLap4z+5PBi8yD8298N7Los0b0mKn/4dow8KBQQVVwWVVbtPqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNiINOEX57ntFM8sAYoEA+J+zx+6VjJCBmViGv7vaLg=;
 b=omIBld6K8mvxLkH923qbxLYGRF7vd2Kf9VnDfEn+zgfP38lh60tfKyZ3fH2R3IPz09UWjH0Cbjno35lIpaEoomM0rdhNMD+n6jRvjz/UukfTTbJngP2PtpSpfRw9dow+uYwlHESuo2uS3tlJJcdJoh83XelsuUBX1ygBnxcYRcVIqDE5pOF5tWHfs627EEXjDBz8NWZC/XAl2CLhpYtNhuZ3+FgnG0wi2j/DEbw5Ij1gAI8l97+nVyeTWYqxQotIWYOlGBfkz9j4Fc3JKGxksV8sW+bAoFUCBNq5drhHgk5I7TkpB7m14UL8lz1L02tFp7EhzjC+ORpgiW3eqzcfYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:06 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 14/27] iommu/arm-smmu-v3: Make changing domains be hitless for ATS
Date: Wed, 11 Oct 2023 20:25:50 -0300
Message-ID: <14-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ad5024-91a3-427a-d32e-08dbcab17019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vTxRGtKSpO+zAnP9KU528eawfXlUOsWhfTevjvB4U1nlJpV1T4ha+UmwgTS8pJBOycIVUMRaSXachYqU/Qmi7q2IkBqJ/1aQB/czUn2QyYLDj0AruYDxQUZs+kYExXvA4G76mENqdC4vg8QGUl4Knqt+RsLgaM2CU7kiHwd6bh6wLLT5MAD4zvKeb+zCPRjJyuzkAdKrrKizxxOx9I6We3gy719b198rVJXSb3zr2XfvsV2TZJwHTvaPFBy5YlZtW71YqakHUP7TQwtT7S7iNPjJjDsQfhFmosjHf5AJ/0QyRrE6HOfl8aiFyMN0Cg7e3On4dYePkJ8KvupyhgaHSomQ/YtkxNIiCFhH1/P+jUGB27LKRCNhFMT2H89E6AAq7WR8k1gPdId4y8Pz8hTo998qcwYMUzoqF2iE36iv960tVe4yd9a/5jFUZ5e3a9uXzk20kk46YP8N9REqYTfHmlQzG/OBvGRcwqLwE2u1rV21o96H6lQUzM4l4rDOLyJiX4v3xaMNO2VIl5kT4lzOtUn8YMAhX6C5gQG1ji3dvhxNAVwHlqd1/T7WYcWFHPfY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(30864003)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HL2nm2y/6B10BoqVT3NPghoR3KBKd+xYXZs39TjtAFFHVAkjmzWjwzg7s4/s?=
 =?us-ascii?Q?Akc4OOhoSUk6GDjzFcyZzHUKh9Srox5sb3E10Om/psDJiy0SLUI35SefG3m0?=
 =?us-ascii?Q?oH6gYJfDUpToOwneah3LbHr3iFW+m7PfRmqbizwI+nGPVrBs94mErRJ07W44?=
 =?us-ascii?Q?/LbmVYy5uXBv/D3x8Dyxl3OuOLvmB8AuvA92RZjDgJuOtWhsIVfNVrWe6+g4?=
 =?us-ascii?Q?eWvcRY26V139J3BDXz53witylMOCDFnYvcXWaiAG95SEnxmZcgZdfIE4nq12?=
 =?us-ascii?Q?b6UXO2O+42sYTVcl7TmxVxCrT1mOe0p7fGbBBQ4nQtJ/peCRxHffrWXRsKWM?=
 =?us-ascii?Q?iT765LxmdI03jSN0+4Rnlz/YV8fq2kQ29m9utyELQfl7uZjN+RtmUn0XdIRX?=
 =?us-ascii?Q?a0hdrt83nm5rz2+c0tyEhIwxFpu1Uy6hjrVzCJTZpvshxuF93axxq+NFwrF/?=
 =?us-ascii?Q?MR84Kr084npxAKMfX7cHTZHAa2fcwekAlotN5pbs0lv7JdRxuS2a9fVdD/3p?=
 =?us-ascii?Q?jsk6QYORKQ4Gi0MliitHazs5mlwnHq4Fe8/yAlYLV2GdD85smXCTT9olr6uU?=
 =?us-ascii?Q?n/HFlwhSsmjgJ2+f24Vm7INiv3cWw7ccMZ4RENtOqDjqh8ppei5TTMiXlwtZ?=
 =?us-ascii?Q?ZunH1Meo92OjvDDclu6zElUnSTqYcVVYB5KzUWcPPmSAq5By0HTwohatWde+?=
 =?us-ascii?Q?+Q3dwP/PThMedLtxxynzCNdBoqzPj0dBYfLIpNMDWCUJcGHuI5EIpMfGbOpx?=
 =?us-ascii?Q?YjrcUZ7CEtB7V3FqDTsv8M5JrBciRBy/YvtcVJ84+dZVkzbz0C8rxlTeFoY7?=
 =?us-ascii?Q?i0YYdLbhEnLExs6+H63nzZV9wK7pVVa/Fx6Qs61UtIy8YI08yOWgUeDvjZT3?=
 =?us-ascii?Q?HRzfY1icWlU3dLvxtQ93uAX0huEu2eibRQ5LyCtu5MZ+7WjuW4wSrCog1TQo?=
 =?us-ascii?Q?IKJGpI6mKd2B74nuRYrzcUvOfXWvHtuON8mvhrmMRtyJNCP+E6I9iqCE5dY8?=
 =?us-ascii?Q?Ec0oretl5CqFVRcXZFK6HGogfwrWMeEq/bNmvHgOOWHhdWl3+zGwJ5kth8EO?=
 =?us-ascii?Q?irjIUjSA0L+6xA0lKpVXym2STLDWt2WuhgZ+ENrIBCJGfkuLfW/949HCx+QF?=
 =?us-ascii?Q?8geNqWDEafY4vYVVInxvCmr5PK9thKeswHQuW4qxQJh97DGJwOoE6DsE+2LR?=
 =?us-ascii?Q?P1ozIHU7/M7GcNCCV29DVO1NN5S16w02hbKqJ0AHtrX2QasY3P4j+EgHsHb0?=
 =?us-ascii?Q?GTgbrRubWpUYcubm/C6JSdP6MhjfnXhgk6QaDtZWU/11VU8tWLV05D/Slnpy?=
 =?us-ascii?Q?vS6TdUGskpwz+Ruj8Joj4r6bPEshimsoqLFaLg9S8Oe7iW5+7soF6y+B4G6a?=
 =?us-ascii?Q?AWxc3nSwNkmSxZGw9Ey4UEaGjMlgFy8dvGQDoiaVPpMvtRAeHNLXbcUCbMX9?=
 =?us-ascii?Q?FcXw4yoiYXvotHaPkzVRiQ0dzP9D8mqegFww/kI8TOB//kZ+oB686+Z6knwX?=
 =?us-ascii?Q?YxknEAju1g4BtBshnpvEbZ16t+HRz9b8AU/us0IjRebP+wU1m670AP8yhqej?=
 =?us-ascii?Q?1LDlU3MLLmt+OrZ7afYMI+CEW1L1Hc+vIo98yB/7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ad5024-91a3-427a-d32e-08dbcab17019
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqXrEjBT1bbSF/I1YPAmnDVeruDP3UjDsy/kDohmfvHb0C/HD1oUpcL1GtF/4XJ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

The core code allows the domain to be changed on the fly without a forced
stop in BLOCKED/IDENTITY. In this flow the driver should just continually
maintain the ATS with no change while the STE is updated.

ATS relies on a linked list smmu_domain->devices to keep track of which
masters have the domain programmed, but this list is also used by
arm_smmu_share_asid(), unrelated to ats.

Create three new functions to encapsulate this combined logic:
 arm_smmu_attach_prepare()
 arm_smmu_attach_commit()
 arm_smmu_attach_remove()

Going to IDENTITY or BLOCKED domains always disables the ATS and removes
any arm_smmu_master_domain.

Installing a S1/S2 domain always enables the ATS if the PCIe device
supports it.

The disable flow remains the same, but the enable flow is now ordered
differently to allow it to be hitless:

  1) Add the master to the new smmu_domain->devices list
  2) Program the STE
  3) Enable ATS at PCIe
  4) Remove the master from the old smmu_domain

This flow ensures that invalidations to either domain will generate an ATC
invalidation to the device while the STE is being switched. Thus we don't
need to turn off the ATS anymore for correctness.

Move the nr_ats_masters adjustments to be close to the list
manipulations. It is a count of the number of ATS enabled
masters currently in the list. This is stricly before and after the STE/CD
are revised, and done under a spin_lock which more clearly pairs with the
smp_mb() on the read side.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 189 ++++++++++++++------
 1 file changed, 136 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 82613f5d24f478..5137f7b2ad3858 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1465,7 +1465,8 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 
 static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 				      struct arm_smmu_master *master,
-				      struct arm_smmu_ctx_desc_cfg *cd_table)
+				      struct arm_smmu_ctx_desc_cfg *cd_table,
+				      bool ats_enabled)
 {
 	struct arm_smmu_device *smmu = master->smmu;
 
@@ -1487,7 +1488,7 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 			 STRTAB_STE_1_S1STALLD :
 			 0) |
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
 		FIELD_PREP(STRTAB_STE_1_STRW,
 			   (smmu->features & ARM_SMMU_FEAT_E2H) ?
 				   STRTAB_STE_1_STRW_EL2 :
@@ -1496,7 +1497,8 @@ static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 
 static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 					struct arm_smmu_master *master,
-					struct arm_smmu_domain *smmu_domain)
+					struct arm_smmu_domain *smmu_domain,
+					bool ats_enabled)
 {
 	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
 	const struct io_pgtable_cfg *pgtbl_cfg =
@@ -1513,7 +1515,7 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 	target->data[1] |= cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   master->ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
 
 	vtcr_val = FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
@@ -2380,22 +2382,16 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
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
@@ -2404,22 +2400,6 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master,
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
@@ -2483,40 +2463,148 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
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
 
-	if (!smmu_domain)
-		return;
-
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
 
+struct attach_state {
+	bool existing_master_domain : 1;
+	bool want_ats : 1;
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
+	struct arm_smmu_master_domain *cur_master_domain;
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
+	 */
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	cur_master_domain = arm_smmu_find_master_domain(smmu_domain, master);
+	if (cur_master_domain) {
+		kfree(master_domain);
+		state->existing_master_domain = true;
+	} else {
+		if (state->want_ats)
+			atomic_inc(&smmu_domain->nr_ats_masters);
+		list_add(&master_domain->devices_elm, &smmu_domain->devices);
+	}
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
+				   struct arm_smmu_domain *smmu_domain,
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
+	if (!state->existing_master_domain) {
+		struct arm_smmu_domain *old_smmu_domain = to_smmu_domain_safe(
+			iommu_get_domain_for_dev(master->dev));
+
+		if (old_smmu_domain)
+			arm_smmu_remove_master_domain(master, old_smmu_domain);
+	}
+}
+
+/*
+ * When an arm_smmu_master_domain is removed we have to turn off ATS as there is
+ * no longer any tracking of invalidations.
+ */
+static void arm_smmu_attach_remove(struct arm_smmu_master *master)
+{
+	struct arm_smmu_domain *smmu_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
+
+	if (!smmu_domain)
+		return;
+
+	if (master->ats_enabled) {
+		pci_disable_ats(to_pci_dev(master->dev));
+		/*
+		 * Ensure ATS is disabled at the endpoint before we issue the
+		 * ATC invalidation via the SMMU.
+		 */
+		wmb();
+		arm_smmu_atc_inv_master(master);
+	}
+
+	arm_smmu_remove_master_domain(master, smmu_domain);
 	master->ats_enabled = false;
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
@@ -2551,11 +2639,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2564,13 +2647,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2579,18 +2660,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
+	arm_smmu_attach_commit(master, smmu_domain, &state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
@@ -2640,7 +2723,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
 	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
 	 */
-	arm_smmu_detach_dev(master);
+	arm_smmu_attach_remove(master);
 
 	arm_smmu_install_ste_for_dev(master, ste);
 	mutex_unlock(&arm_smmu_asid_lock);
-- 
2.42.0

