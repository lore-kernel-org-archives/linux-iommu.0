Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157F18BC3B
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384092; cv=fail; b=OMRagg9bAHxCUIbVlWsoR5tUPLzl2TK/H9l1ZXaAyGkAotzQ6kh6zbnRRK8h1PU13W0cc0WGcvKYebKitnKFUZYV2ugQnLxCGZvSfxGmxfXW3R/K0AYIKpZUoOwv21zkuUIT7ke3q4Tmm1uIvI0l9h97AyIlUOjS3uxOnEFNkSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384092; c=relaxed/simple;
	bh=Dujmik5HoJck9T6Ijoq/9j8AC4w6SF5UIFa83n5hGb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJaPEnzLg09VUKB6mgbdDKi3EFaS7kqRSSdBHulAvcvPq5aQsshMyzF+OHzkTuZbIHYgJB+unYrVFtNJytlJI+i/330/mbCatk3cxIRTMSCRa0bnFyeHWWxIJKtmvMBbyKsfbPlO5iufJv5+uK6nJXyzbfvZhkPqv53+3ft0QyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UK1/yhXj; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UK1/yhXj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax7XGc3EgkWgDgXVM+kEgVo2p1y4eyZa2ggMeJxUX7cozuEzSeiwrrfMXoj6/U0rXpnk7oe6ytKwy8iTSTA1gM49c36OFPAvuK7s29Zgq1yh1rXx9uFYeMMCZL3J6k4NO6qv4z3TC8Xy+PTOpt4fejJmNc6LOnSz4+1ARrTSVx89ZtQOhZ+ISnRKRrn7tGWoPOh0PJnYyL6T+cejgUiJDMgvlm9eX7pWmRlmD5z/hHHcrGS5SYaX1Gg3Levjmjdv6HZNrqqmOSTs8mM6yH+/oZY4Gzk5LsnOO2Q0GrSGf1ud37HVCYY8OAQUEalsPvCFsneUIqmCBU3Kf96ISE57KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/9+eweXyB+FzXJOqLiNT84+fk9xEUaQX4tRiH6VNJ8=;
 b=WzpmKQc7jWo1zcWCyEpVOGqhZHjEY24QeIa77xN1htDCNsij17CVHGHA7YyMdvvP1qGwEFRbvTTXBuCPtb+vjUnPnAxJpENxwjwJrRtPSZ3yyE4yMZ6kZ06CIZ2xl2yKbzp0/4YV22V5Er0Ny9tiwpbctOKQ0CXwjpv+D9I/YIY7ILtzFPoKEca/eu66+Vjn6cMLe2sQWhxAv0VTGP4SYtf6s1yTikEwJh3CuDwLxG8yppVBKMTctpxV82OroD16Ep27Ezj4MwctGjbL7h70DadLyMEtPltta1YYn1OSrB0Bc27IyROjhsB487GwgGGLdndVPIr6r45TjPDttwQFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/9+eweXyB+FzXJOqLiNT84+fk9xEUaQX4tRiH6VNJ8=;
 b=UK1/yhXjhIyhrOOCSEXsLtIJfBcVHfzwFIJ2kM3vVYB9WAcT3ktZFf+LCHtJZuV44AFeJ9Ux9dUN5QifU6MfvgIqu5ghQ7YKUTiie1YrB/3GL9Fh+3ks1kMlj/DXqcjjspcL8CNTG7GlYTh8Z1wV4X2KujJ+9TapZJp2PFBvmB0=
Received: from CYZPR14CA0043.namprd14.prod.outlook.com (2603:10b6:930:a0::6)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 10:41:27 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::51) by CYZPR14CA0043.outlook.office365.com
 (2603:10b6:930:a0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Tue, 8 Oct 2024 10:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:41:26 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:41:23 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Tue, 8 Oct 2024 16:10:29 +0530
Message-ID: <20241008104035.4008-3-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe4b891-da06-4645-b0f8-08dce785c31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+IzHKIPaI2o2RdhSjCbH7Vjrx1j8z/I4LrHpMl/S8IKNEwxXZcF4rJj9oUH?=
 =?us-ascii?Q?bhpDQRErYgAVIY6m5jnnyCJLgKNh6FzEmYtanBRBySywwZPNBMIYEchYfRY2?=
 =?us-ascii?Q?x6k8QG0kLAgJ5OZzNiImb/487wuRKhxL6AcJ5iVr5htA7P/niL870m/DjqbM?=
 =?us-ascii?Q?EcZvDB/NvaBpC0+ZLDSHrddNAn6SY/aAzfvMW5Qd5gExt3Mq1kEKFGA+PrCX?=
 =?us-ascii?Q?NtBkCS6K8zBsXV9+u2xRR4s9Js0KUfZifey/RBzn785hFUKj6CuSwmrqj7gD?=
 =?us-ascii?Q?ZMWikB3gSKUKiChNnZsFKl3WMmHwQpCRBRJ8fzJ26lHzHzsIm92A8yLtvxct?=
 =?us-ascii?Q?ZYmrgJOnBKGmKXd5AxORDlEBTtd2E4NeQN+hfwbu3LXYBGljS8mfEVDYcqNc?=
 =?us-ascii?Q?CPQuIMFNWr7PvZlVzNoB9Pwm4QFVgJ0yBiiiKPjY1xEdiQiSopEysU6qa3R7?=
 =?us-ascii?Q?2nuFcLkK/FivC+da+4Cr0v3wU6jumVi1D2viAwtuElKyfvDlvVwc77n4ltIr?=
 =?us-ascii?Q?SxwNQ7hAdFBzSQxtM4hlR5bRUyY8eabZxWYb9lTHOkBD2Y8TuUZpkd8ESZn+?=
 =?us-ascii?Q?veHT8xfSbQJKa23rUnWSCdnh89ADhTZ0B2kNyNTGB7ni7KDLN2b9Q7XkOmgU?=
 =?us-ascii?Q?R5CNZH7xg0zx2oIvmEqivlUweqjPcO/xbpnFCQYRilEdAaMnzMBdgYEUgTp6?=
 =?us-ascii?Q?gnqO5+Tc0D9dUk4kbtCp2XukXD2ry8gqStB6puq3s0nlSJyx3roX3w1ONuIV?=
 =?us-ascii?Q?/8zJHs8i1fOJf0fftaejLenKKev++uZP+p/OgAqzcEZ4r/TZSgOR7MB2AuQo?=
 =?us-ascii?Q?fJLxfAI++OqY4pPhW87jYTCWbXZCPeVy+OAG2Y2zuIxhaTBHRh8NjUCvFjwP?=
 =?us-ascii?Q?psHXqzkVan2Ik/wYfyrzCw4p96Be+es8f5OcSdF+kIzip61t70CWrT/E3JVy?=
 =?us-ascii?Q?ytHR9Q2eUl+1mbxKV/StmOVCs+afLjkD0FgNzNgjpgz902vMpyeg+9aXzugr?=
 =?us-ascii?Q?MksBoepq8jcKYSiY+1yiGfIJC+jpLlvSR2RyubnYYOJNQX12bLkaDwfIVyj4?=
 =?us-ascii?Q?cEbFb8Ri9iHxqrTy+/7xsKxmoyerBCttPxoIqQsUMGxBYop+C1FxwpInufie?=
 =?us-ascii?Q?lWiZJEKY9CMJUL18OYiQg7eCAxEsXzhgZOQDe7xJaxO8fC0p5P/xZhTqUilD?=
 =?us-ascii?Q?s2x5NgTZmIEeHeCUmRKurw5hYy1WjHUrFQd4wj4/7DauJ1pC6VyxMAPm5+KP?=
 =?us-ascii?Q?Oi7ySKNIUkn34dMu5sNCLkbZVCNQp3pZ7hyI37NJB22+pWch7A7sP6tjikDC?=
 =?us-ascii?Q?QzI0C/g7abLljSEGZBfWBdE+PkqYadVo7Z8Ho+opqPQehjpWoGPV+iDpUn27?=
 =?us-ascii?Q?hZp2/QFhA6sB8xqXeWaYC6L5Bzdw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:41:26.8127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe4b891-da06-4645-b0f8-08dce785c31e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
1. To get mmio registers value for iommu<x>
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio_dump

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..30d6819e9a35 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,76 @@
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
+	char *mmio_ptr_ofs;
+	int ret = cnt;
+
+	if (cnt > OFS_IN_SZ) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mmio_ptr_ofs = memdup_user_nul(ubuf, cnt);
+	if (IS_ERR(mmio_ptr_ofs)) {
+		ret = PTR_ERR(mmio_ptr_ofs);
+		goto err;
+	}
+
+	if (kstrtou32(mmio_ptr_ofs, 0, &mmio_offset) < 0) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (mmio_offset > iommu->mmio_phys_end - 4) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	kfree(mmio_ptr_ofs);
+	*ppos += cnt;
+	return ret;
+
+free:
+	kfree(mmio_ptr_ofs);
+err:
+	mmio_offset = -1;
+	return ret;
+}
+
+static int iommu_mmio_show(struct seq_file *m, void *unused)
+{
+	if (mmio_offset >= 0)
+		seq_printf(m, "0x%x\n", mmio_offset);
+	else
+		seq_puts(m, "No or invalid input provided\n");
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
@@ -26,5 +96,10 @@ void amd_iommu_debugfs_setup(void)
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

