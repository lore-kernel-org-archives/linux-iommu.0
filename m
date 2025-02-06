Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9E1FAC52
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821685; cv=fail; b=p2saYBv3k7jFcO7AZf0/6x/90HKxdZDWlTuA2v2U5wIbDJUs15qIACwj6IOx4HFfgaN9xiYiEJHm1wEV9vXF+yWYQcUGNObWJSqh+Mb0p+owk8zg82Fyqx2jFdJWDDT1KyrOeE3YqP2d2djcBynpcQUBKIuTX7P0oXQsfE6DOOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821685; c=relaxed/simple;
	bh=IJeB+MHVIg1RCzBU3Lioe8P5Vi+rtII6wD8fzUNCS/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uit9UPCT1w+4+vB6o3KlVd9lRlYcQYbXR63eDssB51QmXZfeEfQsGnG++pylfdxvSdDhwDvOOKbny4sUuLXeAvdZ2hfBzD486XnKzMMxs2R1NH+VUi0vC4g18tzaXNHdcrCRj0u2MCGTxGIHRGb95xUoklll5vrYtNiA7IihCNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BKhHQZ8n; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BKhHQZ8n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFGRs8g6KQnp5FlnM38/DD86r0agPaNH5xJIM6Uiyn6C1nXh2Tw+K+8VYfV+ZJJlVLpMMVujL+5/PnEli9BVebrX5lCHxvXFJSopRb7Ibsmm9xoe00NKlL5QSqbRm9+i0xDos8Z8+qgsVyfYfO9nHJyyTFVs/4e+u9+q7tsUGASSiwJBlIaVg9JCHcjLJWVhR+Um4DNu4kj/XVL24+HkfJceTyUOOr61x+pfTm+nU+37AnjrqAAIGtXAJ9u/bTlW/AM+MItZ9w0l+DHe0JBJEqjS7WcGHEcgtZcMRq3C7IhG7EfsEl97U65HEfIuaDAG2zHd4NOx5rCqiQ7MFzjV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sFQ8nOGTmGxcD/2va9u1RB62nTxwmpydRbN2CNHWWc=;
 b=aXAR42NvzjsOcLMHjr7rY6PjLReOcCdZG564BakAo+OH6CEoTwv5F6dY7aPv3P8+pn90eQOv619enXHn1uLCNqr2j2pCqXIXDufeDYkg+Jam4SWsbLCnvX4Gi9BbOfK9wT9n3CfNnyq3NzkVMQU3Zt8ZDEYIIYE8h+p2mqb34O9qmSnxUVcYAl/Ii+M+HqVzHeHehNhju5/emJ3T+R/7NbJDbPZNxxWfK0/Bay44gD0ltd+OEThRGT4KXgSi40ivr8bc5CQTZ7LeFVh3WehN8XQdszrB3GUGKPPKjoXkagOg7dP0C8MfEewK0GqMV5NF8gTGTrmxfXRXJjWtGB53lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sFQ8nOGTmGxcD/2va9u1RB62nTxwmpydRbN2CNHWWc=;
 b=BKhHQZ8nAjyqWx+nF99FpvsKW3Ym8B/QWIEiBpM14G4NfF6XLF8fIm4JdIMrHlHwRuvdDn20E/4FfKpK0O1b0YM9ynmKQR87aP8SNfxBQL0sud6o7anGKzc37f69aROJUiawx2HpIUf0A3exOtZoY783CDKzWGurB4xR25OTcXY=
Received: from BN0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:408:142::28)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 06:01:20 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::68) by BN0PR08CA0026.outlook.office365.com
 (2603:10b6:408:142::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 06:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:01:19 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:01:16 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Thu, 6 Feb 2025 11:29:58 +0530
Message-ID: <20250206060003.685-4-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fca9a83-2599-4c13-c6fd-08dd4673ad5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e25aobFzmLdMIjzh/6locTMjFlntDtn4dScIDHm+rLp9vo3shRBIyAyw6CsN?=
 =?us-ascii?Q?w9/jNjp37rIY7/VgdYinvk9FUS3/B+2K/uMNJcSYCAF/JXi4EIl6TS6YUJKt?=
 =?us-ascii?Q?t+RKjgjQEYW8J1mUeveq0jhhcdswyl0oXEtIy2qdsdKHujv2YulFGrT2G+77?=
 =?us-ascii?Q?ISnTuNgjdoCRGckOaQLMH74Ya9dPwKj6sZ3LaMg82azUvSmI4Gl678KoPnoe?=
 =?us-ascii?Q?6b8wzxKkefCqhuO/ne8FG/59+MkKWYCE3rgmzUTuWNq1Hp7YTFXIIDY19ysH?=
 =?us-ascii?Q?oxCzcj2Y0yjWM76bQPpTs5Y+tQC0VXu1eGnV5QhZOPMTgaQWxsaWAzPMLktu?=
 =?us-ascii?Q?GN8fzKmajEuTz+rpjDUolu50irSiapXF2etz8REfl2VlCaCVHL0gPbliL5kC?=
 =?us-ascii?Q?I577azh/AIvNJVBOwkvCDycTa7B47eYb2lotqLCpXFnR3kf5y6wISTYX9kee?=
 =?us-ascii?Q?HsIMtWFAoMo7mqfnGfl2kv4A6qQlGnSAf13SN7dpmrL/8Ke/JpnARhf76EUH?=
 =?us-ascii?Q?mr8+J2McLlZm6Oy1LnRu1zUWCGII1xSigy/zKC6/ZRWivyXwiMSoQHV2WGY4?=
 =?us-ascii?Q?bjydKiPNGesQEmFBQKzUhAEbMbxse+aa66AqBTdMcmmSDqhs+ZWz0lBqsiZi?=
 =?us-ascii?Q?K0GhoTrtVOwFf8dynWy6M/NoTxIhIrcYbqnlzC/G9OzNhPv+FjgiMdpKHy1f?=
 =?us-ascii?Q?fk5okRLJzRctfaTNYP7E0nNqNvWw2GLiFZ9sTDdmMH5d+/mAe9aZEij67knA?=
 =?us-ascii?Q?C5WyHWcu0qGdGId3P/oSIVtg6dpGHJIcl3xKw4/Zl2iWMndcrx2ml0QpRbJP?=
 =?us-ascii?Q?UpkPFH8LCRcfKwMrTkPjrvhXxAhGpygAC7Q5ny6JxJ22ZLjZN1VMAWFsyCcB?=
 =?us-ascii?Q?JUou1C2N1AT2XOZlXvK9k2emqqcjmp+ScRsplx3NRgMUMim6bnDy4H+h21Fi?=
 =?us-ascii?Q?bsnoOLGzyoNNCq0vehpZyaPQbQ+hbZmutEhYc46AdFhAERVuZPNzAOJycNcB?=
 =?us-ascii?Q?Xsh0NIA2sIhA6vtEk+69SnCKkH6GY7wUzugr46YAJbM/0Ii0C666g/PajqH4?=
 =?us-ascii?Q?FGbStPdIXn21y+RxccxtbhPRQDhZMaKpgQrxlhonamg7xCxmD9JsOtxLpiPD?=
 =?us-ascii?Q?My2TVcMpmBX47PQz/63dq82X9HqiOj0aZr7pmtlpBrv4o1sD4Lv70ATkzxyU?=
 =?us-ascii?Q?F40vitTo0KS3L98Wnx24I5Tpi4aJIF1PPeAIPz/4AxHwPHPQdg4Ftg9L3mVl?=
 =?us-ascii?Q?CPNZfJ1n/6TDY/vJBfYKapnXLJBBbjCrzXBuLNCLbfabJQAAgsENa9d5aODo?=
 =?us-ascii?Q?UR4vfoWq/fDf0M8cXf3YTyr3SxlqKpfyV8zuJiglXa325mAj2KCET0hSN/rQ?=
 =?us-ascii?Q?J7SXAl74+tQ5YVTs+S/MO99d8cR4inqAKtz6OkzMAxd3luy/dnvz0hhFWWh0?=
 =?us-ascii?Q?PATazAd9sufxKecoxHCQtLt4jIF8T5N/nRy3UePKfxh7DqCAwSSkL3cxnqM5?=
 =?us-ascii?Q?28ulqAK5UrqKFvg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:01:19.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fca9a83-2599-4c13-c6fd-08dd4673ad5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195

IOMMU Capability registers defines capabilities of IOMMU and information
needed for initialising MMIO registers and device table. This is useful
to dump these registers for debugging IOMMU related issues.

e.g.To get capability registers value for iommu<x>
  # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
  # cat /sys/kernel/debug/iommu/amd/iommu00/capability

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index b16b62ae7111..dc5fdc905754 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -18,6 +18,7 @@ static struct dentry *amd_iommu_debugfs;
 #define	OFS_IN_SZ	8
 
 static int mmio_offset = -1;
+static int cap_offset = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -58,6 +59,50 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
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
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", cap_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -71,5 +116,7 @@ void amd_iommu_debugfs_setup(void)
 
 		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
 				    &iommu_mmio_fops);
+		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
+				    &iommu_capability_fops);
 	}
 }
-- 
2.25.1

