Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323F24C09E
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449246; cv=fail; b=KaKRMXf/475cUEg6zImsLl/X7ijIYEc82mz+ISInaGkdxyy+/Ho+ZIb+kAXEsBOCtE23smQXOM79J1VphCC1In5BOTqZ76Dnad9XckWmRY0OUtW0Yga/sJIom3++QyH1Ij8qq0inJQg6cyQ+sirzX0DI88Q9YWsOvezsnhxHp/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449246; c=relaxed/simple;
	bh=K9gSqCrDPhT2gxGl3YuEFq3KPe0nlS/E05e1K/IQNts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUXl7x2OcJz5AGKKBj9k5P8IdNIHhE73NPDV6ZemkOrJ9gcfvLb7EkhAqmkZvrTsHtvH9U2CkrSz5Ou6smR8SHhu+EO2K7/xB/AC+y82Z6LvpGA5VL+Gip/gxJJYBkWc3Z06ug6EZiOn9HFtP6voWHdTWyW6FLjyyWlv8qFyLkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nckw2O/y; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nckw2O/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhKN50U7fVsDZyDJfWsteZLn8bd5zjmoxGgQqia+VkdPcirHsAH2eHUXEvAG09cbrwqcIhKBYa+e783Vk6j/txRNYVyFAQmWo9s5UNZmQTfV3S1NUbGI5zM+dC6jCW5ORUzXJHUsXgbn6XtqmEEXfAFB5I+EtPCKjfaEJvmOph/AucStwCi9VFoOmZWtG3noWSyU6rRWhW3JtxXAqXGZrWNmkTZ2QVWFZwDEDQQV3mIvOlaXXarI8VvtFlMa00VxOoDtrxyhIlfr2uMlQqYwqktjCTRGC/zpEliYae1PWBP+B9bIMhI2aM9h+9J8w46Od1iAqJDx9s83ERkj2CiXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8VivxZuKrsqmFE8A3tM2TmD912H3Ygr/AqHQOdIhBQ=;
 b=KLiJKWlPeWsJSc+Q/UzF2swD0yUpPiKX3i3wJ4WhBIoK/uEGl9BxA4uX1TFFoVDlbnfzVsYkQLu/zI/RblYAsAwAZbmgaDs2cQsqtyES83bafiF9j3xh0TuqqAR7qeOJMecj4u9rnSlIpkhuQph6i/yvuyuqbWlh/Wp4uZxpKJ3jNjW1Pxjb5aOEDBmo3H4aStIae8WhszQ8WNGGIfcQvewh0IE6G+hPV1hRWLd8SwG1Wc2pja4MARsgDVtU6NBgDDqrFGXwflQRx6/pjBwGIWKF91R8LMjiXIDEHcV4Ny1r9Bfu8/ADCPEBqfpmrcoagn3OkOQk9AgZ1+xbG/8XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8VivxZuKrsqmFE8A3tM2TmD912H3Ygr/AqHQOdIhBQ=;
 b=Nckw2O/yY5xSoElTCk0aV0LcQa2AeEic9H9dPqnWCQE+K87I77HpVbhJzjCkjveSIfEEwnyWvzWpIM4u2hSuOn3PdkeUoKN9w7462CYZyy96xXeiuoD3dOqf2KyFnAdLkb77rnCOitFCh+Ofmjn+OGJOr7ytUnZICWMgCOYmDhM=
Received: from CH2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:20::29)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 2 Jul
 2025 09:40:41 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::5e) by CH2PR07CA0016.outlook.office365.com
 (2603:10b6:610:20::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 09:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:40:40 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:40:37 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
Date: Wed, 2 Jul 2025 15:08:04 +0530
Message-ID: <20250702093804.849-9-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: e2618f69-b7d9-44ce-340a-08ddb94c8240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHJtRa5HonY3WMGDewLy71orU1ct2OPS0Bbl4ATFOZ1JHwA/6zOPjRLN0sKB?=
 =?us-ascii?Q?d2xQzoL4ZWbvDwk/ScmQbWjNltCNTKlmKKkswCJ+a86n5aCz2W/ZBgFEC5LM?=
 =?us-ascii?Q?I21s4eGaPt4mmyy5atH08PGa0khlhKUkE6GGsjtsXX93++NT/0VSdX6TPZ0x?=
 =?us-ascii?Q?mwXmZiONRysmpkZHlGclLKg1R+OpIXvitcyQDwYNKcXt1ncA15xLfUN6Yf/0?=
 =?us-ascii?Q?TT8oSdZXZ5jCp2HO0WXqKc0SE6K/fXkdno2SoQf/0uN9Ft3z5cv/efZcdiC2?=
 =?us-ascii?Q?w0Ss14LEH3hmJU24G9zYignzD+D0g05gQXThmvjX/M3AqCE/DMHl70iD9SQ+?=
 =?us-ascii?Q?YofXDHNNGpF2J+QZRCw/40N3iEEFnOEEU4aY6QmKTQKAs0YbNLjVH+0Gfd//?=
 =?us-ascii?Q?BELMfg3IOn61KKHvVw1PMesgcNLGgWzWpVepYKHBz8cEJqLrjBL9JaUGQt4w?=
 =?us-ascii?Q?VrQwNMNXnX8jEwb/abPr2vpV+oJO2mtjDsdwMYAiyaZC+AFDYHR1lI7O18gy?=
 =?us-ascii?Q?aHo9AO5rELuIG/JZaLp44qFl7sAoY7CdEr4lDm7StrN1Ou9ZzXpuLvrrwEsv?=
 =?us-ascii?Q?xKg8BR3sy3dBe+CcRcMj2icXEjSIvnKjbILb6YgqmfL0M6a5mx66c9WChgIF?=
 =?us-ascii?Q?OH+d2ahCZ6KYFfntbJTY7h2vVaNCd45IHf6dfRHrSRA6teMIbunbKXcIWnGX?=
 =?us-ascii?Q?7XkKN6Uq2YLpdpF4WFSRfUVcByGW5ljfmOaLzrNrsVmL6e44xhNDZnZvkb1R?=
 =?us-ascii?Q?2mriQr5znBcRfp4unaDOP+2S2XYmknf93VNEZ6lgsfaH6GHNX4/0sWG7Xl+e?=
 =?us-ascii?Q?/Vli7Qop9f+UIAm4cDPjfvRW+ICtSsm5vL0D6m/WNu1/18GUVJYSeegO4POS?=
 =?us-ascii?Q?bjbRup7rLRvT7A5nDmnYS5Yi1VE7bOlMtgvTmkLzf8cTDrVuj8f4hG/KDnUb?=
 =?us-ascii?Q?O3jU8ovjTnhYgFQ6hdcfLNKlYwrNP95qoODo6DWpmGEohZhHZf0k5bH8q+jX?=
 =?us-ascii?Q?H5O9Qkinwvp6TbQD1LXufWkGC8ur+jjdxQzS57ShHx4ssYbrSfOm05Y+Yvfq?=
 =?us-ascii?Q?Ed1DWQg80KndgMJqw8se6vgGPvgJLE8K8OZ0Is5kOmovHprvJP0m8xOMfL2e?=
 =?us-ascii?Q?zHflKI711sVonsWDTdk++qnuye1x5jXntOX3I2gNhXemSiyRY/oba0g02vUx?=
 =?us-ascii?Q?i+b5dCfmopvWjGMm1kx9qCdsl7Xk641pmVh2JQ01XUOP+Pyqo6oOl9yyqUpr?=
 =?us-ascii?Q?xbVxR9+RpX48W2wvM52n9kAtVrFO4WY6jFNtQAmHE/ytZGdFO1KwHnQT2iAR?=
 =?us-ascii?Q?HPB315HQ1Byy/E5eTgl+nKnSlcbTpVrEdfR/gPcTJrFegQL/YXCMvgYNgwTD?=
 =?us-ascii?Q?9/M8knqxPALJ7kOS/c65s6EIjMA1WDVfqg222NDX2wVYzKrQm2FIrc5WvYws?=
 =?us-ascii?Q?aKB368DzmD38eyo3r3Qh/KE4NXnVekHkmkeSKF73Lxn6orzxjV5QfzEeLn5q?=
 =?us-ascii?Q?g26yGfUdrN7LubXWnDdYtd/wlICYlx0MrJv2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:40:40.9813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2618f69-b7d9-44ce-340a-08ddb94c8240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

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
index 000000000000..c14b1620aec1
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-amd-iommu
@@ -0,0 +1,114 @@
+What:		/sys/kernel/debug/iommu/amd/iommu<x>/mmio
+Date:		January 2025
+Contact:	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
+Description:
+		This file provides read/write access for user input. Users specify the
+		MMIO register offset for iommu<x>, and the file outputs the corresponding
+		MMIO register value of iommu<x>
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
+		This file provides read/write access for user input. Users specify the
+		capability register offset for iommu<x>, and the file outputs the
+		corresponding capability register value of iommu<x>.
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
+		This file is a read-only output file containing iommu<x> command
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
+		This file provides read/write access for user input. Users specify the
+		device ID, which can be used to dump IOMMU data structures such as the
+		interrupt remapping table and device table.
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
+		This file is a read-only output file containing the device table entry
+		for the device ID provided in /sys/kernel/debug/iommu/amd/devid.
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
+		This file is a read-only output file containing valid IRT table entries
+		for the device ID provided in /sys/kernel/debug/iommu/amd/devid.
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

