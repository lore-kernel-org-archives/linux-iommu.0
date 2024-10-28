Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249D161320
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108388; cv=fail; b=IEFP7QxsNnBr9+F/NXTmuwUy12kIUuWzIFx9T4uAygOM0yBh1ztJNZS4jqjkYooW73oC3dSlFkGLHBnzEB9N8RsNAcJeBEp2hz/YyMuCU/42yquCUInedvPS5YeDOD1YmUWXfoZqq/+oz0fNJd/XdmdRe1QAV4fSJJQVT2ORI50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108388; c=relaxed/simple;
	bh=rDu3DPQTNH3GvnVPjieiyeCUOurQtFpjs9kA9+ercaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stDdHcABwqPEDrR+wYi/X7hYMrleuGhemFA7EoLU4rSDjFJjFvllBwDKjyHUrIntxS/9azwMaxRWMG8GxeAY7q2IF+IYDDszFQtmnMJVa7o3Va2/nhV4oKkkKgrmDfuf17Hm4tM/nvM8OZLt/qMDUTr/kUnyRVuyPYhfT0MktLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4yz1mL9r; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4yz1mL9r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxiuwaacBAtgQr7XqPmtHW4mH5c9kSw4KExHh/fhSdj1PlN0kpkGk6iZqVHmxB6J2WT2aHmhAQEYc5+1HIIVeiu/RwxY9cj1kXr8k6yIo6vMLiAk74VK3NAlp9UCEjt9bfM7e1eyX7KjGoohCBL/u5PmR90SMS8kDxS+NAwmxZPQnSHDCnOJFyJlDcotkDz1Gy3gnBzS4bxaqD0UbTvB+HR+Zc4OFPZd2aRkQfRjJPAJZlpC6HyND97deayd4SdQSJPcJfcw/rPWNyxtaCvbQ94NtXro/13lnpUdZe/Id84Guwi1zFvU2ooF2NiNpgH2UPsfz8RRdZ4tmIhjRXgt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlzsKIEQk7FLEEm/GTGLjtIWFJxIPipMqsB4DelvUcg=;
 b=Vz2Zvl3dsPUAiTXDfIEHQVE8EivQwcoO98zXGkEd9ZOmT5K7tQK5sJ9CL8EFG2dUMCKVS+met1CVkpNHg3c/puXSYDjJ+fQ77B5Qm3Ol/uJPeU8GjRLGh1Tb0JpPIWD+9crJ1Yq25oj5b1itCMiNoqx08BT/AILOrNTe7g76S26Bpy3VZhqfmO9eBsptqir944IWwxZckdXb4c8c5s/0NjMEBBggF5YNR/Ddhsy7kuC4K31R6U1HmQLSQJxxx2/jvlxpeWwQw5RFRkG5/kB7tkj9JIhDwrndbEL3wtpsICf3szbffnKYLdb+u6NvyAhO2dNrX27paWdUmNl1OC0MyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlzsKIEQk7FLEEm/GTGLjtIWFJxIPipMqsB4DelvUcg=;
 b=4yz1mL9rLZ4TH00/7nbVcEpzyA0+DA89fGcdPKSN+XQmUE2JDAtmcK4cKj6JFsHc26rgtG0nLJJvr1q5pkmxH3FHS7FyBagzbpTuBHy1Ff87cOLB9o4o9L66iPDf3P6iZXq8ItZhi18kz9JT5IQe+Rk6rRXI0GgQZFhpxAVn9WY=
Received: from BY5PR17CA0012.namprd17.prod.outlook.com (2603:10b6:a03:1b8::25)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 09:39:43 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::cf) by BY5PR17CA0012.outlook.office365.com
 (2603:10b6:a03:1b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 09:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:39:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:39:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID capable domain
Date: Mon, 28 Oct 2024 09:38:02 +0000
Message-ID: <20241028093810.5901-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4f5011-50b3-4b08-f13b-08dcf73473c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YLFDCC3oiQoaV35njQ8mAsuVrVZaOiN2tUaHOuQn11V3OpmcZ8tGW/gKKb/?=
 =?us-ascii?Q?Irk+M1FqFBQG/ew6tIZUlvLa2AVnkNLhmUeEiRF2HD6o4MsFGx6fMjMBWgqY?=
 =?us-ascii?Q?5AiXuR83LKC6puQbbgOHxP6RKkG9iU1uUOYBAe4hQBRB2CIuYJRfV5ka9Nur?=
 =?us-ascii?Q?X5+PyyC4Aw2H8krKKKkB+yDgQtKtMbOErAf8a2VbUePezuUNny6WGM0DtfSr?=
 =?us-ascii?Q?YU4Lxtd87lCl+/U70rPurjfK7xQtaBvdqcaTfHOwkIP2sueCHIfVTSifipC5?=
 =?us-ascii?Q?vnU8Qq+4DcucSPSeBO4ZYRq1cQFTVEDF89HOY1ff9aAq8NoHuMWanT12f8ES?=
 =?us-ascii?Q?NV1kSBBUIkG+YUBJpFTUf3leGDWdAxQ/F5vRtQf8TGt1Qa0G4AhV1B9aeCzF?=
 =?us-ascii?Q?XNGYyqYo36QwJf0/lm8YmNovKptTJBB7ORvCbylwpUw3RhtUZ8EQ/9sgHFlF?=
 =?us-ascii?Q?9jMtUk29QUrwKeKaxkgtQSJr+E6/FRads3nLqlkCj3cRu7vcqF5ZT5cOFtsr?=
 =?us-ascii?Q?I0KkhpEB5+jPBJpNfyR1sGq7NOcKUI60CrQ5beyByS1a9k35it8B3C0p1n91?=
 =?us-ascii?Q?VIjHM1hNo9kqKUKMNc9XsTqoCCpq0+rGwR+sZlFnL1Er5jVSKGjiDkbCHDSt?=
 =?us-ascii?Q?zTPUW2dJUt4gH0L/+/QONLX20hbSgSzE7++g4gOYFQotXyL5sxNSMM0tr8Dl?=
 =?us-ascii?Q?88+94RwInp3HE4al740qvv32tAjPvQzJmGCQ+R5iy4IeW2443lu2KICzTQW6?=
 =?us-ascii?Q?C8qc9WqMuwpmf35iJKXJskg6aB2S2UBeVH75vjWryCW0KBEBxdQKm9OXpN1o?=
 =?us-ascii?Q?DIorvY6wwQh5+Qb5Qu9kbRQ/iqS2sIo656Ad1gfGTZEuTp587jEfMq2iDszC?=
 =?us-ascii?Q?G6eRedaIrIMWW2CI1YLJYiKJ6Z7j9mGhI5sfdsSM4o3YDp7x++OlRx7Q58YL?=
 =?us-ascii?Q?M2exqqllrsdSxHLSd7zaManoNmN18xWIpj68oTlcCrVZiYfWnukAPAxpHCO+?=
 =?us-ascii?Q?sapd7VgcM4wPoNzCrDbo+nRCVeCH3eMOspdU2wz+tIslI9sJ7jszka546BGB?=
 =?us-ascii?Q?f3yD7PdlXJ79MaQqUF37XYCltuZ6IRu3OffLEgWON8LJzEOTzKDxiwy27TUl?=
 =?us-ascii?Q?mlqHipCvEy3yKMJ7WAqGQvAjG/P8a3OlLgFofZ5G8ODS4PQfaZq8vKt19BWC?=
 =?us-ascii?Q?Mjj+I5GocWqCl4dkw0yiSFMydf3DxViQp+d8Fwkvzp+yZ0InXGaYj5inTn9W?=
 =?us-ascii?Q?w+HatXOBm85jDDorzLyao3HZ9Vy2A1xEDTdWNPiSlNsC9HIR1wIz3E3PJAzu?=
 =?us-ascii?Q?KlXrYnBwkgvXzZqssC1k0Mio81/NnVNUrJazPrUY8kGI/YkZD04LjlXBP9LE?=
 =?us-ascii?Q?hTDgepcKNZniKtPDii8p6KH2p+3aNz5ruwv+jQuzlIMWpQQWuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:39:43.0695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4f5011-50b3-4b08-f13b-08dcf73473c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572

Core layer is modified to call domain_alloc_user() to allocate PASID
capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
PASID capable domain based on the 'flags' parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..8a193141f003 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3084,7 +3084,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+					IOMMU_HWPT_ALLOC_PASID;
 	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
@@ -3093,6 +3094,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 	if (parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (flags & IOMMU_HWPT_ALLOC_PASID)
+		return arm_smmu_domain_alloc_paging(dev);
+
 	smmu_domain = arm_smmu_domain_alloc();
 	if (IS_ERR(smmu_domain))
 		return ERR_CAST(smmu_domain);
-- 
2.31.1

