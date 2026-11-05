Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854106;
	b=amy42Hb3My4SAlggRKez2bt8rsx+A7k3K5zQoSMUD8yRcbYQ2AzL68Pd72U0uuMFsFnn
	 0aWJZtfotuVnRShSetTy2bAnnkJ84hKaC0V4WZ3u+nKjzzgwPQtMshsogPshLgNSETzXd
	 uSEuFZtL/cHBWPkc65zGd1Tv3rJCgW/HQRxBEncn05MsM23gacSzXR3kIbNLA8JV3yuqR
	 jNKgTlbCscVzIjB188FXNMTolZ16FIFB3IMe7Yuzhyjz+lNGZzJrn6ZVmivqqIw4JlRUk
	 UI0ICATmONXt6qNp0rKA1S3FCwDlJcUvnnzkRhhx3B2thdGjfhExK5xb8FSbKfotZ+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854106;
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
	bh=tcbbDsuqnpPgnOEkAItKvuN9/8eDPuIy+ioyx3RwrtM=;
	b=FkBz/RpU6db+3MbboYufRt2MutFtOQdesU0tHN+uGQX23EjKOqPZ2KeLhlcaeMQYq2DY
	 XivigwXF15QMqatYhxK3z1lvuNkTpDjbHo0E67W9ZoR3AsbxtUNnlOa9HbcdbZ6UbZNcv
	 F3DQ+hixmwOzUxhv/aAGZz43vYxyi+YZISZxCUpqajbwT/pHmT0QvuPBK8QQaf/2a3Q9K
	 6Mk4Y737E+ZJgVNRwUUYqdmQbFK8miJLhnmFrL+AuGDCu46pho1M4yX4k+jwvxdud0VKn
	 kxYgxVVfbd/YN14lCMij4hozDqDs+zUwY3UgU9n0vS9YfCv5lZ2giMicHNkw0FrsvyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="K3EpT/PS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.41
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A11606A329
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A11606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K3EpT/PS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pql+hK+HMhYMq+OjWnL0Z1gsrWJCEtl4Dul7aaywTdHYCK1MlifLYQfrUDy8xT2FV8LHXqGrEdpdUNFSqWxqEDna4cj/Yj4MsN5eeaxkIhu/SWAoo4eYXhC5nfFOchKEYMstT49BBTtEJy0sdnyDsByCw78Dh7yGfGxD6/NwOXfmFbCNDxiuwJv+MBuRZzxOOJqbB9iucoE0zprv2TdTaxdR8dijwE8M9pcW/QYBOMTFcf3vLnx26cfagYiJm8JFFUbHQmsX7/rtF5pf8yxqqQLb68Odw3zvEQt24rfJak5Rb3WA5NOTyR9Qf27F5RQ3NhMrk44Zb4QKb11enEGMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcbbDsuqnpPgnOEkAItKvuN9/8eDPuIy+ioyx3RwrtM=;
 b=Svw2a7tftB0CuOHrbRtMFO2Pni0D5U8AQGo09AajQDfi4twbiEasCeB4ZXr9cOoObDvCq0O1l48SOBg1vhY7WNkP0lfSsLl/TWqpGTonz7iVNT+j67dWXWXeI+gxoEVslPzNDFrvAKTC5OIF/F/jTuHxWHpb/p0PwndHluq/eFDdZLqY541AaRhOOOKpfRo72zrO5G5Ij/eUh6guJ/+Na+w7Majg6M3v97Wc7xVZ8ijSQ7Yz3M4r5TfpEc5DEyK23YJytpaECgxlE4MRtjzNyr3hgA0y5Em4uwbp+AfLwSfvcBACtU/OfS20G7qNgZ4f9+y2/57PgbNu1Bdu6S4zZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcbbDsuqnpPgnOEkAItKvuN9/8eDPuIy+ioyx3RwrtM=;
 b=K3EpT/PSVj8FghwB6R7z6WoshGvxV9cyjTtA4rhwd43LvOD1A4ODhB7ioaQ9ZXacd2oFirmdAT7k2IUdQhUDZuLd5osLkU7xp3dtqieuhS4igdBKG7eUhMXonUtQETEwCaVWOIIrQzWxMJ05jm0QK9WxrSPGqpE9IwatAQHUcxU=
Received: from CYXPR02CA0024.namprd02.prod.outlook.com (2603:10b6:930:cf::22)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:48:18 +0000
Received: from CY4PEPF000392D7.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::94) by CYXPR02CA0024.outlook.office365.com
 (2603:10b6:930:cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:48:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D7.mail.protection.outlook.com (10.167.247.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:48:18 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:48:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 00/12] iommu/amd: Fix GCR3 lifetime and PPR completion
Date: Thu, 5 Nov 2026 04:47:49 +0000
Message-ID: <20261105044801.399466-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D7:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: d35d1cab-3396-4e9e-bba1-08df3af8030f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|10067099003|18002099003|56012099006|11063799006|5023799004|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261009221227099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	cHy/7XRuLkUbcJ/Z0PD4NyZ7EZhS/Txk4fZNLV3dTQQVlr8KeL5NOS1R4uUZvrugh5Q1s0YZ9cfK/7rrfmtIxwMxsFai2+F2DeP03GO6GvTX0801/c/owqIltWylqk4bSMVjCfCER0aKzruWS7xXQIsouZoAgbUztTnVHuKPtSCWZwGX6GXtqdkE8jkYrEghQUoj3O1Dz62x1tRLlxAEiGHhWRJH5VSmfvHVWDTbf+I4U2rp6L19qi+Oil6hzqX2ROxx7BRYpXJxTVwNnzguZpxBlqpyWcV3Fp0suVs773VibQXONoO9L5BZB/KDDBp0KGIwTFcQT2MmjUQd47e/hec9NZHy2h3zbSFAQbv3nlXIQGlVVfGrIWFWuQ8ZUj8SGSe2ztJloc8laHyMyFdvOy+aZGDQsJ6K96qz3xNj8Z6Fv8Y3RxMAYg+u9LbC9QpRULyi5S+9WeOjkCLXFXNwcFgeueckc06WsvfBQAI7C12zl2rIEYKhjm8eYo29jJABBIpp9swU8d45/wN9k1sK2JnBYzRn01VcRHtjHqOHLBQMOp+4PjKRDCgdNE9jaRBpZeMBcKHCNX92OEfEYR7dH23lHYyWeJKbpRTaFGpRff+/t7h+Q38oDHXzgZrZJwDSLkqrlHADL4KQ/3C0RQKbdYJ4i8VS99eCqMs+dUBEiis=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(5023799004)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261009221227099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gqWk+bnaoqYQ11dzTi9XJgX15m4Y8yK39k1nZLTBWfeChZANYUoJ7nlQzFifyQvnlcjRdyZkCmSNg4WtpD7Mf9DFo5boUWVHmTA1Hcr0hMegt0Y8h3bXasozP3LH7wt+zCyOyzE7OQARkuF/K6yy+AWmdKjY/UZKFvq6f+kh5QdkbEvmPfUHNk9CIfYHGvpPW+dimkxgly8C8pwpNaxH0UHzusIC2+9QKvMsDDEm43CyaojG/E8xIJ5wYhCAKDfmAafVh2Lk4rXj65qWWyImeF+iiFnkFrkZkc2RwnYLkD7xXpcqfHvss5/FPEUepoHuRWnVMY4R0Z+Pbf7ySowHpPW8qAv6nn28PvgCA/nSFAunnDzD/J+Cxsi6Osvegw0qUCdq5GltW3/n+ztze6VocYJ819HbpMe1TK5AChmlbbLhLl8Mpug4lMLsqp2Ol3kz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:48:18.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35d1cab-3396-4e9e-bba1-08df3af8030f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

This series fixes a number of issues in the SVA/PRI path. It does not
address all of them: a follow-up series will move PASID/PRI enablement to
the probe/release path and fix the remaining PRI issues.

Note that this series also does not fully address the issue during
the mmu_notifier release path, which was discussed in an earlier thread
[1]. We are still running some experiments internally, and I intend to
address it in v2.
[1] https://lore.kernel.org/linux-iommu/20260814104029.71021-1-vasant.hegde@amd.com/

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

Full series including other cleanup is available at:
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v1


Santosh Shukla (1):
  iommu/amd: Restore an SVA PASID after PCI reset

Vasant Hegde (11):
  iommu/amd: Disable PRI before ATS and PASID
  iommu/amd: Derive the PPR completion GN bit from the request
  iommu/amd: Complete a PPR from a device the IOMMU did not probe
  iommu/amd: Keep the GCR3 table while PASIDs are attached
  iommu/amd: Disable GCR3 entries from the SVA mm release notifier
  iommu/amd: Complete an aborted PPR group only on its last page
  iommu/amd: Discard partial page requests when the PPR log overflows
  iommu/amd: Allocate the GCR3 table from the device
  iommu/amd: Return -ENOMEM when SVA PASID allocation fails
  iommu/amd: Drain the PPR log before detaching an SVA PASID
  iommu/amd: Drain the PPR log before removing a device from the IOPF
    queue

 drivers/iommu/amd/amd_iommu.h       |   5 +-
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/init.c            |   1 +
 drivers/iommu/amd/iommu.c           | 187 +++++++++++++---------------
 drivers/iommu/amd/pasid.c           |  32 +++--
 drivers/iommu/amd/ppr.c             |  92 ++++++++++++--
 6 files changed, 203 insertions(+), 116 deletions(-)

-- 
2.31.1

