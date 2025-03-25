Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC91A3161
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742875552; cv=fail; b=TnexTE75hkTxlSop7AnrVQlqA42LjlSgpDvhWOTOLSN3nMeXfjS7jV4PVXcN718O1uL9Bk5nguejBZRFVDsSzTua30YmlHkaMK7wLus/ymFmwzsMMUT0QvoPt+IS7srHXtMZjn7cGSQ4UBRDqcVfVI2m4MGyjBoS/HpC8jIIMPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742875552; c=relaxed/simple;
	bh=DkLMrCWuFSFnnjXli/zKmzTX6SElhAAIBkiAdzgajW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXJkVWkHvUM1pK4ZKgn00wO13CharQWH4lN7IhKx0wevOs5No/tQ5wVhAH3jCbRp086P5/IfyYUAvkai4M79IM5j3zm/RDrV5+nIEpVuBRf/ll0XPpjOW138YTMycHn7ntdHlCoklhtyxO/HWFgy8DXjxY9BONGBJXt+JLpYI0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I9DRhbpI; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I9DRhbpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsxikHo9mtxo39Omq9JkmROEIPnViT0AyABAO5qlS0l2l2ZwIepCs917EHJodkRKzP0tzizxvm2GQCVKW9phL/kVJvvMjJxGGW/xHEwAWx/5+T4Qe5hkq8mK797ZWlfLSFwkTjzm1+sQI6oIxv47/oibew+PfQ83l3txeOoOYBdnVUerQGmJ8/AdTcsBuEwvYWzsiyuajo/GralBjWSKxeeRVyEVoXFRsgyjvhBYlkfvXFh8vY3rqJZrfNSgre7NLJqZnPr+qIwHc5xX0M10u4EBS5wapMC6wXr0FWjmZ+53D5leV6Dk09vcIkIAR6gGv9TDXDIzkFrD3CajjWjakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFK7YfycJoDXwBGZZtPXrQqKFr58fCidFpvfEIDy18A=;
 b=W1j42b1YWurFcQ/cKazGKTknbYF4I042LH7Eq8yV3IgRxajn5t+uW/345bfnC9xFC7z3NYh3sBMkUOY05SQdobGmIlfwiJcNoUvi+/boLd07JAvJyX2+35LD1FW2nQGpkj09fyf1GmdSA5UeMbwMnhwwsUbPXS2Ici9oktIEk1pUSSLqwRG6GNLmLcx2C0bMyVZW6bYsomlRimSqvBUeJ+FZpFmDFm/WqMAhwm02PPNjkfmm3T56ICqL4xGP9UHQNlTzzRm8A+zYY7BZkAV7VV8iI+ebIqSubO6oFY3FJNJ9bx4YKYkfIp1G3sanaar1StKATZoeKBC08lIQSjHxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFK7YfycJoDXwBGZZtPXrQqKFr58fCidFpvfEIDy18A=;
 b=I9DRhbpIQx28kN0suOexsK9JgbMWe98A9JG7xhvaPR9sN26bA9HOuOdcVrwOYEYJiRl5C5NlOAn/yiae6TIzszxiujkxHGVxvWmBKdCCYKsLKe9R7khocZ2MWmBOgIEDjTViBWOC0TA1htJ1EjFss31uSAOvvrT6eJFz4xp87OK68kkmxC/hUipXwrC/J86DCHh5NQwTdfuLr5VZRN5KJNpZQgF5PgoqgfyCE6E4cjkDgt2LQUFPMLM81xsnjRkpCRqUQzz6TnIlzMnoOVjzpI9MHsEw9yd6p5p9zN+0NuWRaHJ55VxqRKHpdwvNhv3TECBKOPd+oaUhisaCMxWNew==
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:05:44 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::79) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Tue,
 25 Mar 2025 04:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 04:05:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 21:05:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 21:05:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 21:05:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<kevin.tian@intel.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>
Subject: [PATCH v5 2/3] iommufd: Move iommufd_sw_msi and related functions to driver.c
Date: Mon, 24 Mar 2025 21:05:16 -0700
Message-ID: <374c159592dba7852bee20968f3f66fa0ee8ca93.1742871535.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 951d558d-86c9-4f0c-f7dc-08dd6b52509a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t9DZxOlynoVIhC75qegUEmV5wPFSbpvJF0oWoOj2wpHzzVETyXoJF7SQQ68X?=
 =?us-ascii?Q?I4EupjQATSp2YTucRO7VI6bs2Rld0Jc1RfOKFTSOIzm/iuCnoq3nJZJL9yHq?=
 =?us-ascii?Q?oXoR3srBNHS9S88XYd5Y+Noxp6sAhRfBXxRKCMyQXZ9LAMA68TPvDKmKGcU2?=
 =?us-ascii?Q?DJfyZScyLl/QcjWn5jwCmOyiRiIZtGJCu+GboWUdXKVLyJDxwOKyvLUamBRc?=
 =?us-ascii?Q?D0iXsy849TieWQTpTyfUwPI/gM7NNsJkHVZwkwBGbeO6JMd0f/wYaroiuYR9?=
 =?us-ascii?Q?F74WrNJ/13FGcgdo/tVV6Rbvr8a5rGxKPqPfPZhMBN44RYXkdTh2xH6MFK3E?=
 =?us-ascii?Q?gOIW896IQpJvO4k8ja+r8ecfIKE1MmWyhomTdNXThTwgXiNrES91seAoxgsl?=
 =?us-ascii?Q?VqnVn5P5rZNZ16v5wuiluiTktFORwn0e7kVrtUa3yQGp9B5uGZ+VX/bmNNcY?=
 =?us-ascii?Q?4d4G5KYe1aD5vuCXBLY0uPR3R0pr8ZXCCL2knkiM+eAc0fV1MOZJXPbX27L3?=
 =?us-ascii?Q?jO6TG/OPoL79QCQeFtZNQGlZ8jXvBNTc7vdJQGkksd9WIO9ZrO6CEUHI0SBz?=
 =?us-ascii?Q?vQj1iFC5DxYpTA/0tJbW92uc4qVslIucO6nfYfE9n21Sf38baX7vFJ/k0ea0?=
 =?us-ascii?Q?zm+jHJdfyc4tmmCwjAvInFiKjt9gBJeMiM3fQLo5RWfouOJ5lp9tHUMEUK8l?=
 =?us-ascii?Q?ZGz7HLCcW12yMG5DBHxkZAs0TPxGxGMbi1npWbhQs1cTenKwV2ymHGm5+oHC?=
 =?us-ascii?Q?9C6i8zWRE6h3k4F+rfB9xZOEnLSpNUzM7AB1L0ChP4cf0xh27TVu2UU09NAi?=
 =?us-ascii?Q?/RIRxgTEZTru8EDQJjI/ZbhrY/CBKrUvQWM6rsO2qDfP0ozh7H7Gpy+fMTtx?=
 =?us-ascii?Q?aEnEYwO8DyKn+vHvAJYgv/ctsZQbhR8y1f/udROVukbiMvbinVZBtwskVBJT?=
 =?us-ascii?Q?TxRpnXeVkY3Xh58pfK5MK8gXkL22uoUyljfaT8vZyHIFItbdl9wwrrvZ0RNQ?=
 =?us-ascii?Q?/1jxqikIIyAw68rINuRj4EjpxWLbgTJrtrK44Ca6zjhEvP8+2BG9l/OVvMVP?=
 =?us-ascii?Q?ItAD84AWgiLTRHQJBaG2LdCDbiG2+kTw9kKWr392NL3MgZufpX4oZZeydixS?=
 =?us-ascii?Q?U8RQsU4Y86Lulv9B0DfG2/P05ZUOlb9AJ1vfLNwqASIl8kJd6bSrGfqpmWjI?=
 =?us-ascii?Q?bu1+016nCAbFGhk9vp9Eyj1k+7DFfjIzrHap6T008Jw5zqYdV5tFl/yhHDia?=
 =?us-ascii?Q?La0pfYcU0yO4a2hzuMjeTqx6oiidqhHrx6ENDl9Z+7Rv8ziI13mS7Zx1sncb?=
 =?us-ascii?Q?wKL+qOOCfPFm4n82TguZpc07EbSgrmbUqy8ZTKPEKjxN03Fl5yQ1looKbBaW?=
 =?us-ascii?Q?+b9dhfUxIj7UxZzIXwNVzuoqPL/3K8hh+DeHzIEPA5GlfFv7raNqhbxwIliT?=
 =?us-ascii?Q?Zxz5vT2gz3ZyBvCwkAyqSHM9CFAigqNCJHzEeXhPfuvrk1S35/xKp+3Mc775?=
 =?us-ascii?Q?O/+CJRlWXa4zJD0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:05:43.9364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951d558d-86c9-4f0c-f7dc-08dd6b52509a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615

To provide the iommufd_sw_msi() to the iommu core that is under a different
Kconfig, move it and its related functions to driver.c. Then, stub it into
the iommu-priv header. The iommufd_sw_msi_install() continues to be used by
iommufd internal, so put it in the private header.

Note that iommufd_sw_msi() will be called in the iommu core, replacing the
sw_msi function pointer. Given that IOMMU_API is "bool" in Kconfig, change
IOMMUFD_DRIVER_CORE to "bool" as well.

Since this affects the module size, here is before-n-after size comparison:
[Before]
   text	   data	    bss	    dec	    hex	filename
  18797	    848	     56	  19701	   4cf5	drivers/iommu/iommufd/device.o
    722	     44	      0	    766	    2fe	drivers/iommu/iommufd/driver.o
[After]
   text	   data	    bss	    dec	    hex	filename
  17735     808      56   18599    48a7 drivers/iommu/iommufd/device.o
   3020     180       0    3200     c80 drivers/iommu/iommufd/driver.o

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Kconfig           |   2 +-
 drivers/iommu/iommu-priv.h              |  13 +++
 drivers/iommu/iommufd/iommufd_private.h |   7 +-
 drivers/iommu/iommufd/device.c          | 131 ++----------------------
 drivers/iommu/iommufd/driver.c          | 126 +++++++++++++++++++++++
 5 files changed, 153 insertions(+), 126 deletions(-)

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 0a07f9449fd9..2beeb4f60ee5 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IOMMUFD_DRIVER_CORE
-	tristate
+	bool
 	default (IOMMUFD_DRIVER || IOMMUFD) if IOMMUFD!=n
 
 config IOMMUFD
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
index 8cda9c4672eb..8c49ca16919a 100644
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
index bd50146e2ad0..d18ea9a61522 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -5,7 +5,6 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
-#include <linux/msi.h>
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -294,129 +293,7 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
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
@@ -443,6 +320,14 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	}
 	return 0;
 }
+#else
+static inline int
+iommufd_group_setup_msi(struct iommufd_group *igroup,
+			struct iommufd_hwpt_paging *hwpt_paging)
+{
+	return 0;
+}
+#endif
 
 static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 75b365561c16..a08ff0f37fc6 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -121,5 +121,131 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
 
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
+EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
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
+MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_LICENSE("GPL");
-- 
2.43.0

