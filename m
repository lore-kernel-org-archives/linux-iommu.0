Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32A2620DE
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840746; cv=fail; b=HKfq6gey/A5Vvnw5UHX0D5RT72rlLfPGx5RGmIXMM4n2Cfic4t0amaKyb4k5ed4FmbHVA1wD6SZSJfYTGkCBvBE43cwwdR43JtpQhcI4B5dzAq1VWOSk5vO2/x7W4MVhNi6eNNC66q8vY6xRCuH3WnAutqiUntx3C1Zg4G++t3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840746; c=relaxed/simple;
	bh=A7ybW2Ak/+a8SQyhmUVSPRZxpz0/A0YBpqnWWv4YuBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UUoYiiyn3ao6hOGj/9Shl7THZZ8QnY4Rsj2xX93UN74p7BpDntx+ep5T0cNDQBBPAOADnyRUTCmDn4RD9vZzDCav8sGZ8wR8wf9zn3qaLLZdXt2FFxzsnD9ND3z6L1963/Ore5uGqbxma6vhe6d1P/bJjz+lQkxrbBrM5tdfAkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1A6oUHTU; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1A6oUHTU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWLEqRhPo9s58/6daAoq3nMm9W8kI0HG77pDLkoikr4nlDE8SuWjSE9NjGOVtFz2JwahPEmg9rQKCBfqz4otRXJtlOlTn0TPOssHkhNOzdl6bM3cLHRHlFR7cObC7KTXFIjUN7EAsdANhBn5F1/cPskbPqZsR4/xGilkrH7eI4pMaYx2UBkTt3eI6nZjHjZxmQmlatsWE7J2i18631RJYTJRt9IswSlEDI/DlqAchdjPlg3cFOfLlrUhfuUlCD/wgu9Ig7ExzOJ+21RwqGUuu4QZ4dmwnv717y8snyiY6f/2+VivQE+ek7kk0AllrN0RKLie7UaFlZFu77wqhB45SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnhDY705I09uNyxg6g3W6au5a2+WEtA0nIWKd+5Md/c=;
 b=PzlvTsDDGlCrJhnhDBjo+IWGZpJjTrl5YIZHseJVIcFupFMc5GHDeIwHAzRLj8AxvUz0Xveuqk94fORq6++lVu+mVGAAHWJoxWfQBsVCnqcY7WrWrVj6RHTOoxMLGIiWezOiN93vs+lBI/T0x0xvEBxTo9RXzW0KTKHPb4nyNDknWTPf1j2pbswoBurH2Yw7rdk0zCxP3oIAGj8mpWEnB83d5YrJRIb8Gw4e6Sv5tU/hxs3bo/iBTnVk52XdujIwjfUs3ge89CcxIPpLWhBH7jkLSKOh/v32mi3tvVrdmuIXlslLUI4ZhTU6ppb8h0FwvmnGwv/67lIZFSqdF+oJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnhDY705I09uNyxg6g3W6au5a2+WEtA0nIWKd+5Md/c=;
 b=1A6oUHTUuGevXdJzUDzhVzjmUCVHZEP0WJ+pkkvdgVHvWNAOCtmKM3FVmSlI3ZuR1MXkdFjAV2AhWCG750G8gAI+P4Q9+eR9olRtdx/niAFCEkYPMPTcB4qXE0DRtDLK0LD0u02k7cQyk7jLUvXRPmHDScwIWoh+yh/gEL4T7v4=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:12:20 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::82) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:12:20 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:12:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
CC: <amd-gfx@lists.freedesktop.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open
 list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, Jatin Kataria
	<jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 0/2] IOMMU Performance Optimization support
Date: Mon, 7 Sep 2026 23:12:05 -0500
Message-ID: <20260908041207.38113-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb5066b-f171-4a01-bb5f-08df0d5f60b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZFzTqy0QLuuH1jyi6Wwpe/Zrl+MCl1vqrQSn02WboRjKXOyxI+llrh92kTCYdekfSGSk7F+AygQ1auonkpkIXxzU1Vyzo+wiusDcnkctF3+CDavjz4YAOr0hRl2BhngjJEzxazK7cCVkBJ7BHs6wRYEuppJHxMJR9JPmqwu1GZuLPP1GCNtXWGUS5MMujMAEKiukbgQ4thZAzCa8uOpPELe4w7H4H31gnTV2u0y4V7fXV+qrxWA6YW7R8F9PoFN8DTnIQDZ9c1YBHTMH4X9xyYk6w0H2ff074Nb8YnbPXyi6SDIOIbJR8TAOLfqPSeQGxv7Nt90E/52Wok3vWaSFonBdi+ZHJ1xJ3tku4stGBfrFyvwZprWyg443FidnY7gDdEcDhJ02BQ6JBBq5Da4aJSN6Lj3SLn2HgZJs3UzHAkQwcMv8gJ+EcRINcXHIWD3phsLSm5fq1zaPR1fqVIqZVrXLDrQtUnlHhAkiyzH8i2+ELzwa6c04tk73okI17UbeQhMxXf86IXPYOjRwnoxtGMPQOQWp3FVv7iSZOb/SUhFJlCpBwjE/ewnlmNXdHtm+IRlaq+vVgsD1AdOxM4UdOAldGizg2URvHI2V6nXxRV5gWxTXPb1aXR4UXPZQb2YU/e31kJCnukQbGfvqu+9otLJcNlNEBlrVDMIXG7XEzO+Rr181dYk3d4AC3uZnCoIgCeaMQ95Nnnn9zOn03ghWnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SMxT4hb6WNBMjK9Vk1Pb5YJRife9lLXqBA6HrCx1XDp2yRWfXhgV5PWEFCycM2IV50XuOrm5jV9OopsqW8kJ+TMLg+q62O0AH2AFzN8weiLn3D88A7aIhXROtEaSyq5jAbOfyBYgdLkbmFCg0XPNTCmAESmbMjeOM8xrffOZ+YN0dX5ug7h8cXi615RNu8LRGjeyDZKnhPdrraXlx5T1oS/e8ECox8HIEM7bUWm+zcLLjn6zClUBOoKALkZ4g2eJkdwTwqq61KgpJT/ome9B539J3IguWQgBTzBjXXSy0ggkGov/wMWxWphJHaBJxQUK4Xbr7S7cY/HrfUCe0qmg1YxrqU3DuOAKppnpkGPDx4vPSfwt5Rk0xWVd/jXCqnRwM4JwnlziE+++dPjGILOQQgsOS4hDBhpE5xK6BT9dC2U0vJo9T7V+kJzHTnYYSEf1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:12:20.4923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb5066b-f171-4a01-bb5f-08df0d5f60b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

Add support for the AMD IOMMU Performance Optimization (PerfOpt)
feature as defined in the AMD I/O Virtualization Technology (IOMMU)
Specification, Section 3.4.9 (MMIO Offset 016Ch).

This feature allows privileged integrated I/O devices (GPUs) to bypass
the IOMMU when directly accessing system memory.  The IOMMU only
enforces the IR/IW permission bits without GPA->SPA translations.

Drivers will opt into this behavior, and enable amdgpu to turn this
feature on when an integrated GPU is already in identity mode.
If a user prefers to keep it always off (even with identity mode)
there is also a module parameter to force it off.

v2:
 * Rebase on 7.3-rc2
 * Adjust amdgpu parameter behavior

Mario Limonciello (2):
  iommu/amd: Add PerfOpt IOMMU performance optimization support
  drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
    identity domain

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
 drivers/iommu/amd/amd_iommu.h              |   3 +
 drivers/iommu/amd/amd_iommu_types.h        |   7 +
 drivers/iommu/amd/init.c                   |  43 +++++
 drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
 include/linux/amd-iommu.h                  |  11 ++
 8 files changed, 341 insertions(+)

-- 
2.43.0

