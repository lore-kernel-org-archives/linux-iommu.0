Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F523C8B2
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212782; cv=fail; b=U5+qvbREXOIqobPKnfjHs1V2vpzosYktOlSBscOSv4O6kDYopWGCw07FDQw5lGyi61TmlYSBEJSI/eE70mxF80R4kmrhWcmU3IKfCYYqO7evS6E3fht7IBRSup6zSluGkKSPS5u5ODDkxRAPwXhpa4RfCtAkxHwcVnLXwDE5+Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212782; c=relaxed/simple;
	bh=N/KP6uwqUnQPn1C9wpTXgs133A3cR1lYk0QixZDpnV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTRGSKhKvOuXBeZr7X/TFTcUj+4cofwPba1fwfSqXpvw8x4mSJCkQYUi113v7eTeQDiPKM7l8zlyMUbYXy5IANs/06d4iqy8Ac/uXoF+3IElLtRCdTzGEWkfWAb5V8x+sPlMFP0HSKBPUV+cB9BtOJ1alibRj+YneLsPv2YWRzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ke5FzDgc; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ke5FzDgc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSmqunxfprxkp/sATjap4Y6ae7YHLKv2pcXuDLj1Ngvv9Q3hxW5X2ITXllxmQLwZVKkKm3xiC3nIlc282pA3S1qdTgm9cvsQAEpbi9Oo571nAy1/kkX6CFtV3vE302P9jAcaU91lzSvP4VZ7lhy/9Hqrgb8t2tPSQhgFeo++8bOylsK4OZgEjaNJ8qZQ38k6L05fdT7AB6XldBTfTbb6dnR99eR2muMsnlePkHqCZ367XZLt4bJ9k/7Ex92S3AzYxwx7OHv+bI2U/4Od53JlHWPFMVoW8MXCatfhnTZbM16/EACGh7bVXyRWNklfvtrqA8NZEw7d5CkjfROHntnZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCEc2/xjN0ve88f1lTocT6+UEUYUyyhkn1M0gaPw72s=;
 b=TEvTRdLicAVuzdB40SGsujb5m4Aow6DBibU5w8K7hPDatlV/J/VQW0Wjf2U0MvxqdpZA00ooWOFYfDlYhbBvpCwSoBs/1Ps2SpVPY1yzJC7ZfEY5wu5Mas+NCAiIeqz5h9A46Jd5NL8v0Cw2pT8ED73aQuI+AN8O0QgY8Jx93IhvPWutAJ0BnZ4eDYoFsm4TuenskogjngHr8ZxLAZDF0DyP3qIzqgjQYZuiMUsWNDJQu5aW4CazDQc7y+diqhHWW+blreKRvnARCKptrWbo5dTiumMEB1BRWo6iSJobApv+Btui1FXeeSk1TQYZTqILhpuKX109+40nrOP+zQ0ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCEc2/xjN0ve88f1lTocT6+UEUYUyyhkn1M0gaPw72s=;
 b=ke5FzDgcLGm9qDVNMSVrP+Rdrgy9xY5g08vrVgt1TfBvTjCKcktUYQCichs4BrRYASyaRZWBtNWIRLsFLd0LjvtYHts7sABlaHZiwhhF5DfUnQoIrEQmLDfKGej+i7zqK7dXEJi5abJPqrtIExcM3ZNLo0zD9IN0fM2x5adBF+4=
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 11:59:36 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::5d) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Mon,
 17 Mar 2025 11:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Mon, 17 Mar 2025 11:59:36 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 06:59:32 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Mon, 17 Mar 2025 17:28:24 +0530
Message-ID: <20250317115830.3416-3-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4f7d19-0eaa-44d3-cd3c-08dd654b304d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5J0susqhU4OgW4yFra9UkJZlcr4HRNEaBE4lF2AP1oJAEIcaecmOca0pSfGl?=
 =?us-ascii?Q?ejWQGekP0i5JfxGf4qs1Vv9oxi5CboVaMpz9fZ0b1rLS/o/w0rJ+u+nuGF9s?=
 =?us-ascii?Q?+5CkFmyOkIiorPnU8BAHtHfO/TkcFnb34VH4DAHKFgwWNlqNaJ/Kl32aRCcU?=
 =?us-ascii?Q?WUKtPdoB7kEx9rTlzQ0be41QSRl01ZEJ4HOjjdobGOv1BMbhRq/MboIqCk8w?=
 =?us-ascii?Q?wEZsmbt6bRmmogCkHS0XRUAdU/QDtDzYu64/BYgBj5H9ehbTYY8vikbSUHn9?=
 =?us-ascii?Q?WGQn7Swmj3MOQ0hx94Fcay5tC+o+dPX0eVMhv2FrV6hmigh6tZ8JVvdmDo7g?=
 =?us-ascii?Q?H2d/fgTLdyoyG1T4DYkTv8+cwwrVeWyPyAaCjM2mBQX8h+SvG8Xtiki/8bVV?=
 =?us-ascii?Q?4Kxzf0UrwAaLplbxHMgKV6itC/Uf8endK5uPmbl/AkoNvqu0eInJ9432R6Lt?=
 =?us-ascii?Q?g2Vu+e5obRq96bd/QQIdKDWH7sXPmSBUoqwILVSEweJPO+Nz9MRMlZtZEvia?=
 =?us-ascii?Q?dRmkbaxfWtHfexLZIc6dxKGH+B5WITaMtkcE8+YPATXVxN/zVBz92CtRv3vL?=
 =?us-ascii?Q?G/xjyZ88EAAxyGn41qssgaEBCbEERgm8LDt5vvrC/nKqzREtDApuTgIAd6q9?=
 =?us-ascii?Q?6Yl8DTGLj0h1+F5jHFEnNKhZGy8NqakbOzctqpv0ACuK0lbmBPJPRGLSR8TW?=
 =?us-ascii?Q?gvnPeEiBx+/5Pnc2yAZ4lR+RYgjFKEyQz6RGjxzoH+uuyseRC99DSpXbTpkm?=
 =?us-ascii?Q?MbF9xPbg73XOXGiNHivnsd/wG9UyNrMaN49gObWHPGdKGC4VnXv5SuEbMSqE?=
 =?us-ascii?Q?9k6ZUedYdW3PDqOt5J7Eku303YmziY36UNXvWONr91Pf2albchIq6tPVBXPw?=
 =?us-ascii?Q?3+sc4mThCiEjPQ/66XhuknV0aeHXfbh45SRaD18vXziskQhNivjH0xHJUAkd?=
 =?us-ascii?Q?/lp30r8SNn9eK2qAk9GsPlw1aYjjr9uM7Jmpwlj1nCyJ01x2ZALct3ZlxSUM?=
 =?us-ascii?Q?ObH6WvA8wG2zKuVUypWuQVFEQcd0wGV2adluBQ/RyMFBwawpExSk4aOqgNeK?=
 =?us-ascii?Q?aYVMX9WJV/BTUtRv7DVauhoc9fMOm2mW1Jy0Pwxd5gGJeZ+VnQiAAo8hQnjc?=
 =?us-ascii?Q?Y6KPQ7nENDAvBxLJSDHS5Jr5OK0gQE87uTgDJ5Wh32bVVa02WDWMZg+505RK?=
 =?us-ascii?Q?unaiuuw3KpMpaUd6e/rFA69yN8WT6SWJmfYi2zuF3ZbBUAOx8gaZAFYisQ6G?=
 =?us-ascii?Q?2mCld/bizqOw8Gpj6W7u1zaUkk9mYnFX1bPqR91oMvraa0ds7UCrlI4x82hY?=
 =?us-ascii?Q?+tw8vmGF7gdZAgNNoGd2/E7Zkp8/AVmf9R0xUB5/bk+B7vjrtytFV8IFJdnd?=
 =?us-ascii?Q?XRTS6eSIaC1iwUDhPUSuWjQd6+3DSmRcNWO4LjY3ZWN2vgxNErDrt30OwTqB?=
 =?us-ascii?Q?SOuFevMkbSjcDq4AABkClKgUFlITMIIiFa4RaU6ckaVflnOmsF0e/aBX2pd0?=
 =?us-ascii?Q?wl5nlzEqiB10oME=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:59:36.2429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4f7d19-0eaa-44d3-cd3c-08dd654b304d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
-> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..c61d52420c5f 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,50 @@
 static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
+#define	OFS_IN_SZ	8
+
+static int mmio_offset = -1;
+
+static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	mmio_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &mmio_offset);
+	if (ret)
+		return ret;
+
+	if (mmio_offset > iommu->mmio_phys_end - 4) {
+		mmio_offset = -1;
+		return  -EINVAL;
+	}
+
+	return cnt;
+}
+
+static int iommu_mmio_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u64 value;
+
+	if (mmio_offset < 0) {
+		seq_puts(m, "Please provide mmio register's offset\n");
+		return 0;
+	}
+
+	value = readq(iommu->mmio_base + mmio_offset);
+	seq_printf(m, "Offset:0x%x Value:0x%016llx\n", mmio_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
 void amd_iommu_debugfs_setup(void)
 {
@@ -26,5 +70,8 @@ void amd_iommu_debugfs_setup(void)
 	for_each_iommu(iommu) {
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+
+		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
+				    &iommu_mmio_fops);
 	}
 }
-- 
2.25.1

