Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266D1DFE20
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449162; cv=fail; b=Ggle6S7stiJsxpdHmsIms5ZCeEioLEiQNxGJ5QCiG7MHJGSPGVCtdo5PHNf+hqIZcW8SpKQP/bZbQp9GE3SpFl8XWC2JyCTfRtl09tyRa3Xoxw15EpEemEkTtZ6IJI9M3i2jaU9g2/Lv8UT0nsfuP/b4I3bvV15EeUfebiu/M7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449162; c=relaxed/simple;
	bh=BWTvFoVHh8zJ7B6iGdPuR7gZcraMxp5jnf5q0dARbwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOZmJY7qpqKj5IfjRuN0GE6UimNGSeZ/1FMbj1exsp9dzv55yIBeZ6fOKMfoDJVAhnVZZP8DrE5Cell4kr0C90xWh9Hgr84gpSYQ8VoTYJuUfRqbqDTKrTYdXfnDqRvDmkrAiWZ3Pfipyc42q+FVFt3p/mvu6/NFezPG6A9vPdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JI8xtJg3; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JI8xtJg3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMAadBxEif4M1Gi9GNyUaugwwetzATcs92TActaamqYYK4RjCL+EuBcPJ1HOzqqXK+BsKKvwfFpBFxbgO6jkhMiue74RUUWb+OpYRYoBCHEibt/74mWsLCN6nGysNqIfCVZtCYD2suw4VNIiI8ww3oIRPIwtoVqu3kKL9c15HYZr+6wQ7uj7MjlE9CSL2oCVEQBI+5qZJGepjuIMuFMqpWwtblKie7QbYMKCBPCx3DD7mRLLa6a6F8ZnfQAEkd9O07Bgah9TvyS9VxE7qcccGATDgV4T9sahEut3kNMwRQOROyf+G9TS3L8w+oYW1iJk+Ca/r0vQhUVIXcJ+G61lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srgzaPIgaZmVlWc4m2KjORb5LBLgZMvvcy4+xl0Ht9U=;
 b=Jz5wzRLEiIiYP9CaW1bF8KgB2z65PEXCbYMNYegYn8c31HAjOn4sxC4jkbWnwxEhWc4g/KzCBhLVx9EYNswy+ehe4QeJ2A4mtdmAK8I96D2i7ngMP8SfAl7dWFTgCwkmJlFJ6MIO9GbBaLn3Wr1UggN2aF+CaYk5w5xq8rRIIeJKvOWcOLGXCq2QQFARf2yhH84RugMW6vlww9NlAW6m1ZYd0PUoAYuHDuwFW8BTOtAOJpiaM1dVnuEYnXelbq69o5mYlvBg9/g20801+4ZZurL0crSVCcQ8LaDMRNeshvIJavAG7ATbzHBj9C1P5FrdscFTWO/h/HrYOuFQV2xbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srgzaPIgaZmVlWc4m2KjORb5LBLgZMvvcy4+xl0Ht9U=;
 b=JI8xtJg3ZLXAKkqTCGzSh3ai0/mTeNZG4kUdz3vjyUVgDDI0K8nz3lIxG7eYDSswlyB0LpfosMMK1VRMBhIIQddfRQViwc9exIQc3oEFC4Fwk+kgUqm5LBd6xJKZuXVWpJ+H5CpM/fxPHXvAv3ALCLHEx3pVd6acM2vyruOySM4=
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Wed, 2 Jul
 2025 09:39:18 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::f7) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 09:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:39:17 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:39:11 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Wed, 2 Jul 2025 15:07:59 +0530
Message-ID: <20250702093804.849-4-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bd00a4-dddf-42c4-a2cc-08ddb94c50a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?icGrlSSJA6tZfiE2NjogxyTveSVQQjdNWh6U8mxdGVX0Mf8PSaqdB0/6coCT?=
 =?us-ascii?Q?3Q6Hu9GCvVDfR/9tnKs4IS/9pQi0dgM9j0x6lqslHSY2wtBBfITKQz2SeNRQ?=
 =?us-ascii?Q?Vsia1+TPkJkOrih/QxDIALxGy1CivX6ZMkUR8xwzrDWb1+L6Fkr1vXPll8dj?=
 =?us-ascii?Q?nRzyiDiN9zEK4pmugOabXBHVhgg5cclrJzeCSmP1XlBNxI3cO/d/IXeKZdiU?=
 =?us-ascii?Q?Jd1foA0rk9C/KQRSOfk19z4F+8Imc/hS/SMeJHLOLaeV+8MDtUdnXU4JXcjY?=
 =?us-ascii?Q?zP9IJrnBT+hNH0hXDhPo32bOF4K01G+o8HpaH7nAkk2NA4JOcu1SdIDa4IW3?=
 =?us-ascii?Q?zSQKFoWRTQV3L96T4HTQ7TH1HKuN4PYIiSs7775VKIH9YNKrwCU2RbahISNd?=
 =?us-ascii?Q?gLpjWvV68zhtH8jIj5Pi6ax3Z5JM2H4ojkE6VcTL8CpS2IZiSg2Div7Jmc/Q?=
 =?us-ascii?Q?YR9tICsOvl/mpcrUmeyl8aNf1ByOjBAzSU4EzUi/9W99U+yCFGbA/OhCVCjt?=
 =?us-ascii?Q?ecBsw9kkUkqKkp3jXMeCEKDWndkvh2SOp6GNEYitUfOOTj70AflfjP9BsoHI?=
 =?us-ascii?Q?/i8vKtYxH3futY2yvc7/Rs6L4URk704RcqFhmpTCRHCqoV04SSrYbixm1TUh?=
 =?us-ascii?Q?mqDNEf2H3nJu5t//JtcTbiBKTplOfarOya4YwrV8jCxvMoO+SmBwJlPuX216?=
 =?us-ascii?Q?WcoV6R+iK+6mxaD55xmsbXFNniT68xpU7shgSjn9r47eTiBqSki7oRxTuD8/?=
 =?us-ascii?Q?krD7YniUecyRGgwwyj141JEy6XSqVTY3KU1wwRJaRZCYk/5B5ljzoXO/o33F?=
 =?us-ascii?Q?iCwY2if0DmF0iP665OMB8dJeDLUUVkMGYMYhgt+zL1eHhjra0N88ktlNfvfY?=
 =?us-ascii?Q?5ifWG2KOs/dKEgfzHNs/0B/BnzJd7n/AActWxt9+huUZZvVbu8Ka1oEzJwIb?=
 =?us-ascii?Q?5HdbOouR+amBNcCX3h3canKTdEFbmBTrBv8YjXIRx+QQhtAUu0OHk8mUiOca?=
 =?us-ascii?Q?CyiQ9w1BlZY7X4izxEEQ6nF7Ee6WH4+q5VBlEC6E25Jwgeys6fPiHfus3plx?=
 =?us-ascii?Q?whZ1fHGecZZLE6TtZv8/C8N81/D8v8Z4zPKvg59bQJRmNZVcM72IWCYQfnuD?=
 =?us-ascii?Q?7FuYOxMVkmEHsRKEQXFM3brKGFCrnsg7MTyC5JJveHWel3r3ObqMWqlLKk0x?=
 =?us-ascii?Q?+mrQFYHfbF0Kv8bRaoe5gI4IzNk7WFmsALuCmEsBBSn0Uu3gIBOrUUrgqq9x?=
 =?us-ascii?Q?fTaAc1asjDFJ29kpcP1dfdESfFHpQ4kuC9xnjO1xGHMnOoa5Db+ROuEHmdoW?=
 =?us-ascii?Q?oGzGm4QqWkWryGJDDH0zeXDBhIq2FlBvDopLOTIq2LUXePL+/bOd69xGf2iu?=
 =?us-ascii?Q?EPUnCXoIFTjM2OgPnHxAhi0JE0dkrJuzBqaQh21GxDkWCelxgXELuCpQj7Le?=
 =?us-ascii?Q?CdG4RD8Fa6G7wIl9fLjeIOwycuxV0Ez89hewUMXLPMsMl6ZwJgfO6dw0qAPh?=
 =?us-ascii?Q?PvvpJ8LZJvcqqleSFytvVvbnAZalqJKP3kiT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:39:17.7419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bd00a4-dddf-42c4-a2cc-08ddb94c50a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

IOMMU Capability registers defines capabilities of IOMMU and information
needed for initialising MMIO registers and device table. This is useful
to dump these registers for debugging IOMMU related issues.

e.g.
-> To get capability registers value at offset 0x10 for iommu<x> (say,
   iommu00)
   # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
   # cat /sys/kernel/debug/iommu/amd/iommu00/capability

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/debugfs.c         | 52 +++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5aec9cc7441f..01edab37c25c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -797,6 +797,7 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 	int dbg_mmio_offset;
+	int dbg_cap_offset;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index c025b4d2398d..f843e184a62b 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -58,6 +58,55 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
+static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
+				      size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	iommu->dbg_cap_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->dbg_cap_offset);
+	if (ret)
+		return ret;
+
+	/* Capability register at offset 0x14 is the last IOMMU capability register. */
+	if (iommu->dbg_cap_offset > 0x14) {
+		iommu->dbg_cap_offset = -1;
+		return -EINVAL;
+	}
+
+	return cnt;
+}
+
+static int iommu_capability_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u32 value;
+	int err;
+
+	if (iommu->dbg_cap_offset < 0) {
+		seq_puts(m, "Please provide capability register's offset in the range [0x00 - 0x14]\n");
+		return 0;
+	}
+
+	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + iommu->dbg_cap_offset, &value);
+	if (err) {
+		seq_printf(m, "Not able to read capability register at 0x%x\n",
+			   iommu->dbg_cap_offset);
+		return 0;
+	}
+
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", iommu->dbg_cap_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -67,11 +116,14 @@ void amd_iommu_debugfs_setup(void)
 
 	for_each_iommu(iommu) {
 		iommu->dbg_mmio_offset = -1;
+		iommu->dbg_cap_offset = -1;
 
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
 
 		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
 				    &iommu_mmio_fops);
+		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
+				    &iommu_capability_fops);
 	}
 }
-- 
2.25.1

