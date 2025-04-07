Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051F227E84
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047390; cv=fail; b=dOtK9VJq2Q4KfvuAnIhADn23UOLLfUw9j+SH3h2IrQ+DdmZN6ZId62pfCklTUwwQsvDSscBnMEQr4xYiR9vdnFf2u8cNsRtLxsZOo2Ous52qmh+7twT4iNhJREjyAkdLtdS36g+o4IpiqhIyl+ogS0Y6iZPwe0B0Oo+buWIEE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047390; c=relaxed/simple;
	bh=OkFkdd36OgzINJpvMh1Ds/Ca6PVjC31duzspXINzQ6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiddNSyr5LVuTYJM5+rNFyFKUeATbPItGTTKNx7sjKMF6xeL/KdJ3RnFTrIihkGeaOSx+dlEvSxl6EDpibVbjE3oa9wK4LJr0/klqyPAs8atI8FYQDbhSWssBF/mt73O/zbGBP9yPt7Rqv6k/4cfZtiPSshrjzkxpLy7Ks9DcNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=17FZehVV; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="17FZehVV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja4QzdC3mDJ66REY4R+UBcRw4goTq6FSpc/9ZfdjzgjZpfoEWN41yqsCAdBgc/LmG9tYBDgBYbJNg1wrFvtFBxSHjwASuq92E3vOIOnim9DyjqnRZCDKOKr+Sw7Ejgyx/zQI6lJWbpzJc56EnlFnhFQ7gcgW4JBO+VHI3KjAZWGG4qLkwm0ryS8CoYpcjmB3Gt1kgmXm8kluxQ/234IGISrpEJPIYiZgG3BprQ5VJif2EJkGrwmxqG97ULZfH00Dmj1vDa6EYelWS+fJTS1ULwj/9pTGOLLd9E1uq5VhdWmIoJOpJLr4h147BKkUzC4NWWcIWf2MiSBu3YRKFSivZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7I/n4buZPTwZpNhvcSffm/oTMfhiN9wnK1i2xdxshg=;
 b=SY4ngWUw8ijt6JoyawhMg2ci1ZDi9IkL4ncQxWbc1GN89QhdSuC28I3npHRDMk+rGrgPD9Dnav7QGHB0E6TdvA3Vm8w2c7SGgCIkRavPnRPflDabwOThEJCvEjqdxqZOu6MDqDdK6rK3BMbAz+P/061ZW20B3JopejvpUh4eyfM7c3j7o+8UzddJU6QWkb1lKtfN2liFTvIU52vt0SYehiZ8fS/zwSnhD9strX8LCtkoNVoqmammJJnEu4QHX64UZGc1BwVTESe4JMqAMoSCsuW7pq5toyfO3hyfV43oU1ifwTmxOs645rLK8zbosY598xOhXoqF7n5YAyPM+uTmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7I/n4buZPTwZpNhvcSffm/oTMfhiN9wnK1i2xdxshg=;
 b=17FZehVVp3i7T8AfKObHeKJc2kCFDnIO8cxPN2Cf7Y+sayHd7PCqXGY3cj4y3a+J2XYrrujFwNQHM4lbj/mi0LaXK/2LfmBRVg2vWPot35+xA5IiUiL3R36f+7JSEag/3Byjz16bBoNBGRE/RHFWmUMG+0NIsUKmtSBL37vocQ4=
Received: from CH2PR17CA0017.namprd17.prod.outlook.com (2603:10b6:610:53::27)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 17:36:23 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::f2) by CH2PR17CA0017.outlook.office365.com
 (2603:10b6:610:53::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:36:23 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:36:18 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Mon, 7 Apr 2025 23:04:55 +0530
Message-ID: <20250407173500.1827-4-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a504787-a3fe-462e-8f1e-08dd75fab732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nO2tfrJX9IGpkTs/mDTDRSwDJOJyhzLgehfcRrN3i4C0Wr4EWknb6njvefGq?=
 =?us-ascii?Q?arrWGyiNJQowlpwZr5eqxnDtR/bpfkptPmF2Ymhqpm0jsVH+KjOfR3M737Dx?=
 =?us-ascii?Q?w2cHGSs6CuO1q2D0XVDrGQ5lOlNfDbyoVeCIpRaLvibXMaXPAhV4Y/b9whQn?=
 =?us-ascii?Q?6DDxAoGRQDO8NT3VnNu3r5pHUhH1sVAjC3SOSW6WV1EtNVb9CmWZzQ5Fy7Lz?=
 =?us-ascii?Q?QhYBUCfcJZrk0IyeWISZppNeLD3LqhTNhoXDadcCoviTRUI9rPGsVPNnUmVM?=
 =?us-ascii?Q?dkDa5QwRtdX7SvxjbLYuQEnA+HJrn+eK813rGKnDJ15/T0P68METEygKxZdf?=
 =?us-ascii?Q?msrmOdvg7BBb1CnCcnu7sQBwSWOJp+67Krdohk7iUiSmFcJ8v8vmvDw9+4cG?=
 =?us-ascii?Q?p2eS2waoYuAtp/w+KBS8bVR7vHY1fh4BHMgA6kpejgHj0DrtLfsMLI1AMS1N?=
 =?us-ascii?Q?YGgVghuHF5VypDildYToj/RNyK6VVkfiT3/qqs3ExaimFkP2fZiqe379lpmh?=
 =?us-ascii?Q?Z/I+MW7+AkKwGNb3SKVnTlhK6r7r357/qgjj1BtFokwoP9S62Qjwfqbvlqth?=
 =?us-ascii?Q?8B0rGNqYtX3/Qwo8rGt1yhZmP+ASvx1hDLJ1Dc/hxpOoDktG5X/L60JNGQKK?=
 =?us-ascii?Q?LLr0YXIaAV2e1m8t9VMiUslwQu4QItJ5L5ovQbtcv4PKuwqOA0vFNejCNODz?=
 =?us-ascii?Q?m9V7Il2esEp5bB/M8dIVBqNBfWk7S9ZYGEf4Dp5/Cs/veS41LTEUu3lXg0xU?=
 =?us-ascii?Q?BHivbyQYtabOQtDCaWamOksckwzROQjX6CIW9M9onVfHEIjf/u3NK++zXF8R?=
 =?us-ascii?Q?HbSqPC8snqrmJYrmidaqnLH3KOm3Xw8IXvSQMHygwWppfxa63+S2rXZl9P9g?=
 =?us-ascii?Q?XfWBh1Z+eSottI2ID1oYKVhtK10q5RjYzaB+RM266e8B7B1FVESB9az5OqaL?=
 =?us-ascii?Q?6X8LyLxII4du10ZLkiVLY3HbqPw6musA8kaS7aQX2GT+m7008Hriz+XK9Mo1?=
 =?us-ascii?Q?mtlhOpbBvGqzkc5D6Rw6FcYmvzFJJNJFkdbvfWh7KwPmkajWpak4oRGsDu1u?=
 =?us-ascii?Q?cce0Dw6CMH9flT3KXwwhtfsUuFmvmEE2mJBR79HoKTL8WpnuyZtNJBvWzqud?=
 =?us-ascii?Q?gVH6tC/vgQqqPTcRz91Z2eUXY+JOJnMx9zvkOP8etNxmkK5ymT/+zcKxhQs7?=
 =?us-ascii?Q?cXH9O5iCmCdRGjCdeJZyzGE/HyfS+LAwmGHIeAJJzPLLXrNzj+HKqtohAIMo?=
 =?us-ascii?Q?1WDV5MoI9dLplt7foFXvnI078HXoj8Lxxu9KOVdRhvJAwOmM6qzDSqFWCAJa?=
 =?us-ascii?Q?+Dgi5vuGBw8NZwRiBUjAb8raEAqRjMUag0hdmTaJzk2MDR8B+g+T86HoVYDn?=
 =?us-ascii?Q?pH7xTv3IFaYmWBiOnO3Jj05dmTtC7w0oLs3EJ/h9JaPaHK7xUoLeNbDmwhHW?=
 =?us-ascii?Q?z5KidEsHjivr5ftnoZIAy3A2iHkiOsQn5aHQ2QP8busjdJ0LPA17cjEVLt2D?=
 =?us-ascii?Q?xzGAUm8CJQKjJqE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:36:23.1358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a504787-a3fe-462e-8f1e-08dd75fab732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

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
 drivers/iommu/amd/debugfs.c         | 51 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7cbc25eaa74a..1666a460d030 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -795,6 +795,7 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 	int mmio_offset;
+	int cap_offset;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 520377ab6731..5ac12c3fe069 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -58,6 +58,54 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
+static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
+				      size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	iommu->cap_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->cap_offset);
+	if (ret)
+		return ret;
+
+	/* Capability register at offset 0x14 is the last IOMMU capability register. */
+	if (iommu->cap_offset > 0x14) {
+		iommu->cap_offset = -1;
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
+	if (iommu->cap_offset < 0) {
+		seq_puts(m, "Please provide capability register's offset in the range [0x00 - 0x14]\n");
+		return 0;
+	}
+
+	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + iommu->cap_offset, &value);
+	if (err) {
+		seq_printf(m, "Not able to read capability register at 0x%x\n", iommu->cap_offset);
+		return 0;
+	}
+
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", iommu->cap_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -67,11 +115,14 @@ void amd_iommu_debugfs_setup(void)
 
 	for_each_iommu(iommu) {
 		iommu->mmio_offset = -1;
+		iommu->cap_offset = -1;
 
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

