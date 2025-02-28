Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944F219E0
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706305; cv=fail; b=PXcTZrtKAz+BgC5YIla8EEKrsnXuwGJGUUdzMaHBWcsKN6yxtrG5Tr8pislFVpuUMnn5a8P37ufNHf3wgqV5p8xzC5K2V9Zi3BMtBLtPrlOrBSGqHnqsX5qi6lB8Cb14LQrFZd2yXXNNB0JeJ217GYg+EVxOBBVB1NUt+bQKNS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706305; c=relaxed/simple;
	bh=aDQAvX1dyU/uZxAne+fd5J5ZfT1OeGVpUBYPTkf/xpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlInfClhQQ1IM9gI5rZpcPIon3BhTUVBDTp5YTf6O/vJIi+KUTYb6AXZPIMrxN9KJjDcOXmVidGPGdNqQV5E+V3LM01U9k/24YngeYMVst/e+notYVmEUtKrydq20mLqDrMRhm3rUPISjQELcoXc2th1eY2kdTVDPyJ8CKixfAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i05aTJFq; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i05aTJFq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajb3Rb/UTUPF083vtRyBdXx522bJ7POGZmt4XfoCO7LjVcSbTxLoQ5ey1SVj+EqhcsA09JHXLQ4Us66SQMFNVSXRClBQLWNnp7yduJoXDW3gNL25zTIEMIVH1tI3dXS66/fK054zUXhcCEggP4/wsKdqBzYM51ObJgdqjPpK2R1Wmcpc/l9HVgBWTaxVI1CXAvRgvYDaVWh7zrG0/7p6Yc6jydFGg2YREh3ee6EVCy+KuPJuWgkkmCaXxS/E/VR6NEBkWhR2mt/buye9UOII3dk9X9r4cZHh07ek/FAdwz6Yak+qcboJ+MCXzRtSi5U2j2EuS/oNHdWMF3r1aTD4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yziw4scXx77v9Y3E7zomKVD0y8RTpeWYUQ0obxTZbE=;
 b=f/D5KTcR2XAspUT/ltNaZQMm3smTWNEMpviQloC6DWW8N5lz5qga/Sz7BZnuNc7yjFi/BTe5pOxU5hv23q2AUNjOQnaT7hjNOHFw75X06qgxD6Vcfs1O3lMX2etDyx63DVbTZtI3V3JMA5+U5LbB0SDAGxbEk6JyNQhswWeDJ9es0dOH9kZjZn/g2VQ+Cdh2mrDe/jhMaAEmE+knYsF6ef+W0R+8ZLhbx5D2IvADOxX9jeM0q42JaouyfJkSqXjg2bK2ngRCyjY5x+f6lamYM0FQEU3/QmGhpRIEoOvTImJIUpkqCImLSFKuu6AWHjA38PN2Skj8FaTk15MOamDLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yziw4scXx77v9Y3E7zomKVD0y8RTpeWYUQ0obxTZbE=;
 b=i05aTJFqI+9QZ22pdIYpSB1zu6IGZzbOvIhfD0rUqxqS8cqfBbg8TaY+RltQW6HVv0lsuE9a3tpXOnzbdspEF8g7d4/T64VeJK4uVgLUUzPFXlJT4hB7r6ycgaYysN7mK+w9gsLEOgBoRuuI//W0ZUn+vWHlJPqdOOIOcjRa+rNDLa771SjjJrAmbZXuV+4QY//n2sgpy4wUJ+JN3jGSn0U0szB90XalGXRI+fwQFaM9WeNcagc4SV6r9EKFPj/ePVCo7q8OfMjPiWx375GIjeZc1S6j6YlQSxshZvcr056QF+iy8tpNo+aaAxfHO0dAQSffGlf0thnOihMBWT1q7g==
Received: from BLAPR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:36e::13)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 01:31:38 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::bf) by BLAPR05CA0018.outlook.office365.com
 (2603:10b6:208:36e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 01:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 01:31:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 17:31:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 17:31:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 17:31:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] iommufd: Move iommufd_sw_msi and related functions to driver.c
Date: Thu, 27 Feb 2025 17:31:16 -0800
Message-ID: <ece6ab9a0144eaabc285eb21a09da683d6d9951c.1740705776.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740705776.git.nicolinc@nvidia.com>
References: <cover.1740705776.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a79996-ba4d-455e-0ac2-08dd5797a515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKWlsvr7irHIcvgVHAexvyoz58tL6FZi3sK5brgC/c5mqS4YruWiRBhYj3a9?=
 =?us-ascii?Q?u9gD70x/LGWghw77T93vOqde1tjb3JjZ/KOtqVv+661tb3FvrrhtrZpbGrOU?=
 =?us-ascii?Q?XPvzq1kgcPXa+HK8WucusFugW13m4+JJVfx9RQ0RpuQkfhFLyKa2cZY82jyV?=
 =?us-ascii?Q?DDwMA94B7/TDlDyndWvFh1nxXVuNodv+525qncEKn/DNqKAGaLMz83b4HR3x?=
 =?us-ascii?Q?eJE2J6JrSFBJaBen0IVxq4LPrZx4YH/x7t1jh/gMKgTMB3a0o0Tlaqeza3/T?=
 =?us-ascii?Q?854IwY7RPCVwEZjjo9xYwyZjm1muICkC2Q4hkOxAtlL/M8EuP1nrx/VJlow3?=
 =?us-ascii?Q?xUlYGQhwjyiYrB0XGCfxu/8kgMN15WK8WUxS2+BMuKGYeBpP0Blnf2BNG83x?=
 =?us-ascii?Q?SCuXdzZSgzgbYGYlg3zItmxR38Mkb1PXIPgEuZnUlSXkRYnBMxoQFSUYuN9/?=
 =?us-ascii?Q?SVhQhRBZiLwsTkd8FlET1ZyUWXt0NOSPEU5AS7fQmHfxvO/ndO3ffcjxmuKn?=
 =?us-ascii?Q?BenFrJGXQPK/kfn6dGxMjwBqqi09OJt+oW8Uo0cD37HJo4LkoYmZdxTP5BGq?=
 =?us-ascii?Q?zKSfiARhhSVMKYMCZaJxX+FImwRzzi0hTGq+NfZuzD1PJAJltEDB834SahTp?=
 =?us-ascii?Q?Dg2NWLrG/uoq1FIRIentX4H8Xa8Ubm0vYMW9J4AKQw0CuLzjit2LKgWdyuuf?=
 =?us-ascii?Q?/34TNTs1iy4kRQedoSNhuIlfizwq7LDV2SpTHkDidw+2KrcCWpVbEDzYo8Mm?=
 =?us-ascii?Q?m77lJa4A1WqhdCnBBPNE6BuhD5zQVu3WDNdsX1TASFTHnBxcJe62zPd1+OZ1?=
 =?us-ascii?Q?z4dOUdcdMo1nU4yviysXJJU6O7KH4D2XLzoo6qYT+dvv0P/DI5fMt1lrlMiZ?=
 =?us-ascii?Q?wIwhZWD/Y/7M+CxMj4jmb2Ilx06mCc/h1maDl372PdUZoeBdumCAJRqfi0M7?=
 =?us-ascii?Q?dbhNNDgPbP61b+LY8bz5yPBtXrbec1+55Uv0kDpsTcD4LawZDPnQRrNzm672?=
 =?us-ascii?Q?0gxp/Fz7st8FLrYnvuqQHhd3t1NHw9bjjhKcyZDTK0A4ilW/RBPrPWFHbjSx?=
 =?us-ascii?Q?aDRFIrEnC1a+HPCoA3dAB72P/tW/sR+K2SUjOG0aBFbvpZrtEMj8DDh640s6?=
 =?us-ascii?Q?mN085VEf2CbDQ79Yr0Grau/I8zQdrjcIhPnHC3jf8SYaRaGuxb1I5MW3EXDr?=
 =?us-ascii?Q?bJCyw9W98SHbmU0boPc59KgQO1i4egZdBF+/+Oc7aTm77EZAesq3Dd3PjyaY?=
 =?us-ascii?Q?4oglhm4JNTZ9V9BS16HmZjJIhU1cyRPCwdQJgNwyLdYnT1RheNrgu56LnGvr?=
 =?us-ascii?Q?YjUM6iFd43KBK+f3+7YDBfMvwVE+Gkfg+n/RgsVYj4jfEdTftwn+9WvOABnB?=
 =?us-ascii?Q?ALbN4zk/i0fXxm/ADVe3n/szPFmmaY+oeozvlI2tUkx5OKalcPQoMP5HlEUH?=
 =?us-ascii?Q?Swdk/56pLYXgG7SePkR5TKTxpy85mWpTwSv1hfEIPWzuASgVSHm3EVGcWbq6?=
 =?us-ascii?Q?JJ6S5TL6NFhhrL0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 01:31:37.5745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a79996-ba4d-455e-0ac2-08dd5797a515
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

To provide the iommufd_sw_msi() to the iommu core that is under a different
Kconfig, move it and its related functions to driver.c. Then, stub it into
the public iommufd header. iommufd_sw_msi_install() continues to be used by
iommufd internal, so put it in the private header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   5 +-
 include/linux/iommufd.h                 |   9 ++
 drivers/iommu/iommufd/device.c          | 122 -----------------------
 drivers/iommu/iommufd/driver.c          | 124 ++++++++++++++++++++++++
 4 files changed, 136 insertions(+), 124 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..51da18672c74 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -32,8 +32,9 @@ struct iommufd_sw_msi_maps {
 	DECLARE_BITMAP(bitmap, 64);
 };
 
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr);
+int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+			   struct iommufd_hwpt_paging *hwpt_paging,
+			   struct iommufd_sw_msi_map *msi_map);
 
 struct iommufd_ctx {
 	struct file *file;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..2f272863a207 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/msi.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -187,6 +188,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     enum iommufd_object_type type);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -200,6 +203,12 @@ iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
 	return NULL;
 }
+
+static inline int iommufd_sw_msi(struct iommu_domain *domain,
+				 struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6dccbf7217f5..9c1fe3170d16 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -294,128 +294,6 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
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
-		cur = ERR_PTR(-ENOMEM);
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
-#ifdef CONFIG_IRQ_MSI_IOMMU
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
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2d98b04ff1cb..999da79dfa36 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -49,5 +49,129 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
+/*
+ * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
+ * layer. The mapping to IOVA is global to the iommufd file descriptor, every
+ * domain that is attached to a device using the same MSI parameters will use
+ * the same IOVA.
+ */
+static __maybe_unused struct iommufd_sw_msi_map *
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
+		cur = ERR_PTR(-ENOMEM);
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
+#ifdef CONFIG_IRQ_MSI_IOMMU
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

