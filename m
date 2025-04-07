Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352CD219A7D
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047494; cv=fail; b=raGEewY/yRflgKKvFKBK150t0D1u9KHKOn67Hy3b2Huy9fR7/p8PIaNiMIC0loifSguxkVRKCpAiskk8tArpLbc7LRSUcC57qhYW3OnEKm9Ex5Mc+OCD2C9gs56etPvNtk7TkTMtV0/XGYscVa/Kp+u6oNKd3/3bXXw3H69vEm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047494; c=relaxed/simple;
	bh=0rk3R9SZ+AXNmTy8D21OmTkESyjvQg71OQKf90faPW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkJD9csSRtfAj27mTUUFVtzS4joxkGA8rmLqHcox1rqGEr78X8Vb3vi/i3FxY6JlQ4q4AJSsL741eIo4IUxKD0OxiNYdjFJM5ic+1kRgvKdbtS3CCizG1bsPT9/CHKVgCoYH+HxsSjhIfLv/zn2G1IUimND9n/EPuc3o8JsQEHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgXAbbfq; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgXAbbfq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3UP8fikSUI3wSlsciU+bzo7DknIwJ4CXxIctvYRopgapfgkUFKQk+y4JgF2shCOlPknUir25kZZSSoAEVcnckOu5XQJy0vQ8go0LlfkH9Q6llndkWpWOygoJyEQRQNKQkwHnqOxvzgv4OJGf5T1RVJxD/pnORIimx0Nj+b1AKGILqf+RCrY8/N9hGRGEgqwr1S2g/UDweaStTZNw6l2s0NWK142r+WYSrwFvHF9dJP9ujlSw/n02pU2f1uN7QBhxiaaF252yPQRnsEEt3+xEoe0ieqA1v9JQ4I04nMp8h+F4i14k2ubneIwKupZdsNqCBcQRl/+WByxf0htVxCLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzu4iNpyeuOBW8qNSg9xV+4SnO95FhoMf0dI192aRfA=;
 b=k+IDQuCVORZvBJ/i26s2p4sehncXTt5l3F4FLYtx17kuTqfwnCH4IfhZ5gISyv3oZ7ETb/QLif1T8eh7vYGOzkv9SNBeN3T1mUl1tk/wMeDHZzj+WFG5tCo2ZDxAC8XLgUBEMAaGRCuoXydUl/elZqXyWz0YcNTsav3tSzEhhcWw8M7aG0CY4fY8n4DkNMMdMfwwmxzKKyP6lym2qiyruLHIZu9ZB2i0N+bIKvMDN5Ep26n22NPtIt2LRSZVnLkrTflVyN3exz7GqD+D+OBBfrLsgLLdn9wJBjI9EjgrKeCUgxbC2jXzTmTPzsDK04c6O2SAVUHyidHTerF4UCU8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzu4iNpyeuOBW8qNSg9xV+4SnO95FhoMf0dI192aRfA=;
 b=cgXAbbfqJTk8t8noIX3sRfTIV7QSXxtxqr0b4RWw2p+PcRJ0d5DL6OXH/vNbHhGW1ua6qIabCFGsq9hvRZ50nh+iOsFnjtwnzpzejc7N8a190rt6n8F/nMos+yEVMKWuqoCZemUgfgzQmA5jVfe9aQeqO+pxpNw7kVyNalQou4E=
Received: from DM6PR01CA0017.prod.exchangelabs.com (2603:10b6:5:296::22) by
 PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 17:38:08 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::82) by DM6PR01CA0017.outlook.office365.com
 (2603:10b6:5:296::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 17:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:38:08 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:38:03 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Mon, 7 Apr 2025 23:05:00 +0530
Message-ID: <20250407173500.1827-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
References: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cedbbf-7fbc-4a9e-d044-08dd75faf5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x6/6WorvsLE2MfY/KwcBN6bMucp1RNZPvREg6jgysa1rgtgOW2CNQ5ZW31Oz?=
 =?us-ascii?Q?BtIS8dXtMQWbcnx1aIlQ3f3DVlmlrkUGydJDy/p790Ww2LqUElswLb522sz+?=
 =?us-ascii?Q?NfLKi+E/aiIgFSo8mrYSA4V+fsdPh4iQWidwYPnlzsoUMKe0m9CkbArDNtO6?=
 =?us-ascii?Q?yxhTsDlTrZeWEBRvnIRvzl0UFObvv3M5v7y1Bmo3nPqok79ldrx8tFyrA5Qo?=
 =?us-ascii?Q?MUWbseawCtMnKBoIIKj40Ydh5vdPMk42p0kog1MFjptPllTZHlyacGZQUWdW?=
 =?us-ascii?Q?9anrLsMaLYolaWTCUriYUcZ+WfI5XczTa3El1IxT76Ky6WSGUF/1w4roSl3u?=
 =?us-ascii?Q?7mOiNtW8XlOrpu3shdxnURUqgxJCOMPD0R372KgXXqeSt2dPD0afBHx/xD53?=
 =?us-ascii?Q?HT1nJ0+Bi9w6t851aJV86KtXEwktoO8mc+gVw3YUL0OC7arlbQv11ttJXCoN?=
 =?us-ascii?Q?0teca7yjOPC88GNOTD+eW5di8QzQcAzqbeUj7te3/0GY1qCY/JjpdgLOi1wX?=
 =?us-ascii?Q?uD4+7QmN3pGdDltdCPBjkVD+SsoBeVr+3XtbqqYA2Z27rpeRSgObaD9Kfe7w?=
 =?us-ascii?Q?7jDbE0f7WNv49KXvfNEYV2RCZhr7HoYsmeRoEpIzUTI78HRd+7q3QoWgtd/+?=
 =?us-ascii?Q?9Bd6e9w7eOX08C1Kh1yVo463rCiaxXbnaPRCq2N31of9n3Z+iO3De8cff0q9?=
 =?us-ascii?Q?/aIEtN1a3HbPn6dgiWl93s+Hrk+vrvdcCeVN16JbohWS3ITyIKtlmnMBcfoq?=
 =?us-ascii?Q?yWXb8bMLSzlCgO9Rr1OQWcrNXDSL7KjfeH78SfKXL1r4X5QxqoJ7zQsVna+Y?=
 =?us-ascii?Q?hrncnnat2HcR24r1HvwSeVvfIw67ptacdMsxA9LJ5aZryAzIyhCPrHyqTTKe?=
 =?us-ascii?Q?9dFYd7DzK77dW3hG11fQ8oCQ0fPKsQNCp734x9Lh4Ll/O+XOKc8CSZCyYfe0?=
 =?us-ascii?Q?PNiN19/gmhuEogJzdhEIw2cal/VYGMj5xvkX/Nkeg9zRINhNw2vAYd+jS8k8?=
 =?us-ascii?Q?9/CkKMibMnk7rbuu3fVnYXJSvCpL1UGspqIAiMo2sugn1UfF2vYmB8BJ9+EL?=
 =?us-ascii?Q?tQ1DOScKJAexS0+/f9F4JOEw2qHdhkX6ZDD6hp4UpLAD0fjDXjyywyRCjpqv?=
 =?us-ascii?Q?opU+xxBgOHQcsQie1hBxaJnVAXb/s5eWzoXkp+m41vpQPN1HAZwoFA0IYLNp?=
 =?us-ascii?Q?pk4TRedEWhcHDNPnxPKfz9mjG2UeDBBBAd3OxGeDhybPWpi6b1LN/wtzFBC3?=
 =?us-ascii?Q?rctt6wZGEyFl90uPZojs64b5SHrqsNFqy0qGg5vXnTgcQ9fSCQHATl04Og9F?=
 =?us-ascii?Q?JMpzPDrA+Vk5/VssDylhZ7RDLgqzcSKY8jiybNocPlh89BC6owvsDn7bxw4T?=
 =?us-ascii?Q?EgI8HVTZa3he7JLSBQtv8LVKDjip7TXA5jl0VMIqzPF3B7BvGk78NkbSuTa8?=
 =?us-ascii?Q?lO67AMPUrUmd1GRg7omKKoQkgXjlD3h7E6eKevzExSEebyqLe6G20rfLdh4z?=
 =?us-ascii?Q?7/A06esiMjSU8V0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:38:08.4931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cedbbf-7fbc-4a9e-d044-08dd75faf5fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668

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
index 000000000000..7d6cf1f602ed
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-amd-iommu
@@ -0,0 +1,114 @@
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/mmio
+Date:		January 2025
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
+		Offset:0x18 Value:0x000c22000003f48d
+
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/capability
+Date:		January 2025
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
+Date:		January 2025
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
+		  0: 00835001 10000001 00003c00 00000000
+		  1: 00000000 30000005 fffff003 7fffffff
+		  2: 00835001 10000001 00003c01 00000000
+		  3: 00000000 30000005 fffff003 7fffffff
+		  4: 00835001 10000001 00003c02 00000000
+		  5: 00000000 30000005 fffff003 7fffffff
+		  6: 00835001 10000001 00003c03 00000000
+		  7: 00000000 30000005 fffff003 7fffffff
+		  8: 00835001 10000001 00003c04 00000000
+		  9: 00000000 30000005 fffff003 7fffffff
+		 10: 00835001 10000001 00003c05 00000000
+		 11: 00000000 30000005 fffff003 7fffffff
+		[...]
+
+What:		/sys/kernel/debug/iommu/amd/devid
+Date:		January 2025
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
+Date:		January 2025
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
+Date:		January 2025
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
+		IRT[0000] 0000000000000020 0000000000000241
+		IRT[0001] 0000000000000020 0000000000000841
+		IRT[0002] 0000000000000020 0000000000002041
+		IRT[0003] 0000000000000020 0000000000008041
+		IRT[0004] 0000000000000020 0000000000020041
+		IRT[0005] 0000000000000020 0000000000080041
+		IRT[0006] 0000000000000020 0000000000200041
+		IRT[0007] 0000000000000020 0000000000800041
+		[...]
-- 
2.25.1

