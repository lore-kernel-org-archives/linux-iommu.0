Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31167199E8D
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212908; cv=fail; b=ovGe41eWQJ8FWbFvLO4bXOnf6vONxjMkeNkGYtAKxayT4G/BftBKvRi766HB2MFvCE9Cz8MCysrLwq+XdXITbBPdCJog9o1lhediOKZD1NmTTKaXKO44DuiyXL5FNyVT7Zc+Vf/LILzT7A8A8qJzyrrpJ0RFTl9s8TqVcCjas8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212908; c=relaxed/simple;
	bh=u45gRG09t+Bf/4ArgvzB3OtoJtbd+cwqjoAlha34Yno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnknLrcJoKGX50PASARjDCueGkwiPN63Yyt+0ueOB4KEKqNnBfozrijvfRW9y6/aKUet63elwisfIekhxxYrhsGJYQVH+XPcAAfDriq+QOKDqHrXIEXXHxfY7IAl//vL22dOyzlBhyimlZu9WZzrtOpKnpIr7TV4CMOGx26k/o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b1fQxT3V; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b1fQxT3V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIIVk8ShsqxlwNiuQwob7EpudCcce1y4qE+zOhWyt8gsYKddqKxkwOOYtOT6J9dBJLwi2guTc//oVsruBQqNwAiyDv22JjpDIkEqY1FH7YQ5ZmzdD/oqnnwJJiZPQidw0PcIHEapCbhvhf9minKeRzZChenRWEUb1fqG+roHop3lPagZ58XWt4iLj4PW/YeZQkxDucc3AitRZJxySfXGsc0K0RiU/2ycVfVy1KHqY8aLWOf3DOFM7QQYUDIsQ3JV3CYGz5rUhpk9RSAq7qp2MWn8PCa70BKCiEcYaaQ+hCby44LnQiadsmJMPWwX0svlHIOk0Irbxd6aF+L+AFrmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhJ3VDC+gV45J0T7wmxQBerr0ApFO0V7MKrknw/L6RY=;
 b=Wn+/P0nshIRWvmonz7PALYdbFYocTYS4yVT8r+o/RJJkUw2vGOgEXtFDA0V2OaS3JMCskOVwcqc5aIbsHRZtCGqTQ5U4Cggr2UN/etZP3/U70ndHeHHxvln66QM2pPncEe8QGeuJTEKcfJ8M3DCb1lVPy/URwq6I7WJBWQgwZk7MGMaHBSbSQGW2d+S3pgZ0ZW8TOS+v0RkrhP1/MZ+dWYFieUwwC0pMGvMhs+DgNO4HqmPtXvpn2xLfCIFDDKZQoOBoJefTbdXp2O8JCiMOgtQX9vI75bvH0osVR6sbFsW9GFOTQz+4ptoY5Le8M0ZpYSevrgW9sU+0Q+pwotyIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhJ3VDC+gV45J0T7wmxQBerr0ApFO0V7MKrknw/L6RY=;
 b=b1fQxT3VebbZOQzMmr2i+OQ+6k+2wXXey5tN1v96J/IwVe3J0u/WRCaDDabv0FfcaF9xSsX2W6LmR/T2VqqvKqh0ouSG8EYxfQTHqEA/f5RFj2F3fYWapThjNdZoMynwxEz+AVkDIbWRBOZ585WJLkoyohNuqmHjX6BT9Kd6T7o=
Received: from BYAPR07CA0028.namprd07.prod.outlook.com (2603:10b6:a02:bc::41)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:01:37 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::cb) by BYAPR07CA0028.outlook.office365.com
 (2603:10b6:a02:bc::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Mon,
 17 Mar 2025 12:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 12:01:37 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 07:01:33 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Mon, 17 Mar 2025 17:28:30 +0530
Message-ID: <20250317115830.3416-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d62b52b-ebc7-4d4a-aabc-08dd654b785e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vu38RvVgDxxR/23a3FP52SGgczzdKWK1XaCkLe46F9Yw7O7aOB03Ecpfky/W?=
 =?us-ascii?Q?RZ4eom5xVjz11QOEnwxqARCQcVRrJbRNeh4yUXjR9uVIkJrDv6ELz9yRqXzN?=
 =?us-ascii?Q?M65nbJ55ivNWVY0cy/WQSsH0uDVupQojAHmXItXN8VUhpEFYVEfaOBWjp+wO?=
 =?us-ascii?Q?+2sX4ps0EasfqfKqpTNcNejqrrFyrwiiirVOhfekCUt6Wzf9FrgnAuB8l3Fn?=
 =?us-ascii?Q?fA2mdwdiO2R8Hbc0rfUl1QDU6N/yoVETcHlDV2a2Gh3OZW6R2Gz599DZq842?=
 =?us-ascii?Q?m7VijEx7D5MpJ5PkkmIAflGjbUtSHmmRvYpsfC4NYic6jTttgpNKOm9DqlYE?=
 =?us-ascii?Q?pXvrOeBBZMigZrLZTQLzrZIrMbzct+f4pjNak4dRVOtlpYHprNUQWCRBzN3M?=
 =?us-ascii?Q?FK996uwpxcPlRIMod+1fMM4iQfAjU6PeeJnhvBB+gUd0y+wE8kHl49Ll+2Xw?=
 =?us-ascii?Q?R1mJLVqHABpRimrlcbR+eH5sbm7JZdD3AbyMpWeMPQ8Po2ZinrPt8Ld/TUNH?=
 =?us-ascii?Q?kVAU6++EwLwqtyZ9bT87bLxyGgU2g2j5WRwcxTKl6BsxtAV381emW4wL3thZ?=
 =?us-ascii?Q?1QvWdw+Ieyw1yAk6Vs0rmPPNG6+DSdFNlgWfgA4WvJDY4vFV94UT7ZYji215?=
 =?us-ascii?Q?n0NFd60cB2k/pIO9hT1LHbP3CjMJPJ+b0gWmjeTdPQ3xmfyLmD5MfvN+2Mqa?=
 =?us-ascii?Q?75WMXRD+T3UMt0eVDMwtBsC/oD+H+CZjzJLrgWsRIldKK9AuY4Jed4EYSuCC?=
 =?us-ascii?Q?Yu1vuXv+T8kxUCisZcDcmiHeIW2JPNaAnF28nQkGXpv9VyZ6qL5raokvWkXP?=
 =?us-ascii?Q?QCwl9rG4WKBvsKg4MxXksV22cAAn7VrrMcjoPNCSvFo9hCAyFHcbbVGi/jqm?=
 =?us-ascii?Q?XVUGFEqU1HtW05YdRYCQ259hMEpZg/sRs6LKczwwVbVIFdceeZNVyenK3liV?=
 =?us-ascii?Q?+aJwU16JNkmu0FwoDx0sXHc6uhQGRxqo1AI8xT6D6ohMFaGhFoKYwGJ7qesP?=
 =?us-ascii?Q?W9i/uuoO8rS1MJ7kUgCG6oCRGNk3HuUZjDLWnn6BtQlQbALvQ5w2OkdMmrVM?=
 =?us-ascii?Q?RwF64pJyVu/nuDB+LJ950TNO4XdDww5A3+9YHIl0x3DLqToTjhlXSy/XWC8B?=
 =?us-ascii?Q?DpVIt6licBCQaDkB6Yiz9QtKDbc4//qq+JdWGxUtPMgwAdm+JFUYCZHJTPKR?=
 =?us-ascii?Q?jWMZEjwt3b1F70EnO0jq6GrFBtIZOCkLcuSkokZW2NcKwcCe6dgIncuVcOY+?=
 =?us-ascii?Q?IC0hP0hgk7G0ikgky1Vj/zMVIGBfx7sQgyFWisfFhrJ9EDmppFGlIiy5cO3Z?=
 =?us-ascii?Q?142FVtt5iuJrJVcBJAIKn8knV49/ebawn22lXeg189Yc7vQF0Tu/MuLjfxEv?=
 =?us-ascii?Q?Wb0KnFF8AWXHYLywHObrQ8KxloRiVLuaG+6JgEqdLqKSpkHD/2noXxSdPyTR?=
 =?us-ascii?Q?s5nH8ttrDBIFN8wDfZT9ItyNXaSFLW1SQi+vhT+uWg8nJD7X2M5lBzVoEV3p?=
 =?us-ascii?Q?d8tjEe3XlklLlIo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:01:37.1494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d62b52b-ebc7-4d4a-aabc-08dd654b785e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085

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
index 000000000000..49efc74c8e6f
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
+		Offset:0x18 Value:0x000c22000003f48d
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

