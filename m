Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB715B8;
	Thu, 30 Nov 2023 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oone55BH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsQ9uHe8CUVpgeokd76FJo2Hcb6jX7dA7NN5ou55L8xuqw1Z6WnI2kzBiNkRBbcpiikuGVA1VwbhgigIipj0gT0M469r1qwhSQ8dCsCplUO71RnaCU6dHeoH470KoUn80BqS2lOFRaTL2yqivti+4PZrswYq+hvsmdwuW1SPOQTpOidEU5++K+l21hr/myjJL0HS/wVkTgL8aPGGq9fPHuMdgvXiuQPdbId/BDwId/A5TIeRmRkAcepD3uFfE7aWnwFtZ7HkQBIfCRCnWfIlVIDEYm5cGCYgn5HCHkJq+dOw1RMDj0/8Rt7tFipgT207NN/DJbnuStQAbysMynHF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/4MHf/uztcI2ZbwWSG0abT7rilc4zmCRB6JzHjLkew=;
 b=HawP9qRWHR1kLcslcMP3wP3YkDitEBqeNoZQrsrXiZtPjNW1AXogfFb2NhdEuV88fHv3CDU1uDdvSEYuPIbzRa85BUQJ1/mIwKefkJsvgMoJEEzhKvrwmh7xC1PqNpL2VMxfBbrrTYuTflDp8v9udUFAh15Wuejjg9iDaqt/Of1+eFTbTK/aeF23oeVWd/dDI7yCKj+DLg0KQcM34/NlMUqhvQ+vndAa48ubytjeQPeQd5zFS2XnqIO8E9uaLalIi3+IyjAOpXL/0xpYD8lbrP9d1YBFKGpayYigFM+JJfvU4cbEpsl1pTQIgb/YQFIhd9jdV3+zNxwe51kzuaO/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/4MHf/uztcI2ZbwWSG0abT7rilc4zmCRB6JzHjLkew=;
 b=oone55BHau6jbUhTofGwf9V/xwDs1OXNW02jl8IYU9LNDXtc0yHHl9MY1+WPlA0JXp4phda8ILQXFd1rWgJ3VfGCZus4PKF+7a1if7p+FSdtI96OUdJhC0rhw3tCZM9ZMR2fvAg4Oo79A8hEeJcf4DVcpIsyuH8TNs2UD+DHDb1Dc2+3KKsVomBaA1lRhgbCT74of8HzEodwZrh9+4utrsuXydveiD3Jhh94TJAPrxCADzMVL/HglzHLGMdAc2lvPC25EIHXUiC7dbSfecVZVdRbFhFA/WcHB6ON6fZWz61q8GQ1cy7xYPIEA0F3aA1PzNdWpw6zBz+ITP6Kju9hng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:38 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 16/30] iommu/tegra: Route tegra_dev_iommu_get_stream_id() through an op
Date: Wed, 29 Nov 2023 21:14:16 -0400
Message-ID: <16-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:805:ca::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 878153dc-52f2-4c93-3ca5-08dbf141b637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cr0rIeHUxAmchj956vz3DsS2V5PUcjFn/R4z/gHpuDxlkhAhkG3ssK69bYTpu8FCdBMQX4mI6FVg+4KcypQ4h80nLfrKt7gv/c7jTMGilQShUwN9xzdrZ8h7n28vKp3xwLwwyZtApoYWunjWfIzQrSly1Rb9U38HqGVcNgM1Piaaqqz2HkYr9ksqoayyH4gFVJNhGOk1o9QUuNwpzC2YeKg5Od39ORsTTwkkWokAJum3o9LmCII9qjTtali7zHZzX5oYQDbXHgTBRIH25B44/qVsRgyjCFkypUwh5B8g7x4a/d+NZZpc+H4SENtRQcQSGaCxfAzYWa1MkNKfKMFDQDsrwUTBg5rO88JN5kVNQbtyHPJU0YDIARLJ7/gXXt4ajrWtpjZ4hh3mS3xBrGRzj15VeEnK4ipG/VkzUphpP375hsxSSN/FclIy1PZXbRBsk+0h7yuh/VeiIo6errq5Z/q5Wl3lAsqojQnzn/4wa2I6b43IZWTURRnLBIOSGe9t1hYj41n5xgji2k7oFncftOFbvyCyHmzeVpaVj4wjftlCxhOMYcNuWq5YWXFoa7Nqg7PNZdlPguymkf+w+J37KA4X2YBH6lRPmnLwn1bd1hc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+82O8y4AynPYxCPRdweg69ZigvmVsdP0IdD1xlGoHI01CK+epSizHXCCKeOn?=
 =?us-ascii?Q?MkD+sS7wCVqUd8CPZLRPoNhSebJpL1yTHML+s0gghlKN/e/6hGtRBwyLpp3A?=
 =?us-ascii?Q?aR9aq6ptvZkOchNzRXZvbXxRWuywZOPan+jlTPipZXkZHfyWmD3rxykauHGQ?=
 =?us-ascii?Q?xcAcM3CotEX1nTziiElpwnXQpG+JVUO86tCs/G9TMWhivaMRaiWk6MPNbw2r?=
 =?us-ascii?Q?VQOH2hwgrvqUv3H1k1w2Zw5J5u3u4pZ+uA1kyneby/3yIM80mE1V/nmwEUVQ?=
 =?us-ascii?Q?AcHfHuT6lJRBS/9azi5CB2KDw8z1TFvrAMHnDWH2McNjdlsopxV8/JWjhWSn?=
 =?us-ascii?Q?YkFqhJopOjqXhWjyp+bKOIDFUo2V2viNonUn98R0UarqUbkcmu0GsoQdn0Ia?=
 =?us-ascii?Q?jVPUll+jd9vkL7qq3Pj+4TIzDpJfh5v1XexeSXMp+fSXdflBxTr0BMTuRq/Q?=
 =?us-ascii?Q?SHaV9fXkBpvjZrHJx6XZtgXDVYqNNfyndsgo1DjU0QxunqbxhiuxrSuNwfjv?=
 =?us-ascii?Q?waArPVtfuBAKQ78VxDDBGkrBLp9L5FuYusP03jb2NrjBEw/v6uI01Ds30DEu?=
 =?us-ascii?Q?db9blvAmfC1dmj0IzEB7TWoYvJlY4YlVROXaXiVmZcAItLcB8Jgwa09KlvlC?=
 =?us-ascii?Q?AQZW9LlHDEeI5VeMlj3DgvMYSxQNpv8sK2d2gTq9JJEGUmUjaBL6+l8rZc4B?=
 =?us-ascii?Q?xAWXGBnZ1NpeV2iblZ6zp6izZc+J4J7ue12CBOmt8FfFNmquKiDdIU7cT9r4?=
 =?us-ascii?Q?LtgcUtewMm2g3rd+KJgY6ZWlHXdB6kvOpe6lRtEsYozJ4iCewqIzxSGQR42o?=
 =?us-ascii?Q?p7vNq6II2eBPp9iNhcTH3Sl7Xg9/Nm/d48c7AeNzcoQfy3YlR6HbzSFGR1DS?=
 =?us-ascii?Q?OtvSuQgLLwCBb8GTh6/ZXTjtBaV/lm9UP8gXvydBg0n0OVwSiNSfc/toJRoR?=
 =?us-ascii?Q?qU5TATdYUcxYQTCvKFqLTEloihHthNXaBrJ6/rEiY40QM06POr1UTlssn8S7?=
 =?us-ascii?Q?zPSNGLA5ZK6ytUl+G13cyQdlpRmZMOVwjAYknJB/7N8rS/VKPmlOD5y5HTT+?=
 =?us-ascii?Q?CJrcZmI7qFgUD6vfDrQKuzhOHWav4/IjaBIXwuqNnvPNWw/5YylX2qrZJgzP?=
 =?us-ascii?Q?FaOfADxwYTgVtG5RJkFpRaWIxQtlXgCkRxO/W6Ljx626OSV8HrXB/Bc4Ipgg?=
 =?us-ascii?Q?d+uyrYNsfLkz26KQrtSvCjySKql4JiPccRqtwSldwW4phD9j/trfMiMU7bjg?=
 =?us-ascii?Q?o22pnFyP51HSDen7CuEpRHcowX6/Oy3oRzF2TiIPH0zooPN5u3JjOtEoWfzf?=
 =?us-ascii?Q?Ai2xcY/2h/4UssCtcUxPGwcSR+Z5zRkiKmBWWtWNHHvPI2G4rwHYR1FxksPS?=
 =?us-ascii?Q?/FKsO8BeIEcVzdPZvGU+UBMkT/wFx5PV0FbGX9dRjx9u/WFzYTiYAf1s0INQ?=
 =?us-ascii?Q?5p8w3ug1QVwGL3xShbHBuCxCzSM1k/AeIAv9j76VxSxzF5YCN2cbr6tDlt9u?=
 =?us-ascii?Q?BgtpbeNOjyTrcHle4PeIxo1o0xUt/QX3lUIZpxv3+Z4Yb53TnmM0r9MLxKD6?=
 =?us-ascii?Q?TaMHtxZymsy0at2GgNNs9hilbhFyDs66gwEd8gKr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878153dc-52f2-4c93-3ca5-08dbf141b637
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLu7+XC5X84J2wldxvvJ93FtwAyiEg+RDVB5+8aWNB850UA2l1IfW4bYECc4Kw7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

This special function exists because fwspec->ids is intended to be private
to the driver but tegra needs to program the FW ID into registers on the
initiating units. The function allows such units, only for tegra, to get
the IDs they are supposed to program.

The tegra HW that needs this function only supports tegra-smmu and
arm-smmu, so implement the function there.

This makes way to moving the id list into the private memory of the
driver.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 +++++++++++
 drivers/iommu/of_iommu.c              | 18 ++++++++++++++++++
 drivers/iommu/tegra-smmu.c            | 11 +++++++++++
 include/linux/iommu.h                 | 21 +++++++--------------
 4 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index adc7937fd8a3a3..02b8dc4f366aa9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1551,6 +1551,16 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool arm_smmu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec->num_ids != 1)
+		return false;
+	*stream_id = fwspec->ids[0] & 0xffff;
+	return true;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1561,6 +1571,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
+	.tegra_dev_iommu_get_stream_id = arm_smmu_get_stream_id,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 9c1d398aa2cd9c..8d5495f03dbbcb 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/iommu-driver.h>
+#include "iommu-priv.h"
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -281,6 +282,23 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);
 
+#if IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) || IS_ENABLED(CONFIG_ARM_SMMU)
+/*
+ * Newer generations of Tegra SoCs require devices' stream IDs to be directly
+ * programmed into some registers. These are always paired with a Tegra SMMU or
+ * ARM SMMU which provides an implementation of this op.
+ */
+bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (!ops || !ops->tegra_dev_iommu_get_stream_id)
+		return false;
+	return ops->tegra_dev_iommu_get_stream_id(dev, stream_id);
+}
+EXPORT_SYMBOL_GPL(tegra_dev_iommu_get_stream_id);
+#endif
+
 struct parse_info {
 	struct iommu_probe_info *pinf;
 	const struct iommu_ops *ops;
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4b6..cf563db3e3b48d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -989,6 +989,16 @@ static int tegra_smmu_def_domain_type(struct device *dev)
 	return IOMMU_DOMAIN_IDENTITY;
 }
 
+static bool tegra_smmu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec->num_ids != 1)
+		return false;
+	*stream_id = fwspec->ids[0] & 0xffff;
+	return true;
+}
+
 static const struct iommu_ops tegra_smmu_ops = {
 	.identity_domain = &tegra_smmu_identity_domain,
 	.def_domain_type = &tegra_smmu_def_domain_type,
@@ -996,6 +1006,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.probe_device = tegra_smmu_probe_device,
 	.device_group = tegra_smmu_device_group,
 	.of_xlate = tegra_smmu_of_xlate,
+	.tegra_dev_iommu_get_stream_id = tegra_smmu_get_stream_id,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= tegra_smmu_attach_dev,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f0aaf55db3c09b..0ba12e0e450705 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -412,6 +412,9 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
+	bool (*tegra_dev_iommu_get_stream_id)(struct device *dev,
+					      u32 *stream_id);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
@@ -1309,26 +1312,16 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_m
 
 #endif	/* CONFIG_IOMMU_DMA */
 
-/*
- * Newer generations of Tegra SoCs require devices' stream IDs to be directly programmed into
- * some registers. These are always paired with a Tegra SMMU or ARM SMMU, for which the contents
- * of the struct iommu_fwspec are known. Use this helper to formalize access to these internals.
- */
 #define TEGRA_STREAM_ID_BYPASS 0x7f
 
+#if IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) || IS_ENABLED(CONFIG_ARM_SMMU)
+bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id);
+#else
 static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id)
 {
-#ifdef CONFIG_IOMMU_API
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec && fwspec->num_ids == 1) {
-		*stream_id = fwspec->ids[0] & 0xffff;
-		return true;
-	}
-#endif
-
 	return false;
 }
+#endif
 
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
-- 
2.42.0

