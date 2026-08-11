Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32983033F8
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421434; cv=fail; b=tcHOif9A/yg3JGNIQ3NQVCkQvKAvGfez65OSribA+hDQoLcB1/gNNZAIsUeUI249IKeZltziSGr8rc2tydZFlGORy4t1Kp0hGDe4HzbbDT0dWV1CTj9RWIE+nvgv4HFbAFCtZZJwLXTKtEbRYVkNk/l+tOCChI3IHkUyOJT8LMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421434; c=relaxed/simple;
	bh=t5Y/0S5fX5dyBlEiVl0RVr+LKYsJHKMd9oSdAv9u73w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q25ggW2mNdaxhiKgmLcOYQA0TIZuvDEWYYO59w0wGYf6kl4qFv3/fJ2YiGLULSLdEMQ688o/uQa0ZtLMoIq7sMbJXliKhNYhtBcxDioC+fMKJoHw4RipisAYRqCtC0oQIPl16NQdol2PLcEkuQxlyTGCvZqBg4p8xbFEOBBt+LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EXwcWaHC; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EXwcWaHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdHkPdegd1tL14khwLxaU2FiCpwS2afk0cth4kbFm9IkH4zYqvTByj2PVnLhIcxtmpHG3sKoO31/DwnZVYd3XL+RckiyC1KLVbzyt4GViO3JVMf1iOdYbKRrjm7jbAqfxVUK3V5aXc7ZQ/5sFniJm7xB32yv6JS7r0mAqub6HQu1y6wWtYwaxqCZ3uogfAcX6Otaha7huVwU6lO4Ic31LPeq0cynNa32AYlBYcm3x09PmK8KWBw0k9kNa9oF1sK/WZe/lTAfwQsRVKg+9mc+KqOEYDyG9WnWdzEn6Gw14lBFETigqP63aNVrexShZwAzOyyslgjkJaywKEiruXZL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2pxbYsM2d7iIhksmShUskthq4xRRJ2IS6FydR4b7hc=;
 b=qR3C9KUgWSRuDeYzu2tj7xmKHWnNS4JTVBjk3QpLEftLcWtUiZkbE/GfFkbCnhu4PkhbYtkBeC+Ktn3h2t1RULew+p0NSuvsjyLITk6jCOQl/s5JYmezFwRVe1pL7aCobb3mdj4zEOuD3JW63FoXZH9N/pwpLDxPUyGAGiQkVXA/nfcWFcCqheAmkzzfPWnKLhcRJrViH90MEDDVOLCQEkC2L0PzrIi9gNZLveioKTtWy02fAYVuFoNErowzd7hW0y69sC/sQm2M4CspzkLKD9cLobHhuBPak/q32WaqL9gMLic09ULeMl8TEFmb2IDKE4huOQN5JmrByjFJdmPTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2pxbYsM2d7iIhksmShUskthq4xRRJ2IS6FydR4b7hc=;
 b=EXwcWaHCp9FsjP6eQZxzeglRBoyPC+6ZgTKybXL+vfk1ND3iQ/cprj2OATXFYHbhyeEzvs6P8yXk7TMg8oISjSAy2fpeCMbz+AJVS116hG5RPxghhqoqfwlE6lqIDJ78qWw5HBp3Xf6BZFluk/Ml2+sz1tZay5KsUP7BPRCzLaE=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Tue, 11 Aug
 2026 04:10:27 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::30) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 04:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 04:10:27 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 23:10:24 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Ankit
 Soni" <Ankit.Soni@amd.com>
Subject: [PATCH v2 4/5] iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
Date: Tue, 11 Aug 2026 04:08:59 +0000
Message-ID: <20260811040900.8572-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811040900.8572-1-vasant.hegde@amd.com>
References: <20260811040900.8572-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1a7ca6-a077-443b-05be-08def75e79a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A5/CkmPJcjTG+pCJ6o6O8rsa0Q52XcmiuZAhitDq8cqEVEpe3hA+F6oZAsRUgskAWrKXzTcMtQ+GNdcUrCgsC5EK2SlyrVH3Z+HX27ZUkngVx4NBUz64e7eZAmMu3iEs508WH5tVVw+jMYSOePC9GzYARcWBKI5ioHRFUsDafKaiVPMx5Tv1KDcfvcE5gzQMMiICsCPSscYW0fVBVn81cB/2lBpz78aG01EnnfELeCukYpNOl64vjaLSyWZtO+9DKJWVr2dNQPtT/Oi6xgDmdAGNXBUg66sl7lFIBl5MiTqZBoAlQlQsGRHunM6m2c9QeYL7k/ioHOTp4WPQKTx4ySI3WuP0N07iudkvhq9q9//wS3N+qSJ13w5BjObN+1NM6MRPQwBgKXKPUkdHdJO3d6NozgDXhaPmf+NLe9ZTtka5xmEVpeL3ipJ3VxMwWANgmAnRZqY1bCkYzBMvWT+Yt/b54U+hIaJdBJxFHQv8ToeWYurSC8i8Wv5o2tM9+U8no44PpmLfsQYdFs9iYQqNKoCebkPajfCzvpxgXC8NMMnoKmWv7Sm8jhIIvr1lKbzXWUD/2tXJI4Bnng+BZH8h6NTPRhjCSWaYr5vU9JnTqjRtSwL+cKNt/YkZInN65cYOqyMDx4Yd2ggJmcRGasTpZIAFuldRIr9WJAWwo2RjwQ5PhfYa6b0G60MCLlYfFxwF1A8u8vjmRg2TNaCNpctGrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1RZyw6uGvGCVgIREUVoY8yodMG2v7VIa4RRGNslxjrueLJBce4YZkqjuiUhM2bBzzENyzrMUCNqXxo2m2pLDgDh1vUNgtOn48TIbKHjtajMej7NfvCRmbxSV8BHnZs/dQdIzeyOM+Zq6BaN4+qn7b7WbUHhHpWt6Po2CTk/JrneWjiK2Pz8v4/W9FGVjhj31VezaeQMftYUeIXS83vB0rFY+Louj14z++FH3umIP7nxnFmNnRF5YHeTd7qeHbY4qJVFFilaC78ju97GjMchEuMt1ZIDA/N4/LxoJLypkTu2ngFf4xxMNO+jfrfbN4/iuUgkFfehxev+4bApvL21JWGQWAPZcdqrVJzykF6kZF+ZhEDh9s0U10BEx8oqccgzzH2CiHO2lsdDDKqH41MRCMLF8y2YM7D1pw6bx7mra2xtZavMBYNuiYBynhPVx5qMG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:10:27.1986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1a7ca6-a077-443b-05be-08def75e79a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361

The amd_iommu_report_ppr_err() function logs an error message for every
INVALID_PPR_REQUEST event. Under certain fault conditions, a misbehaving
or malicious device can flood the IOMMU event log with PPR faults, causing
the kernel log to be overwhelmed with repeated error messages.

Switch from dev_err() to dev_err_ratelimited() to suppress duplicate
messages when INVALID_PPR_REQUEST events occur at a high rate.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4372d3908e67..17df9b28ebaf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -913,9 +913,10 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 	u32 pasid = PPR_PASID(*((u64 *)event));
 	int tag = event[1] & 0x03FF;
 
-	dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
-		iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		pasid, address, flags, tag);
+	dev_err_ratelimited(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x "
+			    "pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
+			    iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
+			    PCI_FUNC(devid), pasid, address, flags, tag);
 
 	/* Skip COMPLETE_PPR_REQUEST response if RX=1 */
 	if (flags & EVENT_FLAG_PPR_RX)
-- 
2.31.1

