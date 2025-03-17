Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802281991BB
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212739; cv=fail; b=YTG+xAArp90TSWHVS6yk1zlmXx9Mm6Sypn6Xo8Swq0YvPZIImYxRbzsXMzuBBVuBZkuOvij+0ryxHeBjNq7/Xvnb/tDzNL7JXfnRV6yIpbO3AALD7zgL4uLe/EH7SQZpNjK6M6794/jBpjS6lyj7gDWS0q8tBPyUq0red2+4wmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212739; c=relaxed/simple;
	bh=yIMU5AYFnCmoye1F1HyM6wIKmnuRLZFqK0BATeMp+aA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lA220a+E1puYNaNBJ5asAXyRNvY1YWqqf1DE+YG18xePyGzvK7hwNHlEJLWxE1yRTbw3704yBSUmoRioJHyFjOnlYU3PMppB7W1hUTWCaEHr4soUSOAbFQHDsz+/TXa6+21/suHqjC7rMV0kYfw4nKCzpKHHBKXnND9eCYh4GOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKnH153f; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKnH153f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcr/yl5XuOvI0wA1gRM+MQGkNZWpY/+AjKgncSdg8QzES763FK5oo9Ez8fBPTcFRzO4cEJoerKi4AnA0EOiqdw8bAFhWISubR5O86Tz1/yMcQXBEOhyIyRjvp8tOPyay2E6oW7s+FeHiCYAQji0BDYzz2HP/tujJ4hnrsJ4ukPuUNQ1RAgFFe1cOTi9wpv/Nb+zBJgKGsR1ib6FsABDi6KqZV/JwD3cBItptVagAwVI2rD8IPdvKQe26Py4fv/RiRG8GbBx6cCkYnhb4oj12eAwQBNJ/YkaeTxp0EHOw+7HYcRTClBykOWcn0b6GTVHFpFdMX/KOJcO0IcLpnlyYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YSF+glVIoRrN02XEP35zA53zBsp+VyGmccvn878k10=;
 b=ZOH9xKwkDiH63hcjQ6Px0B7GX+whirKOvWIhXB1eNYl3AAbcN1CdmSmG3uhzx6wRxXKLA8OJPq1mp8D1UQGFo62Z6FRLbR6AnjQrFr7AIbgTqD9ZMZDcQmMT4zGl/JCWuhfmIFfFqyJ+CzhUY66cd3r6kTylwcnJRel6rz5RR5haE5xjGa34jkz07lPWp5IyBA0KDRK6nb9bQyz0TNEsrpMfXm0OB+63A4FmNfQUBPEPLm5SYxLVNuJugcf1TwEeI6FikdXXTFwsVz5jQrJXLlzKXLjSHWb3UqaaOf3I8rwBfvC1zF6fv0zFwTNQQf3F/5Euq4Jq8/p3wvYdlJnaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YSF+glVIoRrN02XEP35zA53zBsp+VyGmccvn878k10=;
 b=EKnH153f7hzXW+wQB7NevRszc583C4H/I3QQG/N+z+nj345IVGHbm+PbeqVVh4tsbvCA1hlyg6yhKTuIkZs7YPu07ENHWxOngI46FqJ8tr88kvX0qeyTwCdP3reIX4I7MiBHSaOld2BnL+jSfeiBZfjs7A55Uu4aOWNjfIz3SRQ=
Received: from MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:58:52 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::1e) by MW2PR2101CA0030.outlook.office365.com
 (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Mon,
 17 Mar 2025 11:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Mon, 17 Mar 2025 11:58:51 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 06:58:46 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 0/8] Introduce debugfs support in IOMMU
Date: Mon, 17 Mar 2025 17:28:22 +0530
Message-ID: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 04015201-449b-4884-d950-08dd654b15d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+K6VGwcd0dPMNoLdUbKvv/VJZtIeqWCzlju5OSsNTzfdmgJM9Vv0h4QvXpA?=
 =?us-ascii?Q?eqb0HPS8c0O72bRas23aZzCMweOP8eK8r4TtN3+wW130/h2troIIC48M6fv2?=
 =?us-ascii?Q?hnXWOu1rHttIhLxxZ3jOSxfhHwjXFv8rJchgnO+ThQ0JYFVkVqQFiQFFTriF?=
 =?us-ascii?Q?MX6ihvvjdBEIzup+/wbPWgsksLcKVT8IwV9pFLwYvw0wN7kQVd5fQbz/WlVG?=
 =?us-ascii?Q?aMaxBGXMVspqsVbxFW7ETu16f0BaXxmBDwCWERhCMjgPehWyHsvGljiPIE9o?=
 =?us-ascii?Q?x/EpevySS2w3gpfh0/5jswmYf3ucpK3AqPmcq36vrVTnnbOVHiuQ6rH0szuo?=
 =?us-ascii?Q?tF55dj8eAaLvG5X2fG0i7xh0lbZHYyuEUGoRiOEVKW6hPm6o1a6eV8lfaQf3?=
 =?us-ascii?Q?yIOgYuzFBfAl34sqONf/mYi3xnhbOgAEAaa8+8Ihz9WsCWN3ULlXoqBeaLDt?=
 =?us-ascii?Q?EabXZ4nr1MViIZrpnllRYfe9sIjdqBLJSFS/YsK5b0BbcI5HkUt6ME1zRu6h?=
 =?us-ascii?Q?hKEB8BZl11lYgXwuXihl1p6CFcUbtHifE3h+3fORPxJOlSoqFFnMSZVW2Fi+?=
 =?us-ascii?Q?Xs+7lOQ1iHslX8siT3td3vhWeSb7qrfzZwo7B7B16GhTXHoopXuD92wq0wBn?=
 =?us-ascii?Q?ObpPY7mj0lUmNu4dG49qP8cswng8fQiffy0uBbjxnfVM0vAqyG58fqDg9Q1O?=
 =?us-ascii?Q?24RIHtRdXzTARsv9cIYVfxaEAjzaTKtVwdkISQTR3j8OPlNmVdCwBQfgSn+v?=
 =?us-ascii?Q?w9OnD+3I8HpbRaDVrxgwnfA8QJsXxapi9RUjg0r9j+QTvRj0xOvH30B6xBY5?=
 =?us-ascii?Q?EKvjqatEQnUSBWaWh+oUsHZNYBnvYwxJ1iJSXYpxjlV6/vFRgjEePlKxlomz?=
 =?us-ascii?Q?3R00mmxglk5cZ+nUZx1/gM+Yx2j6rRmfxljRFZQ++t6Y5mfws3yTpkadg2Ik?=
 =?us-ascii?Q?/G9paV9iih+4njkJTKWRPAlXCzjCc+pIpjxi+IZQlPP2Avo5MVCPBgv1L1xF?=
 =?us-ascii?Q?ME5tFb2VGfZVj80nwHiLCkZFYOdqOZUxl/4JNu4EY1iyg5fuuF4HNZSu8tmB?=
 =?us-ascii?Q?dGraFuEDRZ/locdA2tpN7ntcwhUb9Vjqgoc3y95iJZGF6K+nQ6BKw8j1KV55?=
 =?us-ascii?Q?ZH9ON3VeQX3s02/XjW9KAXr1DtFwAmx/xw/X3SEoTiyK3gh6vo0urZTTrza3?=
 =?us-ascii?Q?apcipSswriDrSFy4Ll3VX/RjpwkcAlWhPNUXXlhir3X0gDczbDfBwZ6BOK5k?=
 =?us-ascii?Q?oMtWMLL2ouK6W5DMrRXGWhEiCFu/3CQP6gjD1RYlsHNFK+XoQNdZOzhD65wL?=
 =?us-ascii?Q?oeXOTHufZK4eZmubmrg0ZobB1gcwkyMnOzQp8lBNdkOG4df+IAuxG9d50/bh?=
 =?us-ascii?Q?qGJzSWYC2KZZsCDfMkKJY8kedrF68psqxvOzH/u00+RUHJTpiOuIQdMSH3xr?=
 =?us-ascii?Q?SPTdgwIHeF0GcbVBpRlJhQ/AwzWcmy3L620WEs8XT4uxl1FiXwY3TbSNFhmp?=
 =?us-ascii?Q?IvfXfM/ua18YorU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:58:51.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04015201-449b-4884-d950-08dd654b15d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

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

 Documentation/ABI/testing/debugfs-amd-iommu | 114 +++++++
 drivers/iommu/amd/amd_iommu.h               |   4 +-
 drivers/iommu/amd/amd_iommu_types.h         |   7 +
 drivers/iommu/amd/debugfs.c                 | 354 +++++++++++++++++++-
 drivers/iommu/amd/init.c                    |   5 +-
 drivers/iommu/amd/iommu.c                   |   7 -
 6 files changed, 470 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

-- 
2.25.1

