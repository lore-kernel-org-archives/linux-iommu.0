Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456E1DED4A
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055178; cv=fail; b=rkQ690jTVQndRhPfqJAaYPhkdnRelXwEX1oJpXAIggmgFHVDSi1SAK9uuv77q6FYOmrVxjW3wPw80DmGasxJNadIr+4unxPch+MNeVyDDv1zLzW5rFlElV9VqvUcUmF3RBr+CsQXqgf4e0qp7GiDm/5YDyaeY2Yqxpn19Z63ZhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055178; c=relaxed/simple;
	bh=0rk3R9SZ+AXNmTy8D21OmTkESyjvQg71OQKf90faPW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSzmGTwLgFZTX4m7J8dP/igWRayjmDsvPIB6/P2my+NeZY35hGEcZ3BSKB8UEmZiBu/b3WTLTOzAgr+1aL0gHT6GvVdxrsd85QNPdX6jMTW3X2kiUK34V58TDnFcUHMc/MN4XyGYQ3paHmXoy+2EmxLlCtktr5DJ/IQal4J9y9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SZy2zeh+; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SZy2zeh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjnY8KxTbWrfSq51jpsCIBushftu94KvgS327GbUjHkhdF7iPXQGXK+0+GLvL+QEFYgp+X/D2o3krY7RwOIZtGQdu+S8zAdRg1lVPuBnaZ0Xu6mEBSK+2Z4PTw9teIdcgVER/gpdS3NswjmTm7UDSObHSRVKjnpNkF4ssDJKK0f9xTtTTCy7b6TvnIDkhTt50tZYwVlrtgDrU4oZQcSgTKuqiTNVb0fbDSeXK0YngkWnczATxvqz1QcRcVJng29dCcFPoz+jVVlp7aqgUIrapCt8Jj2OaXxcdcLJBY5PYL//XXvhuYXuhAtKLv2UDlGY9nn4uNWUknRi6ybwVLljZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzu4iNpyeuOBW8qNSg9xV+4SnO95FhoMf0dI192aRfA=;
 b=ZVhEbL7Z8wMNRYPSXEOMv4R6BC2UmemVoi18R38wbVAWlpUugEBwoLRF8WEVBrvloqZDNpoRwoqRESRNiI79/JybpO8ke+XRxyXOJbvtycZGldwOWwEvV75QJY89VAUX9I/fMk40xHGY6ysTpZsSzrml7bdgl6eaQA8Reg+4q2AV/X6rOrInHvzwHKQThHlLz9Ic7XRUAZmrhBSzKcE36ws5kIZMlB9ufACOrpbjvflp6X1baXpSgfl+utxsg6lnWH8Y0Etcpf1TWABQvasiopMWosjkn7mPH+gEKMvuxKx2hI/NUyazm7heI27KnC5cn5p/i7TQ2i8YU0a6i8AHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzu4iNpyeuOBW8qNSg9xV+4SnO95FhoMf0dI192aRfA=;
 b=SZy2zeh++PI7y7Qg8oioZVqypS3JwEtIbKFvB+5gqCBhXAES5bLccly3nHdbBfW9SQypSBkP7LBxuF89jX/kSLpiASBH2IS0s+k0It7cX0LxSRb/QR1gWFfWqUYKyG0AInIHd6R5DJ2zGHpHzZYFPlMEk6/R3HotE+9vy2LiCSg=
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 16:39:32 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::22) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 16:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:39:31 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:39:28 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Wed, 4 Jun 2025 22:06:47 +0530
Message-ID: <20250604163647.1439-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a94430f-bb9c-4c91-3414-08dda38661f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bH7P6FF9CIiU4T+E8orQFrFO15w0yQW2spgLXcU5QsJcPbfSTN4/H+W9afr7?=
 =?us-ascii?Q?1VuzNrFvqmuCZwbvx8ypsgyG1NzX3R3cu8tljk5dvpz80pABdaeDBc/wC2cU?=
 =?us-ascii?Q?elz6pfq8jgpJDdTfSfE+EYWDhro3/kKV7W4UjVi1P/ydau+i+siR5Y3O3p9T?=
 =?us-ascii?Q?BdUhtGxrEP2UE5oShHl7AjVYCC+j+JrawQLsbm7z5uTmViuOVzfyK45QKSLq?=
 =?us-ascii?Q?D22DNeJcDi/07u3CrpjC+sxu9KCL3ThAZrXkZXqS2dTUsyj+TYCBL0XGBWa2?=
 =?us-ascii?Q?d98LSmBXa5r2UMXkirtiyavWUYgKWluMBsXQUWvYXnttK2pL58heEsz24fqu?=
 =?us-ascii?Q?4liQKoPZm1GO0EiZZuDer/rMUlVPG4iSEcU+dpy18pXH9BWXXyaV1q8phRg+?=
 =?us-ascii?Q?2saGMDb+5DNAX1YbmDLQ4qvFoftOi5gpEyHA/aVNoqvJ1GNfQAb+jpQ7kpJM?=
 =?us-ascii?Q?tVoMZRCeMVTZCCzP9xgJiVOstxK5xLOdzXpxKR3ai4L1bQ81UeEnlaUu4aQ+?=
 =?us-ascii?Q?zb4bdBynZG07g+BhjLmipwwIuvVL1lTwl47/93OTg8hXUC49pCRulYfg6tNW?=
 =?us-ascii?Q?+Tut2a2dzuGvECP8xEnCDOVfWYHCzNf8W05MwjGeJMwgLrc7rKPHePZbuF87?=
 =?us-ascii?Q?PiPQLfGoyUWocM0HxfrU4Oj6I2xxTMzxwWQb+g4jm42rb83mSa2fQFW1xPnh?=
 =?us-ascii?Q?uN6HOvZ1btY3sNX/26qlffAxvY8jPb13qHMSZeKZluN3KWaX16qNmWspv+L1?=
 =?us-ascii?Q?WC8cxrMGE7JxeVufowjeR8NsKwQDS2xtufzwIN0YKSYXf+/7DD/fXjnDERXe?=
 =?us-ascii?Q?FI3jenJpi4Sr5pTZe7OUCD2tyz8byPI5/ctpRobBth24qQJnlB2bufYnyvsE?=
 =?us-ascii?Q?V2FCGYSXAzdgmv4vDOyFMsZNjfZsRmCr/9RI/WvrFMIPr4hsr6kZt+YVO9LX?=
 =?us-ascii?Q?boKKJNPsLYFDeP6Tv1brPo9VYkl1XsdX/j6+FhbpSLb/1e/WzENs6I1pS1ZH?=
 =?us-ascii?Q?7ER4aLs/9qfNpWPcAA0pO8QM545F3vO/ssyHfisYcSC9b9KOH9bMqFdfoVab?=
 =?us-ascii?Q?YCKFFPiox2eFj+VubfU5wGvLHwd4QbpFbxfLJ9OSYYNGUfvbIo6nko73zgmO?=
 =?us-ascii?Q?E7dOk/yVcWZLNBKFVBaAre/7YdRWHcTg/EDk0Kfs5JfHUYi1kYOJ/LDVA0HE?=
 =?us-ascii?Q?rtvVhMuc74uB1zXwQzNSKeE5FI4E/p6G82FRTh8jrdiJy/yhSWMtaOCQVGM2?=
 =?us-ascii?Q?lZaQj63I5CrEYHfXvfMJKbejwQGb7vHfcMDKdv/Do1a9hgI1H8T7YH1TRVVd?=
 =?us-ascii?Q?j0kX+nnXpM6yX+wVpZtDSCWLzis6ocIp/BuXg8MzDUhRsnBqLRa77TbyEjdJ?=
 =?us-ascii?Q?hH9zT7BFBTwU/CR2VeStodCQu9muoJroLF7crP/6u4I7j17edFnNEf7uqwHl?=
 =?us-ascii?Q?2vDur1JqV4M0beCmhb8/+LxYl7OF0eHZWRRg4G182B/KCjcgiLWDkHaurjDF?=
 =?us-ascii?Q?gYAt6Jr5AOo35yWELPUb0A4BOATJGLSEKByP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:39:31.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a94430f-bb9c-4c91-3414-08dda38661f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

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

