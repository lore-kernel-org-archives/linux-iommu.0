Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89A33BBBD
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056732; cv=fail; b=l90n8n6fE2oUf8nH0vMQiopp9ah9g37DMWqU9cENyVfVGQogxNlOv0yr39Anqiw5ppMlyVMLTMtSvmEQqBmBhCUkansJ27euCS9ffON545xptS6unhdiXoFD5QqKNpGCjnGtaJsDe34tr9bA20MyCS+D0gj2HvEVUvBivWJRNQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056732; c=relaxed/simple;
	bh=LOGeWng4ulWNRJ4YLYEVYCfG96wBMHK2Ns5paR2koWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vytsq4Tpcn0jIu31NyT7J6Q9a4W6glLvBnVXe5cDjXYfQvaqy8SvOB1hToSdPC5IXulbb0fi9g3ORskfBFDoiTVlxzQaLjYVbnMKKl47KJKre/qAMJvpzsu97p3OMc8v/fuQmPHRT7QUmR6gOmDsX6oUOw+DjBplAdyoS7b8Aac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=apIBTak/; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="apIBTak/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edaK30SBNRZQuHbC5j8UEn+W3r7MEW7RW2g7xV35ZOLrH9GkpjCoXvbHMRejelBlKLE66Wu8InXmI1nYwrzw5qYrAoT/IEnhcQ9NO5cSXI2T7db2s+5HWAug2aanka60B8uP3X0MG+o9OM/5kuiBv6refU4ljpBIEzfKiHTE58cEzzWrlPqDmkmTHW9yt6y2TIQOu6fhUgA2uzB4ECs4Ww+t9W8JWEtYteu6NlH2ZMZ3uXlmjRz27ucAObOSw2xX5ym8HERlsbf31ktMBxaTCQ2htdiQ2Sn4Ca9Us32204z+IMksS14UjNLIhU09llaY4ydU0VdoWC8E7tCi3M375w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D60KOzU+x046LlW+N6Byta9VYld6RxG3Tnde/knXFJE=;
 b=RBTpN1u5IZwLLeIxg0vYoU2BJ4LHwR92ej7ONJb4WA0wjezkOJPbxUabn1m8EGygoTDW1rdZDgf6j0hsrpazD7+jRfjUyF6afdMiOj1/ij3xjgoO3BZZr1z/an+iOWuq7mFAJ7HLg76Dzypv57Qb/ZeFHZHXkEBe0jnW1DKgDyFbuUXZyX6XnW6mCzzVE1bJ1fsYRtvk5ysaTaoVf9P7PkGRUNxPpWutwkPTCxcJBHI965q5We2SD305DPUIqqOag1OQWoqelCNvY6rSf0oqigI+IapqTrPXjerbDI8hxljfrNSE1WoCSWBzHVHGgynGMFIhxD4rq0OiOZ7fhG+VfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D60KOzU+x046LlW+N6Byta9VYld6RxG3Tnde/knXFJE=;
 b=apIBTak/PfGemtXi8YzrAFHpxWM/8MC194HvAo+fMR/jlMlsQ2PYDHw8o5t5vyNgCunSI/6Lf4j+qBJT/qTD2s4Kk0hTnu8oG0NqJS8BbIRH0FK0DUOkwHc56Yi4ZCd3aNowOuMb52w7O8u7A03jp304oZSgHZDE+wPaMZWnLNyD0KWIG4CqAM0x0N2gboyiouLMs4KXiG+BkJDJh03yeWY4vG6n0OqkdHPWv8n8yuQSAPC0R9WZdzs9gROHI9YL7A/E/5rr1zR/pJWvtOENOEz1/Bi8wpQgPRIp4N9mYRjDwVh25UrjoKh62lyTgGXC1P+zpJYEhJAKZ1aPAtVUOw==
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 05:32:00 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::30) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 05:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:31:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 05/11] iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()
Date: Thu, 2 Jul 2026 22:31:31 -0700
Message-ID: <c484a614085dbde995152c49ca38529252f79a8b.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: f98e1aba-5031-40e2-e244-08ded8c467bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	S89BhnGjsAtmCFhldxTS60i4vHtJl4PJJZt81g+QvsFjoyqrZHHXNbSwp2MWVzpnNMg8Eu2UpvXsNR0eLX9LIz10gOO1Me2KvUQZzv/a0SGvllrPLHgpZUnmd1v5JSqv4NXZXUZM24Ec691EzAXcSnREhMUpdNuwfF2uq+9pTxw43eU97CiD/ot7fLXElSlaVcI1SQu5PsqfFM+nQ0CGOha8kt6KKgn6niLZynbRCct031fJPTL6ITt0HQPFPwEw/dgMYwCKy5R4e7uguk1UaoU8U7DYPpKf7cwrfyCBOG0Xyn4xZXw0aBf7f0/pDCRQmHaEHMf7hvy4rmryAm6BjLZ2vLA5nZMf/sQMA8KW1hGa5EQbgKtJmwSUNjAiZMjGhLgm7XIZeh4sf0cwolromrwtxaUmsy0mW26qaZkK6W9hDAkSNOWN8yxUkZmC7hvtdMt/nkaQd7gSAVdm3QMF54Rn7heFvePjm6I9APA5cLGiWqB2CjFF+8ci1GMMUT5/GEl10XCEV8qydO3G6PZQT6lihsvXC6irbIjCP+j8OaFfqdt6gKJodaILapW26I9N3NX7Ro5g6AkWf12gjPqGEQpnSmxX+CMKNM8TUfEYILXLr1l/h1gufxveEyCFFyIV2XZf9KliEPlI2vhRQlr/OUlVWcH8zRtIKhdS9zYsrHMIPdoxtS6/TfWviOO/GR7/NSaZztWvqjEzY+IFiRI2sg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4wFRqtRrQojai33lD9q2pyiqQND7Wb7nUaebXct8NOJStUBfN2eNy2cMUDsHpI1K1Ez+A26BBDb5qlafyJtbRAG0Xw9zXI0RMQxy1i5/ij777yxmlGStXCBnDAdDypC1RD32pytjSa3xmHlJfbxeTQEVlcimnB/X9qf4/vo7NxnH8SFKKffqmpxW2cPkPusms+rPsfmv8k+9U8GkrjC7Hqr/wrRKIAIhlKCPe23J0h8tLQ/hLmMgK++Q5CxL4mKvMMjwLWtr8yRRqNLhLaaAeSKgRS+aSzgdyZ6+NTJFiw31Iu7TuglcVhISk4uI612V7n0qcJYTBz1wnKrETsY8OLm8Zj+TffV3gBwW8Y2WI/g6GPxLWpyYNcD8+vEIiabhttVcZk6WVDdf+QdXgjQZDmAeA29PnIiIjelYRIXXVCUyoGX7y0g8V6QO9DzTkmjZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:31:59.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98e1aba-5031-40e2-e244-08ded8c467bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

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

