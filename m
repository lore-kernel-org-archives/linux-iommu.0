Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F41DDA39
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173768; cv=fail; b=BaXvRxBeI6uC1i/1BESOThE0ROWieMIYdvgwneasz4y1G7m9ENFnhLkcG7v48kW92Y+X59bZAhMKRSmOdeQ6psttf0QZ0YA7Y6JetPWbtjW0hJCR+zVn7yBd3Dp7XZItDURYK2Mtp/rPGBTq4RpMzZQXrZQc28h4JQLN+wf8gJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173768; c=relaxed/simple;
	bh=hTALAoAfeS9IdUbuRUNN+Rzs+NiwDCM4XYMYboA6Gz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4nyNoBpkBY+FUoLyGagCS+MjkEoZGbwhD8WRbFx1CED3Hil/GMuJE1QPyNG1lGwp190NoZP9aGPhgqawPcpGU0emQXiMbcI0SmZWTCT5W9BC8j39m1BoxzpxY8Hj6WKeoaeRJ/ZCtcr0NoUVsI2ek+L+ZPL9KAaoEJC7Nf9sDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ddEUsCDk; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ddEUsCDk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivBJpCRL+T9pXEFuAtjmItLtuC6HkCvQS9nHDnvGacjd6ZTlMhWLXbWsWxaoY9C5M6QQLYTbbpT2Fp2Ttp4BjCv8K9+1w72ABLHbuC2PTfxZMJ8j0KcNo3Wq5jTip4g8aeLYmbnfNYlkcOFKKfjwozO7nH8zQ567HxipaZWemuEra0sl2ZQpa+1/w7BoCjrXOTe3f++cUcDNw7bW3kY0qrrTXAUCxsdn/gaItLpKR9BhNAxGN8ZSHrmH/Zn27bvbFFOmfZEV5mNXZpX3YDuSt03qZlcVAmhiIhKvdoIWR+3qKImPqTsfzkXtyLL9lXZSJk4iFotGBjVgN7wBtlKW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aJ9QYoxL2k4V+DeWmTwNJBSlKetQssrjSqYkr5DGB8=;
 b=eiqIrjQOdNrwfa2l6DPpy8gZIbBLgcfoJAMPsl3TTuUPDWYlKB3j6ghYU1loYooPlIAhcHz0nQHQaxuUvy62kRaKYL8gkGJWUV83oxPT9BfTyYbg5aCIGYKVI6kC0TvGHj5wno8MTlvfFyDWtTGghXNYm3Cqi6rJNroGBG3o7uaCABAqR0aSH+I1EXqHm4fwC2ht0Fsn2qAYLoXXQ4BDaMiDn7srR2oDbpqm8QqSPQd1TtKTGjAFhJQV4OzIcXNo5GZAIQu3Zz01IwMaTwMoHVjhxZc8+vQLuhqSfWJlGHa49n6oQSY9yslk2WaTK1li0aq2HyJwLYEZhwDu6WTxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aJ9QYoxL2k4V+DeWmTwNJBSlKetQssrjSqYkr5DGB8=;
 b=ddEUsCDkCumseZc2nT4vFBV5WO6vuaXtdGg3kvU8iiA2XZzGCSkoJK4Zr1D8dyGPnSwD6uDcftUxK8slYjI6DpvJI2p3iDm2xSJojhwAmdkX2qIOY3Jw0JJOfvVq3iWGgiRVsQtmrYYnwQs1SfCqOq5jLRzv8XI7L3aAWAzVbL8=
Received: from CH0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:610:119::21)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 14:02:38 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::b) by CH0PR03CA0387.outlook.office365.com
 (2603:10b6:610:119::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 14:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:02:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:02:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v3 02/12] iommu: Introduce iommu_paging_domain_alloc_flags()
Date: Thu, 17 Oct 2024 14:01:27 +0000
Message-ID: <20241017140137.6028-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 207afcf6-5c39-4bab-7098-08dceeb45c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eKbROwgiJO+nc7FqMmul8p0n5dgGbn1rThy5zjK0tK+D6gWn06EYdgUBobYH?=
 =?us-ascii?Q?RC/jZMZ1vyEdBpYE3lxER4DRfxM1gA+LicjRzQlF8sAGKr0qISsjf+H3tX62?=
 =?us-ascii?Q?8dKEbEhboPTzY4NtzSUBBquFHwZxqOnL2tsJ/YsF0mmN5AfI5yeOnmh7xrEn?=
 =?us-ascii?Q?BMwuYlB5o/uFjSeeGCPKnl36NeQxE0Sll81vb7UbXYG5wufk6qGkk7vv6mYN?=
 =?us-ascii?Q?tpUz9mkbVwWhdytznMa+cCnnG8IITjIVk6MjLzxiGIcme7a2w3kPiJF8ucIx?=
 =?us-ascii?Q?5lk0rzoWPiahFxk5ibgJykPumkYQrTJafIPE8OtQn+OwWhFWbCXPwixsOBbG?=
 =?us-ascii?Q?y8/E1bB2lv6ZGQ2cBM1ZVZJYuN1LmzTfjDoUX089KhYcEeiZsXfxTNfsZqnj?=
 =?us-ascii?Q?SObFba0nSn1vJ94e8+Hc/tem+4CHMhS5esj/Qvhm3do6grDGI8PcvNi/tgyx?=
 =?us-ascii?Q?5RYlWeuslTmHqxYkbBVfCFuGv72X50gr+D+EFaMPscHVLcDSWieUYBD66/A1?=
 =?us-ascii?Q?lz03gx+8FzKczfX20MUcbChvv4n8IN6clWI6ogH23CC3JdhkLT0ZLL+XPTD5?=
 =?us-ascii?Q?uBITvEVY9WiClqC/XWxkDbjtM7hRmXj0YiAD8Ub+/425dNZPe2m1QfjlK6HI?=
 =?us-ascii?Q?f3m5JT0MxqNEX4lDYg9NV1+e9C1Z3fo1YKgCbogqmh2XMaUxjTqN3ZmSTCEg?=
 =?us-ascii?Q?dQWZNEBC0Hny4LHd25eLMLSZqFsOyESkbFIqh7MWU5A9o50FczGtKZbwsa0C?=
 =?us-ascii?Q?BK+8nsI+9VSPb0Cs1yuyP/8vcycke1rk4Th0PoIzoowUAjd9OEollX+G++mi?=
 =?us-ascii?Q?cgI7F5+Qv+8wHK6U2oAHfUmukkNNwOnz5IDAUBMUTPBuipC3s90gpKowQs5m?=
 =?us-ascii?Q?pvxVAco0yWR0YhMEphoqQPTUK6x3xzsynkX372PmLxADA+QNCWbTBMvMS1fw?=
 =?us-ascii?Q?jeopdzh10WYnefJrxYqrN82Ar8BAyYYjr8Ir8y64fRFF46KX/a2ZpMQUij7j?=
 =?us-ascii?Q?i/zF08CiB+GwRE8U6PTb6K5JX/FC1QY77iyKkYeuS3q2ajK2yyfulYXuGX1F?=
 =?us-ascii?Q?1C5n18KQ5uRV37vfOFrLqKXvLZOoxFa18sv79X2IZ54jh9Z4gMgDK3Vk3nJ8?=
 =?us-ascii?Q?SGvLqZYLVSLb88vZBqmSBOQzIfw9Dr9joH28Qum0cCtKoyKbuHfF4/bVWvp7?=
 =?us-ascii?Q?0cj0TwhRChKe1NkkpnV4e4NnpDtNnWMWSpjaZO0epkxIDDqANJ/JtVqNXN44?=
 =?us-ascii?Q?9l7DcxIfu23yGUrFXvLhXGaTGa/Hp5jFhaXOqRwGxBe9f81DoEzSnPQ5g5qn?=
 =?us-ascii?Q?qrK7Jun0mA3iwwHkd8IJys6QWsd/s1dLnxzcT8AptcG5bNUdKTf8qMHfM90X?=
 =?us-ascii?Q?t90+m0l38pFmnfJ6YD7mwiViMCoCshkZkVNmeXO2RjvhqOAsmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:02:38.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207afcf6-5c39-4bab-7098-08dceeb45c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005

From: Jason Gunthorpe <jgg@ziepe.ca>

Currently drivers calls iommu_paging_domain_alloc(dev) to get an
UNMANAGED domain. This is not sufficient to support PASID with
UNMANAGED domain as some HW like AMD requires certain page table type
to support PASIDs.

Also domain_alloc_paging() passes device as param for domain
allocation. This is not sufficient for AMD driver to decide the right
page table.

Hence add iommu_paging_domain_alloc_flags() API which takes flags as
parameter. Driver can pass additional parameter to indicate type of
domain required, etc. iommu_paging_domain_alloc_flags() internally calls
appropriate callback function to allocate a domain.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++----
 include/linux/iommu.h | 14 +++++++++++---
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 811748bec4b0..e13d64ffd14f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
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

