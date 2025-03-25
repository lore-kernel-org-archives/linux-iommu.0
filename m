Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149EB1A5B9D
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742875552; cv=fail; b=Z1ZKQ9OegxxwiZvADjYm55rUk6t3KCTmZRVjl8lJV/VFMw1aHinMi4S2ol4aaztRNpW0P0ehHyKlQiIpqoMmHRIXPLiKvQe2zZSthHfl89fCI9gHWUjGfxzyZZrQDgvOtX+P4h2QnOdF92iXfYxe3L058ccU62/3/pR9scyhDrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742875552; c=relaxed/simple;
	bh=9+8BLr7fBdGbh132wUKhu2qAQGjGFCEO+H5to65PUKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8YnWgxyFe/q1I9gC+9bzEnIY7o2tMLNxhK9ZyIb5Vfj5Oem6mrjMspWvPwh0cVGuEchtZ+4uVnRf0HLA9ZFjylutFS4u/YQGI04F87noZFxZudHl8LCi5hCPh7PNIDlDUGVn+n19FuCvGGwuMyiZavfA54PMEWVFkKyHr8clJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmHuyQuu; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmHuyQuu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWxKZjuMqPhvMf8cuGmcE+6++p5fxbhPBw0EQ+GzkT1bAiQg0WSid5ZdkV1hr1aRJ6ByidtsXBMBY0ubnzpbEhq1aMUg9m1o5DA34Qk4IBY/H7xtfqLpiCX3ZKsDqeR+VLpLq3zAuEgYk+Tzm4MYojbadKFa/vQl9WjbRyU5/5MWIi1WkNobRs7mqAu9uKFK23RGt18DlJgQoywP96PNSXTxls6mjgBTpV6CuZaRUlrQOuJVQvHD7nwqyeYTt7ubKPEJj2zdw3XS4tRggoM8IzlOWphc/fb2rM0dDRolYXMPKpxXx8U6Xuvgjq2yTpVqCchyFN1ZD0uenGhHpHsRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3KYuSK3s6jWb87t5ralnM9ZuGYADSsZaZlcl5uwWdI=;
 b=ai8sDpnwyvCA2m1oO3qetPTDzIkOZO45J3oR93lmwLhbGOKe3XJ6gnWL8xqFX1ve8sV06pU1/E80VIYCpNxRXIyADyaJ240eRLL2+UVYARdG0x1tVifjLqTMn43gVGSLehQgmi2zO5kMRflVejWRSVm1QEIejo408A4FLtSztZkeFrmI6FJXNo/XDYTq1Bia0n/dXfn+ZlhfgC1D29O5sJRkMmlcNl2Jmi+Ln4EiSyTOnSEXquIdQ/pplrzfayOb9EUUygU7KRSdgR0/Vz69A5cjDkf2slIox9hLtVbn5NrhGq5vC9A/h5eEviyHz6vTUhxdGUXbdFcmcfqrIOQ5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3KYuSK3s6jWb87t5ralnM9ZuGYADSsZaZlcl5uwWdI=;
 b=ZmHuyQuuGcJkgg+fj2o2Vu9Ofnbd39ArDFj8+SndyPpvG5JS8YdOkmWDzQBHOO9Ow5FWUwQFnwzT49uiItD8lFIZK7+YPTunjgfBgGd4RwAIfvH7IwUygWFkPPxxfqsS+nfQMrohDt7uhGP3KGG0RKU8g67mEZZQeOyXlpd9ZBCuxIa5vLqOrzFJFsH3FVhisz0V29AMQaf239mg41slbNifmeXIgiLLj9z1tVEkHvMQcypeAh5WbJYyjDKo9cpIcq5pvT+cBq/1jc73CGTdM3mPjaaTTL70L3vBdWDZHXMTpHm0lo8JmeQPSq3e9+1ptOsPzOaFKvM62Xj7R9B9ng==
Received: from MW3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:303:2b::32)
 by SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:05:46 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::62) by MW3PR05CA0027.outlook.office365.com
 (2603:10b6:303:2b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 04:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 04:05:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 21:05:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 21:05:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 21:05:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<kevin.tian@intel.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>
Subject: [PATCH v5 3/3] iommu: Drop sw_msi from iommu_domain
Date: Mon, 24 Mar 2025 21:05:17 -0700
Message-ID: <7ded87c871afcbaac665b71354de0a335087bf0f.1742871535.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742871535.git.nicolinc@nvidia.com>
References: <cover.1742871535.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SJ5PPFE4FC9FAB3:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a091e8-f986-49e4-b1bb-08dd6b5251fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBvk/11Gc7w4ZZZVdcn4Tt3DqKl2FHkMOzH7SB+COjlqPVxvIP54dHYUPXl/?=
 =?us-ascii?Q?1e7GDVX2SQyNKI3+wGoOeKvHKedVTLOI+A4Z/ck+WmVlwZUVvGDIZ5WahpOR?=
 =?us-ascii?Q?YusMxO2k8SDI7uR4/D/gNLB/yjvspUerplsTNBT5pZ2Nte9juOU22juToRui?=
 =?us-ascii?Q?IPyDMatT5zbjLZ2ADvE5LcFerH2AmwV91EPfVsHiVbVWhCLRJVgBCQJW9Umz?=
 =?us-ascii?Q?IETvLCl6ncFxdVJijO/x22lGWPGgdNdYMvWAtXzJI6qFOlcrzWbLOWcGoPFz?=
 =?us-ascii?Q?wtmZnojcDyE1+v1SCWylZrMhzlU+oJvxlxqYRy9Wm6W9CrOe2uleJd+FQoaH?=
 =?us-ascii?Q?uk+kYWNPLCTJRj1C9FmQ8HdPVCWfqjW8QR6rrRvneUnLVzVNO3wAqGFEelX1?=
 =?us-ascii?Q?bB78stkNlxLui1/DZ/tmfGsFW9dbBt6ag7x5eVx05fqKDV7JT1pRTNx0iYq+?=
 =?us-ascii?Q?Daxc61Vx/X0+a0/nxTJF3iPDD5yDXOR1fxusd781N9AovudJF1MwVO+KPdWh?=
 =?us-ascii?Q?LRwiSqhHwklYNvUS3lEGSr/0Uexrx/8SlFCvre6W4m3eiNyHCJmV2EPy41m4?=
 =?us-ascii?Q?86aZtiUKzha+yoHCgk/4nNh7LemeVikY9XiWPqGkmgkNOa5RWQvi+ASuLRiL?=
 =?us-ascii?Q?qWtJU46Pg3UiC8iZRdVHi5UFKtbagTpxKl+1t6N0mZ8EiR1kzfmiPMFkz+29?=
 =?us-ascii?Q?cNkkmE7KJRmNgel2aVY/WAssiR2ZfRF8HhO6S7oR3ktkXD+i13oBEezLoqtC?=
 =?us-ascii?Q?4CYUigxt9qmYGpsXki1txZ7ZoA9X1fC5VZQWIDTgzlqR060dHkIR4F0OL6tQ?=
 =?us-ascii?Q?1egVq0fmHGCNLXIjey6g2jFnzIgFlMKeN1oacndLAleMq+gVmsh0YYlKoLv3?=
 =?us-ascii?Q?m1M/5V/JtsOGHWZLeVNxUyupqjDUNvY4mbSjIeFfH+9TmLt0d5NyuCYzEJnT?=
 =?us-ascii?Q?xsm3FIm9EsdTW6h30sXW72J1IOrrprlYbsIDsVpGZGaHSkeo+AoRctkkoJxC?=
 =?us-ascii?Q?+TIbFXDt1CKQXm3704RFhPcbZ7SWvINMZtK9UJWoj1WGyfEnGFvaNuh1NK+5?=
 =?us-ascii?Q?JM6BRVKVC+MFlVrcAHVj+TbEgF2FX0ZSahp23vTX/cZ7/6KexftphxnKHNmK?=
 =?us-ascii?Q?FIQtpHnj6rcUuXTTZUr2FFAtwI3lmbMJRsjCPVxnfalyW3jLdL9JX019N2B9?=
 =?us-ascii?Q?L+JUoHI8uXwSyQu2vk7UbcNGukjTb3XxrrtgdMReRwbS/rIHQGQpJ8SJXdi3?=
 =?us-ascii?Q?6cc3vieubqo2x173K2Ky8DmeYSYyUGlvhb/8V+XiRK92qCopDPHgIW2yvY05?=
 =?us-ascii?Q?Nx8zX1JOQ3a9nXXJcE4QowEhH55XP/7Tj+3+eaCKZwRldCZaI4V2DZCPA7fo?=
 =?us-ascii?Q?hPkSob2Uu8G9Bnjtscwj17Xb5k+4kAqQelFbjIe88qX8Q/vte/9j28ktfL6J?=
 =?us-ascii?Q?2AwOem8oxqND3+ktD1kP32tBZeSms62bta4Suh1lrmiALYsasUK1Mo831In8?=
 =?us-ascii?Q?g4RFXTmcMWP9wWI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:05:46.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a091e8-f986-49e4-b1bb-08dd6b5251fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3

There are only two sw_msi implementations in the entire system, thus it's
not very necessary to have an sw_msi pointer.

Instead, check domain->cookie_type to call the two sw_msi implementations
directly from the core code.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/dma-iommu.h            |  9 +++++++++
 include/linux/iommu.h                | 15 ---------------
 drivers/iommu/dma-iommu.c            | 14 ++------------
 drivers/iommu/iommu.c                | 18 ++++++++++++++++--
 drivers/iommu/iommufd/hw_pagetable.c |  3 ---
 5 files changed, 27 insertions(+), 32 deletions(-)

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
index c92e47f333cb..d96e6fabb4da 100644
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
@@ -3650,8 +3651,21 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 
 	mutex_lock(&group->mutex);
-	if (group->domain && group->domain->sw_msi)
-		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
+	/* An IDENTITY domain must pass through */
+	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
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
index fded3f07bfa7..8e87ae71e128 100644
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

