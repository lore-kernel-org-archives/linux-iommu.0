Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896360;
	b=OLO/EBEpg8k3xHspZFc9kPsDFD/fUt1//X6TRcW8v88A1GQLuOvCLiPktbhgpnF/kUK3
	 Wzf9fNeHTAg9ubzk/iJvIQbfG6DnBW06V9tn7IKH1sXxkWiug/SQBQ1rjUC2LiQToCCB1
	 GH9nQKqeSIV7tFL88+sJkBMyD5mXpN1nwOBfEBaAH5YzRIbC/R9z0aT88asipVckHBW14
	 iKEJvNUy3wIiz7KigsNMNTMk+wpxzhSQIrUCa11pejpBVUDjX1skFCArcl6LILfDsh4bf
	 fA+JKH1jcuQPuafMYQK2sdgPyRr8kAag3KQtISGXemfyXgSIMzHTbem7CO18HauMl3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896360;
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
	bh=cX7evaUAZUk3NtOD+vQb+hpJ0xjqrO25biFLy5tUjRg=;
	b=ieKtOG3+UwoQWlF3gzSaT2DNCT/F6igcRDhzBi4Lnlnes1pNhIGkxu093Zt1P4xKHgJk
	 jQjVqrnw9GV9lXzVs+J27047aiL7fyXqVKwZlu6DgGUaPt58juh5BzfD+8UaVqaUYpZXg
	 gaOwefIqggRKfWy21yO04Mufk5sZ4Vd9B7NqGWuLFvfKjnTg7TDu2TY2UPysuvwbPxHSR
	 mib7FfWFgooyHP3ZBIDIbXE5A9LzatMakRYlGk16rpClm8/Motynb+qappQSsoE2CFNfR
	 LpPJcFpywKA2DZ8TE6eGI4W4m/aCmrb9iOBXLzNtfV1uPbj9oGGF+VMqo/DVLqMv8gA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sqm5mziB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.4
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B6606EE84
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0B6606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sqm5mziB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw69URQspin0NL7zE2d1+3TiXGRlMjZovfNpmI2WWTc3+MqWaSqwRQz0teUUpnJKl9rPR6DKFtSFGahFs7GzKfUYz/YoowT/55txu5U4ToZRRcN6RaGu078pAKH2XGxGP9xT14IZkPCYs/4kXujybOa+G3j55ffjWGQG4wJaNeSkHgkbNxrnabUHeQ5fYOS4Bpl1WjH4j8apAcsJsiahNzBZ14pRVjyto4rqzePXiidLmcIix9ymnVSJObUbYNax6A8etw06cFEZE5JhesFd7fRb/alaTW5GjkS17G5dXmz5uZ6vq809STze7CVCJl+bh6WLwEIrFoUKS1Kv2QJ1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX7evaUAZUk3NtOD+vQb+hpJ0xjqrO25biFLy5tUjRg=;
 b=SNRPvfdZeGj2dNUQhJWrzgsS73phCb0ZYjHvjx5T4xTCwquhnigrCfMjLUFxetjO/0TUl4Fuue2qc/Y1OUbfTi+dAFxNjw2n1oTxECjiHm3YRanas4KQJ/WRLkACjDKTepLxL0AKsfvBzPSXKn/2zByJzbI/X+Mi5AyCNG4v59SgDmQ9SP+865iPWNP+MXrhrzNNIxfxBvQzXLCKQleJxj00LYpxEViEolbR/XJn+mBvL3BGVhC5b5slQSdM01khN2//YRgpHI0OSkvai2eabb6skdLHZOTzXxC4ixuAseCjJFXOt01NAWpDyAaVvF/8nTLRhDZmDNi1N6tYLrk6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX7evaUAZUk3NtOD+vQb+hpJ0xjqrO25biFLy5tUjRg=;
 b=sqm5mziBYCLCBBx3+R1kL0vYevJDktw8tgoxGExG+OEH9iFa+pK0JVyaQzIgWCWG68aHFkkMsc+wdegtCkbOq4qQkYziQTLByCYbTfC3/tuuitQWQADUGiLf1haCg5jSAiw1VWzUIRxaDJqSb4RAwE8Isz6AAwobPal6eIpD64c=
Received: from PH7P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::17)
 by IA5PR12MB999323.namprd12.prod.outlook.com (2603:10b6:208:605::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:32:34 +0000
Received: from PH5PEPF00000030.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::28) by PH7P220CA0045.outlook.office365.com
 (2603:10b6:510:32b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:32:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF00000030.mail.protection.outlook.com (10.167.243.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:32:34 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:32:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>
CC: <iommu@lists.linux.dev>
Subject: [PATCH 0/5][PULL REQUEST] AMD-Vi updates for v7.4-rcX
Date: Thu, 5 Nov 2026 16:32:14 +0000
Message-ID: <20261105163219.601561-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF00000030:EE_|IA5PR12MB999323:EE_
X-MS-Office365-Filtering-Correlation-Id: 32503a1f-645f-4eb4-3bc9-08df3b5a6538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|56012099006|11063799006|261022075727099003|261009223027099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	paXxzlvRvLcXXn5fN5l5GbzyU3nea8WZdfJEDn8uKrFWmtg7wDaCRNw2+XzispvwnTEHJKPBBZpgaF24+CiWE6fDX1iy0cY5oSyiz7Lmy2shLJ/xkBc+u4TvFs0T/OaGxkw3dHBNz04z32YA9JxMAEvw/Iq974XQ4G2arcEko6SY8g2Nsb94c9mQxe5S5nnRf7FEIA/AObuRBBZRrAfV0UrJy7LL1tD+7f4HZWTRBwd/MdSrw9HnftYoYzobVSLgyUhI0om4oLiIQYjbnUMdWUf4OLpxAyI2ZJYnxLZLlTzq4F46nH4TE3MtqwzO08eFiMQ5Ybm+YWhW+luKbq6RLnLnA1gryffj+iWRMh4dyJk+6CYDu/vowygN6uOEgvKonHaOPqU3fv+nX0SktyDLOwTTqxeTffOgxUmtZ8x//YxnNccdcXYtT1r+PezFhzXqFlealCz7cWlxkWY+AFmGc3CC12z8ENnRBrRBaL97T46D5VAYbsIe/fsxq36tnDEQXTKZFxAuMxjs5PDFfXKx8vH0QIWX0DAwADwBplX9go3vZF5y29LrS8K0MQE2QZUib+9UIF3SNUIQTr3nE/gRQ1x6qgN1tutdXtzKcZd4zFcgGOJ5DW+IWXUN09W9Xwd0FbscB16VF1yeGBK1effX3mdJD3JHk5Akqsa1g3Y1HfmmEXAGdl8arChkPCMV4jgK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261009223027099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dCTgf2Zu5zZsgRnUUNqmUotZTIDJQfFxcDtYlqrDFceyxrg+C8g+3nryXwlMqCuxnj3LCxdCmPKAVSezuxWO0uMyOXfALsvIvAANfyiIVh4+72i+DVTRe5J+qH1fp9DqFKyHRsCImq0yl8n5tMCtIF/5bIAwFO1DM9hHieZuk5Zb9qX0+mck8scbkA7S4Y00xVJR5jIkwHHTTNJkqHQnZeBlpxFl6nvFQWjxkxXtnAmwLpsiAmqs5yUuwQ52BDQcarNfy1ypm44WIolGbnzqgLmD32A4kb3nUTwKrTy9NmzFG5nbVLCBiDx5n01ubBMt13vCAUCztSfFxFslhxMAZuXCZ56GwnQituMlACj6EzP9/2cYUZ/EsTMgxJR23LIRG2EKfu3nVGDz+HcblgO4gzFJGZKiS5sbHkG4TUqxz0QWYuCd1quntGtVjRw2zGA7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:32:34.0413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32503a1f-645f-4eb4-3bc9-08df3b5a6538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF00000030.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999323

Hi Joerg,

This series includes fixes for:
  - Boot issue on some of the AMD laptops
  - Making perfOpt as default. This is slightly larger change for rc.
    But this removes the command line option introduced during merge
    window and makes this feature contained inside IOMMU driver.
  - Few other minor fixes

These patches are based on top of v7.4-rc1 (commit 6628e7d4c6b2). Please
consider pulling below AMD IOMMU fixes for v7.4-rcX.


-Vasant


Akshay Jindal (1):
  iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Dheeraj Kumar Srivastava (1):
  iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init() fails

Jean-Christophe Guillain (1):
  iommu/amd: Fix NULL pointer dereference for GPUs without upstream
    bridge

Kevin Mitchell (1):
  iommu/amd: remove obsolete domain pointer warning on release

Mario Limonciello (AMD) (1):
  iommu/amd: Enable PerfOpt automatically for integrated GPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 -
 drivers/iommu/amd/amd_iommu.h              |   3 +-
 drivers/iommu/amd/amd_iommu_types.h        |   6 +-
 drivers/iommu/amd/init.c                   | 106 ++++----
 drivers/iommu/amd/iommu.c                  | 273 ++++-----------------
 include/linux/amd-iommu.h                  |  11 -
 8 files changed, 115 insertions(+), 347 deletions(-)

-- 
2.31.1

