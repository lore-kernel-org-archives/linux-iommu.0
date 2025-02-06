Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AF2236F6
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821664; cv=fail; b=Gyk1R2go25mEUqrc428QWdyxq8oX6DxGx0BJvL1pSEmstJS/5qYprFp9nk9WJ6+ppMrX8kgDSiQeMW8FSBz2Vmd5u7n1ecB5MG1nU535dnqAeEaJcEBcdm2b6BR96FMxu2mxCq+mmjapLzurbrQhck8CDOHpPV/cvLLiQ6DIy1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821664; c=relaxed/simple;
	bh=8/glszcPjOcy+WH1zy/akcCSd+ZJkabZwr18zBpbpDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRSF8Z3clnQFqQBKSo/giv+NXFjZME1Q65I6J62fr9hFbnKrUl31w5ovtXQYgoWgLwnRmmL92DkjDD3jukxAK+yA+dZPAn/X87P6cWU6It9PifoLWHu57L7EORgVQE/9HrUWaGXhRQ1NP6Pi1CfbOcB71uHrHIrtFnvoM7tMxKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WWs0egJi; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WWs0egJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvKvqfJJ/yXmU8jKyhp2EdMrhmwqtB2dZkH0kSqb7tTPfC+am8DbpJwEDqLr8nYy967AR2hlzwDYYSpJJImtLd+H/1quYKk1etFrGE8LeHDcBUvzqOIUpRLHOk/YZ2LtFUdPFwk8XL45Eeh+djohtHqKXZRzh1GqjctaN2LoJ95aQ7sJ402ghARbSNmMlCnHo7Ezb62+ut9O5Z3gmqihbvnc42e6hq4cfZMFDQnw25E1EmI/eA/8bjzq+C3ik1zj3FZ09ffcOn+MQgruRiMcvQGEwMc2j8dcSMJwu0ne5CUWftU+b/3egRImfCWJf3d+IaSe/WGdU2vs1HW8/apjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO6W6T8LWDduFbQ0WvR0AQA2FvQC4L75PfwUO6j3FTA=;
 b=Dkglq+KGWYRNQfvg7cz69B8yBQIFUjRqE804ifO7KqU8m1dIIQkDH6/bmFrqjGLkaDUXVFtMpwPalnasTzrR/+CiTKwTOGduj+AAsZlN16Lqy1ItmPA+JXyINhiiFOAf9eDVGoNkHCcPfXmzKOlW9wDedagDdGnypCPfX3yn7IJv4XYhqJ6MpkkB6fgdYuo4Eedp8awFOo6oOFR1BtMpcxWfibwkmBNwEvL5wT/heF1VvoGG8BjriEHHzUxsTIT+FgJfzABf05pfNWV2o2tiNHrGaBPGnb4EGtNbrFcqMTA/zuPfqREoOcj9uS3HLF/gyOP1zC1PYEiVCR043CEY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO6W6T8LWDduFbQ0WvR0AQA2FvQC4L75PfwUO6j3FTA=;
 b=WWs0egJiLvNGxP+iFKH/vAUoyAlG9psQeYHgA7XfKeyzQA+NSI0i38IWMicd/DU2i1vAlBwKV/jkmVap6a1j6tf2EqK7Yhsa2XSr2dOF+uj6k5B4t+ybX1YtEBBgwISz/le/zkM5gBP/qXRYCCDjXT4yIYbxleBPFZdYgFG0XOs=
Received: from BN1PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:e1::30)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 06:01:00 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::be) by BN1PR12CA0025.outlook.office365.com
 (2603:10b6:408:e1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 6 Feb 2025 06:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:00:59 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:00:55 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Thu, 6 Feb 2025 11:29:57 +0530
Message-ID: <20250206060003.685-3-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: f207bcb4-2e20-4045-625a-08dd4673a142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/2l15Sn0WjfTcFsGhVdzacUsolKYiSSZEo6BrCCv/XPVGbod+BjSWTtq1ik?=
 =?us-ascii?Q?luwCR6Y7/d9ZOHy8XisWTZiFAjBKIia1F7mD9X2+bt1yUjbyq391AYiXFvw5?=
 =?us-ascii?Q?1UmDtXwX3a02oRUouSChK5YqiXlaA//Y70rcjBRsWMc21s9ZqLDH0pz1iKOl?=
 =?us-ascii?Q?/fXxYq7Yp+JRc9qkJJWTKXh4fipfUS32cu33Vm2BvIi+a9bIkhZy052pigxO?=
 =?us-ascii?Q?lQ6Wd8UQVj0zgAc79GIDE+3D59/YRB31SDTQqhW+yU18rPomEKP6h0iF6nQt?=
 =?us-ascii?Q?WfSVP/bTacVSazLoPtchVCWk5EyNE83OvS9dkr/Cw3Yhfjm3aNHCnneSaJN2?=
 =?us-ascii?Q?Sz+gT3dUIXX/chjFzVU8kdRarPolSvG0VdQJuxflhMPZjSs97vjA4CtDKT1i?=
 =?us-ascii?Q?T/KIjy18dKiMbLTQFzK6ToA6jfovmSzSHhrgts7tPR88g+WUP+qfhjcIMH27?=
 =?us-ascii?Q?6bp6Ga9/86HTvEwjfn9p1eGN70UBHX7RFDziK/7EpOtwsQzk/8Li59qthGDY?=
 =?us-ascii?Q?HVzXSUC16RDVllOZK0IfzGRcLenfLlhWPGvF//Vs2LetqI58VDwf1EdweJCp?=
 =?us-ascii?Q?kfpHIwhmPCM9XUTWwRIm5T+qGKo/Y1O+9+MkjEdVg/skk8HQt35QTRV4cv8g?=
 =?us-ascii?Q?LeGbSKvuNX3uR5WFoVTa4sQs2NLMsQYjr5oysXGL8bheq/AyMrJ/3w8Kl9SV?=
 =?us-ascii?Q?U95BbAU4VJ0nSrUUXhs/YYAgB7NKsthnQcPGlkMR6cCFPBMtuSx9oSnTmC0J?=
 =?us-ascii?Q?XvnCew/H7MN4nddVXPuzRDf+hULW+YVwTVxWdO9I2tVqWQgaXon0cYnNyuAd?=
 =?us-ascii?Q?T4wWIVoP97H9tnOBgR4SeBWFN9LKHAWwJGzpHCN9Yvi+SGIOVKq0eXd/BRrE?=
 =?us-ascii?Q?ghU4vxJvQsZy+kBiJdlnaaEmO0PF54NF91v9kf6on/m8QBw7c1lBzWJOZv6c?=
 =?us-ascii?Q?fVUIShphwcXfYbHueD16lIRFgpUTrqq31jfEhquKJUZ1cZvQPHzv08HSMoTJ?=
 =?us-ascii?Q?pK+QZQlReQt6amsEGoMP2D+FImitMW+oc/vM3Q9+JQ/n83mIjfw10UdSx7n+?=
 =?us-ascii?Q?CgRt2fNAvY0av+a8z9EU+Bx1uGDNZKKVZb9zhhgmnnkquJpuXlAwvlAWr29n?=
 =?us-ascii?Q?EHoiB8uSyTkc8yvC712W174pSkOQJNdBsKUaruqR2AyB1MxNqJrVy0f6nuvs?=
 =?us-ascii?Q?HNGaTJ9HaMVzp5gjHgEVHwxWqYm3+b/GUp2OQPJJ5MCSu3ltCDF+Do5IzaMU?=
 =?us-ascii?Q?r5CsPio+ED4gszHgz1xk6b9oRGZ0o+mKh/NMUyc+dM955Vd1DR+de+uNXlma?=
 =?us-ascii?Q?7X4vGkiX9qKPErW+7v+zYCpULBEVu4LPQoLeB0bgVZ4qiMr47qItV0PsQ5wG?=
 =?us-ascii?Q?6CHQOmZjM4DjWkcY3bL2JveALrBJRcbAM61LJcOkw2k5hQW6ulL5qrMlRoZ4?=
 =?us-ascii?Q?ef/ePof/M7N3HQX9jkCkV2QBmWYp8YcpmJC5QBGvkqD6UaQimGJ81lRqotnx?=
 =?us-ascii?Q?40V7pyGanUp6L/A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:00:59.6519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f207bcb4-2e20-4045-625a-08dd4673a142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
1. To get mmio registers value for iommu<x>
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..b16b62ae7111 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,48 @@
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
+	struct amd_iommu *iommu = m->private;
+	u32 value;
+
+	if (mmio_offset < 0) {
+		seq_puts(m, "Please provide mmio register's offset\n");
+		return 0;
+	}
+
+	value = readl(iommu->mmio_base + mmio_offset);
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", mmio_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
 void amd_iommu_debugfs_setup(void)
 {
@@ -26,5 +68,8 @@ void amd_iommu_debugfs_setup(void)
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

