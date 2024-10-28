Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBB1CCB54
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108522; cv=fail; b=ZKQHjiUFYbMKd2PEAxANPTvtya/1pU6prTUrgH5bqGGdNYrPf3rqER0crceJq20kcUc1RPkIltFthy5eWJJ14fx7qnQFlkG2qVeGzE/QRpahW3VxS9NuilMXtXqy8TXaTIaRhLh22e7y0+eCfP2LMzzyVqDY5IL1CxePs3fzG+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108522; c=relaxed/simple;
	bh=jgeBSJfBOrlF5Oq3/O4VH0x/Q9s8Xo87JWKMADeESEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYHbQYrmy2dXSMQry2YjRTuPaBUpliRcgcjhBiXevlidqInVDvz/lBGtz7RUnG03Br35bIv5qePj3eJeJFR+Gut7yLm07PAFJL3927ozZnshHYGxq8msBHp0XENUY7Z7p686D1IPscBlrSyKyoVxI00JA0Ty8fItDV8BsbT2ICg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RWF/k/im; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RWF/k/im"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOjtSnki2ljndTmSwBX1+HdMDUculoTbHxomReT5XCr4OuK1FJ48yniChiCC9QzihmmM5m+nkeGd534Lw+bzzRf9rbFZPGW/hf7NpU64SHZIDO3zhnrRYkIgDYEKxtcMctIAyGgpbzNpZaeIfZ8EfHhejnx8eER24nPSADOUlWrc1cU6jmBWmiqNykUdh3mmK8C7zq/y5RYdqedppcCu5UtoghfejRj0paqOThJxc7OuWjx3DEYJEmPUksg5hc5eXM6Vjhavbe4tW1HqwxRZ3w73CvdYxDMS6C5Vm+j6Zhedwz371F8Clig7hvHiD8Y9YbJIhFrRjEJmdNF05TH/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6BqO17eWr8qEbRrTSfSmdhoZ6MGbWBunagnODwpwaw=;
 b=o2y3E3czKPhJ87J8Xzb+hjwIbXuwNt9pmVTNgpO0ubAqAj+cxY1+GnCm1l7SVNe5iqmhmyJIVkFZjnFKyhNYwg3jzu+5HpEdhEBC2X3Chk/VoUMUuy8TeYdhNQPIu5iZCP7GGnWKdD+D2GixU3hoeiig2mPrP37R1qgnbIUEkOIsHSjNJTLAn4eFcSeyQ6q4cXnnlAjNLSdZDBRP7mQdGQLLuCZ5X+42x1KFDQVKaB1GtIjXBN1LBJ0vBxsGU8SZ0DMHEYkSyDAIbMz3ao/uGhSv6ry9uurxbZ3zyD4unxhf64i4BPS+/Ej1sjwH50u5mVTvb4ILSBIJkk1dq0JeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6BqO17eWr8qEbRrTSfSmdhoZ6MGbWBunagnODwpwaw=;
 b=RWF/k/im0J+2yYonYuIZiXxAsDxpeEyvm6gHhpW1HqeqDBCYLMq91SQlJN4rd7KdXazdwxq3R7WJxGnvwg15pgENDvEkXfe0J2yGuk/mH4S0VETNBaRmA/avGRnk+YZUAejeDesk9ykVFatAHEKVj3wA3KlMUKF+WbmnpTBrlP0=
Received: from BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26) by
 IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Mon, 28 Oct 2024 09:41:55 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a02:80:cafe::49) by BYAPR01CA0013.outlook.office365.com
 (2603:10b6:a02:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 09:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Mon, 28 Oct 2024 09:41:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:41:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH v5 12/12] iommu: Create __iommu_alloc_identity_domain()
Date: Mon, 28 Oct 2024 09:38:10 +0000
Message-ID: <20241028093810.5901-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 7190f268-cfff-4500-e0d6-08dcf734c215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6o/xUutHWKQxC/1Jl68dsUe0e5s0I/0WaAInLb0cQlgyvClWx4VKFA7oJ75B?=
 =?us-ascii?Q?2a108xuO527YU5kNPQ5kpn6rHrf9wKUbYEHo00mCbDEDrr9jFcWvJu7lwFOv?=
 =?us-ascii?Q?0m075TMebauWbb6eFq71URRYnIKTi+dViyTmCMkeRi6mDJQsCoOzgc3wYRdC?=
 =?us-ascii?Q?ZLPBcemJvuEnEL4708WBkJefO0Igid4Uo+Z3N8oo8vrZt5pIk0rSEfZV0Gu9?=
 =?us-ascii?Q?Mvy+y3Nsh/QDUwAYsjB912pgxGxDqhjXCv5cXCVrn2wWTl4m77cmUSn86cSj?=
 =?us-ascii?Q?aczKGkO/FaLV8mF3dAxRT7k+8qNHQTYW7cgFJasjkwnen5B5mEX4PXiEiV65?=
 =?us-ascii?Q?HUCBjSky6YthacAMeSBJOKal33JcNRBjhodL8Ptzjrc/mgfoHc7hr38vJv4O?=
 =?us-ascii?Q?A/adNRPDAtrbv9i9PhSNgiftLwX3NZwTF+9gYemS/4TCTfGwFtsqA3poWv7q?=
 =?us-ascii?Q?Hjxw94e8JSTrAZuhxCvxnz4ttSKkZK5VHGlmStgZ01EjBtak2CdvRPPG0ABP?=
 =?us-ascii?Q?HKl8EJb6Ae6sCUI1XqA3pCLN0E2RLBE/E7ElSsBVMNKgRx+Y7gw3dKToSR8V?=
 =?us-ascii?Q?+6kiaDIwLcMBug6gQzuq1JTCLAmw3JMSlmWKrEk6PYE/khJcEWYq2h0SNt4W?=
 =?us-ascii?Q?z7XnqtIgPXumu1TTNeu/Hv14otc0HTH8yzzCvGHZtQNO0NX0vQVhsNkVv11b?=
 =?us-ascii?Q?+DW2KKA0Ea3nS9HLGj015QYRchKpdXWOVXTy4VG7rXADTi3KeY3lZPp3xt2L?=
 =?us-ascii?Q?di8k1fpIbRPT1pWQRNJP7xPujDYH5VVYoEhJC7ufVwjhBcBdaZ5XA2qIRnqF?=
 =?us-ascii?Q?pLJijVuItOVYp5r2zybPBkGCN1iX2i/nsjLlQlaJZILXrP1Hkun0rbdidJEq?=
 =?us-ascii?Q?i9LR/uVEvvO8fwUECi6dCNeItod5MiP7N9T1DWmdi5q9Vo23SK287YxrKeQH?=
 =?us-ascii?Q?N/xXOL501sUSj/zT6IqraTTe9wj2Ql6KNtic6+mqEzqYe16mAJ6Unz5du8X+?=
 =?us-ascii?Q?xFahlIS6qVuyBXvLMxNww0vm/PzlIJ2VnnU7xlUJgDPyuyzGAYoTl4jTzJKP?=
 =?us-ascii?Q?vgKMzAVT3sBC7anI994gviQXzI6jG2+wPqPs3pIu5ldtxsPHDsZPp8EXT88Z?=
 =?us-ascii?Q?1+UdNr05BruGif0TBX4AnRtpthjOjYhRnbQxoMj52iQT65PK6Ora0oBmtZ8a?=
 =?us-ascii?Q?L+x8Nw2nm+bKIjkRiOxL0wVUGZ2QDk/7zNArikoaWLfMZO5z+Hu7gxEBpVD+?=
 =?us-ascii?Q?xq/mlpkMkav4kWaQnYibcr1JIuxoNR32hNnqEBL36Fe8Oca3fZjrfgg6zpd1?=
 =?us-ascii?Q?/fkeJrHCxDHx+T4hd1S8sYN4zHYcXoXklSaVO8J5jt1/7R3NEyzmW/I7dH2b?=
 =?us-ascii?Q?guaGbt5SacvUeDJbuMrCY3Lxv+/ZpT48wABX4kel9VVrOtIXlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:41:54.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7190f268-cfff-4500-e0d6-08dcf734c215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

From: Jason Gunthorpe <jgg@nvidia.com>

Consolidate all the code to create an IDENTITY domain into one
function. This removes the legacy __iommu_domain_alloc() path from all
paths, and preps it for final removal.

BLOCKED/IDENTITY/PAGING are now always allocated via a type specific
function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4677b676bd0b..dfc2f9816086 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -94,8 +94,6 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
@@ -137,6 +135,8 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -1590,6 +1590,28 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+static struct iommu_domain *__iommu_alloc_identity_domain(struct device *dev)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	if (ops->identity_domain)
+		return ops->identity_domain;
+
+	/* Older drivers create the identity domain via ops->domain_alloc() */
+	if (!ops->domain_alloc)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_IDENTITY);
+	if (IS_ERR(domain))
+		return domain;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	iommu_domain_init(domain, IOMMU_DOMAIN_IDENTITY, ops);
+	return domain;
+}
+
 static struct iommu_domain *
 __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
@@ -1617,7 +1639,10 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 		return dom;
 	}
 
-	return __iommu_group_domain_alloc(group, req_type);
+	if (req_type == IOMMU_DOMAIN_IDENTITY)
+		return __iommu_alloc_identity_domain(dev);
+
+	return ERR_PTR(-EINVAL);
 }
 
 /*
@@ -1983,9 +2008,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
-	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
-		return ops->identity_domain;
-	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
+	if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
 		domain = ops->domain_alloc_paging(dev);
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
@@ -2006,14 +2029,6 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	return domain;
 }
 
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
-{
-	struct device *dev = iommu_group_first_dev(group);
-
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
-}
-
 static int __iommu_domain_alloc_dev(struct device *dev, void *data)
 {
 	const struct iommu_ops **ops = data;
-- 
2.31.1

