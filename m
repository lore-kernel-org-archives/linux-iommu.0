Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A115381A
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050049; cv=fail; b=YlNy+PuNlxW6v2gi9JRT2SmpG/CFDYgqwGIa3WI2lgUtgxQXKznjZK/95y3i7ViwFIUECFvD+wILJ2Z42mYD8JP2r9FjHeT+eFJlXy7YhQno+NqUAIX4zRCgDPnfda3tuhZD7RPvbxEFwfq1RXGiqURLSv/Hi+gASY/DMakUVxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050049; c=relaxed/simple;
	bh=F8HGiM2BZsXwjXR/oVNQWO1bDWUii5vtQPRNdrVgxsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyLbT4SW08Hps+FnDIScvnC/2MDH9l7ggzQbbRTMWBceaFKTwa9tf2Xw1yACUZgOQW0MdL/W5taUdOQnNhWNa28Sp5X1gw6oHichP6z/JGNrdZDqx49GmX38/6ZnGusojCAY9S33Fm1O3JrRemc1P7eT5XvrhgtAs1ctFVUVPKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKA+PQv5; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKA+PQv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEyNReC/ddelwLpCV5IBzWRJ4jZzRpG++E+OdldgTY3VT64GQlVZWfpS26Fv9GN+CJv9J0ozYwluvDAIF6X66xUcPYIJRkY14b3imC8Hfa3xi3ZCHUWCQpc9Mxh+nfyQF4OfQgLwuOEhDb+52PtuCYVNyQYzz3guBeOpCN19aSvBWEaNMaajuZb1snxXo4FdfpusMvpW8bzz+NlQKwql7dRolY3YXMYiFb70xxI31YXbihqmQ7lNc4xvqiDyNXlHujB5L9aGGzSiBJOSnCadvTC0WYPn+vFPcRtd1HQk9z/Ux6eBJ/fcLNY2pLzZorgPTx3dqMi3cixdpY0O+lIIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCZgoK1bn2KMuerXCNAOYm303S8r4R2UPvkPW7uI+KA=;
 b=m6HOGZGrM2rAwR2mab/SbBbfIUvbfx+CoE8b7ZBSTDbaqt4hIcG0fjQThn62Sm+NEY4ZaSEKmSn4Xb22JSB/oc8Y7Akfpkz0BPH5FNNFE7ebSd6G67QlQQktdL5VYsaUK2lXBK63lqOFFJBOgifNEl+kSMF1MjjHcTc5Tkk8ZbcWhf9s0YC10SUA5RqajMddlQgS7jzXrkVHmzWzhs8T5nIYxKePzArXc5YctMkPkH0g3olsJjb2JPEs3XlMlr/z5DhiKo/cETfqiBddupYQvS3+eRnOtLEdVgF5N7AusqZNflz4KIxp1WODk8MRZkTkjtDKCoMU7vPgtuoIXeTtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCZgoK1bn2KMuerXCNAOYm303S8r4R2UPvkPW7uI+KA=;
 b=EKA+PQv5O3fTZsk0RlS72O/kKbtqtS9WNPDoT/OfK6hHVMU851cJUqBwaszbWihXnCSqyHrRFNj7EwCUG8Sn3GHwGJ6lJ3kISCe8nr+w2dFAQn7yO3C4QzzkmcvMfrjy38R4yfl2MsE7PqDsxYbwiDUVAB9NNHjwIbrTnkpvDUs=
Received: from CH2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:610:60::14)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 10:20:41 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::36) by CH2PR14CA0004.outlook.office365.com
 (2603:10b6:610:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 10:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:20:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:20:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID capable domain
Date: Wed, 11 Sep 2024 10:19:06 +0000
Message-ID: <20240911101911.6269-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bad75d9-c9b6-4a51-e400-08dcd24b6352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHTZhYMVxvCkmHjeXssFSlSb8ClYnnfi8p88w+Ln/acVFR8xjVLgIvgxwQgG?=
 =?us-ascii?Q?pTe07Rus65JGNKyTTXXWUGLPnI2T5P4Z9FV8pxWBCGRYXrUn049ipJZYOE0R?=
 =?us-ascii?Q?tQR34R16LqRC3jklSvsji4sHHRfYegkyprTaTz4psdgW2JMpu66XsnSWZFTJ?=
 =?us-ascii?Q?90qiBCXhkXrEvUAzzKdWAE+jkHAFKix82mfat6y6sLJrj6GWcyCjUqKAh9Kh?=
 =?us-ascii?Q?wSssxZnW7d5ZRXGAS/DCsSc3WYKwYsnVSiy/MJEo24IE8jSzqeqIfEiou/tr?=
 =?us-ascii?Q?G5aIty8eNmGGGce2qdsb1C8YnossGI85Ckx7Nx2FHKZ/esWwW+YCVpZf0mw3?=
 =?us-ascii?Q?70x8zkiw/MldcxI3Dm4HUXTlCZfuBvs8JbTuMndvzF7vbprDpMDqLjohVRWJ?=
 =?us-ascii?Q?JgPsZFECRB5wBTe4c4Qlk1wgBXgtR6KrLJgAnSlLYDLyLjnEFYfVaA2E3lY4?=
 =?us-ascii?Q?2iTRI4TkJdhQ+GCCAQ6jZdEht4d4rpsmY+DnmcXS0LdJ67K6M6ELlcMTdJ/R?=
 =?us-ascii?Q?tnDiVYQRfBHmMfH5L1mQcW9WRY006IfTUyI9D7Hl+qxB0QmlzArKnkux56VI?=
 =?us-ascii?Q?8swbg4q7+EMtTdEaPlrXamZGlfWnllhYpFM2p8tElc00DFJ7Ysz1Zp0p5qUC?=
 =?us-ascii?Q?9ZDiHFoiMU6j8HxohEEPXKaKBvxqSabrJah74Q4za3j3uHx8csBrg2TFdi9y?=
 =?us-ascii?Q?0/aqQqgN6/ce800MrbWZy2SaRDjZCepDGQC/zvKmGFX4yNZJf+2+SHg6owt/?=
 =?us-ascii?Q?NxjJ7e+Nid8RJZyHvoTybFnFprTD4Vaynthbm9Ul6XhbhJVzyzKDyPkB/KQy?=
 =?us-ascii?Q?/lmbfecPQGxYwCIR98fWHuYqyujB7nSE8ZpdLFvJ991aEYOqR49CRZMWhdhs?=
 =?us-ascii?Q?OoFsnwnBH1gVvHWkanuEcV/0CZx+1/FRiVLN5T5RCKZ/heY/GIs5g9j8AFVL?=
 =?us-ascii?Q?TxrAxCc7p9JHBdVo5A7QITdn/Wa00eOM7qtsT1c7tma6neS3NMSEKVBpblsy?=
 =?us-ascii?Q?Hva3zWun8tDLbZUjuHHfUnH3Cay2VBvLiUw13laEM+TFDQ8nendaYlzP6Lkt?=
 =?us-ascii?Q?FqV08o/3YJkbl0K/58fqw11Cyp5gtF5bloflPmPLXWADCGLzQSa5CHtJD3GX?=
 =?us-ascii?Q?0BoqmiFhHUQubEUAiaQ7Wnb/IAjWYsW2U2ZcJQIN+g332t9gRvTzzC3TqDAN?=
 =?us-ascii?Q?zdRxKTyW82mmeJpRPkW/A1Xv5j3jIfy0t8BfsErPycdHQi7uvNUOjK3b2nmd?=
 =?us-ascii?Q?G4wBEUOKhzejKy0aQ0WKXyXV82a4M7OpdUdmTl7wRHEk2Ns0/XAQuR2DdxQL?=
 =?us-ascii?Q?6tXu6QS0YBXiP6i+PPm/6w3GpYrdFrgDbDgaarFcGCDIVRqszQaTWrN721z1?=
 =?us-ascii?Q?BlfdnVeKy5NCbcCcfaAPBWJ9CH5tODKKhi4CwDuX9TAeWtbqbmfeXaxD9v49?=
 =?us-ascii?Q?6fgPfAWpc7Z46f5e1rFGp8JF8qtKH6/9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:20:40.9274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bad75d9-c9b6-4a51-e400-08dcd24b6352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839

From: Jason Gunthorpe <jgg@ziepe.ca>

Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
If both IOMMU and device supports PASID it will allocate domain.
Otherwise return error.

Also modify __iommu_group_alloc_default_domain() to call
iommu_paging_domain_alloc_flags() with appropriate flag when allocating
paging domain.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Added __iommu_paging_domain_alloc_flags() and description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
 include/uapi/linux/iommufd.h |  6 +++++
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5d1cef36f633..f3f1244fe90a 100644
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
+				dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
+
 	return __iommu_group_domain_alloc(group, req_type);
 }
 
@@ -2026,16 +2041,9 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
-/**
- * iommu_paging_domain_alloc_flags() - Allocate a paging domain
- * @dev: device for which the domain is allocated
- * @flags: Bitmap of iommufd_hwpt_alloc_flags
- *
- * Allocate a paging domain which will be managed by a kernel driver. Return
- * allocated domain if successful, or a ERR pointer for failure.
- */
-struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
-						     unsigned int flags)
+static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
+						       unsigned int type,
+						       unsigned int flags)
 {
 	const struct iommu_ops *ops;
 	struct iommu_domain *domain;
@@ -2059,9 +2067,24 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
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
+ * allocated domain if successful, or a ERR pointer for failure.
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
index 4dde745cfb7e..4afcd3e2eac4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
  *                                   enforced on device attachment
  * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
  *                             valid.
+ * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
+ *                          domain can be attached to any PASID on the device.
+ *                          Any domain attached to the non-PASID part of the
+ *                          device must also be flaged, otherwise attaching a
+ *                          PASID will blocked.
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

