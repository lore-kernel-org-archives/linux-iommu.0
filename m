Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D41865E0
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271101; cv=fail; b=k8D+uq554Fc4ULIJvTHYPu8Y/bQ3pJPoL0uyTXikuqoth/LreAOLY49PGB+yqcoJyoXej6Ey8lYtRX5o31sUTd8d48voECUipazqThP5SufFSaIyFVfOIr7+uCNyp3rV9lDfduyO8eLH0XnERjlHO0trffOy2iUfr48Ldwfd3IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271101; c=relaxed/simple;
	bh=wVoWtyJ4Zlq0rB/nOPnMVEoPh1RIzQy84GVY9twyjog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9xfo1Q1vlfCP92nt3D5c4VIvTZxcaJkS2QH1tFJBCkR/q/R2KyRHc1xdu6qo1to3qKO9s2ErbOL3y3l4+saGmN6R5yYd3okreSp64dqqvxTtsWhoDF37b68WMRPIJo6SoVSTBVfxKciixJrj+o4Add6zeWQp5wnk/zzMOq8I1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nc7EboQe; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nc7EboQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0Y4zj33M1Ml4AcYm1EJDOwETYYFZUAABnAJaAAujsbSHXp5gyE2QORU0Fpwuo+gqZ6d1RHmDlJftPhVrqOHqrUvfgAi32gmhy9r2L0cf1w/rcf+eoovlxzox1BK1RE5jlNdyX+FZUD9zTYGhdU851SfzQrj8d/T3mtYfmbMjIwKzJBuzAW1iElo6Ianne5yOXe5RjSdLziRcZCELJFUyjPZ1Roi2vHH4UwwQMT8mW+qSEV42VvYYX6NYLCdljvHBBTBg0ROfuudjCJqg0qpFl5wMDvypgsdVWDcHp3+IhxFkoEr1TPQ+sRs71EIAnolBeUVrzJR9pZKIXR2mZnYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dUdZdJbxBeN8Oy5CFbhz9MtC3jpKcaWgKqyMSoKsZE=;
 b=af5jEzVIQIRAJe3JY2iuK4hOOBf21fH68WbMPR2paRv2WH1axAg0er64ZYkpSsMekTzjYHosIg77U8vlDjVrpOjLuUVdiqX1zcA+FchEKujLQcEMNomdcP8YT1eq2RqlO+Pf4ExzwXWSjiASQV2gfM5o048pqfnp7DiSYyYPC689YqrbUVS4zyFn6F7Mfegph/MGJeXcAdZiVog8tomBFGaqugCp1JL4ZMSMDlh0I4zCAc+PWh7LH9F8DwrKixK0+PXm5/UaUlkTc8FooSj1N6NhNW44WUDDtxaMlYmFRMw9qYb4nrfKvGwUCjpEt0tZYLZHxqyX/VxgCqgLznyz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dUdZdJbxBeN8Oy5CFbhz9MtC3jpKcaWgKqyMSoKsZE=;
 b=nc7EboQeJlu/QHhmz3SXJQp1LVpaUINmzllFVHfW97rMAtto0MMP9iWEFUajeLlSBCYkV2vSqaD+VNTNFyjSXis8/fMqGrJSlMiaiBpN5GLNW9a1mn8TJnfk9ReqWKv3/QNBV1IEegqxdOICOrbsL1ldNSXwrm0nsbmJ7sxgE5g=
Received: from BL1PR13CA0424.namprd13.prod.outlook.com (2603:10b6:208:2c3::9)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Wed, 30 Oct
 2024 06:51:30 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::76) by BL1PR13CA0424.outlook.office365.com
 (2603:10b6:208:2c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:51:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:51:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 11/12] iommu/amd: Add ops->release_domain
Date: Wed, 30 Oct 2024 06:35:55 +0000
Message-ID: <20241030063556.6104-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fcdda4-9171-4849-0649-08dcf8af48cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOY4PJUgdwgsGsyUsNTbclj8e/nkwjaS2wueT7PyeLDhSw1NgYNXCXLOw/LH?=
 =?us-ascii?Q?NcVJuuvXPglRM0qpKDhmMErhG/OHRvWyv3+sZPr/mkYrm/+m3jXsbPrnweyf?=
 =?us-ascii?Q?dU0ZewARI/k2wHRDcKenAYuo4Qo2a48L6ExU9CJHMuMd3GhqiqHhQoKuUrNL?=
 =?us-ascii?Q?usJ+W4rRX51sfgrejJMVHlEzIcSX/uKALvrfMRYVJhaW6i7FqbPK+xn62qOm?=
 =?us-ascii?Q?XmQxtxiyvwKBUgDyEUl/luAn5ZfBBpG4zWG0dYw3sLov1ZnSWBTAud7j3wgI?=
 =?us-ascii?Q?9TlNgclnbWgGnWgE9GM/or8BFDjZoSql1s8oXqmG66RZ9/ZheJRmdnFWmR6l?=
 =?us-ascii?Q?4Ms1D5adMcSth5LUFZCmhLsymPFpYxUGLIgQ3b6jOKveCiunCjZK//WqU6Wz?=
 =?us-ascii?Q?tJNhh2yJNDvBY1ETLoj74XvBdmM7ue8/2RdxS5PYN4VGzmQci527JaaouAts?=
 =?us-ascii?Q?XUitWRvI0emEWOe7EIcEJZJuSbz0YAHspEmIyTrhTXoOonPlX6IiTIr1394T?=
 =?us-ascii?Q?taWLzGlAxAw6gN7RqloEz+ahLYTXAk7NeIaDnO1IZe4p3MMEIKL6J+wMSvIL?=
 =?us-ascii?Q?fzLzuxHkgRxnzynCaDvBbQUtCEyMIqt9aNPtwf7rwqidBFvelun5Nx2qhFqN?=
 =?us-ascii?Q?h2lt53GmT72unw95ZlgavvHqXxS/ZRu5SR8vfaLBRPI6CUSndmuCap+UiBIW?=
 =?us-ascii?Q?3+KRaz4AgoRSAEzWEsOi9icAbC7q/QG3u4MyXIOCJ5ms4eHMQ7gzGvOBN8OW?=
 =?us-ascii?Q?OG5zSl4AMKZcyQLa/6vTOFjY6gsF8hGJzR+wyi7FNX+i+RvuVtn9Z8mqiBYY?=
 =?us-ascii?Q?bZsrtFa3Zl8+XjVj6wdjF7wIyXcXzdYbFW5GK4wyvPB8iY3HtLy/T6wKyzea?=
 =?us-ascii?Q?ccuWc4Dh6VnthXZwTKLdvt1l/nccMnbsrIingbjgAykeeg7n9WoIggx+NonK?=
 =?us-ascii?Q?P19TkyXX8H6QHNPO1n2bTn+bk8n5hrBFKmJ6FmMwP9DoFmyMsnPf8yd/H1wk?=
 =?us-ascii?Q?N4wxMMnry9HdlvZ9hN1QHLT/4OamRa0zT+AlboAXL8A608Ewo9AkSeVAgFCQ?=
 =?us-ascii?Q?HdPXOStV93VQW2bAAiYBv8xK0O4EEYNC8H+aPIuvkRXwGTkk75QH7cfqYHZp?=
 =?us-ascii?Q?X1fcL1Ys26/md0j1HgrueRL7riQ2kjLn4lznwJYMGA937CxkFij5c1FyfqAj?=
 =?us-ascii?Q?gi3fFFe4D8+5fkCaYMlCdp93xREgZeXis9qFCyvvgwK5DfuPzhMu8X5dZCRz?=
 =?us-ascii?Q?fra6H7NUBLkb9FLErYSl6qOMoyNas1YrEpdkHkHLFKvoOmc8D9PzraQnCUVD?=
 =?us-ascii?Q?Vnw8bjfU0WWXR/Xk/GHtHkkvVr2cDkGbItR6W3Oj6hJrjk4O760QRqQqiMer?=
 =?us-ascii?Q?fQz0zLuj/9/2HdrJRarfQ0N4TO/J3MYV3TM4JqVelCX4r5lMOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:51:30.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fcdda4-9171-4849-0649-08dcf8af48cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271

In release path, remove device from existing domain and attach it to
blocked domain. So that all DMAs from device is blocked.

Note that soon blocked_domain will support other ops like
set_dev_pasid() but release_domain supports only attach_dev ops.
Hence added separate 'release_domain' variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c6f5130088e0..1186c4ae9a57 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2515,6 +2515,14 @@ void amd_iommu_init_identity_domain(void)
 	protection_domain_init(&identity_domain, NUMA_NO_NODE);
 }
 
+/* Same as blocked domain except it supports only ops->attach_dev() */
+static struct iommu_domain release_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev     = blocked_domain_attach_device,
+	}
+};
+
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2894,6 +2902,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
+	.release_domain = &release_domain,
 	.identity_domain = &identity_domain.domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
-- 
2.31.1

