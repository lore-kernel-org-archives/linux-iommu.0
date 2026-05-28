Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2493B635B
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963402; cv=fail; b=hErzGYhH5GtU2i4B7Nt27ZpntTHbOUJcJL5WKJ248G50nzupV8A2Xeipp/2F1lBnNnA09hfheBoknQFJFN5j+BxfwxbpHAMeOj/NyCqGB2N0R6NEAoE4lAHEe0u6nh0knvLEIZ5TPOdG8tAOVLWrhGBr0H+7Q2qKFl+gix+vusM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963402; c=relaxed/simple;
	bh=DMeu2dW4SQGivgXIkmfVgyA7Pqjwkor2YPf8la6QzEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j/aLlhJe/VhKygp4n5pdV9M2NWCeGYqgLQ8DqGSWkrfKrNbtttTzj1+mDwURJa3D3E4vU2ilN88Br1RTfyepuBlmjJkPV/49vrFw7wkaA69V87xfE1Azvzi9HYP1uiyWmqvv/e9LPQoMd4zOqt4W1xMPMhL/MfYPVJXoGWKi/7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMG7szN1; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMG7szN1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR8j9HycHgG0o8v+avzE7++6I/TEO6Q9nzLCMdvLZmLa22TPMHp2ISjJIYfTS7WBQHTE0xwLUXSOqR2KT1LGi8x/fHKBd8JZPbADlLeXZMZ+XCulGx7HkKsTIm9iauiOp384NJ0HQ0OiyrhIdwMgZGReLlsWwP4XMSs4bt9VMjx7GHypw/yJ/lC8ajMgHF8LfHPI9ns7IA2OobeWAj2jIWj5KXG+kLa6qCPUCUUXrgZFq5oMqtPzSv3PltmvdHBVwF+e0BEy2u38kR09boWAlCj6Y2529k8CfDu4zKRglr/X9QtlElyriEI6QqKbssu5SDlIZ0f2H70VCf/VPTWOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6wvbE/nA66altJoo2zmfFBj2wnQ0zAAnQBK1sa/6gs=;
 b=TO9K8usveuGDAJzFaRyyojqR8btYvheGYwEm+J3ohdC6uBPFwZWfTMLej4oh0si7o4BpPK8rkG5TJopkV9KWfvvRjtsjfry+s4Z+oJnH3fsq5RVZDXRA1dekzkUBZnfdzfqf+ONQL3KdVrWf9Qt+90hxcFjPcUZKQqcwjS2PfWl+M5cu3V9gY7NaolKKlnZoTRTF9biShQDMPvcKtlRXWk5JKknAZ/LEq3LelUWvB0KXtIce8LtBXcVlrETw14EwMukiFe9NZ43IfvwLu3h3nQQSw2w2B147xAU17Zi0A5Z1frzJNBeyzroKRS5sF7cH8ecxbbbBFR/H8l5hAzUymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6wvbE/nA66altJoo2zmfFBj2wnQ0zAAnQBK1sa/6gs=;
 b=RMG7szN1fBFSQ32BPouM8+h5oIWwbxfQLIHYAMYpqzT7GSex0EWHErdyfBeQVQgQOYrk7zIcZqQb7gVbtX9hBpipl+G0pygL+CvsWdRq4WCS/MhhyAL7U5X5B78rRUSz4hDQjoG2/PvJHFrAoZ3uQzqWlJ+WaJDd/TT/ZFRZEKAQzK7w1FZQekRU7Dn585vt37zykHxAK4uip5xtFILO7IRiF7EHC9Y+byu50OE6NZTe8JEo+OWYMqIyWd/TfWo4AxNjaLMfhOAi/aQ6yhSz6XwI7QQk94OQP+SBJn1uL9e0oV/GwzAm5iU2HEzhakQfP5pQ27VGhqJ8Vtsw5xKwLw==
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 10:16:36 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::58) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 10:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 10:16:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 03:16:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 03:16:23 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 28 May 2026 03:16:23 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 0/2] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Thu, 28 May 2026 10:16:15 +0000
Message-ID: <20260528101617.4068249-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: afbfecdd-42fc-40ac-18cd-08debca2331e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6zsAtW1vk/N2TLIwSc0x8uu+fZb19+z2xr23wB1AqLH6bk3/d4Sq90VnyCdDxmmH5lc5TnafqUPh6funw5IMVNeqlPBE4bdQxEojI7nPL+4kHhsT3mTCoIz3RAnzPbu0VhxaAd8Z2eDU5Rk0RygkCEKFFuNIX1vHTZ61pcJ/epz1AIoN9leLKMBxa+nPsz+fnPUdGh3qZCG8W/VSOdgdlJE+23g6e/7PpHs2c3RPLNIpAaVAwfLQEkKHAJ21u4LZgsP9dmAY3G/y3uYVy7yrKSlffYeB6+wNy8KDX+SUSzuyEHAX7WMdqAs1kiGx3k9ik1uQKmuC2L9VCEKush4veHIltLGVajpiwNi48OANyB/GrK3BM1BJvP9KAC2o25MJUn5ftePxfL3WBD5OvO6ZS+yjYh03NN27ftJG75zouvnuf7YwB4ghWnt1UMg+K1YEghN5ggcFkAIg8zG1/P0WoDtg/R48juiyAWeWZIABDT31jVuzTTcRV94GMpJeiSrsPN/wgL8awLyt9r08JeaNWMESLU4EsqSLgHNTGG+tfXwOr9AjoaSBxiwmYpS+KdwrT3QYLFJPk75e73T8tnEewaf0I0nQT+XF7VOMANZeOEjviZtlef4hX+yM2XIUCTx9+kNEbif69SHOwBM1e+WkTL1lBem578zgCT95pQMPkISo6Q512Nu2J0bw2ZFuVsZhf4/Sdjehz+p3QCw3mdZL8ISZsOzgMNPlfXz/rjhyBaQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o6UnSxBvzti8tExDXZ9FNfiCfdryEyfQrpC0ZOA0Hg25jO5xUwKnq61nihLRQ8uymIHqw9aWdQNtM4ZG3hTzPiR4qcUBu7+AY2YmtdqcZI6PZ+RD9YJSFdw5ERSiRuEgzemoWnWkeRHYDag6Afqoo9nCGErUSXqChcPfnkhRVrD+mi/ybJ9ijSKDYGURlClo1XJGI8/xhchqKbLfUccKvm1/WBy7D9V6gywY8E+FtUTb/A3r7ebuJzh1d1e9u6QY3rMkWM9hmTs9Yoe/GP0Gv1l1ebn06tXQWZt1G4FRSYMEf6WTBPVQDYMOeseXJrdo2to69qqptHf3v2DtoYErFKc2n+XpLV/oRiuYjIOZklw6/zNzGDcZ7Uzv/VtOmO7O1NKOLH97TBlWno7/opLqe9BGqS3bGKbuidDT5UW1T/Yf4o5IH/OOwk2Ec2YWLV3c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 10:16:36.1016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbfecdd-42fc-40ac-18cd-08debca2331e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice. The
second issue must execute only after the first issue's CMD_SYNC has
completed, giving the sequence:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

This series implements the workaround by hooking the duplication into
the single chokepoint that every synchronous submission flows through
arm_smmu_cmdq_issue_cmdlist().

Patch 1 detects affected instances using the existing
"nvidia,tegra264-smmu" compatible string and exposes the condition
via a new ARM_SMMU_OPT_TLBI_TWICE option bit.

Patch 2 wires the option into the CMDQ submission path which is used to
re-issue the cmdlist when @sync is true and the first command is a
CFGI/TLBI.

Ashish Mhetre (2):
  iommu/arm-smmu-v3: Detect Tegra264 erratum
  iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 70 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 +++
 2 files changed, 72 insertions(+), 6 deletions(-)


base-commit: f86b1ac9a67321419fec095ecb27584b2f77e339
-- 
2.50.1

