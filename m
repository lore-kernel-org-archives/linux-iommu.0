Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE5192B98
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879394; cv=fail; b=WPFWcjBeQUjikG4BEzfYokm7F9alhgSiAZifZdlzQM630+hs3TOL+dH4OxO4swH8cmQ2EuO5afJERIvdx3RxQz7hREtwBx1Q3AoVJ1RAvfFn2MK4QckY6VF63EIWWIwmBAuledu9Kh3V5lv8oCpMSMl2SU2he7z6DdJkisS9fcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879394; c=relaxed/simple;
	bh=7zOXN5ztrkoonuhDdUWHZBFyAt2w3PJ5gROE2e1ki2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdUtpVngIEo6p87EYrfaEwWGcP9a0Yyn+Ds6010NrMrzZKLwJcEAkN2SMr7OX9grbtRP82GlgCmBwhiBJ0rSx+dSaAUnIsO6tM1HwpD9GLlX7tUnYZjDnbjCQRgykbSf/KG87dd2lNa5v8tS2zesPqJPkX/Ypnyiv49fampb4yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJVN4RdJ; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJVN4RdJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww4GEj9WRotAzc7ta+wfmJ2wS1ZfsggZDk6KKUmyfCqzDMzqTSP8WNd2ZlwoM+Qy72CzAfrAhmwvnJn/2NgDN1KmWSk8JpBCQNDp4lq34cp2z4yon0RVLKhFmTNDvoCuu0jxBdvPzMYeskxUx3ufIO8jcYxrj+wmsEVbRt6VXGwwJF34IrSSC7iX7v08mpg/1xxoyVxYW9cadys9BbJ89/XiKeXNXFt7aehVZq88JaaJQSfyRLvlGltYQ72YlwHhrtd107oo/lpH5gZdWFuFNCxId03Y3h6qnfvL0ckKZfw6D6st16g+Mije08Uuy9fmLlhiPqIAs0Xw6/feBMa+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/CWWzeaho81nHjNzYsskfRTkPS76/RWJLyDdiCa20k=;
 b=JLnAs4Ht35Yhr8SVLiKAI61FEGf7QdML0cSP4ocwjom/NcZVCnpQI4eDkdrsdBqyp7L1rKSwYoWKxrucKGOnh4kgD1WpzgEeUPJa/SxU8/55PaI+t6ZUkhlgmOWMfvDeHJwz9nxxs+5XedAMJZ0HV9BucUju1ceoFGsdbDD5Y68KLNNA0noqSVhB/n3HPXutYRas7e24i3WHEJPONLKnCMhpiDY3VdMMwKb1UhIVcqMNHmYJ17NXRGCh9rEuC8EEeUfpRMsnbt7mckljbr9ph3JQoR2jjxpnKX2v8HB8GAQI88Odyf06b8xxE9q2mcVpStR+QmyNEzN5J2dBayGFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/CWWzeaho81nHjNzYsskfRTkPS76/RWJLyDdiCa20k=;
 b=tJVN4RdJjvsQ/CO46dAKsYlU98s+YI2sU59bC7gMiFBKQWou4HJYd7FQ76imXsIC5HLzllzdDhNsCB6MoHd4Xsog1Gglv4Gpt+Oo+1wc5D0vPoLeEcmOVHWxi6GsFwS0LnJSih0De3BVuLV5bqM35LT5c/w3OQyIfyaklJXlAjo=
Received: from CY5P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::24) by
 LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 07:49:50 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::6f) by CY5P221CA0015.outlook.office365.com
 (2603:10b6:930:b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Wed, 6 Nov 2024 07:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:49:49 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:48:24 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Wed, 6 Nov 2024 13:16:33 +0530
Message-ID: <20241106074639.2039-3-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1227fb62-e09e-4a73-0d35-08dcfe37975a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3k834RXlvUboPyO1qUr8pNxWZ1ZuEHj0Kv0SmafGCvegPd8/u4YlNyNbQVHp?=
 =?us-ascii?Q?5ZUoq+1zNHSLyv3fGGU1BP1aRUrNnPiAVdmE99Pi2Ua4r7IfBE05VFKb9q6J?=
 =?us-ascii?Q?8gwISer8MiUa0Yk+Jj0rKEPXpaz7Tbg1Afx/pHfCZY/B0uM+jBy8/+TMpQp3?=
 =?us-ascii?Q?EiQrI21kG+PQXpUocyjGn4RTVahTdRb6EQj1qnvAupkLqHIibcxAGzMi7KY4?=
 =?us-ascii?Q?FJQn0vJaGKKwmWasfepV2/RbQmsXaZXQi8Y6oLJyuSTOXByBtV/c+/eYUkoA?=
 =?us-ascii?Q?WZIW9LQqzp1h+WfhKIg3jlEIBZ+zkAy7O8I/DVwW0iqQHZqKSFRDTwmvht0F?=
 =?us-ascii?Q?kZcodnMqTtlUAyfVV+QhlnfkspPvNWYLLD4dwrgYJsE6uIHwk8sw7Ph9ruiF?=
 =?us-ascii?Q?gTtBAZZ5KHhSnEMqZXrMayHfFU6CH03dqI8L6FbvKQFVOfNl7Bzxfgpvgj0L?=
 =?us-ascii?Q?tO+gReq5r5cWMOxlC9p8Ola73qIiByc/p6z9CA+lqSi/LiKQo0boS50SZvk4?=
 =?us-ascii?Q?nP/zYept1THWwV5Fg3vaF8Hq93+vdAojTF0Ufl+o+WS7aTVebi3fo6/hHaVE?=
 =?us-ascii?Q?MqOvhNaSpg1UFbc8pJsx5Z0p9AvK/D4PyH9f+pe7KRN6hHoi5vAuoaXvlB9+?=
 =?us-ascii?Q?/xz8Jwup2WtTkChjxfzoUmd+gnikM9EvGc9t+3bpleyfPefIGCNdfyFaxiPN?=
 =?us-ascii?Q?XD4M7S6p6nn+ksd4DoPGtbRlZP+uj61SA4XQN4CsoDZc9N4w3RGGR5E4G3iM?=
 =?us-ascii?Q?cjxowI7aenEkB+YBcr1LR2gN6v830iVAL5nGJieMPCBIpyhkj7FILEHc2Kwv?=
 =?us-ascii?Q?eQ42EC6qjBovNikJW3/NC4CWcgZp8V1QPxGeNheniN4CWFyYI9aqceMlo33T?=
 =?us-ascii?Q?T9AvULkCTH8Re00WQ/0P7DedMwN9GSb7djrjQ63L8FoiH/3Pm6x7Ckt8uCrI?=
 =?us-ascii?Q?D4Xlf6zYe7CXsrTpptkLnBwT9HNMdAUZ+fNmeySttPT+S0/2XWwWeQjXbeYA?=
 =?us-ascii?Q?18UNiVzJ0E3AUJUB4jioUz3xk/rxvI9E3yMLB3kGAx6v++vPXHEGeo69FLbi?=
 =?us-ascii?Q?jQ7v8+g7MFpF3vwnGy7vIGRjOQYaGFeNzsfuxSG5MOICvNj2o6L+fg+EOkOA?=
 =?us-ascii?Q?cu23tH7nCIHXf222mTn82m3WMSj+5fszMY8Q9IAMT3DHre0WLzJY6T3sF5AI?=
 =?us-ascii?Q?78DaC5mvZl4qF9asYc5VuY5+AWgSDNyrC2fcEK96gVWKyDv1rC2SFwsa0Ftz?=
 =?us-ascii?Q?ezWjgpiaZBU5FQbVOlNpPbhfau3T1TtauQXDQWdKl8OeBtlsISPaDVlm/f9Y?=
 =?us-ascii?Q?JyOKs6sEW5D0x31iy+MwQaocMxGakrLYZ9sCZI6W/AwFVb52Q1Q44B3TW40n?=
 =?us-ascii?Q?KEwyNsSHCjeKaU27rhPfwTr33jcQKvFIfPTicqBLugj5PM1v1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:49:49.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1227fb62-e09e-4a73-0d35-08dcfe37975a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
1. To get mmio registers value for iommu<x>
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio_dump

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..e56c050eb7c8 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,59 @@
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
+	if (mmio_offset >= 0)
+		seq_printf(m, "0x%x\n", mmio_offset);
+	else
+		seq_puts(m, "No or invalid input provided\n");
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
+
+static int iommu_mmio_dump_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u32 value;
+
+	if (mmio_offset < 0) {
+		seq_puts(m, "Please provide mmio register's offset\n");
+		return 0;
+	}
+
+	value = readl(iommu->mmio_base + mmio_offset);
+	seq_printf(m, "0x%08x\n", value);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_mmio_dump);
 
 void amd_iommu_debugfs_setup(void)
 {
@@ -26,5 +79,10 @@ void amd_iommu_debugfs_setup(void)
 	for_each_iommu(iommu) {
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+
+		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
+				    &iommu_mmio_fops);
+		debugfs_create_file("mmio_dump", 0444, iommu->debugfs, iommu,
+				    &iommu_mmio_dump_fops);
 	}
 }
-- 
2.25.1

