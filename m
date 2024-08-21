Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AB1A7AEF
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247406; cv=fail; b=OzAbC8GBuL2/UufNq62Gb4oX4ombZrIp0+9kFc8MtTiIxbvim3pxJ6Dr1a99QW66izWqrTAAPhueqihd/jSV0PkzXqamrVyTIFTJTE5pLtq3D9O0rqmxlPThbEbHr3AEia7Et/fOLBOPKHSJJXmG/Cu8DRJNzelywdt3f2U9J/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247406; c=relaxed/simple;
	bh=lXq/+LRA7LsflEW6Gp7LRr/+xxxZ5hrmlq9dFrpj85w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQvkKwCJ7dPsUVNATFqoNBqzmpEFrGjbNdqEXYY+6lfynfgTjJAOTYGZTDgR/BEU3MHEzw2oUIy1DTYmt1qQir+kS8SVCjqtJUnVJxJH7zSh++6M5aCS77a31KeEkWln4gfcmBwvSviPJ1FKq7l9s6rqesDJPzsBnwbungFcNN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M9NVFRji; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M9NVFRji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaH7WWGVT5aZ0oxPz5alSDxrcvECrBjHkfgFOgQ9BCe7p/vyGX7gDiBvB3E5E3/D/7M4Q1VLhfryykZtXf0JweAzxLzcQC7DHlaOnkv+LGulK6pnkHdOp+yDLd6Gxvd1wmW7vpAyzTICc8QsZyx7rQSJ4Lrz+w3s5DrU8st00BFpPmxJ6uqtmeyL0lGgs9FMY4R4IXEH8x+n055cL4nATWzRcQMYCjfhUM1DVwvnyFAiEtkXcd6y2q0OmfiAHYQckZlYdxDA6070gJZaDzcO6BBnHNtJvl5A0SVeba2ihl79+LCKlcNdi9PE97+o6QKl3masGr6sL9X5bjsbUGD/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lgVbAjBU8VY+ASGv0RaXkyaivnvzrn2rMpg6sbZbLE=;
 b=SWQaaGBvZ3Y8euu+tKkOmYxY7hCjeR/S4QsXS94zD12E9X1/61OrN3OAhOTNCw1naR8iejS+/nCKOJ3Y9hT4AW/nt8+b2gyXwqU1Yk9mNqEI9YsXDtYd6+36W0hs+p6CdkMxHOgzqmmThOdh8qFr5bb+wlPmhgw1TWg3XlPDM9l7OPPSVwpLJUcNiRweDf07KuxfP/8CQDYOcqjy9olLqc3UmeTy0Z7L/MaJ/3XuAu78GUrl1c75+6C2aiFKD8wauUCOUbcRBQD0PRHiPmE8m9hFIru1PlCV801veu7AsHg0Zg/wxZKkZ35vWIXpb0NDsXXnBJcXn3tR+hokZIUfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lgVbAjBU8VY+ASGv0RaXkyaivnvzrn2rMpg6sbZbLE=;
 b=M9NVFRji0oqsc0QhNF7TA+YmDm5IAzcz+L/Hysi4hvbIuyNCy9yj3Icdf/oAJIBID5pMwTXBmBp2jYQj3jX8HUHchfRJ04KXZN8gXYyO8mBOkC02XSV6JcDYz6a9VL+ZCf0BarcQ/cV1VuR61nsWazknGbdEHZ3lt/t8VGr51Tk=
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:36:39 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::e2) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 1/5] iommu: Enhance domain allocation code to take additional flags
Date: Wed, 21 Aug 2024 13:35:50 +0000
Message-ID: <20240821133554.7405-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821133554.7405-1-vasant.hegde@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0fca70-3cb6-4fb8-9f3e-08dcc1e64907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evtiTTwyhQkbWQI/KP7RAsSls05kXXevR+Na3eycuh7IyCgFjCtU79MKHnkB?=
 =?us-ascii?Q?NnB3gpMD/851dJGPMzwack6ZgmQHJOXCna5ixG0gzNg5omQa0X1Z+Vvb3g3E?=
 =?us-ascii?Q?WSGX9e4N9xdOq3azFCd2A6muWq/PHiIIcZKbxEkliR2l8UEyRuh2pJwjKDfB?=
 =?us-ascii?Q?CAi8l0x1DMgDyXmwGOrq3ern2KY58mSDOilcWefaVFN1NMWZLPo5LtuC9+DM?=
 =?us-ascii?Q?0raOWo4wfa4apTVsFJF78bD6189983F4+Eh+EUYimmwvdiPLoqgRw9oEnov4?=
 =?us-ascii?Q?oMqBe3XFlzu72CeCUTI3XjKv1+BK6GKZlPTbHlZ2BNLeUWYU1HXEcsLxVtor?=
 =?us-ascii?Q?j+VkM13+Vzh/5LQlae/nskBawYpadjxKL06O7KFlKj7985CwEJDK5HWCjHa9?=
 =?us-ascii?Q?O4rtNfmmOG2673/8+QzErhEC16Rpsrt9pWw/oyEUqI2UTbOMKqodViSn63R8?=
 =?us-ascii?Q?hUr0pFo7zaOPcOBe682A8ciU1WQ3cNA+Dpn7q1GTgzVXJErBVpLqjwHud4md?=
 =?us-ascii?Q?9RgmgskVK/bFZHz0C/vo2av6BJEsPCNip3kS6gpl+31G53CHUCu6I+rFRXat?=
 =?us-ascii?Q?D0EhrzEi6mGe889vtjDrdDDfYov9VCFhjcKM0N888EBCJCIr2kVGV2RLQ/sL?=
 =?us-ascii?Q?WNa0NpgyKb+43E5sltCQkb9lHMRCps4iXngxXZN0GyaurWqiir04+VFep0m5?=
 =?us-ascii?Q?y+U//XHULoarzh1rdw2UPWFeAF0rKdNUWYfMnM90Oaeu4Ta61BjuzCaDoBE3?=
 =?us-ascii?Q?iYxIEYvA9wZy/LkFxsg+dVDLxWkr0HTDVqTnJr3+BfZbUYBAVR9aj5g7Snwc?=
 =?us-ascii?Q?32ZSOD1hjlqZsndkqEGeo8dejU8VA+yqb1UIC/BpbOIaeFJoWcKRndCN2DVp?=
 =?us-ascii?Q?aFDKuRy99KvyoXzVXroj5h0G2q70SfjO8g2SG05kXVTgw+u6MP21lZClTVxs?=
 =?us-ascii?Q?xMGI57t9MQRyuK1vNVPCaznl3vUWb7kcRq9hijuq2fTmPiv/gZUFZyP4iZ0O?=
 =?us-ascii?Q?gtL8VqZ0Kl5aTlzFhEakIpNfif9jDCFlET3ZP1vFs9inFpaUw7iPEyHsMNWm?=
 =?us-ascii?Q?HDQHeZeof+L7HDq9v8zlwxahlhFLUBUQK0AyZ0wHYtFNqjvJ1tPb5E2Z5fyL?=
 =?us-ascii?Q?q+8m3lmm2wP0Bl++P4neY3gsCDwLaHaRXyYzWnLgZkNctk8++O8P1Jt5PB6H?=
 =?us-ascii?Q?cwNJcFmm0wkS/VPzBRJwaJvyCwqQLWoa8kH6LR6Pc+HbWoUmQTg/jzvqaQKx?=
 =?us-ascii?Q?wErocPmQwlmbCEdz5T6lfV7hBwV9reXEqQup3nhCIQD33R+1ZbThoeIqUbPc?=
 =?us-ascii?Q?yCpjIK4ntFiB+2PEJxR/btg39zvzaO0yj982Kv3Cx79HSYeGiPsDASMpOkpF?=
 =?us-ascii?Q?NaVUzPxsaxm0Um65UN7/S1kmowkRCGxZmi93ZXlQrQvRjWCO/CA16gJ4vj9v?=
 =?us-ascii?Q?VWaITOKFUn4f9Nhck1BPVUf6Kt3DNLpC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:39.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0fca70-3cb6-4fb8-9f3e-08dcc1e64907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

From: Jason Gunthorpe <jgg@ziepe.ca>

Currently drivers calls iommu_paging_domain_alloc(dev) to get an
UNAMANAGED domain. This is not sufficient to support PASID with
UNAMANAGED domain as some HW like AMD requires certain page table type
to support PASIDs.

Also domain_alloc_paging() passes device as param for domain
allocation. This is not sufficient for AMD driver to decide the right
page table.

Hence add iommu_paging_domain_alloc_flags() API which takes flags as
parameter. Also update default domain allocation path to use this new
API whenever device is PASID capable. HW driver should implement
domain_alloc_user() to allocate PASID capable domain.

Finally introduce new flag (IOMMUFD_HWPT_ALLOC_PASID) to
domain_alloc_users() ops. If both IOMMU and device supports PASID it
will allocate domain. Otherwise return error.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Added __iommu_paging_domain_alloc_flags() and description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
@Jason,
  Notice that I have added __iommu_paging_domain_alloc_flags() so that
  it can call iommu_domain_init() with appropriate domain type.
  I think instead of having separate function it may be better to
  enhance __iommu_domain_alloc() such that:
    - Keep below changes from this patch
      - iommu_domain_init()
      - iommu_get_dma_cookie call inside iommu_setup_default_domain()
    - modify __iommu_domain_alloc() to additional param (flags)
    - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()

  Does above flow looks good?

-Vasant


 drivers/iommu/iommu.c        | 103 +++++++++++++++++++++++++----------
 include/linux/iommu.h        |  16 +++++-
 include/uapi/linux/iommufd.h |   6 ++
 3 files changed, 94 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..abf537c605d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 #include <linux/msi.h>
+#include <uapi/linux/iommufd.h>
 
 #include "dma-iommu.h"
 #include "iommu-priv.h"
@@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
+static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
+						       unsigned int type,
+						       unsigned int flags);
 
 enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
@@ -1589,8 +1593,19 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 static struct iommu_domain *
 __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
+	struct device *dev = iommu_group_first_dev(group);
+
 	if (group->default_domain && group->default_domain->type == req_type)
 		return group->default_domain;
+
+	/*
+	 * When allocating the DMA API domain assume that the driver is going to
+	 * use PASID and make sure the RID's domain is PASID compatible.
+	 */
+	if (req_type & __IOMMU_DOMAIN_PAGING)
+		return __iommu_paging_domain_alloc_flags(dev, req_type,
+				dev->iommu->max_pasids ? IOMMUFD_HWPT_ALLOC_PASID : 0);
+
 	return __iommu_group_domain_alloc(group, req_type);
 }
 
@@ -1934,6 +1949,22 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops)
+{
+	domain->type = type;
+	domain->owner = ops;
+	if (!domain->ops)
+		domain->ops = ops->default_domain_ops;
+
+	/*
+	 * If not already set, assume all sizes by default; the driver
+	 * may override this later
+	 */
+	if (!domain->pgsize_bitmap)
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
+}
+
 static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 						 struct device *dev,
 						 unsigned int type)
@@ -1962,27 +1993,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->type = type;
-	domain->owner = ops;
-	/*
-	 * If not already set, assume all sizes by default; the driver
-	 * may override this later
-	 */
-	if (!domain->pgsize_bitmap)
-		domain->pgsize_bitmap = ops->pgsize_bitmap;
-
-	if (!domain->ops)
-		domain->ops = ops->default_domain_ops;
-
-	if (iommu_is_dma_domain(domain)) {
-		int rc;
-
-		rc = iommu_get_dma_cookie(domain);
-		if (rc) {
-			iommu_domain_free(domain);
-			return ERR_PTR(rc);
-		}
-	}
+	iommu_domain_init(domain, type, ops);
 	return domain;
 }
 
@@ -2030,21 +2041,49 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
+static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
+						       unsigned int type,
+						       unsigned int flags)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	if (!dev_has_iommu(dev))
+		return ERR_PTR(-ENODEV);
+
+	if (ops->domain_alloc_paging && !flags)
+		domain = ops->domain_alloc_paging(dev);
+	else if (ops->domain_alloc_user)
+		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+	else if (ops->domain_alloc && !flags)
+		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	else
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (IS_ERR(domain))
+		return domain;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	iommu_domain_init(domain, type, ops);
+	return domain;
+}
+
 /**
- * iommu_paging_domain_alloc() - Allocate a paging domain
+ * iommu_paging_domain_alloc_flags() - Allocate a paging domain
  * @dev: device for which the domain is allocated
+ * @flags: Bitmap of iommufd_hwpt_alloc_flags
  *
  * Allocate a paging domain which will be managed by a kernel driver. Return
  * allocated domain if successful, or a ERR pointer for failure.
  */
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+						     unsigned int flags)
 {
-	if (!dev_has_iommu(dev))
-		return ERR_PTR(-ENODEV);
-
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
+	return __iommu_paging_domain_alloc_flags(dev,
+					 IOMMU_DOMAIN_UNMANAGED, flags);
 }
-EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
+EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
@@ -2965,6 +3004,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	if (group->default_domain == dom)
 		return 0;
 
+	if (iommu_is_dma_domain(dom)) {
+		ret = iommu_get_dma_cookie(dom);
+		if (ret) {
+			iommu_domain_free(dom);
+			return ret;
+		}
+	}
+
 	/*
 	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
 	 * mapped before their device is attached, in order to guarantee
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04cbdae0052e..ca1813b2fa64 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -511,8 +511,8 @@ static inline int __iommu_copy_struct_from_user_array(
  *                the caller iommu_domain_alloc() returns.
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters as defined in include/uapi/linux/iommufd.h.
- *                     Unlike @domain_alloc, it is called only by IOMMUFD and
- *                     must fully initialize the new domain before return.
+ *                     Unlike @domain_alloc, it must fully initialize the new
+ *                     domain before return.
  *                     Upon success, if the @user_data is valid and the @parent
  *                     points to a kernel-managed domain, the new domain must be
  *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
@@ -789,7 +789,11 @@ extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev, unsigned int flags);
+static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	return iommu_paging_domain_alloc_flags(dev, 0);
+}
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1096,6 +1100,12 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
 	return NULL;
 }
 
+struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+							    unsigned int flags)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4dde745cfb7e..eba07ddb141e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
  *                                   enforced on device attachment
  * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
  *                             valid.
+ * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
+ *                            PASID, the device will support later attaching
+ *                            a PASID as well. Some HW requires a specific
+ *                            domain format on the device to allow PASID to
+ *                            work.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
 	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
+	IOMMUFD_HWPT_ALLOC_PASID = 1 << 3,
 };
 
 /**
-- 
2.31.1

