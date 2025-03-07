Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EA20C482
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341519; cv=fail; b=aFooDX/vmGSllEzvwHI8a7co2U31xVr6nzb4fbx1qndp4sDjkqqG/up6y38SgjUZqwH9sVHzKu+r8U0o0AdioaOaS4m2MOPkp5SwTSPZYh6aQKhgtwaZmmf+jXCrAtp9vvG6AsHats03HuQ4c/NY9zQOzgmcyOwyTcH/79UTgsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341519; c=relaxed/simple;
	bh=gwcSGCPblAbDN+FPG6x1Bvuq/q2dRPpxrXzu1LNfpXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhRdfh5mf8sBin9gVVzQ7P1jUG6nU3w/Ii/7iuVVfNWCbdd0iMMKl/uvgiyRPIJ1cmpOImn8/3cbpnkh3Injxji1oLlot2AcFbNfWLxWkZ2BeFKtI5+Hjc47DDsC+yOeX3cVyzkSC+2WlAO3V5PxZUTrRtegGOh5v/kq401PNjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nNo7RB20; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nNo7RB20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP4uK+wUQGyulg3ZeCg1bchAqquVk4u2LSQ6ngD+Idty3nHUJwpoUZdRWrhIwskhMESOSjWWHjqwBenakQkNt0QVRdDbqzowLAM9F0XTspCY0CniyUlrxodRPvPD1WaLs8O1GO+TpWe9q/49zgjxlUQtyd+g5TG2wOFij8zv/OlIyzCRA3yVW543E13aX06gH/01FCz1HDqtBFJbQktnfxQ1vyiSnaMBKQHVduEHGymeyIV+x9MUuxrZA5t3LTH2exfoF38V8/7XBSzBb+6YVOuJ/9ZUgZGCnLE3dq18xdu4RpXNINcJy86A46OEbc4U9CDxvoU2AKQwxHT1skt+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AdxwKybe2qk+jBfh6Kf+gMjFGWmVE66PwL8i9IoIUM=;
 b=LwIGYD0Nh7g9crVTok9nV8dKQzcjcJt5+d1mY8sAcXOi1bJvFky+biAQo8CWqvl33+eNpCcGwIuDQPiMD217tCXB+2/uoHahOEouClzQbkLVn/G+hB180/Ewuw+/XSdPWYEfedAF9LBdPxJ2g5RkBuXpmckSrrwjG3CIeufiuCQ5uCqfqjSRg5GwpeE20TYqZUDpjQzqjgKZ8WF+tG5pjgx9AVBI3abj/ddhHtHGEOHCdgsoCPbSYx533ZdbWQeEb0w629mB2PKkTOpBi+uJOmU1mjkvB8KqaJTMMKNnzVSl+AvRFPW7zQNF+89yPGSfi3iZ/Rb6/HnBGYyVfY3FhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AdxwKybe2qk+jBfh6Kf+gMjFGWmVE66PwL8i9IoIUM=;
 b=nNo7RB20g0meT6Usm8CpzNA+wjqAageSdaNn/ktpUOmYQiQhi9UKQM+2FLPCWjn9ZuXQFNYcZYwgxbj23kvDXnhV9vtQxY1ZO50jCzdLuxRtS8bW+BrUHLm7QqG9X9WuB6W1flo41xmd29Qi2JkzdcJx2XDBq7pwHKhOsJKXZdI=
Received: from SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 09:58:35 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5::4) by SJ0PR13CA0093.outlook.office365.com
 (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 09:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:58:34 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:58:30 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH 0/4] iommu/amd: Enable support for up to 2K interrupts per
Date: Fri, 7 Mar 2025 15:28:18 +0530
Message-ID: <20250307095822.2274-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 801d51d9-d79f-403e-cba6-08dd5d5e9fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nupw7zZS/7esR7Ok/5D/EqahMXMWDJAdtL34HiTdO9jrsdIaVtTefmKHnv0?=
 =?us-ascii?Q?O7K0z8skQwfRCyaKGebrDCTxZxH1URT+QUtTH2xcTNLWgOuk+4CIrGcmyOcG?=
 =?us-ascii?Q?M0Tj2mZWjHGGBE3ENxTrgaxiBcsNa9XxhYLk30N7CyHo6SXAALW8hUR573HX?=
 =?us-ascii?Q?yg5kTOTbOJZA4Dr9Ta1itZCz8pQS1Y/tn/Xr8Wa8EHBVEVLTH48wWHRIu+5C?=
 =?us-ascii?Q?k3LbUUVDZwRgJ6dhMmgJcqp1bj1Mi65NlC3+OxJXE1CWywIQJ/Z5da8QNHa9?=
 =?us-ascii?Q?LCdnPnWHVOTr5dGBEjl8xjrpile6APG8BfCH3cSRkhWY4D7UnWspdmu+cgA+?=
 =?us-ascii?Q?QouMesis5XQ+TOUNnWO1m5OzByROU4GHZV8aJyFVQ5b9IwWcUBt63SX8COPD?=
 =?us-ascii?Q?4yGYp5FghHUeXi9oshVhvhaO0X5Yf2L4Sapn2gJMd197vOUFUi3NCGf96gRp?=
 =?us-ascii?Q?tqe4X7Lccdn4H8TI+g0n1+ZI2vthIJF5LQ9tGvzUcSFUg9ZAEihvG3hKH+eB?=
 =?us-ascii?Q?mRwTveySxlGDz2dHYT0hYPqsdqG+56sMuqXMk81M0FEYxlUilDr33/E1j3JY?=
 =?us-ascii?Q?wZ37dIvxQrJ1xKnVcmCAJS+qnQy4dyOPa+3rWyL9SXgBpHGYbQM15w9aToXi?=
 =?us-ascii?Q?PdAig7w6/2QPTVRBOObQTorGxE2hQ2Vzc9XFjRK4weOq36IF4Zif6EZzjqof?=
 =?us-ascii?Q?4HcqlMFDkjD7aUr4CoKE63zifnf7Xji7PyangFbIlyRUNpKilMwJqbiZK9m6?=
 =?us-ascii?Q?czGgwdJMRChLI1RrLEf0AFwSt1c8Tak999+JBd2ysm/R6dCrnDTlT/T8RjDm?=
 =?us-ascii?Q?LtbqXVOYc4amXD88WkP3R6hOUvzZLMWfqSpZB0keI77QhWyQ7wCIEHwofP1/?=
 =?us-ascii?Q?Qvu8Qb/1sENBL9UTDnmyoYUtlPYYbjY9S/DihifmgadXne5uiyEN6bGoIr7a?=
 =?us-ascii?Q?OgGkvfacFVL/HItZYAy6rNefQBWiRSpKbOUNVNM7XcxCroPfceHpfh1B20Bh?=
 =?us-ascii?Q?wGnj2T9zNCh+O/ra5CCw9/+d+XROiI73lWM07SC//qi/f5QQgfPY1X7wyj19?=
 =?us-ascii?Q?nIEwE4Bt4UGj2RQRQnUKE6f5Wowr647/gPU/WLPaBnYpYFDHwL4oA4nyedw/?=
 =?us-ascii?Q?wperkFFGZb5IQIpjsUOY8CdmIkGtlsb6ezbdFY4q2QNZss+0gMq/2xMgLS7y?=
 =?us-ascii?Q?8wzamNmLEDB4N0nnnKPC8HOVG4avB83qIISLREKqk8RH3a0KEXy2ZfvngB2K?=
 =?us-ascii?Q?CZZxqxq10ox/gMx7QPyjpBdXwS8og7/CiFf+VPdPZZ4bLlFrph44OJysMUU0?=
 =?us-ascii?Q?lIVbtLu2ofcfhS9Y9PERZCXZKqOOby32gN3Ak+dNvA4x/o126CSKWPADVqcS?=
 =?us-ascii?Q?YfunS8SzOkEDSA9YmuFUOGhkiHkedT30nrUoZVhCY6dq0V6TC5Ny76jKZZCO?=
 =?us-ascii?Q?mGjTTowIoh98hEXlz2nrsQPmE6Gs7ja7KlPusfeQKsJKWZiYXHp0TWkuiZMS?=
 =?us-ascii?Q?bdyWoE75UY6qeS0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:58:34.3437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801d51d9-d79f-403e-cba6-08dd5d5e9fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

Newer versions of the AMD platform can support up to 2K interrupts per
function. This support can be enabled via field NumIntRemapMode in IOMMU
control register (MMIO offset 0x0018).

This series adds support to enable 2K interrupts per function on top of
v6.14-rc5.

Please see more details in [1]

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Kishon Vijay Abraham I (1):
  iommu/amd: Enable support for up to 2K interrupts per function

Sairaj Kodilkar (3):
  iommu/amd: Introduce generic function to set multibit feature value
  iommu/amd: Replace slab cache allocator with page allocator
  iommu/amd: Rename DTE_INTTABLEN* and MAX_IRQS_PER_TABLE macro

 drivers/iommu/amd/amd_iommu_types.h | 27 ++++++-----
 drivers/iommu/amd/init.c            | 65 +++++++++++---------------
 drivers/iommu/amd/iommu.c           | 72 +++++++++++++++++++++--------
 3 files changed, 94 insertions(+), 70 deletions(-)

-- 
2.34.1

