Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDB1DDA39
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173785; cv=fail; b=PEiUcf4ym4mJgRXwtMkqKdgUD7XV2LFtUAfiJ0PFa/rmLPnmMGIeXRT89FgStw6fHdFUynpaeM8V39BW8QIZbU/cW/UXdzEpXBJ8NtsK4CuAZe83jh4L6GJPQoDTbO/pDkRGrEl7UubuAn+44xt98j9EkJTArsYoR01eNmj4V38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173785; c=relaxed/simple;
	bh=XAH0IGka6mrBbewYKztqMXNSqQojKNSpoG0sUN5jO9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnpA0t91BKnKlraWxW0JAuQS3WKSwSvUgNM7nn6m5wt4SFoh1v8VnZfx8SUDOoBqDMp5NCJPHKYkYqw4P6/ThMQz6J8P6yZYKcIkEDkVdwTQrm5HSD3Rv1cMZoqg9odXi+LICntpToLeve75Tb7gXl2GkvS281MpNA/DCRznFd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nTF9AT0Z; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nTF9AT0Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz+UQR0QQYK25H0dntCKukqSAVtxNGz2vhvz1/Od6sLT91y97/tZEvk5fPtnReka43ZwJS18FBZAWokiAvllTXYFuLcnRM+XyshPJbAd09ktS94CBZH8IojAjCtEB9m5Fmk9h6tAJYiB5dMOlAkHD61x5X51ZnCOP93wWCeM/WLVrGmKRABNalaMCxTXxSlQz2sWijky4gj3wuBHOstiM1BryoFrdaYoAw3Sj9nfd1qkl/JeGEFP2YeRvAG6U/DVXQwwFLNST5swFA/iSLTcdXPC2SN0la9Euq9PUpiALuTvXIBfHKzPuAEKWwEqLCCn5TleKgl5huMFJkTbV8rTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxnGwP02EC//LQ6DT14CuiMM7sQvdbtP2g25XoPX1VE=;
 b=tGKoFnhBR8MqSltEH0RADuTXlKAQM62+rr9OviMcjxwfSPAMxm7gkncgRQROqY39f+QIgug5e4CUSerFkxyuWMgI5J7hN6SpWlg2XIYvMz4FIdnrA5vkJYpjCIPpzgmH+aspwDtEGLa8361DKS/zjMdIfpFsYWmPSdhK3kM3azdAnH2lVMdkB9Fl09qisCWES3EzHuOcJR3bWP3c5lQl1wwXk858fHaMTobME1o/iQZbBBCTaezyqTfOKiqeSCUhoTF2ONyvDEbSS01tH5AwDZIYoWSaV9aLCZ0kQEwgNXSp5F4b4ubrMTMeukT/CoMsC9IMPkvm1nmRGFe0em83UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxnGwP02EC//LQ6DT14CuiMM7sQvdbtP2g25XoPX1VE=;
 b=nTF9AT0ZrSgIDtowFhODu1LmO+b3h4fE07Q0msHxE/cphF6yJjXht0pYTAwvMuThXB2p5eEtokQq1eC80hQ5SqvUHe8WVgx3n4YY6lHWx8Q/MXAJAEeIyO65wwkthTCJgXtfu9QxSLJWM3mKbVmjXtyZbIYN6dUedikbS4+ZM7Y=
Received: from CH0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:610:119::25)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 14:02:55 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::25) by CH0PR03CA0375.outlook.office365.com
 (2603:10b6:610:119::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 14:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:02:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:02:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID capable domain
Date: Thu, 17 Oct 2024 14:01:28 +0000
Message-ID: <20241017140137.6028-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: d195badf-2423-4b9e-5ee1-08dceeb465bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MQNuBKzgGhRi+xkPN9XYaQ30p9gPQoq9SA4Hy8KJvXdo0FplSLEP1HmiM7em?=
 =?us-ascii?Q?hkKDWzgDkWobpalsOhD/x7xsykUVF3qPOVW8XbJi6AXS0dbpgdhyUBBDkZ47?=
 =?us-ascii?Q?WivMMuPycqp3BHUI6srWWEgNf8YVcwjYtF6MD1WJysxuJVO9NqkepXWQIvtH?=
 =?us-ascii?Q?/xhmcOmplYvB/bBIbydqUNUtmflpogAtloLohpF3h+VvI0RMZVqOI9Rx9JTj?=
 =?us-ascii?Q?n/svUGYCkQkr8dYwVX1KHhZPFp/Y0NQBRWw2D4WBnQky+M76FHsb80qdSCPH?=
 =?us-ascii?Q?KTPldTrAcC/MyRw8tFxjvgNaa/31eVF5ossd8Kg+1WvKJdsvroD9UoQ+41PO?=
 =?us-ascii?Q?9C4yFAgJkPt0Jsm+TTcZvchv9bIbIjsU4AiD7ZhiGAxSW/34VwxGu7pSzaFh?=
 =?us-ascii?Q?I67OP5jmJShYscKu1v+QS1ymogd3ZqYuvKHeR2+3Zmz6gyy6VajFaVZPakgU?=
 =?us-ascii?Q?EoamebgUMfTBjggW8kmi1AImi3NmTto0WAp7J1u9ahFQOx38uVoYrwZZBAm5?=
 =?us-ascii?Q?VUxfyRDRnZWih1loCtHiTLVUvioWp5RtcuDxV9u9ppdh/F+kKyFwQQhPORZA?=
 =?us-ascii?Q?9+Qnc9bXqa737X6pG8LGKJVHIjBCPrN2zOauyWsEHAQycgezXSdVDlpdZ7GA?=
 =?us-ascii?Q?LtLubPPRorvedIW0qdw71mYDn8+NlOlAiLm6mBGFf3BDttAR9dH5jeZBwwxk?=
 =?us-ascii?Q?P7oZ2ufcv4BD77g7YFYFsxaK0wU1Ryf3IG10h6N9vVe2aaKCOoF33PfPhVIs?=
 =?us-ascii?Q?kXN8ZzMh+eoCZWkUz4lmg3nR9ndjPXmuyNtnwdgFoVE4f9egnwo2u1HNCVdk?=
 =?us-ascii?Q?PFtAE3gTU0u+1SQes7FEHk2LD97ucMEJLjRVpVVmwklbu68HOukkKd4xnbV+?=
 =?us-ascii?Q?N6yGclGhHGlU4N50Ti3/5i8gVjVJEVB6eZIxWFO4+vv5DOcF7Mml5h/KjSR4?=
 =?us-ascii?Q?1Z7cuUAiUuIJAEsogl3vPKQ+f+bVKjnhMsX5DbZS4CMKzcuhnsImi0vvDcx7?=
 =?us-ascii?Q?lKFh0dF57W5PfQXa2STID7SxgeeR5sVSmH2IELZkz9CcCJTSq25Q6wupjGmL?=
 =?us-ascii?Q?6sjqpAmhss5uhlKl/5Dsc4NHUSdFGObXe361WXqCwxUUQyo/8qq3VXqX00Gk?=
 =?us-ascii?Q?CXMWUKBkiGW+HvZQ+flsN90Eb1tDdSmewHGiXHcyz2edrx3ONzL9gKGjyzgT?=
 =?us-ascii?Q?wULE1fF2O4CXqDJMeBEBaPhF2Q4xNHdejQSB/RuE07GB9oJScDJg1YMFWkxH?=
 =?us-ascii?Q?DJqkibRVNq5eyz3upRFC1X/+wa9QfByl+zUDgwUtvjbi2eQfZDYqqrNr3HVw?=
 =?us-ascii?Q?f+nh1IQ4X1tIGB0nU/1Wuu/rNw9UptApQ8yOR9jOhDatBvTyImRK314gXZBd?=
 =?us-ascii?Q?iJe/u6jDppaAmS0qMJBIM+t9HYl6hFYFBb+0qhIJHsKy2vqgsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:02:54.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d195badf-2423-4b9e-5ee1-08dceeb465bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
 include/uapi/linux/iommufd.h |  6 +++++
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e13d64ffd14f..107016b3ba3d 100644
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
index 72010f71c5e4..d1b07f4d9d32 100644
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

