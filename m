Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EF161320
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108357; cv=fail; b=KoC/YZfjpP1zfFBmDKOLhIXP/YuQ9TI7yrWUT+xEK2VnRBeGh7JiE6R1U7nxIuGqVFNgecELz1a2Jo+TwuirjxENR49v0YcjJvLH7TsWB5cg1At8FkralH+nvEJRKha4+0ypZb3zCXMOf7JNPR035rNQ45EXqFFioaKIqlVbc68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108357; c=relaxed/simple;
	bh=0cVP4L7j29cAi8VHPqkxfqR2uc8C4oE9Undn8tJMmcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt1UlSV89mXGh2jLTcLTUP9HhyT9qcS6/2LRykabCBzD8aa7eKZnrnBh8hMNn1UzkWgi/3YAva/B4pm6Y/fkvkVy546G6RN6j2oy6S2Y61V7fxS18bqXIxVYJQBAdYxrdmjdyG/IWBHXquaAFTB3Jw9/5/Xf8k7l9DoCZ5SKneg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3wocNGT7; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3wocNGT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5BJMJ5ZT7KmkJvxeGf6hHny5j3tv3R+NQhs2Hq6tUUIROValR6+qEAjcLisMVHf5GibPVUWVdPHCSNnMeXNP6km76/fXc2wiSGqJRJXMQ+zRGSmNiFf0xfS8ywkquWX4uwQI0SGNpYfiCtpw9pYDaCTse6x3oc/4XvMKyVXnjFAZhN6JxgwiSmrKBwmmVqh5lnkzGMBRcawZXnKdoH2RrpRz8ifgZQTe08p/MfjX+gz7SjNs3d9Xj1YIXEKBtwcVksybCJz3hCZmod7FFUGx/CEANyaT5iGoX0wV2j1wnndtpd+7lbie4xWJRfQOeFIhQsZNdWaWxTENjShEJkCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaCsI7x5kGFx15p51L5uxMkRzWRQame815v+T2MGKrw=;
 b=qdZUhELzn75OLSr9wkjGAtL86OyD8jSrSc7i/q74gCWuYgH7S5xSY35U5u+fEX+GtPwmhZf0dbgWmPIRy3OiiWw4mzGHxsPgVFDRf8F4WCL7kbfeKcOxB9RPvPAtJIghU5jN1/AI01gdDXqsht9Mj+b5aq8MUzQSlSNxGKNYmKxhLuvNoq0KC7b+rPOkhStjahxxnIRljiuxSR/EhYZ1dt0/1yF3b1lahw3kgg85QnsH/ReksoTaEdt9gdjSrIhkOHCDsB1sd1G+AxKqIGAFgEqvQYT68l+uhzTT0TX6kSDDy9nAFgcXX98PMjVRvvMTCjMbnjrthCWFxLzJbgyyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaCsI7x5kGFx15p51L5uxMkRzWRQame815v+T2MGKrw=;
 b=3wocNGT7mzt9xZMBzK94gQSay3csr05e+Vqd3c8P7UBg3KL2SQ+ioZeTg3Ns2i+NPiinp0wnI4+la0cS8X0bsBeGO+4kgoDrJ7XgnFBRW4qotOtFN1/8znuKxuMIxd2sGh8g3VuSM1kVFVLV9AjiLQ3XkiJOtioFpKY9BwjPmkk=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 09:39:11 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c2) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 09:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:39:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:39:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 02/12] iommu: Introduce iommu_paging_domain_alloc_flags()
Date: Mon, 28 Oct 2024 09:38:00 +0000
Message-ID: <20241028093810.5901-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: de74007f-71cf-407c-9a91-08dcf734605d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UcvUG32gKBMRl07kSShnJptkAYzOhosN8WeSUqgzlgwlGUTCsyNRXuzxMBd2?=
 =?us-ascii?Q?FeETJECfngmQIbnSSuSu/TNm30o/PLlX13uPgA3gP/c0KcOom/W4z5YjQaGK?=
 =?us-ascii?Q?PdbsdJYqkwfHB3EHxF/DHXW5iGfg0+TjD9HqqrY6VqB0817xBTMRqcLWRkrK?=
 =?us-ascii?Q?R7pqdPUxiY6iO5wOLfiOHMuDs0Z7l+mP3v8V/xMS4Y0EJjuXGgZ/sZ6PBZiY?=
 =?us-ascii?Q?tVzZ7AgcmiYekDIR+xsqwSRtbSLgJ5O92oNWb4jHRnw/z/RYNABIe9jxrHhK?=
 =?us-ascii?Q?gUavuFuXE0uk4lQr5UGMdLWTGVxzIoFPg/NmsXhrKJgD1V2yMbDy8WY1k1Gz?=
 =?us-ascii?Q?ISRq/yfuJVCX48m+Aa9QWVTv37xP/xuVYUNdLi4NI2LcWC7QCersNsqppVqe?=
 =?us-ascii?Q?m2F3S2fPD0g+ikpDFNxnYpMCAzolklKyFlXghlsA8XasBNOYarNyY4SkA7NT?=
 =?us-ascii?Q?RemstH9NHcaMtQRsaQp4ikWClOFy+ZD/GVXcNW6UBUOIikhHivEQlNPmTPXr?=
 =?us-ascii?Q?Oqa32vcbR2f9melzmN+LS3XwRtDhaLidIeRrNMclnLBh3aVvQopQtSJRAZrg?=
 =?us-ascii?Q?5UNZH8I03ihKcJEXVTNMY9Wr+knG0OmFP2vVaWNE8xfIAcRURZ8iNsQef/sQ?=
 =?us-ascii?Q?QK5kDcw5yXdAVbk6n/1NbO4HxcWmGZsDhYlVZ7eyMLQUM+7/5d1qyzQe4OKv?=
 =?us-ascii?Q?II1dRmJbf2kIfErtQMTtaTyCILy9eQzO9XO84fRh1i9nrbZZzcts/YcZd5jA?=
 =?us-ascii?Q?Poqywt1Mwc/HihR5OZc4+bq5NY45y9+9+K0A734qciyn5p5nQtQKMT8HqMGj?=
 =?us-ascii?Q?NlFmsXQgTjDzTQXgPj+p+wNTfJE8MbeHSe4lOqwFvuvDNRNEoHjBQ037VoP9?=
 =?us-ascii?Q?8W195xGNig4jS8ZFHWHtlvsQXWw6f0RLgTdCsmGmf+JrmfrvoXMpuyCYNpwz?=
 =?us-ascii?Q?mfCXvYS3JLObWsFbdZHQplr9reg1mqn5TMIdVUlC/9jHP0RhKLYi15oPuO78?=
 =?us-ascii?Q?S+xr+qM2PnkHwsFltgnHgiEyW3hhwkywPcWmapNoDZeNC04v/wCEXzVe3D1o?=
 =?us-ascii?Q?jIdOKo8XYJEewxrSLgf7LHkFHuubF9YlUoSrnGeyOck8nKJEcD+WgUsnfnkx?=
 =?us-ascii?Q?NZj7EQ3wONzUBOZTIzxP4A8ngmULGVk6aUcuTJLpIhl9YQaxNJZTC3odpWDG?=
 =?us-ascii?Q?RliEnyALP5YN8aBgNV90ALrNafZdMQ4jcPW5qzPIj+NojiapZFkLQkXec9MN?=
 =?us-ascii?Q?CDFNLj4ub8LEJPRV7ekYdd+BwPJGKp05mm4jpW0xmXiR3MqLZIPr+Zx6nnzb?=
 =?us-ascii?Q?UEmMWnAcWGdQVBvmxRdJm4kFp7XPsO39PtxUdEmv0/djmSJN0MEJV4Bykakj?=
 =?us-ascii?Q?5HLuHGXeXbsirJNzDoJK3NX7QPM0IH5UwlXfuhf53poBvoBQjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:39:10.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de74007f-71cf-407c-9a91-08dcf734605d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

From: Jason Gunthorpe <jgg@ziepe.ca>

Currently drivers calls iommu_paging_domain_alloc(dev) to get an
UNMANAGED domain. This is not sufficient to support PASID with
UNMANAGED domain as some HW like AMD requires certain page table type
to support PASIDs.

Also the domain_alloc_paging op only passes device as param for domain
allocation. This is not sufficient for AMD driver to decide the right
page table.

Instead of extending ops->domain_alloc_paging() it was decided to
enhance ops->domain_alloc_user() so that caller can pass various
additional flags.

Hence add iommu_paging_domain_alloc_flags() API which takes flags as
parameter. Caller can pass additional parameter to indicate type of
domain required, etc. iommu_paging_domain_alloc_flags() internally calls
appropriate callback function to allocate a domain.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu.c | 32 +++++++++++++++++++++++++++-----
 include/linux/iommu.h | 14 +++++++++++---
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 811748bec4b0..69fc0b9ba31a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 /**
- * iommu_paging_domain_alloc() - Allocate a paging domain
+ * iommu_paging_domain_alloc_flags() - Allocate a paging domain
  * @dev: device for which the domain is allocated
+ * @flags: Enum of iommufd_hwpt_alloc_flags
  *
  * Allocate a paging domain which will be managed by a kernel driver. Return
- * allocated domain if successful, or a ERR pointer for failure.
+ * allocated domain if successful, or an ERR pointer for failure.
  */
-struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+						     unsigned int flags)
 {
+	const struct iommu_ops *ops;
+	struct iommu_domain *domain;
+
 	if (!dev_has_iommu(dev))
 		return ERR_PTR(-ENODEV);
 
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
+	ops = dev_iommu_ops(dev);
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
+	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
+	return domain;
 }
-EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
+EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..42243183e81d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -511,8 +511,6 @@ static inline int __iommu_copy_struct_from_user_array(
  *                the caller iommu_domain_alloc() returns.
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters as defined in include/uapi/linux/iommufd.h.
- *                     Unlike @domain_alloc, it is called only by IOMMUFD and
- *                     must fully initialize the new domain before return.
  *                     Upon success, if the @user_data is valid and the @parent
  *                     points to a kernel-managed domain, the new domain must be
  *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
@@ -789,7 +787,11 @@ extern bool iommu_present(const struct bus_type *bus);
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
@@ -1096,6 +1098,12 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
 	return NULL;
 }
 
+struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+						     unsigned int flags)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.31.1

