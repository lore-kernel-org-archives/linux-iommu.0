Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E393769EA
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130806; cv=fail; b=RLxg0bAqDtPMxjHPGPZjeWV0faY94MesTC+hDVaP0zWYLFklwhVJh1/IozuilbZ0fXbbUiTKQfupCJJo43vjOqIcqqSr9VmlaV/rjrTS+E3pGKp9oPqCei3jjLHpWkxphPinTw2v2haHvEUu6fvBgQsni33eKDWvUxkHsrCHsbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130806; c=relaxed/simple;
	bh=yC7d/hhGl0TYg3c5RpKxzNw9y2uoD1Cv8Eeu/9yYgY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyNLW/Oo6zC2vrNVWcug5LFLJxDh4Co3dcyoMP/iQ0iYK9PcTmRly5/Y9C8GPn+u0A7l6LazY5hMpWMo8KejzBC/xl6iAsgeUkwTbi4DJ6UY3ccqPULlohHeFdxkBF74dUWDzCbfsbwFAjtjGtoCLVJleWI439xFkO++88MS3Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QqIcmQf0; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QqIcmQf0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV+cetcK/Dk9Ln4L2N/5+8CcIY78Kx8FxKFihsaiZvDUjDkPp6zjS4dFokO1g3FDWk+PwCP68GZuv/jG1hLGc3WR5gGpVDA32VpRgkUYagNs4Vu3F1ssRpdV3H6C3bc/Ulw7VbLlNA/z62WkHM99S6ttDn+BFsAost627ZHa9RQnosbxrtwQptk2tK0/TAYDAdzbtSvxechpMdO38d3aW3N4zN19kT9PO0oOVpLrJakeBPtzBFZLjNsAfNrYDrlPm8tyx5SiR/l1LgJM/DkQdej4pvGn12qOoB6rlcWUNoO3WbIXYPnPvOGEwbjJIuEWeJmf3oCkJpfQ1bUuTta27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbY6iLeF1uoL1qHLGRSxvwYSG0ngXbYQP/cQSZ5BWqg=;
 b=MGnc7dPwwvInP7l55UOEMJjpbPTpanRjsxng2OHJkFVAPeQ0VaDzMQQh5CEyRPJbwtrQbqiiY+d1Ti6B3UsR0Z9P/Cr0GOTa0G0VPHTCjfgH1oGjyQBRLpa0dxqiJz9X1uDGLBdhXu2jyp0LNSUCp321HI63Qdtg6c/5XDImtuTsG6Qvm/uajPx/+tt4VEHZtlJqpnuFsWRzZsKaQeNho8c1jNOkCh82pQsb64fNGlGILyRUOz7g2YnzzmqcdufytnPKjCopxJ66IB5k3jIgQFJWxx/WXWndCGjsO4Ev0RkdogXBiZQBgMjhUodxUxl8pngHPV6/mOkMcNFbKwDghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbY6iLeF1uoL1qHLGRSxvwYSG0ngXbYQP/cQSZ5BWqg=;
 b=QqIcmQf0hR6IQAD+L2FxdUtgpyG3IOUPHDwlwqCbYFHkMHmhL9gSa2NlKSMCAQliMW84F3Eyna+5yMX+nWnZJRDVm7U17KEdwn9lZT54HTJekMt6fo3Y9JpGOU7E67FAN9vhgbIjOUB18nWRzFUjWJoNRikdJYx9vUYuwKNXqEw=
Received: from CH0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:610:119::11)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:40:00 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::1) by CH0PR03CA0370.outlook.office365.com
 (2603:10b6:610:119::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend
 Transport; Mon, 27 Jul 2026 05:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 05:39:59 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 00:39:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/5] iommu/amd: Fix incorrect device ID in invalid PASID error message
Date: Mon, 27 Jul 2026 05:39:03 +0000
Message-ID: <20260727053907.7622-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfb29af-3237-492f-4f63-08deeba17fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X69BWAg/IgqdG/2tSmqB9xQxJ4q6N/gnASnKsH0LAymAv27KZnVnQcLG5rbgJphS/aE5P8OGIXtseNquOW6hS4oh9KRs/rtek15FrcN0RAGWHpufih2lEe2DZ3bsTrCkTd0G9KYBFMTs7LCQuCyH1noGdnRGWMhN+DKdINuyenfVgg7BaXOJlQ1PbTfGchA6Q7wG7Q6/f7SErHc6HikEtyfi/fw3OE9brXp+msBuCNH+8z/53zkhhUqu5Q9s/ISPhxFazcwIxELtWrXPGm6hLAvVc6xJz3f86Gt7tSXQP+x3ncq6g/7C3IcUcKf/web3AXOlngjdUNZ09HwrekExFtXeFnoFXwQWdIO6/enEULSijWSnyEnZtfNBln0Z6NWxHrUiq36Thdg1pcrfnbYrQ2ybo9TZpSfoT7T2eQdSUf6jWeMu1DHGRHlWCqTpXBNFNodDawSYLL6+0WAbLboLT0DEFMhhfd1UX1KLUGew4Iaoz71/OSG/jKStymjt7VHPkgZ+QUQC48YMIxvtQViubo/ZoZyfr0kazXDC1266DozcxRG4l34N2zlhmNIThn59CrMLhZRdBADMveglMCHKmDcU4XOQhDzJUfI5buFw9qrjG5NOUP220T9uYpnXjFUYFHaHhzNUPdeDix4B8XTz2lpTULqF+2iB1t2+O+jRkFDKyumkE1YJWHC9+/+QUdtUOzJDXVAmwBWeFuxXfxuGDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hF6Ox9c98ud1hJSPjqUdY7xd/XT+TbmE1L0+aT2Zj2i1Lq7Gvb91SQwr4AGdSgdsdwjtwLyZdd2ULjt2QBV/9D1XjA8Ycd7zrMwDAwOjsl880j/KZgL6TPlC/i2lBskc4TKfgWw+jUDHCQnIMdQSPZ0P+ARlHPgwBnNVlCshBYsZkZysGQReZ0LWbPnO+oXNZbm+vq2FEC5Z07runIFCcm8muyHzwCoWZZcay6e4q/ultriRtDCfQdUUsECnn/DHh6vOJS2xFUt3J3NBgogl3ZX+j5PWjQM39VZO7BXX6/Ss0PH5RhwnBr8O5lfPV8w+Thz9UjoKZRDWY/df8BjqBKzm/0A8yNjSGHUZdQPfN6XeYXP1wpIubhHGtJ6kN7nd530KNsDeR4eYtFW7gmGQrr+ZtGKHFSoswY/hZcYqQgKu4lgdqBfTU1uPHqwovaLv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:39:59.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfb29af-3237-492f-4f63-08deeba17fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356

The IO page fault notifier handler logs pdev->dev.id when reporting an
invalid PASID, but pdev->dev.id is the kernel-internal device ID and
not the IOMMU device ID (BDF). Use dev_data->devid instead, which
reflects actual devid.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1f8d2823bea4..ad75d1f03451 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -140,7 +140,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	if (event.fault.prm.pasid == 0 ||
 	    event.fault.prm.pasid >= dev_data->max_pasids) {
 		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
-				    event.fault.prm.pasid, pdev->dev.id);
+				    event.fault.prm.pasid, dev_data->devid);
 		goto out;
 	}
 
-- 
2.31.1

