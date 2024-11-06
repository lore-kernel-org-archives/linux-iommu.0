Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7C192B98
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879434; cv=fail; b=TllGC1THhpUcRX2Ga/gQYtlp7emcc9qKgju0Zk88mAinnyS2kEJmYz5NFxnP2nQ44dEEvC4maNMZJL/QUIXjWHYX6AdN+aHtfFJQlXB1dY6GEZJg5B6gw7MmTL+p073FvDP0aGPd/sMBlZnQniBJ1gvnVLkVBCUzsdXxf6xSvco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879434; c=relaxed/simple;
	bh=BQ2J9COjiYSpe8tcV4yuwpvF2XtyuT6iau+YFDIV+lE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG6OpnyPqsOn3XfaB3Kg0u0gp90WMqTfS4nonYPUecsaN3uFLV8VG8eUj/OPGsQdcvQ4RgFFAlWhXndoT0pypTSC0v1ylHYiCK3TZVck11szi2X1BW8G0tL9oyedfRTsFqTlMrLzuf8iNzOzO8YWQshp0Z5Va5J/o1bP0erJGGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jxl4ecwr; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jxl4ecwr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I09nR5bcubhNNXPe4WmOeanWa/cpDP8AyWxzFFiOfCasoxFUMFQ+EnUDrv4cTtSfERYoBxw1knHsBzbQ74EkxjB8ELG7yLWOqAoUz+Cp4XtMBrEoiFVvvXsuV+joaPlRNvuSbnm6KqA/f5Zxa6R9QtjqHG7fXEeELuSoVU4TgSQYTNYl1dMuZ5TqagRpXrXI+6S2vVRfms/SaEkc7jt977V+ndBrHHJZRfdhOdYrytxUg9ZgzagPWTFNc48ukZVfoJ26/TJALMN/Wpn4kVmeOWx0K0vQQuUreAVR5Kc7tPW4toI1dT3FW6RB012499kUTPnFWGmQoUVqK/q5pO/IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9Zo8f7Rlb9XgiIbe1Raf5YJ92b31m7BGHGh6v690aM=;
 b=Ev/C6EcpTLL4YJ29rDGGIJPLAf2YdOIMZcGgJ49dBqAYw1Wkdcsl4u0WYhEjzrq0pRlWactSucG0S7bX2cuM9l/PfPwtcMlBelY0x7Jwi586ZLjdVEyBVamVtoU03MfelA8diiqG5v+UgR+w5zTYqWtaJ5MAnhhUL48i8Fz7YAr9Bl0tHvzLaJ4NM30yHe7wJxtG+fXz150ZItn2ZwFNrdsZiBfgsd/jsCgU/e4qAn8cp4Ll+ReS1VOfuv6HB0GrcP2w0R6eK/khNVJqoTct9qF/QY/48D7I9VlGwtJJBkVAALBMmUE4n1dEtr0u2LChDjwN+0lP2haABuJXjuaL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9Zo8f7Rlb9XgiIbe1Raf5YJ92b31m7BGHGh6v690aM=;
 b=Jxl4ecwrVPn1GVNm8uAx5U7wqBNWv6at7bKXE4rE4EW/0hMEqesup6PBkEjtGrwm4VUF6zA3VBy0tHNUyHMEXzQeTuRlplKb9CgZEwqtSk8wBTCu+mYJ9FV3KaPnWMhTqMxmVoYbGEqgPw0J5CftCMb4YiLq6Z4ChwEJPf0o86o=
Received: from CY5P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::27) by
 DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.31; Wed, 6 Nov 2024 07:50:29 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::f2) by CY5P221CA0024.outlook.office365.com
 (2603:10b6:930:b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Wed, 6 Nov 2024 07:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:50:29 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:49:49 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Wed, 6 Nov 2024 13:16:34 +0530
Message-ID: <20241106074639.2039-4-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d4d38b-4e6c-43f5-5b4b-08dcfe37af55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFzfUXTajB/CoKKRKHG+F/q6T9xAS2475nGRekPemqMB+PxCkQOhvujIEp7L?=
 =?us-ascii?Q?QK2QopS/8S1GuCsrm6hzAwsb+pZG+Fb72jHere1QA21TmBDGVa0/MiM5NcoN?=
 =?us-ascii?Q?+Q1GpXS0kcOJdG3mhnCSmMksLNAbu4j+uavzRUYRQZ+QIvqg6Tp2HR6WSfj/?=
 =?us-ascii?Q?Tvhb/9bPr7Q3CQE2WPGSlK+s6djIuulBkbq5VZXOSY+8HfjBxmjdYva3l1KX?=
 =?us-ascii?Q?EyHzSEEGGQYotsWbir5Z19Xx8BQgIwCI9eqyP5775UAFGUQYPE8HeEj+ZTG/?=
 =?us-ascii?Q?/hPHlEfXLC5C88uxfZtUvw8pe+aL/okZCjQZkhrNwCqJvFtlh0KlR3f3qcFh?=
 =?us-ascii?Q?+yp8HDxch93Tv/WU9BxUCKGRh8Cf8PJAe6vmUQaT1DRdZx1FzTg7ldG037vd?=
 =?us-ascii?Q?nTezjoL0EeawwSfDE/spEGoDSb2kyfFuoFOU7JDrlN1XZ+2gRzvh2MgJsurx?=
 =?us-ascii?Q?OLYgNipMbJlBtUwzTk3Vdy9H8dZlxg47Ihll3UkHagkrFFSE5CwWHRawiAHF?=
 =?us-ascii?Q?+VBylzJWQDFV+SaPLebJkKL7jSpLpbzJ6/MpkcG9/4A9SEZO6FT4d6ZaGTSh?=
 =?us-ascii?Q?dH0SEP7lv+E33tM+5VxD5p/Cpkg6n77HQ+0DG50ZMUP7HkMsddDCKHwy+g0c?=
 =?us-ascii?Q?EyvhNB4wk0HtZdAD/d1aWmxGpAT3nIhwdxmDO2DJwPNz/dT3wQufBR4V96Lp?=
 =?us-ascii?Q?vtKib2J0VKy69XEWczEn83Koy7XISvFo0WsC5M1mUjCwVzJ3u02crAJPq7i9?=
 =?us-ascii?Q?r29ontNEgM0zqAdBBkkbu3oOMAy03SALgkPiSU4lxO9BJeut/aUEBAUb+cQ8?=
 =?us-ascii?Q?8kX7UaR5r1Xt5Gb5M+fs056A9qnbCfGmyQB06gzXHoX54ME7ebqM3Meo/3gO?=
 =?us-ascii?Q?PK9Sr9gcLu7s46JH9yl3l2kdkMQkS0r5ftK2YGCXErE3byTJjM7HXndwvZm2?=
 =?us-ascii?Q?6FsCBBW2in7WzCdQUklmAzgbNbyvjcUoos2j7pINaVxV4GYRiNZyxeox+nNC?=
 =?us-ascii?Q?TwTut6XLbTxXtVFFE76C0oKe8bTeeNFE226RRHWy2Z07oYBhK5lafLfaI50z?=
 =?us-ascii?Q?6BN61YdlJF6OWoFdPlKc0wR1OGAM1UXwigRvCP6qlkmpX4GOLxzz++W8Lbjh?=
 =?us-ascii?Q?1s0k07Sd8CoUYvzhpHGMGDlndq6RfHAmwETFIWCMBzO5rmIKOdU+tAF5c3wl?=
 =?us-ascii?Q?3Wwf6rl2dGUvEOJ0IIcwURoHmt3oTwvSm2pMmo3yizZ7rbMEUWc/CpuqAM12?=
 =?us-ascii?Q?WjEkUYt/puBn0AasHItcBlXPAy3tf/iimKiPPXEuSrlHeasRmiAlfgd59U1W?=
 =?us-ascii?Q?UAqJ48s7F/yBQ/m8/JRkt7UPkV/bqX1SmhHl+z/CN3DX5ywh8L36Q6QawYUH?=
 =?us-ascii?Q?NDRyJK7l1Zaxh4x6YddIC3bUyQgcdMwY0kNadi3WwrFzcp/Q7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:50:29.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d4d38b-4e6c-43f5-5b4b-08dcfe37af55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

IOMMU Capability registers defines capabilities of IOMMU and information
needed for initialising MMIO registers and device table. This is useful
to dump these registers for debugging IOMMU related issues.

e.g.To get capability registers value for iommu<x>
  # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
  # cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index e56c050eb7c8..25a4e738d067 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -18,6 +18,7 @@ static struct dentry *amd_iommu_debugfs;
 #define	OFS_IN_SZ	8
 
 static int mmio_offset = -1;
+static int cap_offset = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -69,6 +70,61 @@ static int iommu_mmio_dump_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_mmio_dump);
 
+static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
+				      size_t cnt, loff_t *ppos)
+{
+	int ret;
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
+	if (cap_offset >= 0)
+		seq_printf(m, "0x%x\n", cap_offset);
+	else
+		seq_puts(m, "No or invalid input provided\n");
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
+
+static int iommu_capability_dump_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u32 value;
+	int err;
+
+	if (cap_offset < 0) {
+		seq_puts(m, "Please provide capability register's offset\n");
+		return 0;
+	}
+
+	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + cap_offset, &value);
+	if (err) {
+		seq_printf(m, "Not able to read capability register at 0x%x\n", cap_offset);
+		return 0;
+	}
+
+	seq_printf(m, "0x%08x\n", value);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_capability_dump);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -84,5 +140,9 @@ void amd_iommu_debugfs_setup(void)
 				    &iommu_mmio_fops);
 		debugfs_create_file("mmio_dump", 0444, iommu->debugfs, iommu,
 				    &iommu_mmio_dump_fops);
+		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
+				    &iommu_capability_fops);
+		debugfs_create_file("capability_dump", 0444, iommu->debugfs,
+				    iommu, &iommu_capability_dump_fops);
 	}
 }
-- 
2.25.1

