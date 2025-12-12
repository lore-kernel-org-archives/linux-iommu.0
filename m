Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600A28468B
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519707; cv=fail; b=bCb8lj3rMBRycVb32AQFkoYyRVe2w9TxZA1hbm9mKHPWo827dcO1nS/H+FmYZxOIXilA6iVHsVbjYoNVZ0C7Wfc356CbqMT+HaBr4wHZPXBzK/E1Y0Uxb3dVB7nDmJfVDtNzYDTq5iEIcstTqBWwMCzNPgUmU7IH99NC6AtCV7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519707; c=relaxed/simple;
	bh=tddNIS83qPRh0NaI8Eh7toB8SrCG5KzlgMivBAmIr2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTsUiYqPDLpduABdbSLA4xQowdAz/tG0IA9kZ/7slYFX+Xg/q72ybsuK5QB5KrlhEfWVx6UUJ6sU+ddZV/MaNTJCulOreh3a4vKSFNNu3ya4bLKtXSz0SLpwMgMI1odLKXO/KrIP3sxJR+DQDtCy0Zyny5b7A14j+UquNBdXyY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZ5r1v/g; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZ5r1v/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5B/qW5UcCi4EL3u8gq5UZs7twJnepn8gRutnTSc7HI7HSMfvjFtQki7ELKEgKWDevocT3Zf0ivxNELRR4K/g+QoVv4K+8sa1Z/cwvQPu1hbRnAK3yiGh+smNX9J8V2GRpqvIMNdx3iBt9LChhhPiLa0ChVMIX/DMU71aF1WmvzBM+Z33XlvG+5k281FLYUHDQjv5LXDAvndvjUxq+0/ktenziAPpbEUJXXdwPhDpJPp98YyXwUEegsY9HqoVasGIkrmIjBZMCPbE13cZRqPkbEXI2qeiQe0QM/tL8Q8mjW1/HyJ6stQHxCjT/JxWfk63cjWaaG/6xONYyZCkswk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPgV8oQEt4Gvn9jLIueQlyMC3edLr4tqRhG5l9gSFtw=;
 b=bnDxHWkaLjCEp/7+gz38XbmGVzY33nAeqnJC3uJwakNvnJfyGkibLI3xrc6XZdXUR9ES1qMB9/3bEHsggu616rjKWaNf3Jre0jbqFugx/SxstlzzmoYs6cbcCDUdhN/FlH4rBj2SCspn/81KIBiRjEQOJQJSJ+21aDHXYTqLnpBIRLCzO5A+1RM0bYgT4WY3QOWypNuPpJTY2c+MAumHg8kIFyEUfRyKjvPar4y/FdmuZgtKCPynS7v7FydgFlNJAh8nPPVVMUlaDzfEzIgBzZclt5KQkVSNNyXn3USTY3ylg/5KGnlC65ic9F8FGGMjIzOn3X/7V6ZfeamEHPImsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPgV8oQEt4Gvn9jLIueQlyMC3edLr4tqRhG5l9gSFtw=;
 b=UZ5r1v/gIyXA/ZmL7MZwKDZxWtQKATFaF0I9NrAc177Dro6kkOBmOr8m0IpZzZD7QRvJmvcrV5C7jcrOWMX3lCHWdeOrpYtD8kDgt32i7iQSuKAVY/FhD8e4ewPhWSXRtNuuCqcTm+s0drNlgTuqgRw9rVnw7qwxZ4hRVwBdjDGmqgy4lh+XdCwGkHvwgIdughzM1BMK/pcwcLzGHVROxiQetbeGHABAhFetkpOORPi8/clDarMPXGjjX8m0NdFrl+3UFouUQ76dMb4HWHWIN0JjDJ/OCHof0sHyWvjJZJ/W5um3+9qgPXrt4A1rYNH0Fb3gAPFoioksRc2xKbcDiA==
Received: from BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 06:08:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::5b) by BYAPR06CA0022.outlook.office365.com
 (2603:10b6:a03:d4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 06:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 12 Dec 2025 06:08:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:07 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:06 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 11 Dec 2025 22:08:06 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V6 2/4] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
Date: Fri, 12 Dec 2025 06:08:01 +0000
Message-ID: <20251212060803.1712637-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212060803.1712637-1-amhetre@nvidia.com>
References: <20251212060803.1712637-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: a16591bd-ac0e-445b-16ac-08de3944d996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yJLc9PDF5SFCM1LKqpIH++bXQ2yOvUwGn848QoW05ZgZKd77SlvRJNxaVzY1?=
 =?us-ascii?Q?rDtJcF/3W2GdQv8zC/3yj88Bp0QlXImpss8t6uMEpY0NCh4y2HgUS+IiyXtI?=
 =?us-ascii?Q?UC5DelQO2G2gvwXrvGKv7uGWUjEJBcWvmd/ePFfk3v/OV7AX7OO7XYvG2vgx?=
 =?us-ascii?Q?wSwYg04sFGG5YSyX7AjflbQy7vuJ4WGXZZDA4GLck6p0AGLbzIS5qsGIesge?=
 =?us-ascii?Q?pFppKZaRgK6YXwdLboHRIeB9Uh6mDDL/YS7nfToazQsqxsv8gWg25yU6AjlV?=
 =?us-ascii?Q?FK9XfwKQSQTvw+j3jopvQSAaku/mS1AesPUZu6nYl+1e32l3L+3WAgf2Nq0h?=
 =?us-ascii?Q?Fk+4mZ3z9NkxDYCY+1NJICqhrjnFDskJryW3L1HOggVC/NHEr2QDdGOeGh/X?=
 =?us-ascii?Q?9TOv+oRJdNXcU/sOEsCb/5gCVnsj2SUQjALQJU7lx0Ogb69qKjPDve5hWIsP?=
 =?us-ascii?Q?mXGdGG5yXi2eqwqq9E2GQoefMh7Nhf6KwE66ERlN+rBnqEz5DziamRh96jkD?=
 =?us-ascii?Q?JIWeSWCEKMy6iuGsoRPc8lrHtLqO4CVMCPsCw1JxtdgXTYxslT/eMMj44O+j?=
 =?us-ascii?Q?DQsAp/kGg2OojT0l/bZVpamZIV3k1wdQGI9Q4kvxaUo8Zlxnp/jTBpHjP3Fi?=
 =?us-ascii?Q?3oc+iZv2O9JBEKWouMKwhpva+fkCjhA0sr3n9BiGEIZyoHpV/vC6R7IKwMGG?=
 =?us-ascii?Q?aeAsUA13TKqbHsZz+Ptm2sIBl9ugaupJhnSAHPJWKo4KVwi8nZkbEmyqZMaO?=
 =?us-ascii?Q?3AQN+zzdhWIxPJmoyPyZmBSIwr/wTsl9xe4oSkeOFlesOthVl6h0bL35H5cS?=
 =?us-ascii?Q?fDcftsN/Bq9OPkJUbEc+cnCEgaprOlNN01D1UBQYUhTbcSf3N2GfUZR6XYl/?=
 =?us-ascii?Q?qHpr6eFQGAHgVCtNGFSfgjam08bJ9cYgU/GdJwvS2qMDepWtQlp4hdgnyElQ?=
 =?us-ascii?Q?GQlQe4fO4jAf0U9RVTaJgxJQPkDIJj0crOyYQf9+6drnMeLWxvPOgQvDrm66?=
 =?us-ascii?Q?WtFCZrXNlgJia8ls9pnym4uUY6jYN54mHx4ow8CZRGwkvR+Vlp3dTVTaizGt?=
 =?us-ascii?Q?Zd8Kt5EoZnfYnWc7NbhqKXCdUOXcNF3cchcPGzkFMXEyKcp0UrRPo3tWbz65?=
 =?us-ascii?Q?q4MVBIcUt9WFubZBAmQXtDcHmI3W7QhE2XgWiyx/JSXsjlzgy8sewzWoHDYO?=
 =?us-ascii?Q?8ZIODRLCaKnyf2VWJdSy7FLopP6OM832HInC7iE5xXPGQqUskqIYxZag6yOk?=
 =?us-ascii?Q?hRSRvUUHptmYZ9wioUSf2mBRB/7UpegqmEkMfGa9pT3VuI7K5Kga+0/+1KCT?=
 =?us-ascii?Q?SklmdGSTUm/XfuXoWNxQIqWQrYKqyjBATvbk5J5G6xZ0sMkAnWCnPjbtvtIL?=
 =?us-ascii?Q?LhJ5rUM/Dm/Fvn0uILfUGRc0G85Uqyj9/UanIt9NQxThvSsyrItMf/YCLg0P?=
 =?us-ascii?Q?Ak5fsuzsljwJogXY+mFp0lpnUkmXIKego+kZRwjSo+XSPJl4maz59unESWLP?=
 =?us-ascii?Q?6K1odZ0cVjI4MA3Rvc7OdHGljiJ4TRn7d6rZdqRstBTIUiPG2tYoCC+l/CzZ?=
 =?us-ascii?Q?8jJD8kXS1TWnZkgb5pk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 06:08:20.2950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16591bd-ac0e-445b-16ac-08de3944d996
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679

Add device tree support to the CMDQV driver to enable usage on Tegra264
SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
device tree node to associate each SMMU with its corresponding CMDQV
instance based on compatible string.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 42de3da54858..fbd16b210e88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+#ifdef CONFIG_TEGRA241_CMDQV
+static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
+				 struct arm_smmu_device *smmu)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
+	if (!np)
+		return;
+
+	/* Tegra241 CMDQV driver is responsible for put_device() */
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return;
+
+	smmu->impl_dev = &pdev->dev;
+	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
+	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
+		 dev_name(smmu->impl_dev));
+}
+#else
+static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
+				 struct arm_smmu_device *smmu)
+{
+}
+#endif
+
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_TEGRA241_CMDQV
 static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
@@ -4634,6 +4663,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+
 	return ret;
 }
 
-- 
2.25.1

