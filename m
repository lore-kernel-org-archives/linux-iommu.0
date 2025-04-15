Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E5275844
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693124; cv=fail; b=YwbSSyOcIL85YyQ+GlJv8amaObVLAYeLJmF1RslkdAWTQEKASBIHFiZvPdL40mBcmD9JfH+UYzzu4vrycT5E9I4o7schDWMsj0MVgMi0fTtBU13+DUWEVlby+iiMZ3ol9CW99l4o5PEMeq8IPBgbvNQFDqQb7IHbQkAt6pB1BaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693124; c=relaxed/simple;
	bh=qbmrC4iG2Tpj4O6aScm0QCZCaa9lvYFOxkjbZ1/FRFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0RuP3jFXcMfXksOo8y7hr4hKQQGMWMyTebjPJtAlR65jhsaTB6MR2IV45+cbJqAuPWpy0djwR29GRbg5GGN75kjTINqJ0jzrfDg3rHwuajxHNHAmUBY6sfoGKPC+nbQJflZZOG9iGK2W5K1OrWxJ1ESjcKpar+t3KCS+pJrQa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tp/dVvax; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tp/dVvax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w97QEKi28NWmf/9fqysJlgdeaP7bjlbIejJb2l2Ivk60oToUIG5X/j8grhx1T98mnhb2yPSs11wlhCuIu41FyFSVbYxGbrbEobIs0obbj9WXvHCUv51JlE2NXuHYcrVxHj2ONcLTIoBiKYSlXIdeGQ1iSi4FpPBgueNVmRmDtBMmqRoONjIiJJDsS3r/WNwoILZNlXehX3rgvRLN2sAas0eS4f6JacWsmTkg1QEXY0URcjVtncN1Muv+jbHTige4jxpBR93EQS37uNstyKjKBSf+Kbdz0JVddrRG3bZmx03qFjLJgYrTzfQDBbxWsQbPImuvbEQApT4NmF3qc5StlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi7Lx8FzAFjge2/DZPsH5UQQz7ZzdnK46Pkn0ALEFGI=;
 b=CxyQftZEE2uvYfXFlFVbGxwP0XZSKUEW+9BkkBopWXRRNGK32Zpi2Iff/Lcou52U8izsfxXbL64KNMD0FOhgR5c6t71dkPGvlpXYsnWOpCfngywbVnoICew2zQtzR/yoceWwHaP9FIN+a64lF2L4VWtUmBkX5CmsNIG2YPSDv8fnjZuAlAoqDcdDcWgvGqMepJx4g0pio0k+gokdhC+rO4voNGW/JCc45xd7Eq/qR5ItsDE8NcoL4RJikWSg4r8ua3AMbVMiK2Y0qyxqD8V9J76vhpdDi5/57wVcTEIgO+d3XQj39Hflhv7dH7Z0yeMtR2EqzGIg/MdZwajz8Qy3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi7Lx8FzAFjge2/DZPsH5UQQz7ZzdnK46Pkn0ALEFGI=;
 b=tp/dVvax9l7GdIoPR9gK0h3rmpAKzlPz/4mjsJzsPOMEIfPjMk1VosecNAjIp1xf+wVeZuorrqv8wktRfqAtu17WM7/kK1uzO4anEE9lMwxlIhOjlZ3FOQI0PjD26frmGkQEkr1HSLgiLqmMzc0CcaE2ok39JVeR9LFQ8SQ48R+zzEvSdBn1l6rKpREsgp5RoTod8oVXBfhWPJURtLcdFPky7AkONtttRSSOPy5/7OKra+MmSgOIOzuNGiPD2vOj7DoATsmd8lb5e+2V4twL+kd2Pyw0vpb0EbASABClwcFklNUkWBYtWY4nEsYpgfLr4WwBocmB1dmilWJqUfr0GQ==
Received: from BN9PR03CA0217.namprd03.prod.outlook.com (2603:10b6:408:f8::12)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 04:58:38 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::a) by BN9PR03CA0217.outlook.office365.com
 (2603:10b6:408:f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 04:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 10/11] iommu/arm-smmu-v3: Decouple vmid from S2 nest_parent domain
Date: Mon, 14 Apr 2025 21:57:45 -0700
Message-ID: <74495f4edb0d80dff17cf0ab9fe13c29f55b7502.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 68572d6e-6665-4165-c15d-08dd7bda2f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bLg0i1QnmpCqVUakPXvuKukKbZnIe9sUEzp605Rc65lXNS0wfTrJdSutBmKa?=
 =?us-ascii?Q?5GoUpirwfEm5G2MlfCKx40BToFYkfsWDrD+7Oo8dnrjrKL6u90UiMGIywAv7?=
 =?us-ascii?Q?Wuv+wekVSvo3IZmC8H0shmng3QhP+uhH1st+IaQcxnasZcggIrr6B7oLdJ6U?=
 =?us-ascii?Q?OF2e8pTKMC9/ZNgcXjVOIpW2YE7KN/oc2mwN4xuFYpZUL6dXpMDzVJD3eKav?=
 =?us-ascii?Q?NGa0puJ+A2Lqv3L5cCcz1FtrHejh7aMK2BdrY50V8zUK4OL6wi8jzXp7hgXJ?=
 =?us-ascii?Q?X4WNpNbQYx9qEwXz4uO+iT9SB1TmplFt/vH6/KgXQcbxybluvixvHK4m4mvh?=
 =?us-ascii?Q?6cmqdvuJtvMgE5Z5lZSkXB7z7EZ6R97Va3Q97zt5DuMd4Co51ikJ4P9I6xfB?=
 =?us-ascii?Q?zYQwio3p3cyicST+UskmzBw+pL6NVaUiG7krasHIJlLpl3v0a7stLBUx9Vxk?=
 =?us-ascii?Q?HTRGMWYMQbkQFmJrrCHGF7BtjlG35XGQQ3Jcrhi0u+1IloxtwKak8nPE8Bam?=
 =?us-ascii?Q?JjkJBO0Di43wmRoH9DLW+Szm3WqilZRD+PCPxMmcWsCEFwDrccItdHoECarj?=
 =?us-ascii?Q?8ohYsJQykALWuLRUi3VCAWFlaus9huROl8OZ13S6XEXgCaZMSgC/Y9EZRpo9?=
 =?us-ascii?Q?oqK118b/mICGsqgVkgDe+KB3HjSs2syTxGDmawN8aIH7b6DI48fwnC9lQEDH?=
 =?us-ascii?Q?9xdXxz+L1KExecG6mW+TYU1y1kSHoSPJDnbyVJ+cRnJpS5+8VURRGRfCeE8u?=
 =?us-ascii?Q?IFhFQHuXOZKjckWWay3wX5j+WOantHHpHiocTkNuWZQQmEVtze6lGK5MFV7v?=
 =?us-ascii?Q?C7w5y6clS6YW+0SiH8WWj1I3c9gRosjjr5djzcjhYnewqEt02Dg2Y1yBwVnG?=
 =?us-ascii?Q?NaocNMTsTdA1cwp5APWSeaJqn8HycsMJ/d2Fj1cuk38z9sOW2+iCawFvH41K?=
 =?us-ascii?Q?gspgw9XIEyEupmt66Erp//Dng3j/qW4xvIaudJaTonNZQxmrF9DtZRLBoDF6?=
 =?us-ascii?Q?mrUTBX82AHZVyCKnz4jnmZtNjb2P0UUAzxJKqPImkDc6TysMM2pENX+j541o?=
 =?us-ascii?Q?RxI8nJLWS1RIrwrN6bygV3EAgz+T8j7n0Xd7Qla0F//egpP5S8m+A6yeX4ox?=
 =?us-ascii?Q?j7/ReUVMPqKaen+YQXH6dQvK50w6Cgsi6SsGq9Hkbts+jiyVv9CdTjTep6jF?=
 =?us-ascii?Q?mpfo+KxiABCnoBsJNNyDFq377yLm6/vpEwrT0O2N4ShkHYlUxJVA39dQlTgl?=
 =?us-ascii?Q?WTqNFo9QKJ9dyJImMkld7CIOgnHqpymjMiYVoKiBBoi5syYwgkpMijqtG3Bu?=
 =?us-ascii?Q?yHmFQuEohRJvJykuznysBv+RMh6A3P2fNeyB8mYwGsnVAWbIeqI1vM/Ud+4Y?=
 =?us-ascii?Q?ooER/klJvOMCTB2vb8qWwJINPBC5WExNm2ck5AEyQywRbIeP8XHaGOgcwK6k?=
 =?us-ascii?Q?/u8voRxRmbXdYzeSH5UayqjAqNoxcQ8tdxAyXhYFkPpkUY9dH6m2pSVgeMKv?=
 =?us-ascii?Q?UtRl7PekS3IGMcvr5bCTBzGrDq5dgPG9WGiB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:38.3190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68572d6e-6665-4165-c15d-08dd7bda2f6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

Now the new S2 invalidation routines in arm-smmu-v3-iommufd are ready to
support a shared S2 nest_parent domain across multiple vSMMU instances.

Move the vmid allocation/releasing to the vSMMU allocator/destroyer too.

Then, move the vsmmus list next to s2_cfg in the struct arm_smmu_domain,
as they can be exclusive now.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h       | 12 ++++++------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c   | 15 ++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c       |  9 ++++++---
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 477d4d2f19a6..dfb9d5f935e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -857,13 +857,13 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage	stage;
 	union {
-		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s2_cfg		s2_cfg;
+		struct arm_smmu_ctx_desc cd;	/* S1 */
+		struct arm_smmu_s2_cfg s2_cfg;	/* S2 && !nest_parent */
+		struct {			/* S2 && nest_parent */
+			struct list_head list;
+			spinlock_t lock;
+		} vsmmus;
 	};
-	struct {
-		struct list_head list;
-		spinlock_t lock;
-	} vsmmus;
 
 	struct iommu_domain		domain;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 491f2b88e30b..5d05f8a78215 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -118,6 +118,7 @@ static void arm_vsmmu_destroy(struct iommufd_viommu *viommu)
 	/* Must flush S2 vmid after delinking vSMMU */
 	arm_smmu_tlb_inv_vmid(vsmmu->smmu, vsmmu->vmid);
 	arm_vsmmu_atc_inv_domain(vsmmu, 0, 0);
+	ida_free(&vsmmu->smmu->vmid_map, vsmmu->vmid);
 }
 
 static void arm_smmu_make_nested_cd_table_ste(
@@ -511,6 +512,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
 	struct arm_vsmmu *vsmmu;
 	unsigned long flags;
+	int vmid;
 
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -541,15 +543,22 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
+			       GFP_KERNEL);
+	if (vmid < 0)
+		return ERR_PTR(vmid);
+
 	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
 				     &arm_vsmmu_ops);
-	if (IS_ERR(vsmmu))
+	if (IS_ERR(vsmmu)) {
+		ida_free(&smmu->vmid_map, vmid);
 		return ERR_CAST(vsmmu);
+	}
 
 	vsmmu->smmu = smmu;
+	vsmmu->vmid = (u16)vmid;
 	vsmmu->s2_parent = s2_parent;
-	/* FIXME Move VMID allocation from the S2 domain allocation to here */
-	vsmmu->vmid = s2_parent->s2_cfg.vmid;
+
 	spin_lock_irqsave(&s2_parent->vsmmus.lock, flags);
 	list_add_tail(&vsmmu->vsmmus_elm, &s2_parent->vsmmus.list);
 	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4b9cdfb177ca..8047b60ec024 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2474,7 +2474,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
+	} else if (!smmu_domain->nest_parent) {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
 			ida_free(&smmu->vmid_map, cfg->vmid);
@@ -2503,7 +2503,10 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
 				       struct arm_smmu_domain *smmu_domain)
 {
 	int vmid;
-	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
+
+	/* nest_parent stores vmid in vSMMU instead of a shared S2 domain */
+	if (smmu_domain->nest_parent)
+		return 0;
 
 	/* Reserve VMID 0 for stage-2 bypass STEs */
 	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
@@ -2511,7 +2514,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
 	if (vmid < 0)
 		return vmid;
 
-	cfg->vmid	= (u16)vmid;
+	smmu_domain->s2_cfg.vmid = (u16)vmid;
 	return 0;
 }
 
-- 
2.43.0

