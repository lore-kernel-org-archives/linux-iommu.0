Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E13254B2
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022556; cv=fail; b=iZkoWx0FutRPZ4kTcVY2Uu6dHgFUxzzIUy5+7Hz9auNlowQE28g6KSNtRGAmVjtr8T164XW+suS+Kp2YW7A6aCsYme9iOsNeJpeSMCadUVGVkH+55Oi4ouKR2FUY80iUxhXhY9IpV5ily3Sjq9KVIFGTX3ckyPT2XlTf0CuAd90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022556; c=relaxed/simple;
	bh=s/66PweP6XrBvNKHvpeQB3mKT1cHSoT+XwzadR+wRzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EbahIFLpm6ky+0saLwOnZO3C3kHoedhODP7dm+HA4ydh1IupYxY2oF7Wg3Nz+UD+FalQhiNQP0TGydp25jKMSDDdo3qzlJA4b7P0WS/Bd91rYlo/5B9PDzBuYkgIRNrRa6aKr4FrwRUVFCHbyvn3+04tUrn1UIwktJnRgQCLT7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sAuFFxUH; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sAuFFxUH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgDhjf7qnbEqtdPvj71rlq91jedvSG/LOpt91mEnUCEVzd7n46WKkokSw8DyFDHxKupcVGJNIkDH68ruwxi9I38QLUGUdvIiUUMkjnMCWwFCrAMQLyBDoYed4dPDA+uclcIcbAsm3oOmf7GAno/jiA2yz2miVZcIOnoFiQxr4xnxYJqeAvvAIlXDcRt1F1wiC2VgkZ9DiAVybkZSfQ4JZSJtgcmbMHNSSTzNZnXtrjhoclTM6aYluHb9xW5e3u+TLtoO7elmCmPspvd/DElJtsx56QUbM+Mblff9npugMRXZMEzIjFbRtzYkQavq+7g8aZvHb/j9EgbVxkkv8gzQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qxRhm1dI5zNuttdD7ZWldE7qGLOBLbb7id5A1dTJFw=;
 b=rpHozq+Y6+NFp6H/V2C7eDkiTRi4iAkj5aF8p3IOs7QUOIkJfvSV5zML7FWLtdzNYMUY49mqVkaDVTFZ+nijU8s5zzsA7S8sv1YPxxRX6H5bMPJ8OGxQFd9RpnK/6NXB2w6vhcUJne3tED/a5lmcj3Ed+a04HMC73TOGj5YrTHw8yOXLfqPgPRiAwb9un/OC3sILwgcp+lwyGX3Ko3AZhtpRNGvp5t2a+cwQRAblPvgeMjhhHOees5ilaG9u7vVB1dAbZNjCTweWu/6lKKAzur8vfy+XaHwqgrTgYgeIzmcZ97SbCkJU5ugLz9IBBSMUv2c4rTPsiD+TSh8nkNVVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qxRhm1dI5zNuttdD7ZWldE7qGLOBLbb7id5A1dTJFw=;
 b=sAuFFxUH4tQmAgCquyaKjAa8cF3u2MrRddk9H1b0uVHYzKcJG6t4PtCt1OIaFTL5Ex5WVODMTxWKfN013l7siq2UyYi9PyOttl9B7M0DmC+TECdDj0SbaObX4DRyiV77ansF/VWuCoUvpbfDsxUh59jF4V0ZhJEbIv9em1DOMzw=
Received: from CH0PR03CA0439.namprd03.prod.outlook.com (2603:10b6:610:10e::8)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:22:30 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::9) by CH0PR03CA0439.outlook.office365.com
 (2603:10b6:610:10e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 09:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:22:30 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 04:22:27 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/4] iommu/amd: IVMD handling cleanup and ivmd= boot override
Date: Fri, 24 Apr 2026 09:22:09 +0000
Message-ID: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: e9304b7a-e612-44f8-76c8-08dea1e3026c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kvm3VLuJqvQTWCz34aokZYwsZ2t0TDjaqo3y0RzW78a31RRqZ9weJV1Xhpj0k1aRvVJKx1k+bb8EP6yyZmjpNfQnR4JVgAUD3nDEoFptmXB3Xg87meC0FNL1d8XDhchpxPBC09OuuQK8GM/mzdKA8x2SHL0FBlUiq1XPFAEjtQUZiZx+1MyX9/+XACgYoWzrvnYM7+u661FmP6HZZehpur+tFvLBV6bVv4JPXpK0ZATnsFuU2tPSdJZVMXYQjgM7g4+pZEAINwjpNs0UpG6QcKTnk9326JBZQ1V0V/PhbEEcddVy8gv1/EGbqm/TpkxljpDbSuVWEhZ1NkLGOtz8kPrchv0AZIkStqH9mU2YM1aB+KJ2R1H6Uc0689aroJSH5VVZ0L/+TPkiQqrlSr4tEhReFJYOiGjJhbum+6koqKda834deIbMgHYgZWkOXEMsRSlM1jd/F9SsEp2sipVeMyC0Ia1/VFzaJK+qXStXmRN8AdoLDDgUDvgpVCfP8K9KQYjnsFfwAHtXRdhfmMePGAOoIGI5lydN7a7sli+KkRLxQknf+cRGvwuPibX5sT1Kyx6EeFRkZ0JY2f23emQNx5phPUmPSmq/GgWqzqfBWAuGKW++5ikYm0UtbkOO+HGCazDzZvaWzFQzj+QzNbKGw7qCfRNNnzPpMyEub6AKFh/HtOofuCbs1fQdSAcXq+B4ZaExz2fu8wuFa3MMt0VFiDe6Er1L4gny+o2JcDs+Sw6fCJ8KQHwQ2zjeVaQNBsfHR8ZtH7JpD89yPEDq3RAjHPU/yAYIh4NhgUNsDVJPfV0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BjxIh19tWH0yoSh323BMQRTtxwnMD/9HJ3D3WhrwANALFGENchLzsh14LS/kgdE7/I9MVLDjcrvGSDyuIz7iT0tINASTGFxXJMrCm+rWF6tb22hGXBPakR2p1LSM9QEk3mB1TXjmoPtsKAdqC/cAAPRKQLobD5GkktIyel5OSMtaDll+d4zGP8Xgha7fmRoNpPYkkG2nLOARrnvv1A9I/H6X4N2eKDTkhUaHF95xf3oNeDBLqZUnClF6UxU5YPf1BYiIbRo6nMf2u+ZE7/SqWSpykYxgd4nG6D17flLZe+T57vAwan8Ozn/dDJ5OZsN177fhvCgQgWngXGmO8FniTT0NTLHCuBtOO0R2i7VGOEYAPSEBMJLlOdnan/Ca6eApfiufv1InHc9yijHsBRu5i2fVyYafGLsk1COJ+eOf3dAAb+xqyWwjCpzHsI8hWhQn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:22:30.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9304b7a-e612-44f8-76c8-08dea1e3026c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
after the hardware exclusion range registers were repurposed.

The first patch renames the associated MMIO offsets to reflect completion-wait
store base/limit.

The second patch drops the workaround that forced IVMD exclusion ranges to
r/w unity mappings; the driver no longer programs exclusion range
registers, so that the workaround is obsolete.

The third patch centralizes IVMD flag definitions, renames the unity-map
structures to ivmd_entry, stores the raw IVMD flags byte from ACPI, and
derives IOMMU reserved regions (including exclusion as IOMMU_RESV_RESERVED)
from those flags.

The fourth patch adds an ivmd= kernel parameter so up to four per-device
IVMD-style ranges can be supplied from the command line when the IVRS
table is wrong or incomplete, documented in kernel-parameters.txt.

Change from v1:
(https://lore.kernel.org/linux-iommu/20260420170033.6780-1-suravee.suthikulpanit@amd.com/)

* Rebase on top of patch "[PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD"
  that was submitted by Yu Zhang <zhangyu1@linux.microsoft.com>.
  (https://lore.kernel.org/all/20260331152550.479841-1-zhangyu1@linux.microsoft.com/)

* Patch 1: Modified to only rename the marco.

* Patch 3: Reintroduce logic to parse IVMD exclusion flag to allow
  reserve region of type IOMMU_RESV_RESERVED.

* Patch 4: 
  - Update the sscan function to scan start, length, flags in hex format only.
  - Fix apply_ivmd_cmdline_entries() to not free the cmd, which points to
    the early_ivmd_cmdline_map[]  on failure path.

Thanks,
Suravee

Suravee Suthikulpanit (4):
  iommu/amd: Drop unused global exclusion range fields and init
  iommu/amd: Do not convert IVMD exclusion range to unity range
  iommu/amd: Clean up and simplify IVMD entry handling
  iommu/amd: Introduce boot option ivmd=seg:bus:dev.fun,start,size,flags

 .../admin-guide/kernel-parameters.txt         |  16 ++
 drivers/iommu/amd/amd_iommu_types.h           |  36 ++--
 drivers/iommu/amd/init.c                      | 159 ++++++++++++++----
 drivers/iommu/amd/iommu.c                     |  27 ++-
 4 files changed, 187 insertions(+), 51 deletions(-)

-- 
2.34.1

