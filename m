Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7522D4C5
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017624; cv=fail; b=JkB8XeVVMVac48vILFVfMmZvVl+9+9PUdEx5vl6mT3j6rofwq4Vq+Ub2eQNmSNvobUqW1HO+ub4EefHAXYqBiH+AuXnu30Ex3/R4i1oMc6WbqN6jlAbRFFF7X/UBoeaw/NKypPzTqvC+IS7X/GCzdCq4DFkVo28Xm1YiTsxo9+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017624; c=relaxed/simple;
	bh=OBW3ydhjxleRyHxisJVpOZKBX/fC5JIGrBrcuGCnI0g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GxepQhTeqotku4H7mUyPlW4BuHYn0B49YkXmu7DORjxlVoqJPQkbYaZiiunh+DMSm31/U9o/3nY7SpCzltCoRwMeq10a42MJm/V/ILG9ha2f8SWBaeo+DK1jmq0SfVlnlXN8t4t+khM/UdPgCXDtUJNhSBesBX2jB00glKZK3gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mdip1T59; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mdip1T59"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYBbW7M8eW2S64fRB/IwaIabKf+LXAQzbPZx6NTwQI65a9TFh5N6hwvzzlqMAyE8diZ+CmWLm34rsQdNcjWbzX6rO7uqEtx615N7t3N+ejqLHEgBjMNd/C+AL9TlYpPgrn9cj9CvM1qI8B5P7VpJrjoTsgbOw2cxhcMb495UG/RYdbptHJIZeFCrxPF5FLRd4EaaL1L4LAkWKGijyLg1S9/fP7jIVxwOXxUHFHuYRg8Todr7nuZ7q+9jzg9brErqGKXUBwQXaGNYUChQN8InHYKM7uxjuFzfS2JKKz9lRbqeKbxkPMAvTZPc0X8SxdvVQEoED1QEU/8Y1DQJwRuIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cswgiep4z4orh2z7M/pYgU2GsI+w5FOuHc3goRNqWgY=;
 b=fm760kK3LYNDm8sIv1Psgvjrk2ZlF+NU637QPTPJesbaUsBri7X+unOoblcarSJ7tsdvwHXSdu+Uy8Ftd277AVvLmALX687Ym4L7Kvy+zYNf/rjIi6qBKSmpYvjLvTpH8DalPmibaFYEg0cj/QcxxKGsnjVr/iAEGv+tTQp6mNJInDmxeK7PszGH6n0OYw3dpwpmaEEpWnYb2pCaBM3PcJMI0a/Bv8R63AXKBof0NO3VxRSz4xUUk9FpxM41SF7Oh4F7tZZRB2jEh69QrJREeV3tkseHXTlrn6KUh/Vr3KgIWa+r+cz7vEEOUl/Dh1K7iIvQUzxN4e2doJ5iRbhu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cswgiep4z4orh2z7M/pYgU2GsI+w5FOuHc3goRNqWgY=;
 b=Mdip1T599O36Y2B6jCCFbfzZ52kdArkkjptoNnR6Dg3WG0fLyFldt9HKm94xXGDnZr/7fkFr0yhH9Bnp4nergnpLV2V9FjwNDYL4kzhgb1sX6eNz/PFY5LjyZKxvDPDrBOSELKeQIbZBBy2Pz/lC6/qK6iyLDz+ji060c3hPF0M=
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 06:13:36 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::95) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 06:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 06:13:36 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 01:13:33 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] iommu/amd: Support for HATdis and HATS features
Date: Wed, 4 Jun 2025 06:13:23 +0000
Message-ID: <cover.1749016436.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b56746-5fcd-41e5-1ba2-08dda32ef0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9h+f71QDZohl+HuBSJAEF2OOJCPQkftujqllKsWC2GmnxnVIpObHgD384p4?=
 =?us-ascii?Q?m2SDIuesQxefzuDMvPj062wuIWIjTr78pGJ17KcbUD14lP92QQjfN+AfnKC+?=
 =?us-ascii?Q?GCw5pgu+WlHwf/1rEYGPa8K0JgUyk97BqedWV2fOZNJ9zMzTD4Z4P52o9SwX?=
 =?us-ascii?Q?uKNxt3NuQ+NCuPHEW+z7YPDM8vgOkt1OQt0A+gyX/ti1p9INWU/dk6fmsxCi?=
 =?us-ascii?Q?LDAXEmnPICv9EOP7g0q9aViGpokCon1k/Zs2fJHlxwCZm8rS4nAl/sIyEFbx?=
 =?us-ascii?Q?P2XtcGbuOkowddakQxmm8whjySEE01A+JJUWIUvLlBvYeF0EvfpMfRC8ajH3?=
 =?us-ascii?Q?hTLTP/+bQ4ex4sUwfdK/GM+HEpr9xEe0ptkHosbAk8ZLKINW8Vwg57PgELh2?=
 =?us-ascii?Q?mr71a2JRqpA/A7egS1aFeUPpbDbmHX2MKTBbNudURnnEhSPAb84tzNNeIRjE?=
 =?us-ascii?Q?6WHyRmbYmkwo7ozGtS1QuGgNMuwun1PY9gpHhvulkjrQp/rOzkJp8yhUEwH9?=
 =?us-ascii?Q?IpdsCq7MxJGjS3DH8yEofqXBd5dtixcFVeq98Mu1LtgB1uGHnj3kphfYV/Km?=
 =?us-ascii?Q?xP0oIhLSW0vezXCSJ4hfiYg1343LKlIECjVxWzuvq4W99aqDCr2B4AVh+r68?=
 =?us-ascii?Q?QECLgBvIc8gY9jgI777Z3SYOVahvul7Fmi5ZzAmprWASRkorAPPdvMRNUeqS?=
 =?us-ascii?Q?lPaOKz+RiQ4c51ptPRCGfIZo3A4uH5nwrh9b5UNMXXGPRkxLAVwXdHqv+ZaI?=
 =?us-ascii?Q?+MnTEOJoWL45W8z6oluyeM5F95wU/wGbOJnhUK3mu1opsJr3G3GG0xPu19Zs?=
 =?us-ascii?Q?xAPWOY/O/hBmclJ3gVYuGWDfYiLpxkF+XDUR+WCAPLWvI+KIjF7t3SC9qpEQ?=
 =?us-ascii?Q?NlJNSTSx8eZPMYu3xktNZ4PuBAP0YuZeiV80Vx++KLt9YTdHuOcSltK9iazi?=
 =?us-ascii?Q?7waW1GFqwYORqupOO20Pux6IOGGALVqBrMcbqskHbRmR+i63QhSW5UALeidI?=
 =?us-ascii?Q?4pv1PEE5z9FjLIPVwdzNimDIuQAk3ozrK4se1ybXRGaw7uq/NOTcDL74Eryr?=
 =?us-ascii?Q?4tyrPEFkBa0JwSZXVS7GOMISDlCX1azXg1HQDIYNzL1GzmnRGetZ7Rxjajj3?=
 =?us-ascii?Q?GJd6rmFtAt2QBI1Niyh/lBdIh+VU1KxfeClfwsy3tSS/h96t6jsCMkhxZuD/?=
 =?us-ascii?Q?mnTIKkDLDbMSq+tkQ4UzF/a7pHSFvoeHp2kNCRHUDOJ+CPYXhV9QzdZCRLgm?=
 =?us-ascii?Q?zUhX1yNqXO+32xZAnsHVRxxMcBYOqlKETAG4whSCUMbBkGlischf2QUB49cv?=
 =?us-ascii?Q?NivRr/N2B1AuVkbH5ViqjTkJLJ9YCAz0l4JFxRgwK9xr6Wz9f/IQWf0wAKWL?=
 =?us-ascii?Q?/5pgxFSL+IVeJdQ7LcP/IkpCH26j0ComWhtTGX23YrZAWYSLewdlz+w9y0um?=
 =?us-ascii?Q?05P5DmzVFlVXmR0TTgD51HxqRr/q1bYZ9zC9k0XMP8GCDzsamYdXV451+/za?=
 =?us-ascii?Q?rmRRkZTuR09QZ04uBVebWH3Y7hb+dBPhrYJ3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 06:13:36.2805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b56746-5fcd-41e5-1ba2-08dda32ef0fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

This series comprises two features:

HATDis: When host address translation is not supported by the IOMMU,
the IVHD->attr[HATDis] bit is set. For instance, QEMU emulated vIOMMU
does not support dma tranlation for VFIO passthrough device.
Support has been added to check this bit and switch to guest page table 
mode, if supported. This feature is useful for cases where only interrupt
remapping is required.

EFR[HATS]: These bits indicate the maximum level supported for host page table
by the IOMMU. Modifications have been made to adjust the maximum host page table
level, starting with level 4. If these bits are set to 11b, the driver will
attempt to use the guest page table.

If guest page table mode is not supported, the driver will fail to probe
devices for DMA translations.
The interrupt remapping will continue to be supported.

---
v4:
- Relocate sysfs PD_MODE_NONE check case after iommu_device_register()
  along with return check.
v3:
- Add check before populating sysfs entries for iommu groups.
v2:
- Addressed comments from Vasant:
	- Added/Modified comments and logs.
	- Removed v1 page table assignment hunk.

Ankit Soni (2):
  iommu/amd: Add HATDis feature support
  iommu/amd: Add efr[HATS] max v1 page table level

 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  7 ++++-
 drivers/iommu/amd/init.c            | 47 +++++++++++++++++++++++++++--
 drivers/iommu/amd/io_pgtable.c      |  4 +--
 drivers/iommu/amd/iommu.c           | 15 ++++++++-
 5 files changed, 69 insertions(+), 6 deletions(-)

-- 
2.43.0

