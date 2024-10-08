Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9017D366
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384064; cv=fail; b=HX1gpIheHm3qSAuy/YgorrzEwe+wray0qqNaatCUfKrrAaEu6Juvmdzf3kZ4ttpx+OA4/wrIDboEv+LNo1jfQenaUnUfi/blwnR6SZB2aChSQV/BNlrbbruWjcit3eJOAZG3ztG13ymea+am8s9rZUNL42pfDv/TixYOMnkQcRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384064; c=relaxed/simple;
	bh=CWL5bEeO363iSaEa8uJoWqoOt2vzbAA7c5qYhSlqpBM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCYBBRWLwWITxf+yzVPjinxigusxamSvb124YsST6mAAnrX40gd4sRX4Tbmp8DfOGACJbII5JjsaF7Xc9w71WHd5c+EhQrLkeEbiQ9m1HaXwIJhJqjYNVAJZ9eWMBOVsP0x2LQxwK8jKY3JMOcArfDkSq0UA8NdhtB1XRD61sbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kaxr1oJn; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kaxr1oJn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoZqh2ZCw5i0pL3grbJTCJX122ItW13NA1O0gpGf80BuW+UDWmhxFGbA7933YLQHLslDjsyB4028LQFNvE3LLpmgdjszvJ0rUI5UQ5nervJMBY9FwPm6AEcSs+xfBzWc+Gr+oYU6JdAIahlGLbFBTIwEGadjaOk+1IIB+ZTPKvh/eyZMqUwhNn34MBzy3Z4laT7GLoeGFhrw/wb1U5j6MOxKlH+conO3LCTHdLhkmqFQrwLLzJboXdlHNY3Yg3uPhqG5EgcEy+jJTMlHKhhdchomx6248ocq3WS9x0WvcTpdWFTV6qCdofWTaUNbM9Y5ZcBeaUSCWiKFoIe3IDTfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84ZVD9LI6VRVgDV3eO2S6SJsYHt7E7+p7ZnoIwQwJ+I=;
 b=uxRMNodZbMnE6a8h088nDp95piUcrhLIFHmj0dJMfFBYfBGOYdptP8pIkmdLKDwGN2zEPHD6Yi6R5YVzE97fLKvQBbuMTz2pj1J5CLYMp5Css54N7i2W/Fxdcv5R05WYb4sPs4Y8Ly49ot7ibIQtr8qeEvABycjgtz9Ep/jwVwYE7B/Hi7gWjcTJMzFXWaJThXP27LBr4vDZqu/wN0SCs5ZlnqPFXEjGH5O8UlnE4rpXHTntOjogG8qsxmAWm7HpBsValH0e5glapp+e3byMfLL0KCkoXqwI4pxH8VKVK+0IRaIUtrFVfne6qGKTZ9j4FUjQuPAQGuLBR6oA4QAuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ZVD9LI6VRVgDV3eO2S6SJsYHt7E7+p7ZnoIwQwJ+I=;
 b=Kaxr1oJnQgLB0lu6FHvO9RtzHP6ECMiP7H2uQwABP8mDLCOAVk+8ssqV+7XERsCr3BQb7++Mev/QIlldsU9bl04viHK1cntFmjfro4MVEYaoRhF6hIxbB5VJ4wwEZlQ7Zyx7Oa6rJ3g9XGbETJN49KHgFj4Ng+j26A6ODIoT18U=
Received: from CYZPR14CA0032.namprd14.prod.outlook.com (2603:10b6:930:a0::9)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 10:40:57 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::ce) by CYZPR14CA0032.outlook.office365.com
 (2603:10b6:930:a0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Tue, 8 Oct 2024 10:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:40:57 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:40:52 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 0/8] Introduce debugfs support in IOMMU
Date: Tue, 8 Oct 2024 16:10:27 +0530
Message-ID: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 834693d4-8dfa-40cd-2bca-08dce785b182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3D0cozfsmwNP5oK3gr1m4inh+ydF10SsDCOryqMFpGUQX1P+lZIRTe92mUCZ?=
 =?us-ascii?Q?hfzgK0w00MIoLEe9tJDTVdkW65odYO+NhJP3mRshtZMJGblC1+otk4NpBf7M?=
 =?us-ascii?Q?4uhw+O1itZ2m/uvHFGRDlRRWYQsgwIv/CrFirHaxKJhs7D1N9NWvLV4XunUl?=
 =?us-ascii?Q?mFS3rpUn3zFOUjwDZBVQ4LJP4kSf4iX0mLERryU8U2AXq9O0o0Sl3EPgFA71?=
 =?us-ascii?Q?ug7TdcfU+OOkss/qQT0fLY3PcoHfTyH0Khv9gLxd9o+lQ0lmitFDSEdv6Sxl?=
 =?us-ascii?Q?f09ujAVderbxBNHnYUo0iJZVM44Giw1QwuFMUXfaGllZkhEH0ZJsIqljNqTh?=
 =?us-ascii?Q?8EuiptpxmGAXYJCa3x4ZaElOZYwesGYsoOBe9aXsrasNDeDFo8p0SJWVrQom?=
 =?us-ascii?Q?iUcknrJe7b+V+QVqNfYQR8gqr0sklpxip2TuR5Amh6EZbC/Ff8svBBDF1WJe?=
 =?us-ascii?Q?x72f3/cHCKvgxSdvucM6h4rn6Z76MCORMkj8jNPP6fdJlxAhPpwbPF2Zn2Ax?=
 =?us-ascii?Q?Tf3JPFBZk/EHy6IS+yr1Qpyj5X4KQz1r64Iu/H70/QsrNwsuHnhF3/C8Y1X4?=
 =?us-ascii?Q?C96A79NgsIGqOI5LJyPj5B4Vqm642unmfusJCU/dkHonuTUwIGlWSOlIGn6B?=
 =?us-ascii?Q?gTCWgBK1EuHULXuzsGdyMQAb6DqNMFlvw8BG166KuB+ujYq+I+keot++UfXp?=
 =?us-ascii?Q?uCCaOAtzsN6FhXyuzjGgMZlbPm3CITijTIcmvG6RpQttcq0rmJ4lKyqAVdOL?=
 =?us-ascii?Q?BUDJeqzw9fwj2zZSGNK9HxPaZe5RPdfti9G3yFo4HjJD2xp7QLELbxn2gSyD?=
 =?us-ascii?Q?qQoNCmS48tZ3zoAVWFcOqRZx1USh27WIEV9VIFVwGdyzySHIi88H15Ep93Vj?=
 =?us-ascii?Q?Zx9lh5pNvw5X6QtEJnCtgLxVa0GTBNCtqxR2AWm+9r73z6ewSAkmoJ9w5EcH?=
 =?us-ascii?Q?SqPtc6npMu2Z2qjZIgCBhsnGwyfbtXTwc3MG4lq4FjlfXp9Ob0xpuxovjqOt?=
 =?us-ascii?Q?3xjGpxchtgzS5H9g/oej4UroO9LEpuOw/O5TLnVWQICwfjDpO75v4l+mcK0S?=
 =?us-ascii?Q?mZHQFV1HBwnuemDEzMnYu+3Hm6hl3i3hs+CvL5LsmtYSde+Ib2JnbcJPlE29?=
 =?us-ascii?Q?gVO9Lai0Ypz+8Y3Aqw7wApkfBRD6hgagzb0SWxLqpejE/ZsCpwF4M66E+v59?=
 =?us-ascii?Q?podmE5QxmlluEw5K7MHq0p0xW/JMttOl6vkdG2HoBZgcjppLS+LzZtOg0wFo?=
 =?us-ascii?Q?5fZ+6LvualL/YeTCmWcC/DAPhpYZLY+etSp4VqLdMwbNuhfrenfnYIgHGzDu?=
 =?us-ascii?Q?aMp5JECYUWiRfSRH44JbvtGHavzTK/wWRA5YhMVjdHpRSvmi8b8ObLa+wmMz?=
 =?us-ascii?Q?HCRycqw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:40:57.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834693d4-8dfa-40cd-2bca-08dce785b182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

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
   CMD Buffer Head pointer register:0x00001fb0 Tail pointer register:0x00001fb0
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

Dheeraj Kumar Srivastava (8):
  iommu/amd: Refactor AMD IOMMU debugfs initial setup
  iommu/amd: Add debugfs support to dump IOMMU MMIO registers
  iommu/amd: Add debugfs support to dump IOMMU Capability registers
  iommu/amd: Add debugfs support to dump IOMMU command buffer
  iommu/amd: Add support for device id user input
  iommu/amd: Add debugfs support to dump device table
  iommu/amd: Add debugfs support to dump IRT Table
  iommu/amd: Add documentation for AMD IOMMU debugfs support

 Documentation/ABI/testing/debugfs-amd-iommu | 140 +++++++
 drivers/iommu/amd/amd_iommu.h               |   4 +-
 drivers/iommu/amd/amd_iommu_types.h         |   7 +
 drivers/iommu/amd/debugfs.c                 | 419 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 561 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.25.1

