Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF823D1CD0
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065173; cv=fail; b=LRX2rcRknjSzhEyJaT6mpYLCXlz+UsvgVXqRlegxrdSJC6DbE7xA3gCI2YhAyJ44s7USau5L2xDXfAFhGDZ+uswc36uCBir/u++yNnP/1BT/mBaRGPtEHnsxhAzMYanTbt76FylSP+kmoMpHBBUz4MlQFk2Qiwo+FtHfC7QC+AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065173; c=relaxed/simple;
	bh=PGYYKfpskUyOsyaclQW9zVK19F6JeTV1Kea9A5bv+io=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYJ1oqV+8HwSKObq2fWr1dk8bS9EqEGpSR6N32bLk9cwSx0OW94XVYsJFQxvXhLybTDfLLacKsXKa9PrnLlNklPCCHPpzVMaovAyNJmDSCLAiuOKJ4uL5dlQ0xPl4NpGcmq/DVuRnKonM/tFwi5setvowKn2knxn6LdZDQVaIBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nxDLDN6z; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nxDLDN6z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Go2olZ72mkdfKyr321UUxdVxbHdgK1Ah1jsmsfI8BtddMWWXAp28SO4DSmwLsiLCfhdbhDPSAkUcldUaR7IZAYJXkmEku7cURNY/obI8LvUyZ5obN34GA5YRYrWBNjeA1xdSnlaIMecL139ELXye7kkmSMtYG2AQ2ltI+oidTEiD6pHWfWIprlXzf3CD+C9Nzz0/EpU6D73vw7PhJmkmV0T5rE2PLQJTRgWDbsXnfik3Aka3+2yVaTMlE0pKXOW/ps4LNS73mOC0GiyLMB3f+BNV92dWj8rK1c+TWx8a2BkR/qmwlqYswJnilOd/7/+/YZYG61Iq+pd0oQJnycHFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLC9wlfTMkVS8OHMMXNnJ9dDRcwf9M0aIUMwARX7wvc=;
 b=TEqn8rQNYyx9Oz952RYuLE7kefT3f4/K44yaQfomRKWa9w6f6kCMv9DouonTCZ3L05etJT4TAJKAvC5H8BSgmQlTCcWu/koQUQs8Srf4qEs6DMAsZfi6eQdocxmfzCIWb/Ao+DfimlUCqCvt1G4OQLEB/bIkHTpYNwE5qXC+qZpPLP6cgsNOJK0PVIPZJBzEDn8pkT/T+Gs2wTBFpU1jPYStaBLvNa5w/iqBB+wXAeiMLzWQpUDIMsm2LJ/nOdHhekamz0bvagFmUVsxMb3zsep8NjJ1xlvjGCuGOTsS/0qHc4WUurmfS5cBGCJi8TiZnrFqKMCNXwHsgqsKV1A3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLC9wlfTMkVS8OHMMXNnJ9dDRcwf9M0aIUMwARX7wvc=;
 b=nxDLDN6zYOeIP5OyHGlPEACuSyi2eIi08h0P/Oa2O2XY9QQBSteVWDUk/+7XvXB8ra9hbVpkSgIlzhnLRcmaIIRw+xsE3EsfZh/0xov13x9yrABrcYQgoYMxMiP2GfcPmrIwvQ8yHvmhMwuwz4eb+urDg1HrFMg+4fhdWLfkJJo=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Mon, 9 Mar
 2026 14:06:06 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4f) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:06:05 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:05:56 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES
Date: Mon, 9 Mar 2026 14:05:27 +0000
Message-ID: <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773058553.git.Ankit.Soni@amd.com>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1089d1-bc4b-4cdc-d6a9-08de7de50197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	UbnxEXTTYLMZHcthF56oSsBkqIWu1XnzEvryeeLm+Ha9mW6bHSx9coCHbnrFEDGYUyG7hEIiZuHeXP0eeF2O7y4GHvemC7HqTvkOd1uKM1cmruzVRSp3GUh3GBhBpMZKtzED8AOO0yA2OTh0y6q3zTpFucXHpNfRX/+8U0WPmvQqsR+B7wsirN7I4MBb7rhc0/Sqw5LmXDvdApWLnd5cCXNzFtepjCxotQpyNlrxDWzC2N19cv5dIfu6G8x2jEY54OUwN/dX00PXjFWIJ1VQ1tNY0UVItEeEjifh9/1F4JQI/4KMXiK886rAUXEV9Bd8aDsxHde+NZXgRA5WYcvJrWCdxoz9zuskGiY+Q7IIN9rOQXBoNcPi5uxJRnMusDirqVbIDgEnYWfTuiysiKi6GTHiJnlPiWOUMMjm6hijeEimpIKkEaoNh0Se2z5kKUPK45ZLD2eHoKHZ2Cr7LosTUVN88OcsJ/cDImidOgbYcZHeyI4vxDJ3Hy74eERmpWZwUeYa0vU1lRSA6Xo2jv1fZmLvdatnRULskdSuScQwXjFH4NZr6G1C0h3vK0oG4dEFMQVuWHZDQmuEMBg/l7kYoCK6dm7vnGWSzHJBsW9nChdz2b+ZlM5Kten7vFTYjFsAU+iltT/nEF+FU+CaCOrAvZSjR7FXKfYvyrDARxD+iieddaUCU5QelpovKeNE6W7IqBv4qnOlFcNrqHs0gvlfNZgWDn6TmEu2aOUkGL1+SPxP1ZmkkA5U5/82CGXui69Rrd2cBWrZqa9lBPZZMHyacA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GbQMk0Zx78359dvRSDiTuZfcFYLwMPFNY1jMhieTOu1YF9WhmPZa25uiASTbTSUH88b3+OBGdSBwwbfhZhkDaPT7z9XehUYjdRimoGdI4N5thWXnzdnnIc5/faAQgKLJHe1HHWzF1/16xG1CwJICdYnPrG7N87sbzTYyVsE0jFqP/gi3dZS+frLQcEIA726C/cfsYCJcIrKMUvqaWuax3JeKrp0YkrAkdvHbLL8sC7dWfz7uYnIc01vYrgNYHZGsLL4Ub8lVB+f7xUhiXIwDDMJL1AqhIm7M/7DUHow6rtp96hV1iQ7GD7aa1cAXYD8wpy912dd6Ia6K9QX3z2ryUYRxeAIUJtpTpKmnWJmiqwTw9uvoTKC5GMIrHEIP2/M3wD5YS68rEEmYThTocf6A6eZhZOkKBg7baiHKtDY00K3GmyoYSZQRSCxE5SftB1PK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:06:05.9567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1089d1-bc4b-4cdc-d6a9-08de7de50197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

Dynamic top is used to grow the page table levels. However, if the VA
size is small and the initial page table level already covers the entire
address space, table growth is not required. In that case, the generic
page table framework clears PT_FEAT_DYNAMIC_TOP, which in turn causes
error -EOPNOTSUPP and leads to domain initialization failure.

Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES, since during
domain allocation AMD IOMMU driver explicitly sets PT_FEAT_DYNAMIC_TOP
via cfg.common.features, this keeps normal runtime behavior unchanged.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
index 72a2337d0c55..61e025a85e6a 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
+++ b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
@@ -9,7 +9,7 @@
 	 BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |                           \
 	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
 #define PT_FORCE_ENABLED_FEATURES                                       \
-	(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) | \
+	(BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |				\
 	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
 
 #include "iommu_template.h"
-- 
2.43.0

