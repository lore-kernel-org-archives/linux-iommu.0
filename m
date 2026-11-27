Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780673;
	b=v+krPU2JjdI0ImJupR7hVxt1pKcshUlq6kATZ/58EX9Wm40WbH9Gs+3xPvWrOGZeGsad
	 +wdDTRhnR61UYfAND2ku9bCAE2UGWYQJMGMLcO9Phu2WJN6d7c1mXB0V/tUN+7LNuVBYg
	 oPpgguD0YO9mtCo2IHqB5YJePSzDcBm8N7Kq23nEvTH4zl1iWSrFOEdtMKz50xkAIprme
	 pO9oIhUiDn68pIh3visFKK4TucxkK5aZbslqk5oXFDsKfak6Y3pkuRonsyCbSvBpGGhcM
	 z17abnB8yXgLJ/y156MhOSVUlQQ16O6GIJXjJL68bomcFZs5HG+LZXV/HpFgnk7sVPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780673;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sLbbTNRgtJzaBK7WJW0quXL1IaIbq5fy+uYI1BT6gGc=;
	b=zv6Ax/GbqFSqtl2IrUxJ2ZG5ThfCA6MDZIBeMBPP+Lw4NwKerjYk0tMXWB/3R+Qh/Cho
	 PBVIKwVRxqyY2u4+tnKQDQVbLy0vvyeVHMZPEPmBz3P3oF5FtnST0v+A4hB5m2A+M8Roc
	 VzavgfXO1vzVRC0Bhgr2HzcyBl1h9rtCoYKSWXAZ/r/b45Q414tFenQ/gDFpAzye35bWc
	 baLyXmQ3dwpvvV9ejU8a3p0E5rI/AGBk4Mg3lvZUkhxkW9XCQfMsHW9Y2I2vb1ww9gS31
	 t89l+syD5kmVPwWijJqxu4yxjT3CQrvl7vDu7YmKp/5vpaJFwhROtHRXuJy9XcWS+3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=inseFMsT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B70606A321
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B70606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=inseFMsT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJFtM3ZqViBQbDkxUDZ4eyyWRzOHAwUBJjpqFd8RxbuvPsELfa27HsvWJkc3BwcupyBmfGxRAfQkCegmeRDUsIKh2AhTnhhT2oSrYpptzHGNGzRRDRB1dtrZy7VbM0VRtfB70OnVBOQSYMwpRwiwbSHdp1AlqA/LdqJTCjawC1XJBCoN/CwDYU5wvEVuaRV3hLQWG6Dv3Efm+BRh2KKMDhXouFayQzoVVYrBgq6YL+GZsJrNYmG3uiWNjBLglqTBC3VA69pT0ECsJyXhngFCy1aL/KO1q+frs0fkyCnc3E6Pc//25OmPhIiukqY1ng1q1qvJqyDW2H5L+aqlREMFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLbbTNRgtJzaBK7WJW0quXL1IaIbq5fy+uYI1BT6gGc=;
 b=lHQHPMvXt2RYfJyUUIPOxIoAfpZ+2EH0R89qLn3hzD0EGxG+yPCUlgDP73fz/7R14Tv0vGOBjdFCSd90ivHD267715ec+pO0u9D4FSuLLGXMiMLsy1IqIHij7n7YKvetf2cpt5IoLpWKtH3ZRTsj+lTqLypTZt4WQg+w1yRTbgSarr6LUWLItN4KGpttbhlGhumHwSAICN5DwoJ0V4AWgtwsYGVhWul2Qzx8PATvYsRwwIddBvnBRBU6B+2KaDdabuESjwGVBi+/+knlB0BqW7CiAUIhyxWv19rEm/0bf55qhzAl09H+c9PYBSpAI7E9IcyZJ+oJvd2gMQv+Fb9aIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLbbTNRgtJzaBK7WJW0quXL1IaIbq5fy+uYI1BT6gGc=;
 b=inseFMsTXVvQJwCEZhXBHnoW9r6OgcD8wlkUqdFxY7kJGHaSUlHjFrvvrNse7fS16YK4pGtdGhzFaocupLMg/iu2pyIBHvflsEjhM+G+H1sFVNMk6+BYzrqqGqMg6xx3cRv//qcvJDPvjwF7l3NsXBTLXzuAiP/BLCVCyDnAyJQ=
Received: from SJ0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:a03:3a1::21)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:55:44 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::26) by SJ0PR03CA0376.outlook.office365.com
 (2603:10b6:a03:3a1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:55:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:55:42 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:55:39 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 00/12] iommu/amd: Fix GCR3 lifetime and PPR completion
Date: Fri, 27 Nov 2026 11:54:35 +0000
Message-ID: <20261127115447.209792-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d374fa-c2a6-4f41-5dda-08df4c7d5cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|56012099006|11063799006|5023799004|261022105027099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261009223027099003|261009221227099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NWAScGGRyyRFDFLkYazNaLwfdNNgynQfl8wqvMh/Ks2QEFjg9zO4lSfiDoSZBn5S1anSqoviKJ3Fzqu9H5GooBhAs/Vybom79VvXNPpcYjq0XGrtu6babFlPgHkHQkeMCMvl8d4JQ2V16RugtqKedXvTbGHPnXvmKyFtFdU4S2Yf2/B2Fys+bkMXi1cMoUtzA7eu8lzq9gr5B6gKRQpd5uKqW5CD+FCJRDeNyZ1E04uSKa37yRzDCmxuKixe52sgsPf+b5thQO6AoA/WgCJ/8Blj7lBNDegRGZSj3haEfxdnSv2NsOzifRYnwbA35WiW+I8YXhBj6CcVw78ipEXWtV91T4FRk10PrYTvcj839r3ee7N3BHDtsK3muy6ZJ7aRJJUUvEYpNgYBfW9KDBko3I0DQZXnDOMd8fxCbNJp4n7NMxcDQsYGXO7BU/B0Wmk6iIshmzjVrcEkOqDud1j5wKefFN+HC/IxWC2PpxKEMn31fetGCzFW7mkW+ba0IKoQLgOEucCLlFa3wM7xqbE3srBiNaA6bEIcMy/9VAD6A6PqWuyn5fgHDw5GsDyOsaEhdU4MWKJqG3JRTAd8aKIyB8ryciChy3pPjizlQZW2076jxTJvG8Wzii2cisysAe+j3bQpeiP/ELiNrpQOJhwCrv1GZt+e04HpHGh+m0tk3pA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(261022105027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261009223027099003)(261009221227099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l8PFm9OakRG4/HyinOhR3rxwWgS4L2Q2nKCNcrS/bbZSxoYcfue4yCnVeZnx4AIdYG8QQV72a9OUDQsoGNRGRJvqtdx0wkXYc470O74zufEX7+ClaGLMYLPAq9jyu65lv+30WPVnhf1QJ8XqTO6uMUDOKWSE/4sT+oSDvgsEUyuFyvy0mvrb8xSRpKrYz+U/OuAm3rPIYNEU58wC7dlbTQ4LxBFvoLNg6c3JGM/f78/BLA7XdhNsX6c4EM0Q9G5hNqfFs9TdqQ8HOPASUVTf3Zz6HbGCDoXoP1HtiQGgzhLepu19zLalzms5bxqhSpI8jqLVGJOQP8K6kIsuYz4txqwUif7Ja7mpFHfeDwWLXCGLeWrp5zbAdPYxJluD/DvDszPJLmVEc/QejIWVx0N72SpssoCg851lP/EYh3e/p0oo/eaLNP23G7f0iC7eG0rQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:55:42.2880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d374fa-c2a6-4f41-5dda-08df4c7d5cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

This series fixes a number of issues in the SVA/PRI path. It does not
address all of them: a follow-up series will move PASID/PRI enablement to
the probe/release path and fix the remaining PRI issues.

Summary of changes:
-------------------
SVA teardown and page-request completion have several ordering bugs.
The GCR3 table can be freed while PASIDs are still attached, and a
PPR response can complete the wrong request or run after its attach
handle is gone.

- amd_iommu_complete_ppr() takes the GN bit from the request.
  Page-table mode does not cover passthrough, which also uses PASID.

- The GCR3 table stays allocated while PASIDs are attached, so the
  blocked-domain attach during PCI reset does not free the root out
  from under a later clear. A PASID-capable device allocates the
  table at probe and frees it at release. A non-PASID v2 domain
  still allocates it on attach and frees it on detach. The mm
  release notifier only disables GCR3 entries and leaves the PASID
  attachment for the core to remove. After reset, a blocking old
  domain is programmed again as a fresh SVA attach. A failed
  tracking allocation returns -ENOMEM.

- An aborted multi-page group is completed only on its last page.
  Overflow discards partial groups whose last page never reached
  the log. Detach drains the PPR log before the SVA attach handle
  is freed, and before a device is removed from the IOPF queue.
  The DTE is cleared first so the IOMMU stops logging new requests,
  and PCI capabilities are disabled after those requests have been
  answered.

This series is made with the help of AI (Cursor).

Full series including other cleanup is available at:
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v2

Changes in v2:
  - In sva_mn_release() path it will point to newly added dummy page
    table. Any device initiated DMA after release will continue to call
    PRI handler. Driver will respond with error so that device continues
    to work fine.
  - Addressed review comments from review-prompts.
  - Updated tags

V1: https://lore.kernel.org/linux-iommu/20261105044801.399466-1-vasant.hegde@amd.com/

Santosh Shukla (1):
  iommu/amd: Restore an SVA PASID after PCI reset

Vasant Hegde (11):
  iommu/amd: Disable PRI before ATS and PASID
  iommu/amd: Derive the PPR completion GN bit from the request
  iommu/amd: Complete a PPR from a device the IOMMU did not probe
  iommu/amd: Keep the GCR3 table while PASIDs are attached
  iommu/amd: Return -ENOMEM when SVA PASID allocation fails
  iommu/amd: Complete an aborted PPR group only on its last page
  iommu/amd: Discard partial page requests when the PPR log overflows
  iommu/amd: Allocate the GCR3 table from the device
  iommu/amd: Drain the PPR log before detaching an SVA PASID
  iommu/amd: Drain the PPR log before removing a device from the IOPF
    queue
  iommu/amd: Don't detach SVA PASIDs from the mm release notifier

 drivers/iommu/amd/amd_iommu.h       |   8 +-
 drivers/iommu/amd/amd_iommu_types.h |   4 +-
 drivers/iommu/amd/init.c            |  12 ++
 drivers/iommu/amd/iommu.c           | 223 ++++++++++++++++------------
 drivers/iommu/amd/pasid.c           |  32 +++-
 drivers/iommu/amd/ppr.c             |  92 ++++++++++--
 6 files changed, 254 insertions(+), 117 deletions(-)

-- 
2.31.1

