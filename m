Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142142E64A
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821799; cv=fail; b=kZXzzzOBnL38fh5778Gn31NdfBypcbpjkT2cuBhErNPp7FBondvnP7qZnO5xXHObBHbyU1Hi2i9Z5JQfSOBlx1BgEX57GiDQ26DoXfvmGN0003Nr31zAYSGQq0MGG6k5EZxxUyTDfvfaZJPu7wgq88RcnfLZ+KOdAP3eRfBpyMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821799; c=relaxed/simple;
	bh=cQ7yRCUwSoB2DVmd2P1HeGf546fLmATSXNVT9cp7ucc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LR/aaY8t/Yo2irEvpvG3srjQAfkrrFnOPg0d9gS74nbf75BihDA150TeuFaq5boYYpj9Wg/6KWQnKujfVzCfgz/YvyNQA5jNCxj2HiZfiqCFE2xfm2U8tzpeXj2we4MXejeHbSqs4nBa3phj53nPr4l9HSQnfPf33ayJw+Bo7Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iMrZPc5m; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iMrZPc5m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTaOGxfYRYvUuguELYKCmre/Zj8mn+Nzouq97Y1eN0PNcwmhMqJ2mu8rf0HuDC/LeXN0N2apjvQA3lVIU9r3eu9O0o8W1iCEml7rYJjypOzkvXaYx2qEGk2s/K/my1y1YjpVU1bVj0L3g2zMx75tJKXjB6IJUJzfjMG/wD5z8L5D29A9Qx5NkpSfVfg8/VUa8TdxvWPp6vfSWmSpaFqh+ih4ijF8sC+t1MKdykfbUayT29GWEboqfyi8+rl8dOOxH6bcOAIWcLoLGjhIYMNU93Ig7/Bk87SATEBsDIoR7cQH5sU2/9B4TViTMpSnEtzKkqvEs45H0olwHvMMlWBB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsTlOiPA7UpFAGEhdGhGSDzJG07hWg43GuYdwvy2cbA=;
 b=Jye3Z/4k7uqHuQ4yDgtshlEUWb0BaSr6r8R3FCPA7sflLqjOeyfTQCsILzj3iuMDfctydeM4zaN3umxpFiUAj26gZjPkTS8K+bK6TmInsbhSck9jXV8dCUx4nXkIyOFLow9kdCAWWxKC/s82EumwxFuZ5Si5BiaJRhPrZWYOXGOsqSx5wcE04vokMjFawMPWJWekLmEVQWKo61Pr05ho03AfmTt1hDjT6Kh/mKAeuiW+XKK0DZqmUAfn97lYve9C/Tk3RvhbHv7i3mu0mdyPOnHPDWMAeAx0LtvIvMTtqWhfnNeOxM/KT1j1sU9B4IjziqskBc3iyy2w5Wxa4BuU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsTlOiPA7UpFAGEhdGhGSDzJG07hWg43GuYdwvy2cbA=;
 b=iMrZPc5mH4NTf00k8TUFjjBpZsbEiGcQOdEBQCJGqgjOnCZ5sRGr8y2HplJtQHndUaJcBs+W+ZjEyA2X1OAaQkPknUjr6dctQ50OYhPrKxyCAzbbeee2fT9SWiKt8wHhT1JrqbTwCx1VhIxVmdCx31zsWDjDz4yGNSUKqBD+Zxs=
Received: from BL1PR13CA0421.namprd13.prod.outlook.com (2603:10b6:208:2c3::6)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 06:03:13 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2d) by BL1PR13CA0421.outlook.office365.com
 (2603:10b6:208:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.5 via Frontend Transport; Thu, 6
 Feb 2025 06:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:03:12 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:03:09 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Thu, 6 Feb 2025 11:30:03 +0530
Message-ID: <20250206060003.685-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a88cfaa-39ad-4e58-803e-08dd4673f081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6goQmebU5PGGmjwRdUZ+m/bmgOwx1jOz5C8721e6gbRYEwNS+OIhGUS7osed?=
 =?us-ascii?Q?DVCNafgbZVNGt1pWMEvwdAQJ2OVsHGBkR3BZZ27ODujThy1kGiXqjZ11sHgJ?=
 =?us-ascii?Q?ux9LPWLLHlzKCvOlAmtd1AqoVakXWDtxC5dci4GmSIWnJ7+DAEy3jhxk461S?=
 =?us-ascii?Q?pudMMaZYtuCMyE6SF7tI/1cI9M5XmXsWRN/8XhlvjL9QZF63QuUSV2TjQQMg?=
 =?us-ascii?Q?+YzNJYyJxUCukwceTErWv7upKWf9/Nj1fmZAV0KFrfBRvMm7PqnN4MwvgNoz?=
 =?us-ascii?Q?fL9EgMTX+MwKzEQhI5/4qC6P34rJr/to1DWJuY0/+YRNj3wJrqmKeSGchKL6?=
 =?us-ascii?Q?oIu6MO3lbiMG+MH28+sikSosR6pdVjPDj8x4BR0RuIjmmCK6YRAdhOLeFelG?=
 =?us-ascii?Q?luv7IcD/bE4oebAdC0e08+gyU2Nm9Kt4bNLze/PlntfCs44B2rW8HRWrDY64?=
 =?us-ascii?Q?rWVfOd3UdbnTvIzbhdyxFXHirCcgACko0MOvRub6jGPh7bFyFV1jRvsHdTCd?=
 =?us-ascii?Q?x+rXF9xs5pMAWOhVhww7ogruE+Lg0N+HE6z0DxT97oVWE1qwP3TUvLihojJF?=
 =?us-ascii?Q?LUlPsvHRDHsYyVz60xe+RqqWEgAyrOFqyldtwDMpBogmiQBfgoziJppeCSEw?=
 =?us-ascii?Q?o5WQ+/QqWSBlG1Zj6kHb208ZHKXdZgZQYEhHmEs2D27xO4OjzpCdzDF7qi+k?=
 =?us-ascii?Q?kFL4vuGIHEyWpn2K7vcHmqqUCWVpbs+Ko17hHb8kqRtgK/T3NRkyGuuRpeWt?=
 =?us-ascii?Q?8v14mPcBoqvrhAKF9VSV32xSrGz6qROWip4fOy6/Eli0aGd4/9AOnTwLmHX2?=
 =?us-ascii?Q?N5ts3ZRkcIUDADuCCbLJj7y03RQIjtOcY4uyp2i3fg+eVcXfBPC+MmdcYT9A?=
 =?us-ascii?Q?ScFJsWYWKzSGIVrUUyH9p0T+uVgiUsGI/hPYr/g8Uc34JDpwmUiYc3h30En6?=
 =?us-ascii?Q?ZPbmT3MvibPIObD390Yng1CuEBDFvTgY00l+ba9SvBINivOZI1x16b1ysHbP?=
 =?us-ascii?Q?WaW3AZB2qShGXri0caVFzLZNbnKtxyaKpHHWwESl358uBocwiMBf/TD5UouR?=
 =?us-ascii?Q?Pp62uhnbTCsEIyph2139IIuxh8FC+vdFtwWCVhaV4FTswCJ428V6dVl/2HYe?=
 =?us-ascii?Q?ZbIl5aoXMmEwvF39pquTfOkatMI1j83r3YW7V9ZgeQ4rcgz++50oL/UeWf2q?=
 =?us-ascii?Q?TGse/FNmswZSj3SM+mDeLFTAHL4BnNBMyWyHs7S45G95gzks0c3GSQUtNV0l?=
 =?us-ascii?Q?W6yuD9tphh/NkblG4UH0OkMCL8L7hMNO2HVwjKU3y2wfUdCkbHzcJcggapQN?=
 =?us-ascii?Q?IZSnHsFEspbWWQ92Da7uzQzoLduKk6hPHFgBLiylDPW1ov49ukbPMSBq2KXo?=
 =?us-ascii?Q?Y9KXDJQWSmcmUI/iJRNUZcTauiAV+a/8KyKOJ+p6sHAS6ExuEXGO0NAk0jkC?=
 =?us-ascii?Q?XD95ajsBpYOvlhcF+V+yGJRKHQfH/DTwAZWEqb1qvX8j5Ia2RcOoWUJt14Ee?=
 =?us-ascii?Q?gkCaIPaan3uzGW0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:03:12.6055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a88cfaa-39ad-4e58-803e-08dd4673f081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

Add documentation describing how to use AMD IOMMU debugfs support to
dump IOMMU data structures - IRT table, Device table, Registers (MMIO and
Capability) and command buffer.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 Documentation/ABI/testing/debugfs-amd-iommu | 114 ++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

diff --git a/Documentation/ABI/testing/debugfs-amd-iommu b/Documentation/ABI/testing/debugfs-amd-iommu
new file mode 100644
index 000000000000..f318e3418435
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-amd-iommu
@@ -0,0 +1,114 @@
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/mmio
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an input read/write access file. In this file, the user input
+		mmio register offset for iommu<x> to print corresponding mmio register
+		of iommu<x>.
+
+		Example:
+		$ echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
+		$ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
+
+		Output:
+		Offset:0x18 Value:0x0003f48d
+
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/capability
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an input read/write access file. In this file, the user input
+                capability register offset for iommu<x> to print corresponding capability
+		register of iommu<x>.
+
+		Example:
+		$ echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
+		$ cat /sys/kernel/debug/iommu/amd/iommu00/capability
+
+		Output:
+		Offset:0x10 Value:0x00203040
+
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This file is an output read only file that contains iommu<x> command
+		buffer entries.
+
+		Examples:
+		$ cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
+
+		Output:
+		CMD Buffer Head Offset:339 Tail Offset:339
+		  0: 008350011000000100003c0000000000
+		  1: 0000000030000005fffff0037fffffff
+		  2: 008350011000000100003c0100000000
+		  3: 0000000030000005fffff0037fffffff
+		  4: 008350011000000100003c0200000000
+		  5: 0000000030000005fffff0037fffffff
+		  6: 008350011000000100003c0300000000
+		  7: 0000000030000005fffff0037fffffff
+		  8: 008350011000000100003c0400000000
+		  9: 0000000030000005fffff0037fffffff
+		 10: 008350011000000100003c0500000000
+		 11: 0000000030000005fffff0037fffffff
+		[...]
+
+What:		/sys/kernel/debug/iommu/amd/devid
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an input read/write file that takes device id user input.
+		This input can be used for dumping iommu data structures like
+		interrupt remapping table, device table etc.
+
+		Example:
+		1.
+		$ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
+		$ cat /sys/kernel/debug/iommu/amd/devid
+
+		Output:
+		0000:01:00.0
+
+		2.
+		$ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
+		$ cat /sys/kernel/debug/iommu/amd/devid
+
+		Output:
+		0000:01:00.0
+
+What:		/sys/kernel/debug/iommu/amd/devtbl
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an output read only file that contains device table entry for
+		the device id input given in /sys/kernel/debug/iommu/amd/devid.
+
+		Example:
+		$ cat /sys/kernel/debug/iommu/amd/devtbl
+
+		Output:
+		DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
+		0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
+
+What:		/sys/kernel/debug/iommu/amd/irqtbl
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an output read only file that contains IRT table valid entries
+		for the device id input given in /sys/kernel/debug/iommu/amd/devid.
+
+		Example:
+		$ cat /sys/kernel/debug/iommu/amd/irqtbl
+
+		Output:
+		DeviceId 0000:01:00.0
+		IRT[0000] 00000000000000200000000000000241
+		IRT[0001] 00000000000000200000000000000841
+		IRT[0002] 00000000000000200000000000002041
+		IRT[0003] 00000000000000200000000000008041
+		IRT[0004] 00000000000000200000000000020041
+		IRT[0005] 00000000000000200000000000080041
+		IRT[0006] 00000000000000200000000000200041
+		IRT[0007] 00000000000000200000000000800041
+		[...]
-- 
2.25.1

