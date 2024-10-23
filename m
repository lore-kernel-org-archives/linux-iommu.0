Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD4136331
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680209; cv=fail; b=ca+nMgRFug27nFf981Av7d/5JoODmFoDYCPMVsnMQVhkfsDeRPxWZpgNvaLSyIX5OdZfc3WAglXcwwaD4uX4ELgkD+NxMmRwKE0kekExX+yM95kgxNoyxgBIl+t/g/GHH54jQFAzxyjTsM80r2sYnz0stFc6jQQmUsyu8wMbxwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680209; c=relaxed/simple;
	bh=ojUh0KwpPzzesoRuKL15uY2c3a2bNA85GM+K2LVBn/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlBQDSk7tjOjmyLOxKuif2rKergg6dEzQGq4eIyjAlSqHD0l1Ex1AhZH4nZT828Q28v8G3K3+G177mW2FmM6LnCLgIFnwEg7qGeKq50KhHIUAPGXH5AxGXEfwlZtHYihqMN3r0PpbfxKLaR6cliQEJg01s74G3smHmDcAxkYCRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dL0y+iBO; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dL0y+iBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf8XK2PDiWdzBQA/PiB+5rotZks0FVd1Ju4UdoSUNSIthY0wqFvvEoMDiqQbJu+OXOEA9QfZDFoXhDRPaRn20pwPvq+5KeSGbDfkj1XnfK+Sr5v9PfwFy5FZTLCVVavD3tVFeBLj4ExDKgB3XXBIVCeAGW1e3Kzd8uzF7Gv2ZWOLVDQbuAXixHOXkAVikOoUF31AyjCcv75KC7yBH42LTAN2fumEXQU7sDqlfp4t2m7UAgBYIw5sUqsN3mdgiPgicaW71X5svALv81FzV33Ss7V1AL0BLudwASzqCywDqKOR5B+knFUfJfbSMQFH+jmDUqGunrnGvIPrzZgtE+xMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C59HGP+TDGchQkqibEbR/X7fuTiZBIQpX+rj13cBHhw=;
 b=glmNsdZcert/e9HCb48W+TxlZuIJWJDkm3JVlByY1PYTr+5eSm2HfZOHGCVcFyjoQ6fb50MU0b/+ozFuaRmi53sjS7Hk885GOGeUrPQ7y1q/0AFD/crfNCC/OuskRC2KAtphopvF/31db0ikTrRCtPvwPS22YtEf+1dRwfggXizKVPHkshpgPwoYkoltpIM1IREAAwh3GvbstIEy4w0QR6Kexl+guL1qA5uvi+lUnLqOu+hTrMraO+F4macx6ywp5wSCnFCEFomFoAuQO+ApWFIiApfvzKtQyvKz4CDTRXBCrhQOqoiR1/IJh57kIw/jaOp19A2YJFMLKWcJIyEVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C59HGP+TDGchQkqibEbR/X7fuTiZBIQpX+rj13cBHhw=;
 b=dL0y+iBO++agouDyh3MkrUbhmxiDzhJCZ8QojRDyaPlKnGMo3WanypZ0ZslMqltkox3Fl6LsRAaj/1PaUBcooAg93URZKA4GJOvI+uQJJZImpOgk/BXhYi8IanM1NG8R1/Ox80GowoZTne0c4M3PZjzv8UIvUDzYBWK2hXW7Vj0=
Received: from BN9PR03CA0583.namprd03.prod.outlook.com (2603:10b6:408:10d::18)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 10:43:24 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::fa) by BN9PR03CA0583.outlook.office365.com
 (2603:10b6:408:10d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 10:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:43:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:43:20 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 03/12] iommu: Add new flag to explictly request PASID capable domain
Date: Wed, 23 Oct 2024 10:41:58 +0000
Message-ID: <20241023104207.5894-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c462d8-6ea4-4ac6-33ba-08dcf34f856c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7Lk6BhnYs0cDdIRKKD81yws7gV2vlAdWBTmh9WYuiyekPOKU3BUwytwhFNN?=
 =?us-ascii?Q?wAUO5CiCjnAnBq2FcDHP5EUPCJuLKnKB+uAUzN+KJBrLmXXNGgdqy1MJ+Uc8?=
 =?us-ascii?Q?2AWWSd/d4pxVMblPEQsTZFxxqLknqMnzAds26Ap8sToPQzuLB1hKlKtIWTNw?=
 =?us-ascii?Q?EOTFO9YjepAp0M0qlS0WzinSyQnyn+oIDe0kR0cnbfKd29iq7+gOjFh7rgjS?=
 =?us-ascii?Q?UNAQjZ6vtGI8REEMOj4MNzNDOtv8j131pv3QLNEnV8SKdO9jtujm0OfS4++V?=
 =?us-ascii?Q?9i3mzIfwkrV2kJekGn9BoQuYkopJt+e6nqLIyFwjkAgsROtwI1IRH+vNN/sZ?=
 =?us-ascii?Q?OfRozCBeO56uRnVpDem2IhqF8SOg7SP8UzAYRcZrrL4x+dz54NHgpYyBfqr8?=
 =?us-ascii?Q?ecQs4+rEEk5oYuTEJ1Sdp9Wmdf5KLFCpcAHrc58wgobaMJkS/zrWH4MmWHVx?=
 =?us-ascii?Q?Qu+qFC0uPRXVf/rbwT/Gx4lsK7raz31koec6G2aFn36yZDGCx6eS6zMEvZU+?=
 =?us-ascii?Q?93qkoRnR00AyBEVwmlKR2EK4pwNapCuAqlUIF6a8Da9jAe+HeppAyiKA4VzF?=
 =?us-ascii?Q?ZvXtDwIFGqSOp9czAIh4CvCsDUtLDj+Su4OCNY+AXf27CkYvCOn6igV2ZzVQ?=
 =?us-ascii?Q?nAVnjnLG0VxavMSxjq7HFTH5SZMU7n+C497y3LDaxL41MSwLZ81aiglXf1rz?=
 =?us-ascii?Q?TpHq27cX6OyVdxJ8EXlS0wj01TAX2dWoRGNr3KhN/DGj99KPjadXAh2vodbr?=
 =?us-ascii?Q?H15VCysWyAhrlY+BnKkO6C2fdHtvVHccq0lyNxeDdGry7HOGXNCEM5eVWhx6?=
 =?us-ascii?Q?KfVcbtXXUgY8IRsX7aBrR0q0GLc3uAqf6609iP8v+DOBt+gFqe3pAKj5P8cO?=
 =?us-ascii?Q?/XmtnlppAdBLhAWSG9lH/DmE4M+NNWhWyxPq0Fs1ntNMfeYI1Jp5gvo7IQ6I?=
 =?us-ascii?Q?te26l+nUlMSXAR0Xm/iwukHxa5D++uoB7LSu/+jJBEN7LKitiiViGkycRFXL?=
 =?us-ascii?Q?0c6MT9k+nBcZM4qUL8vRgQKttaKWvlSaAQmxng0ppaZeBSe00n0Pmq4AUKFK?=
 =?us-ascii?Q?X+pRnqUVwCMPwl73utEglUu9A9I++W/wpiBWKG+5auJDBBHbdNxeagqKPOq7?=
 =?us-ascii?Q?VzcC3blT0wUWOsvDd5kxUqWiXI1jkcm+aqAD/AOH/YiJbIbToNxxxtrfORf7?=
 =?us-ascii?Q?s7i7lZ5LyvDrzJT/1CIFjWCgy12vzbgk5fsXcZZtoINx69/P2lRKRTolMEdi?=
 =?us-ascii?Q?d9bTpCCJ9o3IkYDZxYGfSI56E+0Z9ILO/UTtjPFDgJ7j7tPqqWXUOC1u89G0?=
 =?us-ascii?Q?oQlklv5nWG2LNPdntbCKu414HfO0lwd15NOfMRzqKqK/Fx1mBrNsLKesne+t?=
 =?us-ascii?Q?IZeL95VRmZlDpWzVIchMyYjlKhxTY1+IJtYxHd4ijnAvwFGYUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:43:24.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c462d8-6ea4-4ac6-33ba-08dcf34f856c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

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

