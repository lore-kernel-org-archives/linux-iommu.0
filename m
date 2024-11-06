Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C01CF2AE
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879704; cv=fail; b=KyStN9TP4fpggbkV1g9xoz2XbNW/B78PZIkpdo/UKTji3zwYE9g0FMmxZczy3NyrEy3DgfAQnZfRpy9TQmH8yLJIk/rYoIjlz6ef2ZcmElj+mOqxgi1zz5QSy55KBkX1nfzoeCHUK2Q4FdH6ZRjsgUrauIMRubwAKyICBDmCWX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879704; c=relaxed/simple;
	bh=zgW/WA/0HRq3U5JUbW90ya/nCzPsgbcMjdW07MqsHX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOsDtVs2MLWiL8bwUKxJPnoTBNPC8cBm3bcTKI7oX1qEXgqimgzZwYRsudJgV49bb2BliIfQKp+cqS3VWcr7aa1d6PGxgg0lIdNPf4drlCBKycUGkDT7ga87xYZHCANCi0G2QFswflT+qKEY7Q+LU3eRPC4VwtH/YrC5amBCHnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kAsUOKQv; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kAsUOKQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDvXAJXgVCsFKL/A++4ur6hZO8hUcw/k1KhZkziQ6bcSdLSIVAL2NTG7APYfq9GvVE1rWZlxFJeG7grwi3D1V9bXg/FZFi92EiC+nApcE4UaKZHRshal6X8fpzC+YpyRN73SeCw/0VO6UZAos/VEPtPXvH+yiV7IFIiIwNNGJtvHnZHJD0pYFZOa+Ruqr9ViyWdUdzc4Ev/G15C+c+XDgDtote1hZoFVQW+1Hc1EBfezzH1AK6GO96B5cEKU54qJzSaTjt+TRpsH3OTVJiyQdvwbS5Ih9fXhCS+fZ7OLNAWLU6Anz41TaO+yEgLUxcE4uF36Mm+prY/RdppmXYFwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ARFf25kJpv4NqyfZyZtLT7RekhZqR3rK6YmDLrHYkY=;
 b=pnYP7OrqinGJh1Dt5mtn7zyMwi3DGUoxMh1O0M0pBq6DD9Ml29zLsrk4Ly+N7Ay7OeP8yHs1QBZnP4T260Vg6w09CQTBVe6zwnXfMPVatuc0ubFzVqQY1DLj+03cdTJ64q6WeSqRD5ADnIkTngNEkCX4CRGhSJO+QZL56VKaEnjpDPZ/P6mMjGWb96v/XH+I9Z1YR+0r8iRlY9HiVIqVPSQLf6VuG+7Bq9vudwM5oJyPgWgYYJtMJH7rULrVt12tc8Xk1Uit49SB9sHSbsDwOF6o2JD6cvvwLGnTw2Qfib8Xdzv2wmmtMZhK4MsK/7/p9GNme1KJSrC2aECYpuO+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ARFf25kJpv4NqyfZyZtLT7RekhZqR3rK6YmDLrHYkY=;
 b=kAsUOKQvDh7k4u116zYYaGzdXqpMSpHwVkoX4yyMRiIfj8YOKo6073py61aaEQJmZzzRxtJwgqPICQqEkAEEOryfkYGzq6fK7uxwMBNG2+97FxZoxn7uF3Po3rx8UEfwmp4kD4zY/owJR/8BHQFfV+XwjG3pFEn7k8Q4MnsPNx8=
Received: from BN9PR03CA0433.namprd03.prod.outlook.com (2603:10b6:408:113::18)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 07:54:58 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::b1) by BN9PR03CA0433.outlook.office365.com
 (2603:10b6:408:113::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 07:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:54:58 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:53:38 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Wed, 6 Nov 2024 13:16:39 +0530
Message-ID: <20241106074639.2039-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
References: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: adfabb37-154e-4f8f-d4f2-08dcfe384f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94CbQbzOVZCJLfnXh5tAVd3CHlX7F/Co7WU+hlyxkRQ5ta4tDKmeOU4v+C2U?=
 =?us-ascii?Q?mxqGnLUTdEowhMsl/LugfV9vv99hTtIosNMYr/s2xOBleQdd78lxxn51lnUh?=
 =?us-ascii?Q?ZrzhwN/Wu1Tr2fuUcCpr6v44qk4AXtHHC1EDhvnhLDY/HblTb8qzGkEwFw/M?=
 =?us-ascii?Q?9i1N+xthFX1jOrYHrylbwCoLcDZFt3DgSzXfx0f0hotGUdMgu2fEJm3gi+tB?=
 =?us-ascii?Q?LXeoyfuwRvN8UQMqKHnX8tBWE2QY+JIJWQkv84pI6WlhRvibvqxu9VNO6hMi?=
 =?us-ascii?Q?bLTVAgZ1YW/6Oc7aFv+MJC78VH+jBgGNYxZ8HvOGbqPXAKSq4vkzOlkFc66e?=
 =?us-ascii?Q?8AGGLlf6djZCU6NcWVR355koqCWTRDJ70PGygLkWW8pzY7XCZlNKPK4Fh5/3?=
 =?us-ascii?Q?1vlLIVG/pvD0oo4Brk6dBzPbSuoiRK0RhanuMWn/IIJaK37QaQwrf+/5PGJ6?=
 =?us-ascii?Q?VNZWLjyh8+afpbE76BpfIcDub5slXeMmJRaeBW8ieyH/y38Phh1rIqw2QC8l?=
 =?us-ascii?Q?FHqA/Rt2EIkSALXyNkzThXeOayLs3WX2xAEXCfMkM6qmzK8P4GH/DEtKT0Bt?=
 =?us-ascii?Q?v4co7JGKE1drs0WqdCR4hMKkYC/HaZZI0Uo9MescCVl1VfZQ3/YDvCEod5q3?=
 =?us-ascii?Q?31yDi5XE6aE5isw6YBCzLiXjkhO8tzeSJas0LRWkASNkcJRqWjvwUlOdFxGv?=
 =?us-ascii?Q?iVWtfVoz4DVsMI9FD3cTISEbi/NplPsANS97xUy9EZ5488W4w7A4gjFbGZXO?=
 =?us-ascii?Q?o37BuxQZAkCQtJyoa/JOi1F1/MkSBAU23My8w5rRNaeJuxs3FQ6LBr7DGG1H?=
 =?us-ascii?Q?fcaGwmrEVAKcevKfA7w7Sm9t6+t30R4QXweQEDy5LD6qe/UqadgZqRcGUdGt?=
 =?us-ascii?Q?wmWwLUiojaMVVwwDpydzxQLAazdaNjSuK9xGtO8dPOmWrmvT0jkpzwsWab70?=
 =?us-ascii?Q?LDYIOqQ7X335DZ4AJVK5EL7O2kvH0kfG1HhUCVdEz8FDQzbR+EPdUrftRcWF?=
 =?us-ascii?Q?xM7p1XPByqoGldl29kmtwaWQBD4Uu7D/dc41rOf9hhNoXClr2+IJZVHr5w5z?=
 =?us-ascii?Q?gB9FWezsdSAGOQ7c1rishjp5qN5YdhSG1xmHhfEF8LSftkLvCj3RbR+OhP08?=
 =?us-ascii?Q?P5IhrIfsSEqUnYvI/9iu+ENr/aBEpKDjchu/rkVjwTw2Qha+SBZGyoumigVu?=
 =?us-ascii?Q?+cZ5d+NyjFh6RS3Twuyv5gVPD8A0iM9F/zaLOESh0CQiNc6cIx3/LO+OjBYH?=
 =?us-ascii?Q?ZD5EN+yiIktnmayjl0CZFJUrB7ucLpWYRNqupbFGfxXO5y/xf/MYu3KIslNv?=
 =?us-ascii?Q?RMkDcDsDlfCx/Jh2h2sQm1mLcEs09xF/2qax4WetYweZMjL1i8urhrKj611F?=
 =?us-ascii?Q?aTe2GF9t9ugNEFS+i/JyWtT2bsqaZza0mVX8hoAC37GfLKjKNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:54:58.3465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adfabb37-154e-4f8f-d4f2-08dcfe384f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608

Add documentation describing how to use AMD IOMMU debugfs support to
dump IOMMU data structures - IRT table, Device table, Registers (MMIO and
Capability) and command buffer.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 Documentation/ABI/testing/debugfs-amd-iommu | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu

diff --git a/Documentation/ABI/testing/debugfs-amd-iommu b/Documentation/ABI/testing/debugfs-amd-iommu
new file mode 100644
index 000000000000..9f7741e05217
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-amd-iommu
@@ -0,0 +1,140 @@
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
+		0x18
+
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/mmio_dump
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an output read only file that contains mmio register
+		value at offset "/sys/kernel/debug/iommu/amd/iommu<x>/mmio".
+
+		Example:
+		$ cat /sys/kernel/debug/iommu/amd/iommu00/mmio_dump
+
+		Output:
+		0x0003f48d
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
+		0x10
+
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/capability_dump
+Date:		September 2024
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This is an output read only file that contains capability register
+                value at offset "/sys/kernel/debug/iommu/amd/iommu<x>/capability".
+
+		Example:
+		$ cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump
+
+		Output:
+		0x00203040
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
+What:		/sys/kernel/debug/iommu/devtbl
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
+What:		/sys/kernel/debug/iommu/irqtbl
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

