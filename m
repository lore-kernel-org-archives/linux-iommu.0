Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEB429CE0
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062547; cv=fail; b=sM8d+O818pI8oOb0lpBBwuYvQrl8TV0Y4/TOnUnuXqge8y+GIdr4tmu30hIQX/I9LmW0QFzZ4lqKW9GyJqHm7VrxkFxGRDaNn5gHN4ovCfs8QWWAUIoUfCxPgMiTxlRM6hf8soemLi/KDGePwMdcDeir7i/5u/9Ejut3R9UpEVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062547; c=relaxed/simple;
	bh=LOGeWng4ulWNRJ4YLYEVYCfG96wBMHK2Ns5paR2koWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LokTrkKwhcnj23e39hEJ0u6t8e7/Rz5+SeK+X+w15zdmT8FWwWQUVupaVU5awELBmk1lLVBbvoQBp2SAH2JvLQm9189mc0VQVleRg4zsGARLz2GbEdSGXKI9cIKVB3cbxcs0LPEL9btsG+DTN4VtkQf7MLfL8LT3jqRE4ZjIq/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jy7dxwq1; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jy7dxwq1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQBxFafS9o5YYL50z9GxcraqBI/trfrySj/Cp8wcCZUGL3joMvpRDajtbIOe3erfSC/eScnS5YIqqNUBZSwAqzy8AM/SeFSajbO+cR1oCmeFin1phiYtk/IJP+edccfxv3q0XJkDYe1g2LiFebILzg7go4hvcPWorLc7R/yzL6FTDrw+LI19hAmm26vosQZIaX8h3r0YB/u2+EklW/6VriZQ/IXTuqe+kqUgf/dbx1Fcry6TX3FnpK4HX5PfdCeBgKaM+P6I1jvVv9aVM7+E0bg75/SMFrnNXT9z2GBb9XsMQRRciv+VlIEMVy7FVEgxaY4VVeGa7AlvVkgpmLOOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D60KOzU+x046LlW+N6Byta9VYld6RxG3Tnde/knXFJE=;
 b=nzbAj67axmWmOqRwzUj7KPdQP2ymOH8RDgCi0Fx0bfQDJWkMja7fE1nzi2bpuBcl9ktXl/pM/shTSOkvbFAZEe6pJs0R3lTE3Tnz4qMVR0WhzWiQbsMb16t5WuJ4dwF/fBbflKQJDKd8G3xs0TEq2DYZbm6Qk9ge/8IXIFZiVVXyfIWBJqxVCeyXxF4gJRRai+PAWrpLDL35clyzXna3tNvLTG/UmVFY1XzQsAjKrMvvGrYnW8bL3lded7f/1YPzfB2aWNZFns2rYYBWOpSZ2//4SDjLUQ8qDaq3tknti4X2tWdOZboG3VlcS0vbLXuCCnlgNCQc1Iju6pUzlUzZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D60KOzU+x046LlW+N6Byta9VYld6RxG3Tnde/knXFJE=;
 b=jy7dxwq1hW3JaUh0OhRtpqqJ8W06PxZ7okCllnvr1AiuufRoHwQb7oln5S56FsoVQ4V8SBSE/5EYqLuJYRts/J/KFmsC/oFtA+JYA+95GtoVVVGhCbfAkl6noU68D9vByCHyTJTyaDUJIeLYMLkH54Up5mCUBvKxr9i5Cl8KXh+SUP+wrBC3OaAb0tjZZX+oC5IMEb9b04pJSXbg3T0FCO5LBnNr+OBV/C5uHe6KmlrnIwNjLU/cJ9YxvZTZW/qzo6DQQT7nXwhj9txCrdTDBscWGdQPwCLBM8FJW2UOnoh3/v3+3UFLTWlrJj4AQ86UEhMRCXbxKj3Ov42BaEpZ8w==
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 20:55:32 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::92) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 20:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 13:55:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/11] iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()
Date: Tue, 14 Jul 2026 13:55:02 -0700
Message-ID: <c484a614085dbde995152c49ca38529252f79a8b.1784059577.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784059577.git.nicolinc@nvidia.com>
References: <cover.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5ecdfc-ed34-490c-b8a6-08dee1ea3e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0YsVnIfoEN4CobQUDtKT2mXRgMbMM2Kg+YNolMIc/ruKOBWWNb4GnqUzTrVrnqcNXh7wQTT7m4OdF5BXNWpL2tDNBDDZN+QurRiWDGRnso34BCcEJBpxd4wM3afQda7fExeavlfQNopCexuo/NK6pq9LIpl41VemSD2YuBCMplIsTyaSEZHdq1b2KSTsNw+GWLNYvHpCm+3O2rxhcV35whsMIM6JagEV+20KQs/D7jNCjUcqfaBWf1TExZt/plWLYue6RoFOz/MIaMg3kNDIFa7hIRxgs366dKXrYy08U3ZzZFLre8AqSA17oddNBaBqYMW1nBpUQFmHE6aZ8pG6yDS6EPIbNKL+9tlUMJvuPPR/HDQwsC8wy/56Wk3FJI4wmVzBVEiSSlQ6bwS7aO1GZBFuwLKFVWfEuxFZKbbWAZV8mfe1UlyQQjUdv2jVf6MazLUBOE1BSy9Vi/pnwq7izuck7a0BIY85tHphSUvHXh9Kc0nyRrC1dHGqKwacVcYQyi453ZVfi4l1AhN4xflW3PCvoG3d0jbSS9fHfq9TK0VRiU9+9DOlZNqIbM6LNJcj8oBQCPNP6rRVmpFKOGxQ163DzHH1gWRIjtZrasKXKeg6JAp9r4VJ5erMCtt67Ydr4zfYcLPI/PKsWWBKrqJXSLKgmzcmRAcDUDJmLN3ET9jj6WZ8sph+ewadBvc2l3EJijYATDfl3AIBr/rmCXJLWA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zqYWjo/8UfUR1XgNc0FE58UzU0FPOMXhNIlw2x0Xl1A8v0cJ7kmbhnMiFMUBiwTxw2X9x8fdB3ZQ2OqYFEPFV6ltc7hyxLoe6LEdaeS13PqEBK0x90KlaeAgN5Eae0baa0mrb8xZtv1E5QJ4HgkEFI6dP3pIzKdbYrFdAW9wV+hiQL8TVpw9OxeOzzOPmUQnz3MVjcXXeNQZkfAsMpAVb0+ML3Zzcft28vp9rgPT7XgsmMbHhTuOIDe3AvCoZJSXU//xuppWWgFrazHF/XetocIO9j7xo0FU7QfF+Qd2BGxOQsw2T7yKm8izWkOc90iyl9XaH26FSZW9lKJSgGF0lUULw3rQ+xvD+y4gikkfjZfTm07IDNp/4ohDC9GTiq15gTFOiszkhf/u9P3s1mOTTrRsZx4WNKMa06dshN7TWdsQsKVz86s+04pyhwCmyiOv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:31.3122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5ecdfc-ed34-490c-b8a6-08dee1ea3e25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959

__tegra241_cmdqv_probe() uses devm_krealloc() to grow @smmu into the larger
tegra241_cmdqv, which frees the original @smmu once it relocates. A failure
after that returned NULL, and the caller then dereferenced the freed @smmu
on its fallback path.

Return an int and take @smmu by reference instead, then update *smmu to the
reallocated pointer after devm_krealloc() succeeds, so the caller and its
fallback path both use the live @smmu rather than the freed original.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 54 +++++++++++--------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 7e366030d9d70..262798cd6b8a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -934,16 +934,22 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 static struct dentry *cmdqv_debugfs_dir;
 #endif
 
-static struct arm_smmu_device *
-__tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
-		       int irq)
+/*
+ * Probe the CMDQV and reallocate @smmu into the larger cmdqv->smmu.
+ *
+ * devm_krealloc() may relocate and free the original @smmu, so update *smmu to
+ * the new pointer once it succeeds. The error paths after it do the same, so a
+ * caller falling back keeps a live @smmu instead of the freed original.
+ */
+static int __tegra241_cmdqv_probe(struct arm_smmu_device **smmu,
+				  struct resource *res, int irq)
 {
 	static const struct arm_smmu_impl_ops init_ops = {
 		.init_structures = tegra241_cmdqv_init_structures,
 		.device_remove = tegra241_cmdqv_remove,
 	};
-	struct tegra241_cmdqv *cmdqv = NULL;
-	struct arm_smmu_device *new_smmu;
+	struct device *dev = (*smmu)->dev;
+	struct tegra241_cmdqv *cmdqv;
 	void __iomem *base;
 	u32 regval;
 	int ret;
@@ -952,25 +958,28 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 
 	base = ioremap(res->start, resource_size(res));
 	if (!base) {
-		dev_err(smmu->dev, "failed to ioremap\n");
-		return NULL;
+		dev_err(dev, "failed to ioremap\n");
+		return -ENOMEM;
 	}
 
 	regval = readl(base + TEGRA241_CMDQV_CONFIG);
 	if (disable_cmdqv) {
-		dev_info(smmu->dev, "Detected disable_cmdqv=true\n");
+		dev_info(dev, "Detected disable_cmdqv=true\n");
 		writel(regval & ~CMDQV_EN, base + TEGRA241_CMDQV_CONFIG);
+		ret = -ENODEV;
 		goto iounmap;
 	}
 
-	cmdqv = devm_krealloc(smmu->dev, smmu, sizeof(*cmdqv), GFP_KERNEL);
-	if (!cmdqv)
+	cmdqv = devm_krealloc(dev, *smmu, sizeof(*cmdqv), GFP_KERNEL);
+	if (!cmdqv) {
+		ret = -ENOMEM;
 		goto iounmap;
-	new_smmu = &cmdqv->smmu;
+	}
+	*smmu = &cmdqv->smmu;
 
 	cmdqv->irq = irq;
 	cmdqv->base = base;
-	cmdqv->dev = smmu->impl_dev;
+	cmdqv->dev = (*smmu)->impl_dev;
 	cmdqv->base_phys = res->start;
 
 	regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
@@ -982,8 +991,10 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 
 	cmdqv->vintfs =
 		kzalloc_objs(*cmdqv->vintfs, cmdqv->num_vintfs);
-	if (!cmdqv->vintfs)
+	if (!cmdqv->vintfs) {
+		ret = -ENOMEM;
 		goto iounmap;
+	}
 
 	ida_init(&cmdqv->vintf_ids);
 
@@ -1012,24 +1023,23 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 #endif
 
 	/* Provide init-level ops only, until tegra241_cmdqv_init_structures */
-	new_smmu->impl_ops = &init_ops;
+	cmdqv->smmu.impl_ops = &init_ops;
 
-	return new_smmu;
+	return 0;
 
 free_vintfs:
 	ida_destroy(&cmdqv->vintf_ids);
 	kfree(cmdqv->vintfs);
 iounmap:
 	iounmap(base);
-	return NULL;
+	return ret;
 }
 
 struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 {
 	struct platform_device *pdev = to_platform_device(smmu->impl_dev);
-	struct arm_smmu_device *new_smmu;
 	struct resource *res;
-	int irq;
+	int irq, ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1042,15 +1052,15 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 		dev_warn(&pdev->dev,
 			 "no interrupt. errors will not be reported\n");
 
-	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
-	if (new_smmu)
-		return new_smmu;
+	ret = __tegra241_cmdqv_probe(&smmu, res, irq);
+	if (!ret)
+		return smmu;
 
 out_fallback:
 	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
 	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
 	put_device(smmu->impl_dev);
-	return ERR_PTR(-ENODEV);
+	return smmu;
 }
 
 /* User space VINTF and VCMDQ Functions */
-- 
2.43.0

