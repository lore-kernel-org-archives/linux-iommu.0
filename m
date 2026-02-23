Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535BD346A14
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827536; cv=fail; b=rLL8DSayuwuVqCtqZ1XUyDbah0T0r4zpQsGJgIp+7v6Ttfr7wZk0eSPFiDhs7vVpL10bCF8jXK6Y3omaypnYwY+uGtxgfmuIMBLbJImLedGws3LUhjfLhGLa7+kUbT5pZLhqm7Ep4uriSMZQXPVs646d2yz2UBuK/XYygrtsVuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827536; c=relaxed/simple;
	bh=RW3Af4ypSJUicBAIoyQ1oDwfweQdV1wzjA0kKpTboBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1Qsi84BxxzlYgvxV3Q5/5zJ7tFHVLe5RoAhUOZNn4O77H/EBNnTYqFMcHqMeVnCQj/VyTGs/g/s2LpWyxMuFbIUPpXupl1Tfztb/uVcRgUA78Zx95Se5m0MfrzovXWYkSXbkz2CHcwB4Ck5cKQY5g1vOZREMeSY97B2aSJ6WRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q7jGSALF; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7jGSALF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xqg82gUk4sPXzG4lTY69qmCIYXRc7CyBDRmicdm/2JiqVkkyoeAvP5Ib0IMabjGAqeqZ4GUR/6o9vUb2CELE51r1tGShcrUAeExg38X+9Xd7/KSp8e0pkhLg9qz9KgwJad7XLziFbDrBGr0evKQj6gvgIms5Yz+X0qw9oiK2ry/U2A15SBQVNtoka1M1m0UqHMQVajOm4F7zxnXbiLYPt3dSRGukrJNCbmI0JAg6ONxTtSKrDna076NDAA95eteGwVz6oMik1dZQyvozifj7ngY2rNxbgxly/ODXDmia+i0cGrRkXpQdorKfL27fu/MWoV+QFxOhgQOMLJg2t3oWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT8wOBY1i0/KM6EQ/vrGlkGNtIBtk5HGH+eDIlZhM5k=;
 b=Vwb4F/CwKDr4enB30kkXiBHb0bZ1mCoy7dmrfpZCZLdoxPb1Pcfp0sRX70y9ZGLgdkzG2Zz+PmRu4nEcyNO5qp4/fJk+UC8bUVkaP4jHvAU16YfE4LGWn+7ZY1pDaYMFtjW1YxoKK74K4pCnG9S2u8HSBAzO3mgRzBwNaHb7eApvDhaXQW/8718DC5sXrfJtbFiYe+b6+m5WEsVM4ENwSUFEzgyVyX+iWBXrH2DeARAV5Ybljx2jV4gEFwV1JX6cjRiP7ffiPPEIEqPcMFecFz+UXe25PkyrXUesV5qpRQIR3fXeRo5PUm4E/VAnOUSbwJW2YX67MQNJe0tsIjC4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT8wOBY1i0/KM6EQ/vrGlkGNtIBtk5HGH+eDIlZhM5k=;
 b=q7jGSALFTGybjDeX9AVbCI5pnVf4aqSPPc/i6ONGPd6xjD+easz3w0JMGZFtH4035DteLDCqGF2dVAlkcwQqGFNXCXCGCz4P39+x9+r5bwlsJJIy14kYxQfwR+5JMRll9/NH0YrSIh64v+ay/CDZu+Eyr/xzzuh4NPsMWCnCcpu5t30XFyz7MoJ8gFkEtcE/QOEVTEBBdYctUtIMXjelcnTbFIdYeK6x1iVYTZ0oxwv1Ek68viG2CADr9hPVIGSzJHEoxZKZxbQji2shCTJLg8HQwom+gUN3Fd75EI7KnSsVNw81ynLvEX7ED2GBd7jbt3mjxTtEiHwfGlBoc6mKeg==
Received: from SA0PR11CA0170.namprd11.prod.outlook.com (2603:10b6:806:1bb::25)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 23 Feb
 2026 06:18:47 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::ac) by SA0PR11CA0170.outlook.office365.com
 (2603:10b6:806:1bb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 8/8] iommu/arm-smmu-v3: Perform per-domain invalidations using arm_smmu_invs
Date: Sun, 22 Feb 2026 22:18:09 -0800
Message-ID: <eae6b82ef6c9cc8df0393718704a9507a031bf6d.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0af9eb-31e4-4241-b5ca-08de72a36761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5iUOUEEpblpgeLv4U2indrefw7OHK8xrzzXJkeIRlx1Aqer/AirnODfssdp?=
 =?us-ascii?Q?s0yYwp56I+iSRi9yrPC+aNLPYcYWT7V2fPQQzuedcyW/KEHV3Df4nCivYMmj?=
 =?us-ascii?Q?r3NJILf98ywHGHV7MaqhbRgY91bHDPc3AQjbZFo1oSMbZ3RJHamAALoJpzZp?=
 =?us-ascii?Q?/wB8m58p2Ey7Cj1aNQTSPaE3MLaKBz4Lq36IYx2LD/W/ezqgj7MAi21DDkxK?=
 =?us-ascii?Q?WnGDyW0dsTeQJAF36lW0tl3iyENBJPPnEU9M49CODrw/yk1CRzNFUBDH2stT?=
 =?us-ascii?Q?oQskOxXCOPHucTDA2gF2g7nsO8EWIRRIS2u/KrhChQCfq/ryPxlfIvX2SaeE?=
 =?us-ascii?Q?lWVoYiYrKv8jM5C3cdWJZE6xNKD46RX5Nitqd0MID8HXM99c/S7noIzvfqYf?=
 =?us-ascii?Q?pQiGLGWA4JNqmDm3l813Z3pUwMk7r3i6xz9gIrI2fomSMzBIo281Elxb5eHh?=
 =?us-ascii?Q?LdC7LkejBBgL7XHVyPKhwCaxhEbU7iFdDtVeWtQUcU5utewEWukZR1dUghmD?=
 =?us-ascii?Q?0EsC+Q/qtlCZEW0UR6cw8mOtEs7zisXUZoy1VZBM9e2wx42xyQtDBwnPsjV7?=
 =?us-ascii?Q?zsUCEUmLxdKbttM85lku9ajPfhN4UlHvKouQFahhWQDOr/11cHGThvvRdbqZ?=
 =?us-ascii?Q?od99kRiJwQOalof/AmlE6mXaWzB54LvH506xJKUl4v8ELUa2jrIEQQdCYUUs?=
 =?us-ascii?Q?lJ/Yeb9zJIEc16BvkuXjhktzbF3Xmy+80OMv/3PpFAc8mqDlmg/t5AvHeKcd?=
 =?us-ascii?Q?XfpgJECXzcbhwVaF6RRa/Ri6oCBIbJX4S42l5p39YWRNDD1ZSB2imqZbmOvt?=
 =?us-ascii?Q?p9vO3CqID9vrJAusvxVz6AGleG48dWt1KlEu3eW3KKKEmJZoF7VQkICgZktW?=
 =?us-ascii?Q?wh8kVq193j9o7zXMJt3UK0krQ2l2pSO9+oTV1mUdlwB3wPJ1YzqmWyLYsBHW?=
 =?us-ascii?Q?qDYXzY2VpWvozfcoPZiSy42nrKMuDL13+tpiJUDsQlaseo3YEk1tuJbCVpQV?=
 =?us-ascii?Q?3cH5keMh055sC48fCiIzSwqxT8uQJMbVusjJBCSHvNxr5frMVRDwnfBTwlvG?=
 =?us-ascii?Q?aKIyDlVkQ2sdhLOm1eaO+R2qjy199P2ssvHbcpp6hy3uOzLg722iZihG7DMQ?=
 =?us-ascii?Q?AyP8U52oBA2x6ChPQT9DE2+kZA4cANTyu+Avq0wuD92WKxcc9UPkqa7vgQdH?=
 =?us-ascii?Q?zulmnIArmIA8Zy/4zxP0q0jic6us2AGvtkkZaPDR3fO9IK7ClhQPCe/YPFty?=
 =?us-ascii?Q?Z1/qNwIz1jPQO9wt/xhz//OJ6RbTtTKndb8aMr8BRmuezVUA+InPzwCw9pcr?=
 =?us-ascii?Q?SuadERafKw9KC2KAf4nFdnevwWz2a/rPxpM8egQiin6EeWDS1dYHYEp4nEEl?=
 =?us-ascii?Q?0PYdhxyg87OwFsGVpQEhTCinkyTwrZ1CdXeFXQ0wlcdtyAcKnTbTfg9tfoOM?=
 =?us-ascii?Q?bpQ/yaYqrS6FeGMlSRPG1WIqOC/3dNl+rW15kTDfWQYVS0qDS4LUBzN3dxB2?=
 =?us-ascii?Q?cJdh3o7Oc4oFHs1LcQBHCj7aeqloPGH/2cw+3R2ZnrTNP7LhQJONo94xXHCv?=
 =?us-ascii?Q?/XxcQRKPzA41K1OJdHMcMvf0gSvtmIBZrnMRsJqlSiQi+oWThOBtHD9W+iih?=
 =?us-ascii?Q?kL0nJ6W6R6MdN0IIlsZRgm5x8WWLcf474L+PuN+BoZwb61VnPMmRUzQqPpz9?=
 =?us-ascii?Q?vKWm/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xr6Qm1+Z+z03sJ4+He0RR3pi6BTYC56bzhasSImyqZpC0OeXhFxqRjp1vmoKVRs117KUjJywAJjVP6CpI/X3pRzxT13XtfVlEYNagz3pERD2bNFWcdtIqw2wqiQhnE1h701es3B4GI0YMWwvf9ZPl9czOfeW1EzNQlSYifW+KU3i6kRGwX3SDlgpuXIcPnuXkXCURpQtkKoHUHt/e+knfgd3HwSBmdEiEXR5cgWv3APSeXmFbr5vPlqqPnWtGjU/XgBQSkGGmhfQk65vv7dLNPGgmGfQGL2m8yy6pdpQsq9f734Wagx/mVaU0f/xW/YWdYhhMs4eOs2O+A9T5Lvf3i1wCcGyY/KeAe8vfCmEGh5cv7IvGugSuFUiNTeQMccI8KRzPa6ugfTcLEXyNSzTXMMsi/9HKlkbj/5FKXQ6miJlglOuLlmbXiiPd50NK/Y9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:47.1345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0af9eb-31e4-4241-b5ca-08de72a36761
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641

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
index 534e9a5ddca31..36de2b0b2ebe6 100644
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
index 440ad8cc07de2..f1f8e01a7e914 100644
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
index 9ec82c0036448..b10a68565e9df 100644
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
@@ -2504,90 +2494,27 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
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
@@ -2599,7 +2526,7 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
 	size_t inv_range = granule;
 
-	if (!size)
+	if (WARN_ON_ONCE(!size))
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -2654,76 +2581,6 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
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
@@ -2925,7 +2782,9 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	arm_smmu_domain_inv_range(smmu_domain, iova, size, granule, false);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -4196,9 +4055,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
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

