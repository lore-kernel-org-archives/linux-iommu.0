Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AF2DC331
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851016; cv=fail; b=HhIjO9Qmcm0O+2nPW3G1rHA1IGiF1Zur90O7+ufJU5wSR1hyySWKexZkOsTzpxhgwLSFGNfq16RkutCZQYKHvOIVqmYOgjhYsfszvoPbrTy7E0HCQ7q6QdcvNgntvmXu+Wf/UHj931qAAMRefyV5nckRgNoakU8lvlpwaQFpwVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851016; c=relaxed/simple;
	bh=C/xdiENoWhh3rgO4t49jItVKw+boHDVfQj9OVDyFq1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRLkL/M61S60JkfxURt8jniQ4fCmFtnL0TrzZ3hcIl9HxMm9Gdl0eERr6Z7eKRf7vRztJKyu126lU7g9nnS8tvHjV6CR2SdL1SK6gIKFP+YCQ6Qbkk+kuJLaiTYS0EyUJPc66UQs+oydb1id+wMW4KM7IX+TKzq6svI2Zteg8sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gPhrlKEg; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gPhrlKEg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7/2XJ3qEd9DSKdflAJ9/x/eX2fgEKb09xzk9/Io//q6ISSPLClYp7kUSsGaHu+K1GgNcaUBS7l4rvWEDjtaZVnUg76wGx8WMiePtddAwHl3scVyuculECYPq6bdEalzIm7UHm7YAHyatocN9K9Uiz5B2dIi/OKDsLPYZSPqFadSpCFTskjXu3HgjP7PnEqDBSxhm2uSM2I4arGZHHKS8xs1Gw4+h6AGFKQrBYlfIvs1OhaUQ6k4wHwNnULo5OHyi2ksuabGB43Z/JuV5Bv5RUjTfYv+1sOzOwBr9sjNL7qQV9/qh4XZ9mKsybCmD0wjJWEgM+36PHDfbjZCsErAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg12Yw8tY3diF76Z9B9BKu6uy1ZeELmLDqKgcSNmnuU=;
 b=tiZXEnjHVDDz8xEFjZmxjuvgC/okiek7W1Ewuba2+wLixStH1aNRUvkoBoJc+2LzM4WJ4ac8TmGQn/NAU4laJboH+xJqh0PdfF1RwWELXZjyxFRQTlnxkK7EfZl710o8wv7nhr89q10eDzdgn97PQdXi6BhNP5vpV5hfqpWlxyl1Sj9pTjXNA2ZPuXbs3YP+/jJonLLyJUWoe0Ms1pKvHBo7PGs3KWfSuE7+OdIAc3nwJsc6ISOSGUzPFHDSTKey4Nbm2RnQgO5jmrpnTr1hTuqvc2Few8OXyhYTLuB7FMvq0QQqwV7W6d/7Nqyxyy5mjulUYt8Q/pDEd0PobWPBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg12Yw8tY3diF76Z9B9BKu6uy1ZeELmLDqKgcSNmnuU=;
 b=gPhrlKEgDZ2vlFwDA6RnMWXstABO2/kvAsfOzMokVgxCNaCOEJYzMgKQFCM75350dI+4TmedF/dVSQE3k6iwSncmksYQuNUVD6luH8KfAwW06SI4VHsxU2WyiuSA80lAsaZButfD0Lx17QQ7mKecbaIXkdUIMih0U6Ssu9oX9F04RzFk8P1NR2fiOahfMSs81n5G9Zl1h48z/M7xKELn9xD4I40EM4P0URao2jiOOeqL8znDHqoHjlB97J0BD72+6LejiUH7cYwvxpPyKHWmRS0AfVesEyzXAl+ywtzypuF1kkFBoNTKMaL83JGJ3axikFPKCn9GOM+LSE9LWkhyzw==
Received: from PH8PR20CA0010.namprd20.prod.outlook.com (2603:10b6:510:23c::7)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:10:11 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::f3) by PH8PR20CA0010.outlook.office365.com
 (2603:10b6:510:23c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:10:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 18:10:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/7] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Mon, 15 Dec 2025 18:09:30 -0800
Message-ID: <df4b8cbc0d67a0bfcccb09be868e0da5f0cbb743.1765850465.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765850465.git.nicolinc@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe3efc9-c7d5-44c5-2d13-08de3c483e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKPrfxlMUBJIZFXHS71GBB8oOdqtsIFDYcHwNv307WlLJSJbgBWAHX4eRxK7?=
 =?us-ascii?Q?RyI9BpE88HBgsEeYXyKskoO0BtDEwUaqIutanY5zs9ZB9diokOWN/GXD+ou/?=
 =?us-ascii?Q?GmbQwKJItoSlRgp2EZukOjPe2HvgBjZyDQVkVmgMZ5DEh7UPTtU4ptUchOwg?=
 =?us-ascii?Q?gzcw7n8B7tHbWB1nBuR1YywAPda9IeTY7drINw30cfO26vDFUHUmNIrh5NKR?=
 =?us-ascii?Q?fcYulH3R4hIgxlKwe6f9D8ZAhkkWpf1Ah4nyQ9h0jIMt63AExBc0e+TGUnSi?=
 =?us-ascii?Q?fRHbmYw+ts4lvJh86uf/HTQTjsMrWqCW8K59xz9P/td5MNDCj8Tq9i3G2ffp?=
 =?us-ascii?Q?4Yp0coZMCmXXUdvxmcNdagGBI+sMo+nGCn2HQlyjHiXBrf9P+PtIVQ/WaPaV?=
 =?us-ascii?Q?i3SoFiboFy8kCCiGimKtQ8WfNtXFb6HeQuM0cwhuIQHP9ntToZwcKbLWCaBC?=
 =?us-ascii?Q?eKEa3xSGofqJzMgxDfN4Z+Izcsqhzr3yZ241/afblPI2vu0YDq2aIwOGxGiR?=
 =?us-ascii?Q?/O4PEldYWEJTw4S+rjYKrJFY8LLx68nj/3Ak8G/dj9ky91/q1ztAv5irsAy1?=
 =?us-ascii?Q?1uumfmZyXT9OumvwzyBB/0FS74iPuhXQ/0gBPnWW34FlZn/A2wT2Ywv39w6r?=
 =?us-ascii?Q?+0I7BDQeVgtIoWePHHljUu/b1q7HApn6fh1q+eYSbKXVe49bkZtUt1TFC08m?=
 =?us-ascii?Q?Ut+ueKE3Fvl+TeEIZC4pWzJhqROTIUvCPcXAyQKY8JNq3S0hneM/axxYE/cl?=
 =?us-ascii?Q?r/eAEjpHBUruOO+va8K8bGocuFqeGRhDIgvacyoVkw/Ej3K7wlNCYCeO9D4c?=
 =?us-ascii?Q?7/oT9vFojUXdHc+OLiJjoKFU7f7SqpmSj7r872lp6VjZVCQDVe/25j8upvO2?=
 =?us-ascii?Q?Qiw4RQ6b850ndb+HlKQvcPbbuEQmh/2dcZBeXv4mYRhzSXHiRucUq08+1MPe?=
 =?us-ascii?Q?wzukYVi5c+/gGWpGqdmHB07/+fHZnscVgxYMr4RfYtt3zgEqHQywNti23ywF?=
 =?us-ascii?Q?30HdmGDvDCVwtpziK7G7FEbsebxrExZ9+2lZz+4YIySQphecbgUq5qzmk7cQ?=
 =?us-ascii?Q?GRZ5sWo77XO7p7w4jRGcMDXUWizarSd/Sg89q8igA8yFYZpME6Qu1+0XNwj8?=
 =?us-ascii?Q?gLKAHDE7Wwf4CrZlgZUYaVy90gHydxnnW9QUshc3WOm5jZfIGeVO2xvYqpBe?=
 =?us-ascii?Q?q6JJ/NaPcdvFnSDEMalWhKn3cIzqGrq8oMBme45WsKXjRl0Of289tTqCgAM4?=
 =?us-ascii?Q?v0E3pXimw4i3WT67zmJwPKVdZNDdfLe6z7K5OhGMxf7vBD4oFDwNkjGSCZ8k?=
 =?us-ascii?Q?Zw/WI1tk7/iLkH+ZmJc5g4/s2epG+FrJF4BPsolXxz3a2vy5NbJH08PBNbx1?=
 =?us-ascii?Q?0Jye2wBz9ZESldDlsMq1I0NylLICwvKQadX2c53MFNS7FsnKqdpKV4Baxh73?=
 =?us-ascii?Q?aBBI/nBS5SH+c3e5b4Q4ozY6wYsf2t/BewQIwXg/uopOExIAHuzQoU1OOMKp?=
 =?us-ascii?Q?8wGoodQQ5PZ+6BeICU2Z/Gfj/dedxq6mvRBAIh7dnp5hi4cBctXveX5SXpx/?=
 =?us-ascii?Q?k2tOvtEgucyGeVL4I2g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:10:10.8755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe3efc9-c7d5-44c5-2d13-08de3c483e11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..5c0b38595d20 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -858,6 +858,7 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_SVA,
 };
 
 struct arm_smmu_domain {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 59a480974d80..6097f1f540d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -346,6 +346,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	 * ARM_SMMU_FEAT_RANGE_INV is present
 	 */
 	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
+	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..9d9f24a08062 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3065,6 +3065,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
+	default:
+		WARN_ON(true);
+		break;
 	}
 
 	arm_smmu_attach_commit(&state);
-- 
2.43.0

