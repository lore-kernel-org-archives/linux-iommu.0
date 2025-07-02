Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A29248F7A
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449143; cv=fail; b=XSBCTcL74xcHg6Gk2JMQ54/PNgmiv1cHti4Igi+kotpY8+e0Qof4oAEiydVtKdQBnZdAe5XnCulYas5g/XFBaDGMuuq6cObQy4UkhyUXeUGqjlR1A7rimxYAYDesAbwYdAwYBDX0plYnXXPqk9GvAzZLYQVHWCpBeGTQXXjTv44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449143; c=relaxed/simple;
	bh=+if0nUmLF132f6uT3TwB6+8+gKdsCQbJ/KvK2X+G1c4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6ES7iLChAmvm1h68L5t1sno0A/6lBgHSRIzfSJsQIBDSX6k7KBPIKknk41xUssGcKKlddWRx4KAwEUN6Wt2z1ZLrRWM3Nrmd3MF5KNdQbWmzGrtpQZJZndVGK7PMKdCZ+eqzaT2gFIU93z+NzSC563IlGH9bmvwNrK3Rp8wuJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0i0r/her; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0i0r/her"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1fvSeyRafHMWjowBWO93Xfe6imZuYUEuFDyPdEmNK9fU8IZmq2lqdmO6tJGL18RRAdADVkr5CJcRw5Rk82MzbsHWxcluZq2i+hM9IOhj+PL78er/l1WfepGgwbf/WVkiIJrDAz1nfEZnZ/MQGDAXLIUugd/xZM+afj1AtGGZZm5SrEf1tsyaAbCALRe8+ysCe0L8gRngrPYDVKaZfstxl1J/iN9g5AXWBd4QVJb/kUGgEyDNRq9n1tn8RwnWWIQXI9mlura3lqhlVjnvcdfCpcWB9WgowpkNHw2uHZd6Tun92kdwRjn1o1nEWbKGNfM70PPlUUgd3ujiFZadvmidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqaBUbX2+khCfr1cexkFsC7K8oazyEOV48NVi5KOhow=;
 b=DPpvMcixp4OiYR1CQvGqlEdrASWxoN5IPJdShyC5aoML8xp7QfLAG1TI90WdXxgTh395HkL0Jg/LX9uPl9K/2jnjew27CBXimmVYZeD+BeASmZQCz9Eq7bRfaTIxGdSg1YvqPoRaqPiVTtBZJ36VLfrC/ARf4bP3lZh2irAQs7A+naJmW7lwdvlaUcSGnrdywrCy/vlU8XqCSBR8YxhQnzCxTqnaWArj/yctigtIoOgt3WdE7LJ1mzz+tziJkODdRE4O4eAQSkMRONMQMuRbdvFcpAch1XTubrDz110IHxkuyXnFpV7TSon+/lPJK9LM41AntqgxApPHNoNHNf4UZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqaBUbX2+khCfr1cexkFsC7K8oazyEOV48NVi5KOhow=;
 b=0i0r/herkucmsmOPACOOaRKisCZe7hA/mB8KHCnJDzQQXvdOQZnl4NmhuSU7rjVBk1ItkcnX0E4nD9Nl4jBOOmCeWngFJzkVc8BiN12pV7hK5qCMV9wtwCayZMqOonSsvHGDLhUrXQPE/E0Nx2AdSsbjk/JpzacS7115c6Y+bL8=
Received: from CH0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:610:e4::7)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 2 Jul
 2025 09:38:58 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::ea) by CH0PR03CA0182.outlook.office365.com
 (2603:10b6:610:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 09:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:38:58 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:38:55 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Wed, 2 Jul 2025 15:07:58 +0530
Message-ID: <20250702093804.849-3-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 13857265-7862-42df-672f-08ddb94c4555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZEzv8yJWw0ZOJc+oVzommWF6iyLZzE82ypPr5x2P8tBoDuDegZwLJ0rpxvZG?=
 =?us-ascii?Q?0mmx+s3Aid53rLWVoGmfjr+5+bGm5a8O2hdugcfLbv5QmfmneawbbOS2JODA?=
 =?us-ascii?Q?Ai8N8dhArjcHS9Spuj90nSM1mSFBZcG5HotKt63aUQDtktq/Qf3QYSR3HwAK?=
 =?us-ascii?Q?iHosKQ3zH+cJmAo1O0zFccqM8tmgz6rdd2Hbtspt0rFdHu3kE9IgucgFGT1Q?=
 =?us-ascii?Q?xh8LMQIcRH2TDVf572JEvNDpTi5ILGh4GkfqpKxs/ryXG9kLxmGHVB38wfNf?=
 =?us-ascii?Q?Gel/umD34vENdLbKIsUjxASknr5GuYWJGFeZ6g/nw9S7M+v6ejixUc61x6/3?=
 =?us-ascii?Q?nRA3/58Uikv7ztnysSIAtuRIJ+X822S5xLV9llEaUKgM11LnXeow8pDRtGT0?=
 =?us-ascii?Q?d/lnf344LLb+zTvwTVZb0mVljI89U2T+WZxh3921f3q2lCJBmh8AD+DO6QwT?=
 =?us-ascii?Q?nHAmLDbHsbNbPtEsniO5DCMQylkImlQofFI7dIQ4ljVGBqHIiaBJf1814tW2?=
 =?us-ascii?Q?9JBWyNSzMLchrzrQ8iOEvy02XSPv5FlR1EptqxsWpF46Ij23gkJaD4rx0rij?=
 =?us-ascii?Q?2Qf8Tf8n8dvMIk81ivYpVI6byMpPpzUP3Drf8buNU1gcV09L7PTbAc7KA/Au?=
 =?us-ascii?Q?8ApLhxd93CRVikg5wZAtIlbARp/EuRNiBTNIggkyywbagQUnNjzeTLzma591?=
 =?us-ascii?Q?D+5jJogA3uC4mGebb8o4Mt/KDT000JODhxanrvmD1gErzfsGfRuwef7wGVLJ?=
 =?us-ascii?Q?/9G3C0yL4VHHdx4r8wY7DNKpAxVHra5Xc5W77klS19kF2WsdjEpVsiVH0nVn?=
 =?us-ascii?Q?UlB+WlIuaSsJ/SeQIckwJpBO4Ryi6VqSzduuw9fK9T3Iol8zgzIXZfTMvaKM?=
 =?us-ascii?Q?2JUOJVJYL07pAQAW19AlTymhFh7o2hHu03BgzeUvD++G5zgF5Of0B1vQbktN?=
 =?us-ascii?Q?9aFgpWB7OfAxr5uMjkUMJKph4B/oUe8bbvVJrC3SLdKOHL9Pho8DbIGoOd4f?=
 =?us-ascii?Q?harXTbksqFPOHeCXemVkpVYguQnNTB27tABBVD+v/SDvu3xnY+H9c2lmfLRy?=
 =?us-ascii?Q?3jJYNtg67Y0GYhiKcH1F1PPhK3XCQZMhFWRf7htSAwLFBDc2zSp4F9KP00Jf?=
 =?us-ascii?Q?51nrk0u1k4JgKMGk6fdOO6e2H4Qgfet5/d/i8Py55+BeyfFHcu/Q5AIHBpCT?=
 =?us-ascii?Q?MLTENFUP9bs+vaqMkwzo+waQQGV1cjFxRgtECXjUiBLrQ36h89Tq/VEn17Fr?=
 =?us-ascii?Q?456KKEuR5smA4RZlZwF6k781Aq36pN9WUB7aLUVAb8naeT3zoiy8hBhX1Zzn?=
 =?us-ascii?Q?k8bmj19sYqCB3P1yBLDFku4+XxiXECItJoYv1EQp9JsTIfQx7xZo1RyTZMec?=
 =?us-ascii?Q?pbJt9EEFJdnmsrow40x/8SOEruMLRde2MhSAU3bgtexdkUTz5UHAkjskxanq?=
 =?us-ascii?Q?GitV6QdUWrQ07y0ElNXIR5kKruHcjbFrqGWBuI0epSSJjvzUyWJ44LiQy5PE?=
 =?us-ascii?Q?P/A8agMRT7dp/luyDrv1WBJIcTInE9Nh/P7Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:38:58.7797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13857265-7862-42df-672f-08ddb94c4555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
-> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/debugfs.c         | 47 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5089b58e528a..5aec9cc7441f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -796,6 +796,7 @@ struct amd_iommu {
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
 	struct dentry *debugfs;
+	int dbg_mmio_offset;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..c025b4d2398d 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,48 @@
 static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
+#define	OFS_IN_SZ	8
+
+static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	iommu->dbg_mmio_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->dbg_mmio_offset);
+	if (ret)
+		return ret;
+
+	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
+		iommu->dbg_mmio_offset = -1;
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
+	if (iommu->dbg_mmio_offset < 0) {
+		seq_puts(m, "Please provide mmio register's offset\n");
+		return 0;
+	}
+
+	value = readq(iommu->mmio_base + iommu->dbg_mmio_offset);
+	seq_printf(m, "Offset:0x%x Value:0x%016llx\n", iommu->dbg_mmio_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
 void amd_iommu_debugfs_setup(void)
 {
@@ -24,7 +66,12 @@ void amd_iommu_debugfs_setup(void)
 	amd_iommu_debugfs = debugfs_create_dir("amd", iommu_debugfs_dir);
 
 	for_each_iommu(iommu) {
+		iommu->dbg_mmio_offset = -1;
+
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+
+		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
+				    &iommu_mmio_fops);
 	}
 }
-- 
2.25.1

