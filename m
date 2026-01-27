Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B522FFDCA
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483403; cv=fail; b=VzLGnK4HDxjQz/W/RXM6CCnIED6PSnw9J3fdhXaq4WM3x1ru/ZIdzj6NW0h/BgtC6LHWGOA3hu4xTktZe/irgssDz4TeabqnaC0hNN6h8Y1YpdNsNuzL6o0Z7C9xM+MeEfTQ9Pzw9Vipv4kSDfW7RE1sO3ipK+GAqz51zZs+dtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483403; c=relaxed/simple;
	bh=wVjfs4Gdk+q4mka8L0KcDnc3L52xEsrvs58qOYoOBTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDCzKq2smf2P3Y8HFgarsql3/hi7TDKUO+4XqWaWqfLhEgVMrEna/y1C0xl1NFR2urWkhGY34/lKUh7sg/EsZgSXnKSLmvirrwXxNnbf5xceJ3XHmsES2v2LMeEnBe6TmDJDuuuoflwhKhLuEPmHIFc+PFVUL/YnFm8RkTqG2XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VIrh4Rkf; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VIrh4Rkf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0/6/2+VeWbnu9AI/snjpe7rv9/6tsG2GjQJKZbzDdYg6Gbgvo1AnQ9I4kgH3n+GzV81Q75dUhX7q04+wR/mMzshe5H2r6V/bHxkDH2l368Z2iLf3kpqwhx36aYO5v+pVCPHki94cMZhw22z9RZtcCUhN1fvHkL+JDwDRFYkzDV5o83u/bEa4OmB+npuw2s7wxTliJYpnArlikNzlf3Ktr/ostC7d2HVbxze6cxAdYO5nfMY+kNNca4SlZE/YpXmdIYT58AOis01qvYC5McvJMtZzCSwZP4oLhjlK4ll0pmBAw65yjOvJ2YHhnqDDVC8c2qQG906nTjz6t6ZKhYPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNSPyUtkiFUdmLV1Kxxux5qj18UQLDSaKpcgxsaoT6Y=;
 b=rTcTsnNq9BrDRc9+W24C5GgcXBWc7NLNIvcObgRFNuGoBcqOXrsPzFVgykt6E97gP2tz1YeQZ/olSfBCEBzRdydwZTI0mAK0jsxrd7olrZvUwAdqR74+9k7v5llSgr3HdZqUuqC4qh2RV3yhuZPz8JksEzHeSCWe/HRqULJsIElKpVMHaCTvQsbW/CuFEx9gxqE/U62B2yMUAilt6IKm5B2d7hqXBm+8Ax18stBWrXWFEneVpwypiHtyQ7uHxQ2WUuGzswtDuk78qD3KxGGjSMSReVXhzkQRor5KqvfazxguOgmDxiGaOrgJf2ODpyRW2gaXvDbd8HRIDwDXU9Xs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNSPyUtkiFUdmLV1Kxxux5qj18UQLDSaKpcgxsaoT6Y=;
 b=VIrh4Rkfo3VSNYLa/lIC0+miaCHU8ZlkVM+47AwM02ln7jxsalHoq4lp4J2EGcb5QMzdt8KWswFoC88zgvGVWwbokyYYX0TuGGpQn5Y7Sqjc1ogM10l3zt0zPfGU0ok8PDMCHhWbUfjYnSRF7o+A05rvJNEGw20XVxDcVwrp6nx0xyd4RpCFhf7JSjiopTkHchMZfPwqAsOhZiYsJqwlz2nXa7lYVS6XZxLfU3jpSkjF3+H4y0mQy0G6pYFVPnJUjggZS1W9ifbBxK+SFneOcnp0gA/NUQT8uq7iUyuN8KIv4/70pn2xVPivbtnr+jT9UyC3n51GSv5cBSLrJyCnxg==
Received: from LV3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::17)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:09:54 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::9a) by LV3P220CA0012.outlook.office365.com
 (2603:10b6:408:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:40 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 8/8] iommu/arm-smmu-v3: Perform per-domain invalidations using arm_smmu_invs
Date: Mon, 26 Jan 2026 19:09:19 -0800
Message-ID: <1ad93ac5573ce2fa908a3c9cb0bc2ca53cb14ebb.1769476588.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>
References: <cover.1769476588.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: dc70ca0c-c933-46ba-91d9-08de5d5189fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8ZPDt+H27tc1PHPMwZbNuswliTO1P1FOTMsfp+K6E6nBLTKQeZ7tSWJoMGx?=
 =?us-ascii?Q?kiU8Gft4mBQz0db1+DfgubSbf2JOScm5jmgA+5PcMx1znfvmEu1kluctpd2X?=
 =?us-ascii?Q?3b5e8ZhNs1wZbCds+0pMZc6qXFrHBZI+9WThs3rnAi/SCr8/SigZCyDPyYPX?=
 =?us-ascii?Q?sz/ZMi64LOZAN5ewhiPydmJUuqFLxFlSZSmDfRydLTcOrT3VHN8sXQTEfI7L?=
 =?us-ascii?Q?TbRUfExvXIG3VQQq6kGWR2+czO6CxE+8FQ4tURjfvSS5U2O6XV0OaKqGTqR4?=
 =?us-ascii?Q?VCytcSA8KgJ3PJqXRvTciKA4bDCchIimINQZ+ZaRY07nFmS2rY1tQk/GGoJe?=
 =?us-ascii?Q?90aa7k7dFS9Mu779J0asvl27KvB+qqj/oOqLI85uaRhSf8KyjSFpa7ef8Tvs?=
 =?us-ascii?Q?FMtE9FqjVaisR+s1rqiN4/O7d2IwlqhpO6sx/SmYeBvrOP46tsxsyhqKP/WG?=
 =?us-ascii?Q?NW9aUVzD/VIVD796P2L/ci8v953Si/mhR/8/s2MVoOabD6AeV6et+acmPD4F?=
 =?us-ascii?Q?XWliZs5uJPjHUfeLn66QS8QpmthkIhtNRgfk2VSReDEuqrpMvRzT64Z4GY65?=
 =?us-ascii?Q?JCFrqjkTPNp0oSqpNSavtxRwHWZN50BTiBpJMTdz9ckvNnKlel7m+R08Y8DE?=
 =?us-ascii?Q?9M8CNkBa+hbO/2pkbWenb8lCBge8Eo9lhIdPnupFjkk3d3BgH/gHKX22Lm4u?=
 =?us-ascii?Q?CKilkwD2sSXA8R/YXNXNZdEtMgdjR6gG4dttNszv8NQ6DwD1F5434JoaqhdV?=
 =?us-ascii?Q?xeP0DJRGKNvN31Eqbc8JfmNhapPvbjVqMIdBpoNcjM7smDKEVC7vOrhgZggZ?=
 =?us-ascii?Q?XeAl3UouS+BkZ0xzw1EAaCQ7XaiGdCbILbpToiUvIWg+kBgVrII/9XURJZDq?=
 =?us-ascii?Q?pKLNtZkTb4/7VgYW1dELypiOg7Elupa9caGTwyd+zTyRCVHURjGxrHneE+LE?=
 =?us-ascii?Q?KHnHlEH5qWIlCMyjKkXdfg8HhFJb/tOf+fCMVmrfRglHrnyeZE6dNtFkmy66?=
 =?us-ascii?Q?3TEhdSjyhIT5Em4LoXHbBOdXV4nVQnUOrf9xUcTIZXBQFSrOQ1eaDGg1ki3t?=
 =?us-ascii?Q?6p1caYbAvzYlRvFUy9oP0O6Z9ftQ1e+Ae+Wb63rs8ZwAZCqjPRwO8JGLZ9Y3?=
 =?us-ascii?Q?2OhD7CyIBlEEL3n3d3bm/vw2IF/CRXTNuYEUSWI69vSKgog7ondXMa3iNiCZ?=
 =?us-ascii?Q?lRrfT78d28rXRHmykVhmaPuR9I23df6UDwv2ljE24vjUdDOsm+4jXC4M3ZOV?=
 =?us-ascii?Q?fbBuqwctwGzGfAx6TfxS3XPi7KYvI1njfOdjUkE9YWSAM0SjwzCYQH5Rgvd5?=
 =?us-ascii?Q?ojvgDFUckQHxPVLl5ASC8xfjdRtOOtIzvtr6/hOa9ehrUSauRR5uuA7deWq6?=
 =?us-ascii?Q?L+yTIA5elIHeaBeHXSFb1vOdu/iX3ebPBz0MwIgf5gTMzfzny56K9lzQEsT+?=
 =?us-ascii?Q?3XAFR6qEcriT0bjQcZ1/y4VOfm/f0w6d5/PQC3kk9SKyVrp40NbFzdCtXlvw?=
 =?us-ascii?Q?LDyRd5eiiV/Z4FXApQGSKGS4WpB5XsMe/rinN/Bq/RdD9r9dnzRBWvAmB3SO?=
 =?us-ascii?Q?bHxOZ+uNNJvOydjOzu3AdTMC7ZyvKmAcLkYSapSBtggq4AHuvS3+eLcbWbWS?=
 =?us-ascii?Q?cDVKKdw42KgGV8+IyI6IgwHsksiF7k/NNbRYjohQrrYHRiRi4B5oZjbyJu6n?=
 =?us-ascii?Q?C03t4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:52.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc70ca0c-c933-46ba-91d9-08de5d5189fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F

Replace the old invalidation functions with arm_smmu_domain_inv_range() in
all the existing invalidation routines. And deprecate the old functions.

The new arm_smmu_domain_inv_range() handles the CMDQ_MAX_TLBI_OPS as well,
so drop it in the SVA function.

Since arm_smmu_cmdq_batch_add_range() has only one caller now, and it must
be given a valid size, add a WARN_ON_ONCE to catch any missed case.

Also update the comments in arm_smmu_tlb_inv_context() to clarify things
with the new invalidation functions.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  29 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 183 ++----------------
 3 files changed, 24 insertions(+), 195 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 534e9a5ddca3..36de2b0b2ebe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1080,13 +1080,6 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd, struct iommu_domain *old);
 
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
-void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-				 size_t granule, bool leaf,
-				 struct arm_smmu_domain *smmu_domain);
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-			    unsigned long iova, size_t size);
-
 void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
 			       unsigned long iova, size_t size,
 			       unsigned int granule, bool leaf);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 440ad8cc07de..f1f8e01a7e91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -122,15 +122,6 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_sva_cd);
 
-/*
- * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
- * is used as a threshold to replace per-page TLBI commands to issue in the
- * command queue with an address-space TLBI command, when SMMU w/o a range
- * invalidation feature handles too many per-page TLBI commands, which will
- * otherwise result in a soft lockup.
- */
-#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
-
 static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						struct mm_struct *mm,
 						unsigned long start,
@@ -146,21 +137,8 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
-		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
-			size = 0;
-	} else {
-		if (size == ULONG_MAX)
-			size = 0;
-	}
-
-	if (!size)
-		arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
-	else
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_domain->cd.asid,
-					    PAGE_SIZE, false, smmu_domain);
 
-	arm_smmu_atc_inv_domain(smmu_domain, start, size);
+	arm_smmu_domain_inv_range(smmu_domain, start, size, PAGE_SIZE, false);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -191,8 +169,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
+	arm_smmu_domain_inv(smmu_domain);
 }
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
@@ -302,7 +279,7 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 	/*
 	 * Ensure the ASID is empty in the iommu cache before allowing reuse.
 	 */
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
+	arm_smmu_domain_inv(smmu_domain);
 
 	/*
 	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d94bb290d190..d0749577197d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1284,16 +1284,6 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
 
 /* Context descriptor manipulation functions */
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
-			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
-		.tlbi.asid = asid,
-	};
-
-	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-}
 
 /*
  * Based on the value of ent report which bits of the STE the HW will access. It
@@ -2505,90 +2495,27 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-			    unsigned long iova, size_t size)
-{
-	struct arm_smmu_master_domain *master_domain;
-	int i;
-	unsigned long flags;
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode = CMDQ_OP_ATC_INV,
-	};
-	struct arm_smmu_cmdq_batch cmds;
-
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
-		return 0;
-
-	/*
-	 * Ensure that we've completed prior invalidation of the main TLBs
-	 * before we read 'nr_ats_masters' in case of a concurrent call to
-	 * arm_smmu_enable_ats():
-	 *
-	 *	// unmap()			// arm_smmu_enable_ats()
-	 *	TLBI+SYNC			atomic_inc(&nr_ats_masters);
-	 *	smp_mb();			[...]
-	 *	atomic_read(&nr_ats_masters);	pci_enable_ats() // writel()
-	 *
-	 * Ensures that we always see the incremented 'nr_ats_masters' count if
-	 * ATS was enabled at the PCI device before completion of the TLBI.
-	 */
-	smp_mb();
-	if (!atomic_read(&smmu_domain->nr_ats_masters))
-		return 0;
-
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master_domain, &smmu_domain->devices,
-			    devices_elm) {
-		struct arm_smmu_master *master = master_domain->master;
-
-		if (!master->ats_enabled)
-			continue;
-
-		if (master_domain->nested_ats_flush) {
-			/*
-			 * If a S2 used as a nesting parent is changed we have
-			 * no option but to completely flush the ATC.
-			 */
-			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
-		} else {
-			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
-						&cmd);
-		}
-
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
-		}
-	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
-}
-
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
-	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
-	 * PTEs previously cleared by unmaps on the current CPU not yet visible
-	 * to the SMMU. We are relying on the dma_wmb() implicit during cmd
-	 * insertion to guarantee those are observed before the TLBI. Do be
-	 * careful, 007.
+	 * If the DMA API is running in non-strict mode then another CPU could
+	 * have changed the page table and not invoked any flush op. Instead the
+	 * other CPU will do an atomic_read() and this CPU will have done an
+	 * atomic_write(). That handshake is enough to acquire the page table
+	 * writes from the other CPU.
+	 *
+	 * All command execution has a dma_wmb() to release all the in-memory
+	 * structures written by this CPU, that barrier must also release the
+	 * writes acquired from all the other CPUs too.
+	 *
+	 * There are other barriers and atomics on this path, but the above is
+	 * the essential mechanism for ensuring that HW sees the page table
+	 * writes from another CPU before it executes the IOTLB invalidation.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-	}
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
+	arm_smmu_domain_inv(smmu_domain);
 }
 
 static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
@@ -2600,7 +2527,7 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
 
-	if (!size)
+	if (WARN_ON_ONCE(!size))
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -2655,76 +2582,6 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 	}
 }
 
-static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
-				     unsigned long iova, size_t size,
-				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
-{
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_batch cmds;
-	size_t pgsize;
-
-	/* Get the leaf page size */
-	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
-
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
-	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
-				      pgsize);
-	arm_smmu_cmdq_batch_submit(smmu, &cmds);
-}
-
-static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-					  size_t granule, bool leaf,
-					  struct arm_smmu_domain *smmu_domain)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.tlbi = {
-			.leaf	= leaf,
-		},
-	};
-
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->cd.asid;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
-
-	if (smmu_domain->nest_parent) {
-		/*
-		 * When the S2 domain changes all the nested S1 ASIDs have to be
-		 * flushed too.
-		 */
-		cmd.opcode = CMDQ_OP_TLBI_NH_ALL;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
-	}
-
-	/*
-	 * Unfortunately, this can't be leaf-only since we may have
-	 * zapped an entire table.
-	 */
-	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
-}
-
-void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-				 size_t granule, bool leaf,
-				 struct arm_smmu_domain *smmu_domain)
-{
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
-		.tlbi = {
-			.asid	= asid,
-			.leaf	= leaf,
-		},
-	};
-
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
-}
-
 static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
 				      size_t granule)
 {
@@ -2924,7 +2781,9 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	arm_smmu_domain_inv_range(smmu_domain, iova, size, granule, false);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -4192,9 +4051,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 	if (!gather->pgsize)
 		return;
 
-	arm_smmu_tlb_inv_range_domain(gather->start,
-				      gather->end - gather->start + 1,
-				      gather->pgsize, true, smmu_domain);
+	arm_smmu_domain_inv_range(smmu_domain, gather->start,
+				  gather->end - gather->start + 1,
+				  gather->pgsize, true);
 }
 
 static phys_addr_t
-- 
2.43.0

