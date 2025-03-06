Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149C27701D
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294890; cv=fail; b=CHY3YGP+2VIAXn5aDqYB+sQXYyOo8+EFvHupDDbaXKmDlhOEKDmXKPWb7GYd33rpMjJH1U261HhVu2cb0UFuov7KAPMiQHq9GsOtj/j0uMgrz3RVKTnn6Iiy101lgOPjUDrfmEo6fbxQCGz6bBNybhpphE9RheyijW5ygNbcWWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294890; c=relaxed/simple;
	bh=f9e3MvekFFZMOAA/aeF5ixGZWXFJSb1wjwcLY5Rda4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgRrIglSayvQI2ON5c+avnhLjrgyrJNa1RWI1wAt0AWwY/e+DIHDvpwqK8JsPytidG2iZ5VI7SXPfrluHSGyafoZ5kLFbv9P8m2M3eqxbVJNi3ABNtr5uBEjpzcPanOQ4g0zubeKa1KenvYDrbL0pA537JHJXqG0KEXnFp2YwaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKidv2Ud; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKidv2Ud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5TtMWmxY0VD1RIAlClqpQ54irDgoCvDtRPpujbF8AoNMoge520fumYjG2+JfTkde6ef7tHwu26iR2d1gpSNqgSCGTKqCQr/lpqn0lCXCCEScqHvx7POFwmjO54SjGcmHeVuUl2dYhriSadfebq4pnADGOhje48gd5FoIqt0kBhTOn2vCNSnBUCpHLh/ygKa4pE7a61dsmkMIcSToKuyWCoxlOwn+DXG0rPpmgSgD/tLYW4jFMKgB8RjzYXUo0dawrNApTsRP0AFaLoK4Sd2S2GPlcvvbik3yo19OSNM9cbQJV1Sbji13hvA74DlfPAvYZsG0E/MVCR5Zp0eFkLu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5smXpKAK7q/xKw6b2PzVgqSxnOMMMjAR7DVBgL62gNc=;
 b=QLn0BK5oH3udBYTuMdCAf4bNQM2j5Y4COqrMMplcJInp2bBLLOOVihCprpBxzUMV1eIMifgRNeYLNxr74B3dVWA3YKA/Uo12o/qQgWHnB2Pw10XyIUq8Btqo+2MqIc6krHcZwKok4m2yFjjOy0gRmRQVdKjMVDkSypJl+A0QRZTG6lPnpLYr5LmBd0QmO1aWZutYZUqOOJup0b8UNTWLBiy3rjtK5uOAZoY7fZdE/K33KxmBDmtqvXrQggcUVP6Fv6tDy8bytGPVhpwhCXZCed5UxPJ9oOuTShbofLPwtImjKOa6JgWuarrTVauNxwRfW74T29rIqOWpy3/MNgo0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5smXpKAK7q/xKw6b2PzVgqSxnOMMMjAR7DVBgL62gNc=;
 b=YKidv2UdNMFuGV5xWA2cEGwErRYEDk1bkhuB4iTHzqtjs1/ekiv6kGn0hbgAhEUjH3KqQD1+SdWoW6+pX4qvah4cBYNE52R7LMouFC+fc3wTrZX2jmHRJe/3Whpces3tVjJWEmv2DOi7/az9hAWt7/luqPcQ9VEJA4XMgbpjg/N0X5kjvP8q+XFKjqoS9s6v1mP1jzDZgw3td7ANuFBB/c35MJ6NUXUL9RG8TFrtBoX+Q45wUXjWVsAGINGt6Wouo8i+gUxnTHgSKSy+ETJAJPU2A/idQUaO1Z7Rewl8d2V6Crh4KB8npwMaOJPVEkvAX3Qg5rxEencnJc1eWFncmg==
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:01:21 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6d) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 21:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 21:01:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 13:01:03 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 13:01:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Mar 2025 13:01:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] iommufd: Move iommufd_sw_msi and related functions to driver.c
Date: Thu, 6 Mar 2025 13:00:48 -0800
Message-ID: <6a437cf5118d17e7e4d8002ba61498ebc8376b91.1741294235.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8a052c-fa92-41f2-4fe2-08dd5cf20be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wcQIKFF4D4Mq5Y5Z/6IXhAJT8BVhMxJ1wD0lEs6gClycYWD75NyIZxOwQBr0?=
 =?us-ascii?Q?2cqaQi0leMcq9Upkj/y1qmImCltTULtnDLZ6NuV0f9RR9+F2FvkFEysDr6aC?=
 =?us-ascii?Q?RksoOs70YUns+aXbDfRUDSZfOKgSyU3bkBFv0ltEGx1Zilw95Dx9PwXilBlO?=
 =?us-ascii?Q?FPHYkyOrgbiKr8/NJZQMWaI8kYOUiJCY2AzXtv+Rl2L+GwcrOt7a1s+66xO6?=
 =?us-ascii?Q?zUDteHv1Wco7G10zDm+AkBI2MMMaC+IQjttM/1E7Y8AlRXg7ZwHgQoWAbjQq?=
 =?us-ascii?Q?wTe0q4WiKwMhdYgSyTesLBXboP8LQaG2dmYR0F4kXlf3f9jdfK5bJCHdkh1y?=
 =?us-ascii?Q?vpLHC2alJsQjoIZqqHZ6QTW362Yc6z1VS/kt5U3MMX50GkZsNmETZBPaXvAJ?=
 =?us-ascii?Q?8WiHcR2SOaqjCq1jkqDuGQJUxmGlRZ73JCrvkLaMK9eFJ2tiseOvEiLizzrk?=
 =?us-ascii?Q?cafJj4YqLUF2NJQ713EDWVjdI4XrLjdIMXPeTpekpz9zrm7FgL1LJu3EIMPN?=
 =?us-ascii?Q?W4RgF+vUcLeUaBzDgZYi4Sk5odZ3f9cd69qGEs0REh5IVNMtwbRhK6QxFrv2?=
 =?us-ascii?Q?JxVf784IleL2AY5xgu+JyXE0maVapDgkQmbryt0OG3hyhF2MnFXGJBT4L7Pa?=
 =?us-ascii?Q?jz8nMgvu5omDI86zS/2VRdxgBCLTGqAGED6WMTKUCRE93gn8TDdf163+3vlb?=
 =?us-ascii?Q?p+P/ehP1iTkGVAhd3YoINCoPKUY24msl9j1FA7zxEZHctjtNJ9ntCyx0qrMK?=
 =?us-ascii?Q?0g71NUwJvODVlTfsNWAwbUWLbO9rRxRsRonHBsOJzZ+MHxTq7/Mj6Vykorr+?=
 =?us-ascii?Q?e3I287Mg+88GDyjFAHEOyT29cyk+nGAWO0gi6MQdJGOKKIi+ysBE65oV4xbg?=
 =?us-ascii?Q?RCiOsf7+AKJCqnChGGM6zqm8xspt2PPbqmYmuMfGwyUds3Z6Ow0BAo35Gxva?=
 =?us-ascii?Q?W1h1OTS4zEBxjixIuGdceOITvlXnT0GKdGVUdDV9mKYIG9qNC7CNfOTamGOg?=
 =?us-ascii?Q?gCuhyf4EAHtnn2lGXJtCfP5RcxSTQw/jRfQ+gcBFD2gc2Uzsj1yLhDXaMRHT?=
 =?us-ascii?Q?oDBYAIvUrgYBDS3BAvgphgtmjnAHqtStuE0FuROEmqrlY0u7syER3ToJ5ysX?=
 =?us-ascii?Q?zA+nxPdjyElRBgCfNv15/tis4vL5/84i+31fi3AShK+AFLf1XFxDP6m506Eh?=
 =?us-ascii?Q?6EhLIBd+HObpQdUyQFCmxEmIwG1rNLbSCkSZbwLd3r6Sc5KPTRqkJQCKn6U7?=
 =?us-ascii?Q?/FU0mDtFOA6zIh1MQlqbwNTwMaBp+hB67FKkk2skIO4tXeLoASvOyeibkMog?=
 =?us-ascii?Q?4So7tF4itFRyV44VskmJBFbmNocpkJVD4MMl+l/RHdZDSiy/g0rfdlfXVSlK?=
 =?us-ascii?Q?6hM0n4lVH7h9OpJTwRzee1YdYf08K7O/zyo9RmIpczGaPN/xbYJLloDX0E/T?=
 =?us-ascii?Q?jlKWfKGM0VsuWdVJSwO3k9y8WYI0d/LufUGDjQMCxcBvxfPCueIfeCPrEl3w?=
 =?us-ascii?Q?w0BAnMIiHxFcjQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:01:20.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8a052c-fa92-41f2-4fe2-08dd5cf20be1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

To provide the iommufd_sw_msi() to the iommu core that is under a different
Kconfig, move it and its related functions to driver.c. Then, stub it into
the iommu-priv header. The iommufd_sw_msi_install() continues to be used by
iommufd internal, so put it in the private header.

Since this affects the module size, here is before-n-after size comparison:
[Before]
   text	   data	    bss	    dec	    hex	filename
  18797	    848	     56	  19701	   4cf5	drivers/iommu/iommufd/device.o
    722	     44	      0	    766	    2fe	drivers/iommu/iommufd/driver.o
[After]
   text	   data	    bss	    dec	    hex	filename
  17671	    808	     56	  18535	   4867	drivers/iommu/iommufd/device.o
   1900	    100	      0	   2000	    7d0	drivers/iommu/iommufd/driver.o

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu-priv.h              |  13 +++
 drivers/iommu/iommufd/iommufd_private.h |   7 +-
 drivers/iommu/iommufd/device.c          | 131 ++----------------------
 drivers/iommu/iommufd/driver.c          | 125 ++++++++++++++++++++++
 4 files changed, 151 insertions(+), 125 deletions(-)

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
index b2f0cb909e6d..814d059e333a 100644
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
index 2d98b04ff1cb..5132fea9e52a 100644
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
 MODULE_LICENSE("GPL");
-- 
2.43.0

