Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A016238D53
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212801; cv=fail; b=ZhK6Tfbb+OiOeT87QhRj+g/aPxx02Sic9OqBnpyXmB7kksr0uFo5gz9NzkvrQ9oaaeGG3VaSdzUvzS7SDHPQbldx8hmg7KYeongkJ1IVBVxrNUzHe7nIQispEWXnsu2FNKsCNupVqzIxd3BniVBHqnOkQ/N0k1E+o/qWQmvt8GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212801; c=relaxed/simple;
	bh=w5ZRCVpQovjD4awd2p187doRgSIRFgsX/sjAt/C0qzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3ls7S0pheIbCjcWEf981kg2UaRTmdQcXiPD8k2ReiY+i66XLAXvKZsbKOmo4Qy7rkTDHFr5lQjJPoC8h15wc85Iz+nWbbBbkJ1hJF4pFqFr/PWm6dcLCJQOdlVMYPjCFy9HsPuWNnOplhMCSzcwnhvIEiY7Ryu8P1YSB+9oWkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tvxm2LOx; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tvxm2LOx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnNn9f049gkrXpwXCkwWwqgubI3tY9EwA4kX1CnCWplgf5CRKNO30DsE8ezubci9kM8tCJnnA+gPTOstlK2erlsLZ57YBkB5gNuIza9dlAJqC9wXx8rG7/e12pJRxumQXzNL02o6yA1Bz6D8THpqfmToRKG5oq+EAnYSlcQRpj5zTciywIX6+p5hpc42UR8EhhhVwE6zLeV0trQR1Dp3Xr5YKyaSq0t4jUJvW4lqkzWv5xK+fhjGsT+4LKRiomY5ZgrGOgKuOikcuVL2TL+eWrRWcARNeKPJXHIS26TpVe6t5I8LA6Varyw0hcdp1HmZOTCE+JKbi3WAUqow+HVgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjVO0B0hp2fp2rVUy18GR1xt0RFYkNUH9Cja3RfMb1M=;
 b=x3TQQGvoK1zHEqACGtHD59rSIQ9zWJVUzrKUeKTJA1WKZrVMITLj3PmexHGGttdJkF+KUcnHa8FVvQdRMcki3NLNd9F/3K9KgFQzhmZCM9AHgcXvNw8FE/tWPjfsEvwBVeRPgsKGUMICLux2VUQkSWSxjaSDLptFd/Kt/8pLThValrrQNEN8AwC5gAdSVHO6NlkT1I4JHsPBudsSA+cppSbvNrhmcNOvbye84FZzHCnFTq5bsagmju+1YNnQnINk7kurvugqu7ZGDOhcWzDM4UuoORycg+YyiGOaKAVE14rEMHtuO1qgT5YpHj88AWh1ap0TZoSyRqZnATxCN02yjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjVO0B0hp2fp2rVUy18GR1xt0RFYkNUH9Cja3RfMb1M=;
 b=tvxm2LOx+XVj+smum7y/OvvAI5NAb2nxlbjd4SDypMK4w2f9A8KyhFvl/Kn+l+IrHlE9z6rQca4m1pz7pQRXSkBGV7ThTtzFEJiAwP9jZ+r++fIbcy5iYRNEzLPyo1J5C37vHhJ1kYGQCKxs903Y6V6VlKCYwlac05I4jQoNDXI=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:59:56 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::ff) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 11:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Mon, 17 Mar 2025 11:59:56 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 06:59:52 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Mon, 17 Mar 2025 17:28:25 +0530
Message-ID: <20250317115830.3416-4-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d01c40e-b901-4ca0-7f8f-08dd654b3c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6BNpKp5aiynz4mFsn3giqEyNPfOumNleCp9XAiatYrT5l4HMEYkCmmfCoEj9?=
 =?us-ascii?Q?9gXZ10eYf1p0Fty2XsmnzDaHAPl1ARLMbxiEz+8yTKX7vPw9U4DmSqAIKZqs?=
 =?us-ascii?Q?L9YBmoERmOIEM/hRAC9TzrLVmfzlyToUrXgLN0vN51c7zHKCvPzBz3BlxRq5?=
 =?us-ascii?Q?Tkh/Gzr5WJvenvjjmxH8EClSzT2bGa+bXdOYdRYA9ceNf+SLdekAzAveiEV9?=
 =?us-ascii?Q?7KaSoAL74AcGDfgIizMSSLDIxQZY0OPpLamjiKywlpG41cqVOQ67OdvdmE/n?=
 =?us-ascii?Q?YGJbOO+N6eR88B7Kck8qJHr+PAaYEufPKHT0MANmCC9Lm9bgjlMYIdZ4ITfN?=
 =?us-ascii?Q?t1Nim7zxNSDLbKWblbg+PWiScFVcWnLyUyiIQPQIlfjlTE6/TBDhaEP8HQQk?=
 =?us-ascii?Q?ILFb08e+gFkLjKe3vWqEtMyTvqYtuAjExcqkaxU4KkGIzoi1ygheU1mV4gzp?=
 =?us-ascii?Q?2QQbL+pYC5eEOrdYFsvrpfW7VA1zZYtxegzQUaORE8WCpG/iJMPtpbrtKXnd?=
 =?us-ascii?Q?lGU3WbtO6LzOpfrs2DsfF2zy0vZIKw2bd8lPOen6mTc6qew25ZakHJTD9y4N?=
 =?us-ascii?Q?MpN/T+x2Iv1RM+DnFAgViQKBPoJHp+w4A9MLgAtpvhEPeztEEAT7Nt+lmodI?=
 =?us-ascii?Q?USBF0tjSRN6k14xuivFwJbdiYA6sWYsr3YpqNOYrZBK2inEELH0DBvE8tAQQ?=
 =?us-ascii?Q?E8plqfR+bwwXKHzy6nQcIqWp+sdMpP8i1rY/xeB1RXdoWG+gsoeWw7Yr8waZ?=
 =?us-ascii?Q?1eE+XdyWfXEfMo288aSJInPdpqZDhScc+8XjTysMu4SRw2aczdtGNGosxgHQ?=
 =?us-ascii?Q?tqccyagJ3XscazxsbSelTht23aC128aFaGPMh9fx5EEDnhSML77iaHTh85Us?=
 =?us-ascii?Q?ae0wY4QmoZf1BfIBymVPn3nRjCsMb+eqw3L/AFc55idGopVKKouCQZvjDcA2?=
 =?us-ascii?Q?sTcAa99B2TuwfVMHAlkiQV0BAUNh8aJNFg3ekB0UBumA8mEphCqzPptneMwQ?=
 =?us-ascii?Q?6UKAZnqiLSovDNKc3WA5c5Jyb3KuiJacvOI7WifUCThWSGPz4kCfNo1m1dZs?=
 =?us-ascii?Q?Hml6Q5jLdJPOaYf3SdUEQMUwLd6khs6rguvNh6dt/cqq8KF92tG3hPC5X4Uu?=
 =?us-ascii?Q?WqZNVmbDvzZfCgP1gDxhmOLe1b/ljuY1AuqTYHeyGFM1Nar6r+cVCfOXACwx?=
 =?us-ascii?Q?pYT7dDBdK45jT03IyCm4XLmuILZxGnOnCkA4uUQsEq6Ghz3KWzFyKOOPNWFh?=
 =?us-ascii?Q?HSnP063nWgGFgpG1RFrrTWYbBVd07dIvCJ1ZwkbdoVodHApmDd6wMhvyVWvo?=
 =?us-ascii?Q?1g/QNDlAjcWzpj+aJDOgxLkscEn/PlmazLHxjpdxHz1QEw9Co7qAnwrugqJK?=
 =?us-ascii?Q?tFU24kge7oRFURsjLutB6zWYhM5vi1drc9xo1UE9jW6HLjbyf1jCsiYE7ukS?=
 =?us-ascii?Q?ccTca/O7YToPOxOVUEMKfaFA3eB2Y5lOkdedrKYf9NQ7F3gMfuYaRfSvRCSS?=
 =?us-ascii?Q?0afQtPRDNQ+XDUI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:59:56.3146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d01c40e-b901-4ca0-7f8f-08dd654b3c44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

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
 drivers/iommu/amd/debugfs.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index c61d52420c5f..33ffa1c7a511 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -18,6 +18,7 @@ static struct dentry *amd_iommu_debugfs;
 #define	OFS_IN_SZ	8
 
 static int mmio_offset = -1;
+static int cap_offset = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -60,6 +61,52 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
+static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
+				      size_t cnt, loff_t *ppos)
+{
+	int ret;
+
+	cap_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &cap_offset);
+	if (ret)
+		return ret;
+
+	/* Capability register at offset 0x14 is the last IOMMU capability register. */
+	if (cap_offset > 0x14) {
+		cap_offset = -1;
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
+	if (cap_offset < 0) {
+		seq_puts(m, "Please provide capability register's offset in the range [0x00 - 0x14]\n");
+		return 0;
+	}
+
+	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + cap_offset, &value);
+	if (err) {
+		seq_printf(m, "Not able to read capability register at 0x%x\n", cap_offset);
+		return 0;
+	}
+
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", cap_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -73,5 +120,7 @@ void amd_iommu_debugfs_setup(void)
 
 		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
 				    &iommu_mmio_fops);
+		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
+				    &iommu_capability_fops);
 	}
 }
-- 
2.25.1

