Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86521E3A4
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056967; cv=fail; b=hDDCMbGl/SnmcFrwpwJ+0kmbQycxGY0owsHQpwX4ktU88rfd9QrRVOYuyXnwva7DO00QeLG7uI0dZpEaZ1EKlzbO2qvfNgp/bScusvxuaSyK9rO0rhKyTrT/WJPjx44vn8s1KDwV1rkyZsBb9/vaQ4q9Zk3r0zNjGcmMlNinEUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056967; c=relaxed/simple;
	bh=WQDaE8qR9sGKe4BlOWSSMvHy17DQ/7QDgElQWv7QNCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6HNHIT8XGuwcHKQoiu4QKZ7N9VsE3SeK2VieknFp8kS+K9b/NdQkInPmpoRnBkJtM67NV6mSWpY0NIAtRby0nChAPp1nvxLqtx6lhVNtTJ48h3Q8dC2PHSxbZbBqjAIHUKPSW6lG2wxa4OHn7m+1NwOYVYm0PwaRLut7mqCcQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRPUdgr3; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRPUdgr3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvpAYIdFBxcIfcuIJKM7aSfgbJAgzf43SpeRDGT0t+HKGzOjE6DvQJq/g/BnEL/x2RNxSgQoXhNcaHMfTa3wLgEPp1QFbvWnCfNRnxb21rl10RAayrUmEyuy+euBCqyx0W1iP17RdT+dIni9dyw8WrFvnddVSw2wDCjWcg+0ezrt/O1FZzyBcT2yyWG7dAHTgNp7LfZa7BqlXksmLqHzlpk5XrQLNaAcnXiWBEGldpLB0UStk8unA1upKefq1HquwCUuyNDEzNImroM3d2J7jVv1g9zkApG29BGB9Tod3K1KAWqUlXdXfiOx+ZJSsrfA9LSMoIkxhwDPVK47GaN95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upgPdW68WxcZUygE6Kc58dViuCwAOrltNAydHz+sfk0=;
 b=pMnmQ3IKAGG8K1p3qrxqleCzgxZqIXGbvlkDSnqqAawV9MGHIwZIojy+nV/xymTKE8y9995wd2DGckgzPiM0Vjej7XVEf6aiLihDLTG0G5uEHCbpLS9//u/Z8L8628XJJktP3ns2jId4r31IQZjLXLyLzvZLNAiwPEhgyvvKPoJF7LeCHtUzdsTyXQnHN3ubro4VRjn+FGUetSmCcReZE2OIb/gV8Ou4ommnkPzJ3B2tjJW4N9N5T7OMIBUH/tDo4WUlajidRUhhLhTCYPfhO1jfRm1JVWwCvEFOcnOwlXZXREIhjSfBIhY65RVOJryyT4rwbjrysuSYluD4T6h35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upgPdW68WxcZUygE6Kc58dViuCwAOrltNAydHz+sfk0=;
 b=aRPUdgr3dEYrPDSCybajz11n/o2Ia9BPoBttscbdt6RD4f/YJ0+7cl3jwgv+A5IQ0IrLRmhKLpkLu0MWtBT4UGAhEPFpyAm4QmV3Qzf0t/dsKxbQEX9eryh53UhXtzDVNWm0T7ZnlM6mgJqy0hXTHfBvBuQ4KSFKXMniHpXMd1E=
Received: from MN2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:208:134::29)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:36:00 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::3c) by MN2PR16CA0016.outlook.office365.com
 (2603:10b6:208:134::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Wed, 16 Oct 2024 05:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:36:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:35:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 00/10] iommu/amd: Improve domain allocator and device attach code path
Date: Wed, 16 Oct 2024 05:34:51 +0000
Message-ID: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: ef277700-7429-49a8-e466-08dceda46add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2U5elyZp2TWyDu4pgkZ9gznhp1RF4K/ENmL+hVp5AOGSuAVnUegAlgsdjWG?=
 =?us-ascii?Q?atBPd/ZhN85HMyzjTjiWCgzGFKElS+pclTOsSx0hbmMXXTqnB0Oefm8OqbLj?=
 =?us-ascii?Q?GBj5DRd4ZzQGp72BxRvXxic7MEqZ7EgtW7tQyikX64LVeBSqH7dL/83rtfUK?=
 =?us-ascii?Q?JzKM/MPxbY2JDCAK/iuds0H93WDpIcI5/daWtm+KhGEo8Ao7uCK8SWl0N1T5?=
 =?us-ascii?Q?e4cOuTbfmt6PhfsOVAmFSEIRFIoEyVfFPKxOLtyXCQjNOJT488iC3xXwc1pI?=
 =?us-ascii?Q?S5nK3vH6cI1KeE4ByLiA3v4mb4Yi0ddYPcTwij0iKioBFyvKTpzle7gOzrvE?=
 =?us-ascii?Q?BqpKxv9WKK9apeT7G5oojaU3XT2YkA8I/EV1Qo5mJySTUIQVE11bE1qI4P0z?=
 =?us-ascii?Q?h8eiIZ/gmk1bi7O0LHA1rjtDFeF2yXQ30WAu5OAXx7+4dGK6v6Yd5oh6guI7?=
 =?us-ascii?Q?AEtDxHqNitwkWW68IRLRErKS3pLBq8GKxWMGKSprDt3SMG3uE0Y5q05Uxmoy?=
 =?us-ascii?Q?OX3UR9dY+wl8N6PyK7yyuBKg5CBw9EHxcAcbROtoCkKb+ngbh9TLWALyDAC1?=
 =?us-ascii?Q?szHgt2Uj/ln7znStR2k1hNOKG/hr8FJ1BLzi9CbeN6x8oVvewLHvuSxxPQfa?=
 =?us-ascii?Q?hNrdoFu1kFgDrxXiWpn1gg7AIvBqPdw/nHolZLdIukJaGIr4ijMvG7K/hkZO?=
 =?us-ascii?Q?HRIZVG+mdMkBlBQJz4UdP0KTikdM479HjYq7n4h7KjxNOUxrWLXv0WUPPIxT?=
 =?us-ascii?Q?PUjrKx3tYg2JMGS5k7yudBiIl0tDrmSR5vYalIvBL9egvB8n3vlrg5FF+yvg?=
 =?us-ascii?Q?fV90Xaas2gJfLih7O8Vo39OwBwQQI5vGqUu88dBoERubG6lVqncKf7jvXZq7?=
 =?us-ascii?Q?gB2UXvdKT9jZoTgFQoRiLps7CMhwUS0ANwn3wmo21aTlutiuYJIV46S4VFal?=
 =?us-ascii?Q?TtDhcSAL85/7vP/jD2UP7Q3c/o8UAzjC2t75k7xHLBkFKojJ2m04Ue1oV8gl?=
 =?us-ascii?Q?2712dhkNHHt4+mPD5twbZLYM6IRkFOPU/O46aiAuYgodQ47tvxD/gMZzqdxB?=
 =?us-ascii?Q?wAyujzxRK70TQf4SZDE+ajJ7rR/jXRaNVCqNzFAOAgj1LSAQCw36svfa0kKC?=
 =?us-ascii?Q?9xw1o93ClZG/lwtk+oA4bc7uH3ZstSHGN3L5d8vLlYSc0vXUVvQzW9+URND7?=
 =?us-ascii?Q?5yI1u/YRG8K8JUfwd72RL/EFLaxCItAoKHQBrXd4avPI5N/S1aVo24o3Qfqf?=
 =?us-ascii?Q?xQ34RhsfWvwzWChtO5Xc5w3jIw/P8EKxkTp1hdBTaV3BcEb/TGYflpOvvAJX?=
 =?us-ascii?Q?9j5zMTid72TV+YYhvIZD8OE9Q3fgYwWBPnklN30DH0jHazqfcwZUpaT3S7iL?=
 =?us-ascii?Q?4PhDsv92qCdvhTC9WnpKKfY4Y96X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:36:00.2489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef277700-7429-49a8-e466-08dceda46add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129

This series aims to improve domain allocator and attach device code path.
  - Replace custom domain ID allocator with IDA allocator.
  - Improve protection domain data structure
  - Improve attach device code path and replace dev_data spinlock with mutex

This series is on top of v6.12-rc3.

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_rework_attach_dev_v3

Changes from v2 -> v3:
  - Rebased on top of v6.12-rc3
  - Added Reviewed-by tags
  - Updated patch description

V2 : https://lore.kernel.org/linux-iommu/20240910065812.6091-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Minor fixes.


V1 : https://lore.kernel.org/linux-iommu/20240828134317.6239-1-vasant.hegde@amd.com/T/#t

-Vasant

Vasant Hegde (10):
  iommu/amd: Use ida interface to manage protection domain ID
  iommu/amd: Remove protection_domain.dev_cnt variable
  iommu/amd: xarray to track protection_domain->iommu list
  iommu/amd: Remove unused amd_iommus variable
  iommu/amd: Do not detach devices in domain free path
  iommu/amd: Reduce domain lock scope in attach device path
  iommu/amd: Rearrange attach device code
  iommu/amd: Convert dev_data lock from spinlock to mutex
  iommu/amd: Reorder attach device code
  iommu/amd: Improve amd_iommu_release_device()

 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  20 +-
 drivers/iommu/amd/init.c            |  35 +--
 drivers/iommu/amd/iommu.c           | 349 +++++++++++++---------------
 4 files changed, 188 insertions(+), 218 deletions(-)

-- 
2.31.1

