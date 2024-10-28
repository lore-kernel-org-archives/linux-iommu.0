Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8855161320
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108375; cv=fail; b=jf2UBJ5s7p+7Mr9gTyl8Wq25Bgla9lGu/5YfCKfNVuM0w79gJSAqc8a2DBkHwbTSIld+/Lhp3mNL0dO8bKWJNIOm+XBUWzwu8FkA2GI09p72o6VlG5HJw7fSDM7UmD5gjQznq3KrJEZlrvSTmXDsVAgd7JtTvo010MiPiaAicNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108375; c=relaxed/simple;
	bh=UxjXFKWJaPCt7YfekZO+nizCYTIjxSb/vJnLl+oLSrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CguFzd3hut3PPzVdYUC4GumJ3MzhEsq9eCv/maof1ekJueSfPh6pgR5ACt4t5IZ48ZF7k2vkOExjRzH2G8Yz9Vdad5RQXnf3mnVARvkLxrbyDGGxel9rFDL/18T/yD1OODtRA6NWKm8sC45T/rwAUyAdU5PTomNpbLJKD5996hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rsVSdrqM; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rsVSdrqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laRDRNVEisAOJaP+7Ltt3oXnR6VyNdZdEIz0eWppJSdtQq/v3GuFgQPjdLco+ibmcefFo/4A5wX+17Cfjt6uW2xWjIvQxTqJCp+VeSqryLPTJ3dHYo34YKR2gUaqSlTMn2qtgDGOVv5rAsGAmlnO90+j2xBYI+YPaYxuBOFdSHIBaRgE1ro+KhgktK5kXnpEbEIoH/e1UMkYxYUiKccRHFjec9hn05Zt0ozmkuargFNMtxfyfMm7dkxIkW8Ar444iVYX8NAR75atBB4Qa6pbgjMHH8kAAjYH+UvHxQEBblSaO+xiePgUpsd3vTOFppczKQMivhPv3GDRFjMKGVqdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9G6nzkDGap1cYy2eyFjAucDQrHVt8JOoQu7j7J5CHU=;
 b=P9v3a/f7nZOK8e1YjoG7Jj90pwG86XXea8b6k4YGx5ZTuK0oEiMI485/hvg4kDzXnh0M6T5yNJjQbv9nZxV6WsqpbZCerZq1yWQXjMX+T7y0hc+n09NtWuOZHpdyDUtARAuYZx7Gvxf4Lnm0R6+NXsNOiPY2PDPGdwBpM+XUCLLWEsEHA/jxaRTZ1A8aQr61pVoHY5bnfT6NOouyc91gNYL1TLgX+0IVX1EnuwAXvNSBP4l/Ahw2XQHXA0aJ12ikB6MuMF8zbTyQz8yGrDIz6Dfpdg6YevrtDk2UHnHWGt2yt/cXPiaTcUmZOZqstsyqO3Sf60JVmB5ug7DoHyWdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9G6nzkDGap1cYy2eyFjAucDQrHVt8JOoQu7j7J5CHU=;
 b=rsVSdrqMoahhPHu3SljDlgsJq91AG6/3bLS4xMyjquYsVZk+rsspzErE5MCjLOa+wJ9GWQyBhFouOq+Ihd1tQUm0vYVEkyKU9mDMvlgeUvwFLy0dYOtUHO+fEB4wa+ny64gFAtFHhzFg2cqj510cZpWp6tIKGuYlGZVMUdhfVoE=
Received: from BYAPR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:e0::35)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 09:39:27 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::e4) by BYAPR05CA0094.outlook.office365.com
 (2603:10b6:a03:e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.9 via Frontend
 Transport; Mon, 28 Oct 2024 09:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 09:39:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:39:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 03/12] iommu: Add new flag to explictly request PASID capable domain
Date: Mon, 28 Oct 2024 09:38:01 +0000
Message-ID: <20241028093810.5901-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: daf5e8a5-7f12-4343-c5a5-08dcf73469fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b0r4LlIiUAPqkBzdSKkonI4aWPFzGQTRTMaHLtncM6w1x7d2Iq43tp1G/50d?=
 =?us-ascii?Q?IHqfw4Vp5q8H2cvklmvdrO8fFRMEI1Bkjo9fT8vYorwUXx/ffv9ZQFJAUiIm?=
 =?us-ascii?Q?STILB8d5KLYbn1lUz03hT3gqLZvIp7wWM5dCOp4S//+adYIBc3Ha6ZG+SUOX?=
 =?us-ascii?Q?aE6tjQnSnqs3QJ0oHysN6rNqqwCgrGXxbm7+MIBAvAVHQk4Op2/r7bIEgbxq?=
 =?us-ascii?Q?dTBMJMjKMGgYcSDDmPdPvGXTDIKCZALuA1kdXh9ivuA2bJPGcfGLkokvJw7Z?=
 =?us-ascii?Q?gfkhLx5YpqudPnZh2SCfGhzMcSE/mDIWybSY+a2NKm8lg5ZIvChX9y48GAYp?=
 =?us-ascii?Q?AIejNGqa+j5lWduwZ3DOwggEaE7m1b3TkhwQ8AcYBMYdjGtF9VpUBqHaNzg+?=
 =?us-ascii?Q?nNCeUY+CBTood/AN+oCYiFVAQ9a7pwD2rzYEDK5faY0TQlyNDhFCof3vLaBF?=
 =?us-ascii?Q?pYoRpLheIUkSAPcKC6A4izTmueHwK9MeBCOPt2HQPrjLeaqG2UOoxrGR3rfB?=
 =?us-ascii?Q?MQyFBqJFkizMOSR7nkrHVXGy/LfV9SolrJOgk7gA9bpxeVRg/xbIXetRvW8c?=
 =?us-ascii?Q?/7HxXv8a68KQEX8TTffy+PcTnOOmpGC+ov8bipG2ZVkPk8v0S2Anj5PCDFhS?=
 =?us-ascii?Q?wQj9Uoh2YQnZvJVkTrDkJXhuNaa4Tx93LSV9MwAmfwAGgnANpXA+zlVh2B6o?=
 =?us-ascii?Q?qOYovVNKRpJoulRB8JCNUPUcJo+WXwTFliEdcNPnpOGs4yoI5e9a/yCDbwIs?=
 =?us-ascii?Q?8jGtlH74yoSfEAoYCqlTW3dwp2IBrDA0CNzfPhWv+Ku1RyDlPeQq2T2WzK0d?=
 =?us-ascii?Q?AfwjcJAY2mTSvf3o9nQKeFQh0tZhhugv/QoxBa0c+2JpdTcDS7mfGeOAEBUX?=
 =?us-ascii?Q?SzCrCplx2SFpZJhyFPARTpRLMQpsOazAfcebWs5dghrGf+HDXoaID4U4GlXg?=
 =?us-ascii?Q?cdlYfbqjDOesPuiQbQ9ri2o+Ucmz/EqEPnenTakmkFIOGsKymPhvtb1F3IG4?=
 =?us-ascii?Q?oNrkkCbGJVsiccRPyhUhoT1gD8V3shogaqlQY8bO0s7ycbB+IZasFzi/JZ6w?=
 =?us-ascii?Q?sHhOGYb6v0UKIRv0Ml4tJ1+vBZL6N/KSX7kC8qto+V8picLogyuolwHyjEJY?=
 =?us-ascii?Q?QbTcAJ85Y1Z5tjtlyP094c/tuM4FyKtrtYvhTWetUsOW/5hmg0Gv3B1zaSR9?=
 =?us-ascii?Q?+7Lzs+md+PH0srplfHVWASZB0y26wfCAgZNEB0fWAP0mZiquygNG5j46r2EF?=
 =?us-ascii?Q?uQhsIrZoaX5uNRhXApPfC87xIoFGKyDNvuRL0XTmLs9kgtrdxExwmEePI3iG?=
 =?us-ascii?Q?40oZFFyNq2QoWABVeFZwttgG+Mh+2aGa+dvF1Nt7TuuR8xfP1FIk6zsdVoqA?=
 =?us-ascii?Q?fh6SiNmvbGHcjvziK32uQjln59b/d4Tb6Ns9LVJrpdLFh+aGpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:39:26.6673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf5e8a5-7f12-4343-c5a5-08dcf73469fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

From: Jason Gunthorpe <jgg@ziepe.ca>

Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
If IOMMU supports PASID it will allocate domain. Otherwise return error.
In error path check for -EOPNOTSUPP and try to allocate non-PASID
domain so that DMA-API mode work fine for drivers which does not support
PASID as well.

Also modify __iommu_group_alloc_default_domain() to call
iommu_paging_domain_alloc_flags() with appropriate flag when allocating
paging domain.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu.c        | 56 +++++++++++++++++++++++++++++-------
 include/uapi/linux/iommufd.h |  8 ++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69fc0b9ba31a..a7286c406170 100644
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
@@ -1589,8 +1593,30 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 static struct iommu_domain *
 __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
+	struct device *dev = iommu_group_first_dev(group);
+	struct iommu_domain *dom;
+
 	if (group->default_domain && group->default_domain->type == req_type)
 		return group->default_domain;
+
+	/*
+	 * When allocating the DMA API domain assume that the driver is going to
+	 * use PASID and make sure the RID's domain is PASID compatible.
+	 */
+	if (req_type & __IOMMU_DOMAIN_PAGING) {
+		dom = __iommu_paging_domain_alloc_flags(dev, req_type,
+			   dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
+
+		/*
+		 * If driver does not support PASID feature then
+		 * try to allocate non-PASID domain
+		 */
+		if (PTR_ERR(dom) == -EOPNOTSUPP)
+			dom = __iommu_paging_domain_alloc_flags(dev, req_type, 0);
+
+		return dom;
+	}
+
 	return __iommu_group_domain_alloc(group, req_type);
 }
 
@@ -2026,16 +2052,9 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
-/**
- * iommu_paging_domain_alloc_flags() - Allocate a paging domain
- * @dev: device for which the domain is allocated
- * @flags: Enum of iommufd_hwpt_alloc_flags
- *
- * Allocate a paging domain which will be managed by a kernel driver. Return
- * allocated domain if successful, or an ERR pointer for failure.
- */
-struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
-						     unsigned int flags)
+static struct iommu_domain *
+__iommu_paging_domain_alloc_flags(struct device *dev, unsigned int type,
+				  unsigned int flags)
 {
 	const struct iommu_ops *ops;
 	struct iommu_domain *domain;
@@ -2059,9 +2078,24 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
+	iommu_domain_init(domain, type, ops);
 	return domain;
 }
+
+/**
+ * iommu_paging_domain_alloc_flags() - Allocate a paging domain
+ * @dev: device for which the domain is allocated
+ * @flags: Bitmap of iommufd_hwpt_alloc_flags
+ *
+ * Allocate a paging domain which will be managed by a kernel driver. Return
+ * allocated domain if successful, or an ERR pointer for failure.
+ */
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+						     unsigned int flags)
+{
+	return __iommu_paging_domain_alloc_flags(dev,
+					 IOMMU_DOMAIN_UNMANAGED, flags);
+}
 EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 72010f71c5e4..0c0ed28ee113 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -359,11 +359,19 @@ struct iommu_vfio_ioas {
  *                                   enforced on device attachment
  * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
  *                             valid.
+ * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
+ *                          domain can be attached to any PASID on the device.
+ *                          Any domain attached to the non-PASID part of the
+ *                          device must also be flaged, otherwise attaching a
+ *                          PASID will blocked.
+ *                          If IOMMU does not support PASID it will return
+ *                          error (-EOPNOTSUPP).
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
 	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
+	IOMMU_HWPT_ALLOC_PASID = 1 << 3,
 };
 
 /**
-- 
2.31.1

