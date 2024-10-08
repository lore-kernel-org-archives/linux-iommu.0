Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7831779B1
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384187; cv=fail; b=qJHjagsgx7QiX1A/aVui7D/CCsGQAMf/nt6EwHOltaVvpfJ3IcwspqmX+DPsGwdwHriioydZbjKMoXXc8KpsoWFnAWkFnvGMZAtSjdNUANUKJT+S2h4M3dvAFmijxRbjz3INUj22soVpPEtJZxSWcdot4vy0Kaf2H6GZBd5ukRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384187; c=relaxed/simple;
	bh=p3kUZtsfcXwmV2UBmLTMpjVijuUfeSP4TQ/FEkeiDe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wamv5HH8fmJZBVLM83RnGevVyxPmmT12rYSe2hkTL4gEmInRPU1aIqQ6dCSJleyBe+A2pe2U+QmVYtHI7JJF6NaLRg+hTucqdUog4H+aAOXHr0eZmQK1J/HkrGN2Id34R7Y1qAPEAhccBilK/k+3x/abpTm6/LHz3PX9/JmaGvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0yWPpXq; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0yWPpXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMzzyJ3UMXTInu1B2FKnYrJq4g6XqWHqArs8B0RILjwuRhUydiY63aiM9ZkDCiViwsLKJuWd/xEV6ukzND+MAvlGa8CEzUzbsHTa4dVx8TUBK71ArIJte/2Skg94Mt5sDcgkJrV7FA3fSDmnn3JQksPhZ3N4FmMNOxwOfvNPMkntKxA/nxC5Tud/PNddILGrlAwlHghZhgtksEGU8dHsAjknga+8Ln78wMcemBx8aagdG45aiHgRE6fY9ximqpeQxfJoklybar7Da+Cvr4Ply6yCcwOTbH65CLz/dm+JsIV6GI0FnIhcSZ6uUzN7Ls2O6iTgT6qB46BlhEv5twwHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpvugTu5VJxcN4v9VGPgnr1vbZmjzmYF5b8PA9baRHE=;
 b=bwUUUzLZyzfk7wOXcvGKJgWyTRKKiE7JtR3o4Ym4rd+gK2WUx+cXh3g/jjJFXeB9PWuqNf6DN+vyfQTyEhCaltueAkQvS2oEocCzyNb/zjxI0dwpxmRYfQEjYGlD7RXvKMvoJ+OqgPZvs5fQ68ZkjOAw67RpJDq233C0MWzvJRTowDyjOY8oKx1kPYoHSy3O8LGycnkR1FNe3GDot6k7D2z+/RqMpG2Zh2rZw1SqFo85gZ2dvcMm5v/kXQlTPBihO3Ia/sKPRl0Nip4yGcjMHMmpAyvuTwfYNRxa/DZRwLa7L2niymMTMeuOx+UlK+e+697cDonmGsHXE2QXU3th7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpvugTu5VJxcN4v9VGPgnr1vbZmjzmYF5b8PA9baRHE=;
 b=V0yWPpXq52bg3Y8Aryay+cqNZKimId+seFy90oF+ISm9T97H75fyObmtiJpiRVEIOZ2ojdbvaze5l3UdUZ/sOhpllxEANoU4GeTrjAubQALMklQN2hNqu/raBov7g+iKTM7Pafu9zTHVobC1QmPvW8klAhOJJLegfVvyqPbxpog=
Received: from PH7P221CA0072.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::10)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 10:43:01 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::2e) by PH7P221CA0072.outlook.office365.com
 (2603:10b6:510:328::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 10:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:43:00 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:42:57 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Tue, 8 Oct 2024 16:10:35 +0530
Message-ID: <20241008104035.4008-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
References: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: bcde736c-4a9f-46c5-f996-08dce785fb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KEgHtcz+YL+odQiEIvOjyqq9LoqpDpS3pifdyfTf6ov2io7stOxaod+lM/i?=
 =?us-ascii?Q?Mcr23sXFV6R77AoFhkMV4IIDy2rCj2KH/c2/E8nuTbJqnMzfV5zRf5L+VALq?=
 =?us-ascii?Q?5xesKQgvdk5MoNxsZaMN9sMkAmuYtEWrkGXrD1Hq2ZK0N8kYFRG3K7ceGb/H?=
 =?us-ascii?Q?4OcuEEgfxX44hYCmZN+4+3GBJlK4IclfglqvP0VaY24Wfd3r34Q2R4omT05F?=
 =?us-ascii?Q?QJf1/7n4mBNSPzlz/x5AGPPA2o3FfCTixXB7QbZvUeeYJTtuydyLdckIYLG+?=
 =?us-ascii?Q?ZnhRpc0eZjUDC7C9aG7o///e2y0JO3vBi9sov1IYjLYAojc8WSSp35dh47Wn?=
 =?us-ascii?Q?nbsOFcQmKvVeoc9PVQJC9/7Widcarq7oDFIgvQDs8sXkE4M0MYkBXKBxj4WF?=
 =?us-ascii?Q?7P69m7vmiz6UBQj2Zeq9EcW2wD+845gL5+3KfQnxft45WLghzJxiqriUZ4BA?=
 =?us-ascii?Q?eJMu0gLQf9dElBQf2zvtfmMutKz8uR9d++c93LsztXOTzmMc+alfEMY1RDPx?=
 =?us-ascii?Q?4eDhbTyTp742h53NMtVkTii1mTF2A0VnfTSMsAZto+6/Eod8+SEcX0U5L/T4?=
 =?us-ascii?Q?Jc9tKmr1d2megLKXeQB2HIDOthnVgtE6pPUV+yVo7RMsAK3onk7SdMMhQ2Nt?=
 =?us-ascii?Q?t2VBNvAaSqPOx+ssFG8mfRagLSLx4prjPJDOdlNU7HwDwSrw1S03rpbI2phQ?=
 =?us-ascii?Q?6FjMJdghEz7fzoKFd+hi2X7NPWJZy3zr0e2pmpphBENDEhk2DQL3RgjR5KUP?=
 =?us-ascii?Q?9RwmexqfFvlzlgGF7HJ0ri8cxXB34tLOsOOOU1+4Fh9j/GJ3DzbWFIE4ahkP?=
 =?us-ascii?Q?GK3RvO1qZj7B+nBiwzYPCqul2rjvwO6kO7R8CZiSx0GI6JovKCkwkWRnQBzT?=
 =?us-ascii?Q?XKwXDz86HlPm3wtu7OmT0tq5hnMyie8eawKSWxWog6EEFCOHs4XosZSmJ6s0?=
 =?us-ascii?Q?/tpFZRqb7tfsSAYHh0x68Iue4oNM5itdV0PWqKTgyESXkBPOHzWPoxy/fecu?=
 =?us-ascii?Q?IkxgtRZck0TO2UoDpn0t2SDv7K5NnzUh3HSBRuVmw4Z3zBVVQFgd+Z0E9o9B?=
 =?us-ascii?Q?oSV+mjzT7DS0ggw93uf3fno/T9/jWkZpXUHOLPsN2AIVZ6MKZx8QFIXDs/ek?=
 =?us-ascii?Q?NsraNRGzD07svDAwQsOvZoXSjwHRu6/2EAD5hmglCEhfhpmMigYbUtqUIl3v?=
 =?us-ascii?Q?TyiCYlzsioCgmonxSFkGGfNveV/8cKAEKSdTabOiJVvtyhhFlAGlp3g+ltwk?=
 =?us-ascii?Q?bBLjndW5JS5zjAUOCcBdknlyDhaoIvPDPrcWq85wgDNmI5/aqAJhKV0SjvRj?=
 =?us-ascii?Q?9WhAi8zj/FytC4JyRNuIlCzbLDEFJYu1ojr8cU+QTbGG4WVLIFkK1jzWraLU?=
 =?us-ascii?Q?fLDTcsnbMGV1Ln4eaxtRVfvQ9a8x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:43:00.8482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcde736c-4a9f-46c5-f996-08dce785fb28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

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
index 000000000000..7acdb38bdf7b
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
+		CMD Buffer Head pointer register:0x00000b90 Tail pointer register:0x00000b90
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
+What:		/sys/kernel/debug/iommu/devtbl
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

