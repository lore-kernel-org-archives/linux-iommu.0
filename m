Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143C2CA8
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873464; cv=fail; b=bT3PotWnMWepiCFSAPpKNJ10YEYZlf3x1jHe8oFmA/Bc/xexysnR8vd5TNzh2PtT2P4WlFHzpHK8xtCkwrQLhld3xqxIfZmZ64HzXO7IOI7YJb/g4lwu+/rBag74G7EZj1QRoW0c1QiM9oBA0BqDpz3UdS4j2s6LxgKLxFVsvcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873464; c=relaxed/simple;
	bh=Kpk1NMBZtia8gsvOJ42Zo0lmu6j58OZ4o+o84h+7aZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uyb7yYrvuNlbMpRiE1Ov2u4wP9seoflOydzg5bVaHYjEmsBefi/cAiuiIHgjpZIdpO5Dpf9IYJVcO5yJSgpk0lnbmcR1MmY5woU2Ddi0Z3odkk0rctvv2L4LEp8myWwrMGBJijquO94S5hmduaKDm+Z7IIGbp8CwF4vAdKsP+7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ihwvHKux; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ihwvHKux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDuh4IWmA9Sshvzs5/0CedHhlSJ5m/ME70iMXHJzDc+OJhjcqXmsPAQzz7aluTW3IMc4G+exy7n/9hwWbGSZt3CQ+l6tVAbMWp/moTBFU5SPrOE6NCSF5ALwLPs20jeRR1ztWm06/zGME0+4UWG0BBJR6na/t+181S4fVsbWS0bzbZFiyGQ72l+auEqP9TWzOEK8eg+dtvMxnya81HwqHk4+7coLYs0vUfAK17Rfas5T1VhCfEWs84TYNAcCQihd1sWspv2Zivh0NPu4ahLBgSsELVWZv/pCljtrGRuyuV+BUlEEfjkADrTuSa5oDjwplvgwIvmVgc+Zh+8Rxnz3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do+T9sT5L19gqSgT+cSz1/KPjWv7o95NkA+MoHjSdFY=;
 b=hVA5J37olCVCqRi7epOXYPdXxfc5clBkCuSmRf7tA3+KRiMMlw1leRGn2+ovgHTxMtBKwYBnXTfP5qCcOv1KVhi6g/1gkzX2Jf8d4JPQfKggxXsmmyHzgmbWk1nQeS/HD6GsGOOWyXYIXSxN2mFXqZma07ydeyaG/UqLOGBqYVvMAVmZqZ5mGWx8IF+Ilxhn4UTJzIkZoncb0QlzTGNJoFiMgHZ8hyUJvBMA2SiBefNGSgw+nQORbrVbtF/OJYNppyCx9d6MLYt6EIkDmV7X65U3R9JdsXiQMYlkjYB/c4P4xxZ5vVIAOtsLTDylgjLkETJdqhbkOkkA4CBvJRVg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do+T9sT5L19gqSgT+cSz1/KPjWv7o95NkA+MoHjSdFY=;
 b=ihwvHKux/dKKiG6GIi5H7IOrWGi2ebZHj9ZAGydWKYnzcIZ4Xqp41rpWAT4lvhLRBb8VpHWu314ayt+2v+vAqCybZvZwUxR+UVyWNNrojz5IvWQ2uZ/8Th3RpVPii96UN9vBL8tSisZmCn22YOt4r6GlohaCBJcpPGopCvRowGZbEi3Zn+1xLq0qiqV7+ZCe27ZbRaQl4SqNyhqKKXafzz7LYEB164GuCB17BgTNnqBGWHiCTSkeSapjifUQ4HCF77xVDAFu7CJZC8t2b/BzatJTQx6099j9ZGWYdqtg5Et+7ANxBMW5aKbkIsHHlex8WUpDP4FCYe/yCnYLw8EWcA==
Received: from BN9PR03CA0201.namprd03.prod.outlook.com (2603:10b6:408:f9::26)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 00:50:55 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::87) by BN9PR03CA0201.outlook.office365.com
 (2603:10b6:408:f9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 00:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 00:50:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:50:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:50:39 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 17:50:38 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>, "Mike
 Rapoport" <rppt@kernel.org>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>, "Dev
 Jain" <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [RESEND PATCH 0/2] Add encrypt/decrypt support for vmalloc regions
Date: Sun, 10 Aug 2025 19:50:33 -0500
Message-ID: <20250811005036.714274-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: bcae2c00-3375-4678-4467-08ddd87120d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlVNeEQ3d0o4Q1Z5cG1KOXVyR3N2NmNJQzlKRWU3RW54ZUFOakZXUDBuNk4v?=
 =?utf-8?B?U01wY0FxTWtFOWc1amx6WHdpTEtJVXdpQXh1eGN2aUpEWFhXaDRjNDA3T0Zs?=
 =?utf-8?B?QVdxb2VuWmZhNnVhOGNrWVVOdGNhZ1J3WU5LZmhCbjZ6dUpNdytOTjRVLytI?=
 =?utf-8?B?b2o5R1crSFdIWmIwbzhwSXFSQS9BdDNTbE5ocHJQb20zS29XSGdpaUNPN3c0?=
 =?utf-8?B?bEtxOG5NcExid0tUWWpyMlYxckZOQ1VhcnNKZHcxN0g0QWczZUgwTUQrS3Bn?=
 =?utf-8?B?aU1heFBySUtDMFp3ZGkwWGUrSVdZWmF2M0tId28yS3ZVNlZmZjE0VWl4a09U?=
 =?utf-8?B?M3liYSs2cmdnaXQ3UE9raDhyWHIrT3RQc0poMmF5UUVmbUNCMzNDaEtTRmd5?=
 =?utf-8?B?SSt6VG9uQzNmQ1UwVmFmKytwT2V4S3NEdlpoNTJ0MmlvUzdONkg4aUxIalAy?=
 =?utf-8?B?QVFtSjhjdVlucnNXM0x5U1AvRHoxYW5DenU3TnNHcHFEekNoZ1RJeGRVbjNq?=
 =?utf-8?B?a3V2TTRmTG55eWlLZUdVelIxdEI5WEZ1RFBLU2JoR0d1bkpSeEVzUmFiNFA2?=
 =?utf-8?B?SDl6MDBQYUJwZ2NMZDgyR1hERWxBNy9MWW5PWWR0UmxiaFo0RTdxS2NZWDk4?=
 =?utf-8?B?YUlqRjN6b3Z5dG1jYzhUWmMzYTVsR05jeUU4dVhoTUFLNjZmZW5wM3dUSUtU?=
 =?utf-8?B?L0ltNC8wUmpwQThsVzNKditmN3lhV2dvZ2VRcEtCT25vL0hxTWlLRlpxYVY3?=
 =?utf-8?B?UmJXaTZScjQ1UUlmODlwOVp6dFk4VUl2NUcyNlRySjlKZmwrOFhtMStCY2Yr?=
 =?utf-8?B?c1JIM0hqVFY2OEIzZGl3ditlNk91NXpUMU1Sa1l1NmZVa29mRG5pZUYyWXFo?=
 =?utf-8?B?Y1h6ckxXTjVkNE9lZ05QY2hHS3ZjTWFMOEdSUys3bERVaEVmc2t6RCtkTlJL?=
 =?utf-8?B?VG5USnMxZVk4MEdDTmxvUmo0NGkzZWI3Q3dFT2hMajVKR2FKRGZyc080WDJJ?=
 =?utf-8?B?NUY2cXcrQTNVTm9WTGxRUm9CYUJIQWI2Mzl3U2VHS3BCSWxLUXB4UXI1U25y?=
 =?utf-8?B?Tkk1YnpNY0pqOWJoUDFCZGtkdFdXRmtTcHpBeXZ3QlVlczY5eStJRjhnYVZP?=
 =?utf-8?B?czZ6QVhSenhuSzgyc1NHbjVqSTcwaFk1SHZKTDhaeWR5OWtYTnNwdkNKTmND?=
 =?utf-8?B?c1BrU29udTJUd3BDU0RDajRwQnNXMWdaNU9MbklnU01WTDNNb011THQ0TzhS?=
 =?utf-8?B?eUlCeVo1QjFId0R4aDVnSzNLUG9TQjYvU3BMZ2k4OXh0Nm1wQnFHc3lhWmxw?=
 =?utf-8?B?NXBMWGRVNXNVTysrZnN2S3E0eGh4cUNlaGVDZHBtTW1qSXJFTlNibXpnZkda?=
 =?utf-8?B?L1ZRQWhFamtvZjBmUzBvbUNFWkJXSEFkdlZLajJ2TVJQYnhHc0pqcEh0TFcy?=
 =?utf-8?B?blovcDJDOGV1NmdKOTRjN0U0VG42NVkzWUpvZEY2RkVKUXliUmtGalU4NExL?=
 =?utf-8?B?eDlyMkRTMkZBL0U2RkN4WTNtWDNVcDdLK3FQUFJrL1pQblJDME1FZ3ZTemVv?=
 =?utf-8?B?SWdQRlNtNTdiZEV2VHVXbUU1V2ZncUNJeVR4VnpkY3QyMGtUaDFENUppb1Vh?=
 =?utf-8?B?aW1pd0hGNXBQL0ZKZk1CWFFuY0hpRFZjcy9CMHFvcUJBaXpVSGlpMlJ3Rmk4?=
 =?utf-8?B?WExOTDZYTy94M1JvRkNCOEh2eFBqU3pGeHlPTDlieEdRNnRHR0RNSXEyajdr?=
 =?utf-8?B?VEVxcnJVUDJsRWs3ZjM1b3h1T2JkMmFrb1pTQVVBVUN4em9ZLzM3V0hSS3VQ?=
 =?utf-8?B?YWhyTWd1djJhV3prTjZzTWdpNDRXNkJjdUhFSnp3SWV0RHpnaHJIdDB2RnFR?=
 =?utf-8?B?NEFTNldBZ1lKVUxFU3B2ZS9nWnkyelBONmppK25tOU1oUlphL05aSXo0L3Q5?=
 =?utf-8?B?Y29IeERXZmFPTFI5YURKN1pOcnZ4c255Nkt1dE5OQk8vcnRJVjR6UUpOeXhI?=
 =?utf-8?B?Rlc3SktvaDRHNGRGTTVJenpEb2lBaHVGWGdHS0Z1eG1Ecjdsdms1UHEyZExo?=
 =?utf-8?Q?N7pAVh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 00:50:54.8248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcae2c00-3375-4678-4467-08ddd87120d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

This series fixes two related issues in the handling of memory encryption
attributes on ARM64 systems with Confidential Compute Architecture (CCA)
enabled.

Currently, certain code paths assume that the target address for
set_memory_encrypted()/set_memory_decrypted() is always part of the
linear mapping. This assumption breaks on ARM64 when 
CONFIG_DMA_DIRECT_REMAP=y or when operating on vmalloc-backed memory
regions, leading to incorrect encryption attribute updates and, in
some cases, system crashes.

Patch 1 addresses an ARM64-specific bug in the DMA atomic pool expansion
path, where the wrong virtual address was passed to the memory encryption
helpers. On CCA-enabled systems, this resulted in corruption or crashes
during pool expansion.

Patch 2 extends the ARM64 memory attribute change functions to handle
vmalloc and other non-linear mappings correctly. A new helper is introduced
to detect such mappings, translate them to physical pages, and update
attributes on a per-page basis. This resolves failures and crashes in
scenarios such as NVMe device pass-through where vmalloc-backed memory
is involved CONFIG_DMA_DIRECT_REMAP=y.

Both changes have been tested on an ARM64 CCA-enabled environment with
NVMe pass-through feature.

Shanker Donthineni (2):
  dma/pool: Use vmap() address for memory encryption helpers on ARM64
  arm64: Add encrypt/decrypt support for vmalloc regions

 arch/arm64/mm/pageattr.c | 55 +++++++++++++++++++++++++++++++++++-----
 kernel/dma/pool.c        |  8 +++---
 2 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.25.1

