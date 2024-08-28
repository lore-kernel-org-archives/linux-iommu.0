Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3F15530C
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843460; cv=fail; b=JPqReeN/lD4TA3cwEjDZChPsogF4uV0D1bdavVRR3QiV+cuWDaamsrAI2ufub1U3JSHyWBVjSkRHNdTVsTXN1sF2I9jlOmnwFHzXP3YVE8D1I3jDqkMutlvg/dO02TrhL6Lqr5ZjzYEmbTZSpanTxQRTj2jsS15r7VlAoSORUJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843460; c=relaxed/simple;
	bh=QWzjhxx5IXggmcuLOJR9jLxLkquOb00pepDvwgaim08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NnkAZC5WTOAzlOJNI5k9hiimrGOjti3m/1EBaHuY2peS8ETSHMl+vYK+eEVrcPVMIjbo+fvuDE5PP6aH5QHdHbrmO++yA34h47Vz+g5sA3Lu2Xdv6v3IsV2k0Hjo/p7FW2yWgBiTKhzfsgpE2QAQnpZGu8wIeKdLHj3omX5LmJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1DdwWzS; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1DdwWzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDJ8Ge+qFRXjBnAawepPxmDomEahdJt/CHlD0z8rgCAY5Me5f+ScSb8YsNslhMkUzRlarpS3S3y9JXVidkkN9yRpiJoh7iGb4bdDz+oE6zdJpIsW3qD8VFst5iTnZ/VY03C6Ds0C6sUX4XhQiqeGNrgHH7Li4mn2L0E8A86V+hhHkyloNR6K+vn9ySHnMjV8xUCdSlk97YRI9Zd8ft3Jo57e99h/1ECrM9U3u50mOfXLJ0QtWtjV43xPH8Rifb7FdjrJ1gbN4XOtUZZkdZ8E7QDIPbyjw2wqHGssWDcVeT2FPrTVJbXWrmUNaVwe+hDfepICab5BY6HuAJ2rbTLchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q82GhS7/T4ebutfBczBDgGSTVorvQLYvW5sk8PLtAz0=;
 b=Walb//IXYcaVvjCy0qP/rYwBwEwGuGLiJfQp2j424noGtwey66qtzN4E3WSaMdwRf4cMdL24UPs0yem5jMYr3jkkLfqZ6p/x+dt8A89OUR2orJOVsW6+rX9FDdKm1I/7M3JVLVluwsmWHCnzsMUpyb2EtTKKB5ZPKho3POKHLajIUM788CcuUAUouMuUBbLyjtSCJnrS9uh+/sb1WEynu5Tsu6L4Amx2jO/7QbgYvAkUFv3rGzpS7yxwd//sr26/kPur++7+VIfXKtTdNmitOuz7dS7u/cQnVyCrawOANQ/2F1FzKNPst82hYOE9+w7zfRj6WCyoI8rg82dSph4lNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q82GhS7/T4ebutfBczBDgGSTVorvQLYvW5sk8PLtAz0=;
 b=L1DdwWzSFCfCB5NWvhFaMAL8XpASXgQ7AKv2/uv8ROyBRNFiDbxKmoesoobVu0K72HMOsjJAPaaYEYzsQYxPLebesbk4akoXLAxbw529+X0oPaR1cJTeYEiZdLD7/GfzDMPnO+WdcI92yTpupX6gFAkLpGYSHDWKfspjLz8rOBc=
Received: from SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 11:10:56 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f2) by SJ0PR13CA0102.outlook.office365.com
 (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Wed, 28 Aug 2024 11:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:10:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:10:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/8] iommu/amd: Misc cleanup and trivial fixes
Date: Wed, 28 Aug 2024 11:10:21 +0000
Message-ID: <20240828111029.5429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: ae20bff6-14b5-415b-e422-08dcc75216d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IMoUD7hdMdJBVH99nXDa2vy8DmbtcLjuQm28zJWIIXSQODm6S5sdHoWxjiuX?=
 =?us-ascii?Q?jnisoevOHgYm9A7RwpfSO69IOz5kVF2FuNMvEppbm4tvvBeE5dfBSqIDxE4k?=
 =?us-ascii?Q?NVqMOt1EXB9HaX1b3B4iqZ1zGfnyEsVXVkP0lTL2aFmyUpa9V8+Qyz4okn6L?=
 =?us-ascii?Q?6lUxhYP0wHSKj61Mi/9bOc/A6xG6zOciDGBtf1kxKpXm5Vo98Sv8eYLVmh8E?=
 =?us-ascii?Q?3TCjYRkarIPcID1ddcN7SslJYgcwCS3KBuMSZWA9KSeb3DfjurMM5AG96c/P?=
 =?us-ascii?Q?knl/8XDCvGdO+sT/qUYMViGmGetD7RxJ7CzhGHOl8GntKABTCfhGtVxMkoDk?=
 =?us-ascii?Q?bJEh8JkypluzWvS7cWwfIyr8xPdptsIbwG+rb6S9O7rQS+6ud3yBc0FzNYcW?=
 =?us-ascii?Q?nt0Ss1mE92wK84gZ+jAdqzKVhhS0z7IW6YyUIwDz/fvvhk2lCvFPdUT8jhra?=
 =?us-ascii?Q?SCcqSBhVsQAi5rTv+we47B8J4szGWsrHMPjWC0rvtj0RReeH5jCl2yCkcQYT?=
 =?us-ascii?Q?qY+bjVtb1yy1PDwV3NzyvEe1PCOMZ4D/Y1cIqTyOt36uXBsJ8bwF3NNk/cRx?=
 =?us-ascii?Q?wTbdK7CNS8Jk/28qsdyNYci7ayzLxN2YiheMV1NtH8You/7MhG0PaX93Eist?=
 =?us-ascii?Q?3uRGEg+j9jYAmkvWM8DyGVe7TJH9/b8O/lKI2p6oKCXbOTbfoSVh0+PpaCNL?=
 =?us-ascii?Q?xLYpkQYErQJOSfnAAqdbs5IZvkD5Nko1E53yZcuor8CeB7kf0zHxpayJFKXi?=
 =?us-ascii?Q?gJuDut/Z+C8/kqoFWMVd7fdyWcV5NGXivK+wS++o35dP3cdx29Tz0fcV+Bxj?=
 =?us-ascii?Q?IKTqCoztbHZR+5PRz3NqCa8jq+ODbKFTod+8Vw5QSNg5fgV+fUR8KQ/peWcd?=
 =?us-ascii?Q?gZYbjY9nGrQv2vdl0CUv6cXFzerZk/xQP/lew6YGM7x5axIkXvLY1m/gY3Ug?=
 =?us-ascii?Q?VmFQgHvNmO71bJg7UGzF2sSYVkhVpzF3l24K7fLqM5g+Y8CG9tyOvr4bY13I?=
 =?us-ascii?Q?1Piku9l2RZZI/Ne1egN+LuNr3Oa2KNi+bTZrrZ3hbPGZl1pKA0LfB+p2blrS?=
 =?us-ascii?Q?fPuUieii3BEcQoHFaVbdOAPB9LPHZJMhj4bWuvO2VH68/nzOB0+lHIZZMVFE?=
 =?us-ascii?Q?VQSv2GzTrq/8L2J+/EZhHUPJgE9xWK+7lUN7UoKrTbXwXEh0zF62PMKTgMlR?=
 =?us-ascii?Q?9GGS2vDdMtRXcBbhs3dyBM712gQlobyoGSukPjJ8E2ezj9vaHEZc0egxA1Bh?=
 =?us-ascii?Q?vUqHcFG1Y9Iu3X6edrT9U45YyeY8Q5s9YrVo3geMyq10ETAmpphz5ztFsMhP?=
 =?us-ascii?Q?sBODeMjypA1UTZiKjP5rRveBD9fEKGLCFy+stLdZ98FF4KWW1x0vnLQeE0OZ?=
 =?us-ascii?Q?R05bBn/apMRtT7vDvqIZjbDb8MtPJKU7npHkFjJ6aRFjOEMSR7oTA4+giR+i?=
 =?us-ascii?Q?8Kl7kIFh/n8flquONRbuR7kA90No8pin?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:10:56.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae20bff6-14b5-415b-e422-08dcc75216d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

This series contains misc cleanup and trivial fixes.

This series is based on top of iommu/next branch.

-Vasant

Vasant Hegde (8):
  iommu/amd: Update event log pointer as soon as processing is complete
  iommu/amd: Make amd_iommu_is_attach_deferred() static
  iommu/amd: Remove unused DTE_GCR3_INDEX_* macros
  iommu/amd: Handle error path in amd_iommu_probe_device()
  iommu/amd: Make amd_iommu_dev_flush_pasid_all() static
  iommu/amd: Make amd_iommu_domain_flush_complete() static
  iommu/amd: Rework amd_iommu_update_and_flush_device_table()
  iommu/amd: Make amd_iommu_dev_update_dte() static

 drivers/iommu/amd/amd_iommu.h       |  5 --
 drivers/iommu/amd/amd_iommu_types.h |  4 --
 drivers/iommu/amd/io_pgtable.c      |  1 -
 drivers/iommu/amd/iommu.c           | 87 ++++++++++++++---------------
 4 files changed, 41 insertions(+), 56 deletions(-)


base-commit: 0e922e0fecffdb8e0f5ea9c00754f65a17e5a535
-- 
2.31.1

