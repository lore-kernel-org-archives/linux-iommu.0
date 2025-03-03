Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689322376FA
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035204; cv=fail; b=gZx/fkX0eXUx+pXpUwEqmrwERVQsG0QTvEMRh3AoIMNbsXECU/Gud7YuRK03emZbftwDzZk1d8dN/hrpOOr9UO34ttxjIhmLQVc2XmUptsTUGk5EpGQQzCHtM8nR1XxCp5aWnb8FJyX3NppH6ND9Z7FaUFy00Dwzr6zgNbUk32I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035204; c=relaxed/simple;
	bh=bHpO2bfgXwR1rVZZlPxpGWM59g/Ro4XgBbKzcxAbwSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjcaJKahsYNoJTtMapsACJOC1ykun01OvQ6kwFHXAHt7Ewo6GY+SoHxhhvj3HiD5nlrpVcYUUkbAdOTw8yzy3mfOCBDG1tBd2UfP+dYYl/o/2FeD/mH8tUj22AyoNjq6HeqG434LXHd59VIAkm0QPvzr0h0csuJPETCTb4/gxxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EeWTowOO; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EeWTowOO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj5DM3MHg5bdAA4J9CNECcgWSW81kYgdqIvyMuGmdulnWRJJqSXC5daLYy1SPTx7W/vlnn4uEVukwOTaxjWdL1bP3Wggv2x1M42nM9KZsbnPsC68scAoxLrAY7OutAQkvfsWszKuprZOVDq6Ejtbd7xCrOh/XwDgaOR4r0LbZNxybLVOYNYlCiFMI276RWLKeQcJuDXDe3Ribu6H7Idtfhxt/zmc01Vzgaqc2BnBFT0cxuKs0oPGeukVEokrclCgJWvPWnvgdCSt5uqAW9yfqySO1IFJMNjlN1pCFNSvaZcyYzf9c1A/XYaldRLll5IquVXPaQcVz9rJM4dFByqVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDk+wx+4Rea0tlhg8TW5HMeZBDZphUtMqMLlUArG6Gk=;
 b=O7cpGGPSvz1jtLVbKuDko2wm6ZwRyPILFxhl/aNvLaZbgwZqF5TTpZ3hBGlgcUl9KeZobgYr5RBw8EtSTFMcD+OH/YKDVtjDMn3UB9nULgvdpylQ1QwFoQVAC8Yxa8Zrb94k8GK6VHdqiZ9p5Lc7xBYbycZsUJR8oUyeKI8sg49282XN4MkiRaxZxiVuS4hiBCL7mXSUxk8EUccX0xtxieCdgySlDLfvZJi9Iu7WtbwKxwWxseSsM3bTydDJQz8lOtza7IBS3UsZyX0qXv5nO6BYugn+GmdVNcF7nkGdbpr+7wBqWLiT8M21AIPeH6LIFBzoB9obFtixJ5SltF9eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDk+wx+4Rea0tlhg8TW5HMeZBDZphUtMqMLlUArG6Gk=;
 b=EeWTowOONrsfUYoe8VwnJlDQP1VttY6dxSfdFujp9Xr6cZqQH45MbgsaiutsghpQMqZ8EP/KXHk9tdkidoCLlfV+6kvNthuRxzVl98+W1AFwk4DmhzFKZeOhkyGXdvj21omu0b0Xg8kGpDnCGw1fZsaBOJv7kj3hlcFiXFV5vAa019BOAC6hHKwZHU2n6k+p98Kd3GonYBzYr/Zj0jj9SvChHOHKil+Esi1/tZVHAsYU5gKLhiSuvOQGuSXq3Q45eZR5kZT5+FpBapkh9h0NkFpLIqyybXXdz+tWsBwnTXZ92UiZnv6n2xJuC6THwWFlaXi9Wwm0GDkez8afBzcnTw==
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:53:15 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a3) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Mon,
 3 Mar 2025 20:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:53:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 12:53:05 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 12:53:05 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 12:53:04 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] iommufd: Move iommufd_sw_msi and related functions to driver.c
Date: Mon, 3 Mar 2025 12:52:51 -0800
Message-ID: <01eef75aaf5326067d8a237496ca67395994760a.1741034886.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741034885.git.nicolinc@nvidia.com>
References: <cover.1741034885.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 649acad5-1b39-42f2-d05e-08dd5a956b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uo0g3pdnugK+RX7y9ROssPX5y5ETBtmfCfvLkAtgtjuEMdS9IQfBLCKxuNpy?=
 =?us-ascii?Q?7fNWpAzITaMrxlFJWCd5GqwssdWjuougUtW214G3pqIjP7dV15SXv1wjcuqy?=
 =?us-ascii?Q?SKXvq6DUXBa4sVurwoE5leqF2FmIvsENu0The9ZnCGzNemas66bUax4KJGM8?=
 =?us-ascii?Q?P+U2RwcsQAm9h7XB6A1mPz8TYwAKTuRM/nO5zExzmjO/LIU71awB/Tk9mDpS?=
 =?us-ascii?Q?+VumoeS+fdr5sWYl7J470NXHzmB2Rn7/2+EKcHJc901OvPqBILu64VhXfJVn?=
 =?us-ascii?Q?8NNlXyE1GrYacJxRD0XCdQzUDGqkqbuC1KhXqdphQeUnHPnPDc/U34qq2Xg+?=
 =?us-ascii?Q?ItVTsIKs3/Oz5G5BQvO29se2kvhIwEuEoN1p8r2m8C4Uvr+PNv64Vn1g9nFl?=
 =?us-ascii?Q?cgKObqf89wbg+cYvLK/JDeRfQVCf1Z35iR3tTnNhuSPTPReiNNaY99RGy/pE?=
 =?us-ascii?Q?if7Z/ATrKI+cfgJiyH4v/txGtmcRfbM3YN7OY5S5dmGIfzkTUw/Z0x8NYYgd?=
 =?us-ascii?Q?ltD1xl3ci13H8kQ3Do1Q+k00YxdQu1b7rUmuJjXbajE1rXxKGMnH67xKHven?=
 =?us-ascii?Q?Qnu4TP4IJAkGXymVkGqunxm0pgNHwkDaF0waxTsTJELc7WGc3opaQPQ5S1AG?=
 =?us-ascii?Q?N0fiwUKoj67p7bXYWhtxNxtNk48Jr8hr17MSn/BYzdCZj45LHD1zZqQJ0pRf?=
 =?us-ascii?Q?/VQSIYro7yp5ad+FgpPh2PJgPsQhmrDZ73EOm6Y2cGqdk1uX07Wuw8yO0PRi?=
 =?us-ascii?Q?4UiftCDEtnPo8uNCvQZRutlzWPWRkNpIUUPliJfBzvwXdmecDCCkr4G5VG0L?=
 =?us-ascii?Q?jXVJRJjICgazXLr6N1pMMwF7CJMHJjwNepumeoSyNrUTyxQMXJN95ZP3dZRY?=
 =?us-ascii?Q?XIrjskZLUfWTFF4IVhLmV6aiRSosGuH1XCN8D/Z7SBp22YhnSLSkQIfcz3e2?=
 =?us-ascii?Q?mcpx9i3Yx+YvuJwGgyoz5Tqoiy0HUHrgHeVFwOH1vRQBsi4DbiCNFJJWo5EP?=
 =?us-ascii?Q?BLSJFv8SyiSqr7lBwqUG8vMk+8pHUGBHDc+1Qd/jlam4qw+S6lfS67ZHJjBp?=
 =?us-ascii?Q?nnKClmRdYyidi0cLXAcTJwTKLhfVa+WIzm152mLC//VUA7748g7DFCdZpo0r?=
 =?us-ascii?Q?zOHMe2FQ+oipWJVqumP1W2rfw7wMTVjKgU/DbkvMD7cPZXv/tBL6IwO/zsvQ?=
 =?us-ascii?Q?WTkR0EAA2DQoZgi+nHzliv+DYoJabLl1N7urYCo+6wRFQGvc5W4oFQPdgaLr?=
 =?us-ascii?Q?WZ9fjVrg17b2RYFLmFBorHTTnKvE6DQw5lvTEN+leqbp2QfhdOElr9v0U0Ya?=
 =?us-ascii?Q?GUfcjEjIuYVl1COCgMUsgOz+BMkReJfc+zW850wzkFC4xq3ZOwskylTWUlNa?=
 =?us-ascii?Q?JnO10h1kb2sa3c8ZnluZvICc7Ben9sx7lQYpjusv4AsipPv3EARlFi3QYlul?=
 =?us-ascii?Q?QFV/cbGLz4DD16smUg32WUmt2IiWnNm8yPyRp/49q5F4Q8Sn4MdpfI0vlnTI?=
 =?us-ascii?Q?/SaOhuDr164C/Mk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:53:15.8297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649acad5-1b39-42f2-d05e-08dd5a956b9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

To provide the iommufd_sw_msi() to the iommu core that is under a different
Kconfig, move it and its related functions to driver.c. Then, stub it into
the iommu-priv header. The iommufd_sw_msi_install() continues to be used by
iommufd internal, so put it in the private header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu-priv.h              |  13 +++
 drivers/iommu/iommufd/iommufd_private.h |   7 +-
 drivers/iommu/iommufd/device.c          | 127 +-----------------------
 drivers/iommu/iommufd/driver.c          | 125 +++++++++++++++++++++++
 4 files changed, 148 insertions(+), 124 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index b4508423e13b..c74fff25be78 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -5,6 +5,7 @@
 #define __LINUX_IOMMU_PRIV_H
 
 #include <linux/iommu.h>
+#include <linux/msi.h>
 
 static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 {
@@ -43,4 +44,16 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle);
+
+#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr);
+#else /* !CONFIG_IOMMUFD_DRIVER_CORE || !CONFIG_IRQ_MSI_IOMMU */
+static inline int iommufd_sw_msi(struct iommu_domain *domain,
+				 struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_IOMMUFD_DRIVER_CORE && CONFIG_IRQ_MSI_IOMMU */
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..b6897a9991ee 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -32,8 +32,11 @@ struct iommufd_sw_msi_maps {
 	DECLARE_BITMAP(bitmap, 64);
 };
 
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr);
+#ifdef CONFIG_IRQ_MSI_IOMMU
+int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+			   struct iommufd_hwpt_paging *hwpt_paging,
+			   struct iommufd_sw_msi_map *msi_map);
+#endif
 
 struct iommufd_ctx {
 	struct file *file;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4e107f69f951..ca17c2b7f455 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -294,129 +294,7 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
-/*
- * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
- * layer. The mapping to IOVA is global to the iommufd file descriptor, every
- * domain that is attached to a device using the same MSI parameters will use
- * the same IOVA.
- */
-static __maybe_unused struct iommufd_sw_msi_map *
-iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
-		       phys_addr_t sw_msi_start)
-{
-	struct iommufd_sw_msi_map *cur;
-	unsigned int max_pgoff = 0;
-
-	lockdep_assert_held(&ictx->sw_msi_lock);
-
-	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
-		if (cur->sw_msi_start != sw_msi_start)
-			continue;
-		max_pgoff = max(max_pgoff, cur->pgoff + 1);
-		if (cur->msi_addr == msi_addr)
-			return cur;
-	}
-
-	if (ictx->sw_msi_id >=
-	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
-		return ERR_PTR(-EOVERFLOW);
-
-	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
-	if (!cur)
-		return ERR_PTR(-ENOMEM);
-
-	cur->sw_msi_start = sw_msi_start;
-	cur->msi_addr = msi_addr;
-	cur->pgoff = max_pgoff;
-	cur->id = ictx->sw_msi_id++;
-	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
-	return cur;
-}
-
-static int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
-				  struct iommufd_hwpt_paging *hwpt_paging,
-				  struct iommufd_sw_msi_map *msi_map)
-{
-	unsigned long iova;
-
-	lockdep_assert_held(&ictx->sw_msi_lock);
-
-	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
-	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
-		int rc;
-
-		rc = iommu_map(hwpt_paging->common.domain, iova,
-			       msi_map->msi_addr, PAGE_SIZE,
-			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
-			       GFP_KERNEL_ACCOUNT);
-		if (rc)
-			return rc;
-		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
-	}
-	return 0;
-}
-
-/*
- * Called by the irq code if the platform translates the MSI address through the
- * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
- * allocate a fd global iova for the physical page that is the same on all
- * domains and devices.
- */
 #ifdef CONFIG_IRQ_MSI_IOMMU
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr)
-{
-	struct device *dev = msi_desc_to_dev(desc);
-	struct iommufd_hwpt_paging *hwpt_paging;
-	struct iommu_attach_handle *raw_handle;
-	struct iommufd_attach_handle *handle;
-	struct iommufd_sw_msi_map *msi_map;
-	struct iommufd_ctx *ictx;
-	unsigned long iova;
-	int rc;
-
-	/*
-	 * It is safe to call iommu_attach_handle_get() here because the iommu
-	 * core code invokes this under the group mutex which also prevents any
-	 * change of the attach handle for the duration of this function.
-	 */
-	iommu_group_mutex_assert(dev);
-
-	raw_handle =
-		iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
-	if (IS_ERR(raw_handle))
-		return 0;
-	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
-
-	handle = to_iommufd_handle(raw_handle);
-	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
-	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
-		return 0;
-
-	ictx = handle->idev->ictx;
-	guard(mutex)(&ictx->sw_msi_lock);
-	/*
-	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
-	 * assume the caller has checked that it is contained with a MMIO region
-	 * that is secure to map at PAGE_SIZE.
-	 */
-	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
-					 msi_addr & PAGE_MASK,
-					 handle->idev->igroup->sw_msi_start);
-	if (IS_ERR(msi_map))
-		return PTR_ERR(msi_map);
-
-	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
-	if (rc)
-		return rc;
-	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
-
-	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
-	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
-	return 0;
-}
-#endif
-
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
@@ -443,6 +321,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	}
 	return 0;
 }
+#endif
 
 static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
@@ -458,6 +337,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	if (rc)
 		return rc;
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
 	if (list_empty(&idev->igroup->device_list)) {
 		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
 		if (rc) {
@@ -466,6 +346,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 			return rc;
 		}
 	}
+#endif
 	return 0;
 }
 
@@ -682,9 +563,11 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 		}
 	}
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
 	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 	if (rc)
 		goto err_unresv;
+#endif
 	return 0;
 
 err_unresv:
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2d98b04ff1cb..386953c510b3 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -49,5 +49,130 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+/*
+ * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
+ * layer. The mapping to IOVA is global to the iommufd file descriptor, every
+ * domain that is attached to a device using the same MSI parameters will use
+ * the same IOVA.
+ */
+static struct iommufd_sw_msi_map *
+iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
+		       phys_addr_t sw_msi_start)
+{
+	struct iommufd_sw_msi_map *cur;
+	unsigned int max_pgoff = 0;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		if (cur->sw_msi_start != sw_msi_start)
+			continue;
+		max_pgoff = max(max_pgoff, cur->pgoff + 1);
+		if (cur->msi_addr == msi_addr)
+			return cur;
+	}
+
+	if (ictx->sw_msi_id >=
+	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
+		return ERR_PTR(-EOVERFLOW);
+
+	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
+	if (!cur)
+		return ERR_PTR(-ENOMEM);
+
+	cur->sw_msi_start = sw_msi_start;
+	cur->msi_addr = msi_addr;
+	cur->pgoff = max_pgoff;
+	cur->id = ictx->sw_msi_id++;
+	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
+	return cur;
+}
+
+int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+			   struct iommufd_hwpt_paging *hwpt_paging,
+			   struct iommufd_sw_msi_map *msi_map)
+{
+	unsigned long iova;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
+		int rc;
+
+		rc = iommu_map(hwpt_paging->common.domain, iova,
+			       msi_map->msi_addr, PAGE_SIZE,
+			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
+			       GFP_KERNEL_ACCOUNT);
+		if (rc)
+			return rc;
+		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD");
+
+/*
+ * Called by the irq code if the platform translates the MSI address through the
+ * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
+ * allocate a fd global iova for the physical page that is the same on all
+ * domains and devices.
+ */
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommu_attach_handle *raw_handle;
+	struct iommufd_attach_handle *handle;
+	struct iommufd_sw_msi_map *msi_map;
+	struct iommufd_ctx *ictx;
+	unsigned long iova;
+	int rc;
+
+	/*
+	 * It is safe to call iommu_attach_handle_get() here because the iommu
+	 * core code invokes this under the group mutex which also prevents any
+	 * change of the attach handle for the duration of this function.
+	 */
+	iommu_group_mutex_assert(dev);
+
+	raw_handle =
+		iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(raw_handle))
+		return 0;
+	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
+
+	handle = to_iommufd_handle(raw_handle);
+	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
+	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
+
+	ictx = handle->idev->ictx;
+	guard(mutex)(&ictx->sw_msi_lock);
+	/*
+	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
+	 * assume the caller has checked that it is contained with a MMIO region
+	 * that is secure to map at PAGE_SIZE.
+	 */
+	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
+					 msi_addr & PAGE_MASK,
+					 handle->idev->igroup->sw_msi_start);
+	if (IS_ERR(msi_map))
+		return PTR_ERR(msi_map);
+
+	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
+	if (rc)
+		return rc;
+	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
+#endif
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0

