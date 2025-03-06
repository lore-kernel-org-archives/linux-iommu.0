Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C02276046
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294889; cv=fail; b=ci95g4xzT1RLVLrkpfjbL2MIqSfpUgs5iG+SBLpSX78cQwDTlHF0DmkEsb5/e053V/pCCrjBJOyMtAeX9glebnG8GhgiFUM1xfoJjP9fC9hnUj7TCYQKYqM9cIVoXqZRJbZxBmvl92SMG3dtMyjiucHN0Y/JG8wHKEnDHJ3R41I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294889; c=relaxed/simple;
	bh=58eBuaO/n0raa9xMEUXEyKdJVETJ+Ki/CuNRIzmEYu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MY2V7PxUNRrVVBLzwRIEasSEvlgPLHXArWGclbtulPmZvfdl3TuI7+0J6SjOgRoSIs0nNLZ6FNlAiD3M0CG60pjq5CRXiIKGHnaQt26yXmGNvx16ZquuN9/ZuG14SyaPXhFmVMNFUjiIaE24dKvidRMPLqR+0tvmkWDT0dQVnmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+qK4n+a; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+qK4n+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPVvD+A1aojizbi+u2RoO8fIqw8uzvCux9DvuQ8pAZk/7F2OOzO49+eSwKxaD8IePKlgw2MICmDmqa4Cq/bClauFE8VoRA9LfuBJcKn8dsL4suKqFcUJ9/c/XPoUQiULVdW0H+7YYF+Uh5YRwBpbHxvDmNVwHLSEZqylNSf1kiG2Jb9cEW/AcoB2VV1fCxIrfWsaadhpHcfsiDvwBAWsxXRyNPee7ZR99/gicz1Kkg3GTYONpciRTGNgMSy/gQx1UOYwfm7I+a/kFhzCOkC1enF1AGCwGePI/j88Xn3sKT+nlTNNk2PE+wzcYmmR/LyHamP6MtWjLwLN+pN1cO1jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc0+fsi4jlU8LiygH4CsAV+Ji7txlImXInPGqy92II8=;
 b=bvxNjrHyrwSF0rfKB0WxTym5nsoyfSnV7Vef2U/5Vp7Rk4CSxDwdS0tzlHG/cbH9AcHXwsigHj9S3zK2wUlmRLDOKmUwNzjShiQy9lTbsmHmE98Pb6AK5alKTz4/EJXl972silSvxe88d8aSPJCJrYOLX2DAoPY4Dc30fpERK+q2SjsHyxEic4zth+c/ImuLhnj79r2eYZLTVbdCwQ8gKR87k8dEIx7+14M0G9FWiFKxTTkxe/Jsow59leERJrLDWwDxJ95fS/VZlgHBEewOv1yTsUkrCICZATDBPDUtatgho4IoCc35mZAZqFSrlBiMz10ZHY0DYvVH5p90Sneyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc0+fsi4jlU8LiygH4CsAV+Ji7txlImXInPGqy92II8=;
 b=O+qK4n+aV58DTIKcqXIgdnVOlrVLLhAleXHQX5yK63GGz70nQaHPdWqJTiAg7Y7qJuThfLvkEnhoCMVjQ10A5Am9E6VQDgdmgnL+2k53KjqvXlUa6ACTZQVZRZV74AlUrAlpPJyoyEER/bdEdDQL4o7MVWYwmdi9OaqWqH6HCSDYrTxKUlkkxjTC7ONLNt6VbK2COsqiDLJiLtnU7G8jlbABvaM9uM7JBv8oF+lL+g1n9LZTBVvUfox87YhjV6ECLUxTer+hXJvUtLUXHb9fQSD67lLUfEStq8Oq+/0xt9E/hjdGEL9hOqwmyFM4IDUwzwqyjHG+VYe85KxOpue5EQ==
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:01:21 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::38) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 21:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 21:01:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 13:01:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 13:01:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Mar 2025 13:01:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Date: Thu, 6 Mar 2025 13:00:49 -0800
Message-ID: <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741294235.git.nicolinc@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d10e12-f34d-4334-158f-08dd5cf20c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RS/l1OCcXLIHlYRVje3OF92+jWIPZ75+cur0E01pY0mo8pFsb7sbxCNhLr0S?=
 =?us-ascii?Q?gt1g8vJuO+qr/8lKAiQUwkuoNDjI8iyT6NfCSCCmDfCkvURb3PKkh4Lzj0gD?=
 =?us-ascii?Q?7if53nS34Md6iu+RyVgUJFHDeTQETIfyiZJ0c3uvoGlw1X5eDQPgkBdbTB0e?=
 =?us-ascii?Q?m/OXtRPPFjEsfbrP8H9IrNKi5AHenVTIxt7Q6tRPT6tAG5+d2txk1CVyCLEf?=
 =?us-ascii?Q?CjRm1EPFebD/GOJBUeqnhCoGASgP+lgRFUSKrOEqTuVFNxWiHmwH6fp+qXu+?=
 =?us-ascii?Q?ig8pwhAqRg25phcYyYU/TMaiXmgpO+Po66+FaTdBI/xZLalxSMrcA6qga5DX?=
 =?us-ascii?Q?2Bsk14CFfGXZFuoxQsbLN72sqIX+RJLaP10cWFuRJPnm/6irVaamJ5cZQdr4?=
 =?us-ascii?Q?FLfGi6yWx+JZ89QpOjtH2S2M/UgyXHpuKaOhIeUKoOYNQSJ4wdUG6Z31XMJ1?=
 =?us-ascii?Q?0T9QIwTfKlYKsuz/fQm/NIGZ5SWdwoJ8LcMqhiPT8Q6qRAyK8qRGLk4FpEYg?=
 =?us-ascii?Q?d/X8x1mrFDsITQJhsYg+RU1SW8USFBkS4u/Hj3cJGERZafjiMUI1Tk8x35RX?=
 =?us-ascii?Q?/k2uGfRl+2zsxnjDH1kCixVMsOFPbXw2adlJ/zstlFxtKEwBKbZbQP6c1z3u?=
 =?us-ascii?Q?ZVu9aG105afzNI5ngdxvlmUHL67DEJ//S2/ftaDXZbEMumWDjbGpw0jedify?=
 =?us-ascii?Q?V3CMOmFVfao4sZ2hbqEAJZTHtM66Hdu/RnFsGNuf6TNtMmY6R98riDXvG+1J?=
 =?us-ascii?Q?kE6wFH8MEkpmz6krfCzNNv1t+ncZUYEwltWgkDzJ3iwm8iXej2kM2Na0EVQ/?=
 =?us-ascii?Q?0Ah+vMb3i1T7CzbxW/omvVLqTdRlw6ik08Di1PohqscTAPw04nLQYtezmqd2?=
 =?us-ascii?Q?Eg0Rb7MrM0k3bhvpg6Kg3HR6tSAlRp0UBiSV4aAA/qve6+inDfJR+YjY8HIy?=
 =?us-ascii?Q?7Xk053jMuprelyzTmTwWxaKGFlrR1+xh/auZofkTufrC3UxkA9k+Lne1S0N5?=
 =?us-ascii?Q?aKzT4gAJr70N0IWrCsq3HVoDYG38eaQyqMFzCnSNjrNG+Y2eFRZq3uc5Mz1b?=
 =?us-ascii?Q?z/07rwkea6Azoly71elpYtpC5p3DCSh4J801lCGy4J+M+VgMsVFvifFTgStY?=
 =?us-ascii?Q?qpf/5d5CPqrgnB/ikWJh34Kz+ePKY8ojE8tWK/YdJmbYQsA6uDKFLdk/TK+y?=
 =?us-ascii?Q?FsylQ1m8Alxkeyas24nML7Gtpy5bCN0sA3aMyVc/pEzrVqL75SbpusYFeyJc?=
 =?us-ascii?Q?1CqqJ7WFNjDs+Zs999KitlzkZ9RzW4Ao2eat2F5i8HsgHbPGvKQ9q2uy8yX2?=
 =?us-ascii?Q?5XZRGOU2eSMOJP0W+BLKow/Z+SSeDpe/9Lz5V6Rfmfj3P8oFaxev6TwEzbTh?=
 =?us-ascii?Q?zL1gKTJ4IuVbA6xxR/6ziuSC86pkQ5FxRUoG8W7VZ+UP+XfbzwOJZyCxJ5sJ?=
 =?us-ascii?Q?ngmllMw5eHgZp5dp+WZWrSp1mPr5AaVm3Eg0sxOXmu31g3aohrRlkbG1Kw7A?=
 =?us-ascii?Q?MKXd/FYA8l1WM70=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:01:21.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d10e12-f34d-4334-158f-08dd5cf20c6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

There are only two sw_msi implementations in the entire system, thus it's
not very necessary to have an sw_msi pointer.

Instead, check domain->cookie_type to call the two sw_msi implementations
directly from the core code.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.h            |  9 +++++++++
 include/linux/iommu.h                | 15 ---------------
 drivers/iommu/dma-iommu.c            | 14 ++------------
 drivers/iommu/iommu.c                | 17 +++++++++++++++--
 drivers/iommu/iommufd/hw_pagetable.c |  3 ---
 5 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 9cca11806e5d..eca201c1f963 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -19,6 +19,9 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr);
+
 extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
@@ -49,5 +52,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
+				   struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 06cc14e9993d..e01c855ae8a7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -229,11 +229,6 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	int (*iopf_handler)(struct iopf_group *group);
 
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
-		      phys_addr_t msi_addr);
-#endif
-
 	union { /* cookie */
 		struct iommu_dma_cookie *iova_cookie;
 		struct iommu_dma_msi_cookie *msi_cookie;
@@ -254,16 +249,6 @@ struct iommu_domain {
 	};
 };
 
-static inline void iommu_domain_set_sw_msi(
-	struct iommu_domain *domain,
-	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
-		      phys_addr_t msi_addr))
-{
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	domain->sw_msi = sw_msi;
-#endif
-}
-
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 {
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 31a7b4b81656..2bd9f80a83fe 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -94,9 +94,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
-static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-			    phys_addr_t msi_addr);
-
 /* Number of entries per flush queue */
 #define IOVA_DEFAULT_FQ_SIZE	256
 #define IOVA_SINGLE_FQ_SIZE	32768
@@ -377,7 +374,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 
 	mutex_init(&cookie->mutex);
 	INIT_LIST_HEAD(&cookie->msi_page_list);
-	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
 	domain->iova_cookie = cookie;
 	return 0;
@@ -411,7 +407,6 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	INIT_LIST_HEAD(&cookie->msi_page_list);
-	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
 	domain->msi_cookie = cookie;
 	return 0;
@@ -427,11 +422,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	if (domain->sw_msi != iommu_dma_sw_msi)
-		return;
-#endif
-
 	if (cookie->iovad.granule) {
 		iommu_dma_free_fq(cookie);
 		put_iova_domain(&cookie->iovad);
@@ -1826,8 +1816,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-			    phys_addr_t msi_addr)
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c92e47f333cb..0f4cc15ded1c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
@@ -3650,8 +3651,20 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 
 	mutex_lock(&group->mutex);
-	if (group->domain && group->domain->sw_msi)
-		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
+	if (group->domain) {
+		switch (group->domain->cookie_type) {
+		case IOMMU_COOKIE_DMA_MSI:
+		case IOMMU_COOKIE_DMA_IOVA:
+			ret = iommu_dma_sw_msi(group->domain, desc, msi_addr);
+			break;
+		case IOMMU_COOKIE_IOMMUFD:
+			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+	}
 	mutex_unlock(&group->mutex);
 	return ret;
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cefe71a4e9e8..f97c4e49d486 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -161,7 +161,6 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	}
 	hwpt->domain->iommufd_hwpt = hwpt;
 	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -259,7 +258,6 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	hwpt->domain->owner = ops;
 	hwpt->domain->iommufd_hwpt = hwpt;
 	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
@@ -318,7 +316,6 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	hwpt->domain->iommufd_hwpt = hwpt;
 	hwpt->domain->owner = viommu->iommu_dev->ops;
 	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
-- 
2.43.0

