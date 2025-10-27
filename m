Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE12FF173
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566919; cv=fail; b=TBj3Qgmw44XzZu0/SdkysmJU1SIbobN46Hxy3kTlPYAWp46LCqy5Lqua1nJ+dQAiZgbFAGChLXxyfpBO6bpFzxspDOVQVCVXiUTgduR89CeKigvebVniHW0PLX9C3fkU/VbgUpR9rKRUwIOMk89bWTjreF5ya/aHDvR9zKiZszA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566919; c=relaxed/simple;
	bh=5Ebuf1PJhkM4Mb+xx/1iXnUoG6lYgADjCiYVVx229wU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnYibZbw7rV6MGrVzYcZnpwx5j3u3IOeCgtxR7WA7DqSlNutIoXgaDDhCHgyIIRKkk2qZC8MppoZEBio0Ek+K3aJN/kQ36+FYHYhXLpZIZoiblE67ZEd5ERD56aVCsZ9f4uw5uk06YoRbzkK46JnFsendQGlIsgW0fc3HfL6sUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NoCe5EAj; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NoCe5EAj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On5qqt31Gx0XZlMJ6Nvd2fP8e8rlJokEosQOt0Sv061u5Cd8eKd51FBcCDZch8q0Ull5R8Um52GBSBzEbXvtjQ3GLuJFf0b2TTUEwalioYt3lf056y/hPnBtK3rjz/jIjbtoQidFA1XVxpDVSpZg5v96BVBxEx5pKCZgz8pbk0mvD4pu4mEUIuC96WAwJw1f6Xv+OeUfh5M99kYGYqR5kM7jLWmWz4NwluK9bNq6bVXKmwWnK8MWUo0KHso90Nz97BIeqrSp8x/2XwN/z6vHMRLZ1YeY4a4oVU34L8k/CcdolCSdRfjVnQWVSF/Fo090QFdtB0N7mBsqfY0CQjzbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLJyL3k0qJP/jzKnO2C75+8aN98mkM8inenanEr0UEA=;
 b=rdSE9DQPsUliTLkz64RWM3gjRM8BZv5CWcBVQaKHhq9RpLqFVDSlEJeIazKj5YfE8sf1aIbOnVe5DSy3yDkQfuzhwvmad8MqC769J2ujfgrFkM343IwFe1hRso8MNLku72W05TSIlabpCkgTDQniPiMaw7Hl2XD4ftePTIBwmka4BBFdFX75C4FYLoz7CFQ8Ltd5qK/2fPsEGIejPkHE2ls3+i3Gs0G1ZTKL9+36j9+JzUJZWHDz+FHRtC95A2t3z4ltZSETHbrBQclN/XoE5wQyTfZ/Htr+ndc4RU7z7jzRkWxr4a+AEBEfhi6603qQqptfm7yOCQ4h1GmEsYXv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLJyL3k0qJP/jzKnO2C75+8aN98mkM8inenanEr0UEA=;
 b=NoCe5EAjPMqo0opVKfMrQH50/Om3IMOYC24QKjGLeyOQdITQ0E41hCeRx6Mh72XX5WSAvM5tBMh1/uKSpU1Y99+tMsxcnZvk86ayPiN0KGG5YwULTocPg7G9Zki4yziE74lJoHMyqI89K6jj0yMQA35Snl+pfw1bgWY9U9L5RVw=
Received: from BY5PR16CA0020.namprd16.prod.outlook.com (2603:10b6:a03:1a0::33)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 12:08:34 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::64) by BY5PR16CA0020.outlook.office365.com
 (2603:10b6:a03:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Mon,
 27 Oct 2025 12:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 12:08:33 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 05:08:30 -0700
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v3] iommu/amd: Enhance "Completion-wait Time-out" error message
Date: Mon, 27 Oct 2025 17:38:03 +0530
Message-ID: <20251027120803.706-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b139d-e4dd-48e1-4764-08de15518d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AHTI4tYcJvdY90ExV0RihqxrP2S3hFBZW8UADMz1SgKvTh37bDibVqUUVFX?=
 =?us-ascii?Q?BgLrSBAqf+qIHvQ35JZmtZzLzRlEkhcEGqoUhQ6SGq5+hC/KQEhOJpZNzzEx?=
 =?us-ascii?Q?fhuZPFN6lFhMvkPQIR+f/8s+RWrn9d7kvF3xgX9mtcj5u0z3lYTzm/GZk+Tv?=
 =?us-ascii?Q?VHBxdhpNRT42qJ5KxcYe6aOHxwuzk+mRHljS82khZcavkVQ1oOKCG/S1khpD?=
 =?us-ascii?Q?H6UePjmTZuQ8sMImYjCGxmcJJN5wwUE1+ZUNUFDaqmIWWEh3F2g6OxN4d52I?=
 =?us-ascii?Q?k3+uSmlIjGmyRAiU2aq4iYuQ1YV8I+94iAvNNFrc02mMWGG24AHjWJsOj0Ok?=
 =?us-ascii?Q?xhzzJ8TbX2Ys2FPd+CjPwa9jjQJ4l+7H/+2YKTOGZRKAje8ZKeCkMzHsph+u?=
 =?us-ascii?Q?H/4eCuVlIqQAZTmR0H5AGxtG/XwXiiOqEDnCNErjgioikEAAxVJshKfiKnOb?=
 =?us-ascii?Q?+xFlEc8RLRJ8zQWiCaOTSvCIyETS6jMrI77XAKulHPdaj6V+wgPGH+GD0Y1U?=
 =?us-ascii?Q?D7pgm3g8j0SbNxbzIg20Oet4bg3V7rnuzE00iIFhHVQpnuT/K1psJQuee2jF?=
 =?us-ascii?Q?ldMFM8f5sM7dQKvpjVyc1B7T+C1VzfinqrW6w3b8IjtCJyWPAQE+rHAX2mql?=
 =?us-ascii?Q?87+fQOaYpyWMzs4sPyr9IvqS9/FVzishc0nIb2CYkq6uC2GFM5cff8kDiRlU?=
 =?us-ascii?Q?zpe0UxTX6tfwtv9PJcJZqigDjedYUpavTT5zsCTOi/eBIcVTe99RSqGC2g2s?=
 =?us-ascii?Q?7ceDDfZfbsCc6Ml/yq13OfEhPSRAEa0j19LA2aeOKDR+wXyc0SKgHsGtFlHZ?=
 =?us-ascii?Q?xqQ8sNz8nClf/O9ddItIu3SZTQAOmVb8nMhJ8ft3cz5c6R2DKpliw9SRa1Qt?=
 =?us-ascii?Q?FlpZkXMEc+Fj0h77pg8sjJ0wK9vW3zIWT0Y00B7x6Z72ZPn56nlDdCHdtOFW?=
 =?us-ascii?Q?aivS+3SyqsSIlRqfX04reo2W68iHvNTWe+KYIdUhRq8krePIYPpMxOjaa0tY?=
 =?us-ascii?Q?jLD6MsJxuxuwucyBRe4h/bYApisvfQddLpP8Mvqd9mN4GhxzrVkG0wurFIxe?=
 =?us-ascii?Q?Xygvag7Xc9uCWRlS//cDxFQiM8OXiVIKG92Z3dMAAS2u31Y3/O/V8qwUlLP1?=
 =?us-ascii?Q?qyHFp0rXQ9Gi8J4co65OGEXTQWULtsxMb4K7jURd9dcFlWkX5EK23YO7seU0?=
 =?us-ascii?Q?Xs8dp0TPefxFz673qwKx+QrOi4Gpk1uMQo2d4XlUnziQEzGJJ79O+xJoSc+G?=
 =?us-ascii?Q?7B+CfwesIiRmdqe7MiLkkp17nnsZhYLXtykQhtl9f6a/Ar4eh6b47uvYuTtP?=
 =?us-ascii?Q?hdfqdM2D/cnjxZJXyzQ0RSgHVNg/lT9ECMGaErgs2BFB8AHP+g0/R9eE7LuH?=
 =?us-ascii?Q?ICRCSy9v9KQ5VV+uKB4shrKeyTXNuwIMTSEibL6eKbAR499tVAa7G0e+AkWS?=
 =?us-ascii?Q?oty9gmDSkMJ5fthyTnEw0Eg3a64fxAS3414DpKT3dp44DNodPoCrpm1WvNi1?=
 =?us-ascii?Q?kShnJd3rcpsZuGbwLAceI7uw8cakGH+QQBA4W4N/IX5oR7x1W/PkfqaSmxN6?=
 =?us-ascii?Q?0fhisi+Ou0Nu/0g9U4E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:08:33.6743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b139d-e4dd-48e1-4764-08de15518d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Current IOMMU driver prints "Completion-wait Time-out" error message with
insufficient information to further debug the issue.

Enhancing the error message as following:
1. Log IOMMU PCI device ID in the error message.
2. Also dump the command immediately preceding the COMPLETION_WAIT
   command to identify what the IOMMU is waiting for.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
Changes since v2:
-> Fix kernel robot build warnings.

 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 95f63c5f6159..d495e5e4a9a2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -247,6 +247,8 @@
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
+#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)
+#define MMIO_CMD_BUFFER_TAIL(x)	FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
 
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..24c6df4f37ae 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1158,6 +1158,7 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
 
 static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
+	struct iommu_cmd *cmd;
 	int i = 0;
 
 	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
@@ -1166,7 +1167,21 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-		pr_alert("Completion-Wait loop timed out\n");
+		int tail;
+
+		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+
+		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
+		/*
+		 * On command buffer completion timeout, step back by 2 commands
+		 * to locate the actual command that is causing the issue.
+		 */
+		tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
+		dump_command(iommu_virt_to_phys(cmd));
+
 		return -EIO;
 	}
 
-- 
2.25.1

