Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F7175D59
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384107; cv=fail; b=MB+lRJvEu8KH9F5q5unJaIqYu0eVFhJobFZr2nc62pEm9Mf9cO747ZnOWfi+tV73CLTtCl4yPP8Q4wlNGbCImfpM/txSFC62W4coVN3+vDTVyexyEEEVnaoP/ZNu2v7Tmji8FToM/GH2GLlVy4tNmIB14Ow0yAhmv+HoYyEg934=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384107; c=relaxed/simple;
	bh=zCGZr1HGv65881Jnynk9ROpsdpu/inTxqBJzSapvaw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNx11ikI19OL5mB58qU+4BinpYpdNHotAuHEfDkIVqCkfqcY3/xpLOWHkUlY7dnKgEs1Y2SPBDB5tj00AuBttk5HK+0LrpCmQxwS/xTpgruXxF5nANalo1tWYc2DkwIoO1OdGUZ8V0XAIIto+zsG26JO13Tzo9nMn+baSfOzIvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ud71iziD; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ud71iziD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqEDnsk9yB6e91eRAKvNnFVkasWagax8HnlNF+8UVOQkImIbKsv60LL0O60CsWYJMOqvBllIAfKl7IR8Yi7HAo2HRLXKgZQHWvCdS0/Azo7jjN2zrtvdO2vZsBXA0/r6913zQWoAOH01gYwBX0+MLcPlZNHChtI+7Pl8jtrLc+cRv4g903zDlmIRdtu0C5YJDaqb0/WB7iPQ5KqnKbx0hel+eKsm17u0vLk5w0AYlrhJMpEFvil2aTqAribDBjedhtISJSpAptXqYVDL4oO1tUPSsolOHUz85UoDis2lrkfeU7Z1curnVpTpbvYICOnJkG3dcCt1ghWlIN5aG4G9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xmDVfXy++NTJfIelaqomkDcLHBRhVvy2lZS4eSyi4s=;
 b=hsRbSbSphJQ5UfaBHi+rlUJIOJ+52Uq9K+8Hv7Jp59QxncHB+WGiXol3TQ1nKuCb+1HcCwHGIRDOLeCO6T/7fZGFwpeY3cpqw8/56bJZ6HYmSuPdSV4QlyggMKOMK3wRYXAoM1ii4ZVqKwlRcUDAvg1nRn+EnOHzUN/0+ongnMCF9QsRjAULReCwhKupxwXc8+NBxo4+xopWYJbyx0fmdKGbHDEDAGhER2S8f7wOU4iB3WlZctEQOMG7v490Ix32+eMWoB8ypQ7Ag3lluvrsgV2a+3yt+4djIyLDhiqanOge3BvdNiW54nPeENysnBG1PVIlqzgoS/TgRyIBzHThow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xmDVfXy++NTJfIelaqomkDcLHBRhVvy2lZS4eSyi4s=;
 b=ud71iziDbPfE5Jss12ysjQr1WfK/M94Wcl38DUvZLNF6bp3nJ3YybNuMWkjppApXmfcTW1cl4DfHBpNTOfQQUq2WbdTasaIxAAnnCMhszL7dkzD/JR6tzEsRWCLZm/blR5s8Kl1H0zd/53n0IDamdjqpJao0ry3LVjCITSOLob4=
Received: from CY8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::16)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 8 Oct
 2024 10:41:43 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::85) by CY8P220CA0032.outlook.office365.com
 (2603:10b6:930:47::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 10:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:41:42 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:41:39 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Tue, 8 Oct 2024 16:10:30 +0530
Message-ID: <20241008104035.4008-4-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
References: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5894b049-956a-497a-4d77-08dce785cc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gac1UN2jPgCICMgR+I45qe1YKD1U0Gxz6+1Ya8F7PCzpYKTM6t4P1KsHY5EB?=
 =?us-ascii?Q?XS6K1DxOy12BBcGEv2pBq7P35+jHNPSWa77N73F3l+8EnIGZdTBn0IK5sRZY?=
 =?us-ascii?Q?dUX5CjTpVf95Bn23IU+pjJroEx6XuuuEwuapTK/hHA3AJ/jo6BDfRaW1dHLA?=
 =?us-ascii?Q?r94v8D+ZrawQkUve1yqWrbfTXwwrCad5PCcG77s05qfXh1OuSOUGQeQQmzOX?=
 =?us-ascii?Q?zzejvVcTjoieoV8SBYHBohgWabHsvwPSVij1jkbkPjFxoslXGDcfWjoErOa2?=
 =?us-ascii?Q?heq2J4w2FI0jq03pkLakf4gEVZbcIAIYSluZnVmiCyEcy+vauuZR+f1Ai7lT?=
 =?us-ascii?Q?BGynE37oED4pcDCnGgF9cDiF742jwvto1fXUSsEUBSoaRgkx15p3iUKT6DJ+?=
 =?us-ascii?Q?WD2T+bkdQqcJbSCjW+4GYPYxI6agBzEtae4tOimxj/uS24JjaV+XC+XKzGYe?=
 =?us-ascii?Q?sl5h6Rn7l0B9880IrME8I/E8CuKMCc5Pn7gIYlzIg5gxH8EL9QvSUcXC2ArR?=
 =?us-ascii?Q?2D4iotquj3xt0fbzfHDnE+nsekE3F98nLC4/o5vY6n/GS1GCsgpe8hselSY6?=
 =?us-ascii?Q?t2VkZqU5vMNS+BtcVCs6+oiL5gIXlW/juW+gT41acTCYxplHcfFjuakitzQC?=
 =?us-ascii?Q?1kDiHwqYwEZvVwLmWh3MEhRhlR2yWUIU0G4i+cEfj1moNl0MBB4q3m34Ftim?=
 =?us-ascii?Q?8s6nVPfptVbSsDKQxd89caaIySanyInFixh9YFhi5QCRA3pXZ0REf2Toofdo?=
 =?us-ascii?Q?K88Ot7fS1fNpqIDVkMlXK4vy6fNN6fhL8Sak99Qa4iQnt0oY+hNJT26fVLCy?=
 =?us-ascii?Q?l5FEa2NL94o4Csck+DyaxfaFs2G8BZOx6xaLs70hd5A/h/U/tNYP/3dIx72a?=
 =?us-ascii?Q?rPxdQy12a00JIYFPEVreUSOtXaBWl7Eml2a8SgcKTi/M9elTEQcuf8bUjUD3?=
 =?us-ascii?Q?wNQtrQzt0N6pEQ9HadRegzAtY6sY95qh7IsBsWUdC9JCtDYFAEya0rDy5gTA?=
 =?us-ascii?Q?SDu9Atooz2cF81dQGH5Fj119sWct3ItoZxchoewsO4xPIZ6IygWUAaYZQ1s6?=
 =?us-ascii?Q?RK7xzEVQRHbktoin99/19Z5CRgTziHM3daO7vJWR5gzEulfAlWrYiNUjyXIU?=
 =?us-ascii?Q?Cj4fY/ixrBxSyMDGypBvHuHCFoBvEIdOnGVaHoI/fL/CVY/j5kj68pt5k5Yp?=
 =?us-ascii?Q?l8hn7uqiRdBTgJcRGk0/wM4dME3lzAllguOcliqNRR1gJQJDQXPkMIJ99edX?=
 =?us-ascii?Q?2XZ824nwSrLKlIRTA5UPf0KseK8JnnR+nxJqHpzZYwZ32lQZEz4Ex/rmh8fY?=
 =?us-ascii?Q?j1WsEX7nsWOW98FMlMfo4owbjTi/BfWTGRzVFHe+viXhYNm58GkY5zTV4s18?=
 =?us-ascii?Q?lDvZ7MyWh7fTlb3Zp4klTUwWHUel?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:41:42.5061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5894b049-956a-497a-4d77-08dce785cc79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

IOMMU Capability registers defines capabilities of IOMMU and information
needed for initialising MMIO registers and device table. This is useful
to dump these registers for debugging IOMMU related issues.

e.g.To get capability registers value for iommu<x>
  # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
  # cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 77 +++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 30d6819e9a35..c3ef15e7b918 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -18,6 +18,7 @@ static struct dentry *amd_iommu_debugfs;
 #define	OFS_IN_SZ	8
 
 static int mmio_offset = -1;
+static int cap_offset = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -86,6 +87,78 @@ static int iommu_mmio_dump_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_mmio_dump);
 
+static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
+				      size_t cnt, loff_t *ppos)
+{
+	char *cap_ptr_ofs;
+	int ret = cnt;
+
+	if (cnt > OFS_IN_SZ) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	cap_ptr_ofs = memdup_user_nul(ubuf, cnt);
+	if (IS_ERR(cap_ptr_ofs)) {
+		ret = PTR_ERR(cap_ptr_ofs);
+		goto err;
+	}
+
+	if (kstrtou32(cap_ptr_ofs, 0, &cap_offset) < 0) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	/* Capability register at offset 0x14 is the last IOMMU capability register. */
+	if (cap_offset > 0x14) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	kfree(cap_ptr_ofs);
+	*ppos += cnt;
+	return ret;
+
+free:
+	kfree(cap_ptr_ofs);
+err:
+	cap_offset = -1;
+	return ret;
+}
+
+static int iommu_capability_show(struct seq_file *m, void *unused)
+{
+	if (cap_offset >= 0)
+		seq_printf(m, "0x%x\n", cap_offset);
+	else
+		seq_puts(m, "No or invalid input provided\n");
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
@@ -101,5 +174,9 @@ void amd_iommu_debugfs_setup(void)
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

