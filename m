Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54E38DD1
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821629; cv=fail; b=FARQoBRXcK/j4n+aerxm+TZom6HpFMUav5v6EVqjoPi4F86devy/KKZM3li1maoZqXSq9NUzlDswJKt6zSRgwYZMmP4TXP85UlTvH+YklrXF8t5OJiI0rhSNJ9mJ0ThFqoOuHzmER2+Y7GGDhYCR2i07ZmSRTFFQJSQJQCPYVdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821629; c=relaxed/simple;
	bh=IlPxH1Iaq9hcUblkHeUOIEkqH+QYtQHBqfZFBQLLo2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bq7tTePOBoHHhxMrylUinu55g67WB03Dp87p98cmkmX3vBiArtCpz4R4nVBRozhyBUeCJZlNDXo0964Qilg9XFAAq+uY8yTB5h87nFu1JonnmMkifYMYMF4kOGds6QxE0fkknXbV5U9Rg8vz+fXQQ2q/e+HBG1AFb8y5hqhMPdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/Atb5y2; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/Atb5y2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG+zzmG4+IFu/A1wHu1/ske+8LklyYIp+1LXEMnCDtMWAye66i/XB4U2aZrfe+0x99n9H5Sq/LXwgxlHQGLeLN3Hu7V/g4J3BdJd18RrFogZjZc4qrUTDhODMv+ySTMt34S+bO7CPPqR8evnDFauDDoUgXp1Y2WJqZ7Bz76l8GAOKTAtQ0VUx8M8PTz07y5oJ9v5i5Ind6pUO0JUMGcvAJ+LB8BFGyrJBKpQ0Ogn/gExPYkU4OSWSCCvq6CIsoiyNa2ec8+ZmKmcx/Y1XGSAZS/3BXdTX4JkT+vteykdOGlxHG3Va9VQKTRTmlBe7NtkPgLITJ2yzgWcVL7pwDEJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA2uwsEccPhxkhFCtdX+eVutX0N+oOqzWlqg4ihKUjk=;
 b=UtWONj6Y20PuxOz/n2iw/XJ7csSLld7ix3xnGV+3ifKcZngOPF/RbQj2wqvErD+4rK+PUAxOxy1DJ1ZzlQQlnxWajs+pLGtpF4CoAoLobvaRSO4e1h8jlR6wXTs9DC+Po1IytQp5mLibKw2B4IOmtA3I5cxYBJXkaXyI7qeSXsjrGZKQ26BciHd6oqzpB/N/yxyzgtmeHFN37FENjDOFgOiWSuOK0NSBoGoNubn1JYL0JaQsoGWI7b7X+B2fhVXM+KBXGK1LHqTs9Gdt/aU1QzhZgqq9YhfHnjfq+NUidoa3S6d8asRLhMBp/S1xqqMCSRAbtP9i7DTGQcgQaaSzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA2uwsEccPhxkhFCtdX+eVutX0N+oOqzWlqg4ihKUjk=;
 b=2/Atb5y2/cbxg35+6bljSUUAO5uRWWHh3ChpllkJScjpTlvXuEmJqhbIEMt+72MOXYrBxN5VaDsMDgAhAVU2JlpTvAGX1BLTXhr1WsLcoLP234vx5ob52mmgula15bkTG0K5EIuuiRwzYNJulsuNgxwjASPejd6FP6ZKCATGtro=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 06:00:22 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::30) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Thu,
 6 Feb 2025 06:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Thu, 6 Feb 2025 06:00:21 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:00:18 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 0/8] Introduce debugfs support in IOMMU
Date: Thu, 6 Feb 2025 11:29:55 +0530
Message-ID: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 495e0db8-f075-41b3-f88f-08dd46738ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkQjfCzxsc9FSuQXaqxzIXDL3rrXFonn0KRaV077va0XsHulnD4eWJa2mE+o?=
 =?us-ascii?Q?2wXRj8b1FANY/3s6t/4sJpWAhu7oPkZ7ANrfvliXI979IquE+eINfHuR9wyT?=
 =?us-ascii?Q?ncEkakQTD39fQ5jVDUbxBNs4f5AdX/NGwCcoNgBBC0zgrHx9ij0WISIEfpfj?=
 =?us-ascii?Q?xB7w/CFX8VjM+TMjTP5gxdW1Wwcu1iBBQhdkUjATkNK7UZwCdM+NaQnx8g4f?=
 =?us-ascii?Q?9TINM3BF0JWxagFPrJvujbO6xuLNRdF41Ya1KXWdVEeEKhWzsDCgHFG6IPmy?=
 =?us-ascii?Q?YMaquI/GQ0J2j/Grjk4s/fVQdzGgWOjGKHzywV7JXtz4vtoSpUAiQBQ2pPbb?=
 =?us-ascii?Q?lFs+vSIfIdmYV60Dzd4nz00LC/8k5at652qd1bmwP3bSfYyupc1jsw7MF0y3?=
 =?us-ascii?Q?t5xcAhe9PsY8wOTtG9GViyN9n5gompmKzlw8R0tT5ewZHBZxF03MVyUgjYwX?=
 =?us-ascii?Q?T3XJYPgpJpZudaekaOzUiJHr4I6FATjNaWgruAmELfmL9hnYWgMcrUuB9wHe?=
 =?us-ascii?Q?DfD/Is3yd9JXr8exVhByPt750Vur4KWA84nXHpLDeSffejWiBn5CyH5IKjx1?=
 =?us-ascii?Q?VSrPobonN23jADeJrOWcisM2J6Sp1Pk9p4tZgzJa2gFU5RrZ2QZ0L1mBO1d4?=
 =?us-ascii?Q?sNQPOx8S6uAQyHzpWPeolxxlcHi6FoU3dXSxst8KYfkaNipRf11JxBS+OcOz?=
 =?us-ascii?Q?p9wDOtTjnysFXXpfeDYpbkUaKs8cSgL7nQAODOA5EtRcEoQuTTXkxSn3lEYU?=
 =?us-ascii?Q?swxGfNIlXlMIcz5dfZLLcnBmwvjQRFuJNjIEheXeKqS+wJDcHXyVFTWQjkCk?=
 =?us-ascii?Q?KylQ56XSzretm+0VthCpKQMRn2Oqq6mhoOxfw7uRdLo80dRWbKyXq1Tn0xK6?=
 =?us-ascii?Q?L+CgvG1gsmmC8GYmh74bnkWhJxmCNrARP6h+DRsXpJNE0OMjC4DrmBcA2CB3?=
 =?us-ascii?Q?J7tZSRt+jBhxzTPTkQ+dCxdz3WP3++EvcXfL2Q9gfVsnThVo1Dh/eeB7fH+c?=
 =?us-ascii?Q?vfTSRE6tkaoQN3HbJ8pernmC4oZ5PeEmNI9VTA0iCMc2FN4SEr8eCPW0iWCR?=
 =?us-ascii?Q?E7yFVvSEFYFxmUomVtzZsaF5fMCTNCo3U3ckpkieIV821wf6rkS/tZqloZzD?=
 =?us-ascii?Q?GwTg2kxyDtavxt2JMvzSeErR1gHzEN69Q+oDSAytLtYQ7dajQ6C97CKX3BuG?=
 =?us-ascii?Q?V5qKtCJx33rZ3yNi3yo5qUZeyiyjRWqWzV9ecgSBk/WlNMTeH/vXYZnlRSCi?=
 =?us-ascii?Q?k966PE2y56IkAAZUBWacH95Slu2TZU/3Y1tvY3nZ4BXX3TSTPi3wHWXqhrFM?=
 =?us-ascii?Q?gjqe7CWYXwLD7HrhLuMVUe89vEdWUnkplLDnmGUUt4qQvcu7HP4kleqSD/bt?=
 =?us-ascii?Q?STzhRCkswbetsxamhHR/t4+CuccF+L5fx7bwVHkZD8Ue/WDpyQGOxzP0SPuu?=
 =?us-ascii?Q?HcW/MbDkED9BWL3EsntVRcrJwoqd/b/gsl1R71rrR+X+hTLdSsxTVRoMA/ki?=
 =?us-ascii?Q?/OKNHyKZujDzB/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:00:21.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495e0db8-f075-41b3-f88f-08dd46738ac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

From: root <root@BLRDHSRIVAS.amd.com>

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
      $ 0x0003f48d

    b. Write capability register offset to dump it
       $ echo 0x10 > /sys/kernel/debug/iommu/amd/iommu00/capability
       $ cat /sys/kernel/debug/iommu/amd/iommu00/capability

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

Open question:[Suggestion from Bjorn Helgaas] Instead of using device-id input with
	      "/sys/kernel/debug/iommu/amd/devid", can we have something like other drivers
	      have "/sys/kernel/debug/iommu/amd/<bdf>/".

	      Each "/sys/kernel/debug/iommu/amd/<bdf>/" will have "devtbl" and "irqtbl" files
              for device table and interrupt remapping table dump file.


Changes since v2:
-> Patch 2/8 and 3/8: Use single file mmio and capability for input and output registers
   offset and registers dump respctively.
-> Patch 8/8: Correct path for files "irqtbl" and "devtbl" in Documentation

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

 Documentation/ABI/testing/debugfs-amd-iommu | 114 +++++++
 drivers/iommu/amd/amd_iommu.h               |   4 +-
 drivers/iommu/amd/amd_iommu_types.h         |   7 +
 drivers/iommu/amd/debugfs.c                 | 350 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 466 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

-- 
2.25.1

