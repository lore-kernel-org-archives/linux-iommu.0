Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C06A8D2
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754871858; cv=fail; b=q0fMif5OK4yvlYFny7CMmXMGJ0J96yqphzt1RVW2fKLv6mDkSmKq8hvsi0YsqHGBjCqTln0MQT54PW5Uf+BT2yWxwZK7WUXuCVlXwNTPVZficNNzEojVmnW71j2PbVLVtOiBNl2ZfqoxFk/qKZrpYNsYJ8ZJoR8orQussgxjzh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754871858; c=relaxed/simple;
	bh=Kpk1NMBZtia8gsvOJ42Zo0lmu6j58OZ4o+o84h+7aZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NugT2w80CHdes6mEe+SFL2Gh/Cw9H82GoKPJESb4brWnzcvCmhyEZwLzOwbukbAsfN792dGu3o69qGoGRAT/sLKcbFihl8HSh9q3q+7K5YwKbA8U+VZXLeVlGbfKx4pGbRoocbAMpigl/QWjo3pjjNpbtuVEhjMhpWNl2Wrf2Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SbE2XkbH; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SbE2XkbH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcpjlbjPMuk9BxhE+NbMj9/svkdgr/jS8L8HkTTv5YwFlF6LEz1ywDhrNDDwhCYpIS/3u+wxav6u4L61nvd9g95WcRiEjwXVAW0etkomQwN/uk29Q01N9ZeODUovjVYJ8hezYHU4F6W6j87gS9tI86WtBTqOCmAcQmxqNpd13KRLKFWaMYsrIn8kmyBgX/rAUou2FiG0MUVkxX2wQuUdiU4cnuBaNpvGGJaqW4Vqkbu3TZG+Hbu87fEypPobazwSrvjId6slAuCWRRprR7ZyR665TChklZiCPfV3RaTAP+mV+icTItP7EL2E4kNVk3dFPfVM5GGUmVWgX/8oIcwK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do+T9sT5L19gqSgT+cSz1/KPjWv7o95NkA+MoHjSdFY=;
 b=dcJaavcJX9kGBSvESTpn2SJ+CiTdZMP5P4zhti2eQvKpXjWcJ2JIAjAe0eH+eBoMfOW4fdnKQhS88c5nt8S75MEr4mhIoGMqtSRRf1pPKoO6r84gHGWlXnKUZu9suaBq2mwSqG71zCfOxSTmrJ8mrzmvnxUwCn+hrXEq2N5FXwPKEint8KqydbE1kwBAr9pKtXxQjaYm7ANdW3u/ue1t/u1ADCiVvlfxr+amb9Z9MmKEpDX8cNv5aijLzFOVbtxcXOc60kK/Z3La658bcsWyQoPxtwkKh1hAbTxPXQtIvhLnQXTmwEmPNJR1uQOMclNKZAGkC99qmj1Ww0uT8Zs8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do+T9sT5L19gqSgT+cSz1/KPjWv7o95NkA+MoHjSdFY=;
 b=SbE2XkbH6I14l6b7U7FRsNkgHupCGA9h2E85FoLcGdSBDuY9SCiCHjDK0DK3WHRJ9V2xZOqVgCAYieOX6PPb3Bk7C+NzBbXsrBiYn/vNp2TMmOiwXS1NNAgUglK598GikV9g30H8PIKoOsVp2ztXNelu7H+cLLmqh3mMQ175jQx71iQkApKIKee+BS0WgpcjSwzr7umdBj/mxTwE+RrHJZYfEU/Z4/XwdRoTcf393i+GEMkl8i42KHSTxwftvD+9MJnvL+fGVOpHys1pAtwD7fdKCh87CrKMARXiPkoZxQnNxRCzGG0wqSBf1HqiEMof6P90RxYS1ornuISOg33ggw==
Received: from BN8PR16CA0025.namprd16.prod.outlook.com (2603:10b6:408:4c::38)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 00:24:12 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::ab) by BN8PR16CA0025.outlook.office365.com
 (2603:10b6:408:4c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 00:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 00:24:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:24:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:24:03 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 17:24:02 -0700
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
Subject: [PATCH 0/2] Add encrypt/decrypt support for vmalloc regions
Date: Sun, 10 Aug 2025 19:23:55 -0500
Message-ID: <20250811002357.714109-1-sdonthineni@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f1ef70-c6a1-4d37-5100-08ddd86d6561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlh2MTJUeEF1dkIzalZ3NnJTeFNvM0VlRWdUQWZoWW1DQTNaT1VVZHA1V1Ru?=
 =?utf-8?B?S3JEcVhXUVR3M0MxR2xDNElKOHZ1amk5ak5tWXpNN2F3QUE3eDhJdHBudExw?=
 =?utf-8?B?aVpEa3NWUm42TWpLcms3bUVHT2tXV3RXQzhSVGM4c3pUK01WRzY5RHhaRkhs?=
 =?utf-8?B?UEtubUw3cWxtTnNvSzFhL2NSaUZhQWJTazhwZGhPM0s4UyttQXFya2Fwcm9I?=
 =?utf-8?B?TmFuSWsvZmhJOU1xcHZtVGFDQktWVkN6MWd2aVpmdWcxSGo3QnRndFpVejFy?=
 =?utf-8?B?SkpqTkNxc3hIS1ErQlpaeEZhRm9pMVprNVlPeUR2VmRDOFhYTkJYRXNWNXNC?=
 =?utf-8?B?R3NiYTRvMlh1d3Y5M1VQVGg3VXdhSXhCRkR6Y1BVUGVBblpZbHdTSHhqVkl1?=
 =?utf-8?B?c3ZoYmZoTlpWUkplbDllWUtSQjhvUXYxSlYyVjVLblpveW43Q0ZHS1hreVVz?=
 =?utf-8?B?WTRIdHNBZ3VyRjAzUkxWbHZDTTNaRTNUT3IyL05vQXFNYlNSSUFGL1ZPUHpu?=
 =?utf-8?B?cVp0UWg5SUxQeHhNQTMvd2JZWU9ZM0E1UlZLM09XZDk1Z0R0NFRrUWFTaURs?=
 =?utf-8?B?a2FqWmFmdHJqN1lXeDNCeW1VZ1IxZG5RdjVwN21yR0RTSjhEQTFyQ0xWcGQ3?=
 =?utf-8?B?UkMxV2JoeWRXTkpCdjFGbE5IWmlJRk91NTc1b0ZaVEJtOHFnWmp5LzVjQjVO?=
 =?utf-8?B?SzAzK2RDNEZlRXdac3doVEpkazNnTHVUYmR4MEtJSG4zVXhIY2VyVUFuZkdW?=
 =?utf-8?B?RDlKemNadUVjYnhqZk1sN1pZZjRDUkNnN0g3Y1FrNnVDUnpDVlJlclJzb212?=
 =?utf-8?B?dm9PQ2hhU3FZQWdKUXZvTnB0K2M5Sm1YODJoUUhxVTEvRVFLUzZjYzNlTkhL?=
 =?utf-8?B?S1JXSjlwSGlMejd4ZmNMYlQ0bFplZlZFOEpHRGxIZ2hqQTFRVmJCUGtPVWlv?=
 =?utf-8?B?RDUvYW5zUENoREVkWi9QSFQyK0doSEtDRm9xY0VHcGd5Mm5OOXFQaXVuNStD?=
 =?utf-8?B?SWJhUTRWYlBxc3hndUIyQWV5b3BXZC9yM1dXV21VeENxVXpjVW1RdUlLaU9Q?=
 =?utf-8?B?TkNyRWFTWmhndWZyOXNxMVBuQ1IvVmtkNjhJWTRTYjE1b2p0TWRsZEhJeHJk?=
 =?utf-8?B?OVVXdGdONmIrQ09FUXZxMjhuTmQzQ0ZoSjdaK3FvNGNidk5yVEZJd0FDQWt4?=
 =?utf-8?B?dUF5Sm5VRDNFVmhEUCtzSWJrR0hXanF6MzJaa0NXVHE1TU8wenh5VlBOaFFM?=
 =?utf-8?B?RXlWRmJNSE13MElDSVZkVDJGTlBqb0tHaU51SlFvK1dMZExVV2p0UzEwVWtS?=
 =?utf-8?B?WSsyU2ZPRkZxNVVaK0tkYTNTbzJPcGJzTFEydSt0R3k0WTArM2JTYlI2S0Ft?=
 =?utf-8?B?L0UySFdyQU8yUkFIVWcvbHlFMVpOL0lmczVTYm9hL3FmTnRyZlRCV1pobGNq?=
 =?utf-8?B?c3lmMUE0YXlhNjlrWDRYL1g4L1I2bnpxVEs4R0dFMm5KZEN3MHB5YXJuMDZD?=
 =?utf-8?B?WmszMHhoQjhLRnNmd09kdUZOa0h4alJYSzlyUDdZcjRmNFQ1eEJnSmIvV2g5?=
 =?utf-8?B?dWN6OVJ0MW91QnRWazFFMVBnbGVSb1FlNTMrYTQvaEp6T0VQT2tyWm00T0pW?=
 =?utf-8?B?ZzFtNklzcFFHUjRCOGFUNjUzZ3c1RFoxWXhXa09jSkR4Q0plYlBqbUJUVW5u?=
 =?utf-8?B?WUJmRXZuVkU4TmtUb28zemMraFVZNERsVWhCTHg5akhrbUx3a0NXYmNkNEF1?=
 =?utf-8?B?S29XQS9GOENZTkthSU1ZWi9YUlpKakF1MHZBNG9rUTQ3Yi9JbDlvZlRUdW1o?=
 =?utf-8?B?K08zdG8wcjJIOVR4eVp2cWhZRlZpTHJWeDJqT1ZFY1kyeGF5MmV2a2t2dElL?=
 =?utf-8?B?a0k4L1RVKzlRem5FSU56VHBNRjAwWFpOUHI5bWs3Z3ArV0pCaERCeHdLVGky?=
 =?utf-8?B?Z2VzK0tqSXprVkxxZ3RBRVZpYjB2M2N5RmJhK1FtL3UwelJJWDFEdjByZWdv?=
 =?utf-8?B?ZGEza2RGYlJ5eWQwRWszNVpNNlc2c1dJSE42dmZCRDZsdVg2UENKeDdmS1k2?=
 =?utf-8?Q?fkhTVE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 00:24:11.8605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f1ef70-c6a1-4d37-5100-08ddd86d6561
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

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

