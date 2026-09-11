Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC5255E43
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115730; cv=fail; b=Bb2iEKIKUpVMT/OzHFPKzoR+9NuDrqwkq4XEUc1YX98NaEypWCZ13drowvANoaztkSVQ3Ey8O3knYRVLT3sNgyISx1OA+oMJkg7J/BOHT66PVb0TxySmnKRHje2ZnyI/Sfnd7c5jizu39YyOOp1+p40OYNk/TldyP88ptv/Fulk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115730; c=relaxed/simple;
	bh=eMIMDw8h66B89A8gsqD0NjP0tKIQjmROYmLHSPnk5ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZxb7DVMgmzVdBhlP/HYsHgTbEEKqvRsAG2A5wxeJeezaSN5BLImOEfDjiT6tmowbJftd27pvpJMJBwo1d5uOQ7cdjR1EXK1/ivpUkS48qoBbbP+NlBzAzW6llPVK0nYio7iNF8H/vAHiyvvdLFCUrjU2CoW7eAYoql4uailFs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qd22RRtU; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qd22RRtU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiqBZ+vn2E3Qmn8pVjY1+7dve4lQxoGfhlcy0OdM2rZqRQv7JbHEPKKsYg+G7iVjikGdP2kG02xd5PTkdQlWREwnVnskFdIHUieQzykggtw51Qm+p1K4n7N60XLLJxx6ZmOgETcJFONUMkTO8l3+qdlP3Nig5JO8jHvavP0AMNpTdJNZVpD9PTmororNju2EQ2wAetX7LIJfJoHUWYrUi4oZSUowoTfwwzUqABUoi12kPa65hQ0AAxJ6bi9NUjFSR18hGYRcXoIP1yrvT9TlzMI5OSXF9ygu/8OBtQCjRGEzPgKc3aQp++I4baMGYJbjz2Kv9JsUKk/Snci+qk99aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7JYT0hPR+LCrVNlWPqLJCdwOWHo3lc94Itoo1Ihoa8=;
 b=MWsL1saHsjXoD0HaegWcmvSLOdPmsJpaFluWGHyDbh7xWUu27nvfk665LMbOLzkDY7NyJuS5HIiRQkRxG9hpuuqWXbVaAvQsd2mNLbwjF6NLO4xGmCVnay7mGU6nT22BaVXF3tXBEq6XtaTtwds0tKrn4IP65y8iyAeKrKSchm2WmE2wmIgth+5WQaFuHZh8BRpTPsn2vAMEv/PrjWetZEHJSWsqsMoArZEIM2KpOmZ9gpqI9j7xgEFTB92J0B9shMlaxxrRCSk0z3e8ZuM+lEG+nokiqhojzvSwoWvW4R2OoS9l7RMFd+87e1LPbhI17G+s/AD2dy/FO4PEm58pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7JYT0hPR+LCrVNlWPqLJCdwOWHo3lc94Itoo1Ihoa8=;
 b=qd22RRtUpELLfeGW5knksTup+qIad2gRRmmtaaOiOY4NJ0uaoE1klix4TuNZaYApAv8qcB/XMqc0DOQBgu85ucbml2qaO9kc+h9c9+NGzk+RvUNRINu+NiF1DdzTuCAoLPIuxEkXNjg1pogIhu5JJibWA3zNq6kjDIsLbLmQAdg=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 08:35:19 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::8e) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:35:18 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:35:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/4] iommu/amd: Remove unused macro
Date: Fri, 11 Sep 2026 08:33:53 +0000
Message-ID: <20260911083353.4812-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911083353.4812-1-vasant.hegde@amd.com>
References: <20260911083353.4812-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dbe4f2-cac4-4835-8c6c-08df0fdf9c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|22082099003|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	44Mg/wzn4rKJpgIoge9j3msvRDx17b7FtJHaas33lB7v/c7+SxYbkZhwxmZkEpzIElsopDsqoQsiGRu6CBQCpWXYl8FFWZB+tVOtOUBxxxASmn6dYTLx5k49UR2wgDI70nm+EWSAORz/RPUOy+bbqt+W1CL0ftWo+MCI0aERHkrN7n7LT06U0wgBYvAdvfWeCaXcFtVGrV58R9KHTTy+03HIt0H96ecy+ZxMU86egWqclI+MOzXJY7XneaAx0HyziMfv6j+ea3BWe/64bW8asy38Oo1vkXCrRVxU8kEzZ+WuUPzdDYM0HPysW1KDE6lZX9okZ0i6QSTHsGS8d9xyPg2ybgIRDfzwOKzMIzyB0Jq2DA/Z5IDL3tiaoL/ozOA9gNYfp5ArImBBRQA8AwzcDQdmV/7E1Z4cPMlb3ayMpJyWP+U84XFL3eljwDVRTuzOkJI25dujhSocX3pwH6WavCw7GRk+Ju4pgggPZYB4xydij1sl5CWsrUn7FlXymbtS/Z1UrsT01iDCzgmqmbeGHuNNI6L0rF0W6UWMhGKiYAZtfsUycinZLkww6sRxTZZIdgOdjoMxu2OmvTpJk7S4uM7epZGKB5W16HKy2AWTpGaiPiUp34MwkhUD0EvYDJ6UlaIgreLOYcLI8rxPV+T/JqQhFIGqt1SndN9av5NCluBQX2639l8qdvQxO03Cq7JQ2qqH4wMJrXxo+z8gs8rnZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5lFviq6FCjSs87nWN3y08AMDY5E2LCwN/8m2u7+O0sBb+NKr2zMhGrfElqTungCYJLzrwkTDoy8jkyiG+H4jMggsRfbMoOgqlH75HJMGnVLC0rg2a/VsgTU9lDYicdH9oCBvz3VzKi6nlCSy2NIgrn1YPZYm7xC3wLA+25oHscvZ0UdhD42MKD4L31OX5qGF6DEj7lmZv3lIx95fBUQq5ZzLXecZKv3gKPrvyN2N3V8zXaN8J7E9nDp2VvbFhKHNG/7BgZoF0GVTtDCfGqaFa1E2c0JgvVyG9cQ8/PW3l/X2f/TkgswsTJpWmP8aOiqg+XUFjmGLTl200Ez1vstOG4Ru9j8uit3wRsi8ZLlYz6lks8+GxNibDxsg9csPXlQ43WT4z/O4PvW4soXh7WK6nJRHsooQYczZaqyuK33xhAEXu16dJz4FmXpwnt2N5gke
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:35:18.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dbe4f2-cac4-4835-8c6c-08df0fdf9c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179

Remove unsed device range capability related macros.

No functional changes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bce5027388b9..8241ef922519 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -39,18 +39,6 @@
 #define MMIO_RANGE_OFFSET	0x0c
 #define MMIO_MISC_OFFSET	0x10
 
-/* Masks, shifts and macros to parse the device range capability */
-#define MMIO_RANGE_LD_MASK	0xff000000
-#define MMIO_RANGE_FD_MASK	0x00ff0000
-#define MMIO_RANGE_BUS_MASK	0x0000ff00
-#define MMIO_RANGE_LD_SHIFT	24
-#define MMIO_RANGE_FD_SHIFT	16
-#define MMIO_RANGE_BUS_SHIFT	8
-#define MMIO_GET_LD(x)  (((x) & MMIO_RANGE_LD_MASK) >> MMIO_RANGE_LD_SHIFT)
-#define MMIO_GET_FD(x)  (((x) & MMIO_RANGE_FD_MASK) >> MMIO_RANGE_FD_SHIFT)
-#define MMIO_GET_BUS(x) (((x) & MMIO_RANGE_BUS_MASK) >> MMIO_RANGE_BUS_SHIFT)
-#define MMIO_MSI_NUM(x)	((x) & 0x1f)
-
 /* Used offsets into the MMIO space */
 #define MMIO_DEV_TABLE_OFFSET   0x0000
 #define MMIO_CMD_BUF_OFFSET     0x0008
@@ -247,7 +235,6 @@
 
 /* constants to configure the command buffer */
 #define CMD_BUFFER_SIZE    8192
-#define CMD_BUFFER_UNINITIALIZED 1
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
-- 
2.31.1

