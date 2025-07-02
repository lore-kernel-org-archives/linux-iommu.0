Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7F228CBE
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449111; cv=fail; b=R8c1hDqCEsAPJv4TAuKNK1+BpJZCLPaBGqVeOU3vSsUOarsD7F++9iIux3S82aZRbJSWo97ca1XW/c25IDlRKt3WbKCwAdGt9IWFpchWCTSd+SWpV26rHURjZmRuoe9xsVSLTXqIIqB8VMwkNQQoNKEOPWhFHNVNuGFmZlK6N+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449111; c=relaxed/simple;
	bh=WUTRRKjhrV5HWtclgDt+lHi5Jcpn459G/e/ZdI7dHmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VlC2oaato69Wt5tPc7Ato9KNrllArqXMQ62HyVp6z2LhlqlqudO3hsAW/60dEecxUpJqo4vxhNSOAO6Q6HN0W3D5sUUiDLxUd4PQzElsOpuwG54MseN0HuQ2IT4Mz92IxmLhUhO32y054QOpODDqQstHh2qeG5tvKdvl5iVw0JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FohEalkm; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FohEalkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGbeH6p/rEQ2fw8Y0eTqQ2xr4ikusvgkZifvtuwOuzb+Iq16+/Tp8f06ewB7cKFespeDB+HH7P7jre+S5v7biZlt7OVQdC8vaUSAgBzVrMpqF5RpAcouwBA1CcMYtcOyWyVj1SsyB32i/bszibhTiYQGl/25FIZDey3SIfdqQViQT4VEIn5GQ3P/JLo0e+IKS4/zOutKc0493vM6SzsWvGOmMibT9YgBbuUEqeIg818dJjODAo8eFOu4unKI3ZzIudSI8c3GO1xAq60zL517H2AsUIz7SqdfB0CcOc7eob5Hu2MM1QKZ2ehDtz0uR07zyzqFnK5iR+Z0Jl6nlalZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsqddeSUVnAAjPCa4Dg9s+6W30WAyYANdZYluGAALhA=;
 b=bvRen6Y/hwfgLOWhheZzBquy11kR/vzPgdHaHDwmKYjlVJRpw6E2TbOgF0H4eguK9oVKYgLZrKGd8E+sVu9uJBQ6VDrYiWbjhU1D2uXgNt0BnIWyBMu44nENRz/G6KBts32GDg5yxSkK6+5P3N3wmE2HHjR0jXKnX5ZrYA5DX0btxjg8pcT4jTJ2DXKlprYdQJz77Z6A/ALwCsPscGWjMlJBRezF4oX5Ewr8wwvX5y8UvV9Y2h5KBW9Pyhys1qFcDYkUPyRN5up0/H0EFubLdoZwXoaM5d7z0WXePxl/EUWni75Q2XesJgqmH+WPOVj1bbQ3vt7J55LBuXFn/TOY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsqddeSUVnAAjPCa4Dg9s+6W30WAyYANdZYluGAALhA=;
 b=FohEalkmjCKjTpAHggVnuZ524GVFPTDuCjDOQ3rtUSaDz9KEH04/XAkYJyquA+oo0u3ooyA+luw2Pff25VrjsOkAoiPLCiXjNI/Z2b1wY6dYb0SzWVLUB7n1yUfVFjc0XPWpwYoZF0ci/QDr0eBvf1/tgTNJUZHOhUoUulrxfK4=
Received: from CH0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:610:e4::30)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 2 Jul
 2025 09:38:24 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::51) by CH0PR03CA0205.outlook.office365.com
 (2603:10b6:610:e4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 09:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:38:24 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:38:20 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 0/8] Introduce debugfs support in IOMMU
Date: Wed, 2 Jul 2025 15:07:56 +0530
Message-ID: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e75501-e2df-4804-e9c1-08ddb94c30c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNRZHBX3Zl5VXfbzg3WqNnXjG0YZBQQODSEc/0fS2NvVdWvDBDxKZcBkbXcC?=
 =?us-ascii?Q?iu+rm0XT+4cSwAxQegoohihAuy2nAVmeCljsZnge49vqZgLJlZrK/GyObyCc?=
 =?us-ascii?Q?+X/04GlElV5aHH/QSFHOqIdPRi9xMqTH5gdcCeqogbDtSTgJHaC01jqrOAKF?=
 =?us-ascii?Q?D1eFEIPandsLg3jWztSfScL/le6VIzbiyp7dxibD8nWFPF1mcEUq1C0PJjDi?=
 =?us-ascii?Q?l5CsXhbA60MfFn2YlcY8pz4IuaFsZnx25+qGs3NgmpJvYeUpPAFOxFVF2m5I?=
 =?us-ascii?Q?XufV5+Rhd/aJql+9neg+e8+DYBfeoCvkq5eGKmHiUagkLcr0a/9zV+YodGdF?=
 =?us-ascii?Q?kJRiBKOgkzY1O/8qhcWrriXKJlTaeZ16NzCq0BiHjwgAkA0P10PrigTj4JX3?=
 =?us-ascii?Q?V7LReNmV2SegqFKSEB3FGpKiWDbrX17BoeHmM29ANufLwiTgJB5pcacupnc7?=
 =?us-ascii?Q?ubRk6vTe7xfoK+4gcvKnG7tIvuaBZBB1CI7J6xGPi4RQ9crvL3F//AXILfM3?=
 =?us-ascii?Q?mrtQQR/XniRNT++UwVeExJXOL8yY/a+vgh/OhfiX39+Qmex31BvTwMU3J5MP?=
 =?us-ascii?Q?NG4/UAXRpbnIcDRSw8d4XAcmOXJLEIFzvVxTrYeGbdidHLbEGSagla/t6pql?=
 =?us-ascii?Q?rqYlJ7AtXsvV51wZ0Z9DGqy61tsH4RcvbZ9OULfXXVFMdfKFWKerPo1Z3QCr?=
 =?us-ascii?Q?U4SUFy9ZDPI7qNmvmjUtRCsx1qzlj8wYRWaC2f/+es4hLZjQczxy0PO70vp0?=
 =?us-ascii?Q?YF33wYPl2sAu6iG5b/i3Wuh37PAyo7obwchHEeAJp0tw38Xu8E2OqfO7VF/R?=
 =?us-ascii?Q?GJ8dPOqa/xS3H/a+T3Qx4jyzGFU6OglQeyNur/Ot0lBEIMyJ+SW6rETRI8bl?=
 =?us-ascii?Q?5bGBTuhWkUzp+oJTwKuI1DlvU9dyG1WzRZUbzKZF1N3JomtUbFmhivnBc4cf?=
 =?us-ascii?Q?0TCA0wDIsDcqxOEy6+d0cfyUaPY0pFzESQXqJiXHX45BmJ8yN0K4JnKUxrBP?=
 =?us-ascii?Q?FPoxt0tZ3BGVUIZlPQYDy1SFRDOh60PG3a/jHkGWA5Mr0JvZAo4sgca3Esy4?=
 =?us-ascii?Q?VqTAZ17ltKgb5GMpabu+Yr4aJa4J82x7+cTSVzycCGnsZ0stc3XyG+Y0dMZ1?=
 =?us-ascii?Q?mBCtTuQvYy+C5GJHzD9oslQdz2WbAFOpevWL2LU+IqCg+ukgNjXi2akhcvne?=
 =?us-ascii?Q?NvCvE0l6R79smDGIE7T5Vu3XzRh2Y9p9K5eefqSqY5zLLCOZrdbnEdzbw1gq?=
 =?us-ascii?Q?O5fTtgF8t/EMAt82PM3OUi7U+3JRwM86jSw3L8xmrmGWw1/i4yZU13qza8i/?=
 =?us-ascii?Q?cK/hxZJ7LsNImKQrGJjCBZ/ox7mLiXa08tU40fiY649/BxpYSqlcg6bNLjoX?=
 =?us-ascii?Q?cB3bFkxxRzJ7Ai1YZgGt+J5MMIIETCdj3OGs+fmVX0OjVI+flo5UpcctAGfP?=
 =?us-ascii?Q?P9ptdjLHaPtlx7X5c0y9X3gp2lLRdpUZUQAGZ8phiHcCrp1HMrEnp/ZRrish?=
 =?us-ascii?Q?pbcX6uQxrkByrb6H5OFyV621maW844xDsy1N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:38:24.2610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e75501-e2df-4804-e9c1-08ddb94c30c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE

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
      $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio

      Output:
      $ Offset:0x18 Value:0x000c22000003f48d

    b. Write capability register offset to dump it
       $ echo 0x10 > /sys/kernel/debug/iommu/amd/iommu00/capability
       $ cat /sys/kernel/debug/iommu/amd/iommu00/capability

       Output:
       $ Offset:0x10 Value:0x00203040

2. Command buffer - Add support to dump per IOMMU command buffer.

   Example:
   a. cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf

   Output:
   CMD Buffer Head Offset:339 Tail Offset:339
     0: 00835001 10000001 00009900 00000000
     1: 00000000 30000005 fffff003 7fffffff
     2: 00835001 10000001 00009901 00000000
     3: 00000000 30000005 fffff003 7fffffff
     4: 00835001 10000001 00009902 00000000
   ........................................
   ........................................
   ........................................

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
      IRT[0000] 0000000000000020 0000000000000241
      IRT[0001] 0000000000000020 0000000000000841
      IRT[0002] 0000000000000020 0000000000002041
      IRT[0003] 0000000000000020 0000000000008041
      IRT[0004] 0000000000000020 0000000000020041
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
      IRT[0000] 0000000000000020 0000000000000241
      IRT[0001] 0000000000000020 0000000000000841
      IRT[0002] 0000000000000020 0000000000002041
      IRT[0003] 0000000000000020 0000000000008041
      IRT[0004] 0000000000000020 0000000000020041
      ..........................................
      ..........................................
      ..........................................

Changes since v6:
-> Patch 1/8 and 2/8: Use "dbg_iommu_offset" and "dbg_cap_offset" instead of "iommu_offset"
   and "cap_offset" respectively.
-> Patch 6/8, 7/8 and 8/8: Minor rephrases and grammar edits.

Changes since v5:
-> Patch 7/8: Use macros to fetch IRT table length for DTE.

Changes since v4:
-> Maintain per IOMMU variable for mmio_offset and capability_offset.
-> Get intrrupt table length from DTE instead of using MAX_IRQS_PER_TABLE.

Changes since v3:
-> Patch 2/8: Print 64 bits instead of 32 bits for MMIO registers dump. Since most of
   the MMIO registers are 64 bits.
-> Patch 5/8: Update commit message with the need to add support for device_id input.
-> Patch 3/8: Throw error message mentioning valid capability offset range if user capability
   offset's input is not in valid range and input fails.

Changes since v2:
-> Patch 2/8 and 3/8: Use single file mmio and capability for input and output registers
   offset and register's dump respctively.
-> Patch 8/8: Correct path for files "irqtbl" and "devtbl" in Documentation

Changes since v1:
-> Patch 2/8 and 3/8: Use kstrtou32_from_user() instead of memdup_user_nul() --> kstrtou32()
-> Patch 4/8: Dump command buffer head and tail offset instead of head and tail pointer registers.
-> Patch 8/8: Fix bot reported warning on v1 patch series.

Dheeraj Kumar Srivastava (8):
  iommu/amd: Refactor AMD IOMMU debugfs initial setup
  iommu/amd: Add debugfs support to dump IOMMU MMIO registers
  iommu/amd: Add debugfs support to dump IOMMU Capability registers
  iommu/amd: Add debugfs support to dump IOMMU command buffer
  iommu/amd: Add support for device id user input
  iommu/amd: Add debugfs support to dump device table
  iommu/amd: Add debugfs support to dump IRT Table
  iommu/amd: Add documentation for AMD IOMMU debugfs support

 Documentation/ABI/testing/debugfs-amd-iommu | 114 ++++++
 drivers/iommu/amd/amd_iommu.h               |   4 +-
 drivers/iommu/amd/amd_iommu_types.h         |   9 +
 drivers/iommu/amd/debugfs.c                 | 378 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 496 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

-- 
2.25.1

