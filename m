Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903D28C5D3
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054373; cv=fail; b=K8lejdt9VkbKUMbOp1sbu8oQyhtpYo+/23OKO5cIVAQvbk2RreKZHA8LYX0lU8YWrr0Twx5U5ueezMu54rxHaVnFdlpFXJYrjegil5tRRQGkFxYXX7T8CYt8OTcwSVbJ0RA3dPZ4Q+OFNWRf8ow1DPb84OPdjaJo6d0PVEkmth4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054373; c=relaxed/simple;
	bh=4BaWPeMqgnrboJXHz75SJEvgGcoRVv1pdCQWbEeXu5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1emA1UVPWWCLad3N6RK9sYiDK/KPaxj1l2YLDNXjhXDdGZ/ihKF+O98abFLh6mEbAjgXzn67aEcPPl+t6cj/UYEP2lWyWSsHxAqd1nKad2TOOMwuvXTALJUC2+7/mBVadGHnIfxL5hS6hSre8wd4NgZjjQ9fUBvbGxsXhU/foA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U2hR4HT3; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U2hR4HT3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QewfmUNL1sdvnyiaxA2S3LKH8vSCKl7iSrQ8n5dkm+I2X3bUXP08LOjuNHBFa4h6KqPJVTgdScqWLHIwaldIR34vZyqXNPL83LWr7KOrhCzv1Vg5Kt2SBfvvTNhZ+ZcQ8hPpWYFn+BrRcVQclgbMSZ83t57VUtD4bkmi+4JHRkmdl7mA4rSfy2Qf8bBt3QRQQQXf9M6RADrWrW9s+sfFYBZOe/bDsCwuqKezz2Rly2+sBF2QlUbLtr+IDiWaekDjJcoENIyAEzfd6OaK9Ltnrar8eT36pi782Wt3kxNvlEian4YX9X0N7i8MU0dUCiMl7KyeljOsCmoq4Chf4Hw1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrNdX/D052zAX+/C9eAE0B/flWKj7KYsRf1sCfqpkrI=;
 b=GAQ/+1t00KTh1yCTLOHf17XN7WEpo98VGwJPpkzQy9L8cmjJa4KSB8CHItHYZURwTTzIlATPUbv1lE98BJo4tien+TiDYgYFtjfa1sCnkYDgfyV3jo8GyOVK8mND4Cdn+YZ+OfKWjIsM7IjeLA8IRKoz6gihWGuCZ3qNJ12n57nA/I+5FSSeY0ummmCqXqwZjZs+jCXD7vN638xPaqHhbAS4JGk4yUfGLA5bRQcY2LyokJomVkMTti/I5d0svR9/K8MAnLzrvktCynEGGMjnAtgutgeX5rVmvoT2/X5LkddypJ6MhPwJsBipI37aQlRxb8nTsBxS680K8vhozq2Z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrNdX/D052zAX+/C9eAE0B/flWKj7KYsRf1sCfqpkrI=;
 b=U2hR4HT3sqUX9ADOGOWxhqJTMPZyRe3GIB7xQQPfdLHsww0z+sTZAhGuEfkSTnrlwxIRcayyhyn9dmZ2QnFum8X+SEjOS0DgEp7sjUkPFp2udmMd18du5z/yavl3xQbYg5urrZyZH6/BX2GOufJqe4wPHUr3DdUcWZrxvWU+GnI=
Received: from CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::8)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:59:26 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7d) by CH5P220CA0017.outlook.office365.com
 (2603:10b6:610:1ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:26 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:59:04 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 10/15] iommu/amd: Add support for nest parent domain allocation
Date: Thu, 9 Oct 2025 23:57:50 +0000
Message-ID: <20251009235755.4497-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbf6991-f002-4480-8dc8-08de078fe096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wfk54WA13u0Uzfd8na8GgDewu9cU90/b2KkTvXj6iaBo7x7rZJmUE8uYqzDX?=
 =?us-ascii?Q?JGmTznoUTRvVuZwVg9nbWW1CgG0JwsaaPwHoAgQ2EzZpZA8uCq7wocf4Qfth?=
 =?us-ascii?Q?9hpaoPOGF+wXT13xguFutG5JMTW2/1aCStdXrtcoC+VkHjtwoCLmb3trV+/B?=
 =?us-ascii?Q?lRxpEvVKkXqIYvkpC9ubNRnaDmxOifcWwrRgSVrs4A0RGsvblyPmX4Caff5n?=
 =?us-ascii?Q?5pRZOkT0kBnCp68AHE+b0SfozP31W+b6LQdrgWiloaBDKEXx9rk+S2RMZW6D?=
 =?us-ascii?Q?U2MA46dXuVJbXSJLZFlrNOoRjMGuKdqgnTI2/9eb/W6O0eG4/TSrODHi5BVq?=
 =?us-ascii?Q?f6aYUII+mMZdOfjGfzmlA/FzAoThRp0FFGvodYaK+fjDozvUHYdotOmVzi6m?=
 =?us-ascii?Q?cMH3ghOvJVPlCisZ/SJPqDJFH3j5xDgTXSevlSPTcLX1vBfqEJbcT8+jLvBu?=
 =?us-ascii?Q?d4dhtF+vTJiSYFAjInIDX55yqGFEAsFf4vWr5Wfa5Ol+w+Y/8YQikyaKhgz6?=
 =?us-ascii?Q?K+ZOjRgDZDuEDRb+CvfeuWVVgaiF18U0t4bOGwwwszurDBwEc0tX9s8cN+gi?=
 =?us-ascii?Q?pe4W6bCRFs1vcJPPIgH4HlF0bQz3Fod3bwkzLPRdXQuW1Q50GTm6BcEcXONY?=
 =?us-ascii?Q?2JlMD+XBQYtLM7chgMr6GiZQo+IXP/Xo1vgSyJPL+N7y1AEAV8cXh187F/qD?=
 =?us-ascii?Q?cVuUUQWaSUB4u/k7XSnw7e1RorQxQZVhQTZUMMufQ9TyeoltSYmNwE3ZB46w?=
 =?us-ascii?Q?LmI7Asiqcbk2qA8AcGvyxNmMdiKD8eG8zpDNQCJ2FGjEDijvg+Pu3pgXofdO?=
 =?us-ascii?Q?F3wOx9fxHo7g8lJC7tzEgkhLBKsUKLYLVgx0GimL+2EJpf83FRok6RnKTWqJ?=
 =?us-ascii?Q?PG/tcSz0bnCGEn2epBwDUwnzicOQSsIWe+/osXfgI46WfCwEwGy8OVupIrjU?=
 =?us-ascii?Q?rHNGLUUdgGYHukU6X9c0prb8nJeSO6OorBaWLBf4MtjYr9ICqjbwx/MhuLgZ?=
 =?us-ascii?Q?VXTD/xDgSqUeqKxS27ajndmFcHXk1gltz9FTMgjTLU/EderRVdokXS+Bh+jP?=
 =?us-ascii?Q?jes7rwdetZe8PWmmURqtniPc1bRpo/Us8EpCqBBJnbJLxCxaEOzra+o2aJi2?=
 =?us-ascii?Q?ePoC4qGmdeTwqZw3byq2w4zexJTJV746s28b0yiA7gcmOC7Sz79FcigNDClv?=
 =?us-ascii?Q?mK9Ek3KmT4aZNQ8DCT7TTNTNEsjWInYs/mdR5p7WmIJZrBjJaFQckqK0/Dy+?=
 =?us-ascii?Q?/NuRh7kdh/63f9OlMxiX9Yrwc2SrGsP71n4Y1vvFjduymovvXi5mPof5nWTb?=
 =?us-ascii?Q?dTxEWj/yO6Gl9qFQX4sLaku7GzMgvIiovK0+bjg6S1jmwyznKHmxeMd4Kess?=
 =?us-ascii?Q?LOUnSTM6uHKTChBxLjcc1wKqRwxla9swMcOoPiEbIoRIf8EXPvxLiAbigN6R?=
 =?us-ascii?Q?Zarmt2GSRr550PUPiuDUwPS1fKCDx4buRYOM5LIITTSGyhbSrKQ0k8XEVmGu?=
 =?us-ascii?Q?5PDSQ5zOLkh5lKzIt0pdz2WMPq42UyeJPma5PtfjL/G7acZPcQPIUWMY8X0R?=
 =?us-ascii?Q?9cCIM2g63eSYs6BQLjE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:26.2067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbf6991-f002-4480-8dc8-08de078fe096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

To support nested translation, the nest parent domain is allocated with
IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
table for stage 2 (i.e. GPA->SPA).

Also, only support nest parent domain on AMD system, which can support
the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
order to program DTE[GCR3 Table Root Pointer] with the GPA.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9226edd8af69..c34604cf1811 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -107,6 +107,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e0bfcda678a8..e489e360bb77 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2584,6 +2584,14 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	return &domain->domain;
 }
 
+static inline bool is_nest_parent_supported(u32 flags)
+{
+	/* Only allow nest parent when these features are supported */
+	return check_feature(FEATURE_GT) &&
+	       check_feature(FEATURE_GIOSUP) &&
+	       check_feature2(FEATURE_GCR3TRPMODE);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				    const struct iommu_user_data *user_data)
@@ -2591,16 +2599,28 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-						IOMMU_HWPT_ALLOC_PASID;
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if ((flags & ~supported_flags) || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
-		/* Allocate domain with v1 page table for dirty tracking */
-		if (!amd_iommu_hd_support(iommu))
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		/*
+		 * Allocate domain with v1 page table for dirty tracking
+		 * and/or Nest parent.
+		 */
+		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+		    !amd_iommu_hd_support(iommu))
+			break;
+
+		if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+		    !is_nest_parent_supported(flags))
 			break;
+
 		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
-- 
2.34.1

