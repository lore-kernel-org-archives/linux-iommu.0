Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD2266B61
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480849; cv=fail; b=CxPr6hy7U+QBFNMh8ykYOcJ8csTgMwiJo/wtuSRsdJQ3VwUa808bIrciBsd86P23gDmM8x3j7VS4jXUowjYehm1Zitku1ciIUy13IVtoHFmiavhsjjK+/4+wpLP6XiPUZnykbMonIqTWf+J+1yZhrmxzPPMGES8wZ2+4VtpRcRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480849; c=relaxed/simple;
	bh=7CyA78k0lRlrsV45GfhL/ypiYgOyidcOSj6z+vZ4T2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TDBc8MuEx68NxglaSgINmsePCEoLP3+7eJxRRxzMMkoWF+60CaVseT7ikdHPFzTknX35mbqSZYCFmGDnkwcyI1MYesZ1bVA5S/ncWOo8kAkeD3YY5P1FiWkaYIEMK42M2dcih9eBN6K9VUI9/HwD47nuX83u5pnPGdC0RnmYQrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFNPIMbZ; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFNPIMbZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3BDbq54Y1WQnrJhjMVA+GVqVNFV+D/noq3FjwEAoE0lM9rK8oFMRkGxMOoen/CVWagOs/lddaHT9PYTrk6YBf+E87JPUJx5AilLbu7ghD9ojbCBNqwd68rQ33pBHWUOxY0lGRaGX6CRkWWT1yIbZzy99CRnJHUST7zIYkZHZLQOxRILoIm+z09pFWyvfX/E/tg+L7MqNxJXY+k2dUoQi7d5HC1+lMj7U/yBtFzSNDwKX3vKDN7ELohF3z5b2wJRJTTfpqoR3ja0nzVcfnUEhOo/89w7Frfio8Dmkjj31oW5AlYGgq7DX/1jqEe6FUvY8S31JlFmX0JHvbQnR+Uvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XhOPmtjzHQ+t6cKGo2HBMqXGBggRWUwN/AEa9lgRv0=;
 b=QcloJ0s7JjWQsHsNFfrbADPtD3UAQiEkw0LfcxH32Z6YN21n3JdExye+8tf5fIzlxvdIoNe5K7qmm15ncFtA5oYMc/wfzSYEjaUAboL4M1LKVQM9krk7nQN8uBHCvmpeEKgdJCBN6KdLc+oEHa5B+LQlbNwnN2gUW8ZYD6vr1iLkDDm3tXull8rZWmsIbHKtpI5SEcnecE2OJj8RgwnXUX2dNAY+wQZNhulBrl8Xb2caQHRaOzUesnU3YSeLzeGTpsVseja6t6dXPLAwaUxJdfmpdfsqC4VPSS/J+X/SrQxrnqz4n2sPmuvJ9RKEePZIIhzsLR5fUT8xcwk6u8ZRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XhOPmtjzHQ+t6cKGo2HBMqXGBggRWUwN/AEa9lgRv0=;
 b=ZFNPIMbZ44ja/VhAHy2Z6Ej6ITier3rpGUSVqgvgXZaGeGiFDjfLBXBsFG4HCbROj9d2sjyOHEyPNppGdtrobMDsASYznyt+M7OU7cfr/AqzNltwkaTMUJ/UI/xSBz1xcsI/W9wXi+HjCgiD+upGqPhRDk+G7yx8QbogR8cpZl4=
Received: from SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::24)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.23; Tue, 25 Feb
 2025 10:54:05 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ca) by SA1P222CA0051.outlook.office365.com
 (2603:10b6:806:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 10:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 25 Feb 2025 10:54:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:54:02 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/7] iommu/amd: Trivial fixes
Date: Tue, 25 Feb 2025 10:53:38 +0000
Message-ID: <20250225105345.52143-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: cbef6153-de07-40e6-09d2-08dd558ab895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?688/f/lBsZffyB3Cma9+5hwKK8IROP/sDQrmo69X8Ihs7vMP6Whhsn9gm8W7?=
 =?us-ascii?Q?477k6q6RLtp0V2tnT2JYB8Q05leZrjaZngkygWEr3CuKPo6IEpRU2jwLqdaj?=
 =?us-ascii?Q?nAdwCAC9hK5gXFmw2Qrbuk4mc8QfHQIjwMXwsoijQwS9rEUjjFhT8GyY1o+r?=
 =?us-ascii?Q?7PSzZ+6nmv89rSLLYXzE4xnCgo4A0hrjOPGpwBTJ0MkjNgqYmWVUN9HhCG3x?=
 =?us-ascii?Q?Gr+GJd66qmANcbnimZ3ATiyu92lfVBCeZBDE9kF71le7EDLLc9XdXGUqEqdc?=
 =?us-ascii?Q?AKDMdJl0VhxDLhCT6fv+tzHTFbZeo4zjDPmXDQrAdKkjb7a9lGudFtnR9Bv2?=
 =?us-ascii?Q?bPvYADCOhtR7unZiaKco/7tvrWQQYPoSMGLjUQXvIa97zBBG6N7oA3PjIXco?=
 =?us-ascii?Q?HPREDh6gzWigebpibrCp/+kisfJJVTqOkEGsv3vUCQBSy3rnf1LyO1Hp6hfu?=
 =?us-ascii?Q?tOMouazwlPN7x9pZ4KLxius6l0G/J4b58UJHN03yYHVOloWqZPI21k2aZv+h?=
 =?us-ascii?Q?vGtUJLCfZrbNGaJMgWAbzPZnbqybHYcaxwXhmBpmRzspv2elbZSg/ZWNI0IE?=
 =?us-ascii?Q?L2hqnmRazMv5HLWGGIeRih7zs/6cvcX3BPvcGWLpzeXe/QnjqqmNtn4m6wFu?=
 =?us-ascii?Q?zu6/1kSoDA1Ilr1yb6FeBloYZ/d3dFTaNcOZDElvrZOcFa/w92yQbozEqxBV?=
 =?us-ascii?Q?0IVAJpXM/SHUmB7YqBoVxtvTUj8UbTllQG35kJiyZusYGUThTwFUgr4SKG4w?=
 =?us-ascii?Q?yUppIc60QTLm+jy2xiwsrXKQ6T09ckMyhnM1NkARxWn771+UE/8xpkxkCMiE?=
 =?us-ascii?Q?C5AZELsrqB2FekOaGX2jC0nGzAglebXSr8I1+BbovKjoXd1nPIjDU6HsTLLE?=
 =?us-ascii?Q?goMcswA5DMswK7cT/lxXx1Ihr/tDll9y/evomnhvYTU/RGAeNAUrakKOQ6UG?=
 =?us-ascii?Q?YKytrpJMjQKOtNtlvXSJOcu+NUoxmJgPA8F8kTkrfZFxLYsJgfJseVhcrEr0?=
 =?us-ascii?Q?UoOv6+Q9z4zNu/TycCUCjzCXc9FJY96PeK30of2dgYH8f9lUiCp6zu7NEpqM?=
 =?us-ascii?Q?R5c26r2W9HJKIS8v9EwVzySxp7ofBGQIZqe7ho0mtJNH4EDI8e4oaYVehAYz?=
 =?us-ascii?Q?TLK8YMypdt/XYgnlOo/BfZX9j8D7I3Q0IeoIIkKRhk3IXMeP+DTwY66sHsQD?=
 =?us-ascii?Q?uO5S2Biv3ZyZDGI7mSsR8Qq+1d7eVC2/qTV5lbGRxdYMWm7rHDiMJPPBpCE+?=
 =?us-ascii?Q?YcSog6PeEbg+TpzIb4o+8bqt72oIERoU3v3CxVdqq0jop1zTkVgkLBoEIBHb?=
 =?us-ascii?Q?kJ8Nwrj889HS4k9cBOOLnTbuZBc8x9jBxcEWQeZx1UOsSrdvmVHLBlRjWYQW?=
 =?us-ascii?Q?j32SHvGrV+kTu0vT+p2ZyOfWh3fAIIerSEBOBiK0T9zjmmSEm05ijel+hqJH?=
 =?us-ascii?Q?dsCCUQFesUHIqGDZ8hgWyI5YAn4CDF0mwCtI79cBB/9nUCR9kv4XJef5h7Ct?=
 =?us-ascii?Q?LFhvcQ9zXRfTiaI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:54:04.6165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbef6153-de07-40e6-09d2-08dd558ab895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

This series contains minor cleanup and trivial fixes.

base-commit: v6.14-rc3

Vasant Hegde (7):
  iommu/amd: Log IOMMU control register in event log path
  iommu/amd: Remove unused variable
  iommu/amd/pgtbl_v2: Improve error handling
  iommu/amd: Remove outdated comment
  iommu/amd: Fix header file
  iommu/amd: Remove unused forward declaration
  iommu/amd: Make protection_domain as static

 drivers/iommu/amd/amd_iommu.h       | 8 +++-----
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 drivers/iommu/amd/init.c            | 1 -
 drivers/iommu/amd/io_pgtable.c      | 7 -------
 drivers/iommu/amd/io_pgtable_v2.c   | 2 +-
 drivers/iommu/amd/iommu.c           | 6 ++++--
 drivers/iommu/amd/pasid.c           | 2 +-
 7 files changed, 9 insertions(+), 20 deletions(-)

-- 
2.31.1

