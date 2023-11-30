Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA4811;
	Thu, 30 Nov 2023 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhKCOuXD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y81lXcgTNGe/uneqURNIEx3sGsCvyrAyS6Uvwvpb1zHJVzyCpVQNc3TvdeZ+FKLDdWxXpI81rkWY050ubb55Z8Q9iD0S/T/uu/VwdVtxBiXRdiBTsD4n0BqRKFxkZwSdPrFx0v/eWxCHPwe45wW/5w5dppxrc+UNS99ozbIOtEzASYoLrRF/jQP0qN60bAFbemmwEQ4TumUlx8icUJG+kBEGWcrtG9fviWGlkilD9nopr7o7GIrvBuz0o9fJMRCjrqxD+mvkt6Il4pBlt3X6rboD1GBxdM5UguxzgnEX6Ly2BfQH2YhAO5xapegV/LVim+GqUd8zRL+ITwRieHiegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gvB8+jcuszFrOcv/8o0zSHcCWgbZ8CoZJyYlaYjMU=;
 b=miNHOzA/z8gnlplcomXlQRLJ7KHoRKMGMcJR9FtF21za3T41UDC4eUK0HbW7MrbBb2fjzOfbAlk662cs8rXcLI/gqBm7XxGUpFM9jfGHySj4wSKc0BGBZT7hSPtuVvlrbQDd/Le3uKT57RHQOM6xnUO3ZBGVlwjNh/tuj7eJVDDUiJHkP3guOSxoJiY5BaVX7bcQM146ephhSsKExLtNopRlhlUDJL0UIkwDlRdMye6A//tOBv75pLGWaQzRugjGRJ9udVN2qkgevFWkLEbxljZSWQXbZHCs/tD3O6dBgIbxce7tmvQIGoU4FbQI88DzwFIIJAu9Aw+XE9Z83e2U0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gvB8+jcuszFrOcv/8o0zSHcCWgbZ8CoZJyYlaYjMU=;
 b=uhKCOuXDuqNa7gbtRb2a6olx+UkSeXC4A+i6GVpibVRqCgkP3Ro4O0jvgYH7muE7I0A8dlhPghLWnDwJwDurZZTt8LClrhXOrVDKYXvqFQ4PfwyM0X8zo9USKOONiwUa1bvfuhpPBtg5LMGSOoAgW3G5YkGFBa1V0r+Hr1JvVYD4oY0gGx3RVc0uTYxn6ykaix0xrO4hsFTFbjli1sxpiDwDeLgfLUBPgSmatdcXTvpkknI3rNaJaBDRuAU39yFAs9MbgDKCYEkcR2JMyWDO7FIPtKOfENfHgmWM2dbZaabl8+pewmXOg98fXIdB5nPuucCYOicO2vgqQWOtP/BrRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 18/30] iommu/tegra: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:18 -0400
Message-ID: <18-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ec043436-83be-4f91-4bf9-08dbf141b553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aNww+TeO9imF2SKepIaRKb1MTgal6Bmvnpjv5hQUg7hSqvMqsufcQiMMXbeOlCle3GwiuVj0QIfm3OXmfYdax0GjBS7FZyVGEBAMKFf+aXQKYKjwXeNrLOrta+y053DWs07efh20k4+I0ZOHYzAtumu2KR12Ixbs4Y4itd4eumdPNqjKb1b6LqZwUIo6T3KziFM5t3RwX2cGwCVkAChnYL2pDfxh3Rnv/qoBGbpNx4cIwtlrLsHExYILAouDpV01Y52lm8MM0oVqc0fA1CQPwD5MvpWAy3oOpA9gxtbPGk7IqbCGeXuwgVMU/2YpnwrH3AiapRtyk0uQipSz/WEc5jvN3uBAURL8KkT2bbW3/4xJute5wioZFOmhYl+yu9OLjg5qtDu9vZ/84nOWV0FBIZlDpoWpYklz9v5duXbOKk0AUMuOyqnKIOrXnvY/OiShvF+Z71ZyoZtKKUTCpHNcnLc3wfj3nNt70MLm5q8UUFcXJ9+q780+PSO13QfajhuCnDeKdkon8hrzwzGSMAJS9v9I8310/U77Bkc7nZOOMuYZCbbeoG6/vkufYCTTd4xH2ilDWIF73jjSSEJ02Rh/TMevqgyh0pWBZKMWEl/AdGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TqYjBorTjK5hhVCfYcZkWSM3k1UsWHyVTa0Wy946yaDsm08AkJDcU85ZBB2o?=
 =?us-ascii?Q?PHK3aO94QxMj5tnGVCTEUwmyV9SsIuiTmg1BE8pKLLxMMxPLxdvH4opOCzD5?=
 =?us-ascii?Q?NbbvEdrsd/6eQ5tUujrW8bRvaqCSeu5Mq41yoThjvJBpq8hCr29Po+7vEkGp?=
 =?us-ascii?Q?8Ugp8yX0DmI9k38uJxkcFdd2ESqP7SJvVL/0czrBJeCVpQ1UTKd+8vsoFJPe?=
 =?us-ascii?Q?/U/57JKuAo+UQMMiw2bV2uv4twG8T7D80+Vs8s7F0LZiW4qR502gzGMAalfv?=
 =?us-ascii?Q?kEtZbk/QfTqoCSMyPB3pWIyk0pFWoBa3Yog7Pm5DbTCH4DJOcWMrpZwcUWWd?=
 =?us-ascii?Q?7hZvvq1d40ZONvOcm3Kt2QK8V+84mSAI/qiceOPlQM8lffD6FvPK4ELUnNfE?=
 =?us-ascii?Q?aNev4XC52N3PFPlHeeuFvBNCV4nldrYzQIYiLEDoSt0yeMNX2CG6A3Y4un2C?=
 =?us-ascii?Q?lvg+zX3ecbXAaPJkmjRZIqiF0KdpFU5q7RNu2tIgAqr1ONF6DCoMUpuQtQjU?=
 =?us-ascii?Q?yvrmR6+m+ZWUgNfpzzd62hdntc9aX31G2fTR3EDZBFLGpqAPqBoaOSauxNGB?=
 =?us-ascii?Q?98HVl5XDQEDVEAW1ro0z8l9ehPJlyI706kMb+UNJI5wU/kcitng7m8rF6sZ/?=
 =?us-ascii?Q?nq9b5uurzqMmusjYB2lyS8R65TzjLTzwogu/TTAiU0mLtJcrwdmx0B6alqTI?=
 =?us-ascii?Q?rW19NjuOXijlccAum1dGnJuKYWEJ/keZAtVL3xP3dN6dfUU+K/bUXmD0ykEA?=
 =?us-ascii?Q?O5yY/yU2dQZ3JfaYch4ZeYXrezBwqhpnE/XT/5pobr3mSSJ7ZCF87cOnS8zA?=
 =?us-ascii?Q?JtvVhJxE9CdGwuGYLNmbjWZ+Gv20mruBHZJzfDz33VutmG9YOl/r/13UR+xD?=
 =?us-ascii?Q?Z46w4QpncSg/fGJHIKahZmlhNkb33SUWDttGDKKFo/Od9JobPSH36jNsYL3U?=
 =?us-ascii?Q?5zLVzPlU+rH+ZmyK45Izx1SckDymoxZLgh24LlMUm8FgAyDW85sEO2KZA4Oh?=
 =?us-ascii?Q?SPQdVtxgUwTCiYisUi6VP43hyzfjOAcZLNjM0+yRAR27O5LRvRb7hhpxtoUw?=
 =?us-ascii?Q?Mpfvpcw/0+kkFkLB0OgBE0kQniHMK+YaDdOEZS6U6EvwseQ6f0g/QvzmdbG+?=
 =?us-ascii?Q?uMtEi/sY8dLwXCdJ/SDMipivdvvVK4LerFLNJrKAA/4O/rb8/QpefC+WyeeA?=
 =?us-ascii?Q?99XzSbt9iTArf/+ck/Ah+hJll+bnvy5p2A4R4fWfDecifmPr88b2xanHtHje?=
 =?us-ascii?Q?9NJBnSXl4AML58OgcnRAHMAymCeMCaGsUl9u8MUzgWCXJG+ACpozIt+HZCkZ?=
 =?us-ascii?Q?N766Z9ZVrxwprToTvqa7eryw9DR4xPF0v4XM31TqF7491t0GgBVaQz00OvAx?=
 =?us-ascii?Q?OKIrf62lM9Zg62oosUpW8micjHiNd0TXFykLkpxn0UXotPYdioTaisjbeh9A?=
 =?us-ascii?Q?xd1be3Xwcws33TH2SVtYdYnuLuhxvq8pFBYq//LG7X2k0F+6IWwUirjBGCWW?=
 =?us-ascii?Q?rV5pGpAO/cj4ZwDRpPLd4/A8f5OP6hpkguSY+uilcI0nu4gEHtSvCJLtHXcM?=
 =?us-ascii?Q?1c9UpUNooqp3cxyCvfePZf/JpUS0WlzH9JmYR0S+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec043436-83be-4f91-4bf9-08dbf141b553
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DEh2n0D6mkXb24dDVl4F9A+bXvtzI8SDlXLamXckk1w6qLJ13SkD4CHDo4wNOOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Tegra supports a single iommu instance with multiple ids.

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
tegra_smmu_of_xlate().

This now checks that all the iommu instances are the same.

Tegra can self-probe without having to go through the fwspec path because
it self-initializes the fwspec. Use iommu_of_allow_bus_probe() to achieve
the same thing.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Convert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 154 +++++++++++--------------------------
 1 file changed, 47 insertions(+), 107 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index cf563db3e3b48d..1daa92f524452b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -7,6 +7,7 @@
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -19,6 +20,8 @@
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
+static const struct iommu_ops tegra_smmu_ops;
+
 struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
@@ -49,6 +52,12 @@ struct tegra_smmu {
 	struct iommu_device iommu;	/* IOMMU Core code handle */
 };
 
+struct tegra_smmu_device {
+	struct tegra_smmu *smmu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
@@ -477,21 +486,18 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
+	struct tegra_smmu *smmu = smmu_device->smmu;
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned int index;
 	int err;
 
-	if (!fwspec)
-		return -ENOENT;
-
-	for (index = 0; index < fwspec->num_ids; index++) {
+	for (index = 0; index < smmu_device->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
 		if (err)
 			goto disable;
 
-		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_enable(smmu, smmu_device->ids[index], as->id);
 	}
 
 	if (index == 0)
@@ -501,7 +507,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 
 disable:
 	while (index--) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_disable(smmu, smmu_device->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 
@@ -511,22 +517,19 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 static int tegra_smmu_identity_attach(struct iommu_domain *identity_domain,
 				      struct device *dev)
 {
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu_as *as;
 	struct tegra_smmu *smmu;
 	unsigned int index;
 
-	if (!fwspec)
-		return -ENODEV;
-
 	if (domain == identity_domain || !domain)
 		return 0;
 
 	as = to_smmu_as(domain);
 	smmu = as->smmu;
-	for (index = 0; index < fwspec->num_ids; index++) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+	for (index = 0; index < smmu_device->num_ids; index++) {
+		tegra_smmu_disable(smmu, smmu_device->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 	return 0;
@@ -811,77 +814,34 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
-static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
+static struct iommu_device *
+tegra_smmu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct platform_device *pdev;
-	struct tegra_mc *mc;
+	struct tegra_smmu_device *smmu_device;
+	struct tegra_smmu *smmu;
 
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return NULL;
+	iommu_of_allow_bus_probe(pinf);
+	smmu = iommu_of_get_single_iommu(pinf, &tegra_smmu_ops, 1,
+					 struct tegra_smmu, iommu);
+	if (IS_ERR(smmu))
+		return ERR_CAST(smmu);
 
-	mc = platform_get_drvdata(pdev);
-	if (!mc) {
-		put_device(&pdev->dev);
-		return NULL;
-	}
-
-	return mc->smmu;
-}
-
-static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
-				struct of_phandle_args *args)
-{
-	const struct iommu_ops *ops = smmu->iommu.ops;
-	int err;
-
-	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
-	if (err < 0) {
-		dev_err(dev, "failed to initialize fwspec: %d\n", err);
-		return err;
-	}
-
-	err = ops->of_xlate(dev, args);
-	if (err < 0) {
-		dev_err(dev, "failed to parse SW group ID: %d\n", err);
-		iommu_fwspec_free(dev);
-		return err;
-	}
-
-	return 0;
-}
-
-static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	struct tegra_smmu *smmu = NULL;
-	struct of_phandle_args args;
-	unsigned int index = 0;
-	int err;
-
-	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					  &args) == 0) {
-		smmu = tegra_smmu_find(args.np);
-		if (smmu) {
-			err = tegra_smmu_configure(smmu, dev, &args);
-
-			if (err < 0) {
-				of_node_put(args.np);
-				return ERR_PTR(err);
-			}
-		}
-
-		of_node_put(args.np);
-		index++;
-	}
-
-	smmu = dev_iommu_priv_get(dev);
-	if (!smmu)
-		return ERR_PTR(-ENODEV);
+	smmu_device = iommu_fw_alloc_per_device_ids(pinf, smmu_device);
+	if (IS_ERR(smmu_device))
+		return ERR_CAST(smmu_device);
+	smmu_device->smmu = smmu;
 
+	dev_iommu_priv_set(pinf->dev, smmu_device);
 	return &smmu->iommu;
 }
 
+static void tegra_smmu_release_device(struct device *dev)
+{
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
+
+	kfree(smmu_device);
+}
+
 static const struct tegra_smmu_group_soc *
 tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
 {
@@ -907,10 +867,10 @@ static void tegra_smmu_group_release(void *iommu_data)
 
 static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
+	struct tegra_smmu *smmu = smmu_device->smmu;
 	const struct tegra_smmu_group_soc *soc;
-	unsigned int swgroup = fwspec->ids[0];
+	unsigned int swgroup = smmu_device->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
@@ -958,27 +918,6 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	return group->group;
 }
 
-static int tegra_smmu_of_xlate(struct device *dev,
-			       struct of_phandle_args *args)
-{
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
-	u32 id = args->args[0];
-
-	/*
-	 * Note: we are here releasing the reference of &iommu_pdev->dev, which
-	 * is mc->dev. Although some functions in tegra_smmu_ops may keep using
-	 * its private data beyond this point, it's still safe to do so because
-	 * the SMMU parent device is the same as the MC, so the reference count
-	 * isn't strictly necessary.
-	 */
-	put_device(&iommu_pdev->dev);
-
-	dev_iommu_priv_set(dev, mc->smmu);
-
-	return iommu_fwspec_add_ids(dev, &id, 1);
-}
-
 static int tegra_smmu_def_domain_type(struct device *dev)
 {
 	/*
@@ -991,11 +930,11 @@ static int tegra_smmu_def_domain_type(struct device *dev)
 
 static bool tegra_smmu_get_stream_id(struct device *dev, u32 *stream_id)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu_device *smmu_device = dev_iommu_priv_get(dev);
 
-	if (fwspec->num_ids != 1)
+	if (smmu_device->num_ids != 1)
 		return false;
-	*stream_id = fwspec->ids[0] & 0xffff;
+	*stream_id = smmu_device->ids[0] & 0xffff;
 	return true;
 }
 
@@ -1003,9 +942,10 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.identity_domain = &tegra_smmu_identity_domain,
 	.def_domain_type = &tegra_smmu_def_domain_type,
 	.domain_alloc_paging = tegra_smmu_domain_alloc_paging,
-	.probe_device = tegra_smmu_probe_device,
+	.probe_device_pinf = tegra_smmu_probe_device,
+	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
-	.of_xlate = tegra_smmu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.tegra_dev_iommu_get_stream_id = tegra_smmu_get_stream_id,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.42.0

