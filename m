Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E3145335
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504072; cv=fail; b=FXOfb8m9CL2ZbZDvywn5q17673hYK4hiNK70/I2SPARPpimGclooiO3trjhWMW683mN/VWmfyaGLKrccdLeY/xh5uv+yKUqeSgx4RYDQCjSo1d+bhp+BCW/ye031ac3nbDwCoMonyXdmdFgJsLxnfH1R0FL/Ao9QeYqGdc+XtBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504072; c=relaxed/simple;
	bh=NgT8rAv48QOVNJn96qRFwnFPkbaKE5GtaWhDbyU8qUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr5sqsQFJD+Adikb3Eo+yx+sH+Gmr3tj0mS4yXoxaKcjQu7sOq5T1WNy5g8NMCk18w7QBaF7N2sbgsO56R4aBpHLQfn3vz9ucfC8HCAfOPIHoH5V3f5w/q1XPcyMBCCtBkuGxCUnkzXyN+H/v3odYOBdlyYVobvKdayMmBUuFu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvaR7nKN; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvaR7nKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/nnfdeoelr4nWtCVn0vvf1jBGaGnZjgadyRXaC0+9tHMA5Esf/cYp9H3xiO1UMoVAq9fWF82y1o+SPZdknIGBXUwLnM+EsLDZczVDQ1/WC7yvI6Z/WjQR8sWfVj5csv5Y6Rw0M/gzF4A6squpJiKZUkPTvwW+Qec3XJFt+p0ji26leWhTSKNeT2aEX5P/53im0nnxhZ9paqwIZDf4Wn++oAC/VK8zCf2sweRHD7PACIIvGHCPyEnasiygkssJ2EwbFCCisXs2TomqBFsUik9v52s8XfCz9FHIoxOp8rNG+pT7wU0sxHsXu+97rrZMW8k4SvxM0hcaOlrh3NLs0UgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abpJ01yXqWzHSwdHcxSO5egUrtHullt1I6iWH4W145A=;
 b=QaGdcjYxtiSRZWIACSbtTZRobvZ3AvpGFFChJ9AHgqWFqr21b3oV7xtilF0sym26nogauuQJeXdingIH/Ezt63d1uK6h4s7T48ef1ypPUe5XXwyu1n+wEzU7NCEhrYlFanMeKvirbfbQIrR2F8f+O0pskT+hMnIosGrRFgI966u8k/jYRSWYGE6Atluy44ZsmPrLTXAoHUVh34v9IjnuxOW0akosfnSXF70bg1J9Pu012BS9CdcOFE2+ZowKHSDKXvUJKFhDRDr+D3ZnqXbTxWYwC8DWQDUmzBdkucqx47w25okeOPWtb4paHx8aVBdrG4zv1yDv9dySxxf7C9heRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abpJ01yXqWzHSwdHcxSO5egUrtHullt1I6iWH4W145A=;
 b=jvaR7nKNYA5TjYhZCcW9N/xacctqvCQAqLi3o5zUzIqMQZKLirzmc5CPIgOXFz5jso/0Ymkznyqhs/h+Ov00GD+bWZcwINluBtuhf3gevO8QLsm75BwIgZ+w4atbXEuEaJaepgaDTzEEm2wgI82YRFUeAKwP1fdpAB5s/XbC/0AF44u+CPRtU81kr6UV6cScHO4ocsevAd4hvQXIXobFqtGKEKf+2hXbvt0YPCC1sgdoCdrcS4L5fD+kv1A96eWzse20gy3eHTcWXgZsEFay2QOF4dG18hDwFq5mu2OoHSnUhZfad5vIYGv2c7mV4aAv6SaxBNW4uV+Jgbh7nD8mpQ==
Received: from CH2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:20::30)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 02:41:04 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::7a) by CH2PR07CA0017.outlook.office365.com
 (2603:10b6:610:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 02:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 02:41:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 19:40:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 19:40:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 19:40:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <mochs@nvidia.com>
Subject: [PATCH next 2/2] iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent
Date: Wed, 4 Sep 2024 19:40:43 -0700
Message-ID: <530993c3aafa1b0fc3d879b8119e13c629d12e2b.1725503154.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725503154.git.nicolinc@nvidia.com>
References: <cover.1725503154.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1f3e8b-5536-48b1-1885-08dccd543009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+tiWCQfF2pLaKX6zc9hue/m1I9/xn/B3S/LiWmU/za0rAv+MOoRbBBOaYMF?=
 =?us-ascii?Q?mHozosmtrB0efTv9fFFHy3ENtesOkrsOzQq6jNXfkpzJ9ahjOBn6kwqcOVVQ?=
 =?us-ascii?Q?Fil34IkgPrTPBxBEoPz0aNdVJ4V2mLOr8eJNd4aiVjixLKU+dHbswd8/dH9T?=
 =?us-ascii?Q?Z40qT5Bc3nlodzDxjers2lxDMXH/OW0085hNr0/lP+2wIjVUXq2YeLWNves8?=
 =?us-ascii?Q?gKA/wt8slcgZZlQrQxnpIrLjn05tV0hgcSNCLrcFYNgRfGRubqhsSit4+4Dd?=
 =?us-ascii?Q?5QFhlTPk6Rqw5rCI1O0gfVDGS85cz3uyEtaNrP61cD9nL0XlmHAyGnQ7NB5T?=
 =?us-ascii?Q?XIvP1L5k2Svx9PZJnzSSYJO0d2+u4wdInl0+YwI8emeKzpnGbfcnyUI9WT7R?=
 =?us-ascii?Q?v09D5+xiNZi0Y1ybA/MXgRWgPnR1QcYEE8RIhdLYUsvbgQZ9G7WGreZhF1os?=
 =?us-ascii?Q?IFdQrzKFGld7rbOZWpF47tSwSyOLex+dMQbdT0BjnXpct21F2QSe8CQyoKnS?=
 =?us-ascii?Q?OT2HRT8jKuGexhNHmqKFT/3KOnQ/tMMus0J+QUVwWeF0ioYneQhR0E0pa9C8?=
 =?us-ascii?Q?ZC9cn51zymiYfs6d8yMa8pSkpVGl9MUWIKmPtlI0o+7PlkHS9feKgSNBzhPZ?=
 =?us-ascii?Q?M/GDyxonSaXsw3D3tHayXkmyk2JJKBPdlhS+NyHCtMBf6Podro1VP4kQ4kfN?=
 =?us-ascii?Q?md19FtEqYKRcbjp7Rg1sg6Hc96/YsCvW+PWFBZdvWKaC9Ml7a09HSuDcS6zB?=
 =?us-ascii?Q?R4iJ067dKaHdeSVZS8nYV6PARvur9tEiV0PbfkFBNd67IqrlN5Z570DJwDPP?=
 =?us-ascii?Q?xL7qRKp0xCPluZ1aBWTbYCHnKr19dtAqR/qI5y3Y0C+L5azXUBelq4aZkzKO?=
 =?us-ascii?Q?c1ERcpz5Pp9Lp882dKqDIegTEF9otnfFSIRlv53H+GfANOBDUAPVB6+BQVVC?=
 =?us-ascii?Q?bf12yPN9qiagDNL3JcT20ZvqJA2jTdC8OJlk+TJt0P66VDR+9q5t5RJFy4GC?=
 =?us-ascii?Q?DFfIskFRBVIE0FACk8GJAz18DNi+FC0a/avEmRfUncO82NJa5axposQdttuO?=
 =?us-ascii?Q?DvvlyEL5/7OueW3a0MzFSc7jtlneCH6ryOweSmWuF+N7QgM0tPWnxwcrHih7?=
 =?us-ascii?Q?1lDK6epWMKRhG6V0zy+P0IQzHzo+IXnfFKvl60bxoUqI/u6Wa/al4vbrZ+LY?=
 =?us-ascii?Q?9tH5ahxiQXCv5nS/M3s9RdzINF/rYs2n4cSb2bF2LHIPLM4f7gSx7ZBclUVU?=
 =?us-ascii?Q?l9K3dSu7moUZxv7z/q4AAAbopQoHcrD+XAIMV/Um4rsrzKowdsQqAPwoFP3a?=
 =?us-ascii?Q?gGUt67fi9QoT6xEXeDbazYY4BCPq1j54o2l+v5yJRjVV8YBxqvJOxszLnubA?=
 =?us-ascii?Q?KSR+0xe3F9ypG9bCxN/Nmus5Z3OR68/2Pxx2RF/z1kizUNUn6vmthVDv/ClB?=
 =?us-ascii?Q?o8ECwzZ6BqZs12gAaT2VQ0kJ/5f/xTq1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 02:41:04.5367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1f3e8b-5536-48b1-1885-08dccd543009
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

It's observed that, when the first 4GB of system memory was reserved, all
VCMDQ allocations failed (even with the smallest qsz in the last attempt):
    arm-smmu-v3: found companion CMDQV device: NVDA200C:00
    arm-smmu-v3: option mask 0x10
    arm-smmu-v3: failed to allocate queue (0x8000 bytes) for vcmdq0
    acpi NVDA200C:00: tegra241_cmdqv: Falling back to standard SMMU CMDQ
    arm-smmu-v3: ias 48-bit, oas 48-bit (features 0x001e1fbf)
    arm-smmu-v3: allocated 524288 entries for cmdq
    arm-smmu-v3: allocated 524288 entries for evtq
    arm-smmu-v3: allocated 524288 entries for priq

This is because the 4GB reserved memory shifted the entire DMA zone from a
lower 32-bit range (on a system without the 4GB carveout) to higher range,
while the dev->coherent_dma_mask was set to DMA_BIT_MASK(32) by default.

The dma_set_mask_and_coherent() call is done in arm_smmu_device_hw_probe()
of the SMMU driver. So any DMA allocation from tegra241_cmdqv_probe() must
wait until the coherent_dma_mask is correctly set.

Move the vintf/vcmdq structure initialization routine into a different op,
"init_structures". Call it at the end of arm_smmu_init_structures(), where
standard SMMU queues get allocated.

Most of the impl_ops aren't ready until vintf/vcmdq structure are init-ed.
So replace the full impl_ops with an init_ops in __tegra241_cmdqv_probe().

And switch to tegra241_cmdqv_impl_ops later in arm_smmu_init_structures().
Note that tegra241_cmdqv_impl_ops does not link to the new init_structures
op after this switch, since there is no point in having it once it's done.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Reported-by: Matt Ochs <mochs@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 83 ++++++++++++-------
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b2de56dfceb9..df852ab04fd7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3744,7 +3744,14 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	return arm_smmu_init_strtab(smmu);
+	ret = arm_smmu_init_strtab(smmu);
+	if (ret)
+		return ret;
+
+	if (smmu->impl_ops && smmu->impl_ops->init_structures)
+		return smmu->impl_ops->init_structures(smmu);
+
+	return 0;
 }
 
 static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e044ce5b5372..e8320e9341d7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -643,6 +643,7 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
+	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 0766dc2789cb..fcd13d301fff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -755,18 +755,65 @@ tegra241_cmdqv_find_acpi_resource(struct device *dev, int *irq)
 	return res;
 }
 
+static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf;
+	int lidx;
+	int ret;
+
+	vintf = kzalloc(sizeof(*vintf), GFP_KERNEL);
+	if (!vintf)
+		goto out_fallback;
+
+	/* Init VINTF0 for in-kernel use */
+	ret = tegra241_cmdqv_init_vintf(cmdqv, 0, vintf);
+	if (ret) {
+		dev_err(cmdqv->dev, "failed to init vintf0: %d\n", ret);
+		goto free_vintf;
+	}
+
+	/* Preallocate logical VCMDQs to VINTF0 */
+	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
+		struct tegra241_vcmdq *vcmdq;
+
+		vcmdq = tegra241_vintf_alloc_lvcmdq(vintf, lidx);
+		if (IS_ERR(vcmdq))
+			goto free_lvcmdq;
+	}
+
+	/* Now, we are ready to run all the impl ops */
+	smmu->impl_ops = &tegra241_cmdqv_impl_ops;
+	return 0;
+
+free_lvcmdq:
+	for (lidx--; lidx >= 0; lidx--)
+		tegra241_vintf_free_lvcmdq(vintf, lidx);
+	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
+free_vintf:
+	kfree(vintf);
+out_fallback:
+	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
+	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
+	tegra241_cmdqv_remove(smmu);
+	return 0;
+}
+
 struct dentry *cmdqv_debugfs_dir;
 
 static struct arm_smmu_device *
 __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 		       int irq)
 {
+	static const struct arm_smmu_impl_ops init_ops = {
+		.init_structures = tegra241_cmdqv_init_structures,
+		.device_remove = tegra241_cmdqv_remove,
+	};
 	struct tegra241_cmdqv *cmdqv = NULL;
 	struct arm_smmu_device *new_smmu;
-	struct tegra241_vintf *vintf;
 	void __iomem *base;
 	u32 regval;
-	int lidx;
 	int ret;
 
 	static_assert(offsetof(struct tegra241_cmdqv, smmu) == 0);
@@ -815,26 +862,6 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 
 	ida_init(&cmdqv->vintf_ids);
 
-	vintf = kzalloc(sizeof(*vintf), GFP_KERNEL);
-	if (!vintf)
-		goto destroy_ids;
-
-	/* Init VINTF0 for in-kernel use */
-	ret = tegra241_cmdqv_init_vintf(cmdqv, 0, vintf);
-	if (ret) {
-		dev_err(cmdqv->dev, "failed to init vintf0: %d\n", ret);
-		goto free_vintf;
-	}
-
-	/* Preallocate logical VCMDQs to VINTF0 */
-	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
-		struct tegra241_vcmdq *vcmdq;
-
-		vcmdq = tegra241_vintf_alloc_lvcmdq(vintf, lidx);
-		if (IS_ERR(vcmdq))
-			goto free_lvcmdq;
-	}
-
 #ifdef CONFIG_IOMMU_DEBUGFS
 	if (!cmdqv_debugfs_dir) {
 		cmdqv_debugfs_dir =
@@ -844,19 +871,11 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	}
 #endif
 
-	new_smmu->impl_ops = &tegra241_cmdqv_impl_ops;
+	/* Provide init-level ops only, until tegra241_cmdqv_init_structures */
+	new_smmu->impl_ops = &init_ops;
 
 	return new_smmu;
 
-free_lvcmdq:
-	for (lidx--; lidx >= 0; lidx--)
-		tegra241_vintf_free_lvcmdq(vintf, lidx);
-	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
-free_vintf:
-	kfree(vintf);
-destroy_ids:
-	ida_destroy(&cmdqv->vintf_ids);
-	kfree(cmdqv->vintfs);
 free_irq:
 	if (cmdqv->irq > 0)
 		free_irq(cmdqv->irq, cmdqv);
-- 
2.43.0

