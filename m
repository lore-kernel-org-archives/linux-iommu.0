Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6761CC8A3
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879274; cv=fail; b=VoTCnhlkb1qZco56Q3O0npEtRfEeJOyzlxSWEI75LyLVT/Rn+MVmj+nCAFXlNOeOcs9hLAJdRWP6cdk+NfKOiDLLQs6yrJwwYeVsvd1uMw4MKv2IHCz8pXTB0/5xbpBG4lDgVCkSO/Zc+a8tiHXrfKpbPnjCztNfHu8BDmYQcAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879274; c=relaxed/simple;
	bh=kvY7p1D/HbFo76hm2Z3GZf5CjrW/8fJZspYTiIrI690=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/EOBHdKwf6jXkHxTCF1gSwRaHYkbAD1SNC3OzzNyIZlXajh5uy/vtlPnk+CYsdSSDookpcAKcxoLqhCgne6LOOmT5Y1GLaKwZ5mb17ZQvTxdNiTeN3swBD+xIfO0nr48+UPX12/JAvFTCmjGuu4XB9KK7A51sEFNoRSrrUM/qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cI4qs06M; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cI4qs06M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blHdbaoccwSYAPQ91YRFsg8Be+J9y5R12BR8tm6rl8Hzvj25vXwCYOrpBj3fbxPrq2Oq8M/lu9Yk29hMqGT5pduzgVjDqCgCQ2g+aNSrNQkeePOUdOdL51Nm6qTRka2ygcnNRYDcv0ob6zpe82eWyrrJBpVXKymvCR/Yizo3MghmE6rODaUwB1qe/GJmomG+Fduy+fyIWeeELkZ648Ix+OtSsiC6zGtTP+VW4MdcF3uKgcbofzIcSTQP2PWKsyiPYjzBRUnmqRweUqU9CaVfOYjvLMOO62gn/eVcrsLJpmFOn35ExSGTpDhKlHkOXjSMGPvEYATLRQZ9r82e7yEYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M496F0i3aEXYxrPCPnJxIVVYqaqhjt+0k5x5jSLlb1I=;
 b=uXnPPQ2xv6A4DTLbFuCE89U9WCPqlc8Q71BJ5QPiKx1RQPvotYM0DzskOuqi1d+7+pN/Q3O0NmRBtbIfgPLHJvBhdowpH2lwjJIdmGPYyOHIZsYp6n0h7eOUirsSmH41FNLcfB6du11+u090mAdYOKd9dlgFJFvakleNPb6fTS7r8wS09MqLTgV6dvtTwbZRYwUiViyAP1dwWj0QWBWENMYlfotruDM3/wgEQpE/WK6jowd8+BV9nePoyv90Qw5UaSxQAgkoeHvUf04PsfyQCkzWYynTPoe2mJHgoArljfRm70GBY5/HrAF9lBdrH3Hi86CBgZuztHo/nT3yMtMCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M496F0i3aEXYxrPCPnJxIVVYqaqhjt+0k5x5jSLlb1I=;
 b=cI4qs06M2THCIbqckB8FiW/U8sxOfEvVUWmTzKTXoqQudtfsm1Ox+tVvkDd2UMqkpp1AbeL0beD/aiacuaOyWifFQPkkBtRAl5QCfJy3ApIiZ6ViRitXYJMt2u2J75f1pF6s+xYLXMSUgHsgWK0sthBPCjmbA3CGr3zHAE5aUcY=
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 07:47:45 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::d6) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Wed, 6 Nov 2024 07:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:47:44 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:46:57 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 0/8] Introduce debugfs support in IOMMU
Date: Wed, 6 Nov 2024 13:16:31 +0530
Message-ID: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bf35f0-692c-4cf1-239c-08dcfe374d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9OkhULOVH+pUymgy7FXudMDcVAfI69swuzPjlXX2jLQOv+732l4Q0QkXUmNo?=
 =?us-ascii?Q?+buhWZfjZp8Lz8P98uunJQKULpfQ7dGGSf46jRzoatLF7vojODc/iNlWMzvU?=
 =?us-ascii?Q?mLnNvpeAHFuMGWKV7gc3WSLr9QH9Hiimbq7+4Zo9oiOogJYHpNYqqPHT1waQ?=
 =?us-ascii?Q?n6lebpXs1ubU1BFMOfJ7m4EvdernTsmrsFdbBrr14lT7Dhd0/XVl8P2QwJIL?=
 =?us-ascii?Q?pAx7hBYzd/mMCgxyFvHzFMVyTUC6jYgYsLsZRKasG0zCtLCWORILCc+9JMte?=
 =?us-ascii?Q?y61kNGtCkWVl/IjJ+mPDqBTUOScygWa5Fv1V7ct6osvbR8mA8B9yifRguWEn?=
 =?us-ascii?Q?weLTLyh67ii2r+eEJ8FtG9IQd9WXNdw5nsydTrAwy4wyV6tvXlj8W/ZISUtZ?=
 =?us-ascii?Q?rGH/UvhSmSpsgIvFj98EI4g6YPQnT7FLMDzTuPQLRYzfxRK3ZNz9VG8UaiJn?=
 =?us-ascii?Q?dIoX5cqlzHE7OFfg9Qes+LIXzztiGg80iCnVKrne2899w0xaJlJrs8Is7ncB?=
 =?us-ascii?Q?IctMnVyw+NDQ2YGABzhjH8+P0Zaeap4AV4siCDtRRmEhJop2R/yy1vBdU2xv?=
 =?us-ascii?Q?j4iD2L5TiJyN/emmjZl5LonqrztffzT9FdEYxb7nIECgNlTxQ/XO/0zPdAvr?=
 =?us-ascii?Q?96ivg+rXWg/G7bpgyBSq6O5DF+Had74zSGbJpzB2EYc8L/TO1uGrD8W18Qdb?=
 =?us-ascii?Q?enyxHIRtKsVAljAOARO88D6GHu6b2+KyfkSebJX2T72J/aQUPos1b2nBGT/l?=
 =?us-ascii?Q?bDkC1PRgi1StMcT9muqahoGaTDUNRcPpbwBy2gbgnXJVA/EWYAA+yh64eAtO?=
 =?us-ascii?Q?omFlz95ArjKrj1K0LYkHAUuJO++fggWAhBMFLmJ9zFLRj9RNs6TtepuyggBI?=
 =?us-ascii?Q?/iZSvnzJzBHTGDQyi5P3pSeJsjlP5nXeHT+xAupG51aceT57rkKma8uIrO34?=
 =?us-ascii?Q?UJlNQcU0AXqS+pL1kLtOEIUk7UKEgFR3C3DaLL/fYEPuK5VW4UGZAwfsnpkQ?=
 =?us-ascii?Q?ZyASx9eeJGh9Q8zrjtaMACqMevF2ium2IkkppdiOIP4zHZJ/B//DT/xVrC/v?=
 =?us-ascii?Q?zIUyW0M5KUfkQskza6p3CBK9udoS34t3sQM0J/0CZYaTq5k4lVbXPL6Zbri9?=
 =?us-ascii?Q?8vjhtcrRYfafPWzILKlh2+s7uw2j2AfcRReolccFTcSsOt+eBTHOTjPclWV5?=
 =?us-ascii?Q?LyzOjXnDYymTXWgZMLWYRNnbrtuuOHhuR7sRB4HIXH+AaMB+2SPZiabj7n9w?=
 =?us-ascii?Q?LKMVYrlprBQUc4NasfmhyJ//vxyZSSUsBvnPk3m46eKqMPU+KnQ4gz9eoTAB?=
 =?us-ascii?Q?dgWPEetf/d01PJYLcZpes8YjxpYuPjKn0P33Y2G+I37akTs7cNgl+trHdUWs?=
 =?us-ascii?Q?87a4Dqo/wzzqayqtit6+Qcifi7US+CyXz7CJbPAvt6Vy9DBr/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:47:44.8471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bf35f0-692c-4cf1-239c-08dcfe374d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255

Introducing debugfs support in AMD/IOMMU driver that will allow
userspace to dump below IOMMU information
1) MMIO and Capability register per IOMMU
2) Command buffer
3) Device table entry
4) Interrupt remapping table entry

Analyzing contents of IOMMU data structures helps in understanding IOMMU
capabilities and behavior and debug issues faster.

1. MMIO and Capability registers - Add support to dump MMIO and Capability
   registers per IOMMU.

   Example:
   a. Write MMIO register offset to dump it
      $ echo 0x18 > /sys/kernel/debug/iommu/amd/iommu00/mmio
      $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio_dump

      Output:
      $ 0x0003f48d

    b. Write capability register offset to dump it
       $ echo 0x10 > /sys/kernel/debug/iommu/amd/iommu00/capability
       $ cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump

       Output:
       $ 0x00203040

2. Command buffer - Add support to dump per IOMMU command buffer.

   Example:
   a. cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf

   Output:
   CMD Buffer Head Offset:339 Tail Offset:339
     0: 00835001100000010000990000000000
     1: 0000000030000005fffff0037fffffff
     2: 00835001100000010000990100000000
     3: 0000000030000005fffff0037fffffff
     4: 00835001100000010000990200000000
   ...................................
   ...................................
   ...................................

3. Device table - Add support to dump device table per IOMMU.

   Example:
   a. Write device id to dump device table entry for that device
      $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
      $ cat /sys/kernel/debug/iommu/amd/devid

      Output:
      0000:01:00.0

      Dump the device table entry for the input given
      $ cat /sys/kernel/debug/iommu/amd/devtbl

      Output:
      DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
      0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3

    b. Write device id to dump device table entry for that device
      $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
      $ cat /sys/kernel/debug/iommu/amd/devid

      Output:
      0000:01:00.0

      Dump the device table entry for the input given
      $ cat /sys/kernel/debug/iommu/amd/devtbl

      Output:
      DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
      0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3

4. Interrupt remapping table - Add support to dump IRT table valid entries in
   "iommu_irqtbl" file. This supports user input to dump IRT entry for a
   specific pci device.

   Example:
   a. Write device id to dump device table entry for that device
      $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
      $ cat /sys/kernel/debug/iommu/amd/devid

      Output:
      0000:01:00.0

      Dump the device table entry for the input given
      $ cat /sys/kernel/debug/iommu/amd/irtbl

      Output:
      DeviceId 0000:01:00.0
      IRT[0000] 00000000000000200000000000000241
      IRT[0001] 00000000000000200000000000000841
      IRT[0002] 00000000000000200000000000002041
      IRT[0003] 00000000000000200000000000008041
      IRT[0004] 00000000000000200000000000020041
      ..........................................
      ..........................................
      ..........................................

   b. Write device id to dump device table entry for that device
      $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
      $ cat /sys/kernel/debug/iommu/amd/devid

      Output:
      0000:01:00.0

      Dump the device table entry for the input given
      $ cat /sys/kernel/debug/iommu/amd/irttbl

      Output:
      Device 0000:01:00.0
      IRT[0000] 00000000000000200000000000000241
      IRT[0001] 00000000000000200000000000000841
      IRT[0002] 00000000000000200000000000002041
      IRT[0003] 00000000000000200000000000008041
      IRT[0004] 00000000000000200000000000020041
      ..........................................
      ..........................................
      ..........................................

Changes since v1:
-> Patch 2/8 and 3/8: Use kstrtou32_from_user() instead of memdup_user_nul() --> kstrtou32()
-> Patch 4/8: Dump command buffer head and tail offset instead of head and tail pointer registers.
-> Patch 8/8: Fix bot reported warning on v1 upstream.

Dheeraj Kumar Srivastava (8):
  iommu/amd: Refactor AMD IOMMU debugfs initial setup
  iommu/amd: Add debugfs support to dump IOMMU MMIO registers
  iommu/amd: Add debugfs support to dump IOMMU Capability registers
  iommu/amd: Add debugfs support to dump IOMMU command buffer
  iommu/amd: Add support for device id user input
  iommu/amd: Add debugfs support to dump device table
  iommu/amd: Add debugfs support to dump IRT Table
  iommu/amd: Add documentation for AMD IOMMU debugfs support

 Documentation/ABI/testing/debugfs-amd-iommu | 140 ++++++++
 drivers/iommu/amd/amd_iommu.h               |   4 +-
 drivers/iommu/amd/amd_iommu_types.h         |   7 +
 drivers/iommu/amd/debugfs.c                 | 376 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 518 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

-- 
2.25.1

