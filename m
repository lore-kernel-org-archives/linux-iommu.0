Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52A217677
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047327; cv=fail; b=t2JbCPhRhAtYaEDXydlO9DPWv+uh1kKPPqTWh+DQMJeDuSA6zhMGfgLfscQjLJyWUkss4zeNp1KrZ8NNXWVuO0g4wB+/ZSJEWsPWam1ITyKSlAgZ70gWypYZNhWgdonPkD92gZXWvoXvnSxMNrHlOpOCPKIuyglLErTvLWYj0mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047327; c=relaxed/simple;
	bh=W/P0R00vPyeR3uPse8+2ZEH2cUyjob9A6JHiaRxAG8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EvbuZNxZL0ncv02fapiG1+RUz55Lncz580qknzmN6uvPC+cKlNTt6E2c42x8TqmJnI3119wuX7FtjNKIwGrhUnc41lQRYnqfubM4HqNPNp1RkOEhnsB9L4/qjKXiy9MYmYoS112oNQZdKsu9NOCQuhiQplvvX9aky9Q5S9ulD1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AoiKmqFm; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AoiKmqFm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lngY5gQDisvb0pnG0BZtwwBvBNaDD5d9LwtqLq/4eIe2aA3bztoyGjsMddwsSrON68KTiNnQbvsuFoKmG+eTup/0b9FsCCGPYQFZ/ep3ZHxMSVoTIco6x6g2yvxZA4ePT/9nqHih8GWxtsv6mbojcZ4Ix8Ek7nB2w0xD160oQnBRH1TiVx9U9l87HbZrl1W7W6JbYJpkfYqsXftJ3tuvgQpIgmIVNSQyuc3C8cGh6f5SZL0/3AlkQGXRBFo2j/Y5Tw8lAg3Vpz8JLG2ZpykUIlBgs8y02l6yn4ziySz9pVXHIlES6/xzQ+jOtBPxTS8aA47NKV7NxDfh/a1dyNN2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym5rulXGboUkixkJK7Tv2duwvHMKosfq69zqpl75spw=;
 b=c5bJc95YLpwVQmbZ2vIQxza8dZMSyy/4Yo4VfrBP/YOFo/z2GFHrCnSjXUyLpzwieyEqSJQmE1yWEQ+9HteZCG7LrTKh8OGGFb/odFHU/NFJSRLlqeIQmIG0KqRNGLXY2nCVX9VXwifKM6Aj2zzZFZ8o4RwVftknnwdCi8hKaGdTqikmolsmfj9RxsAwvy7whxQw1/tPMhMMnA3TARjN8DF7gphMH2hq0cxvHlVebJxohxb/Og4UoKNElqMY+CUjBx47ntA2GzJFA02YnQHi3nW1RIaP1Yf5kGKdN40AGb6BsnHLXholtmwRqcCLeaDeciz8U40yM0ZWkTZEWMCrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym5rulXGboUkixkJK7Tv2duwvHMKosfq69zqpl75spw=;
 b=AoiKmqFmU+RjLW63sMUa8We7P4p5YibD/J6enXErsNyVUudeT/QZcSHgZsJgSNKlhtTev7sVfS1o2pLq+k8srhna8EPNUKzlSqxr+Zq6cRM6+3rigH63EawjDwNSopRxj03lqvhCSiu/L0wePW0FTu4Qosv4wNlX2m6JpjrNdSE=
Received: from DM5PR07CA0074.namprd07.prod.outlook.com (2603:10b6:4:ad::39) by
 MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 7 Apr
 2025 17:35:21 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::3f) by DM5PR07CA0074.outlook.office365.com
 (2603:10b6:4:ad::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:35:21 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:35:16 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 0/8] Introduce debugfs support in IOMMU
Date: Mon, 7 Apr 2025 23:04:52 +0530
Message-ID: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da795d2-a202-4ef7-be40-08dd75fa9244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2cL+JjWQmZbrHNcm6fAuXIFXaLzDiwgsj/sVzYG6tC8T6MmorlVntKt4i75?=
 =?us-ascii?Q?8VDFYcxmLDd2VfYlXlZZQ/MKcz5Run+JGFFYJp21B/j58Cf2bciiJLTYIWH+?=
 =?us-ascii?Q?LnGWbcwSz3FwxIsz76JSwEsN6VuopLhKtYXMZg0jUEbC+Scz+qSnCWPfV8pe?=
 =?us-ascii?Q?7vvxtw9keSx3Qa0NX/PEql+OTnc3bBMfzD9rZp1vLkMCaNXyh2RKaidv6aDA?=
 =?us-ascii?Q?W5I7jMt8nTE1d8QhBdqorpfKrjoClqCqs+bdaaJJyAdLsJ+MXYLylyHmq6hn?=
 =?us-ascii?Q?MyUKqnvtD3LA2qqajMx2cQ2Nx6QgV7U4/Nh78THbEMIl3dopU+/DIrPgHd02?=
 =?us-ascii?Q?WhHBTG56rIg3UHcGuq0HBPkF+Wqz1FVUSk8hWgyBlJObxacEGtLAWvagPSqp?=
 =?us-ascii?Q?FChSC6oinFHQWZG5fWXsNJRWqWSCGXB6bE0hjgUvzhtxsbgXOkr3UBOaLBLm?=
 =?us-ascii?Q?dKk37zRmQfZ9SHJyRG7m4A0iqSRoUYReDIYEAxlKm7aBWvyeEWU94zM5BtWr?=
 =?us-ascii?Q?kefubXcybZAeoeav0QAZ0ClnzyOFIhPLGaRSo6cnDnXRdE7lVeyDdz9hzEI3?=
 =?us-ascii?Q?IecoUeKMO557Ppp/lrRoXfr5Pl2Su0Fd9l8tVO6wTj9TW0u7QMqJuUnDTQyq?=
 =?us-ascii?Q?hcmSIVncyXrsooqwPWO+GzrikwBXYvDIt9V/1zgPd5Kgq/E7qnLSX61qG/+9?=
 =?us-ascii?Q?kgFDUHP5d3oH4HItT7wQ+uezA0HaIm/n6XJ7dGz9hbsRWiPYstqCPAmyyXiw?=
 =?us-ascii?Q?Xq5u0j4l5Q39fkaVrJPr7OBZHJ18HMjmSL+OQOpTwGaPu5W6b7GKbR+l8MH3?=
 =?us-ascii?Q?OQuNBYNGbLjAWsw9CqbnFN7Ee45Sp73MISuOC5Dv62CMFOP0ITxP7MKR9XLi?=
 =?us-ascii?Q?uDQubedDt1Grh4h5P0Z8APDzeLRi9poqkJhYXa+KE5npGM+cGZq5txNcRKvD?=
 =?us-ascii?Q?mjxuCMxBs4BmbwYNIN9EKshrajzM5u8YRuNJziz8b2khwLct/RyOkjVGAsfs?=
 =?us-ascii?Q?tAfUbR7qrhIGFT6zSfpGIHYArwikqqVESZlp1i5HclHrjgOYPQwzDHbYNjnk?=
 =?us-ascii?Q?POMK3o3K7VRIBnaFtm3lJl+He1dmP/eLkttDTUEar6y7+bBxHeF9JXf5T24H?=
 =?us-ascii?Q?9dHS7iTZrapIJTyRjaO/UX0SXRst6ZmDgNAAHds/K3GKbbM0BnmoEFsFdsCI?=
 =?us-ascii?Q?WOFEPMUnOAq2sNV/1Ek3usvchFUZAcizZiRV1BElDTqUpTa8PR9bqpI1b7rs?=
 =?us-ascii?Q?Xu9/X1s6lUXLYVcK0vmcy/09a7/0olyX7kf8gMXBOAlrgKVuY00H5K3j0Tu+?=
 =?us-ascii?Q?pNbPrnrkHp+5gtK1BTKdFYcFHBEtxSbVUkssULGCN9GDRUzAkAfglVJDDDkR?=
 =?us-ascii?Q?gPWHs3D/ayqzRF3a+5ThTbzkLBIsvoHLmBX/Kp9ZKMXqx6qrgDhj6B1Hxzz8?=
 =?us-ascii?Q?G0oP3KXb/6O7gHSr7YKLp/TB/W0de4L258BSDg7XkxZfYaaD8GZ8z507S+Va?=
 =?us-ascii?Q?lC9aTIkkstI+BYA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:35:21.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da795d2-a202-4ef7-be40-08dd75fa9244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

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

Open question:[Suggestion from Bjorn Helgaas] Instead of using device_id input support
              "/sys/kernel/debug/iommu/amd/devid", can we create separate directory
              "/sys/kernel/debug/iommu/amd/<bdf>/" for per device IOMMU data strcutures
              dump.

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
 drivers/iommu/amd/debugfs.c                 | 375 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 493 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

-- 
2.25.1

