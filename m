Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F76136331
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680195; cv=fail; b=IPNO8tBPW+dRXtdafykExEDS0NP4nLP3N6FOjUeDmb4/m/8JdmdVI7skEeLELGvoaDJ2cQNxJMIChGVZY+UxzF+kzYG1go36ypgPcn4uWFReH0Q7ojOOg27NZ0nmDG8+XHH/QQpVrURGn9aUYsAQaLxq2E/oFNRpQNy5JIzz1vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680195; c=relaxed/simple;
	bh=glQN+xbkZra+yc52MbX0LGQ6CFkGsZAYjnRd77IoHU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFYkq0rXXlFZObTgv2hkQrvGTA6ZZWnaWhoif7t27C48eowPP586AulrdLbtzcepPMnRxKTWfaPRTHonL0nNC9RZMorQNMY99R4MMMeoNQPDCqhMPmv5hfHVopYHIHInndY65ZfyuKIc8ikO6pGl08oiUOUWhUIAGaY7SVyDcvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GB0pKlBO; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GB0pKlBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUb0I8Cx1pRpb5bPvB8uIvQdZ5U7LZxxH7cqpool49raIrXR3yNsenfyM7W+AH1VKdnnInpo/0htuAI7t3Nh9BPw1p+WVqyomdudxAaYYvoe9eoMUuoaGJfQ1AvsMgpxkJgq5n4tUI154YoJsYlvn1oLgC5WMy+LqutBj9TjOCVflADzMPI3v4APnDSIhe80rXQsPA6sZglJUax12eU3czqlS9cWLoz6n6pvotMzOBe23lkHeLf7JrlcgZf5WuCWY9776MJUVe+BXCz1XSBdqGtwlgBMp4PYBPQHgoM0OdnSYdS3WP28knpQYXJi2ksbLFNAgWGx1RDvS4uPiDd2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ8DlgIaCVS34iKJxSpjpWOPS1YtHjTGlUBJz9F1aFM=;
 b=KCpFgfRYQ/75u4Wm7I7TIP5lWj2UTp1dFPZpkL1wq5+QYbNfDPcFQgdI0YodGCVTAamItLU/y+mc2yVAQFSimZuElT3X13iU7K2HeKN3L8fBzYuH7TnXpcbRxfaT4wQ8ihcfzi5nMptuNvVhkuSWloEa5qolCvYr/mTqIIVjrCf7wQVCl410ipG27BQjs50BfRrxVzyJKFqRNH3HSb3nJIaPMr6Y052oS2YcrcUBU2tvYlB4Rf12m8kDB0Rj6tH5w3f9FK9fA0Z3DQFW7oohth4pDudGeu33NCUElLlM+zYZ1F2EZMP30af/0nAawm+bcixADznluDkjVovWMaIwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ8DlgIaCVS34iKJxSpjpWOPS1YtHjTGlUBJz9F1aFM=;
 b=GB0pKlBO/yM6YEnDBpK5Yq+QceYYi3KdYu29KN0owMFP2lAb42dddSkdc3tGtp8LzQb8WZOl/s+OvHmy/NpzsrT/soloR0Lb5Q2TU45FBcnvaTSliE5rNW4glhBneyRk4f+Z8zadUd9+xST90RrV/LPeVNuDoixVJPxb4qhdc+Q=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:43:09 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::9d) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 10:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:43:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:43:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 02/12] iommu: Introduce iommu_paging_domain_alloc_flags()
Date: Wed, 23 Oct 2024 10:41:57 +0000
Message-ID: <20241023104207.5894-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c357a2-8bc8-4048-a585-08dcf34f7c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bsghWz6UFh5hec2u99VhFTWarDtorb854lI/ZyG5fImCrpwqkMoOqCUCg0rI?=
 =?us-ascii?Q?OtG+TDAYjkMSgId3UqYZgbEeDVxOaE264ae+0U1mzf8kjsTHCbdEd8nyz0Dm?=
 =?us-ascii?Q?y15KJNZ4rjSFJvSof4SPLxeor9zxqnVrvA8v9cMFNt9NX0k4eSikGV4CRZ/u?=
 =?us-ascii?Q?1K9WB8tZr6czzS6j7mqkalqQa5MRprCPM7uPVYwkkPZSTUNaiqGT83ow2gBW?=
 =?us-ascii?Q?gs3xjIMnLOjRfZlr0gWmZh9E+0L4Qx1sqYhE/Igh3ebBVxhCj7RXygTJZ+ng?=
 =?us-ascii?Q?S7rAt2BhX/MrLkVONB6vnRm93OZy40LIYgu8U8laSvim47Zogtw8UMtajMZm?=
 =?us-ascii?Q?QqowWnxrwJ3r1L/1nUZxOm2sQQbmALsHlowG0nRMYEQHv740+7frinGIJ6jD?=
 =?us-ascii?Q?GCewdZt/ILV9Te2TIlo7ZCHgwYrmKU3oCybq90g4kWDDkeuxQPKoh5tksN38?=
 =?us-ascii?Q?agrZq1S2Yw9+Ld8gtxhBxLu998KOX4V+Ey4SkjPzRzpymfSAMtz51O0xKx6y?=
 =?us-ascii?Q?OZTNgvwShNXd9qJL7duqG7zZ8vaCfEgzOdKteSOMRk3mfMBTOxEkTusY0SKT?=
 =?us-ascii?Q?CW72xjyfJgQGQGe9FbZcpJQELyXYyj2wXeAAyb9egKpSS1qNly5myIrPW/Ir?=
 =?us-ascii?Q?NBG+rEEM3sfwSDekOPRaIZtOwslEFxobGzy1zYnAUeH+M3tneV+NZxJdg8KV?=
 =?us-ascii?Q?FfJB8/6yNDxRbpqac7TI7Womo2w/4tB81mWmm4Zhnm+FD7ziu+ZW5Q8QpLr5?=
 =?us-ascii?Q?dRz30EmuIYraR7Pltnmh6FWFN+dAUtY7Y5qyAB47DhluUwqOPnIntdgwJIQh?=
 =?us-ascii?Q?hJx1Ft2T3kUU5qap/Qm1TlHM5cwKn5R2QA4Rdm/CumYVk+nEdSTc09h1WTh4?=
 =?us-ascii?Q?Uu1gHYef0wY6WYO6d12+DY2KNua/llvtSVw6BrUj1CgtdRfQxQQjcxISwCdk?=
 =?us-ascii?Q?L94K1rMaBPbZ4rVuIXC+MeTLdJryr8qkSYUH32E3AT7ySCt/zc9A1IL9+fi7?=
 =?us-ascii?Q?tR6XDmk2H1Tyvg/pliDu1HbLRJda5O2ZzcYIjU2nF/xmmniAoVnaAkKHMhnV?=
 =?us-ascii?Q?kmXFIUK9g6Uf4uiYXytHTaGPwaXkSHfWyl2wnEFnGkM6frsLwk7JGpjJZoG0?=
 =?us-ascii?Q?vx+5Jj/sc34VsJQxtTF3hlK5z7ls7wN1BJ79DhazwQSDSTdMR0D9kNBs3YFP?=
 =?us-ascii?Q?wAfxsy9pzEUyUJSf4YZ9Uf/KchqccWzms51s78FWN+JlI0Kiw/lFgWWCT8bV?=
 =?us-ascii?Q?abY6XpMvBRvSBjsSL8FwcXwwrP5QoucKvU69XEYQncREaCE9TBhdRFkvcvZg?=
 =?us-ascii?Q?ttyIGpFUEPYj1NC8ZAKExzQD+HNf7zdvU+PpZL4zpwFBhu7EcmeMxoENvfY2?=
 =?us-ascii?Q?8D3y6RBO6VmJq0WicUnv6Lv0HX9KV2RIAc3GZwV9tBqB5j/URA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:43:09.0908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c357a2-8bc8-4048-a585-08dcf34f7c36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

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

