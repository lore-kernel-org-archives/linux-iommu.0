Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71631DE3BE
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173938; cv=fail; b=TaSn8UH4EzUKWWfqxEN4IYvjRL/HmAMP0PKg1kHYSZ0IYaflZzY18k7cIYv2jiCNWgq4zFVuYOjFGUOA9cnwPhb9gZy4tpZzcl20iN0NUAgh/3z0/4r9s3rufnbbLglauEbdXag2XA/0/veA/VW5gm7UjEOzdctg31nVwy9eZBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173938; c=relaxed/simple;
	bh=40C6hM+eEl4704HVchMfiisqFLHMmzHqG7kYUjA+TtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kwmak31JdAT2lvqTtyEE2qjiH2sP1XHyG6rKg4KRRM0S26It07PdZ7uqzf5f6PSrMVBSzYMEgZgrB7iHj8xz1cQHrz7tuWdYNvsqFsuMVUxovdXKJOpCvY68/5S3bY+8A6OproturtKZIXVC+kHq58nVGIcK9SFzStlSuL3o+vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2jPcFzMS; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2jPcFzMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apY97ZnlEsXuDTRmt3ugRbAVorG/KYQpiuDJk3HCn+vJtGzpReN5nBZ66/MCLZjTudvsGbY9MIhpmVwT5bIPDZIFRLziVeKpwK2zBYgFBusYN220cda32NyIlDKcOKEpn3yeYOc5dBS8RWerz6lGSwfSc5d/Zlnb9yZT0BSJ2XR0X2v6ScYLp3lQ5/McOyPr71b4RoDjBw9+02XM8bZAzCFmaz9UerAHcd9/Vu2sGdxC2S0k5o1YMh1DW2tBaOuFeH8PKX+qedns/+9qgMqpg2wa+K3fyo32N2+l3Uwz3Yfes6OLnimWX3x1NfIx5TdHaWo7FoqFglkNfucVjB/YRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zP87mteDxmanKl5PHYIFVT8cbXwg4PnbcDH3BT/o0Q=;
 b=zUVcMnFp4sfx/7x0g/Q3IoqzATFHou3ZFBB200iYgl7g8TapHPywCjWa8dSKhVf8XTWpFgOg/x2lCnmJbX6IgXQu/RN/KX2rXvKgQWa3lC4SJb3aVTTGpPl6GPj1eKLGh7gufHfeurW5r0Om4PKgG1eaP4cuR3/TAQuSgErgzPWl4wR3P1q5yaZB9NF7XAia5UCXiBsDQxKRo3MkRLjUI3SkGOOwNttZEHIZCVOk3LNfeej1XpDvKuuwHFcPiSdPO7FBYtYe3siBdgBRI9da0WTri/KU5oePrbKIje8G0dIdSubSDzVnDB1o+OB7ZtF2TRYF79cH4Ksr3q0w3V9phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zP87mteDxmanKl5PHYIFVT8cbXwg4PnbcDH3BT/o0Q=;
 b=2jPcFzMSKI2VwppgraY3Im5AQJFqMiALPKKhMxmNsSbECLM1WDMqHjwXdBSWYmNQBIxTC+FNi7rbnQBjYthXPRpU0aua12eHJUcO/J3q20dJuPtCDo2RZ1s2EXRbLrzaiJZFCAkB5zNV7IQxb9aEwXxXcL+/2JeGyfM4Abgw5ZY=
Received: from CH0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:610:e5::10)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:05:29 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::9c) by CH0PR03CA0245.outlook.office365.com
 (2603:10b6:610:e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 14:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:05:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:05:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH v3 11/12] iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
Date: Thu, 17 Oct 2024 14:01:36 +0000
Message-ID: <20241017140137.6028-12-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd8a8d7-8b4f-4623-9011-08dceeb4b2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOXaUGzoH2OhOshjhArag+n7TlY2mENvJJQNItqh1qVeKqAGVRBvGwiKVZGO?=
 =?us-ascii?Q?c20UAuQCuot905++K6hKbHh0e7h2DAQhdSkWp3g4uUapjMWACoOjylkGI4VN?=
 =?us-ascii?Q?j7MWDA79+u0DWEb9cYnbJ7n5N1vKvK3ifHPg36YddsLq6OIr5DyqujrLkuE1?=
 =?us-ascii?Q?QgBmUM13rqR1pZoIpRTrIWuKlFkLY3TjH5bS8081118GnfZ955PiOE+MGlvF?=
 =?us-ascii?Q?oimeSXtKIYdl/bGtu1Y0clzUq9y2My+IaQNrujAoBdd+VrYcVnoFdnAlpWKQ?=
 =?us-ascii?Q?nx4u0kZhMGxJZGWAbWgj7xw/26ZyKBaZ5VD6ntk83fmJmdetim70BYDClpku?=
 =?us-ascii?Q?AGa7fEDOhztgQLVdxZJRNxwT9WkSnkLtzmuuqEjLbcSEHj1/x+/e9yUS8DxH?=
 =?us-ascii?Q?1KtCawCy00LQPWEtXGEl6jiTZMSDa3ls5aZb2o3Fc2WDAlJXYzL/1HyJ/9Wz?=
 =?us-ascii?Q?7ZeE+4dBSgn/ldRj2AAV1Za0heOF1V1EZbwPDqAcTOl+wNuffVuZSaahjswq?=
 =?us-ascii?Q?hGtJiRB1/QJdhRDF1CE6i6uWPW0+Fxg0Ou7zDElVUP3qzVWFDuqJKJsKvinp?=
 =?us-ascii?Q?FzbfpmOvoWSSR3qo3qcYUdHphFM5S30lfy4p/RCnLOGEczzSL/53hcAL6CVz?=
 =?us-ascii?Q?+anay8RauALDPl2VC6CRYCxjyxiGj6bOD+C3hLzr4Hyd3lDeyf+nvK/a1e/C?=
 =?us-ascii?Q?o7TTtyHWAo02Y2EPTYApiYqGNkMsVj0+fthJfIXBxOpMXU+x07OYf1LdaSiW?=
 =?us-ascii?Q?xpGHCYvfG2kWB3yQ9kHbLO3DZoCdaAxxHZ3SpknySfUdY80gR9kRvSO1d9Ym?=
 =?us-ascii?Q?5TB6CnnEGud2v+kuZqeMn+1S1GS7LQBS/1TLFxZ4jl9dfcXDnkzfeCV1ZS4w?=
 =?us-ascii?Q?wMi5hEtw7/O9MZSUmgeQw3GozYRQTbvhuwYh+wqgF2Z+usKfhG+l8wmb1ui2?=
 =?us-ascii?Q?jYLRRKaYjdnBr8onhmFNBXVzGfzaQhZjS2zzxuJ3ZJhj7XOpxCFNJAhC5SRo?=
 =?us-ascii?Q?AVl4FqZIi6JMzxOmoyDExOmQAfLETCw0ooLDpiCwnsjXi58x9yB8dk9GlkCT?=
 =?us-ascii?Q?xrN5gi49/bK0EMRUNmsBPIAYc3K5dvCigMjnkXpNIIyJAQyMGBnkUYOhkOAk?=
 =?us-ascii?Q?qiz+J/Vui1ZQ4HR4IjkgOz6YVJoArR5TRHUYSslp0NTD+5Fm6O3Ps++eRU5M?=
 =?us-ascii?Q?yVuetzy+fdKUo10z9k63k+V+FElcSLtb7Cb8Ux04bTf9971Nq4utP2HsLMJS?=
 =?us-ascii?Q?LANvk9ZlZ+DGYGJjIZdlG5N/emLpItTCimo13DltIy2SixEiPB7K0+DwaZ9+?=
 =?us-ascii?Q?3DKjljAlNEzTNqlmRtwb4odhgJsI46uMNiEdJ0b//H3guleB704KAR9kv6bl?=
 =?us-ascii?Q?c2hCdUTwt9pB9WDcXGTSXeggHTy6ne3qBpPbAD5CPFmsiQF1Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:05:04.3275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd8a8d7-8b4f-4623-9011-08dceeb4b2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719

From: Jason Gunthorpe <jgg@nvidia.com>

There is no longer a reason to call __iommu_domain_alloc() to allocate
the blocking domain. All drivers that support a native blocking domain
provide it via the ops, for other drivers we should call
iommu_paging_domain_alloc().

__iommu_group_alloc_blocking_domain() is the only place that allocates
an BLOCKED domain, so move the ops->blocked_domain logic there.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 107016b3ba3d..a007fdfd2fee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1974,8 +1974,6 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 
 	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
 		return ops->identity_domain;
-	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
-		return ops->blocked_domain;
 	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
 		domain = ops->domain_alloc_paging(dev);
 	else if (ops->domain_alloc)
@@ -3201,22 +3199,25 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
+	struct device *dev = iommu_group_first_dev(group);
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
 	if (group->blocking_domain)
 		return 0;
 
-	domain = __iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
-	if (IS_ERR(domain)) {
-		/*
-		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
-		 * create an empty domain instead.
-		 */
-		domain = __iommu_group_domain_alloc(group,
-						    IOMMU_DOMAIN_UNMANAGED);
-		if (IS_ERR(domain))
-			return PTR_ERR(domain);
+	if (ops->blocked_domain) {
+		group->blocking_domain = ops->blocked_domain;
+		return 0;
 	}
+
+	/*
+	 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED create an
+	 * empty PAGING domain instead.
+	 */
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
 	group->blocking_domain = domain;
 	return 0;
 }
-- 
2.31.1

