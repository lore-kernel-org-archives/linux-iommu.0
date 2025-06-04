Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125384C7C
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055032; cv=fail; b=VESTumqZsCynugb9QtR8Vhr3Qr3rqRArddhXZoCWTWtg0ARysqUD2T4HdA+w1bXzLLU8ZkdQ/SguiblDn83zIJVNFyIKm+wUaX2AOteIqZ/Q7HcTk4Vjy+qWRf/1gHCS4VNuRZiiCmU1SJtjDFlp3wwZpGmEcGVTligJivIQN+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055032; c=relaxed/simple;
	bh=Vq+HYFCwT11ULTLVDdo5JzFhb7CE6OWcW1SdIqYXydo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkZmnVIvT0qh4UPsupL4FUurL7iyaJaaS4jreG4twPdjvCV6voeKkK/K6VrDzcuqisLip92zAlPi/MDLA/x2iEABzHTKpLavph7morixqyCRCODrhv5oDpI1PE5fbTyt4C84QFO1Q8cmn9m1RDQVtRyshiRrUCDA/VstiPdCE08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iBz7jso+; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iBz7jso+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaTyMpDuHNhnoY54Y42lu8huPR5W1KZ+DHozkOOXvTvR94jwAc3FAy/xul7FBOmQe5eMkLKe5gZL3Qzw51Z+2qbALADAnlHb6YInedQBJgCqTt7qvLGiL9LFObWevIDxgyqCouGkXbMnKaLFNWsXLzmasZP+ijSYBgbF9E+9uI+xopJpxkoB2qzIuzm9QXGSqRerfD6uHjsLJiG3aixqVpHb8Ch/u9QdHiGzQV8JVQU99lBBsMQT33x15gJvGNG3Og/3DyvaJOG4OP2nDPzfvcKlGTUpVJsLMATt7KTVuGORL+VXSis6eHyYBPEE/0Cjsn+8lOYafrSg6X1rzgQOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bTWfySqgmskk4JL0V2UEJFiynYPxJVbQi2m5aLDNbw=;
 b=YtPpmJ5ac9MwMdgikjULHfanu69UbxkiSRIvK4lyoqlP3YW9Z/c0znstfs7DhSAYPJBK9tS2XUNfxz7bB/kNmbAmmlDwGy6YtDRutHPzKdYeD5hdvvRXStUPM5BI051CFA6lG4u9GntS4+BweWMgVYVlm2gf3koTjX4g3oJNVhA2OSY0B1yKgB4XydIhclFkMk7gO/JwEfWB7chC2giYbkawJpzbMOkRNZ2hnmgH8hkD5MiaxoBpB6O6o/h0lQZcXey5PPnOtlF4Zr6nu9Pc3r735e+JfK6oSobhkspvEX1+PxknyKYOq33PQaLbsf2jj+LLtOq2qBsSWPHXnxihxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bTWfySqgmskk4JL0V2UEJFiynYPxJVbQi2m5aLDNbw=;
 b=iBz7jso+Cw1XOgK+OH/uIxMpB1uzaV66nsoGU6sk1/7jIlEsKy1zlkA/8GsDE7oVTK7p6bn8LQ+wauMr7sbADQVP/XJEvNWr/dHjlxnOjgrqNo975N98ph4g4y09ycADHz32yl7+uKHBGTVi2ZY7dsJXmHnk+Gs0SuZMrv6RuIY=
Received: from MW4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:303:16d::12)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 16:37:07 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::e7) by MW4PR02CA0006.outlook.office365.com
 (2603:10b6:303:16d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 4 Jun 2025 16:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:37:07 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:37:03 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 0/8] Introduce debugfs support in IOMMU
Date: Wed, 4 Jun 2025 22:06:39 +0530
Message-ID: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: f065e445-b5b6-4bc3-3313-08dda3860bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9Bvwpe8oGlipFQ/2jk9PzkLWQy3q7zlir8PUvcD/56Ix0xHIx3X06h88u0a?=
 =?us-ascii?Q?NRbaY1pmnsb4EnqaclYS+XSvmezsw32WiWyXfMtPOpmM+Gn6d5CYkgkRd1Zx?=
 =?us-ascii?Q?R+nxExc/i3/BshgIFEcP4XGu2BbZItcUeFpxuWqa7ZjVqZx1FdNH1E9lbnQw?=
 =?us-ascii?Q?xxrXb8dB0QeB3SfVnAMUoJpIOtUs/arjqhoa8sfZqNZ4Ea59k6FahAMYwMsz?=
 =?us-ascii?Q?K1Orqb+tzmyXColkJe/51eANM3yUt31iBiIPqNIzLkkKjUgy4d3D9cdCybVo?=
 =?us-ascii?Q?2yrru+Lzq4WvCnjemGqNNDIR6TwmjBFybHl+zro9ZG9PiAameyPiO8I0M1+j?=
 =?us-ascii?Q?IhUwBLnxrA6LGoXMf3+W2dxybhtqzijXccbUezckIPD/khyrbcDtPikteRRP?=
 =?us-ascii?Q?ohbs+0n7uWAAcHaQ8c4v8Ha5oxoCrE1IhJKAZMTHO9mu+ymUQAdozjDDBuX5?=
 =?us-ascii?Q?FgKuToshJ6vKEMjxRdYJUTUk6BzPIkS+T2i6IaiZUQP8e5etKxcmkjac6vfl?=
 =?us-ascii?Q?K4r10XQnZmxvTaW1JInW163nLeyvo1FZbWANjdfOAAbBC+ByncevjVl7AgDZ?=
 =?us-ascii?Q?iv1+MkoxOwrRlE9rYnJ4iWCQCzcfbsst6E3G7xufhg6i2aC5345nbb+M+Dz2?=
 =?us-ascii?Q?y8A/5/by2ejrljZklRJJDgHDS2m4geNk4Ea3G5UTMAIIeAhIE12E5+mK+dZt?=
 =?us-ascii?Q?liZPw4LMRMCzcjfa2FCAKQdsY8R93p7DJqBDp+ZGm1+Obt5vOtSgxHtHAOl3?=
 =?us-ascii?Q?JBpZe8TgKL8Mio22KeKDjRj6L+rAjZ5o+X69vpsFJF1FR2hJwfkFa5Xni6pp?=
 =?us-ascii?Q?UVqbPcckSIToIXiZFGafZMPdfvOFMnP0E024GxaLloIjSSEAXsY65AcCQvlm?=
 =?us-ascii?Q?djeLd7yHIMEZWY4ZZ6DZ6SmVATdl1fjczlitvoRHlZa5MSvLETW9c6V+cR3+?=
 =?us-ascii?Q?54r1O4RjX3GQPogg4wotwZ4DchBr2L3OGMIEuGbONqPQqWrdbP9q0I9vozM/?=
 =?us-ascii?Q?Q6T8Ft3DkbNHmV9R3WUPJ9hb/3ZEwNuqe5pHnw4iAPctBGD53PfRNaHjhHw3?=
 =?us-ascii?Q?2pZ6cTg2U1U9urzqos1faOqhFgLNE4BVl98WMmxKWAz2nTkc0+5CfZBtKx8A?=
 =?us-ascii?Q?vyu3oXSKDt4xdxyVz0TWeKKIX82PCLnG9FM6DFxQRc5N/kPZ/rnxFQwGBaRy?=
 =?us-ascii?Q?hu/oKM3+Q469KKFKyJkD1C0GeaRK4NySft8aBOfVSpoaHudpxlzvNzq+dP0X?=
 =?us-ascii?Q?xj7EKbmYVlzmsAR6gn9lkEzJLHH3Wd46bzFWpKF/WMEzbvXif21IRoXt3U+G?=
 =?us-ascii?Q?exMPselrN4r7zpoARcbdRdvVgkhTtY59l4X9jiRhgmLwF4i3wcBoKQ/hyD49?=
 =?us-ascii?Q?BAytfQKcHS6tXBYXTj3N6+hWXkAL2FuowSKzImiay8GR2qr/WpyxX6RA1xhf?=
 =?us-ascii?Q?3xUx4fCB9tVM9yus1iPKUAJ7ipcfAA/qSMKpNw5mfSNahgGVFAQ5x5oLaZPn?=
 =?us-ascii?Q?HIbmCZ/97qAfcTKMb4vHwxWhinHKlmAXNJtg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:37:07.3236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f065e445-b5b6-4bc3-3313-08dda3860bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

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
 drivers/iommu/amd/debugfs.c                 | 377 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 495 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

-- 
2.25.1

