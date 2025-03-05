Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C71DD9D3
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151136; cv=fail; b=Q7Wp8INFPOPqtmG8aEUYF7SN5z1c+NM6eZE4uUxF6JPgCqu8VaxksC7AhJLcp1XcWfxDfnytk2yJu4egcBUazQbV2GXWHbK15Fi/UdDttYQaS+vYMxoBu4pXdJFcCv7S4O5U96kOopcpbnDEkTW6OyUWdGiLXjxr3IDBe4ou2V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151136; c=relaxed/simple;
	bh=muZ0+UyGzDdvNYWHHCgkNa5raAsNgsn4/ZovwsgvCXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky4BymLA5g5bIBX45JCzbIZubJt60gpGkg763//6vGZga5zSEjXzclUFeiXHCTfnHr+2n9db5aFmmRg6Tn0JeRF++Fye192jGcx1Rx8PRbPIvTFXoUKQXtH6LGZDov97x/KsAeabPJreMjCT1oqvEIq4KV/tygrTF6xkRXGVc/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBsaPZGB; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBsaPZGB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0uKKX/zIRrNDdD2AvdDYFktfNeu1cHU4RNKiZ7BRHHLPKh2C5T0oj2G6vFRlJ6A4btNCetBdVs/L9C2Fhe3HsZkPs/sZ6jEbQACX9VFbcZr63/Ergo0ZrmM3b3UwmzCuNi4LT04NBeofIuC+BoMM/lwUHqoymD5xbrpoWxAMwn8BJCLABA216edTFD8M7uJQm8B+S5JDz+FrkLplzJsY++MfucNBxUcYsX7ALpt8KIBcT3XdmjX54VlcJvz/W/AkdF+BG3XtrYsFv4NV3V+PERlzqr6/66IPpJEwW3fxsOyxhPICsrq6WAtsdMnj5Bv80vdTt5Qyump1/oEh5OW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruYzaTpM9J/zVyibxyW+peoybS3z1nHGWcTq1aPHWDs=;
 b=azKX0uHwMa2NeI6F5vDl5p6akIFiEIL2v14CFfyRcRFw+EW8Us05Xd5oOMwToHjhElrb9iP1Uo7iKbjN7Q7iYxWtgpDjfijGXCGovc/1+qtr5x4hONTz8V3wHvbC1w3ardDFU7PBpVFOLKZVf3ANyAMtTDAv7ExkGyhHOUED7ai/6Xx54QSV9FOWpgZbhc/9mgZN/uGeSXxHMSa7Nvc7Ri5pHtTjRwgbwZFF4jt+Z49leRZjtdn0AjToBigKGgGCnUxeDU3jgAYeHcLeh4tErO/cbDjw3D44TzwnifFUMU1iA399SP56vB6+c+7WwZA3hurQL6ALddxiI9otdusOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruYzaTpM9J/zVyibxyW+peoybS3z1nHGWcTq1aPHWDs=;
 b=SBsaPZGBl9GEsL8sZC1ONnRKizxXq01caJPIDTznYzhcJD2WRKeprMlEbXBUcEGjUnPksvajYHzY41koeFq2nc1HY4loeTi4xcbCOd4L5WHnhLTDo/4fDGrw4QGJU8m31ZWfSHJctFYPzvLXagqxbjrA8vAyNeNgetQt2wSL+xy63iLdK30iY4Ty8J6BZQNjOAJrC0v68VXNY0Zp6Chaxk++oG6urzfV+s1+uEhqlKRGvWmuRNpmrQooEjh1OU+L6aUmJiLa8UCqf/HpgXBuVi5nKTytR1Y2uOtojH9Q2F/LCsAeyIzKv2B7zLyS0xKRqZ8eh9Q9uDxz03FFpg0Llw==
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:05:26 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::e2) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:05:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 21:05:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 21:05:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 21:05:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 3/4] iommu/arm-smmu-v3: Decouple vmid from S2 nest_parent domain
Date: Tue, 4 Mar 2025 21:04:02 -0800
Message-ID: <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741150594.git.nicolinc@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb02c97-c2c9-4a86-ec22-08dd5ba35793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2HgBz2cjhQOeN+W10ySEbQSbft73lT2dWPh+4LNCzB8cFcbWesrieCtneG0L?=
 =?us-ascii?Q?6v5G7daOL7V9pEWfMtTWHPMpNBg0dzS30V3iNZpXvI6eDLz4APhZrN+93eL9?=
 =?us-ascii?Q?9HMKUE9wcJROHtpx1yEA8Og9sikKaCL3PuU5/B42tB3Oule6zNsZqML7p2BJ?=
 =?us-ascii?Q?ZBKkNFTy80mWR6lZuB47kvkITe+Xejcb3Dr/T9GqzacNJ8k6zhQUvxk6m39X?=
 =?us-ascii?Q?aGlR7V7oenQu//+1ZkOzu5sxYQ85SjozZbFpKR8uUktdJDIq9maCx6Tl9aXc?=
 =?us-ascii?Q?4SJzuv3alKstjpRYIWBKSOLxdIZgP8V/pyQdkYGl3FkynmNifns4Hx5O7hBa?=
 =?us-ascii?Q?M9qtwvXisfuxk59aRFIC9EVq6EIXRnSbF479QREimnUPppyUv7sUEjZStauI?=
 =?us-ascii?Q?rAK6ZWB+b6/4Od5BHJ7EjzoXgqHtPpaRVsA0FjXt6hJpqp/hZK4u97wg/yfi?=
 =?us-ascii?Q?Lcd23BS1PGuVs6mQO4ATxIsKF44V1L+6MmD/4KcorFcEaQS3ZPP77ovbwuhI?=
 =?us-ascii?Q?ba1WG5r2P+OwQ1k6erxUs8qMC8DkmxFcvXXEVYGC4RUxW8UoT2tK30qaE/e4?=
 =?us-ascii?Q?tnWphNT/QWKq4IzkfBz0+qi972SqlRIlj76B1s7EsX+WXAF87FW7i8EN0vt3?=
 =?us-ascii?Q?EQ1pZZTjtVjA6WfU+4VDaXSisdnRUHPjNc3XLX313Ug89cO8XE8DH9tsNFb4?=
 =?us-ascii?Q?WAtDRkSowWwf55a074ENRXsliaudDxrha8V9oIzhhma2yayKDcAjvIYlHYuo?=
 =?us-ascii?Q?RO+nj4K4jZCCiM8EwLjZxx2qIX1i2oPpUOtwOoBWPIqVd+xTuMSDMQgmE1YJ?=
 =?us-ascii?Q?qsrFWCmFxLlTtRlB8mirqG4QL2xPQcbAeY0nOsyZTI8FVexdaRM1IzBXqUaj?=
 =?us-ascii?Q?pVAg/KiZ1+/ACrD7oHblx+i4tf1EWBfIQWA1PIYHdXTOhur0JlHUpmWVMcPY?=
 =?us-ascii?Q?/46pvj4G9iyRPp26BJusYWIZAInyvjI6mtJJC2itW83u8jQXBayc1TrHzgl0?=
 =?us-ascii?Q?M/vjOtm3QO70vmeyNFwpr8t5+DcecO3FmF7uvMmqcfq8ppzAVwb3u9Mozgde?=
 =?us-ascii?Q?AzCLPd5JeBjj5o5XLcas/aVp4YgiREX2sW/RGNadUKu0CuOzpNJDXxTy0hFi?=
 =?us-ascii?Q?agjxfzRtznL9/Vk312bTSnJSWcF05OkfmV2pPNRT+Vsxh302MQMeQ3CSKFL+?=
 =?us-ascii?Q?xGx9W3KFf04QQ+h+oTWqY0I0rCoEqHISA/X5Gc1f00HNlHrAZLdArVZXPPNI?=
 =?us-ascii?Q?uxutNQwO/QNCjG5K7jMx2nu6tUDB+O0dWS3d9C2dSnh5Uj0TQj9mecJ1Xh8o?=
 =?us-ascii?Q?9KIcoKm4TDHgdHLiVBnqKy6H0CAw8rqcXjL1i3l5QLp5xM+kTdN1q7CrC6yZ?=
 =?us-ascii?Q?OPM/T3SWgy5sfQAaQkFtnYDDP5/dG5uVHcbeyyKWRrV91uuqwJ3QvO8YUyIz?=
 =?us-ascii?Q?MM0M4k/BqY4mw05KO+T6whyZwWuKL0iGpe/v0m+g7aF7lAIw5bLUAt70/6qe?=
 =?us-ascii?Q?Q78828xYgM1VBBA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:05:26.2024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb02c97-c2c9-4a86-ec22-08dd5ba35793
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042

An S2 nest_parent domain can be shared across vSMMUs in the same VM, since
the S2 domain is basically the IPA mappings for the entire RAM of the VM.

Meanwhile, each vSMMU can have its own VMID, so the VMID allocation should
be done per vSMMU instance v.s. per S2 nest_parent domain.

However, an S2 domain can be also allocated when a physical SMMU instance
doesn't support S1. So, the structure has to retain the s2_cfg and vmid.

Allocate a vmid for a vSMMU instance in arm_vsmmu_alloc() and add a proper
arm_vsmmu_destroy() to clean it up.

Add a per-domain "vsmmus" list pairing with a spinlock, maintaining a list
on the S2 parent domain, to iterate S2 invalidations over the vmids across
the vSMMU instances created for the same VM.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 +++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 35 ++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 47 +++++++++++++++----
 3 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3336d196062c..1f6696bc4f6c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -849,8 +849,12 @@ struct arm_smmu_domain {
 
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
 
 	struct iommu_domain		domain;
@@ -1049,6 +1053,8 @@ struct arm_vsmmu {
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *s2_parent;
 	u16 vmid;
+
+	struct list_head vsmmus_elm; /* arm_smmu_domain::vsmmus::list */
 };
 
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ff8b550159f2..2c5a9d0abed5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -30,6 +30,23 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	return info;
 }
 
+static void arm_vsmmu_destroy(struct iommufd_viommu *viommu)
+{
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	struct arm_smmu_device *smmu = vsmmu->smmu;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_S12_VMALL,
+		.tlbi.vmid = vsmmu->vmid,
+	};
+	unsigned long flags;
+
+	spin_lock_irqsave(&vsmmu->s2_parent->vsmmus.lock, flags);
+	list_del(&vsmmu->vsmmus_elm);
+	spin_unlock_irqrestore(&vsmmu->s2_parent->vsmmus.lock, flags);
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	ida_free(&smmu->vmid_map, vsmmu->vmid);
+}
+
 static void arm_smmu_make_nested_cd_table_ste(
 	struct arm_smmu_ste *target, struct arm_smmu_master *master,
 	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
@@ -337,6 +354,7 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 }
 
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
+	.destroy = arm_vsmmu_destroy,
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
 };
@@ -351,6 +369,8 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
 	struct arm_vsmmu *vsmmu;
+	unsigned long flags;
+	int vmid;
 
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -381,15 +401,24 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
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
+	spin_lock_irqsave(&s2_parent->vsmmus.lock, flags);
+	list_add_tail(&vsmmu->vsmmus_elm, &s2_parent->vsmmus.list);
+	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
 
 	return &vsmmu->core;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0462eb1b2912..addc6308742b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2249,10 +2249,22 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
-	} else {
+	} else if (!smmu_domain->nest_parent) {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	} else {
+		struct arm_vsmmu *vsmmu, *next;
+		unsigned long flags;
+
+		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
+		spin_lock_irqsave(&smmu_domain->vsmmus.lock, flags);
+		list_for_each_entry_safe(vsmmu, next, &smmu_domain->vsmmus.list,
+					 vsmmus_elm) {
+			cmd.tlbi.vmid = vsmmu->vmid;
+			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		}
+		spin_unlock_irqrestore(&smmu_domain->vsmmus.lock, flags);
 	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
@@ -2342,19 +2354,33 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
 		cmd.tlbi.asid	= smmu_domain->cd.asid;
-	} else {
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+					 smmu_domain);
+	} else if (!smmu_domain->nest_parent) {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+					 smmu_domain);
+	} else {
+		struct arm_vsmmu *vsmmu, *next;
+		unsigned long flags;
 
-	if (smmu_domain->nest_parent) {
 		/*
 		 * When the S2 domain changes all the nested S1 ASIDs have to be
 		 * flushed too.
 		 */
 		cmd.opcode = CMDQ_OP_TLBI_NH_ALL;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
+
+		cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
+		spin_lock_irqsave(&smmu_domain->vsmmus.lock, flags);
+		list_for_each_entry_safe(vsmmu, next, &smmu_domain->vsmmus.list,
+					 vsmmus_elm) {
+			cmd.tlbi.vmid = vsmmu->vmid;
+			__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+						 smmu_domain);
+		}
+		spin_unlock_irqrestore(&smmu_domain->vsmmus.lock, flags);
 	}
 
 	/*
@@ -2477,7 +2503,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
+	} else if (!smmu_domain->nest_parent) {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
 			ida_free(&smmu->vmid_map, cfg->vmid);
@@ -2506,7 +2532,10 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
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
@@ -2514,7 +2543,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
 	if (vmid < 0)
 		return vmid;
 
-	cfg->vmid	= (u16)vmid;
+	smmu_domain->s2_cfg.vmid = (u16)vmid;
 	return 0;
 }
 
@@ -3233,6 +3262,8 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		}
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
 		smmu_domain->nest_parent = true;
+		INIT_LIST_HEAD(&smmu_domain->vsmmus.list);
+		spin_lock_init(&smmu_domain->vsmmus.lock);
 		break;
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_PASID:
-- 
2.43.0

