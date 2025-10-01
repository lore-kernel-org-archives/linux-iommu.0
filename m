Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433292D949C
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299083; cv=fail; b=JRzum8GhUX8oYKPTL3yXntYMUkYHJvOwTzBW/ha6mnx+wJwS5UEMwc4M3C541nbziD4FFDIlyEan9bkjRjpGWDKyVZlzLqNXMB4RmF+ouy+t1GYIziCe/RkiYF/Xu3+QwueQ+Fxemds3Vk6Q5XfotfoKpgSAXCapeLNMwEgr+tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299083; c=relaxed/simple;
	bh=FXP90p3BGBcDyl2mK9AVeqLOlIz438VhVQSvOcJ+5MQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHL1EHbyYQqAHo5Fj0VZPl4C0NYz6qTwlFQwuM1mu0CjhF4ss3DrAgDKk2kAEkEiVfBXhLNROPiXLtb/dLl7mtfhft1ANtyQ0TfhRDFdZw5zehdIYlSMm04cERzjgrwud4mw5i7gpx9JkN2Yyjg89TvnUzpjJa9g0Pq6H6xk4Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eErj5HLD; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eErj5HLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8k76zpgrHyKjbHgBobiccOObubOftb7odswKJUijlRc6IQu3VOszCBODcf8tKIKSu9aLb6qZKF7PHqdB0owk71dyE3FsggNJCL6abZF5e17FAoaHO9CiSWp8ZDo1QiEROrTTM6wwBjZjXLi7OAgxcxF8VRxbOMYs2WhihRxXAl0GpmfXMEhQHBUf3iRX4OTjHZlP/P5IVaOVzsYrl22UaY1Kppylj3pk7LPxt+Nxuelf6Xjg3vCDr1FKglRfDifFYC5VnXRj3rJK8YrEbZi+6UuTcv6VjV371POtq5BnOZbt6KLqOg7lb+fplQzaT2mi6fXT9g6Du72Vb8AwJDQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6abshNYOoBrUrxzCDH6AFZCtDOVxvT8N7JiWX8y7Isg=;
 b=Yu13ivwi/inhQ1ovNJlYvmUvq+r8u9pGgq9yqSZYNpkqvYp5dnT09/b4aVspnHdF5dyiRX3J46bJUtxgQIZJBcaXAMgqz4UgVOUClakuslQD487XGeaHkMoy680pcRI/6UmugWKMFyM8A/hQg79qByQlp0mCBWBUL5R7PhXv1W1+S3LmXcLU/Cu44PT9EXc0xcBxkmQc8WC+ne/JAfMBchCTJkNLbYyIGPPJtPQjk14oUDLk5PP4RMxCQt/NND8i4Mxoin2hf70OA+99Ge4R8zwqUOlzaG+JqyDJ+9jdx7Zgrk4KvM89E0GulSiu7RWY7ZrTWAnqbiom1bNIWGtgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6abshNYOoBrUrxzCDH6AFZCtDOVxvT8N7JiWX8y7Isg=;
 b=eErj5HLDsnFVqEAZ7zlAX3IVrYQNNOkGDjseoBQ6+9p47NVAScRKFVPrIZfCZLuFmJm7ONJeZ9IjEwV0ZCjIbGm1bZDp65EHycWE2QVWxFQYNIRGsdMhlyNH8ETqKVHykEmKAusPEI4FsZqasYjPbXVBDA0piI5GJa5SkOZhjSQ=
Received: from SA1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:2d3::7)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:11:16 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::9c) by SA1PR03CA0008.outlook.office365.com
 (2603:10b6:806:2d3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:11:16 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:11:04 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 10/12] iommu/amd: Add support for nested domain allocation
Date: Wed, 1 Oct 2025 06:09:52 +0000
Message-ID: <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|BL4PR12MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bb944a-bdd0-4292-cf99-08de00b154d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UCjwCS9n3/MQYvkfBapN1Jea7HldYHXQCa30GIdJJH21sSouKo6jNej2ZzHL?=
 =?us-ascii?Q?wgLhTNAEA5kwdOo/xmEFH69ysiiuuwcGd46uPQHl1ciDAhsVA8BZoV1yLfLq?=
 =?us-ascii?Q?6cbCZXOqAV/f6WgkW06Ve3DghZNhdema/YdSpoKTQHkRvxGIvOtJW5kvS6Sm?=
 =?us-ascii?Q?lG6kSEmsbWCVHAF7IVXPcSkU5raxIxWS6PcZIDM/mB5jX9XnOjoOIvnN7vjE?=
 =?us-ascii?Q?gab88rAGlC+i6WQi6lQ+BCAoayEuw/7QoE9UFVRBPXC8zZxltaF5hKgFoxw8?=
 =?us-ascii?Q?CPe/RiIOgaAYjeMs7/lHL+dXDlEcdQmvK2nh8eZpku4qcIEAzkFLKX6IWZ6T?=
 =?us-ascii?Q?i2bRmKu57DwLOJkODf+yphZquqMUJrwygKutIhwA1at0YEKHC9QF+xhGG2Bd?=
 =?us-ascii?Q?2iGkx5cg8bWafkCZxYgjxNhgabJ4wLT3ryK6xhK+KdH585GJb9FeLkRtIFE5?=
 =?us-ascii?Q?ELqw9K4QXwntLPqAsh4G1LZRKeiFuGzjYZJYqF63OcnsbJI2gzfWi0GrKXd4?=
 =?us-ascii?Q?mq/Bx2QED3ecT134hZNEN0/DRmCkz3UCwmK2E+oPYgSvR0vzZtS6JCO/kmUo?=
 =?us-ascii?Q?+u70dKluS/FofZOGevOs4WyD7XwKInclEnFQmtsNPmWdQ24aw3BzjlLwPdxG?=
 =?us-ascii?Q?7EV3EHGPYqvo+2VZr2LG9YW5GBmD1zJt8R+PxoLAZfPPQ8ZKcs5/b/KCPPaJ?=
 =?us-ascii?Q?Zz0zzMO8PKK1AaIETrnjO717kSge7/2w+0mxuHA5ch5mkuNnQ+E/Ay/TiWfV?=
 =?us-ascii?Q?rH6P/xl6WULbOXWBbMzC9dGDdXfscBjDOVHKmk91oqImJnjOJa+DmNXvkk4y?=
 =?us-ascii?Q?3ryevU9flwbZYXzVo0nzSKSCvNimWd1Lnjp6nWY0McXdL60wwy7lXV0ec85l?=
 =?us-ascii?Q?OlaFk+gu9IFHl1Qy6FbMGHkEtnw0dIyBFZw39f+ujU2UwA+BJRa49oeMf4V6?=
 =?us-ascii?Q?hBKHuQkWidjsqOAYZ5v3NhQFP1AjLZnvX376XmnRy81+hxUfUWyn1yVC6BA0?=
 =?us-ascii?Q?SoEKTgjEgKBk1Sc05974+mV4KOmZSI3xy6JwxqaQkZ1wv0Fs9bNp3aRG722k?=
 =?us-ascii?Q?VRj6FhcRALUNotTFHkPvMKhK2WiDq8SigP9q/3tm52Gy3d8zKy9m5FUWnfho?=
 =?us-ascii?Q?IOI2JBvtMS3wC2j75i1wN6761/8VNau/dVQyoXnK2TrEvJzy6wjtSXiu8xGY?=
 =?us-ascii?Q?Osf11oN0lhYvK9UUr6ggx/B5VvCMUrgkRW0VlVldLjJmoM5Wtv2D8LZJgZ3j?=
 =?us-ascii?Q?S6/e8xFNh+sa+s+EPTxu4xWqUKvHWzxKwBV9ejTYlTq8WSRmZbTcSDntwsSL?=
 =?us-ascii?Q?lzLtFB+DZ565kwF79AIt2vOlcr7LeS8lkQVz1fDr9hiuYH+ggaJZZLMeVvj3?=
 =?us-ascii?Q?CUx5YzsIMnT+G7oR3K7k2dPs2sxl3Z/8SwlyKBirrKGGC0cayVmcCn2k5CYF?=
 =?us-ascii?Q?uUBD7E6Ez6Q6GeOTL2ywVFn/6Tk53LGZ8rSg+aZ3K+Brdm5n3yet1skHwV4Q?=
 =?us-ascii?Q?SRqPXh4c0b9JaKuehfTnoVcKR7LUzfqxJzVgoUdcc8m5X4hAPL+H1GUfvefP?=
 =?us-ascii?Q?KvBcuD0OCoPzsYZeNTI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:11:16.4807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bb944a-bdd0-4292-cf99-08de00b154d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534

The nested domain is allocated with IOMMU_DOMAIN_NESTED type to store
stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
table along with guest page tables. The struct iommu_hwpt_amd_guest
contains this information, and is passed from user-space as a parameter
of the struct iommu_ops.domain_alloc_nested().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       |  5 +++
 drivers/iommu/amd/amd_iommu_types.h | 33 +++++++++-----
 drivers/iommu/amd/iommu.c           | 14 +++++-
 drivers/iommu/amd/nested.c          | 67 +++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 5ae46d99a45b..afa12ca2110e 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d533bb8851ea..cc1f14899dfe 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -8,6 +8,7 @@
 #define AMD_IOMMU_H
 
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #include "amd_iommu_types.h"
 
@@ -202,4 +203,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 	new->data128[1] = 0;
 }
 
+/* NESTED */
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d8c755b2045d..ba27fad77b57 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -20,6 +20,8 @@
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
 
+#include <uapi/linux/iommufd.h>
+
 /*
  * Maximum number of IOMMUs supported
  */
@@ -604,6 +606,25 @@ struct protection_domain {
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
+/*
+ * Structure defining one entry in the device table
+ */
+struct dev_table_entry {
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
+};
+
+/*
+ * Nested domain is specifically used for nested translation
+ */
+struct nested_domain {
+	struct iommu_domain domain; /* generic domain handle used by iommu core code */
+	u16 id;	                    /* the domain id written to the device table */
+	struct dev_table_entry guest_dte; /* Guest vIOMMU DTE */
+};
+
 /*
  * This structure contains information about one PCI segment in the system.
  */
@@ -857,6 +878,8 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
+	struct protection_domain *parent; /* Parent Domain the device is bound to */
+	struct nested_domain *ndom;       /* Nested Domain the device is bound to */
 	struct gcr3_tbl_info gcr3_info;   /* Per-device GCR3 table */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
@@ -894,16 +917,6 @@ extern struct list_head amd_iommu_pci_seg_list;
  */
 extern struct list_head amd_iommu_list;
 
-/*
- * Structure defining one entry in the device table
- */
-struct dev_table_entry {
-	union {
-		u64 data[4];
-		u128 data128[2];
-	};
-};
-
 /*
  * Structure defining one entry in the command buffer
  */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index facee0f7a131..c1abb06126c1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2613,6 +2613,9 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
 	case IOMMU_HWPT_ALLOC_NEST_PARENT:
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+	{
+		struct iommu_domain *dom;
+
 		/*
 		 * Allocate domain with v1 page table for dirty tracking
 		 * and/or Nest parent.
@@ -2620,7 +2623,16 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 		    !amd_iommu_hd_support(iommu))
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+
+		dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		if (!IS_ERR_VALUE(dom) &&
+		    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT)) {
+			struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+			dev_data->parent = to_pdomain(dom);
+		}
+		return dom;
+	}
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
 		if (!amd_iommu_pasid_supported())
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..11a0237174bb
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+
+#include "amd_iommu.h"
+#include "amd_iommu_types.h"
+
+static const struct iommu_domain_ops nested_domain_ops = {
+	.free = amd_iommu_domain_free,
+};
+
+static inline struct nested_domain *to_ndomain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct nested_domain, domain);
+}
+
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data)
+{
+	int ret;
+	struct iommu_hwpt_amd_guest gdte;
+	struct nested_domain *ndom;
+
+	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/*
+	 * Need to make sure size of struct iommu_hwpt_amd_guest and
+	 * struct dev_table_entry are the same since it will be copied
+	 * from one to the other later on.
+	 */
+	if (WARN_ON(sizeof(struct dev_table_entry) != sizeof(gdte)))
+		return ERR_PTR(-EINVAL);
+
+	ret = iommu_copy_struct_from_user(&gdte, user_data,
+					  IOMMU_HWPT_DATA_AMD_GUEST,
+					  dte);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
+	if (IS_ERR(ndom))
+		return ERR_PTR(-ENOMEM);
+
+	ndom->domain.ops = &nested_domain_ops;
+	ndom->domain.type = IOMMU_DOMAIN_NESTED;
+	memcpy(&ndom->guest_dte, &gdte, sizeof(struct dev_table_entry));
+
+	/* Due to possible aliasing issue use per-device nested domain ID */
+	ndom->id = amd_iommu_pdom_id_alloc();
+	if (ndom->id <= 0) {
+		ret = ndom->id;
+		goto out_err;
+	}
+
+	return &ndom->domain;
+out_err:
+	kfree(ndom);
+	return ERR_PTR(ret);
+}
-- 
2.34.1

